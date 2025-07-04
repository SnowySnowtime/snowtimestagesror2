using EntityStates;
using RoR2;
using RoR2.Projectile;
using System.Linq;
using UnityEngine;

namespace EntityStates.Snowtime_Error
{
	public class FireMissingProjectile : BaseState
	{
		public static GameObject projectilePrefab = Resources.Load<GameObject>("SnowtimeStages/Characters/NewCharacterTest/Skills/MissingBall");
		public static GameObject effectPrefab = Resources.Load<GameObject>("SnowtimeStages/Characters/NewCharacterTest/Skills/MissingFlash");
		public static float baseDuration = 1f;
		public static float damageCoefficient = 1f;
		public static float force = 20f;
		public static string attackString;
		private float duration;
		private static int FireMissingProjectileStateHash = Animator.StringToHash("FireMissingProjectile");
		private static int FireMissingProjectileParamHash = Animator.StringToHash("FireMissingProjectile.playbackRate");
		
		public override void OnEnter()
		{
			base.OnEnter();
			this.duration = FireMissingProjectile.baseDuration / this.attackSpeedStat;
			base.PlayAnimation("Gesture", FireMissingProjectile.FireMissingProjectileStateHash, FireMissingProjectile.FireMissingProjectileParamHash, this.duration);
			// Util.PlaySound(FireMissingProjectile.attackString, base.gameObject);
			Ray aimRay = base.GetAimRay();
			string muzzleName = "MuzzleMouth";
			if (FireMissingProjectile.effectPrefab)
			{
				EffectManager.SimpleMuzzleFlash(effectPrefab, base.gameObject, muzzleName, false);
			}
			if (base.isAuthority)
			{
				FireProjectileInfo fireProjectileInfo = default(FireProjectileInfo);
				fireProjectileInfo.projectilePrefab = Resources.Load<GameObject>("SnowtimeStages/Characters/NewCharacterTest/Skills/MissingBall");
				fireProjectileInfo.position = aimRay.origin;
				fireProjectileInfo.rotation = Util.QuaternionSafeLookRotation(aimRay.direction);
				fireProjectileInfo.owner = base.gameObject;
				fireProjectileInfo.damage = damageStat * damageCoefficient;
				fireProjectileInfo.force = 0;
				fireProjectileInfo.crit = RollCrit();
				DamageTypeCombo damageType = DamageType.Generic;
				damageType.damageSource = DamageSource.Primary;
				fireProjectileInfo.damageTypeOverride = damageType;
				ProjectileManager.instance.FireProjectile(fireProjectileInfo);
			}
		}

		public override void OnExit()
		{
			base.OnExit();
		}

		public override void FixedUpdate()
		{
			base.FixedUpdate();
			if (base.fixedAge >= this.duration && base.isAuthority)
			{
				this.outer.SetNextStateToMain();
				return;
			}
		}

		public override InterruptPriority GetMinimumInterruptPriority()
		{
			return InterruptPriority.Skill;
		}
	}
}
