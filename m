Return-Path: <linux-kselftest+bounces-17911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD89776E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5621C24315
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0E1D415E;
	Fri, 13 Sep 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRuSHRU5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2C1D4159
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194239; cv=none; b=RPLXKi/n7g96NRIsXZAXFLU3mupTAc+G3RHuoOFZ/5moc6DEWOu0TR6ksqfU08j72ZS1VgUy9pYpU70I8AXkEBZNWxaspj2nJN+FpHIb2bV+pYZWRo9WZtLcBj+fyTh3aoeiHhQ2b/9BszBpHrJmWsbA7VaXqeApYBq/1NLw6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194239; c=relaxed/simple;
	bh=5GIt/zoCObEEz+c0JNccZ8aHERoDH0RsM8XoHDo3sc8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=opw7JB+G2ZxdaCEhL+sEq7XJ/REYtVOMdfA/HcvkzTevXaHPvwf7G8rqiGjAhOgFAI+8e9pdM9tQ6A4ejSQQLiZ61jjqWT6tj5sW1/mWm+AGRKK0TTPQjI3iqBjAj0PV9NHWbzF1gz6o2954okKTXPqr1mSoacHpUbOhQDDC3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRuSHRU5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726194238; x=1757730238;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5GIt/zoCObEEz+c0JNccZ8aHERoDH0RsM8XoHDo3sc8=;
  b=jRuSHRU5Jp9JctafGbwve2+2QKa9438vJtqCoJY3ifd8pOfNi85XrF7C
   GklFIYjAiy8rTAAwjTpVeQVwZf35ZnJalVOQPF+5GZSCCcCOlEcRG+/u6
   oQPc808vqVJDeuAmhxMi8BQ9RhwDK6HV5tas9OMAnhy8LPUsVAUJFLbP5
   3B8tY+2GBa5g4+/11XV8NhN00s/zToskoDqQZ2wxy3WvkvabACEPgg1Up
   61qNFnlX2lmWNZQCWZKRy9kdbI6KsaB6DSON3JpotnkftJ/5rwURCc+2s
   Sl75FS6YupGp2vSJRCsuJ5zyyS6zDJA3QE9lo7rwiuuRZgxvJIxqsgfvr
   Q==;
X-CSE-ConnectionGUID: bfHilnXxR2ODQHaM2KnitQ==
X-CSE-MsgGUID: mvO1sT2CQHmUvDDz5/ESmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35751085"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="35751085"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:23:57 -0700
X-CSE-ConnectionGUID: c1wosEDYT/25EYqw4UPk2A==
X-CSE-MsgGUID: x48B9biBQlOHo0+MZWArsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="68153085"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 12 Sep 2024 19:21:07 -0700
Message-ID: <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
Date: Fri, 13 Sep 2024 10:17:01 +0800
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
 <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/24 9:35 AM, Baolu Lu wrote:
> On 9/12/24 9:04 PM, Yi Liu wrote:
>> set_dev_pasid op is going to support domain replacement and keep the old
>> hardware config if it fails. Make the Intel iommu driver be prepared for
>> it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 98 ++++++++++++++++++++++++-------------
>>   1 file changed, 65 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 80b587de226d..6f5a8e549f3f 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4248,8 +4248,8 @@ static int intel_iommu_iotlb_sync_map(struct 
>> iommu_domain *domain,
>>       return 0;
>>   }
>> -static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
>> pasid,
>> -                     struct iommu_domain *domain)
>> +static void domain_remove_dev_pasid(struct iommu_domain *domain,
>> +                    struct device *dev, ioasid_t pasid)
>>   {
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>       struct dev_pasid_info *curr, *dev_pasid = NULL;
>> @@ -4257,11 +4257,6 @@ static void intel_iommu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid,
>>       struct dmar_domain *dmar_domain;
>>       unsigned long flags;
>> -    if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>> -        intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>> -        return;
>> -    }
>> -
>>       dmar_domain = to_dmar_domain(domain);
>>       spin_lock_irqsave(&dmar_domain->lock, flags);
>>       list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
>> @@ -4278,13 +4273,24 @@ static void 
>> intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>>       domain_detach_iommu(dmar_domain, iommu);
>>       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>       kfree(dev_pasid);
>> +}
>> +
>> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
>> pasid,
>> +                     struct iommu_domain *domain)
>> +{
>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +    struct intel_iommu *iommu = info->iommu;
>> +
>>       intel_pasid_tear_down_entry(iommu, dev, pasid,
>>                       INTEL_PASID_TEARDOWN_DRAIN_PRQ);
>> +    if (domain->type == IOMMU_DOMAIN_IDENTITY)
>> +        return;
> 
> The static identity domain is not capable of handling page requests.
> Therefore there is no need to drain PRQ for an identity domain removal.
> 
> So it probably should be something like this:
> 
>      if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>          intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>          return;
>      }
> 
>      intel_pasid_tear_down_entry(iommu, dev, pasid,
>                                      INTEL_PASID_TEARDOWN_DRAIN_PRQ);

Just revisited this. It seems that we just need to drain PRQ if the
attached domain is iopf-capable. Therefore, how about making it like
this?

	unsigned int flags = 0;

	if (domain->iopf_handler)
		flags |= INTEL_PASID_TEARDOWN_DRAIN_PRQ;

	intel_pasid_tear_down_entry(iommu, dev, pasid, flags);

	/* Identity domain has no meta data for pasid. */
	if (domain->type == IOMMU_DOMAIN_IDENTITY)
		return;

Thanks,
baolu

