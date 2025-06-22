Return-Path: <linux-kselftest+bounces-35571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1EAE2F10
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 11:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EBC7A1E9F
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6958F1B4138;
	Sun, 22 Jun 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkMnSn8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437418E1A;
	Sun, 22 Jun 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750584814; cv=none; b=N6uK/royVV1Eu1EFXw1Dwz2gWR1ZsWktH3Msr+wXeBQbuhlmngeAtQ1ayNRMadhDPNTNAvrp9QOdchpQ5Ec5+5iP1N8+OJ1AnY2ozK+f+3JbPU0FvxrAD9xezGumH6tzhT+vKUmqoX9lzb1Ofvy3Py/EmnhCuK6ZcAKS0+OD4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750584814; c=relaxed/simple;
	bh=3Z08jdlIHcA4c+ovnj3MepowoUSoFcvbFQogJV3s/Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH0gh+R/M8PuZhN9voKRzElXHxZVVqgtqi+E71bX0DzYQL1ap8zuYbPxbbGnqLGbNgwjJcXXdKBiHBTCq5EMT35W2ojuB6a+L6ZT9zpySFhlqS/emDf3J/Ye7DBfCcr2IunQZlmGc3fouNOPSGeStq2PNRaWI+Jgg8Cnb7XTDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkMnSn8Y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750584813; x=1782120813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Z08jdlIHcA4c+ovnj3MepowoUSoFcvbFQogJV3s/Wk=;
  b=AkMnSn8YYV6BJnnydZ5Kehktdf7p2EDUIdEmAy7bmp3E44peM1Sk0j+f
   ice2/U9gsg4SEiR8z1Wcq0uSLhQPMYiDM/YYbSYlrAhDNZswqYVdeTLIQ
   AIaDFFY1LzzSZbpXa3E8zVYz334fKlLsnXatNROurSFXxOS6xzKglKpB2
   gOl/C1xAvj4V9aCJF1Icexf7hlOH8aNsZ1nwSoEaLfHI57MSszg3Fe/oh
   0jW7uBfN6aTb6xMFs4m+QbExlt8DVEWemAWFmhZYVfr62HkE5exX4WmU2
   Jyglo3vEODF9FyW6rSsJIB1e9CLc5CZrEl50ZrI4Qok3exGILBrkjdrJ+
   w==;
X-CSE-ConnectionGUID: xH2F776jTau6slBwaFy0FA==
X-CSE-MsgGUID: 4unat7QLTSSx115Utuw7yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="52671248"
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="52671248"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 02:33:32 -0700
X-CSE-ConnectionGUID: 36sjy7DyT/ewbISEKvtofg==
X-CSE-MsgGUID: MBzS2UecQH6f7owpkj2ZqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,256,1744095600"; 
   d="scan'208";a="156810984"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 22 Jun 2025 02:33:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTH4n-000NBI-0H;
	Sun, 22 Jun 2025 09:33:25 +0000
Date: Sun, 22 Jun 2025 17:32:31 +0800
From: kernel test robot <lkp@intel.com>
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH v2 17/23] KVM: arm64: Account for partitioning in
 PMCR_EL0 access
Message-ID: <202506221711.tFNGpzj4-lkp@intel.com>
References: <20250620221326.1261128-19-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620221326.1261128-19-coltonlewis@google.com>

Hi Colton,

kernel test robot noticed the following build errors:

[auto build test ERROR on 79150772457f4d45e38b842d786240c36bb1f97f]

