# Sitecore GenAI Assistant

A **Powershell-only module** for **XM Cloud, XP, and XM**, that leverages **Generative AI** to **create content** (text and imagery), keeping the **quality control** under **human hands**.

Assets can be generated and stored in Content Hub in two ways:

1. **Asynchronously (faster)**: Powershell runs the text generation, while Sitecore Connect executes the image generation processing in parallel
1. **Synchronously (slower)**: Powershell executes both the text and image generation processing

![Sitecore GenAI Assistant](/images/Sitecore-GenAI-Assistant.png)

## Prerequisites

- Sitecore Content Hub with an OAuth Client [as described here](https://doc.sitecore.com/ch/en/users/content-hub/create-an-oauth-client.html)
- Sitecore XP, XM or XM Cloud [with DAM connector enabled](https://doc.sitecore.com/xmc/en/developers/xm-cloud/walkthrough--enabling-the-dam-connector-in-an-environment-deployed-to-xm-cloud.html)
- [Sitecore Powershell Extensions](https://doc.sitecorepowershell.com/installation)
- [OpenAI API Key](CreatingAPIKeys.md) - Before using the module, you need to configure the OpenAI API Key. If you need help to get your API Key, follow the steps in the [Creating an OpenAI API Key guide](CreatingAPIKeys.md)

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

1. Optionally, if the field **Use Sitecore Connect** is checked, follow the steps below:

   1. [Download here](https://github.com/peplau/Sitecore-GenAI/dist/connect-recipe_genai-symposium-2024.zip) and install the Sitecore Connect package into your Sitecore Connect instance ([Read this article](https://docs.workato.com/recipe-development-lifecycle/import.html) for details on how to install the package in Sitecore Connect), then follow the steps below:
      1. Configure the **CH Symposium 2024** connection with the Content Hub OAuth information
      1. Configure the **OpenAI Symposium** connection with your OpenAI API Key
      1. Start the formulas **Generate Image with AI** and **Build GraphQL Query to Save Image Field**
   1. Populate the fields under the **Sitecore Connect Settings** group:

      1. **Generate Image Endpoint** - Your Sitecore Connect endpoint to the Generate Image Webhook (Eg: https://webhooks.workato.com/webhooks/rest/{yourID}/generateimage)
      1. **GraphQL Base URL** - The Base URL of your GraphQL Endpoint (normally the CM - Eg: https://yourcms.sitecorecloud.io/)
      1. **GraphQL Client ID** and **GraphQL Client Secret** as [described here](https://doc.sitecore.com/xmc/en/developers/xm-cloud/walkthrough--enabling-and-authorizing-requests-to-the-authoring-and-management-api.html#obtain-an-additional-access-token-optional)

## Usage Instructions

After the module is installed and configured, you will see the following scripts under the context menu in Content Editor:

![GenAI folder in Content Editor](/images/Context-Menu.png)

### USE CASE 1 - Editor creating content with AI

<hr/>

![GenAI folder in Content Editor](/images/videos/Editor-Create-Content.gif)

<hr/>
