Return-Path: <linux-kselftest+bounces-1415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48A9809C5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 07:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D011C20C62
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 06:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137079D9;
	Fri,  8 Dec 2023 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crvhoox5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D2C6;
	Thu,  7 Dec 2023 22:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702016940; x=1733552940;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hhwvQW5d3F0DRDnekXHWCaEI+t4hV1ugkZDv0LKCQdU=;
  b=crvhoox5rHZLQXO10RzD5AVUbatXkyDvL3YNGvso9OGnWRBTC58yS92g
   TXnDrbRlxSLFTC3Ea7Yxg2BIfvvxTpzqqqXnlEz4eM6/OAOywEJS697kI
   Tfdxy0bgjBHsh3HG+GoTfw2p0FHvddYzvt+fVsvG6p8NOHGQaFmWfSHUg
   3vmv5tnqgjC0oCLcouYkv4ir5cQT/gIcn1J1lbnejiuPDFoEfokRs7qu1
   IFzygk0QrwWEFsx0GGMRpWS4bsJzHv5bPpbaTtGxjN/e0Izca1OuORGum
   iybyNiqQd/C6/9+AeBcPoccRFfm1Asz6LZ+n7epoCBNhHZI/z1pjgHkBd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394103554"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="394103554"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 22:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862757803"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="862757803"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2023 22:28:56 -0800
Message-ID: <e6504514-9e95-4f68-a276-35582db3881e@linux.intel.com>
Date: Fri, 8 Dec 2023 14:24:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-2-baolu.lu@linux.intel.com>
 <20231201143810.GK1394392@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201143810.GK1394392@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:38 PM, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 10:49:25AM +0800, Lu Baolu wrote:
> 
>> +void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
>> +	void *curr;
>> +
>> +	if (!iopf_param)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	xa_lock(&iopf_param->pasid_cookie);
>> +	curr = xa_load(&iopf_param->pasid_cookie, pasid);
>> +	xa_unlock(&iopf_param->pasid_cookie);
> No need for this locking, the caller has to provide some kind of
> locking to protect the returned pointer.
> 
> I'm not sure how this can work really..
> 
> What iommfd wants is to increment the device object refcount under
> this xa_lock.
> 
> I'm not sure this is the right arrangement: Basically you want to
> have a cookie per domain attachment for iopf domains that is forwarded
> to the handler.
> 
> So maybe this entire thing is not quite right, instead of having a
> generic iopf attached to the domain the iopf should be supplied at
> domain attach time? Something like:
> 
> iommu_domain_attach_iopf(struct iommu_domain *, struct device *,
>                           ioasid_t pasid, struct iopf *, void *cookie);
> 
> The per-attach cookie would be passed to the iopf function
> automatically by the infrastructure.
> 
> Detach would have the necessary locking to ensure that no handler is
> running across detach
> 
> Then the cookie is logically placed in the API and properly protected
> with natural locking we already need.

Great idea! In a subsequent series, we could arrange the enabling and
disabling of IOPF in this API, thereby eliminating the calling of
iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_IOPF) from the
device drivers.

Best regards,
baolu

