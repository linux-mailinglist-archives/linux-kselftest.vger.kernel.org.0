Return-Path: <linux-kselftest+bounces-47372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D3CB3F1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 126F530117B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AA32BF22;
	Wed, 10 Dec 2025 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5eG4Aqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436743271E6;
	Wed, 10 Dec 2025 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398180; cv=none; b=QvLHWaf9mNxmBUidc9E2/HO+SZ3QXGJQ6Za4nIbxvBdmCxWpYcOqlsVn8fsYRKoNb4G4jjAmv1G1nJJJMyAlglj/gv+DcbzD4OoZSlimrw8rDF7yX2sQovIecXU+uLCAL3PL3CnqMIb8DN3h/gfxw+LEB66rU/f372MZW+FxRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398180; c=relaxed/simple;
	bh=RxEHatHQ0Qy/ChtgEVQnw0Bex/SyCFO2r36FHfM3As0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzdXvcIFQaH5Vu5Qmqlaq0AiFjlBotxz2P9VLF0c0oPzf5EGiYWIIQVkr3S0oZiwKstfSTtE89bYL5QX641t3tROBiISwb0L+xKeMVw6fRbT8QeWiSDn4XbPFEQnMxHTHslwkXS34Nfk9VkpFxzqWeSZSP/DcBKfUwS0DQECgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5eG4Aqg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765398179; x=1796934179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RxEHatHQ0Qy/ChtgEVQnw0Bex/SyCFO2r36FHfM3As0=;
  b=k5eG4AqgJ2aBUrQBA7NkKCAPG3PyIxJmUotlw/JYwEvOpSqGyZ3jwkwK
   0JoH/zhqlvbCOTWdYZEac85GdXR2XlZOqsTc1Bxf8tIY7RKNdoRK2d92A
   Y1/6BNFq3wliuxQ+hzNGdibDFFlgqFhhq5E4RAkZy3/KlQZiTapmcDgrv
   7+VlQYfJnB6Wfr483Flcf6bvCybIx67vicgQz0OegjdJiGaQtu4H1NTqM
   j7/saeSy/mgdFD0V6RgTcxlOaITSV6Xzcukp59ZJ9tGWTKr8pxfYjBUCg
   m+CKzpxr44sp9o9xHVQ8jDcqEatKWEIZFS+Ff1PxbXAG4CZephvllZo+3
   Q==;
X-CSE-ConnectionGUID: CA9+IsSiRISpGGwsflqdEA==
X-CSE-MsgGUID: NeMt5UMAQ5anj7lo5xOkfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78846115"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="78846115"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 12:22:58 -0800
X-CSE-ConnectionGUID: cQOMJWuWSbOlJRB/Ih9UEQ==
X-CSE-MsgGUID: bTPfKaUBSC2wiNq3JOclMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="195684982"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Dec 2025 12:22:52 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTQi1-000000003j7-3dyl;
	Wed, 10 Dec 2025 20:22:49 +0000
Date: Thu, 11 Dec 2025 04:21:58 +0800
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
Subject: Re: [PATCH v5 09/24] perf: arm_pmuv3: Keep out of guest counter
 partition
Message-ID: <202512110439.UXwb1Qh4-lkp@intel.com>
References: <20251209205121.1871534-10-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-10-coltonlewis@google.com>

Hi Colton,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d]

url:    https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20251210-055309
base:   ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
patch link:    https://lore.kernel.org/r/20251209205121.1871534-10-coltonlewis%40google.com
patch subject: [PATCH v5 09/24] perf: arm_pmuv3: Keep out of guest counter partition
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20251211/202512110439.UXwb1Qh4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512110439.UXwb1Qh4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512110439.UXwb1Qh4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/arm64/kvm/pmu-direct.c:75 function parameter 'pmu' not described in 'kvm_pmu_guest_counter_mask'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

