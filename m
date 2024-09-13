Return-Path: <linux-kselftest+bounces-17904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A1977674
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 03:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091D41F24D4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C44A07;
	Fri, 13 Sep 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLsRC4v6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0A3FE4
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726191573; cv=none; b=McXXWNvW+Kq7iVwREyVughBLtOpJmvfPLvhdrOX+W97VU2nMzfNI39AaQDFRy6oz8p5VfyoghoL05txDHng+KouaB2t13F5+3nBB/Gw8RiISYaCPjZBdEoJGu+DEubPtkhuFU4Z9IftQRbSXuuj/Q4wLuHfp4AVUsAC9hJg0Bg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726191573; c=relaxed/simple;
	bh=HqgecsK0tKJe9ycMvAAChKqddjMqIIFJ/+LRYPK6Agw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DCo6UjPW2O1yGYk/flc87pWRBGeEjuXbioX7JienLogx1pMDE2KHd9XFO4YYH87lD+lzdt8Hw3e2mmztJThqn5j/eReuaEn6uvnG8tl0SLDTPiRr2E0UuRsIpTJ7sFc/sg21yNU3VCxHEDFSCy4juCJOzC/QTRqfnt6Tfezyix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLsRC4v6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726191572; x=1757727572;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HqgecsK0tKJe9ycMvAAChKqddjMqIIFJ/+LRYPK6Agw=;
  b=YLsRC4v6/h0P69aPNSWmLqiBnkhrNbsDdo/eISLACJxZ4/O5mTZwiSbk
   eGGWCgi3lz0anbnVMfRF+mZoIZM/wbV1HUMd13wZUfVPitU3QqpBg8Y8L
   hIoWGUj4sLwetTXi/1uC14yTvYtm9cdv6M5UeBe9z9QeM7GX5e0BjmdYZ
   sQfRAw9iC8fnoHxGDOJoWqUv6SirQl7en5XViwgiNz6he1CMPjkZ2MIr4
   mGN94xKU+jx2+woHt2uClnwzyY77ClIjIKrbIZQc8mRozctp+OBEbUp4d
   JBo162VJxdtnAp1hreTHvfdXUZX+O0DkxTrPNZK3afnacoSwhBWJxJzFJ
   g==;
X-CSE-ConnectionGUID: OvdD1sdhTM2A81HM4RlgTw==
X-CSE-MsgGUID: OvwsbmkhTdaVIbU1VjSnVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36217412"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="36217412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 18:39:30 -0700
X-CSE-ConnectionGUID: L8+nXlSGR1y6+lLb77qe2w==
X-CSE-MsgGUID: UbXS92TjQ4On++4PEKs/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72003744"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 12 Sep 2024 18:39:27 -0700
Message-ID: <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
Date: Fri, 13 Sep 2024 09:35:21 +0800
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
> set_dev_pasid op is going to support domain replacement and keep the old
> hardware config if it fails. Make the Intel iommu driver be prepared for
> it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 98 ++++++++++++++++++++++++-------------
>   1 file changed, 65 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 80b587de226d..6f5a8e549f3f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4248,8 +4248,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>   	return 0;
>   }
>   
> -static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
> -					 struct iommu_domain *domain)
> +static void domain_remove_dev_pasid(struct iommu_domain *domain,
> +				    struct device *dev, ioasid_t pasid)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct dev_pasid_info *curr, *dev_pasid = NULL;
> @@ -4257,11 +4257,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   	struct dmar_domain *dmar_domain;
>   	unsigned long flags;
>   
> -	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> -		intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
> -		return;
> -	}
> -
>   	dmar_domain = to_dmar_domain(domain);
>   	spin_lock_irqsave(&dmar_domain->lock, flags);
>   	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
> @@ -4278,13 +4273,24 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   	domain_detach_iommu(dmar_domain, iommu);
>   	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>   	kfree(dev_pasid);
> +}
> +
> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
> +					 struct iommu_domain *domain)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +
>   	intel_pasid_tear_down_entry(iommu, dev, pasid,
>   				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return;

The static identity domain is not capable of handling page requests.
Therefore there is no need to drain PRQ for an identity domain removal.

So it probably should be something like this:

	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
		intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
		return;
	}

	intel_pasid_tear_down_entry(iommu, dev, pasid,
                                     INTEL_PASID_TEARDOWN_DRAIN_PRQ);

> +	domain_remove_dev_pasid(domain, dev, pasid);
>   }
>   
> -static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> -				     struct device *dev, ioasid_t pasid,
> -				     struct iommu_domain *old)
> +static struct dev_pasid_info *
> +domain_prepare_dev_pasid(struct iommu_domain *domain,
> +			 struct device *dev, ioasid_t pasid)

Why do you want to return a struct pointer instead of an integer? The
returned pointer is not used after it is returned.

Also, how about renaming this helper to domain_add_dev_pasid() to pair
it with domain_remove_dev_pasid()?

>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> @@ -4293,22 +4299,13 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   	unsigned long flags;
>   	int ret;
>   
> -	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
> -		return -EOPNOTSUPP;
> -
> -	if (domain->dirty_ops)
> -		return -EINVAL;
> -
> -	if (context_copied(iommu, info->bus, info->devfn))
> -		return -EBUSY;
> -
>   	ret = prepare_domain_attach_device(domain, dev);
>   	if (ret)
> -		return ret;
> +		return ERR_PTR(ret);
>   
>   	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>   	if (!dev_pasid)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
>   	ret = domain_attach_iommu(dmar_domain, iommu);
>   	if (ret)

Thanks,
baolu

