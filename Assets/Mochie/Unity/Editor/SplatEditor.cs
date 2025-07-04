using UnityEditor;
using UnityEngine;
using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;
using Mochie;

public class SplatEditor : ShaderGUI {

	string versionLabel = "v1.3.1";

	MaterialProperty _LayerBlendSource = null;
	MaterialProperty _LayerBlendMask = null;
	MaterialProperty _LayerBlendMaskBicubic = null;

	// Base layer
	MaterialProperty _Color0 = null;
	MaterialProperty _BaseColor0 = null;
	MaterialProperty _Normal0 = null;
	MaterialProperty _PackedMap0 = null;
	MaterialProperty _NormalStrength0 = null;
	MaterialProperty _Roughness0 = null;
	MaterialProperty _Metallic0 = null;
	MaterialProperty _Occlusion0 = null;
	MaterialProperty _Height0 = null;
	MaterialProperty _HeightOffset0 = null;
	MaterialProperty _ToggleStochastic0 = null;
	MaterialProperty _ToggleParallax0 = null;
	MaterialProperty _SmoothnessMode0 = null;
	MaterialProperty _RoughnessChannel0 = null;
	MaterialProperty _MetallicChannel0 = null;
	MaterialProperty _OcclusionChannel0 = null;
	MaterialProperty _HeightChannel0 = null;
	MaterialProperty _Layer0UVSet = null;
	MaterialProperty _PuddleHeightBlend0 = null;
	// MaterialProperty _PuddleRainMask0 = null;
	MaterialProperty _PuddleBlendMin0 = null;
	MaterialProperty _PuddleBlendMax0 = null;
	MaterialProperty _PuddleTint0 = null;

	// Layer 1
	MaterialProperty _ToggleLayer1 = null;
	MaterialProperty _Color1 = null;
	MaterialProperty _BaseColor1 = null;
	MaterialProperty _Normal1 = null;
	MaterialProperty _PackedMap1 = null;
	MaterialProperty _NormalStrength1 = null;
	MaterialProperty _Roughness1 = null;
	MaterialProperty _Metallic1 = null;
	MaterialProperty _Occlusion1 = null;
	MaterialProperty _Height1 = null;
	MaterialProperty _HeightOffset1 = null;
	MaterialProperty _ToggleStochastic1 = null;
	MaterialProperty _ToggleParallax1 = null;
	MaterialProperty _SmoothnessMode1 = null;
	MaterialProperty _RoughnessChannel1 = null;
	MaterialProperty _MetallicChannel1 = null;
	MaterialProperty _OcclusionChannel1 = null;
	MaterialProperty _HeightChannel1 = null;
	MaterialProperty _BlendThresholdMin1 = null;
	MaterialProperty _BlendThresholdMax1 = null;
	MaterialProperty _Layer1UVSet = null;
	MaterialProperty _HeightBlend1 = null;
	MaterialProperty _HeightBlendMin1 = null;
	MaterialProperty _HeightBlendMax1 = null;
	MaterialProperty _PuddleHeightBlend1 = null;
	// MaterialProperty _PuddleRainMask1 = null;
	MaterialProperty _PuddleBlendMin1 = null;
	MaterialProperty _PuddleBlendMax1 = null;
	MaterialProperty _PuddleTint1 = null;
	MaterialProperty _HeightBlendEdges1 = null;
	MaterialProperty _EdgePower1 = null;

	// Layer 2
	MaterialProperty _ToggleLayer2 = null;
	MaterialProperty _Color2 = null;
	MaterialProperty _BaseColor2 = null;
	MaterialProperty _Normal2 = null;
	MaterialProperty _PackedMap2 = null;
	MaterialProperty _NormalStrength2 = null;
	MaterialProperty _Roughness2 = null;
	MaterialProperty _Metallic2 = null;
	MaterialProperty _Occlusion2 = null;
	MaterialProperty _Height2 = null;
	MaterialProperty _HeightOffset2 = null;
	MaterialProperty _ToggleStochastic2 = null;
	MaterialProperty _ToggleParallax2 = null;
	MaterialProperty _SmoothnessMode2 = null;
	MaterialProperty _RoughnessChannel2 = null;
	MaterialProperty _MetallicChannel2 = null;
	MaterialProperty _OcclusionChannel2 = null;
	MaterialProperty _HeightChannel2 = null;
	MaterialProperty _BlendThresholdMin2 = null;
	MaterialProperty _BlendThresholdMax2 = null;
	MaterialProperty _Layer2UVSet = null;
	MaterialProperty _HeightBlend2 = null;
	MaterialProperty _HeightBlendMin2 = null;
	MaterialProperty _HeightBlendMax2 = null;
	MaterialProperty _PuddleHeightBlend2 = null;
	// MaterialProperty _PuddleRainMask2 = null;
	MaterialProperty _PuddleBlendMin2 = null;
	MaterialProperty _PuddleBlendMax2 = null;
	MaterialProperty _PuddleTint2 = null;
	MaterialProperty _HeightBlendEdges2 = null;
	MaterialProperty _EdgePower2 = null;

