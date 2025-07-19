using BepInEx.Configuration;
using EntityStates;
using R2API;
using RoR2.ContentManagement;
using RoR2.ExpansionManagement;
using RoR2.Networking;
using RoR2.Skills;
using RoR2;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Reflection;
using System.IO;
using System;
using UnityEngine.AddressableAssets;
using UnityEngine.Networking;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine;
using ShaderSwapper;
using R2API.ScriptableObjects;

namespace Snowtime.Content
{
    public static class SnowtimeContent
    {
        internal const string ScenesAssetBundleFileName = "snowtimestages";
        internal const string AssetsAssetBundleFileName = "snowtimeassets";

        internal const string MusicSoundBankFileName = "SnowtimeStagesMusic.bnk";
        internal const string SndSoundBankFileName = "SnowtimeStagesSounds.bnk";
        internal const string InitSoundBankFileName = "SnowtimeStagesInit.bnk";


        public static AssetBundle _stscenesAssetBundle;
        public static AssetBundle _stassetsAssetBundle;

        internal static UnlockableDef[] UnlockableDefs;
        internal static SceneDef[] SceneDefs;
        internal static ExpansionDef[] expansionDefs;
        internal static GameObject[] gameObjects;
        internal static EntityStateConfiguration[] EntityStateConfigurations;

        internal static GameObject CovenantCruiser;
        internal static GameObject CovenantCruiserLunar;
        internal static GameObject PurchaseLockCovenant;
        internal static GameObject PlatChest;
        internal static GameObject GoldChest_Scaling;

        internal static GameObject LemurianErrorBody;
        internal static GameObject LemurianErrorMaster;
        internal static EntityStateConfiguration LemurianErrorEsc;
        internal static GameObject MissingBall;
        internal static GameObject MissingHit;
        internal static GameObject MissingFlash;
        internal static GameObject MissingExplFX;
        internal static GameObject MissingGhost;
        internal static InteractableSpawnCard PlatinumChestCard;

        // Halo Content
        internal static ExpansionDef ExpansionDefSTHalo;
        internal static ExpansionDef ExpansionDefSTSource;

        // STSceneDef = Death Island
        // STBGSceneDef = Blood Gulch
        // STGPHSceneDef = Gephyrophobia
        // STHSceneDef = Halo
        // STH2SceneDef = Halo
        // STIFSceneDef = Ice Fields
        // STShrineSceneDef = Sandtrap
        // STSWSceneDef = Sidewinder
        // STNMBSceneDef = NewMombasaBridge
        // STGMCSceneDef = gm_construct
        // STDHSceneDef = Delta Halo
        // STFlatSceneDef = gm_flatgrass
        // STHCSceneDef = High Charity
        // STCitySceneDef = gm_bigcity
        internal static SceneDef STSceneDef;
        internal static SceneDef STIFSceneDef;
        internal static SceneDef STBGSceneDef;
        internal static SceneDef STGPHSceneDef;
        internal static SceneDef STHSceneDef;
        internal static SceneDef STH2SceneDef;
        internal static SceneDef STShrineSceneDef;
        internal static SceneDef STSWSceneDef;
        internal static SceneDef STNMBSceneDef;
        internal static SceneDef STGMCSceneDef;
        internal static SceneDef STDHSceneDef;
        internal static SceneDef STFlatSceneDef;
        internal static SceneDef STHCSceneDef;
        internal static SceneDef STCitySceneDef;
        internal static Sprite STSceneDefPreviewSprite;
        internal static Sprite STIFSceneDefPreviewSprite;
        internal static Sprite STBGSceneDefPreviewSprite;
        internal static Sprite STGPHSceneDefPreviewSprite;
        internal static Sprite STHSceneDefPreviewSprite;
        internal static Sprite STH2SceneDefPreviewSprite;
        internal static Sprite STShrineSceneDefPreviewSprite;
        internal static Sprite STSWSceneDefPreviewSprite;
        internal static Sprite STNMBSceneDefPreviewSprite;
        internal static Sprite STGMCSceneDefPreviewSprite;
        internal static Sprite STDHSceneDefPreviewSprite;
        internal static Sprite STFlatSceneDefPreviewSprite;
        internal static Sprite STHCSceneDefPreviewSprite;
        internal static Sprite STCitySceneDefPreviewSprite;
        public static Sprite SnowtimeLegendaryIcon;
        internal static Material STBazaarSeer;
        internal static Material STIFBazaarSeer;
        internal static Material STBGBazaarSeer;
        internal static Material STGPHBazaarSeer;
        internal static Material STHBazaarSeer;
        internal static Material STH2BazaarSeer;
        internal static Material STShrineBazaarSeer;
        internal static Material STSWBazaarSeer;
        internal static Material STNMBBazaarSeer;
        internal static Material STGMCBazaarSeer;
        internal static Material STDHBazaarSeer;
        internal static Material STFlatBazaarSeer;
        internal static Material STHCBazaarSeer;
        internal static Material STCityBazaarSeer;
		
