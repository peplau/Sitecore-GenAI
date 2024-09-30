# Sitecore GenAI Assistant

A **Powershell-only module** for **XM Cloud, XP, and XM**, that leverages **Generative AI** to **create content** (text and imagery), keeping the **quality control** under **human hands**.

Assets can be generated and stored in Content Hub in two ways:

1. **Asynchronously (faster)**: Powershell runs the text generation, while Sitecore Connect executes the image generation processing in parallel
1. **Synchronously (slower)**: Powershell executes both the text and image generation processing

![Sitecore GenAI Assistant](/images/Sitecore-GenAI-Assistant.png)

1. [Prerequisites](#prerequisites)
1. [Installation](#installation)
1. [Configuring the Module](#configuring-the-module)
1. [Usage Instructions](#usage-instructions)
    1. [USE CASE 1 - Editor creating content with AI](#use-case-1---editor-creating-content-with-ai)
    1. [USE CASE 2 - Editor improving content with AI](#use-case-2---editor-improving-content-with-ai)
    1. [USE CASE 3 - Moderator reviewing content in a workflow with AI](#use-case-3---moderator-reviewing-content-in-a-workflow-with-ai) 

## Prerequisites

### Mandatory

- Sitecore **Content Hub** with an **OAuth Client** configured [as described here](https://doc.sitecore.com/ch/en/users/content-hub/create-an-oauth-client.html)
- Sitecore **XP**, **XM** or **XM Cloud** 
- [Sitecore Powershell Extensions](https://doc.sitecorepowershell.com/installation)
- [OpenAI API Key](CreatingAPIKeys.md) - Before using the module, you need to configure the OpenAI API Key. If you need help to get your API Key, follow the steps in the [Creating an OpenAI API Key guide](CreatingAPIKeys.md)

### Optional
- **Sitecore Connect** for Asyncronous image generation. The module works without it, but the Syncronous generation of images makes the experience slower.
- For a better experience with image selection with **Content Hub**, your **XP**, **XM** or **XM Cloud** must have [enabled the DAM connector as described here](https://doc.sitecore.com/xmc/en/developers/xm-cloud/walkthrough--enabling-the-dam-connector-in-an-environment-deployed-to-xm-cloud.html)

## Installation

**Sitecore GenAI Assistant** is a Powershell-only Module that doesn't include any binaries or executables. To start using it, all you have to do is to install the module into your Sitecore instance with a few simple steps.

The module is distributed in two flavors:

### Option 1 - Using the Sitecore Package (.zip)

For a quick installation via Sitecore Package, follow the steps below:

1. Download the latest .zip package from the [Releases](https://github.com/peplau/Sitecore-GenAI/releases) page;
1. Install the package with the Sitecore Installation Wizard (In case of conflicts use the _Merge/Merge_ option).

### Option 2 - With Sitecore CLI Content Serialization (.itempackage)

To use SCS packages (.itempackage) as build artifacts in your continuous integration pipeline, install it in your delivery pipeline:

1. Download the latest .itempackage package from the [Releases](https://github.com/peplau/Sitecore-GenAI/releases) page;
1. Install the package in your delivery pipeline [following this instructions](https://doc.sitecore.com/xp/en/developers/104/developer-tools/create-and-install-a-sitecore-content-serialization-package.html#install-an-scs-package-in-your-delivery-pipeline).

### Post-installation Steps

No matter the option selected, after installing the package, you need to sync the library with the Content Editor to make the module available for use:

1. Open Sitecore PowerShell ISE;

1. Go to Settings Ribbon, Rebuild All button, Sync Library with Content Editor Ribbon;

   ![AI Profiler Chunk in Content Editor](/images/Sync-Library-All.png)

## Configuring the Module

### Mandatory Steps

1. Open **/sitecore/system/Modules/GenAI/Settings/GenAI Settings** item in Content Editor;

1. Populate the fields **API Key** with your [OpenAI API Key](#prerequisites) and select the **Model** you want to use;

   ![OpenAI Settings](/images/GenAI-Settings-Item.png)

1. Setup a new OAuth Client at your Content Hub following [this instructions](https://doc.sitecore.com/ch/en/developers/cloud-dev/authentication-1286040.html#set-up-oauth-in-content-hub)

1. Populate the fields under the **Content Hub Settings** group:

   ![Content Hub Settings](/images/ContentHub-Settings.png)

   1. **BaseURL** - The main Base URL of your Content Hub instance - Eg: https://yourinstance.sitecoresandbox.cloud/
   1. **Username** & **Password** - A valid account with permission to create and approve assets. It is recommended to create a new account for this integration instead of using a real person account.

1. Populate the fields under the **Sitecore Connect Settings** group:

   ![Sitecore Connect Settings](/images/Sitecore-Connect-Settings.png)

   1. **Use Sitecore Connect** - If this field is checked, Sitecore Connect will be used for faster generating images asyncronously. Otherwise, Sitecore Connect is not used and images are generated syncronously, which is slower.

### Optional Steps

#### 1) Using Sitecore Connect for Asyncronous Image Generation

If the field **Use Sitecore Connect** is checked, you also have to follow the steps below:

1. [Download here](https://github.com/peplau/Sitecore-GenAI/dist/connect-recipe_genai-symposium-2024.zip) and install the Sitecore Connect package into your Sitecore Connect instance ([Read this article](https://docs.workato.com/recipe-development-lifecycle/import.html) for details on how to install the package in Sitecore Connect), then follow the steps below:
    1. Configure the **CH Symposium 2024** connection with the Content Hub OAuth information
    1. Configure the **OpenAI Symposium** connection with your OpenAI API Key
    1. Start the formulas **Generate Image with AI** and **Build GraphQL Query to Save Image Field**
1. Populate the fields under the **Sitecore Connect Settings** group:

    1. **Generate Image Endpoint** - Your Sitecore Connect endpoint to the Generate Image Webhook (Eg: https://webhooks.workato.com/webhooks/rest/{yourID}/generateimage)
    1. **GraphQL Base URL** - The Base URL of your GraphQL Endpoint (normally the CM - Eg: https://yourcms.sitecorecloud.io/)
    1. **GraphQL Client ID** and **GraphQL Client Secret** as [described here](https://doc.sitecore.com/xmc/en/developers/xm-cloud/walkthrough--enabling-and-authorizing-requests-to-the-authoring-and-management-api.html#obtain-an-additional-access-token-optional)

#### 2) Using AI to help with Content Review

The module comes with a sample workflow called **Sample GenAI Content Workflow**. When using this workflow, the content profiling is triggered at the **Ask AI for Changes** action, after the command **"Reject with AI"** is executed (normally by the content moderator).

![Sample GenAI Content Workflow](/images/Demo-Workflow.png)

> [!TIP]
> You can easily integrate the **Ask AI for Changes** action in your custom workflows. To do so, copy the action to your workflow, or follow the steps below:
> 1. Create a new action item under your workflow command using the template **/sitecore/templates/Modules/PowerShell Console/PowerShell Script Workflow Action**
> 1. Point the **Script** field to **/sitecore/system/Modules/PowerShell/Script Library/GenAI/Content Generation/Content Editor/Context Menu/GenAI/Update Content with AI**

## Usage Instructions

After the module is installed and configured, you will see the following scripts under the context menu in Content Editor:

![GenAI folder in Content Editor](/images/Context-Menu.png)

### USE CASE 1 - Editor creating content with AI

The video below shows a demo of content being created with help of AI by a content editor

![](https://github.com/peplau/Sitecore-GenAI/blob/main/images/videos/Editor-Create-Content.gif)

The following steps are shown in the video:

1. Using Content Editor, the content author right clicks the item where the new item is going to be created, then **Scripts > GenAI > Generate Content with AI**;

1. The content author selects the template to be used in the new item creation (Eg: Page);

1. At the **Content** tab, the content author fills the fields:
    1. **Force Item Name** (optional) - If the field is left empty, the item name will also be generated with AI;
    1. **What do you want the content to speak about?**
    1. **Keywords (comma-separated)**
    1. **Select the length** - Content length to be generated (Headline, Medium or Long)
    1. **Choose a tone for your text**

1. At the **Template** tab, the author selects the fields to populate with generated content (Text and Image fields are allowed)

After the content is generated, the video shows all text fields populated, but not the image field, which is still being populated asyncronously by Sitecore Connect. After some time, the page is refreshed and the generated image will show up.

<hr />

### USE CASE 2 - Editor improving content with AI

The video below shows a demo of content being improved with help of AI by a content editor

![](https://github.com/peplau/Sitecore-GenAI/blob/main/images/videos/Editor-Improving-Content.gif)

The following steps are shown in the video:

1. Using Content Editor, the content author right clicks the item to be improved, then **Scripts > GenAI > Update Content with AI**;

1. At the **Content** tab, the content author fills the fields:
    1. **What do you want to change in this content?**
    1. **Select the length** - Content length to be generated (Headline, Medium or Long)
    1. **Choose a tone for your text**

1. At the **Template** tab, the author selects the fields to populate with generated content (Text and Image fields are allowed)

<hr />

### USE CASE 3 - Moderator reviewing content in a workflow with AI

The video below shows a demo of content being submitted for review by the content editor, and further being reviewed by a content moderator with help of AI

![](https://github.com/peplau/Sitecore-GenAI/blob/main/images/videos/Reviewing-Content.gif)

The following steps are shown in the video:

1. Content author submits the generated content for revision under the **Sample GenAI Content Workflow**

1. Moderator opens the **Workbox** and reviews the content under **Awaiting Approval**

1. He didn't like the generated content, so he clicks on **Reject with AI**

1. At the **Content** tab, the moderator fills the fields:
    1. **What do you want to change in this content?**
    1. **Select the length** - Content length to be generated (Headline, Medium or Long)
    1. **Choose a tone for your text**

1. At the **Template** tab, the moderator selects the fields to populate. He selects the **Content** field only.

1. The content is generated and immediatelly available for the moderator to check again. This time he likes the results, so he clicks on **Approve and Publish**.