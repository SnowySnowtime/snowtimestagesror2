using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Permissions;
using BepInEx;
using RoR2.ContentManagement;
using UnityEngine;
using RoR2;
using System.Linq;
using System.Security;
using BepInEx.Configuration;
using BepInEx.Bootstrap;
using System.Runtime.CompilerServices;
using UnityEngine.AddressableAssets;
using R2API;

#pragma warning disable CS0618 // Type or member is obsolete
[assembly: SecurityPermission(SecurityAction.RequestMinimum, SkipVerification = true)]
#pragma warning restore CS0618 // Type or member is obsolete
[assembly: HG.Reflection.SearchableAttribute.OptIn]

namespace Snowtime
{
    // Dependencies and BepInPlugin initialization
    [BepInDependency(R2API.R2API.PluginGUID)]
    [BepInDependency(SoundAPI.PluginGUID)]
    [BepInPlugin(GUID, Name, Version)]
    public class SnowtimeStage : BaseUnityPlugin
    {
        public const string Author = "SnowySnowtime";
        public const string Name = nameof(SnowtimeStage);
        public const string Version = "0.6.0";
        public const string GUID = Author + "." + Name;

        public static SnowtimeStage instance;   
        private void Awake()
        {
            instance = this;

            Log.Init(Logger);

            RegisterHooks();

            ContentManager.collectContentPackProviders += GiveToRoR2OurContentPackProviders;
            Language.collectLanguageRootFolders += CollectLanguageRootFolders;
        }

        private void RegisterHooks()
        {
            On.RoR2.MusicController.StartIntroMusic += MusicController_StartIntroMusic;
        }

        private void MusicController_StartIntroMusic(On.RoR2.MusicController.orig_StartIntroMusic orig, MusicController self)
        {
            orig(self);
            AkSoundEngine.PostEvent("Play_Music_SystemST", self.gameObject);
        }

        private void Destroy()
        {
            Language.collectLanguageRootFolders -= CollectLanguageRootFolders;
        }
        private void GiveToRoR2OurContentPackProviders(ContentManager.AddContentPackProviderDelegate addContentPackProvider)
        {
            addContentPackProvider(new Content.ContentProvider());
        }
        public void CollectLanguageRootFolders(List<string> folders)
        {
            folders.Add(System.IO.Path.Combine(System.IO.Path.GetDirectoryName(base.Info.Location), "Language"));
        }
    }
}
