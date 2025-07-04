using BepInEx.Bootstrap;
using BepInEx.Configuration;
using BepInEx;
using RoR2.ContentManagement;
using RoR2;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Security.Permissions;
using System.Security;
using System;
using UnityEngine.AddressableAssets;
using UnityEngine;

#pragma warning disable CS0618 // Type or member is obsolete
[assembly: SecurityPermission(SecurityAction.RequestMinimum, SkipVerification = true)]
#pragma warning restore CS0618 // Type or member is obsolete
[assembly: HG.Reflection.SearchableAttribute.OptIn]

namespace Snowtime
{
    // Dependencies and BepInPlugin initialization
	[BepInPlugin(GUID, Name, Version)]
    [BepInDependency(R2API.DirectorAPI.PluginGUID)]
    [BepInDependency(R2API.SoundAPI.PluginGUID)]
    [BepInDependency("JaceDaDorito.LocationsOfPrecipitation")]
    [BepInDependency("com.TeamMoonstorm.MoonstormSharedUtils", BepInDependency.DependencyFlags.SoftDependency)]
    public class SnowtimeStage : BaseUnityPlugin
    {
        public const string Author = "SnowySnowtime";
        public const string Name = nameof(SnowtimeStage);
        public const string Version = "0.8.5";
        public const string GUID = Author + "." + Name;
		public static ConfigEntry<bool> ToggleBloodGulch { get; set; }
		public static ConfigEntry<bool> ToggleSidewinder { get; set; }
		public static ConfigEntry<bool> ToggleDeathIsland { get; set; }
		public static ConfigEntry<bool> ToggleIceFields { get; set; }
		public static ConfigEntry<bool> ToggleGephyrophobia { get; set; }
		public static ConfigEntry<bool> ToggleSandtrap { get; set; }
		public static ConfigEntry<bool> ToggleHalo { get; set; }
		public static ConfigEntry<bool> ToggleHalo2 { get; set; }
		public static ConfigEntry<bool> ToggleNMB { get; set; }
		public static ConfigEntry<bool> ToggleGMC { get; set; }
		public static ConfigEntry<bool> ToggleDHalo { get; set; }

        public static SnowtimeStage instance;   
        public void Awake()
        {
            instance = this;

            Log.Init(Logger);
			
			ToggleBloodGulch = Config.Bind("Stage 1 Toggles", "Blood Gulch", true, "If true, Blood Gulch is added to the loop, otherwise it shall not appear");
			ToggleSidewinder = Config.Bind("Stage 1 Toggles", "Sidewinder", true, "If true, Sidewinder is added to the loop, otherwise it shall not appear");
			ToggleGMC = Config.Bind("Stage 1 Toggles", "gm_construct", true, "If true, gm_construct is added to the loop, otherwise it shall not appear");
			ToggleDeathIsland = Config.Bind("Stage 2 Toggles", "Death Island", true, "If true, Death Island is added to the loop, otherwise it shall not appear");
			ToggleIceFields = Config.Bind("Stage 2 Toggles", "Ice Fields", true, "If true, Ice Fields is added to the loop, otherwise it shall not appear");
			ToggleDHalo = Config.Bind("Stage 2 Toggles", "Delta Halo", true, "If true, Delta Halo is added to the loop, otherwise it shall not appear");
			ToggleGephyrophobia = Config.Bind("Stage 3 Toggles", "Gephyrophobia", true, "If true, Gephyrophobia is added to the loop, otherwise it shall not appear");
			ToggleSandtrap = Config.Bind("Stage 4 Toggles", "Sandtrap", true, "If true, Sandtrap is added to the loop, otherwise it shall not appear");
			ToggleHalo = Config.Bind("Stage 5 Toggles", "Halo", true, "If true, Halo is added to the loop, otherwise it shall not appear");
			ToggleHalo2 = Config.Bind("Stage 5 Toggles", "Halo(Alt)", true, "If true, Halo(Alt) is added to the loop, otherwise it shall not appear");
			ToggleNMB = Config.Bind("Post Loop Stage Toggles", "New Mombasa Bridge", true, "If true, New Mombasa Bridge is added to the loop, otherwise it shall not appear");

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
