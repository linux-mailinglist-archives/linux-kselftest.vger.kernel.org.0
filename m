Return-Path: <linux-kselftest+bounces-47369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CCECB3C41
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 128F33043F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398B2FD665;
	Wed, 10 Dec 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jy1rgSyC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6F225403;
	Wed, 10 Dec 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391512; cv=none; b=FZJggwn19I+0CFnsSUMlBeuC1CX5lrHl/ZD41K8q00aLtErXYui1/ypW/wSfzY3hbkopsQz+SzVfdjPjCXdt+2w7BDLLlT/HFkXVJz9bXlqTObOgBIli/DSPfTjI4opGhiH/vYOaRObI5oTRQAnjrLmtptd/QETCp6zYhB/DICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391512; c=relaxed/simple;
	bh=VNHdDxfKQZYeoMNw23AefvwVyxFS9n8FzpKeC+FIJog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLPchjzDd/e0VG7wYV7Mxi8+VPl19Z5yTOw+yUGq0E3eADZCVBot/0OeKfC6PtSG47mLsFKHEHaVRZJ84l1rQ7e+5CWuJJejm275xd9ix7cKF1AJ2UMRsZ8Ddy1lETlh7zhIgFkeQk8aLxOM5TJhipJs9xDj+1f6lCfsJcxf+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jy1rgSyC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765391511; x=1796927511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VNHdDxfKQZYeoMNw23AefvwVyxFS9n8FzpKeC+FIJog=;
  b=Jy1rgSyCZha4H1BTf9dwUO0uL/kNooxr8ZRvRF+HzlUpTtHl35A6t5/9
   LifIO3wxJWr45nL9tNgs/vhTvYBGHCWEcDSiFmtmdR4DttnR06Um+kgiG
   PSOimi40/50qAisQbvuUWb3rehkRgKHVnZ90L5J+h3rYues8H0Ewr+WjO
   HKOMlV5HM8oYgS3lbes8iG4VNy03IOfAL21rKHeeBrqLA3Wa+Qum+9DIG
   PZon80T7Z64KBffV2ZUgYZnYmG+Czg9W1BON9zr1UdoTjiwfL8WtHKu84
   u6lFTToC9ZqxXhOwVsIvSg0Z9fKx28lcGeT1kXqe7GvRAu4CuoaDFyx2P
   Q==;
X-CSE-ConnectionGUID: HmTV0pyNRjCVD0hKNgbcHg==
X-CSE-MsgGUID: 0w/+hcOyTUC3kFBEU+pbBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="92847894"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="92847894"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 10:31:50 -0800
X-CSE-ConnectionGUID: sjzEvg3oQTG3/3GQD9wleA==
X-CSE-MsgGUID: hyVtDifxTlaUirZgxJqxuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="196647077"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Dec 2025 10:31:45 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTOyU-000000003dR-1S1d;
	Wed, 10 Dec 2025 18:31:42 +0000
Date: Thu, 11 Dec 2025 02:31:00 +0800
From: kernel test robot <lkp@intel.com>
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH v5 11/24] KVM: arm64: Writethrough trapped PMEVTYPER
 register
Message-ID: <202512110209.GjVZa9ti-lkp@intel.com>
References: <20251209205121.1871534-12-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-12-coltonlewis@google.com>

Hi Colton,

kernel test robot noticed the following build errors:

[auto build test ERROR on ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d]

url:    https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20251210-055309
base:   ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
patch link:    https://lore.kernel.org/r/20251209205121.1871534-12-coltonlewis%40google.com
patch subject: [PATCH v5 11/24] KVM: arm64: Writethrough trapped PMEVTYPER register
config: arm64-randconfig-001-20251210 (https://download.01.org/0day-ci/archive/20251211/202512110209.GjVZa9ti-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512110209.GjVZa9ti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512110209.GjVZa9ti-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kvm/sys_regs.c: In function 'writethrough_pmevtyper':
>> arch/arm64/kvm/sys_regs.c:1183:34: error: implicit declaration of function 'kvm_pmu_event_mask'; did you mean 'kvm_pmu_evtyper_mask'? [-Wimplicit-function-declaration]
    1183 |                 eventsel = val & kvm_pmu_event_mask(vcpu->kvm);
         |                                  ^~~~~~~~~~~~~~~~~~
         |                                  kvm_pmu_evtyper_mask


vim +1183 arch/arm64/kvm/sys_regs.c

  1168	
  1169	static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
  1170					   u64 reg, u64 idx)
  1171	{
  1172		u64 eventsel;
  1173		u64 val = p->regval;
  1174		u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
  1175			ARMV8_PMU_EXCLUDE_EL1;
  1176		u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
  1177	
  1178		__vcpu_assign_sys_reg(vcpu, reg, val);
  1179	
  1180		if (idx == ARMV8_PMU_CYCLE_IDX)
  1181			eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
  1182		else
> 1183			eventsel = val & kvm_pmu_event_mask(vcpu->kvm);
  1184	
  1185		if (vcpu->kvm->arch.pmu_filter &&
  1186		    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
  1187			val |= evtyper_set;
  1188	
  1189		val &= ~evtyper_clr;
  1190	
  1191		if (idx == ARMV8_PMU_CYCLE_IDX)
  1192			write_pmccfiltr(val);
  1193		else
  1194			write_pmevtypern(idx, val);
  1195	
  1196		return true;
  1197	}
  1198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

