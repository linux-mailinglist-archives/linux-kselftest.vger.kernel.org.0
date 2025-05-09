Return-Path: <linux-kselftest+bounces-32749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BDAB16F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD241C43396
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4548229614D;
	Fri,  9 May 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNTpvpLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94D295D9F;
	Fri,  9 May 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800012; cv=none; b=bxkNwNRvA/8lOIv2Hy+BcM8id5UpVvvptvsGppcpivmtWr4bJ1ldRsfB/taUDDbCgS6nswHBHVqyqaPjFQIJKqkyVQks/xKx/FzUaHaC0jhEEINcORze7ZmvvbN8NY4ohAP4Sgs3fg2kbIl7RlIj7POh11Mvno1R9YBP7hqXwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800012; c=relaxed/simple;
	bh=0/dtn/kdBfNqf/vszxB+yWxoYVNi1v0FvDrPLSfbTQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVO8MHxo40702NGjLBlgbcEywAqwpGjU+yimH75fdV+VeyM8OYthjGpPr5wd/aNcmpayzEm/VuAeZSXQOJ6VqfiHX+iJwM1sZawxGYtxbH2x73iNBqxby4elweqVmP8yb8z574kLvqqzG9LMtjlHJgSKXwdboHfJgU8sXbKIbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNTpvpLZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746800011; x=1778336011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/dtn/kdBfNqf/vszxB+yWxoYVNi1v0FvDrPLSfbTQY=;
  b=nNTpvpLZyO2qudRsV2AjsWADPYqVkv93ka886VEZH+G1+r86+mK/dJJD
   Zo3hv+sOhVQZzwHmyV9fi0lwGJrT2TFhU3RKk4S1zXH/NStD1KHfqcnp8
   MYr9jbOb2ZLWKa6gGoZWvCnSCx6piGsq7rDXjaatFvLksCutL1vbl8D0l
   IeYkk+H/x52bnVnsdpCQUi174YFgCS3lhXdjIS2C92OK6DVr83cgk36ta
   B2rxX2Pm34U6GRdt2J6y5Z5axcrOxtF5X/nBtbMNfT6zdExCLcjkOXAaO
   EiVbIRxWhWCYqmk+prcBhpvIrojotcL3R8nNtumSgAQX9VMQhFQVQTeYV
   A==;
X-CSE-ConnectionGUID: vigOUJHVQOuSzQSjtnHZ0A==
X-CSE-MsgGUID: t/bAtmxOSDufsuQh4EHvGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48782053"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48782053"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 07:13:28 -0700
X-CSE-ConnectionGUID: H4zXQepxSMe8aX0MXumPvw==
X-CSE-MsgGUID: RcgC4DNNQty3MbgoXScnBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141580924"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2025 07:13:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDOTW-000C9N-2m;
	Fri, 09 May 2025 14:13:18 +0000
Date: Fri, 9 May 2025 22:13:04 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net, will@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 14/23] iommufd: Add mmap interface
Message-ID: <202505092119.UALKhnIX-lkp@intel.com>
References: <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 92a09c47464d040866cf2b4cd052bc60555185fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommufd-viommu-Add-driver-allocated-vDEVICE-support/20250509-110521
base:   92a09c47464d040866cf2b4cd052bc60555185fb
patch link:    https://lore.kernel.org/r/ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc%40nvidia.com
patch subject: [PATCH v4 14/23] iommufd: Add mmap interface
config: i386-buildonly-randconfig-003-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092119.UALKhnIX-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092119.UALKhnIX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092119.UALKhnIX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/driver.c:91:6: warning: variable 'num_pfns' set but not used [-Wunused-but-set-variable]
      91 |         int num_pfns, rc;
         |             ^
   1 warning generated.


vim +/num_pfns +91 drivers/iommu/iommufd/driver.c

    80	
    81	/*
    82	 * Allocate an @offset to return to user space to use for an mmap() syscall
    83	 *
    84	 * Driver should use a per-structure helper in include/linux/iommufd.h
    85	 */
    86	int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
    87				phys_addr_t base, size_t length, unsigned long *offset)
    88	{
    89		struct iommufd_mmap *immap;
    90		unsigned long startp;
  > 91		int num_pfns, rc;
    92	
    93		if (WARN_ON_ONCE(!offset))
    94			return -EINVAL;
    95		if (!PAGE_ALIGNED(base))
    96			return -EINVAL;
    97		if (!length || !PAGE_ALIGNED(length))
    98			return -EINVAL;
    99		num_pfns = length >> PAGE_SHIFT;
   100	
   101		immap = kzalloc(sizeof(*immap), GFP_KERNEL);
   102		if (!immap)
   103			return -ENOMEM;
   104		immap->owner = owner;
   105		immap->base_pfn = base >> PAGE_SHIFT;
   106		immap->num_pfns = length >> PAGE_SHIFT;
   107	
   108		rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->num_pfns,
   109				       0, U32_MAX >> PAGE_SHIFT, GFP_KERNEL);
   110		if (rc < 0) {
   111			kfree(immap);
   112			return rc;
   113		}
   114	
   115		/* mmap() syscall will right-shift the offset in vma->vm_pgoff */
   116		*offset = startp << PAGE_SHIFT;
   117		return 0;
   118	}
   119	EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

