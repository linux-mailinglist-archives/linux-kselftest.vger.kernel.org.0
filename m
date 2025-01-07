Return-Path: <linux-kselftest+bounces-23974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC4A03788
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 06:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7015E163644
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6A19CC05;
	Tue,  7 Jan 2025 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlmsKSnp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F3193435;
	Tue,  7 Jan 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229366; cv=none; b=NXF3Y6TedKTwt0yWjNEUgJUS2VL6MIjtp2XeJCmGyQz2xMT0Ceo+EjLShSD5WK4002Pf5oG1wYa8wWsuQWLg/d6B84DQcMYaZ/RhwT7u5CmW3X6SnQ2dBQ78gVEt9TwFkVWVGHBvqZCRRwo1b/lhRqFdMjt5ogyOHi/0Shk+79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229366; c=relaxed/simple;
	bh=WoJ6PsFjUaXsGhvoop4qkupd0WOfNNTpqM+Het/KLMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BACOnoxw1UiHx7jezhIIid677vzsBYgqJjCVjFsyIDo4vycTmH5uREj3y6HDIvNFL9/YOn0HwiJsGzmS93gzzH7R/6DcUiK7qQ6rxE65AtGAixcHDZZVgeJuoCT/ZVV4qax9dpo8nHZMvPDIBT51fG+RoOwruZoqUyqROLcUe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlmsKSnp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736229365; x=1767765365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WoJ6PsFjUaXsGhvoop4qkupd0WOfNNTpqM+Het/KLMU=;
  b=jlmsKSnpHomDLrhprqVVMScoxXYRK+gX6ahXokLkXOUuOswFZ3SeUquP
   qOvihRgC643dqxjG5E/sdR1d6p4+jNRfpi3lSJ9EdckIZIybsi0ZIjVR/
   Eumrly0pFN5+Djx9Gapwe9ELWa4jjlkPFs8Pi37DZk2/ZEk2w8TQzVsKg
   V6C/CVWKCURGh1NTBDV+IZvFXwep1ibnFHybpn8JOcFTmjD0tQwsFGCJy
   O2PyLy1UlkH9hGkKhAPLz/96IBkchr5d+q4IGt3WcUnIp0kRn+j6odBww
   MsOAtxL9ypjlqiTNTiTaIR1zr4BlWlT0H1E4LCvrf+KFKY7iO3Vm1GZm6
   g==;
X-CSE-ConnectionGUID: tNBdP6rjRo670S+lDz60ug==
X-CSE-MsgGUID: hGXv0HPDQKmGOze5ETubZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="24001433"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="24001433"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 21:56:04 -0800
X-CSE-ConnectionGUID: OOJpn2qvQDGj1fkl/ZwdHw==
X-CSE-MsgGUID: 6MdEJVMyTveGv4b9OOT3qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="102849876"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 21:56:00 -0800
Message-ID: <75456867-8993-4be4-bcdf-14df28fe92cc@linux.intel.com>
Date: Tue, 7 Jan 2025 13:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
 <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
 <Z3wk9TvmUhB3/zlk@Asurada-Nvidia> <Z3yvZsq77bpnaoAb@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z3yvZsq77bpnaoAb@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 12:36, Nicolin Chen wrote:
> On Mon, Jan 06, 2025 at 10:46:21AM -0800, Nicolin Chen wrote:
>> On Mon, Jan 06, 2025 at 11:01:32AM +0800, Baolu Lu wrote:
>>> Nit: I think it would be more readable to add a check in the vevent
>>> reporting helper.
>>>
>>> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
>>> index 77c34f8791ef..ccada0ada5ff 100644
>>> --- a/drivers/iommu/iommufd/driver.c
>>> +++ b/drivers/iommu/iommufd/driver.c
>>> @@ -86,6 +86,9 @@ int iommufd_viommu_report_event(struct iommufd_viommu
>>> *viommu,
>>>          if (WARN_ON_ONCE(!data_len || !event_data))
>>>                  return -EINVAL;
>>>
>>> +       if (WARN_ON_ONCE(type != IOMMU_VEVENTQ_TYPE_ARM_SMMUV3))
>>> +               return -EINVAL;
>>> +
>> Hmm, that's a good point I think.
>>
>>>          down_read(&viommu->veventqs_rwsem);
>>>
>>>          veventq = iommufd_viommu_find_veventq(viommu, type);
>> 		    ^
>> 		    |
>> We actually have been missing a type validation entirely, so the
>> type could have been rejected by this function. Perhaps we should
>> add a static list of supported types to struct iommufd_viommu_ops
>> for drivers to report so that then the core could reject from the
>> first place during a vEVENTQ allocation.
> I added something like this. Will send a v5.
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 0c7a5894ba07..348179f3cf2a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -399,9 +399,15 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>   	return ret;
>   }
>   
> +static bool arm_vsmmu_supports_veventq(unsigned int type)
> +{
> +	return type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3;

Do you need to check the hardware capabilities before reporting this? I
am not familiar with the ARM architecture, but typically it's better to
make it like this,

static bool arm_vsmmu_supports_veventq(struct iommufd_viommu *viommu,
                                        enum iommu_veventq_type type)
{
	if (type != IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
		return false;

	if (hardware_not_capable(viommu))
		return false;

	return true;
}

> +}
> +
>   static const struct iommufd_viommu_ops arm_vsmmu_ops = {
>   	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
>   	.cache_invalidate = arm_vsmmu_cache_invalidate,
> +	.supports_veventq = arm_vsmmu_supports_veventq,
>   };

Others look good to me.

Thanks,
baolu

