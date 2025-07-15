Return-Path: <linux-kselftest+bounces-37370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2FB0651B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D2B3A9EA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D492853F8;
	Tue, 15 Jul 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASIAXXDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58F284689;
	Tue, 15 Jul 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600443; cv=none; b=JROvAwj/GZgW8H74E9CqbMy0REx7U01A9nX9SVEJO9jf8xh/EklU2uKIM0HnyHZN194Q6BldFocPH2f8F2351x5MucXOD4GQ6sOKR6gliAwCCOsNJAC+vLgzk5/C+poW7sh7pfRS5P9xsZUW+5QVveKqiwb0UVhpUX+gaATccms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600443; c=relaxed/simple;
	bh=ovPKG96PX8GRLMCJnscYphDbflIJz5ol2cbrtMEYKMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBF9xyu4KnzrVCKIQJmq4gLyX5BJY9se5kwu0ORlE3/Jg+9DZhE0IDk5aKPMCnVF8kW2sri1h8ll5Q/hXPra5JBDT+URJ/qEgvgTdVXQkcd2h54Vkr7FQuilII3SQsI5uk3BdqlCc8bEJt9e08sWkUMFJ0XzJ3VQsjygO0/15mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASIAXXDf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752600442; x=1784136442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovPKG96PX8GRLMCJnscYphDbflIJz5ol2cbrtMEYKMU=;
  b=ASIAXXDfR4dIAnnBg1lb50ru05ofyavLYWbf6KaHN66add6mxTtUP/JS
   mKlIp9qTSfCeFoPFSbkc3JhHGsdhDwjDJ/MrYF9MKhHwbqrCiW9OgFgFb
   QWjMYaqaxbhrZj/3BXU3ks0eJEK34QthKDb5yJ5YMr+27jNm+WMg2ZbZf
   dRTdtjF5eifaDsv1GH993YRmZleTwrwAf3+4/UnOQ1FTCOnSX6EOS/Q1B
   TD95Ce1lT1Ggdhg5m5bACj1Nc5NpTuSAfFn2YkWQ6/xK5XGJCfTt8N6zY
   fa6x70wBE2l/OTk1YF8ogn/pTHtV7BK4exJRG1LfOb0V4ksmD28pdoe9k
   w==;
X-CSE-ConnectionGUID: 1r2pG4xBQnOcaVNyE0RhcQ==
X-CSE-MsgGUID: VEMgzlk4RGShVg/1DTgXKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54048313"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54048313"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:27:21 -0700
X-CSE-ConnectionGUID: dJg+dbpVQYq+HakiiLMIUQ==
X-CSE-MsgGUID: kn5/sUpZQIa1Yvs1bCgxAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161605026"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Jul 2025 10:27:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubjQu-000BNn-1v;
	Tue, 15 Jul 2025 17:27:12 +0000
Date: Wed, 16 Jul 2025 01:26:23 +0800
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
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH v4 22/23] KVM: arm64: Add ioctl to partition the PMU when
 supported
Message-ID: <202507160129.vrvWpdVu-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 79150772457f4d45e38b842d786240c36bb1f97f]

url:    https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20250715-070741
base:   79150772457f4d45e38b842d786240c36bb1f97f
patch link:    https://lore.kernel.org/r/20250714225917.1396543-23-coltonlewis%40google.com
patch subject: [PATCH v4 22/23] KVM: arm64: Add ioctl to partition the PMU when supported
config: arm64-randconfig-003-20250715 (https://download.01.org/0day-ci/archive/20250716/202507160129.vrvWpdVu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160129.vrvWpdVu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160129.vrvWpdVu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/kvm_host.h:31,
                    from include/linux/kvm_host.h:45,
                    from arch/arm64/kernel/asm-offsets.c:15:
   arch/arm64/include/asm/kvm_pmu.h: In function 'kvm_pmu_is_partitioned':
>> arch/arm64/include/asm/kvm_pmu.h:301:43: error: parameter name omitted
    static inline bool kvm_pmu_is_partitioned(void *)
                                              ^~~~~~
   arch/arm64/include/asm/kvm_pmu.h: In function 'kvm_pmu_host_counter_mask':
   arch/arm64/include/asm/kvm_pmu.h:306:45: error: parameter name omitted
    static inline u64 kvm_pmu_host_counter_mask(void *)
                                                ^~~~~~
   arch/arm64/include/asm/kvm_pmu.h: In function 'kvm_pmu_guest_counter_mask':
   arch/arm64/include/asm/kvm_pmu.h:311:46: error: parameter name omitted
    static inline u64 kvm_pmu_guest_counter_mask(void *)
                                                 ^~~~~~
   make[3]: *** [scripts/Makefile.build:182: arch/arm64/kernel/asm-offsets.s] Error 1 shuffle=21662191
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1274: prepare0] Error 2 shuffle=21662191
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=21662191
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=21662191
   make: Target 'prepare' not remade because of errors.


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

