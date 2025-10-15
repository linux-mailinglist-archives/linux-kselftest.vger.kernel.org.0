Return-Path: <linux-kselftest+bounces-43178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803CBDE5B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EF719C4981
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC61324B1D;
	Wed, 15 Oct 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbgx0SFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5B324B10;
	Wed, 15 Oct 2025 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529523; cv=none; b=XMJBMb6eBcb43J1VbSdjZCW7kMkwv9vIASU7WDobeP7QFNuBuHlnrl52w9faFqOkGK04pan87Ur11Kl/RR3jI2hooldWXXf25DpaPr/54n3ixvV6d0PnOCXiI5n121qnAJtA5cTtEz8dM7qCHKhIATK5RXMyHy92O0hJRB4wav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529523; c=relaxed/simple;
	bh=Rh23M01bmd+Uo4dW+JzHGlrL82LSKsPD8E2qifm7m0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9ZQGuQCXiGcWUd1i+6XD24fXM1Ube3IlujgbBecu1yPUy8CRZVdF4XJQ30/BrrTJUUSYdZyG4RmbBLE4gQeFVipfuA3IEFaZjlxN1++jwrzFagYJQ4jbRuKGIUqc6/PdnuGaJscG6SNo1oFjY5cbRBmVjvmVusuklewyIU7/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbgx0SFK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760529522; x=1792065522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rh23M01bmd+Uo4dW+JzHGlrL82LSKsPD8E2qifm7m0s=;
  b=kbgx0SFKvrzf8KLr5D8KFL2/wfsvjW+KwzMmEWLXzlKjC8tRL9hvpK4J
   Wmtxn988Jx30mDjsW+3EjMkhpqd+lL6cOncqQclgCdqsIXfaGKR6jXAa2
   DeB1jSZoNBUywjpfxCUCsgv+Ix7mktS2Q7oBUrKztZISO5bnxupSTtvvm
   qGvpBAuU750U7dUDpS3T7V1G3TSSIhuxnBJIVXMe+wBBMBKyoFhwy5ERy
   XIc2retL65vo1lxf89Zelc2O2KQpvYuzjED4LzuYESqNyXCmpGL12s/U2
   hnorussK0Q929DzIkgpEpr3Kw8TsPPsbfzXf1bh9CrA8YTnVj5PFTlTL4
   w==;
X-CSE-ConnectionGUID: CLddMBW7T22fIi95Q9JObg==
X-CSE-MsgGUID: 3/kfDkatRbKF+s8h5Stxew==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="80138448"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="80138448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 04:58:42 -0700
X-CSE-ConnectionGUID: UZ0EamPpQIKKIBkFRCmpBg==
X-CSE-MsgGUID: hl2HG8F6TPKGptlSC4HUtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="219297447"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Oct 2025 04:58:38 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v909L-0003oN-3B;
	Wed, 15 Oct 2025 11:58:36 +0000
Date: Wed, 15 Oct 2025 19:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com
Cc: oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, shyamsaini@linux.microsoft.com
Subject: Re: [PATCH v2 4/7] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
Message-ID: <202510151909.E0Zb31Ah-lkp@intel.com>
References: <6c36de14b00a3f06df3a602f18baf6b51fde429f.1760487869.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c36de14b00a3f06df3a602f18baf6b51fde429f.1760487869.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.18-rc1 next-20251014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommufd-device-Move-sw_msi_start-from-igroup-to-idev/20251015-083453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/6c36de14b00a3f06df3a602f18baf6b51fde429f.1760487869.git.nicolinc%40nvidia.com
patch subject: [PATCH v2 4/7] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
config: i386-buildonly-randconfig-002-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151909.E0Zb31Ah-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151909.E0Zb31Ah-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151909.E0Zb31Ah-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/overflow.h:6,
                    from include/linux/string.h:13,
                    from include/linux/scatterlist.h:5,
                    from include/linux/iommu.h:10,
                    from drivers/iommu/iommufd/io_pagetable.c:13:
   drivers/iommu/iommufd/io_pagetable.c: In function 'iopt_table_enforce_dev_resv_regions':
>> include/linux/limits.h:11:25: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      11 | #define PHYS_ADDR_MAX   (~(phys_addr_t)0)
         |                         ^
   drivers/iommu/iommufd/io_pagetable.c:1461:39: note: in expansion of macro 'PHYS_ADDR_MAX'
    1461 |                 unsigned long start = PHYS_ADDR_MAX, last = 0;
         |                                       ^~~~~~~~~~~~~


vim +11 include/linux/limits.h

54d50897d544c8 Masahiro Yamada 2019-03-07   8  
54d50897d544c8 Masahiro Yamada 2019-03-07   9  #define SIZE_MAX	(~(size_t)0)
dabba87229411a Pasha Tatashin  2022-05-27  10  #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
54d50897d544c8 Masahiro Yamada 2019-03-07 @11  #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
54d50897d544c8 Masahiro Yamada 2019-03-07  12  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