	// Layer 3
	MaterialProperty _ToggleLayer3 = null;
	MaterialProperty _Color3 = null;
	MaterialProperty _BaseColor3 = null;
	MaterialProperty _Normal3 = null;
	MaterialProperty _PackedMap3 = null;
	MaterialProperty _NormalStrength3 = null;
	MaterialProperty _Roughness3 = null;
	MaterialProperty _Metallic3 = null;
	MaterialProperty _Occlusion3 = null;
	MaterialProperty _Height3 = null;
	MaterialProperty _HeightOffset3 = null;
	MaterialProperty _ToggleStochastic3 = null;
	MaterialProperty _ToggleParallax3 = null;
	MaterialProperty _SmoothnessMode3 = null;
	MaterialProperty _RoughnessChannel3 = null;
	MaterialProperty _MetallicChannel3 = null;
	MaterialProperty _OcclusionChannel3 = null;
	MaterialProperty _HeightChannel3 = null;
	MaterialProperty _BlendThresholdMin3 = null;
	MaterialProperty _BlendThresholdMax3 = null;
	MaterialProperty _Layer3UVSet = null;
	MaterialProperty _HeightBlend3 = null;
	MaterialProperty _HeightBlendMin3 = null;
	MaterialProperty _HeightBlendMax3 = null;
	MaterialProperty _PuddleHeightBlend3 = null;
	// MaterialProperty _PuddleRainMask3 = null;
	MaterialProperty _PuddleBlendMin3 = null;
	MaterialProperty _PuddleBlendMax3 = null;
	MaterialProperty _PuddleTint3 = null;
	MaterialProperty _HeightBlendEdges3 = null;
	MaterialProperty _EdgePower3 = null;

	// Specularity
	MaterialProperty _ReflectionsToggle = null;
	MaterialProperty _SpecularHighlightsToggle = null;
	MaterialProperty _SpecularOcclusionToggle = null;
	MaterialProperty _SpecularOcclusionStrength = null;
	MaterialProperty _SpecularOcclusionContrast = null;
	MaterialProperty _SpecularOcclusionBrightness = null;
	MaterialProperty _SpecularOcclusionTint = null;
	MaterialProperty _SpecularOcclusionHDR = null;
	MaterialProperty _SpecularHighlightStrength = null;
	MaterialProperty _ReflectionStrength = null;
	MaterialProperty _FresnelToggle = null;
	MaterialProperty _FresnelStrength = null;
	MaterialProperty _SSRToggle = null;
	MaterialProperty _SSRStrength = null;
	MaterialProperty _SSREdgeFade = null;
	MaterialProperty _SSRHeight = null;

	// Rain
	MaterialProperty _RainToggle = null;
	MaterialProperty _RainLayer0 = null;
	MaterialProperty _RainLayer1 = null;
	MaterialProperty _RainLayer2 = null;
	MaterialProperty _RainLayer3 = null;
	MaterialProperty _RainScale = null;
	MaterialProperty _RainSpeed = null;
	MaterialProperty _RainStrength = null;
	MaterialProperty _RainDensity = null;
	MaterialProperty _RainSize = null;
	MaterialProperty _RainThreshold = null;
	MaterialProperty _RainThresholdSize = null;
	// MaterialProperty _PuddleThreshold = null;
	// MaterialProperty _PuddleThresholdSize = null;
	MaterialProperty _RainPuddleDensity = null;
	MaterialProperty _RainPuddleSize = null;

	// Lightmapping Settings
	MaterialProperty _BAKERY_LMSPEC = null;
	MaterialProperty _BAKERY_SHNONLINEAR = null;
	MaterialProperty _BakeryMode = null;
	MaterialProperty _BicubicSampling = null;
	MaterialProperty _IgnoreRealtimeGI = null;

