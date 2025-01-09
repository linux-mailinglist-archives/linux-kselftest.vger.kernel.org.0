Return-Path: <linux-kselftest+bounces-24123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E285CA0741D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F24A3A075C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF607215F55;
	Thu,  9 Jan 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii0cE7+6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7531714D7;
	Thu,  9 Jan 2025 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420664; cv=none; b=BBfewwmG24Lx/xMgl00hRthpFYDsj557LZJHIGrDMJrALzpOJ4nKUkVnTptvO1UqTcLE8N99U2BkmFX9QJWVup0BNHzHu6obYZtWUsIj0Us4/DKn7tHjwhDy/kLyy05WfAXvvnUI9JLn0e+EOCJxOBjUUCK7FmGiPtgj3h5H5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420664; c=relaxed/simple;
	bh=IP79LBJkq7R0JdTUMY4tcQDHZkX+te/jZ0WVpzZaqp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJeWAgtx/+PpOY1hE8/5BlzhOtHvE2p6IJ3ImrvfhhgnmwVmbIoW3cbxVSNPyHmidWBrTaE+D5TtKaIVCMDyAWAcKYwEQp/+d8fsJakXzffFA39TlEkTZvEqaD8uMUcc4IcTDW7GFnweBVjFkvd9NRwzfgMZ4VRA/hLfVNfbzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii0cE7+6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736420663; x=1767956663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IP79LBJkq7R0JdTUMY4tcQDHZkX+te/jZ0WVpzZaqp4=;
  b=ii0cE7+69Or4wslApfIvUmV5ay2+FzJu0CWQvstXuCB02Otv0ECea1JX
   ijs+HNw+cq73JBYB5WIZEY0MADyqf3437WYCAAFbsSWz8T4uOm9GNbTb4
   WLN8KqNZ7hb9xT7X55SDjZJQjlErZ2i+1/w+TRhqE9pFpfnBrIn0GawH4
   uL/drBF2RsHH521M43J5uiH/kqSj1doN1omlRATEA6cFiG71MnF1FIu8C
   W49sM+XmvCWrsyJJardsISrdz4LJNDUgXUfJ8mDfSjtpZvb/qoAMShbsq
   5VNKyz+VLaKSCiCvx4eI8+gYGdZdpjXfUxIA7w/T3DwslMeGHtFvNy1W7
   Q==;
X-CSE-ConnectionGUID: bK+YTM82S2SMsqwSW1kUjg==
X-CSE-MsgGUID: iKrkadf6RMGnUd49EWbGig==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36370917"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="36370917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 03:04:22 -0800
X-CSE-ConnectionGUID: KWuf3KQCRHuOZRxQ0NsmIw==
X-CSE-MsgGUID: GsyVUl2OT/W0wQ0EAIHqMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103259034"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Jan 2025 03:04:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVqKk-000HRT-0t;
	Thu, 09 Jan 2025 11:04:14 +0000
Date: Thu, 9 Jan 2025 19:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net, will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <202501091822.4ocbIobQ-lkp@intel.com>
References: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e94dc6ddda8dd3770879a132d577accd2cce25f9]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommufd-Keep-OBJ-IOCTL-lists-in-an-alphabetical-order/20250108-011247
base:   e94dc6ddda8dd3770879a132d577accd2cce25f9
patch link:    https://lore.kernel.org/r/03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc%40nvidia.com
patch subject: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to devices attached to vIOMMU
config: arm64-randconfig-r131-20250109 (https://download.01.org/0day-ci/archive/20250109/202501091822.4ocbIobQ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250109/202501091822.4ocbIobQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501091822.4ocbIobQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:461:21: sparse: sparse: invalid assignment: &=
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:461:21: sparse:    left side has type restricted __le64
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:461:21: sparse:    right side has type unsigned long long
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:462:21: sparse: sparse: invalid assignment: |=
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:462:21: sparse:    left side has type restricted __le64
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:462:21: sparse:    right side has type unsigned long long
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:464:23: sparse: sparse: cast from restricted __le64
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c:465:23: sparse: sparse: cast from restricted __le64

vim +461 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c

   455	
   456	int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
   457	{
   458		struct iommu_vevent_arm_smmuv3 vevt =
   459			*(struct iommu_vevent_arm_smmuv3 *)evt;
   460	
 > 461		vevt.evt[0] &= ~EVTQ_0_SID;
   462		vevt.evt[0] |= FIELD_PREP(EVTQ_0_SID, vmaster->vsid);
   463	
 > 464		vevt.evt[0] = cpu_to_le64(vevt.evt[0]);
   465		vevt.evt[1] = cpu_to_le64(vevt.evt[1]);
   466	
   467		return iommufd_viommu_report_event(&vmaster->vsmmu->core,
   468						   IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &vevt,
   469						   sizeof(vevt));
   470	}
   471	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

