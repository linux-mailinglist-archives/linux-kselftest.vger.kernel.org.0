Return-Path: <linux-kselftest+bounces-23730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A19FA95D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 03:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA40B7A062E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B521348;
	Mon, 23 Dec 2024 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jylnz1wZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6E3EA69;
	Mon, 23 Dec 2024 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734921022; cv=none; b=kc0pW4oHfRmvHC4w6ecQfQuX69CasN1YhNva7vjnmwlwQKPzeAd64gLUtaZc9swb5WvO7wbu/z+gdNdI+BsWMAOdaEcumhVGeW6iYy2R+nFQPm5DmvxM9Jur4H04gKvAAYAoDhijeRM6XLCZSApuUgYwq0lhHykAw22NoUYyIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734921022; c=relaxed/simple;
	bh=846d+cRFBoDrFep8BfHDhcE6RYZkZKHKE60fLL1H0x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5qhZdszUKtdB5GS2anMD0XvKWb4PyOOzDzJMgM77wfNy1/C04HIrqlzi6mn/2qgpCpsnRiYG21WqEHBL3VXf+mY75UbO29UYQnTMUXAW2sd9Nya4sBVxRmji+kJ8lYhzdoX8fEFWf8DAzfTWhsIwHtgqlJbYH9UFMT7R35+tMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jylnz1wZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734921020; x=1766457020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=846d+cRFBoDrFep8BfHDhcE6RYZkZKHKE60fLL1H0x4=;
  b=Jylnz1wZfontQF03VHvyrKc1XCHjfWQByCsgwiUD80iClThSAm2/zo4p
   H6Y0e780mBOcOn3NLXAl5LwxiekA/tVcKrcwFjmWsLvBy+qs2VxzVX1H2
   9LrJVHjHUxFqGU8FD8Tdty01HFTPCb9jnah88dencyXoKJA9rTUa/Dhtx
   2bQ2kXlYy6Ieob7UJtJk5wckdFulgwKalZidOB6MDqAdgvPi2j/pU0tbJ
   oAR+fuFkPsWHWC77u5zVLxQtLAe4CzD2fbDD4073H644O62jk6FaO60n/
   s1FUnnsOJKpQQ5v1P+mQpL7ULScnngQrjUAKSeFY9lx6yzU0dKIdyzP+m
   w==;
X-CSE-ConnectionGUID: Vc4zmSz6RSqPBdZ47Q2kdw==
X-CSE-MsgGUID: NoRkUdOjR6OPxCmAFy54Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="39320711"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="39320711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 18:30:19 -0800
X-CSE-ConnectionGUID: WxF/1ytIQjSsv80o60rM8A==
X-CSE-MsgGUID: FxLvu3rfS3Gtu8sDqEny9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103189883"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 18:30:14 -0800
Message-ID: <74bc9dbe-3420-4f0c-9e32-db49327a723d@linux.intel.com>
Date: Mon, 23 Dec 2024 10:28:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, corbet@lwn.net,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <21d7e63b97d81d0acf9127418a67efe386787261.1734477608.git.nicolinc@nvidia.com>
 <56c65e50-5890-42af-85b7-85f8a1bf5cf5@linux.intel.com>
 <Z2OpylDlhLXoo3dt@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z2OpylDlhLXoo3dt@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 13:06, Nicolin Chen wrote:
> On Thu, Dec 19, 2024 at 10:05:53AM +0800, Baolu Lu wrote:
>> On 12/18/24 13:00, Nicolin Chen wrote:
>>> This is a reverse search v.s. iommufd_viommu_find_dev, as drivers may want
>>> to convert a struct device pointer (physical) to its virtual device ID for
>>> an event injection to the user space VM.
>>>
>>> Again, this avoids exposing more core structures to the drivers, than the
>>> iommufd_viommu alone.
>>>
>>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>>> ---
>>>    include/linux/iommufd.h        |  8 ++++++++
>>>    drivers/iommu/iommufd/driver.c | 20 ++++++++++++++++++++
>>>    2 files changed, 28 insertions(+)
>>>
>>> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
>>> index b082676c9e43..ac1f1897d290 100644
>>> --- a/include/linux/iommufd.h
>>> +++ b/include/linux/iommufd.h
>>> @@ -190,6 +190,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>>>    					     enum iommufd_object_type type);
>>>    struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>>>    				       unsigned long vdev_id);
>>> +unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
>>> +					 struct device *dev);
>> Hi Nicolin,
>>
>> This series overall looks good to me. But I have a question that might
>> be irrelevant to this series itself.
>>
>> The iommufd provides both IOMMUFD_OBJ_DEVICE and IOMMUFD_OBJ_VDEVICE
>> objects. What is the essential difference between these two from
>> userspace's perspective?
> A quick answer is an IOMMUFD_OBJ_DEVICE being a host physical
> device and an IOMMUFD_OBJ_VDEVICE being an IOMMUFD_OBJ_DEVICE
> related to IOMMUFD_OBJ_VIOMMU. Two of them can be seen in two
> different layers. May refer to this graph:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ 
> Documentation/userspace-api/iommufd.rst?h=v6.13-rc3#n150
> 
>> And, which object ID should the IOMMU device
>> driver provide when reporting other events in the future?
>>
>> Currently, the IOMMUFD uAPI reports IOMMUFD_OBJ_DEVICE in the page
>> fault message, and IOMMUFD_OBJ_VDEVICE (if I understand it correctly) in
>> the vIRQ message. It will be more future-proof if this could be defined
>> clearly.
> A vIRQ is actually reported per-vIOMMU in this design. Although
> in the this series the SMMU driver seems to report a per-device
> vIRQ, it internally converts the vDEVICE to a virtual device ID
> and packs the virtual device ID into a per-vIOMMU event:
> 
> +/**
> + * struct iommu_virq_arm_smmuv3 - ARM SMMUv3 Virtual IRQ
> + *                                (IOMMU_VIRQ_TYPE_ARM_SMMUV3)
> + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> + *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> + *
> + * StreamID field reports a virtual device ID. To receive a virtual IRQ for a
> + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> + */
> +struct iommu_virq_arm_smmuv3 {
> +	__aligned_le64 evt[4];
>   };

Thanks for the explanation. Maybe I am a bit over-considering here.

Initially, my understanding is to report a virtual device ID when the
object originates from a vIOMMU, and an iommufd device ID otherwise.

However, considering page fault scenarios, which are self-contained but
linked to a hardware page table (hwpt), introduces ambiguity. Hwpt can
be created with or without a vIOMMU. This raises the question: should
the page fault message always report the iommufd device ID, or should
the reporting depend on whether the hwpt was created from a vIOMMU?

Thanks,
baolu

