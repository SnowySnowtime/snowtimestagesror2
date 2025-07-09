using EntityStates;
using RoR2;
using RoR2.Projectile;
using Snowtime;
using System.Linq;
using UnityEngine;

namespace EntityStates.Snowtime_Error
{
    internal class FireMissingProjectile : BaseState
	{
        public static GameObject projectilePrefab;
        public static GameObject effectPrefab;
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
			//base.PlayAnimation("Gesture", FireMissingProjectile.FireMissingProjectileStateHash, FireMissingProjectile.FireMissingProjectileParamHash, this.duration);
			// Util.PlaySound(FireMissingProjectile.attackString, base.gameObject);
			Ray aimRay = base.GetAimRay();
			string muzzleName = "MuzzleMouth";
			if (FireMissingProjectile.effectPrefab)
			{
				EffectManager.SimpleMuzzleFlash(effectPrefab, base.gameObject, muzzleName, false);
			}
			if (base.isAuthority)
			{
                ProjectileManager.instance.FireProjectileWithoutDamageType(FireMissingProjectile.projectilePrefab, aimRay.origin, Util.QuaternionSafeLookRotation(aimRay.direction), base.gameObject, this.damageStat * FireMissingProjectile.damageCoefficient, FireMissingProjectile.force, Util.CheckRoll(this.critStat, base.characterBody.master), DamageColorIndex.Default, null, -1f);
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
