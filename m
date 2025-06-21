Return-Path: <linux-kselftest+bounces-35541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1CAE29A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594A01782D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0F2036FF;
	Sat, 21 Jun 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avEzWE8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1D191F92;
	Sat, 21 Jun 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517830; cv=none; b=ag+ihMK5Rq+YnhpvzECQDjq4zloz4xEau1O+y5sArOPn4GBqGg3BP7N8PIVEZD6Uu/ZJOunxVW4fJ0StXVlEd6kG0PzwoybqXZSL0nvtAUNEI+gjYIBEEwjk5JUxJXVg8KxZS9V1GH6AMW3SUyUXMbKHLaN/6w/wCq/+ISclZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517830; c=relaxed/simple;
	bh=X3vV+eJu0dvr53qzXk4iuxmihuUGtVvgs8eqeDhJh9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F248+gEPQKpGiV2L+DqW9i9KD+yZvmi3h+UfpsApBM3kX+TE9MqwjMdxJ2QDp9GSeb5mkJmZBJMzAmOfkDw3dm/ECc54lN98+MmvbaVJLZiJNyJyxx3bgsUdx52Tq0fosXyrrEBq9+cbng7c1Bj1abcavE+7ZosMmO2EjQ0FTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avEzWE8R; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750517828; x=1782053828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3vV+eJu0dvr53qzXk4iuxmihuUGtVvgs8eqeDhJh9o=;
  b=avEzWE8RhpejSpMIpCWpVkjD0JbKnxovumBr1tjd7BYDDjfU6RmyNo9m
   PdBlIjpJit0BF+IHGVFTiOs9aOq+kXPK7v+XIBILwrP7QZ+NDIPtoiOJ8
   CQWLUjPFQFoyRfTd3bn1Wmet87vdy1Q2Ui5UrQa0C9s454ADmpJ41a0vl
   N5+/ig3kiI6PzHXZgZQCPkZy0JNV0EuA8xr77dPS5HbMQhRmYIQbfn/zn
   u2jU11k/MJiIDPCx2UHGE+RwccqIIXY611uyidrP9twzDZL8N0qeeSE+h
   cs2+B2KdivzR24zElJKdR7Ax8q60ugvvZ5r92X8g6kv5NvY0MiTobU7rh
   g==;
X-CSE-ConnectionGUID: ZhV+KK3qSZCHtUlYC7brAg==
X-CSE-MsgGUID: Cz8jn5/CRsejbLnxeGQ8QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="52697053"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="52697053"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 07:57:07 -0700
X-CSE-ConnectionGUID: /ElNxIjAQAOkdsx+BhBW4w==
X-CSE-MsgGUID: YjlOm5efQmS2CH7jY5cacw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155720770"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Jun 2025 07:57:03 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSzeN-000MgQ-2S;
	Sat, 21 Jun 2025 14:56:59 +0000
Date: Sat, 21 Jun 2025 22:56:09 +0800
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
Subject: Re: [PATCH v2 05/23] KVM: arm64: Cleanup PMU includes
Message-ID: <202506212205.NmAR3sAH-lkp@intel.com>
References: <20250620221326.1261128-6-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620221326.1261128-6-coltonlewis@google.com>

Hi Colton,

kernel test robot noticed the following build errors:

[auto build test ERROR on 79150772457f4d45e38b842d786240c36bb1f97f]