	// AreaLit
	MaterialProperty _AreaLitToggle = null;
	MaterialProperty _AreaLitStrength = null;
	MaterialProperty _AreaLitRoughnessMult = null;
	MaterialProperty _AreaLitSpecularOcclusion = null;
	MaterialProperty _LightMesh = null;
	MaterialProperty _LightTex0 = null;
	MaterialProperty _LightTex1 = null;
	MaterialProperty _LightTex2 = null;
	MaterialProperty _LightTex3 = null;
	MaterialProperty _OpaqueLights = null;
	MaterialProperty _AreaLitOcclusion = null;
	MaterialProperty _AreaLitOcclusionUVSet = null;

	// LTCGI
	MaterialProperty _LTCGI = null;
	MaterialProperty _LTCGI_DIFFUSE_OFF = null;
	MaterialProperty _LTCGI_SPECULAR_OFF = null;
	MaterialProperty _LTCGIStrength = null;
	MaterialProperty _LTCGIRoughness = null;

	// Debug Display
	MaterialProperty _DebugMode = null;
	MaterialProperty _DebugBaseColor = null;
	MaterialProperty _DebugNormals = null;
	MaterialProperty _DebugRoughness = null;
	MaterialProperty _DebugMetallic = null;
	MaterialProperty _DebugHeight = null;
	MaterialProperty _DebugVertexColors = null;
	MaterialProperty _DebugAtten = null;
	MaterialProperty _DebugReflections = null;
	MaterialProperty _DebugSpecular = null;
	MaterialProperty _DebugRainThreshold = null;
	MaterialProperty _DebugOcclusion = null;
	// MaterialProperty _DebugPuddleThreshold = null;

	MaterialEditor me;

