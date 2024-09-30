# Sitecore GenAI Assistant

A **Powershell-only module** for **XM Cloud, XP, and XM**, that leverages **Generative AI** to **create content** (text and imagery), keeping the **quality control** under **human hands**.

Assets are managed in Content Hub:

1. **Asynchronously (faster)**: Powershell runs the text generation, while Sitecore Connect executes the image generation processing in parallel
1. **Synchronously (slower)**: Powershell executes both the text and image generation processing

![Sitecore GenAI Assistant](/images/Sitecore-GenAI-Assistant.png)

## Prerequisites

- [Sitecore XP](https://developers.sitecore.com/downloads/Sitecore_Experience_Platform)
- [Sitecore Powershell Extensions](https://doc.sitecorepowershell.com/installation)
- [OpenAI API Key](CreatingAPIKeys.md) - Before using the module, you need to configure the OpenAI API Key. If you need help to get your API Key, follow the steps in the [Creating an OpenAI API Key guide](CreatingAPIKeys.md)

## Installation

**Sitecore GenAI Assistant** is a Powershell-only Module that doesn't include any binaries or executables. To start using it, all you have to do is to install the module into your Sitecore instance with a few simple steps.