url:    https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20250621-102220
base:   79150772457f4d45e38b842d786240c36bb1f97f
patch link:    https://lore.kernel.org/r/20250620221326.1261128-6-coltonlewis%40google.com
patch subject: [PATCH v2 05/23] KVM: arm64: Cleanup PMU includes
config: arm64-randconfig-004-20250621 (https://download.01.org/0day-ci/archive/20250621/202506212205.NmAR3sAH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250621/202506212205.NmAR3sAH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506212205.NmAR3sAH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/perf/arm_pmuv3.c:143:41: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD'
     143 |  [C(L1D)][C(OP_READ)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:123:45: warning: initialized field overwritten [-Woverride-init]
     123 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR   0x0041
         |                                             ^~~~~~
   drivers/perf/arm_pmuv3.c:144:44: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR'
     144 |  [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:123:45: note: (near initialization for 'armv8_vulcan_perf_cache_map[0][1][0]')
     123 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR   0x0041
         |                                             ^~~~~~
   drivers/perf/arm_pmuv3.c:144:44: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR'
     144 |  [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:125:51: warning: initialized field overwritten [-Woverride-init]
     125 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR  0x0043
         |                                                   ^~~~~~
   drivers/perf/arm_pmuv3.c:145:42: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR'
     145 |  [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:125:51: note: (near initialization for 'armv8_vulcan_perf_cache_map[0][1][1]')
     125 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR  0x0043
         |                                                   ^~~~~~
   drivers/perf/arm_pmuv3.c:145:42: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR'
     145 |  [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:44: warning: initialized field overwritten [-Woverride-init]
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD    0x004E
         |                                            ^~~~~~
   drivers/perf/arm_pmuv3.c:147:44: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     147 |  [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:44: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][0][0]')
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD    0x004E
         |                                            ^~~~~~
   drivers/perf/arm_pmuv3.c:147:44: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     147 |  [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:135:44: warning: initialized field overwritten [-Woverride-init]
     135 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR    0x004F
         |                                            ^~~~~~
   drivers/perf/arm_pmuv3.c:148:45: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     148 |  [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:135:44: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][1][0]')
     135 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR    0x004F
         |                                            ^~~~~~
   drivers/perf/arm_pmuv3.c:148:45: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     148 |  [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:50: warning: initialized field overwritten [-Woverride-init]
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD   0x004C
         |                                                  ^~~~~~
   drivers/perf/arm_pmuv3.c:149:42: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     149 |  [C(DTLB)][C(OP_READ)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:50: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][0][1]')
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD   0x004C
         |                                                  ^~~~~~
   drivers/perf/arm_pmuv3.c:149:42: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     149 |  [C(DTLB)][C(OP_READ)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:50: warning: initialized field overwritten [-Woverride-init]
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR   0x004D
         |                                                  ^~~~~~
   drivers/perf/arm_pmuv3.c:150:43: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     150 |  [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:50: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][1][1]')
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR   0x004D
         |                                                  ^~~~~~
   drivers/perf/arm_pmuv3.c:150:43: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     150 |  [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:46: warning: initialized field overwritten [-Woverride-init]
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD   0x0060
         |                                              ^~~~~~
   drivers/perf/arm_pmuv3.c:152:44: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     152 |  [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:46: note: (near initialization for 'armv8_vulcan_perf_cache_map[6][0][0]')
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD   0x0060
         |                                              ^~~~~~
   drivers/perf/arm_pmuv3.c:152:44: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     152 |  [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:150:46: warning: initialized field overwritten [-Woverride-init]
     150 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR   0x0061
         |                                              ^~~~~~
   drivers/perf/arm_pmuv3.c:153:45: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     153 |  [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:150:46: note: (near initialization for 'armv8_vulcan_perf_cache_map[6][1][0]')
     150 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR   0x0061
         |                                              ^~~~~~
   drivers/perf/arm_pmuv3.c:153:45: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     153 |  [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmuv3.c: In function 'armv8pmu_enable_event_counter':
>> drivers/perf/arm_pmuv3.c:680:2: error: implicit declaration of function 'kvm_set_pmu_events' [-Werror=implicit-function-declaration]
     680 |  kvm_set_pmu_events(mask, attr);
         |  ^~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmuv3.c: In function 'armv8pmu_disable_event_counter':
>> drivers/perf/arm_pmuv3.c:702:2: error: implicit declaration of function 'kvm_clr_pmu_events' [-Werror=implicit-function-declaration]
     702 |  kvm_clr_pmu_events(mask);
         |  ^~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmuv3.c: In function 'update_pmuserenr':
>> drivers/perf/arm_pmuv3.c:757:6: error: implicit declaration of function 'kvm_set_pmuserenr' [-Werror=implicit-function-declaration]
     757 |  if (kvm_set_pmuserenr(val))
         |      ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kvm_set_pmu_events +680 drivers/perf/arm_pmuv3.c

030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  674  
9343c790e6de7e drivers/perf/arm_pmuv3.c       James Clark       2023-12-11  675  static void armv8pmu_enable_event_counter(struct perf_event *event)
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  676  {
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  677  	struct perf_event_attr *attr = &event->attr;
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  678) 	u64 mask = armv8pmu_event_cnten_mask(event);
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  679  
29227d6ea1572b arch/arm64/kernel/perf_event.c Robin Murphy      2020-03-17 @680  	kvm_set_pmu_events(mask, attr);
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  681  
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  682  	/* We rely on the hypervisor switch code to enable guest counters */
29227d6ea1572b arch/arm64/kernel/perf_event.c Robin Murphy      2020-03-17  683  	if (!kvm_pmu_counter_deferred(attr))
29227d6ea1572b arch/arm64/kernel/perf_event.c Robin Murphy      2020-03-17  684  		armv8pmu_enable_counter(mask);
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  685  }
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  686  
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  687) static void armv8pmu_disable_counter(u64 mask)
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  688  {
df29ddf4f04b00 drivers/perf/arm_pmuv3.c       Marc Zyngier      2023-03-17  689  	write_pmcntenclr(mask);
0fdf1bb75953a6 arch/arm64/kernel/perf_event.c Mark Rutland      2020-09-24  690  	/*
0fdf1bb75953a6 arch/arm64/kernel/perf_event.c Mark Rutland      2020-09-24  691  	 * Make sure the effects of disabling the counter are visible before we
0fdf1bb75953a6 arch/arm64/kernel/perf_event.c Mark Rutland      2020-09-24  692  	 * start configuring the event.
0fdf1bb75953a6 arch/arm64/kernel/perf_event.c Mark Rutland      2020-09-24  693  	 */
0fdf1bb75953a6 arch/arm64/kernel/perf_event.c Mark Rutland      2020-09-24  694  	isb();
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  695  }
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  696  
9343c790e6de7e drivers/perf/arm_pmuv3.c       James Clark       2023-12-11  697  static void armv8pmu_disable_event_counter(struct perf_event *event)
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  698  {
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  699  	struct perf_event_attr *attr = &event->attr;
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  700) 	u64 mask = armv8pmu_event_cnten_mask(event);
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  701  
29227d6ea1572b arch/arm64/kernel/perf_event.c Robin Murphy      2020-03-17 @702  	kvm_clr_pmu_events(mask);
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  703  
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  704  	/* We rely on the hypervisor switch code to disable guest counters */
29227d6ea1572b arch/arm64/kernel/perf_event.c Robin Murphy      2020-03-17  705  	if (!kvm_pmu_counter_deferred(attr))
29227d6ea1572b arch/arm64/kernel/perf_event.c Robin Murphy      2020-03-17  706  		armv8pmu_disable_counter(mask);
d1947bc4bc63e5 arch/arm64/kernel/perf_event.c Andrew Murray     2019-04-09  707  }
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  708  
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  709) static void armv8pmu_enable_intens(u64 mask)
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  710  {
df29ddf4f04b00 drivers/perf/arm_pmuv3.c       Marc Zyngier      2023-03-17  711  	write_pmintenset(mask);
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  712  }
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  713  
9343c790e6de7e drivers/perf/arm_pmuv3.c       James Clark       2023-12-11  714  static void armv8pmu_enable_event_irq(struct perf_event *event)
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  715  {
bf5ffc8c80e0cf drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  716) 	armv8pmu_enable_intens(BIT(event->hw.idx));
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  717  }
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  718  
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  719) static void armv8pmu_disable_intens(u64 mask)
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  720  {
df29ddf4f04b00 drivers/perf/arm_pmuv3.c       Marc Zyngier      2023-03-17  721  	write_pmintenclr(mask);
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  722  	isb();
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  723  	/* Clear the overflow flag in case an interrupt is pending. */
df29ddf4f04b00 drivers/perf/arm_pmuv3.c       Marc Zyngier      2023-03-17  724  	write_pmovsclr(mask);
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  725  	isb();
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  726  }
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  727  
9343c790e6de7e drivers/perf/arm_pmuv3.c       James Clark       2023-12-11  728  static void armv8pmu_disable_event_irq(struct perf_event *event)
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  729  {
bf5ffc8c80e0cf drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  730) 	armv8pmu_disable_intens(BIT(event->hw.idx));
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  731  }
c13207905340d8 arch/arm64/kernel/perf_event.c Suzuki K Poulose  2018-07-10  732  
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  733) static u64 armv8pmu_getreset_flags(void)
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  734  {
a4a6e2078d85a9 drivers/perf/arm_pmuv3.c       Rob Herring (Arm  2024-07-31  735) 	u64 value;
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  736  
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  737  	/* Read */
df29ddf4f04b00 drivers/perf/arm_pmuv3.c       Marc Zyngier      2023-03-17  738  	value = read_pmovsclr();
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  739  
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  740  	/* Write to clear flags */
d30f09b6d7de5d drivers/perf/arm_pmuv3.c       James Clark       2023-12-11  741  	value &= ARMV8_PMU_OVERFLOWED_MASK;
df29ddf4f04b00 drivers/perf/arm_pmuv3.c       Marc Zyngier      2023-03-17  742  	write_pmovsclr(value);
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  743  
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  744  	return value;
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  745  }
030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon       2012-03-05  746  
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  747  static void update_pmuserenr(u64 val)
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  748  {
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  749  	lockdep_assert_irqs_disabled();
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  750  
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  751  	/*
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  752  	 * The current PMUSERENR_EL0 value might be the value for the guest.
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  753  	 * If that's the case, have KVM keep tracking of the register value
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  754  	 * for the host EL0 so that KVM can restore it before returning to
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  755  	 * the host EL0. Otherwise, update the register now.
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  756  	 */
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02 @757  	if (kvm_set_pmuserenr(val))
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  758  		return;
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  759  
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  760  	write_pmuserenr(val);
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  761  }
0c2f9acf6ae741 drivers/perf/arm_pmuv3.c       Reiji Watanabe    2023-06-02  762  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