    BindingFlags bindingFlags = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static;
	bool m_FirstTimeApply = true;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props) {
		me = materialEditor;
		
        if (!me.isVisible)
            return;

        foreach (var property in GetType().GetFields(bindingFlags)){
            if (property.FieldType == typeof(MaterialProperty))
                property.SetValue(this, FindProperty(property.Name, props));
        }
        Material mat = (Material)me.target;
        if (m_FirstTimeApply){
			m_FirstTimeApply = false;
        }

        EditorGUI.BeginChangeCheck(); {

			DoBlending();
			DoBaseLayer();
			DoLayer1();
			DoLayer2();
			DoLayer3();
			DoSpecularity(mat);
			DoLightmapSettings();
			DoRain();
			DoLTCGI(mat);
			DoAreaLit(mat);
			DoDebug();
		}

		if (EditorGUI.EndChangeCheck()){
			SetKeywords(mat);
		}

		MGUI.Space10();
		MGUI.DoFooter(versionLabel);
    }

	void DoBlending(){
		MGUI.ShaderPropertyBold(me, _LayerBlendSource, "Layer Blending Source:");
		if (_LayerBlendSource.floatValue == 1){
			MGUI.Space4();
			MGUI.PropertyGroup(()=>{
				me.TexturePropertySingleLine(new GUIContent("Mask (RGBA)"), _LayerBlendMask, _LayerBlendMaskBicubic);
				MGUI.TexPropLabel("Bicubic Sampling", 10, false);
				MGUI.TextureSO(me, _LayerBlendMask);
			});
		}
		MGUI.Space4();
	}

	void DoBaseLayer(){
		MGUI.BoldLabel("Base Layer");
		MGUI.PropertyGroup(()=>{
			MGUI.PropertyGroup(()=>{
				me.TexturePropertySingleLine(Tips.albedoText, _BaseColor0, _Color0);
				me.TexturePropertySingleLine(Tips.normalMapText, _Normal0, _Normal0.textureValue ? _NormalStrength0 : null);
				MGUI.NormalWarning(_Normal0);
				me.TexturePropertySingleLine(Tips.packedMapText, _PackedMap0);
				MGUI.sRGBWarning(_PackedMap0);
				MGUI.Space2();
				me.ShaderProperty(_Layer0UVSet, "UV Set");
				MGUI.TextureSO(me, _BaseColor0);
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_SmoothnessMode0, "Smoothness Mode");
				me.ShaderProperty(_RoughnessChannel0, _SmoothnessMode0.floatValue == 1 ? "Smoothness Channel" : "Roughness Channel");
				me.ShaderProperty(_MetallicChannel0, "Metallic Channel");
				me.ShaderProperty(_OcclusionChannel0, "Occlusion Channel");
				if (_ToggleParallax0.floatValue == 1 && _ToggleStochastic0.floatValue == 0){
					me.ShaderProperty(_HeightChannel0, "Height Channel");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_Roughness0, _SmoothnessMode0.floatValue == 1 ? "Smoothness" : "Roughness");
				me.ShaderProperty(_Metallic0, "Metallic");
				me.ShaderProperty(_Occlusion0, "Occlusion");
				if (_ToggleParallax0.floatValue == 1 && _ToggleStochastic0.floatValue == 0){
					me.ShaderProperty(_Height0, "Height Strength");
					me.ShaderProperty(_HeightOffset0, "Height Offset");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_ToggleStochastic0, Tips.stochasticLabel);
				MGUI.ToggleGroup(_ToggleStochastic0.floatValue == 1);
				me.ShaderProperty(_ToggleParallax0, "Parallax Height");
				MGUI.ToggleGroupEnd();
			});
			if (_ToggleParallax0.floatValue == 1 && _ToggleStochastic0.floatValue == 0){
				MGUI.PropertyGroup(()=>{
					me.ShaderProperty(_PuddleHeightBlend0, "Puddle Height Blend");
					if (_PuddleHeightBlend0.floatValue == 1){
						MGUI.SliderMinMax01(_PuddleBlendMin0, _PuddleBlendMax0, "Puddle Blend Threshold ", 1);
						me.ShaderProperty(_PuddleTint0, "Puddle Tint");
					}
				});
			}
			MGUI.SpaceN2();
		});
		MGUI.Space4();
	}

	void DoLayer1(){
		MGUI.ShaderPropertyBold(me, _ToggleLayer1, "Layer 1 (R)");
		MGUI.ToggleGroup(_ToggleLayer1.floatValue == 0);
		MGUI.SliderMinMax01(_BlendThresholdMin1, _BlendThresholdMax1, "Blend Threshold", 0);
		MGUI.PropertyGroup(()=>{
			MGUI.PropertyGroup(()=>{
				me.TexturePropertySingleLine(Tips.albedoText, _BaseColor1, _Color1);
				me.TexturePropertySingleLine(Tips.normalMapText, _Normal1, _Normal1.textureValue ? _NormalStrength1 : null);
				MGUI.NormalWarning(_Normal1);
				me.TexturePropertySingleLine(Tips.packedMapText, _PackedMap1);
				MGUI.sRGBWarning(_PackedMap1);
				MGUI.Space2();
				me.ShaderProperty(_Layer1UVSet, "UV Set");
				MGUI.TextureSO(me, _BaseColor1);
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_SmoothnessMode1, "Smoothness Mode");
				me.ShaderProperty(_RoughnessChannel1, _SmoothnessMode1.floatValue == 1 ? "Smoothness Channel" : "Roughness Channel");
				me.ShaderProperty(_MetallicChannel1, "Metallic Channel");
				me.ShaderProperty(_OcclusionChannel1, "Occlusion Channel");
				if (_ToggleParallax1.floatValue == 1 && _ToggleStochastic1.floatValue == 0){
					me.ShaderProperty(_HeightChannel1, "Height Channel");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_Roughness1, _SmoothnessMode1.floatValue == 1 ? "Smoothness" : "Roughness");
				me.ShaderProperty(_Metallic1, "Metallic");
				me.ShaderProperty(_Occlusion1, "Occlusion");
				if (_ToggleParallax1.floatValue == 1 && _ToggleStochastic1.floatValue == 0){
					me.ShaderProperty(_Height1, "Height Strength");
					me.ShaderProperty(_HeightOffset1, "Height Offset");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_ToggleStochastic1, Tips.stochasticLabel);
				MGUI.ToggleGroup(_ToggleStochastic1.floatValue == 1);
				me.ShaderProperty(_ToggleParallax1, "Parallax Height");
				MGUI.ToggleGroupEnd();
			});
			if (_ToggleParallax1.floatValue == 1 && _ToggleStochastic1.floatValue == 0){
				MGUI.PropertyGroup(()=>{
					me.ShaderProperty(_HeightBlend1, "Layer Height Blend");
					if (_HeightBlend1.floatValue == 1){
						MGUI.ToggleFloat(me, "Layer Edge Mask", _HeightBlendEdges1, _EdgePower1);
						MGUI.SliderMinMax01(_HeightBlendMin1, _HeightBlendMax1, "Layer Blend Threshold ", 1);
					}
					me.ShaderProperty(_PuddleHeightBlend1, "Puddle Height Blend");
					if (_PuddleHeightBlend1.floatValue == 1){
						MGUI.SliderMinMax01(_PuddleBlendMin1, _PuddleBlendMax1, "Puddle Blend Threshold ", 1);
						me.ShaderProperty(_PuddleTint1, "Puddle Tint");
					}
				});
			}
			MGUI.SpaceN2();
		});
		MGUI.ToggleGroupEnd();
		MGUI.Space4();
	}

	void DoLayer2(){
		MGUI.ShaderPropertyBold(me, _ToggleLayer2, "Layer 2 (G)");
		MGUI.ToggleGroup(_ToggleLayer2.floatValue == 0);
		MGUI.SliderMinMax01(_BlendThresholdMin2, _BlendThresholdMax2, "Blend Threshold", 0);
		MGUI.PropertyGroup(()=>{
			MGUI.PropertyGroup(()=>{
				me.TexturePropertySingleLine(Tips.albedoText, _BaseColor2, _Color2);
				me.TexturePropertySingleLine(Tips.normalMapText, _Normal2, _Normal2.textureValue ? _NormalStrength2 : null);
				MGUI.NormalWarning(_Normal2);
				me.TexturePropertySingleLine(Tips.packedMapText, _PackedMap2);
				MGUI.sRGBWarning(_PackedMap2);
				MGUI.Space2();
				me.ShaderProperty(_Layer2UVSet, "UV Set");
				MGUI.TextureSO(me, _BaseColor2);
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_SmoothnessMode2, "Smoothness Mode");
				me.ShaderProperty(_RoughnessChannel2, _SmoothnessMode2.floatValue == 1 ? "Smoothness Channel" : "Roughness Channel");
				me.ShaderProperty(_MetallicChannel2, "Metallic Channel");
				me.ShaderProperty(_OcclusionChannel2, "Occlusion Channel");
				if (_ToggleParallax2.floatValue == 1 && _ToggleStochastic2.floatValue == 0){
					me.ShaderProperty(_HeightChannel2, "Height Channel");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_Roughness2, _SmoothnessMode2.floatValue == 1 ? "Smoothness" : "Roughness");
				me.ShaderProperty(_Metallic2, "Metallic");
				me.ShaderProperty(_Occlusion2, "Occlusion");
				if (_ToggleParallax2.floatValue == 1 && _ToggleStochastic2.floatValue == 0){
					me.ShaderProperty(_Height2, "Height Strength");
					me.ShaderProperty(_HeightOffset2, "Height Offset");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_ToggleStochastic2, Tips.stochasticLabel);
				MGUI.ToggleGroup(_ToggleStochastic2.floatValue == 1);
				me.ShaderProperty(_ToggleParallax2, "Parallax Height");
				MGUI.ToggleGroupEnd();
			});
			if (_ToggleParallax2.floatValue == 1 && _ToggleStochastic2.floatValue == 0){
				MGUI.PropertyGroup(()=>{
					me.ShaderProperty(_HeightBlend2, "Layer Height Blend");
					if (_HeightBlend2.floatValue == 1){
						MGUI.ToggleFloat(me, "Layer Edge Mask", _HeightBlendEdges2, _EdgePower2);
						MGUI.SliderMinMax01(_HeightBlendMin2, _HeightBlendMax2, "Layer Blend Threshold ", 1);
					}
					me.ShaderProperty(_PuddleHeightBlend2, "Puddle Height Blend");
					if (_PuddleHeightBlend2.floatValue == 1){
						MGUI.SliderMinMax01(_PuddleBlendMin2, _PuddleBlendMax2, "Puddle Blend Threshold ", 1);
						me.ShaderProperty(_PuddleTint2, "Puddle Tint");
					}
				});
			}
			MGUI.SpaceN2();
		});
		MGUI.ToggleGroupEnd();
		MGUI.Space4();
	}

	void DoLayer3(){
		MGUI.ShaderPropertyBold(me, _ToggleLayer3, "Layer 3 (B)");
		MGUI.ToggleGroup(_ToggleLayer3.floatValue == 0);
		MGUI.SliderMinMax01(_BlendThresholdMin3, _BlendThresholdMax3, "Blend Threshold", 0);
		MGUI.PropertyGroup(()=>{
			MGUI.PropertyGroup(()=>{
				me.TexturePropertySingleLine(Tips.albedoText, _BaseColor3, _Color3);
				me.TexturePropertySingleLine(Tips.normalMapText, _Normal3, _Normal3.textureValue ? _NormalStrength3 : null);
				MGUI.NormalWarning(_Normal3);
				me.TexturePropertySingleLine(Tips.packedMapText, _PackedMap3);
				MGUI.sRGBWarning(_PackedMap3);
				MGUI.Space2();
				me.ShaderProperty(_Layer3UVSet, "UV Set");
				MGUI.TextureSO(me, _BaseColor3);
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_SmoothnessMode3, "Smoothness Mode");
				me.ShaderProperty(_RoughnessChannel3, _SmoothnessMode3.floatValue == 1 ? "Smoothness Channel" : "Roughness Channel");
				me.ShaderProperty(_MetallicChannel3, "Metallic Channel");
				me.ShaderProperty(_OcclusionChannel3, "Occlusion Channel");
				if (_ToggleParallax3.floatValue == 1 && _ToggleStochastic3.floatValue == 0){
					me.ShaderProperty(_HeightChannel3, "Height Channel");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_Roughness3, _SmoothnessMode3.floatValue == 1 ? "Smoothness" : "Roughness");
				me.ShaderProperty(_Metallic3, "Metallic");
				me.ShaderProperty(_Occlusion3, "Occlusion");
				if (_ToggleParallax3.floatValue == 1 && _ToggleStochastic3.floatValue == 0){
					me.ShaderProperty(_Height3, "Height Strength");
					me.ShaderProperty(_HeightOffset3, "Height Offset");
				}
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_ToggleStochastic3, Tips.stochasticLabel);
				MGUI.ToggleGroup(_ToggleStochastic3.floatValue == 1);
				me.ShaderProperty(_ToggleParallax3, "Parallax Height");
				MGUI.ToggleGroupEnd();
			});
			if (_ToggleParallax3.floatValue == 1 && _ToggleStochastic3.floatValue == 0){
				MGUI.PropertyGroup(()=>{
					me.ShaderProperty(_HeightBlend3, "Layer Height Blend");
					if (_HeightBlend3.floatValue == 1){
						MGUI.ToggleFloat(me, "Layer Edge Mask", _HeightBlendEdges3, _EdgePower3);
						MGUI.SliderMinMax01(_HeightBlendMin3, _HeightBlendMax3, "Layer Blend Threshold ", 1);
					}
					me.ShaderProperty(_PuddleHeightBlend3, "Puddle Height Blend");
					if (_PuddleHeightBlend3.floatValue == 1){
						MGUI.SliderMinMax01(_PuddleBlendMin3, _PuddleBlendMax3, "Puddle Blend Threshold ", 1);
						me.ShaderProperty(_PuddleTint3, "Puddle Tint");
					}
				});
			}
			MGUI.SpaceN2();
		});
		MGUI.ToggleGroupEnd();
		MGUI.Space6();
	}

	void DoSpecularity(Material mat){
		MGUI.BoldLabel("Specularity");
		MGUI.PropertyGroup(()=>{
			MGUI.ToggleFloat(me, Tips.reflectionText, _ReflectionsToggle, _ReflectionStrength);
			MGUI.ToggleFloat(me, Tips.specularHighlightsText, _SpecularHighlightsToggle, _SpecularHighlightStrength);
			MGUI.ToggleFloat(me, Tips.useFresnel, _FresnelToggle, _FresnelStrength);
			EditorGUI.BeginChangeCheck();
			MGUI.ToggleFloat(me, Tips.ssrText, _SSRToggle, _SSRStrength);
			if (EditorGUI.EndChangeCheck()){
				ApplySSRRenderSettings(mat);
			}
			if (_SSRToggle.floatValue == 1){
				MGUI.PropertyGroup(()=>{
					me.ShaderProperty(_SSREdgeFade, "Edge Fade");
					me.ShaderProperty(_SSRHeight, "Height");
				});
			}
			MGUI.ToggleFloat(me, Tips.reflShadows, _SpecularOcclusionToggle, _SpecularOcclusionStrength);
			if (_SpecularOcclusionToggle.floatValue == 1){
				MGUI.PropertyGroup(()=>{
					me.ShaderProperty(_SpecularOcclusionTint, "Lightmap Tint");
					me.ShaderProperty(_SpecularOcclusionBrightness, "Lightmap Brightness");
					me.ShaderProperty(_SpecularOcclusionContrast, "Lightmap Contrast");
					me.ShaderProperty(_SpecularOcclusionHDR, "Lightmap HDR");
				});
				MGUI.SpaceN2();
			}
		});
		MGUI.Space6();
	}

	void DoRain(){
		MGUI.ShaderPropertyBold(me, _RainToggle, "Rain");
		MGUI.ToggleGroup(_RainToggle.floatValue == 0);
		MGUI.PropertyGroup(()=>{
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_RainLayer0, "Base Layer");
				me.ShaderProperty(_RainLayer1, "Layer 1 (R)");
				me.ShaderProperty(_RainLayer2, "Layer 2 (G)");
				me.ShaderProperty(_RainLayer3, "Layer 3 (B)");
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_RainStrength, "Strength");
				me.ShaderProperty(_RainScale, "Scale");
				me.ShaderProperty(_RainSpeed, "Speed");
				me.ShaderProperty(_RainThreshold, "Angle Mask");
				me.ShaderProperty(_RainThresholdSize, "Angle Mask Blend");
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_RainDensity, "Ripple Density");
				me.ShaderProperty(_RainSize, "Ripple Size");
			});
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_RainPuddleDensity, "Puddle Ripple Density");
				me.ShaderProperty(_RainPuddleSize, "Puddle Ripple Size");
			});
			MGUI.SpaceN2();
		});
		MGUI.ToggleGroupEnd();
		MGUI.Space6();
	}

	void DoLightmapSettings(){
		MGUI.Space4();
		MGUI.BoldLabel("Lightmap Settings");
		MGUI.PropertyGroup(()=>{
			me.ShaderProperty(_BakeryMode, Tips.bakeryMode);
			me.ShaderProperty(_BAKERY_SHNONLINEAR, "Bakery Non-Linear SH");
			me.ShaderProperty(_BAKERY_LMSPEC, "Bakery Lightmap Specular");
			me.ShaderProperty(_BicubicSampling, Tips.bicubicLightmap);
			me.ShaderProperty(_IgnoreRealtimeGI, Tips.ignoreRealtimeGIText);
		});
		MGUI.Space8();
	}

	void DoLTCGI(Material mat){
		if (Shader.Find("LTCGI/Blur Prefilter") != null){
			LTCGILayout();
		}
		else {
			_LTCGI.floatValue = 0;
			_LTCGI_DIFFUSE_OFF.floatValue = 0;
			_LTCGI_SPECULAR_OFF.floatValue = 0;
			mat.SetInt("_LTCGI", 0);
			mat.SetInt("_LTCGI_DIFFUSE_OFF", 0);
			mat.SetInt("_LTCGI_SPECULAR_OFF", 0);
			mat.DisableKeyword("LTCGI");
			mat.DisableKeyword("LTCGI_DIFFUSE_OFF");
			mat.DisableKeyword("LTCGI_SPECULAR_OFF");
		}
	}

	void LTCGILayout(){
		MGUI.ShaderPropertyBold(me, _LTCGI, "LTCGI");
		MGUI.ToggleGroup(_LTCGI.floatValue == 0);
		MGUI.PropertyGroup(()=>{
			me.ShaderProperty(_LTCGIStrength, "Strength");
			me.ShaderProperty(_LTCGIRoughness, "Roughness Multiplier");
			me.ShaderProperty(_LTCGI_SPECULAR_OFF, "Disable Specular");
			me.ShaderProperty(_LTCGI_DIFFUSE_OFF, "Disable Diffuse");
		});
		MGUI.ToggleGroupEnd();
		MGUI.Space6();
	}

	void DoAreaLit(Material mat){
		if (Shader.Find("AreaLit/Standard") != null){
			AreaLitLayout();
		}
		else {
			_AreaLitToggle.floatValue = 0f;
			mat.SetInt("_AreaLitToggle", 0);
			mat.DisableKeyword("_AREALIT_ON");
		}
	}

	void CheckTrilinear(Texture tex) {
		if(!tex)
			return;
		if(tex.mipmapCount <= 1) {
			me.HelpBoxWithButton(
				EditorGUIUtility.TrTextContent("Mip maps are required, please enable them in the texture import settings."),
				EditorGUIUtility.TrTextContent("OK"));
			return;
		}
		if(tex.filterMode != FilterMode.Trilinear) {
			if(me.HelpBoxWithButton(
				EditorGUIUtility.TrTextContent("Trilinear filtering is required, and aniso is recommended."),
				EditorGUIUtility.TrTextContent("Fix Now"))) {
				tex.filterMode = FilterMode.Trilinear;
				tex.anisoLevel = 1;
				EditorUtility.SetDirty(tex);
			}
			return;
		}
	}

	void AreaLitLayout(){
		MGUI.ShaderPropertyBold(me, _AreaLitToggle, "AreaLit");
		MGUI.ToggleGroup(_AreaLitToggle.floatValue == 0);
		MGUI.PropertyGroup(()=>{
			MGUI.PropertyGroup(()=>{
				me.ShaderProperty(_AreaLitStrength, "Strength");
				me.ShaderProperty(_AreaLitRoughnessMult, "Roughness Multiplier");
				me.ShaderProperty(_OpaqueLights, Tips.opaqueLightsText);
				me.ShaderProperty(_AreaLitSpecularOcclusion, "Apply Specular Occlusion");
			});
			MGUI.PropertyGroup(()=>{
				var lightMeshText = !_LightMesh.textureValue ? Tips.lightMeshText : new GUIContent(
					Tips.lightMeshText.text + $" (max: {_LightMesh.textureValue.height})", Tips.lightMeshText.tooltip
				);
				me.TexturePropertySingleLine(lightMeshText, _LightMesh);
				me.TexturePropertySingleLine(Tips.lightTex0Text, _LightTex0);
				CheckTrilinear(_LightTex0.textureValue);
				me.TexturePropertySingleLine(Tips.lightTex1Text, _LightTex1);
				CheckTrilinear(_LightTex1.textureValue);
				me.TexturePropertySingleLine(Tips.lightTex2Text, _LightTex2);
				CheckTrilinear(_LightTex2.textureValue);
				me.TexturePropertySingleLine(Tips.lightTex3Text, _LightTex3);
				CheckTrilinear(_LightTex3.textureValue);
				me.TexturePropertySingleLine(new GUIContent("Occlusion"), _AreaLitOcclusion);
				if (_AreaLitOcclusion.textureValue){
					me.ShaderProperty(_AreaLitOcclusionUVSet, "UV Set");
				}
				MGUI.TextureSO(me, _AreaLitOcclusion, _AreaLitOcclusion.textureValue);
			});
			MGUI.DisplayInfo("Note that the AreaLit package files MUST be inside a folder named AreaLit (case sensitive) directly in the Assets folder (Assets/AreaLit)");
			MGUI.ToggleGroupEnd();
		});
		MGUI.Space6();
	}

	void DoDebug(){
		MGUI.ShaderPropertyBold(me, _DebugMode, "Debug");
		MGUI.ToggleGroup(_DebugMode.floatValue == 0);
		MGUI.PropertyGroup(()=>{
			me.ShaderProperty(_DebugVertexColors, "Layer Blending");
			me.ShaderProperty(_DebugBaseColor, "Base Color");
			me.ShaderProperty(_DebugNormals, "Normals");
			me.ShaderProperty(_DebugRoughness, "Roughness");
			me.ShaderProperty(_DebugMetallic, "Metallic");
			me.ShaderProperty(_DebugOcclusion, "Occlusion");
			me.ShaderProperty(_DebugHeight, "Height");
			me.ShaderProperty(_DebugAtten, "Realtime Shadows");
			me.ShaderProperty(_DebugReflections, "Reflections");
			me.ShaderProperty(_DebugSpecular, "Specular Highlights");
			me.ShaderProperty(_DebugRainThreshold, "Rain Angle Mask");
			// me.ShaderProperty(_DebugPuddleThreshold, "Puddle Angle Mask");
		});
		MGUI.ToggleGroupEnd();
	}

	void SetKeywords(Material mat){
		MGUI.SetKeyword(mat, "_REFLECTIONS_ON", mat.GetInt("_ReflectionsToggle") == 1);
		MGUI.SetKeyword(mat, "_SPECULAR_HIGHLIGHTS_ON", mat.GetInt("_SpecularHighlightsToggle") == 1);
		MGUI.SetKeyword(mat, "BAKERY_SH", mat.GetInt("_BakeryMode") == 1);
		MGUI.SetKeyword(mat, "BAKERY_RNM", mat.GetInt("_BakeryMode") == 2);
		MGUI.SetKeyword(mat, "BAKERY_MONOSH", mat.GetInt("_BakeryMode") == 3);
		MGUI.SetKeyword(mat, "_HEIGHT_BLENDING_ON", mat.GetInt("_HeightBlend1") == 1 || mat.GetInt("_HeightBlend2") == 1 || mat.GetInt("_HeightBlend3") == 1);
		MGUI.SetKeyword(mat, "_SSR_ON", mat.GetInt("_SSRToggle") == 1);
	}

	void ApplySSRRenderSettings(Material mat){
		if (_SSRToggle.floatValue == 1){
			mat.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
			mat.SetShaderPassEnabled("Always", true);
			
		}
		else {
			mat.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Geometry;
			mat.SetShaderPassEnabled("Always", false);

		}
	}

	public override void AssignNewShaderToMaterial(Material mat, Shader oldShader, Shader newShader) {
		base.AssignNewShaderToMaterial(mat, oldShader, newShader);
		MGUI.ClearKeywords(mat);
	}
}