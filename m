Return-Path: <linux-kselftest+bounces-20372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021BD9A9DB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22931F26744
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269B192D60;
	Tue, 22 Oct 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/pt7c7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7A18EFC1;
	Tue, 22 Oct 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587557; cv=none; b=tXQJj07lybCkMxaAc1kwzqTslmiGH46rgCeK9HB0kMtYjmPY1GDOaA6yF/l7vblGBsoWwndrtIZftvV6uyq9DJ4dSb/IFYepOAc58U7YvwHOcrznh1Gi3FBAfGmCOFqJb4v8YvB0Nn1R62DrW2m2iq9VN6eXXz955ifNDLSu+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587557; c=relaxed/simple;
	bh=PAGAisR6ewXfOUos22t2tN5MyLH3MNDX5PNO1iIvpyA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rY2a8r2ZN5H68P8x+Olzntdnx8gs8pAyy+uddb38F0qvUgKf7K/39qs6ZcSLlLdiAu9E9z/f2DoPfoLOA149SmMVUM5zUkzebJQi/Z+XZZQ8S652/4HSAuv6QPzcVua2X7GcPaOejSCg0jaAJSM/AutNkKTBPOQV/rwUkfqrPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/pt7c7K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729587556; x=1761123556;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PAGAisR6ewXfOUos22t2tN5MyLH3MNDX5PNO1iIvpyA=;
  b=I/pt7c7K/pUC1PnBxzFqJTt6LmOxeCFHz08SIaBR8xK8lqyRnQ4jxVoC
   GZ2s2mAjtUmTu5E5/Izvd5Gv9CfZetbGg7XDhCQPH2Lt4TIIcB+eQwWZb
   e7YYmTxKU1n1Go2H1AgPeWiSAYZuYg1+fwfICN934FVoIGFQPfdfJlW2s
   OBAuZ9Ku5fBR7odWa7T/Q01YC4OWii87QhmJbNZK/gJyNS2qrXeb9uIt4
   fjEZzGr9fzBADRiLbdA6dIeQq4ipnds5fa+/kn8oQ5Ssi1SHX/Ok9gFsN
   lGA/1Y1yTIXxPd5ZPvxRNC6SAga5+LMgYoxXp/RJqCi0r0E3Tx9B+Rrlg
   A==;
X-CSE-ConnectionGUID: I0fcF0RoS+yiwNtlxxUYfg==
X-CSE-MsgGUID: 5duwY7/9Re2zfFvho/yICw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28565102"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="28565102"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:59:15 -0700
X-CSE-ConnectionGUID: FNRSmUgqTXuU/HdcuQ6hIA==
X-CSE-MsgGUID: Sezsu89GSvK2DH0qqjq6Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="110616836"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:59:10 -0700
Message-ID: <dd7eb37f-13c6-4c6e-8adc-954ad9974b93@linux.intel.com>
Date: Tue, 22 Oct 2024 16:59:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, aik@amd.com,
 zhangfei.gao@linaro.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Nicolin Chen <nicolinc@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
 <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
 <ZxcspVGPBmABjUPu@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZxcspVGPBmABjUPu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 12:40, Nicolin Chen wrote:
> On Tue, Oct 22, 2024 at 10:28:30AM +0800, Baolu Lu wrote:
>> On 2024/10/22 8:19, Nicolin Chen wrote:
>>> + * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
>>> + *                the @dev, as the set of virtualization resources shared/passed
>>> + *                to user space IOMMU instance. And associate it with a nesting
>>> + *                @parent_domain. The @viommu_type must be defined in the header
>>> + *                include/uapi/linux/iommufd.h
>>> + *                It is suggested to call iommufd_viommu_alloc() helper for
>>> + *                a bundled allocation of the core and the driver structures,
>>> + *                using the given @ictx pointer.
>>>     * @pgsize_bitmap: bitmap of all possible supported page sizes
>>>     * @owner: Driver module providing these ops
>>>     * @identity_domain: An always available, always attachable identity
>>> @@ -591,6 +601,10 @@ struct iommu_ops {
>>>        void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
>>>                                 struct iommu_domain *domain);
>>>
>>> +     struct iommufd_viommu *(*viommu_alloc)(
>>> +             struct device *dev, struct iommu_domain *parent_domain,
>>> +             struct iommufd_ctx *ictx, unsigned int viommu_type);
>> Is the vIOMMU object limited to a parent domain?
> Yes, for each vIOMMU (a slice of physical IOMMU per VM), one S2
> parent domain is enough. Typically, it has the mappings between
> gPAs and hPAs. If its format/compatibility allows, this single
> parent domain can be shared with other vIOMMUs.

Is it feasible to make vIOMMU object more generic, rather than strictly
tying it to nested translation? For example, a normal paging domain that
translates gPAs to hPAs could also have a vIOMMU object associated with
it.

While we can only support vIOMMU object allocation uAPI for S2 paging
domains in the context of this series, we could consider leaving the
option open to associate a vIOMMU object with other normal paging
domains that are not a nested parent?

Thanks,
baolu