url:    https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20250621-102220
base:   79150772457f4d45e38b842d786240c36bb1f97f
patch link:    https://lore.kernel.org/r/20250620221326.1261128-19-coltonlewis%40google.com
patch subject: [PATCH v2 17/23] KVM: arm64: Account for partitioning in PMCR_EL0 access
config: arm64-randconfig-r073-20250622 (https://download.01.org/0day-ci/archive/20250622/202506221711.tFNGpzj4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250622/202506221711.tFNGpzj4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506221711.tFNGpzj4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/kvm_host.h:32,
                    from include/linux/kvm_host.h:45,
                    from arch/arm64/kvm/sys_regs.c:16:
   arch/arm64/include/asm/kvm_pmu.h:236:50: warning: 'struct arm_pmu' declared inside parameter list will not be visible outside of this definition or declaration
    static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
                                                     ^~~~~~~
   arch/arm64/include/asm/kvm_pmu.h:241:52: warning: 'struct arm_pmu' declared inside parameter list will not be visible outside of this definition or declaration
    static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
                                                       ^~~~~~~
   arch/arm64/include/asm/kvm_pmu.h:246:53: warning: 'struct arm_pmu' declared inside parameter list will not be visible outside of this definition or declaration
    static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
                                                        ^~~~~~~
   arch/arm64/kvm/sys_regs.c:856:6: warning: no previous prototype for 'pmu_access_el0_disabled' [-Wmissing-prototypes]
    bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu)
         ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/sys_regs.c: In function 'access_pmu_evtyper':
   arch/arm64/kvm/sys_regs.c:1076:7: error: implicit declaration of function 'kvm_vcpu_pmu_is_partitioned'; did you mean 'kvm_pmu_is_partitioned'? [-Werror=implicit-function-declaration]
      if (kvm_vcpu_pmu_is_partitioned(vcpu))
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
          kvm_pmu_is_partitioned
   arch/arm64/kvm/sys_regs.c: In function 'set_pmcr':
>> arch/arm64/kvm/sys_regs.c:1271:33: error: dereferencing pointer to incomplete type 'struct arm_pmu'
          new_n <= kvm->arch.arm_pmu->hpmn_max))
                                    ^~
   cc1: some warnings being treated as errors


vim +1271 arch/arm64/kvm/sys_regs.c

  1253	
  1254	static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
  1255			    u64 val)
  1256	{
  1257		u8 new_n = FIELD_GET(ARMV8_PMU_PMCR_N, val);
  1258		struct kvm *kvm = vcpu->kvm;
  1259	
  1260		mutex_lock(&kvm->arch.config_lock);
  1261	
  1262		/*
  1263		 * The vCPU can't have more counters than the PMU hardware
  1264		 * implements. Ignore this error to maintain compatibility
  1265		 * with the existing KVM behavior.
  1266		 */
  1267		if (!kvm_vm_has_ran_once(kvm) &&
  1268		    !vcpu_has_nv(vcpu)	      &&
  1269		    new_n <= kvm_arm_pmu_get_max_counters(kvm) &&
  1270		    (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
> 1271		     new_n <= kvm->arch.arm_pmu->hpmn_max))
  1272			kvm->arch.nr_pmu_counters = new_n;
  1273	
  1274		mutex_unlock(&kvm->arch.config_lock);
  1275	
  1276		/*
  1277		 * Ignore writes to RES0 bits, read only bits that are cleared on
  1278		 * vCPU reset, and writable bits that KVM doesn't support yet.
  1279		 * (i.e. only PMCR.N and bits [7:0] are mutable from userspace)
  1280		 * The LP bit is RES0 when FEAT_PMUv3p5 is not supported on the vCPU.
  1281		 * But, we leave the bit as it is here, as the vCPU's PMUver might
  1282		 * be changed later (NOTE: the bit will be cleared on first vCPU run
  1283		 * if necessary).
  1284		 */
  1285		val &= ARMV8_PMU_PMCR_MASK;
  1286	
  1287		/* The LC bit is RES1 when AArch32 is not supported */
  1288		if (!kvm_supports_32bit_el0())
  1289			val |= ARMV8_PMU_PMCR_LC;
  1290	
  1291		__vcpu_assign_sys_reg(vcpu, r->reg, val);
  1292		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
  1293	
  1294		return 0;
  1295	}
  1296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

