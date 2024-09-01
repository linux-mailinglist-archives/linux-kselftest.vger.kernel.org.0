Return-Path: <linux-kselftest+bounces-16895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8B4967434
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA69C1C20F4D
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D821350;
	Sun,  1 Sep 2024 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHpRsnaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACD3C0C;
	Sun,  1 Sep 2024 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725158366; cv=none; b=Zi94JYC6sC4NU7mOjZHfvW/Ffc/xSuSd/NDDcgEC20m7WlaAVxHs5wyWRmcd3BEW7Id5jIsFjeI3UnvUFakd6llk5oCOMpxJYXI71NhV6HTgWXAP75JLFv0OzkiouvJv5TaXgIsLQzB57mJy6f64WlhVFvIK2+oPfS7Gqi2ATg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725158366; c=relaxed/simple;
	bh=ljvgU3al89OxEVEIUqvIWyRhZNDvLLNUvd8ePVYiWME=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u09vuOBiggwTc/6SPRShOs0JL1jHJXEXP1AtVSVc9XY2XXuG0STo9evAgns58l6FnTOCr/NTuSblidHVxOoQM7HnFuSDGsxTQfcTvz3SxZ1zt9GsGGyTDlRNtMfzNjNbh4RDlNMeb3vYRn5/6B899xeqRgdya8HcajxzCI8bp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHpRsnaY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725158365; x=1756694365;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ljvgU3al89OxEVEIUqvIWyRhZNDvLLNUvd8ePVYiWME=;
  b=hHpRsnaYCCmDUpV7Fu4pKFDdAKUWaoTfRVUjVjCN2K/shsbMNUg4+GXy
   sWiPekyyuoN7Z+zoJRENaOadTF3an4SxQnC/XBjoi0MXqEhjtpp9bMnJX
   W2JIebXV25EDn/d3Ax10NPO4CUWrn16NA9sgqwYzYD6iN82j5xbW7qeMu
   t6P2H46dScxqaKELGVxBpdsIzir7OMUPioQWUOjw52tju0QIZzYO4ww78
   m7NJSmSeAFqONIoQED3jWMlCcvWZZqR7q8SBltwkjBAi/ArkGG8pm+MCR
   qhlPw8wu8UXbypJk3WAyOP7qRr4FPsr+E83TONDXfjQ8xYtzrfmosCjgt
   Q==;
X-CSE-ConnectionGUID: 2c4DltLeSkCpZGy+VeSL/w==
X-CSE-MsgGUID: CSKAzyhbRHOw82RkBkUz0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="41262805"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="41262805"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 19:39:24 -0700
X-CSE-ConnectionGUID: 7wSriv9+TWiJh/xQdZiVmg==
X-CSE-MsgGUID: Wof8a319TkuK6wiSPuTG1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64264177"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 19:39:19 -0700
Message-ID: <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
Date: Sun, 1 Sep 2024 10:39:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/28 0:59, Nicolin Chen wrote:
> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);

Why does a device reference count is needed here? When is this reference
count released after the VIOMMU is allocated?

> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_paging)) {
> +		rc = PTR_ERR(hwpt_paging);
> +		goto out_put_idev;
> +	}
> +
> +	if (!hwpt_paging->nest_parent) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	if (cmd->type != IOMMU_VIOMMU_TYPE_DEFAULT) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu = iommufd_object_alloc(ucmd->ictx, viommu, IOMMUFD_OBJ_VIOMMU);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu->type = cmd->type;
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +
> +	refcount_inc(&viommu->hwpt->common.obj.users);
> +
> +	cmd->out_viommu_id = viommu->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_abort;
> +	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
> +	goto out_put_hwpt;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
> +out_put_hwpt:
> +	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
> +out_put_idev:
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +	return rc;
> +}

Thanks,
baolu