		public static List<Material> SwappedMaterials = new List<Material>();

        public static List<GameObject> stbodyList = new List<GameObject>();
        public static List<GameObject> stmasterList = new List<GameObject>();
        public static List<EffectDef> steffectList = new List<EffectDef>();
        public static List<GameObject> stprojectileList = new List<GameObject>();
        public static List<GameObject> stnwobjList = new List<GameObject>();
        public static List<GameObject> stghostList = new List<GameObject>();
        public static List<SceneDef> stSceneDefList = new List<SceneDef>();
        public static List<EntityStateConfiguration> stentStateConfig = new List<EntityStateConfiguration>();

        internal static IEnumerator LoadAssetBundlesAsync(AssetBundle scenesAssetBundle, AssetBundle assetsAssetBundle, IProgress<float> progress, ContentPack contentPack)
        {
            _stscenesAssetBundle = scenesAssetBundle;
            _stassetsAssetBundle = assetsAssetBundle;

            Log.Debug($"Snowtime Stages found. Loading asset bundles...");

            var upgradeStubbedShaders = _stassetsAssetBundle.UpgradeStubbedShadersAsync();
            while (upgradeStubbedShaders.MoveNext())
            {
                yield return upgradeStubbedShaders.Current;
            }

            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<UnlockableDef[]>)((assets) =>
            {
                UnlockableDefs = assets;
                contentPack.unlockableDefs.Add(assets);
            }));

            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<GameObject[]>)((assets) =>
            {
                // Define the custom objects
                CovenantCruiser = assets.First(a => a.name == "CovenantCruiserTeleporter");
                PurchaseLockCovenant = assets.First(a => a.name == "PurchaseLockCovenant");
                CovenantCruiserLunar = assets.First(a => a.name == "CovenantCruiserTeleporterLunar");
                PlatChest = assets.First(a => a.name == "PlatChest");
                GoldChest_Scaling = assets.First(a => a.name == "GoldChest_Scaling");
                LemurianErrorBody = assets.First(a => a.name == "LemurianErrorBody");
                LemurianErrorMaster = assets.First(a => a.name == "LemurianErrorMaster");
                MissingBall = assets.First(a => a.name == "MissingBall");
                MissingFlash = assets.First(a => a.name == "MissingFlash");
                MissingExplFX = assets.First(a => a.name == "OmniExplosionVFXQuickMissing");
                MissingHit = assets.First(a => a.name == "MissingHit");
                MissingGhost = assets.First(a => a.name == "MissingGhost");
                // define what list they go to
                stnwobjList.Add(CovenantCruiser);
                stnwobjList.Add(PurchaseLockCovenant);
                stnwobjList.Add(CovenantCruiserLunar);
                stnwobjList.Add(PlatChest);
                stnwobjList.Add(GoldChest_Scaling);
                stbodyList.Add(LemurianErrorBody);
                stmasterList.Add(LemurianErrorMaster);
                stprojectileList.Add(MissingBall);
                steffectList.Add(new EffectDef(MissingFlash));
                steffectList.Add(new EffectDef(MissingExplFX));
                steffectList.Add(new EffectDef(MissingHit));
                // add them to the array
                contentPack.networkedObjectPrefabs.Add(stnwobjList.ToArray());
                contentPack.bodyPrefabs.Add(stbodyList.ToArray());
                contentPack.masterPrefabs.Add(stmasterList.ToArray());
                contentPack.projectilePrefabs.Add(stprojectileList.ToArray());
                contentPack.effectDefs.Add(steffectList.ToArray());
                contentPack.entityStateTypes.Add(typeof(SnowtimeStage).Assembly.GetTypes().Where(type => typeof(EntityStates.EntityState).IsAssignableFrom(type)).ToArray());
            }));

            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<EntityStateConfiguration[]>)((assets) =>
            {
                // Define the custom objects
                LemurianErrorEsc = assets.First(a => a.name == "escFireMissingProjectile");
                // define what list they go to
                stentStateConfig.Add(LemurianErrorEsc);
                // add them to the array
                contentPack.entityStateConfigurations.Add(stentStateConfig.ToArray());
            }));

            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<ExpansionDef[]>)((assets) =>
            {
                ExpansionDefSTHalo = assets.First(a => a.name == "snowtimestageshalo_expdef");
                ExpansionDefSTSource = assets.First(a => a.name == "snowtimestagessource_expdef");
                Log.Debug("SnowtimeStages:Halo Expansion Definition Added");
                Log.Debug("SnowtimeStages:Source Expansion Definition Added");
                contentPack.expansionDefs.Add(assets);
            }));


            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<Sprite[]>)((assets) =>
            {
                STSceneDefPreviewSprite = assets.First(a => a.name == "texSTScenePreview");
                STIFSceneDefPreviewSprite = assets.First(a => a.name == "texSTIFScenePreview");
                STBGSceneDefPreviewSprite = assets.First(a => a.name == "texSTBGScenePreview");
                STGPHSceneDefPreviewSprite = assets.First(a => a.name == "texSTGPHScenePreview");
                STHSceneDefPreviewSprite = assets.First(a => a.name == "texSTHaloScenePreview");
                STH2SceneDefPreviewSprite = assets.First(a => a.name == "texSTHaloScenePreview");
                STShrineSceneDefPreviewSprite = assets.First(a => a.name == "texSTShrineScenePreview");
                STSWSceneDefPreviewSprite = assets.First(a => a.name == "texSTSWScenePreview");
                STNMBSceneDefPreviewSprite = assets.First(a => a.name == "texSTNMBScenePreview");
                STGMCSceneDefPreviewSprite = assets.First(a => a.name == "texSTGMCScenePreview");
                STDHSceneDefPreviewSprite = assets.First(a => a.name == "texSTDHaloScenePreview");
                STFlatSceneDefPreviewSprite = assets.First(a => a.name == "texSTFlatScenePreview");
                STHCSceneDefPreviewSprite = assets.First(a => a.name == "texSTHCScenePreview");
                STCitySceneDefPreviewSprite = assets.First(a => a.name == "texSTCityScenePreview");
                SnowtimeLegendaryIcon = assets.First(a => a.name == "texSnowtimeLegendaryPLNK");
            }));

            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<SceneDef[]>)((assets) =>
            {
                Log.Debug("Adding enabled SceneDefs for SnowtimeStages");
                if (SnowtimeStage.ToggleBloodGulch.Value == true)
                {
                    STBGSceneDef = assets.First(sd => sd.cachedName == "snowtime_bloodgulch");
                    stSceneDefList.Add(STBGSceneDef);
                    Log.Debug("Added Blood Gulch SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleBloodGulch.Value == false)
                {
                    Log.Debug("Skipped Blood Gulch SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleSidewinder.Value == true)
                {
                    STSWSceneDef = assets.First(sd => sd.cachedName == "snowtime_sidewinder");
                    stSceneDefList.Add(STSWSceneDef);
                    Log.Debug("Added Sidewinder SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleSidewinder.Value == false)
                {
                    Log.Debug("Skipped Sidewinder SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleDeathIsland.Value == true)
                {
                    STSceneDef = assets.First(sd => sd.cachedName == "snowtime_deathisland");
                    stSceneDefList.Add(STSceneDef);
                    Log.Debug("Added Death Island SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleDeathIsland.Value == false)
                {
                    Log.Debug("Skipped Death Island SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleIceFields.Value == true)
                {
                    STIFSceneDef = assets.First(sd => sd.cachedName == "snowtime_icefields");
                    stSceneDefList.Add(STIFSceneDef);
                    Log.Debug("Added Ice Fields SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleIceFields.Value == false)
                {
                    Log.Debug("Skipped Ice Fields SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleGephyrophobia.Value == true)
                {
                    STGPHSceneDef = assets.First(sd => sd.cachedName == "snowtime_gephyrophobia");
                    stSceneDefList.Add(STGPHSceneDef);
                    Log.Debug("Added Gephyrophobia SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleGephyrophobia.Value == false)
                {
                    Log.Debug("Skipped Gephyrophobia SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleSandtrap.Value == true)
                {
                    STShrineSceneDef = assets.First(sd => sd.cachedName == "snowtime_sandtrap");
                    stSceneDefList.Add(STShrineSceneDef);
                    Log.Debug("Added Sandtrap SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleSandtrap.Value == false)
                {
                    Log.Debug("Skipped Sandtrap SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleHalo.Value == true)
                {
                    STHSceneDef = assets.First(sd => sd.cachedName == "snowtime_halo");
                    stSceneDefList.Add(STHSceneDef);
                    Log.Debug("Added Halo SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleHalo.Value == false)
                {
                    Log.Debug("Skipped Halo SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleHalo2.Value == true)
                {
                    STH2SceneDef = assets.First(sd => sd.cachedName == "snowtime_halo2");
                    stSceneDefList.Add(STH2SceneDef);
                    Log.Debug("Added Halo(Alt) SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleHalo2.Value == false)
                {
                    Log.Debug("Skipped Halo(Alt) SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleNMB.Value == true)
                {
                    STNMBSceneDef = assets.First(sd => sd.cachedName == "snowtime_newmombasabridge");
                    stSceneDefList.Add(STNMBSceneDef);
                    Log.Debug("Added New Mombasa Bridge SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleNMB.Value == false)
                {
                    Log.Debug("Skipped New Mombasa Bridge SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleGMC.Value == true)
                {
                    STGMCSceneDef = assets.First(sd => sd.cachedName == "snowtime_gmconstruct");
                    stSceneDefList.Add(STGMCSceneDef);
                    Log.Debug("Added gm_construct SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleGMC.Value == false)
                {
                    Log.Debug("Skipped gm_construct SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleDHalo.Value == true)
                {
                    STDHSceneDef = assets.First(sd => sd.cachedName == "snowtime_deltahalo");
                    stSceneDefList.Add(STDHSceneDef);
                    Log.Debug("Added Delta Halo SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleDHalo.Value == false)
                {
                    Log.Debug("Skipped Delta Halo SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleFLAT.Value == true)
                {
                    STFlatSceneDef = assets.First(sd => sd.cachedName == "snowtime_gmflatgrass");
                    stSceneDefList.Add(STFlatSceneDef);
                    Log.Debug("Added gm_flatgrass SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleFLAT.Value == false)
                {
                    Log.Debug("Skipped gm_flatgrass SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleHC.Value == true)
                {
                    STHCSceneDef = assets.First(sd => sd.cachedName == "snowtime_highcharity");
                    stSceneDefList.Add(STHCSceneDef);
                    Log.Debug("Added High Charity SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleHC.Value == false)
                {
                    Log.Debug("Skipped High Charity SceneDef (Config Off)");
                }
                if (SnowtimeStage.ToggleBig.Value == true)
                {
                    STCitySceneDef = assets.First(sd => sd.cachedName == "snowtime_gmbigcity");
                    stSceneDefList.Add(STCitySceneDef);
                    Log.Debug("Added gm_bigcity SceneDef (Config On)");
                }
                if (SnowtimeStage.ToggleBig.Value == false)
                {
                    Log.Debug("Skipped gm_bigcity SceneDef (Config Off)");
                }

                contentPack.sceneDefs.Add(stSceneDefList.ToArray());
                Log.Debug("Finished adding enabled SceneDefs for SnowtimeStages");
            }));

            yield return LoadAllAssetsAsync(_stassetsAssetBundle, progress, (Action<MusicTrackDef[]>)((assets) =>
            {
                contentPack.musicTrackDefs.Add(assets);
                Log.Debug("Loaded musicDefs for SnowtimeStages");
            }));

            // Handle adding stages to loop or making Bazaar Seer materials
            Log.Debug("Adding Stages to the Loop + Bazaar Seer Materials");
            Log.Debug("Blood Gulch Config Status?");
			Log.Debug(SnowtimeStage.ToggleBloodGulch.Value);
			if (SnowtimeStage.ToggleBloodGulch.Value == true)
			{
                STBGBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STBGSceneDefPreviewSprite.texture);
                STBGSceneDef.previewTexture = STBGSceneDefPreviewSprite.texture;
                STBGSceneDef.portalMaterial = STBGBazaarSeer;
                Log.Debug("Blood Gulch Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STBGSceneDef);
				Log.Debug("Added Blood Gulch to loop");
				Log.Debug(STBGSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleBloodGulch.Value == false)
			{
				Log.Debug("Skipped adding Blood Gulch to the loop");
			}
			Log.Debug("Sidewinder Config Status?");
			Log.Debug(SnowtimeStage.ToggleSidewinder.Value);
			if (SnowtimeStage.ToggleSidewinder.Value == true)
			{
                STSWBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STSWSceneDefPreviewSprite.texture);
                STSWSceneDef.previewTexture = STSWSceneDefPreviewSprite.texture;
                STSWSceneDef.portalMaterial = STSWBazaarSeer;
                Log.Debug("Sidewinder Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STSWSceneDef);
				Log.Debug("Added Sidewinder to the loop");
				Log.Debug(STSWSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleSidewinder.Value == false)
			{
				Log.Debug("Skipped adding Sidewinder to the loop");
			}
			Log.Debug("Death Island Config Status?");
			Log.Debug(SnowtimeStage.ToggleDeathIsland.Value);
			if (SnowtimeStage.ToggleDeathIsland.Value == true)
			{
                STBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STSceneDefPreviewSprite.texture);
                STSceneDef.previewTexture = STSceneDefPreviewSprite.texture;
                STSceneDef.portalMaterial = STBazaarSeer;
                Log.Debug("Death Island Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STSceneDef);
				Log.Debug("Added Death Island to the loop");
				Log.Debug(STSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleDeathIsland.Value == false)
			{
				Log.Debug("Skipped adding Death Island to the loop");
			}
			Log.Debug("Ice Fields Config Status?");
			Log.Debug(SnowtimeStage.ToggleIceFields.Value);
			if (SnowtimeStage.ToggleIceFields.Value == true)
			{
                STIFBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STIFSceneDefPreviewSprite.texture);
                STIFSceneDef.previewTexture = STIFSceneDefPreviewSprite.texture;
                STIFSceneDef.portalMaterial = STIFBazaarSeer;
                Log.Debug("Ice Fields Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STIFSceneDef);
				Log.Debug("Added Ice Fields to the loop");
				Log.Debug(STIFSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleIceFields.Value == false)
			{
				Log.Debug("Skipped adding Ice Fields to the loop");
			}
			Log.Debug("Gephyrophobia Config Status?");
			Log.Debug(SnowtimeStage.ToggleGephyrophobia.Value);
			if (SnowtimeStage.ToggleGephyrophobia.Value == true)
			{
                STGPHBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STGPHSceneDefPreviewSprite.texture);
                STGPHSceneDef.previewTexture = STGPHSceneDefPreviewSprite.texture;
                STGPHSceneDef.portalMaterial = STGPHBazaarSeer;
                Log.Debug("Gephyrophobia Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STGPHSceneDef);
				Log.Debug("Added Gephyrophobia to the loop");
				Log.Debug(STGPHSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleGephyrophobia.Value == false)
			{
				Log.Debug("Skipped adding Gephyrophobia to the loop");
			}
			Log.Debug("Sandtrap Config Status?");
			Log.Debug(SnowtimeStage.ToggleSandtrap.Value);
			if (SnowtimeStage.ToggleSandtrap.Value == true)
			{
                STShrineBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STShrineSceneDefPreviewSprite.texture);
                STShrineSceneDef.previewTexture = STShrineSceneDefPreviewSprite.texture;
                STShrineSceneDef.portalMaterial = STShrineBazaarSeer;
                Log.Debug("Sandtrap Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STShrineSceneDef);
				Log.Debug("Added Sandtrap to the loop");
				Log.Debug(STShrineSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleSandtrap.Value == false)
			{
				Log.Debug("Skipped adding Sandtrap to the loop");
			}
			Log.Debug("Halo Config Status?");
			Log.Debug(SnowtimeStage.ToggleHalo.Value);
			if (SnowtimeStage.ToggleHalo.Value == true)
			{
                STHBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STHSceneDefPreviewSprite.texture);
                STHSceneDef.previewTexture = STHSceneDefPreviewSprite.texture;
                STHSceneDef.portalMaterial = STHBazaarSeer;
                Log.Debug("Halo Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STHSceneDef);
				Log.Debug("Added Halo to the loop");
				Log.Debug(STHSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleHalo.Value == false)
			{
				Log.Debug("Skipped adding Halo to the loop");
			}
			Log.Debug("Halo Config Status?");
			Log.Debug(SnowtimeStage.ToggleHalo2.Value);
			if (SnowtimeStage.ToggleHalo2.Value == true)
			{
                STH2BazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STH2SceneDefPreviewSprite.texture);
                STH2SceneDef.previewTexture = STH2SceneDefPreviewSprite.texture;
                STH2SceneDef.portalMaterial = STH2BazaarSeer;
                Log.Debug("Halo(Alt) Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STH2SceneDef);
				Log.Debug("Added Halo(Alt) to the loop");
				Log.Debug(STH2SceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleHalo2.Value == false)
			{
				Log.Debug("Skipped adding Halo(Alt) to the loop");
			}
			Log.Debug("New Mombasa Bridge Config Status?");
			Log.Debug(SnowtimeStage.ToggleNMB.Value);
			if (SnowtimeStage.ToggleNMB.Value == true)
			{
                STNMBBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STNMBSceneDefPreviewSprite.texture);
                STNMBSceneDef.previewTexture = STNMBSceneDefPreviewSprite.texture;
                STNMBSceneDef.portalMaterial = STNMBBazaarSeer;
                Log.Debug("New Mombasa Bridge Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STNMBSceneDef);
				Log.Debug("Added New Mombasa Bridge to the loop");
				Log.Debug(STNMBSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleNMB.Value == false)
			{
				Log.Debug("Skipped adding New Mombasa Bridge to the loop");
			}
			Log.Debug("gm_construct Config Status?");
			Log.Debug(SnowtimeStage.ToggleGMC.Value);
			if (SnowtimeStage.ToggleGMC.Value == true)
			{
                STGMCBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STGMCSceneDefPreviewSprite.texture);
                STGMCSceneDef.previewTexture = STGMCSceneDefPreviewSprite.texture;
                STGMCSceneDef.portalMaterial = STGMCBazaarSeer;
                Log.Debug("gm_construct Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STGMCSceneDef);
				Log.Debug("Added gm_construct to the loop");
				Log.Debug(STGMCSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleGMC.Value == false)
			{
				Log.Debug("Skipped adding gm_construct to the loop");
			}
			Log.Debug("Delta Halo Config Status?");
			Log.Debug(SnowtimeStage.ToggleDHalo.Value);
			if (SnowtimeStage.ToggleDHalo.Value == true)
			{
                STDHBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STDHSceneDefPreviewSprite.texture);
                STDHSceneDef.previewTexture = STDHSceneDefPreviewSprite.texture;
                STDHSceneDef.portalMaterial = STDHBazaarSeer;
                Log.Debug("Delta Halo Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STDHSceneDef);
				Log.Debug("Added Delta Halo to the loop");
				Log.Debug(STDHSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleDHalo.Value == false)
			{
				Log.Debug("Skipped adding Delta Halo to the loop");
			}
			Log.Debug("gm_flatgrass Config Status?");
			Log.Debug(SnowtimeStage.ToggleFLAT.Value);
			if (SnowtimeStage.ToggleFLAT.Value == true)
			{
                STFlatBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STFlatSceneDefPreviewSprite.texture);
                STFlatSceneDef.previewTexture = STFlatSceneDefPreviewSprite.texture;
                STFlatSceneDef.portalMaterial = STFlatBazaarSeer;
                Log.Debug("gm_flatgrass Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STFlatSceneDef);
				Log.Debug("Added gm_flatgrass to the loop");
				Log.Debug(STFlatSceneDef.destinationsGroup);
			}
			if (SnowtimeStage.ToggleFLAT.Value == false)
			{
				Log.Debug("Skipped adding gm_flatgrass to the loop");
			}
            Log.Debug("High Charity Config Status?");
            Log.Debug(SnowtimeStage.ToggleHC.Value);
            if (SnowtimeStage.ToggleHC.Value == true)
            {
                STHCBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STHCSceneDefPreviewSprite.texture);
                STHCSceneDef.previewTexture = STHCSceneDefPreviewSprite.texture;
                STHCSceneDef.portalMaterial = STHCBazaarSeer;
                Log.Debug("High Charity Bazaar Seer Material Complete");

                StageRegistration.RegisterSceneDefToNormalProgression(STHCSceneDef);
                Log.Debug("Added High Charity to the loop");
                Log.Debug(STHCSceneDef.destinationsGroup);
            }
            if (SnowtimeStage.ToggleHC.Value == false)
            {
                Log.Debug("Skipped adding High Charity to the loop");
            }
            if (SnowtimeStage.ToggleBig.Value == true)
            {
                STCityBazaarSeer = StageRegistration.MakeBazaarSeerMaterial(STCitySceneDefPreviewSprite.texture);
                STCitySceneDef.previewTexture = STCitySceneDefPreviewSprite.texture;
                STCitySceneDef.portalMaterial = STCityBazaarSeer;
                Log.Debug("gm_bigcity Bazaar Seer Material Complete");

                Log.Debug("Hid gm_bigcity on stage 4's Bazaar");
            }
            if (SnowtimeStage.ToggleBig.Value == false)
            {
                Log.Debug("Skipped hiding gm_bigcity in the bazaar");
            }

            SnowtimeStage.SnowtimeLegendaryDiffDef.iconSprite = SnowtimeLegendaryIcon;
            SnowtimeStage.SnowtimeLegendaryDiffDef.foundIconSprite = true;
        }

        private static IEnumerator LoadAllAssetsAsync<T>(AssetBundle assetBundle, IProgress<float> progress, Action<T[]> onAssetsLoaded) where T : UnityEngine.Object
        {
            var sceneDefsRequest = assetBundle.LoadAllAssetsAsync<T>();
            while (!sceneDefsRequest.isDone)
            {
                progress.Report(sceneDefsRequest.progress);
                yield return null;
            }

            onAssetsLoaded(sceneDefsRequest.allAssets.Cast<T>().ToArray());

            yield break;
        }

        internal static void LoadSoundBanks(string soundbanksFolderPath)
        {
           var akResult = AkSoundEngine.AddBasePath(soundbanksFolderPath);
           if (akResult == AKRESULT.AK_Success)
           {
               Log.Info($"Added bank base path : {soundbanksFolderPath}");
           }
           else
           {
               Log.Error(
                   $"Error adding base path : {soundbanksFolderPath} " +
                   $"Error code : {akResult}");
           }
           
           akResult = AkSoundEngine.LoadBank(InitSoundBankFileName, out var _);
           if (akResult == AKRESULT.AK_Success)
           {
               Log.Info($"Added bank : {InitSoundBankFileName}");
           }
           else
           {
               Log.Error(
                   $"Error loading bank : {InitSoundBankFileName} " +
                   $"Error code : {akResult}");
           }
           
           akResult = AkSoundEngine.LoadBank(MusicSoundBankFileName, out var _);
           if (akResult == AKRESULT.AK_Success)
           {
               Log.Info($"Added bank : {MusicSoundBankFileName}");
           }
           else
           {
               Log.Error(
                   $"Error loading bank : {MusicSoundBankFileName} " +
                   $"Error code : {akResult}");
           }

            akResult = AkSoundEngine.LoadBank(SndSoundBankFileName, out var _);
            if (akResult == AKRESULT.AK_Success)
            {
                Log.Info($"Added bank : {SndSoundBankFileName}");
            }
            else
            {
                Log.Error(
                    $"Error loading bank : {SndSoundBankFileName} " +
                    $"Error code : {akResult}");
            }
        }
		
    }
}
