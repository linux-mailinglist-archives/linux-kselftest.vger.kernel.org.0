Return-Path: <linux-kselftest+bounces-37372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17492B0653E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196B23B6514
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD798283FCF;
	Tue, 15 Jul 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFGrH+vh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562626B76D;
	Tue, 15 Jul 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601044; cv=none; b=NgWmTOQSAsqe02MLMOUVVCST6+3qqjr7NhunMPpUm9jzuGDKIKJ7fdONNV8UGMvrNATY6HInOgetsAMTyS5STRDaEeIg4qH3mfwRmkTBtzEBWrWVi6RaF1fU2hMdeGoPbi1JmeH3cvWKKdVD1ZCHrzdiCskivL2Ku13dTZCT+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601044; c=relaxed/simple;
	bh=LCQcMxbE4qBoe+rmXlWppTEdGOzkpPs9FBZLfSoELDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjC8DQ4rjL9XzOBsjvk9vqu6qyMCDO8ijdzg+cmrguLsblLv87fZOQa6A5cnZwWAMQ64oXatrKwcclBjyP+IFxoqnLRQ5HVCBv7kGwiQ/4w/fDQ9V1WRgvDxirGIDCkTpH6Ofw6gdpWa8XtHdcCQ5CcQN6YRQC83UWX/e5x0r2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFGrH+vh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752601041; x=1784137041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LCQcMxbE4qBoe+rmXlWppTEdGOzkpPs9FBZLfSoELDY=;
  b=lFGrH+vhVRPsSFcgrWjXLI9+AZKq0EWGf+hET3r1ogiqNirg27LZJcup
   kMD9c4AFyA+liUq1vQFM+yqdQiTCvz161jzRRPsZh3z7qlMB28qWYnG5Y
   3mWWzsdgf1k3XVJf62qIksh20RIUVI0UraVJbOEwpPUNvoIFRXz5eIK3Q
   NUrrJgRTpeo8uXu4URAdj23Cs1od7k58PV2OGui/03hp/Txs5GFUjZdrm
   UcvZGSCFsC2km8/jT7UNhzZ7KyvPoxiyJ3SFza4qerzam+qpQYTyJJGhm
   pSBz9/pn8DwVLU+Z4dtLM1qJjHwir1jn2KIHixh3nlNAb49F6pbtwsJUM
   w==;
X-CSE-ConnectionGUID: pVtPys80TKenHg4/eDMrVQ==
X-CSE-MsgGUID: D+6qLha1QbioTt8PK1VelA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65898671"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="65898671"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:37:19 -0700
X-CSE-ConnectionGUID: AA0ida7UQd2O1yQHkyYcvg==
X-CSE-MsgGUID: uSnHo+YET2i/aYux139fjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="188290194"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jul 2025 10:37:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubjab-000BOL-1c;
	Tue, 15 Jul 2025 17:37:13 +0000
Date: Wed, 16 Jul 2025 01:36:41 +0800
From: kernel test robot <lkp@intel.com>
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH v4 22/23] KVM: arm64: Add ioctl to partition the PMU when
 supported
Message-ID: <202507160120.lx4XxDb5-lkp@intel.com>
References: <20250714225917.1396543-23-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714225917.1396543-23-coltonlewis@google.com>

Hi Colton,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 79150772457f4d45e38b842d786240c36bb1f97f]

url:    https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20250715-070741
base:   79150772457f4d45e38b842d786240c36bb1f97f
patch link:    https://lore.kernel.org/r/20250714225917.1396543-23-coltonlewis%40google.com
patch subject: [PATCH v4 22/23] KVM: arm64: Add ioctl to partition the PMU when supported
config: arm64-randconfig-001-20250715 (https://download.01.org/0day-ci/archive/20250716/202507160120.lx4XxDb5-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160120.lx4XxDb5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160120.lx4XxDb5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:15:
   In file included from include/linux/kvm_host.h:45:
   In file included from arch/arm64/include/asm/kvm_host.h:31:
>> arch/arm64/include/asm/kvm_pmu.h:301:49: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline bool kvm_pmu_is_partitioned(void *)
                                                   ^
   arch/arm64/include/asm/kvm_pmu.h:306:51: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline u64 kvm_pmu_host_counter_mask(void *)
                                                     ^
   arch/arm64/include/asm/kvm_pmu.h:311:52: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline u64 kvm_pmu_guest_counter_mask(void *)
                                                      ^
   3 warnings generated.
--
   In file included from arch/arm64/kernel/asm-offsets.c:15:
   In file included from include/linux/kvm_host.h:45:
   In file included from arch/arm64/include/asm/kvm_host.h:31:
>> arch/arm64/include/asm/kvm_pmu.h:301:49: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline bool kvm_pmu_is_partitioned(void *)
                                                   ^
   arch/arm64/include/asm/kvm_pmu.h:306:51: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline u64 kvm_pmu_host_counter_mask(void *)
                                                     ^
   arch/arm64/include/asm/kvm_pmu.h:311:52: warning: omitting the parameter name in a function definition is a C2x extension [-Wc2x-extensions]
   static inline u64 kvm_pmu_guest_counter_mask(void *)
                                                      ^
   3 warnings generated.


vim +301 arch/arm64/include/asm/kvm_pmu.h

   300	
 > 301	static inline bool kvm_pmu_is_partitioned(void *)
   302	{
   303		return false;
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

