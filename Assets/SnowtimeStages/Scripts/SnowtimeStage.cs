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
using R2API;
using Snowtime.Content;

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
        public const string Version = "0.9.5";
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
		public static ConfigEntry<bool> ToggleFLAT { get; set; }
		public static ConfigEntry<bool> ToggleHC { get; set; }
		public static ConfigEntry<bool> ToggleBig { get; set; }
		public static ConfigEntry<bool> ToggleHightower { get; set; }

        public static SnowtimeStage instance;

        public static DifficultyDef SnowtimeLegendaryDiffDef;
        public static DifficultyIndex SnowtimeLegendaryDiffIndex;
        public static bool Legendary = false;
        private int defMonsterCap;

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
			ToggleNMB = Config.Bind("Stage 3 Toggles", "New Mombasa Bridge", true, "If true, New Mombasa Bridge is added to the loop, otherwise it shall not appear");
			ToggleFLAT = Config.Bind("Stage 5 Toggles", "gm_flatgrass", true, "If true, gm_flatgrass is added to the loop, otherwise it shall not appear");
			ToggleHC = Config.Bind("Stage 4 Toggles", "High Charity", true, "If true, High Charity is added to the loop, otherwise it shall not appear");
			ToggleBig = Config.Bind("Stage 4 (Bazaar Only) Toggles", "gm_bigcity", true, "If true, gm_bigcity is hidden in the bazaar, otherwise it shall not appear");
			ToggleHightower = Config.Bind("Stage 2 Toggles", "plr_hightower", true, "If true, plr_hightower is added to the loop, otherwise it shall not appear");

            RegisterHooks();
            AddDifficulty();

            ContentManager.collectContentPackProviders += GiveToRoR2OurContentPackProviders;
            Language.collectLanguageRootFolders += CollectLanguageRootFolders;

            Run.onRunStartGlobal += (Run run) =>
            {
                Legendary = false;
                if (run.selectedDifficulty == SnowtimeLegendaryDiffIndex)
                {
                    Legendary = true;
                    CharacterMaster.onStartGlobal += CharacterMaster_OnStartGlobal;
                    //OnLegendaryStart(run);
                }
            };

            Run.onRunDestroyGlobal += (Run run) =>
            {
                Legendary = false;
                CharacterMaster.onStartGlobal -= CharacterMaster_OnStartGlobal;
               // OnLegendaryEnd(run);
            };
        }

        private void CharacterMaster_OnStartGlobal(CharacterMaster obj)
        {
            if (obj.teamIndex != TeamIndex.Player)
            {
                if (obj.inventory) obj.inventory.GiveItem(RoR2Content.Items.AlienHead, 1);
                if (obj.inventory) obj.inventory.GiveItem(RoR2Content.Items.BoostAttackSpeed, 3);
                if (obj.inventory) obj.inventory.GiveItem(RoR2Content.Items.BoostHp, 4);
                if (obj.inventory) obj.inventory.GiveItem(RoR2Content.Items.PersonalShield, 5);
                if (obj.inventory) obj.inventory.GiveItem(RoR2Content.Items.BoostDamage, 10);
                if (obj.inventory) obj.inventory.GiveItem(RoR2Content.Items.Knurl, 1);
            }
        }

        private void OnLegendaryStart(Run run)
        {
            On.RoR2.CombatDirector.Awake += CombatDirector_Awake;
        }
        private void OnLegendaryEnd(Run run)
        {
            On.RoR2.CombatDirector.Awake -= CombatDirector_Awake;
        }

        private void CombatDirector_Awake(On.RoR2.CombatDirector.orig_Awake orig, CombatDirector self)
        {
            TeamCatalog.GetTeamDef(TeamIndex.Monster).softCharacterLimit *= 2;
            TeamCatalog.GetTeamDef(TeamIndex.Void).softCharacterLimit *= 2;
            TeamCatalog.GetTeamDef(TeamIndex.Lunar).softCharacterLimit *= 2;
            orig(self);
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

        public void AddDifficulty()
        {
            SnowtimeLegendaryDiffDef = new(3.5f, "SNOWTIME_LEGENDARY_NAME", "SNOWTIME_LEGENDARY_ICON", "SNOWTIME_LEGENDARY_DESC", new Color32(100, 170, 255, 255), "stLeg", false);
            SnowtimeLegendaryDiffDef.foundIconSprite = true;
            SnowtimeLegendaryDiffIndex = DifficultyAPI.AddDifficulty(SnowtimeLegendaryDiffDef);
        }

        public void CollectLanguageRootFolders(List<string> folders)
        {
            folders.Add(System.IO.Path.Combine(System.IO.Path.GetDirectoryName(base.Info.Location), "Language"));
        }
    }
}
