Return-Path: <linux-kselftest+bounces-17905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECE97767D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 03:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193E51C24241
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579C4A07;
	Fri, 13 Sep 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSjBs+Tk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD74A21
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192018; cv=none; b=IOKjQddpZZZZHgUgu88LG32k+5Y2RBZltSND/JhzfAvvLl+bmfWeVP/BxtrKHAS1ghc/9vWWBpiSuFlAyuDWTP7jNhGVYpuaQe/YoLAw8tMfRboVyl7C+CjPOBRWysDe2yeGlVKbuok1n2I8+Zz/ozJ1fsTFDKT13/ypHVRVdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192018; c=relaxed/simple;
	bh=6OfhCmkHFtT3tqlm7qzTod2pz5JLojTDLlUiKwepWAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gRST9rI8PcnjqejFmpfmbzTN07DRJmHyWPH9iLqYXaSaYO8PFFa4xJlAJB0Ybjx/eAbnOsvqbNtlJ3+pBrqQF2wHy3yeEryDMDZOy9h8UJ1TZRZTUyGz7VmhUpFQrN/a/5j2f2GYEZBsROHJ6eE+Xk4SvFjslygYmbxwsDhNLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSjBs+Tk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726192016; x=1757728016;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6OfhCmkHFtT3tqlm7qzTod2pz5JLojTDLlUiKwepWAY=;
  b=lSjBs+TkNxO6eRHqradarMtnUOcW+eu/RMUViXawkpvHeShiOoUzblPe
   KV3Wr3RHcEr862YzDvfWbSaXNYZUrgD/wUaQ9mf8/slPDncoCqwDqjqEl
   EEuYPVcJyznN6ZMKQwYydEXyaL9NjUu+ojMZK2sbXXDdiV2YIxOptMoqA
   LEFfvrBgjIf9rDQhvwG7X5PukxZtLPK/Q5cDPDyZIt4hCQPLZsUuu7TTl
   kZ+pI+U8ja2OzWKK9f2DTXWukPxJLoKQpkJSKTlTgvvLuy+3ySbzuE4sT
   zhtG9ekHhWig5o13vC7nQzXJr+Y0OQMe7NmcGP1DEmEtAXMNcIiVQ419V
   w==;
X-CSE-ConnectionGUID: Y4MFfBbKS0252uulMIV9Lw==
X-CSE-MsgGUID: LzA7QaEsTv64RKeiwbig4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35748670"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="35748670"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 18:46:55 -0700
X-CSE-ConnectionGUID: 8wI9FEvuT8mmPXeyHeDxFw==
X-CSE-MsgGUID: ivS5xelyTSeoKWKOEjHM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="105370471"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 12 Sep 2024 18:46:52 -0700
Message-ID: <08e6739e-762f-4552-adbe-52259747c813@linux.intel.com>
Date: Fri, 13 Sep 2024 09:42:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, zhenzhong.duan@intel.com,
 linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912130427.10119-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:04 PM, Yi Liu wrote:
> @@ -4325,24 +4363,18 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>   						     dev, pasid);
>   	if (ret)
> -		goto out_unassign_tag;
> +		goto out_undo_dev_pasid;
>   
> -	dev_pasid->dev = dev;
> -	dev_pasid->pasid = pasid;
> -	spin_lock_irqsave(&dmar_domain->lock, flags);
> -	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> -	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +	if (old)
> +		domain_remove_dev_pasid(old, dev, pasid);
>   
>   	if (domain->type & __IOMMU_DOMAIN_PAGING)
>   		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
>   
>   	return 0;
> -out_unassign_tag:
> -	cache_tag_unassign_domain(dmar_domain, dev, pasid);
> -out_detach_iommu:
> -	domain_detach_iommu(dmar_domain, iommu);
> -out_free:
> -	kfree(dev_pasid);
> +
> +out_undo_dev_pasid:
> +	domain_remove_dev_pasid(domain, dev, pasid);
>   	return ret;
>   }

Do you need to re-install the old domain to the pasid entry in the
failure path?

Thanks,
baolu

