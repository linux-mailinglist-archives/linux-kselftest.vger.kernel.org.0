Return-Path: <linux-kselftest+bounces-31747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD073A9E5D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD93F3BA716
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47484156C62;
	Mon, 28 Apr 2025 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pem8HCV4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FA14F90;
	Mon, 28 Apr 2025 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804183; cv=none; b=gWibSbQNRqrE4Mi1cEKZtN+tAKUpBsya0b+9bz5+6s51SFmAgyROPyBZlTzUiwOTcA+zfynyEBuM4lj+8KzFnV6WgjqeAuM5jnBrV550YEhl2V8SamO4kZGyIPJ++8D0rGzkfjYJ9QmQOV4Ar+QXCWLc2GQrbyKrXw9+N8h3qoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804183; c=relaxed/simple;
	bh=ka5i6kOXSNGQcxxbduG/8nuC65hLt6QpSbzaVuD2Wr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3XjUrunau+81CgUYdrRKb2SgVcNV7+Tc2ZoVj5et/SVxk2rLgTf2QM8Cx2jNrd4OssItFN7Y8k/e4fRp0r+thmiKdtOQ8T2uvykNonzGnfk4yPEBhr0PyOV1UMlRR4krTeXUpQ0Lz6fuH3b2MsrGhOBaLjACadzw0v3B6QTDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pem8HCV4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745804182; x=1777340182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ka5i6kOXSNGQcxxbduG/8nuC65hLt6QpSbzaVuD2Wr0=;
  b=Pem8HCV4UxyX+kLsW6WDADxP+ZZlpoXyPwuIm5bfVbOtlP6T6mlGnPxA
   0SIj2s40zDUBIQbth/pl4gnYYTOrST/SD0WJ5KI3zBEv1w+ihwavf7AB0
   raqXegQsd+0KUwn+mKzMZLuj4JtnPD6jNyy8yyFBCwDRLOTjFpjRhHczZ
   /qER2kF9xPqUG2XVDNYyuK/gp1TZbEIiz3I2cY89Pi6+bakgXIMVsrI/o
   7IEZsNO1JwmDqXtdr/KDf8otYARP+IOYCfGsaMr/IbpmGA92HUMgUucPn
   ik5uTAvs7kecQXARXVd3bPNcYdxxCrGTcNEhDzlLNdKgw1HJXg/uWeSZJ
   g==;
X-CSE-ConnectionGUID: uPDbWgNIRaC9Lzq3hCKFoQ==
X-CSE-MsgGUID: WU36sraISXupnaYWOgStbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47511603"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="47511603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:36:21 -0700
X-CSE-ConnectionGUID: ks4dRZHRQR2z+gA9bUZEsQ==
X-CSE-MsgGUID: 3TSRWkChRnOLfY4dm9t51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="137427362"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:36:14 -0700
Message-ID: <dcfd9bfc-44db-4fd8-a49c-0c96c68f6b88@linux.intel.com>
Date: Mon, 28 Apr 2025 09:32:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:58, Nicolin Chen wrote:
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index a65153458a26..02a111710ffe 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -170,3 +170,97 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &viommu->obj);
>   	return rc;
>   }
> +
> +void iommufd_vcmdq_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_vcmdq *vcmdq =
> +		container_of(obj, struct iommufd_vcmdq, obj);
> +	struct iommufd_viommu *viommu = vcmdq->viommu;
> +
> +	if (viommu->ops->vcmdq_destroy)
> +		viommu->ops->vcmdq_destroy(vcmdq);
> +	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, vcmdq->addr, vcmdq->length);
> +	refcount_dec(&viommu->obj.users);
> +}
> +
> +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_vcmdq *vcmdq;
> +	struct page **pages;
> +	int max_npages, i;
> +	dma_addr_t end;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)

I don't follow the check of 'cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT'
here. My understanding is that it states that "other values of type are
not supported". If so, shouldn't it be,

	if (cmd->flags || cmd->type != IOMMU_VCMDQ_TYPE_DEFAULT)

?

> +		return -EOPNOTSUPP;
> +	if (!cmd->addr || !cmd->length)
> +		return -EINVAL;
> +	if (check_add_overflow(cmd->addr, cmd->length - 1, &end))
> +		return -EOVERFLOW;

Thanks,
baolu

