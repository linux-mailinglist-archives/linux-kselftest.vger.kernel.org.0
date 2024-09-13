Return-Path: <linux-kselftest+bounces-17916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58596977706
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9391C24275
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642C1D2F58;
	Fri, 13 Sep 2024 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw8zt8n1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684919006A
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195736; cv=none; b=lwgBwY4vs/MmTUxNsFVqXG5Df5+N7kjAo9183p8Kmh8ZgYGcm2V30Kzprq7AZ2Aq7HxIHWHLz0IdHDG0AdhKmGa9l5DORSR9lXYUHs+n/IbyvHYoeGTPZxqD8DlpfH0/lJXb4Gyxq9tIAaR38Mbi7hODb7+tFavtZ+Fsr33qCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195736; c=relaxed/simple;
	bh=E1Md7vX5L+kHzpqM8CuOjXPzaGWsw8gfFZfrd0Ya2W8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kyieAV2GrCSlCX1dXr08kw1SJItwsR/dD6lTIWWIwkEpJbSMNx6uQWZCjsd1LmsVQ6YBy/Ka4PeWzVfZl+dVDZp+BAjhXZk/CFXI+ga2ugpI9GC4p1VgrXy22A5Fp/Cn6swfAeaXrLwRvIIQBuxZNcS2bbwQo1HoQQ1I/Irxw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mw8zt8n1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726195734; x=1757731734;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E1Md7vX5L+kHzpqM8CuOjXPzaGWsw8gfFZfrd0Ya2W8=;
  b=Mw8zt8n1t3HXl98NqfiJ1+MsJae8S3AeTPIXu94c32sLVHR8eiHCJ7za
   bpxiS1EDSnLMO0fvJs6idi+ve3+8VQHI/r7wVAR3Y3T2tNqP6z1Bf5TZ8
   y8q685y+JU57F7uLr4H33/fzNzyJYbMuQe1xtpgQL+TJBzdhcbkKEA2nr
   FICAcDZjnFecOgemflMlxlpkdF9K13Y/UgtRKHGvV6S8RuiP05ouAaQal
   6ZNhW7eXD8lpe0oMGTdqUELOd3egvgXuiOJkDvJVmLmlU8Bzb1nUC2Hi3
   k1Pl/QXSJ1rff4deQGV0FBqs67xhNknH7V6JrAsOpy8EN9YOKvSZACkAb
   w==;
X-CSE-ConnectionGUID: p/YGfWw3SAeLNWwInAwz9A==
X-CSE-MsgGUID: t8J7DjEHSvS/Ojy22xL5aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36432251"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="36432251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:48:53 -0700
X-CSE-ConnectionGUID: F31Oz+1iSmOqFyk3RJ0hWg==
X-CSE-MsgGUID: EhithrKSTr+pJ98Xw/egPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72688636"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 12 Sep 2024 19:48:50 -0700
Message-ID: <881fd7d0-dd9e-4d9d-9529-c9ff03088351@linux.intel.com>
Date: Fri, 13 Sep 2024 10:44:44 +0800
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
Subject: Re: [PATCH v4 01/10] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240912131255.13305-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 9:12 PM, Yi Liu wrote:
> Provide a high-level API to allow replacements of one domain with
> another for specific pasid of a device. This is similar to
> iommu_group_replace_domain() and it is expected to be used only by
> IOMMUFD.
> 
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu-priv.h |  4 ++
>   drivers/iommu/iommu.c      | 90 ++++++++++++++++++++++++++++++++++++--
>   2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index de5b54eaa8bf..90b367de267e 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -27,6 +27,10 @@ static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwsp
>   int iommu_group_replace_domain(struct iommu_group *group,
>   			       struct iommu_domain *new_domain);
>   
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle);
> +
>   int iommu_device_register_bus(struct iommu_device *iommu,
>   			      const struct iommu_ops *ops,
>   			      const struct bus_type *bus,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b6b44b184004..066f659018a5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3347,14 +3347,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   }
>   
>   static int __iommu_set_group_pasid(struct iommu_domain *domain,
> -				   struct iommu_group *group, ioasid_t pasid)
> +				   struct iommu_group *group, ioasid_t pasid,
> +				   struct iommu_domain *old)
>   {
>   	struct group_device *device, *last_gdev;
>   	int ret;
>   
>   	for_each_group_device(group, device) {
>   		ret = domain->ops->set_dev_pasid(domain, device->dev,
> -						 pasid, NULL);
> +						 pasid, old);
>   		if (ret)
>   			goto err_revert;
>   	}
> @@ -3366,7 +3367,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>   	for_each_group_device(group, device) {
>   		if (device == last_gdev)
>   			break;
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		/* If no old domain, undo the succeeded devices/pasid */
> +		if (!old) {
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
> +			continue;
> +		}
> +
> +		/*
> +		 * Rollback the succeeded devices/pasid to the old domain.
> +		 * And it is a driver bug to fail attaching with a previously
> +		 * good domain.
> +		 */
> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> +						    pasid, domain)))
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);

You want to rollback to the 'old' domain, right? So, %s/domain/old/ ?

>   	}
>   	return ret;
>   }
> @@ -3425,7 +3439,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   	if (ret)
>   		goto out_unlock;
>   
> -	ret = __iommu_set_group_pasid(domain, group, pasid);
> +	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
>   	if (ret)
>   		xa_erase(&group->pasid_array, pasid);
>   out_unlock:
> @@ -3434,6 +3448,74 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>   
> +/**
> + * iommu_replace_device_pasid - Replace the domain that a pasid is attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. Return 0 on success, or an
> + * error. The pasid will keep the old configuration if replacement failed.
> + * This is supposed to be used by iommufd, and iommufd can guarantee that
> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid() would
> + * pass in a valid @handle.
> + */
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle)

How about passing the old domain as a parameter?

> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_attach_handle *curr;
> +	int ret;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
> +	    pasid == IOMMU_NO_PASID || !handle)

dev_has_iommu() check is duplicate with above if (!group) check.

By the way, why do you require a non-NULL attach handle? In the current
design, attach handles are only used for domains with iopf capability.

> +		return -EINVAL;
> +
> +	handle->domain = domain;
> +
> +	mutex_lock(&group->mutex);
> +	/*
> +	 * The iommu_attach_handle of the pasid becomes inconsistent with the
> +	 * actual handle per the below operation. The concurrent PRI path will
> +	 * deliver the PRQs per the new handle, this does not have a function
> +	 * impact. The PRI path would eventually become consistent when the
> +	 * replacement is done.
> +	 */
> +	curr = (struct iommu_attach_handle *)xa_store(&group->pasid_array,
> +						      pasid, handle,
> +						      GFP_KERNEL);
> +	if (!curr) {
> +		xa_erase(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

This seems to be broken as explained above. The attach handle is
currently only for iopf-capable domains.

If I understand it correctly, you just want the previous attached domain
here, right? If so, why not just passing it to this helper from callers?

> +
> +	ret = xa_err(curr);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (curr->domain == domain)
> +		goto out_unlock;
> +
> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr->domain);
> +	if (ret)
> +		WARN_ON(handle != xa_store(&group->pasid_array, pasid,
> +					   curr, GFP_KERNEL));
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
> +
>   /*
>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>    * @domain: the iommu domain.

Thanks,
baolu

