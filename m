Return-Path: <linux-kselftest+bounces-15029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4394BDA9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728D9B242E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C718C918;
	Thu,  8 Aug 2024 12:38:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8B18C910;
	Thu,  8 Aug 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120733; cv=none; b=q8yeH86BAM810YEVC8Fdsd28XwDV3QsUwnH7D4Ic4AMzrJZY9/Ps03jvmmwe0EOwD9eYjIoBTa09fe5EKSUHJBK6WIEoBwF/8cLKrqGWspwgG1h59fX3N98uBjBZBT3nXwluuTA0XnF7o1qNBmQ/JY9Af3T1GJzJwfDqw9ILM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120733; c=relaxed/simple;
	bh=GcvSFJMKHLhNFNdb66dJFFYuo+iitWi4Lo3O6EpjwWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUdvVZ94+OFYXsIU386WYWzle4UU8XzAQuQEZ9lkSPZYrkGeIoihCJ2rCcJjc8KKrHv6HLT5wxAQmkOQlQ/w3GACoRvWBNpeARWEzMV9wJBCSvO/ZtG3q5m0K5h5VrcZ6MKiFbFXAgGCju6zSkYuao1fFQVo3K9hMpNP833aTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E407FEC;
	Thu,  8 Aug 2024 05:39:16 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E703F766;
	Thu,  8 Aug 2024 05:38:49 -0700 (PDT)
Message-ID: <6da4f216-594b-4c51-848c-86e281402820@arm.com>
Date: Thu, 8 Aug 2024 13:38:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2024 9:25 am, Tian, Kevin wrote:
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Saturday, August 3, 2024 8:32 AM
>>
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Currently, iommu-dma is the only place outside of IOMMUFD and drivers
>> which might need to be aware of the stage 2 domain encapsulated within
>> a nested domain. This would be in the legacy-VFIO-style case where we're
> 
> why is it a legacy-VFIO-style? We only support nested in IOMMUFD.

Because with proper nesting we ideally shouldn't need the host-managed 
MSI mess at all, which all stems from the old VFIO paradigm of 
completely abstracting interrupts from userspace. I'm still hoping 
IOMMUFD can grow its own interface for efficient MSI passthrough, where 
the VMM can simply map the physical MSI doorbell into whatever IPA (GPA) 
it wants it to appear at in the S2 domain, then whatever the guest does 
with S1 it can program the MSI address into the endpoint accordingly 
without us having to fiddle with it.

FWIW, apart from IOMMUFD, we may also end up wanting something along 
those lines for Arm CCA (if non-Secure proxying of T=1 MSIs becomes an 
unavoidable thing).

>> using host-managed MSIs with an identity mapping at stage 1, where it is
>> the underlying stage 2 domain which owns an MSI cookie and holds the
>> corresponding dynamic mappings. Hook up the new op to resolve what we
>> need from a nested domain.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
>>   include/linux/iommu.h     |  4 ++++
>>   2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 7b1dfa0665df6..05e04934a5f81 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1799,6 +1799,20 @@ static struct iommu_dma_msi_page
>> *iommu_dma_get_msi_page(struct device *dev,
>>   	return NULL;
>>   }
>>
>> +/*
>> + * Nested domains may not have an MSI cookie or accept mappings, but
>> they may
>> + * be related to a domain which does, so we let them tell us what they need.
>> + */
>> +static struct iommu_domain
>> *iommu_dma_get_msi_mapping_domain(struct device *dev)
>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
>> +	    domain->ops->get_msi_mapping_domain)
> 
> I'm not sure the core should restrict it to the NESTED type. Given
> there is a new domain ops any type restriction can be handled
> inside the callback. Anyway the driver should register the op
> for a domain only when there is a need.

Nested should remain the only case where domains are chained together 
such that the VFIO MSI cookie may be hiding somewhere else. This is 
effectively documenting that implementing the callback for any other 
domain type would be a bad smell. Much like how the mapping-related ops 
are explicitly short-circuited for non-paging domain types.

Thanks,
Robin.

>> +		domain = domain->ops->get_msi_mapping_domain(domain);
>> +	return domain;
>> +}
>> +
>>   /**
>>    * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
>>    * @desc: MSI descriptor, will store the MSI page
>> @@ -1809,7 +1823,7 @@ static struct iommu_dma_msi_page
>> *iommu_dma_get_msi_page(struct device *dev,
>>   int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>>   {
>>   	struct device *dev = msi_desc_to_dev(desc);
>> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +	struct iommu_domain *domain =
>> iommu_dma_get_msi_mapping_domain(dev);
>>   	struct iommu_dma_msi_page *msi_page;
>>   	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>>
>> @@ -1842,7 +1856,7 @@ int iommu_dma_prepare_msi(struct msi_desc
>> *desc, phys_addr_t msi_addr)
>>   void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg
>> *msg)
>>   {
>>   	struct device *dev = msi_desc_to_dev(desc);
>> -	const struct iommu_domain *domain =
>> iommu_get_domain_for_dev(dev);
>> +	const struct iommu_domain *domain =
>> iommu_dma_get_msi_mapping_domain(dev);
>>   	const struct iommu_dma_msi_page *msi_page;
>>
>>   	msi_page = msi_desc_get_iommu_cookie(desc);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 4d47f2c333118..69ed76f9c3ec4 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -638,6 +638,8 @@ struct iommu_ops {
>>    * @enable_nesting: Enable nesting
>>    * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>>    * @free: Release the domain after use.
>> + * @get_msi_mapping_domain: Return the related iommu_domain that
>> should hold the
>> + *                          MSI cookie and accept mapping(s).
>>    */
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>> @@ -668,6 +670,8 @@ struct iommu_domain_ops {
>>   				  unsigned long quirks);
>>
>>   	void (*free)(struct iommu_domain *domain);
>> +	struct iommu_domain *
>> +		(*get_msi_mapping_domain)(struct iommu_domain
>> *domain);
>>   };
>>
>>   /**
>> --
>> 2.43.0
>>
> 

