Return-Path: <linux-kselftest+bounces-23935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94472A01DF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 04:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73401163848
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0E78F2F;
	Mon,  6 Jan 2025 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bndyOQVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148C3D69;
	Mon,  6 Jan 2025 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736132645; cv=none; b=r91ZALjkatv8P3JfR+3mnYBCRBih5QggO3WzeRNHUFJhKyWRPzGjLuwfdxr02C8mGdOOBDOWP2VY6yVfy+WnoN1Pfl/DRDAycG+7AeYnb8NVHT3yQK7yWPiHpOOiR9TmBnSxShj8QQOtcAH9LKtFx2b21nAacPMeFCZ86gnj/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736132645; c=relaxed/simple;
	bh=L5CTqVAplYWz3cvc2Q2+gANM0xCm7wWwxzoKHr589zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arKp3LnpZ/I+CeRiliJSMm7+mbitOgOvZTL36QUo2LNlsyOLnw+RoYjEo0YEkec+BBe/2ZiGzAByDmM2bzqrYUPjea+47JFmNdoe3B+ALRBfP1UGx/oVLFkKVhOMEtKhobLBdEiu8q0uhSGhuqHH2pJcRQzREIsVNJ9tMpua18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bndyOQVK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736132645; x=1767668645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L5CTqVAplYWz3cvc2Q2+gANM0xCm7wWwxzoKHr589zI=;
  b=bndyOQVKSK65mDaNR7aLEqrSzurJISmm0XtEp2L9btdD7vqrBFiAuu59
   rMLi1bZHwvNa3aNPHLujl9JaZ/FVo/T99Exotdbn07QEyCFIoeRMFF/sl
   2dFViiVh5DK9UhTXuJMF18p+gon4MBWL9YOJNpasPAxuwuzi3oKVDdxlt
   /Uo0rnVvKDrvAZmXWNRMtk7cE/2P2shCtgmznPZDoqB8O1HLZP6uAZBS4
   6I/kU/BF1nckVKYmPaGVJafQ45GKMSVwdNsN1tYmRQ1yJPK4nnCbmF4D3
   ppRT0n6tC3rl29duGFYJW8imkVBmqRcwB2xMP9Q8HYYtXAeoS8qtGz2u1
   g==;
X-CSE-ConnectionGUID: CYaf27oETam/nUHLNQM4fQ==
X-CSE-MsgGUID: N3YVRL4+QbC+ikQDKuyBRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="36431343"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="36431343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 19:03:45 -0800
X-CSE-ConnectionGUID: dFnpKBihReKdlEaZXHSJug==
X-CSE-MsgGUID: OINJhP+5SYWKmpQ13/0R3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139659644"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 19:03:39 -0800
Message-ID: <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
Date: Mon, 6 Jan 2025 11:01:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 0a08aa82e7cc..55e3d5a14cca 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -1016,9 +1016,24 @@ struct iommu_ioas_change_process {
>   /**
>    * enum iommu_veventq_type - Virtual Event Queue Type
>    * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
> + * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
>    */
>   enum iommu_veventq_type {
>   	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
> +	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
> +};
> +
> +/**
> + * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
> + *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
> + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> + *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> + *
> + * StreamID field reports a virtual device ID. To receive a virtual event for a
> + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> + */
> +struct iommu_vevent_arm_smmuv3 {
> +	__aligned_le64 evt[4];
>   };

Nit: I think it would be more readable to add a check in the vevent
reporting helper.

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 77c34f8791ef..ccada0ada5ff 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -86,6 +86,9 @@ int iommufd_viommu_report_event(struct iommufd_viommu 
*viommu,
         if (WARN_ON_ONCE(!data_len || !event_data))
                 return -EINVAL;

+       if (WARN_ON_ONCE(type != IOMMU_VEVENTQ_TYPE_ARM_SMMUV3))
+               return -EINVAL;
+
         down_read(&viommu->veventqs_rwsem);

         veventq = iommufd_viommu_find_veventq(viommu, type);

Or perhaps the compiler could automatically make a warning if the @type
is not one of those values in enum iommu_veventq_type?

Others look good to me.

Thanks,
baolu

