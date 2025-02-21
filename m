Return-Path: <linux-kselftest+bounces-27178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C9A3F855
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B854E179938
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DB210F7E;
	Fri, 21 Feb 2025 15:23:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6720FAAD;
	Fri, 21 Feb 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151435; cv=none; b=a8DDof2hBLeH8nTzEkmLdRs5Mb192OtIFaALVwmhmb88MvVP8XluQWS3u/HNhxKBVB6Ejk1jbIBSLNOtH/HGme6or3Qj8mtEFxoSZX9M7vTFZMikTv0KuGDAR769ksthla+0GmIH8F34dzrJwNXN46YgSi5ad48ZuqdLoDDrwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151435; c=relaxed/simple;
	bh=uQxevZXpFMojCyH7DESAb1y03ZWoLwNE7lYXXVKgIK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Imy9n7CSP62k7mJXfdm4JOpQMufDzu1Bd6V92ggQUvznC1JmYNGAwJSXXMEFcjdA+l5rFF4vJT/GXSQpvtvKVzeAHr5ka9r7ILf71MdQTIaRAup6KGc5k9pBNZgmLDSD5CVMF1zaCz+OroUaa1rb1zGOP/YIAzz03H7aVDuGBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56E2D168F;
	Fri, 21 Feb 2025 07:24:09 -0800 (PST)
Received: from [10.57.36.60] (unknown [10.57.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05253F59E;
	Fri, 21 Feb 2025 07:23:46 -0800 (PST)
Message-ID: <b9b4bfe3-9d2d-4009-b3d4-e179e8bccd9a@arm.com>
Date: Fri, 21 Feb 2025 15:23:22 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
 joro@8bytes.org, will@kernel.org, shuah@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
 jacob.pan@linux.microsoft.com, patches@lists.linux.dev
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
 <20250221143959.GA272220@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250221143959.GA272220@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-21 2:39 pm, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 05:31:42PM -0800, Nicolin Chen wrote:
>> Now that iommufd does not rely on dma-iommu.c for any purpose. We can
>> combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the same
>> union. This union is effectively 'owner data' and can be used by the
>> entity that allocated the domain. Note that legacy vfio type1 flows
>> continue to use dma-iommu.c for sw_msi and still need iova_cookie.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   include/linux/iommu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index e93d2e918599..99dd72998cb7 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -216,7 +216,6 @@ struct iommu_domain {
>>   	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
>>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>>   	struct iommu_domain_geometry geometry;
>> -	struct iommu_dma_cookie *iova_cookie;
>>   	int (*iopf_handler)(struct iopf_group *group);
>>   
>>   #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>> @@ -225,6 +224,7 @@ struct iommu_domain {
>>   #endif
>>   
>>   	union { /* Pointer usable by owner of the domain */
>> +		struct iommu_dma_cookie *iova_cookie; /* dma-iommu */
>>   		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
>>   	};
> 
> Ugh, there is a problem here:
> 
> void iommu_domain_free(struct iommu_domain *domain)
> {
> 	if (domain->type == IOMMU_DOMAIN_SVA)
> 		mmdrop(domain->mm);
> 	iommu_put_dma_cookie(domain);
> 
> It calls into dma-iommu for all domain types
> 
> And if !CONFIG_IRQ_MSI_IOMMU then this isn't possible to protect it
> against iommufd owning the cookie union:
> 
> #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> 	if (domain->sw_msi != iommu_dma_sw_msi)
> 		return;
> #endif
> 
> I came up with the below, but I will drop this patch for now you can
> repost it as a cleanup series..

Eww... What's the issue with just checking the domain type in 
iommu_put_dma_cookie()? Is is that IOMMUFD and VFIO type 1 are both 
doing their own different thing with IOMMU_DOMAIN_UNMANAGED?

In general it seems like a bad smell to have a union in a structure with 
not enough information within that structire itself to know which union 
member is valid... :/

Thanks,
Robin.

> 
> Jason
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3b58244e6344a5..31d53552dc4790 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -418,6 +418,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>    * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
>    * used by the devices attached to @domain.
>    */
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>   int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   {
>   	struct iommu_dma_cookie *cookie;
> @@ -439,6 +440,13 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   }
>   EXPORT_SYMBOL(iommu_get_msi_cookie);
>   
> +void iommu_put_msi_cookie(struct iommu_domain *domain)
> +{
> +	iommu_put_dma_cookie(domain);
> +}
> +EXPORT_SYMBOL_GPL(iommu_put_msi_cookie);
> +#endif
> +
>   /**
>    * iommu_put_dma_cookie - Release a domain's DMA mapping resources
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
> @@ -449,8 +457,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iommu_dma_msi_page *msi, *tmp;
>   
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>   	if (domain->sw_msi != iommu_dma_sw_msi)
>   		return;
> +#endif
>   
>   	if (!cookie)
>   		return;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 022bf96a18c5e4..f07544b290e5b1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -456,6 +456,12 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
>   	return ret;
>   }
>   
> +static void iommu_default_domain_free(struct iommu_domain *domain)
> +{
> +	iommu_put_dma_cookie(domain);
> +	iommu_domain_free(domain);
> +}
> +
>   static void iommu_deinit_device(struct device *dev)
>   {
>   	struct iommu_group *group = dev->iommu_group;
> @@ -494,7 +500,7 @@ static void iommu_deinit_device(struct device *dev)
>   	 */
>   	if (list_empty(&group->devices)) {
>   		if (group->default_domain) {
> -			iommu_domain_free(group->default_domain);
> +			iommu_default_domain_free(group->default_domain);
>   			group->default_domain = NULL;
>   		}
>   		if (group->blocking_domain) {
> @@ -2023,7 +2029,6 @@ void iommu_domain_free(struct iommu_domain *domain)
>   {
>   	if (domain->type == IOMMU_DOMAIN_SVA)
>   		mmdrop(domain->mm);
> -	iommu_put_dma_cookie(domain);
>   	if (domain->ops->free)
>   		domain->ops->free(domain);
>   }
> @@ -3000,7 +3005,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   
>   out_free_old:
>   	if (old_dom)
> -		iommu_domain_free(old_dom);
> +		iommu_default_domain_free(old_dom);
>   	return ret;
>   
>   err_restore_domain:
> @@ -3009,7 +3014,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>   err_restore_def_domain:
>   	if (old_dom) {
> -		iommu_domain_free(dom);
> +		iommu_default_domain_free(dom);
>   		group->default_domain = old_dom;
>   	}
>   	return ret;
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 50ebc9593c9d70..b5bb946c9c1b19 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2271,6 +2271,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   			if (!iommu_attach_group(d->domain,
>   						group->iommu_group)) {
>   				list_add(&group->next, &d->group_list);
> +				iommu_put_msi_cookie(domain->domain);
>   				iommu_domain_free(domain->domain);
>   				kfree(domain);
>   				goto done;
> @@ -2316,6 +2317,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>   out_detach:
>   	iommu_detach_group(domain->domain, group->iommu_group);
>   out_domain:
> +	iommu_put_msi_cookie(domain->domain);
>   	iommu_domain_free(domain->domain);
>   	vfio_iommu_iova_free(&iova_copy);
>   	vfio_iommu_resv_free(&group_resv_regions);
> @@ -2496,6 +2498,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>   					vfio_iommu_unmap_unpin_reaccount(iommu);
>   				}
>   			}
> +			iommu_put_msi_cookie(domain->domain);
>   			iommu_domain_free(domain->domain);
>   			list_del(&domain->next);
>   			kfree(domain);
> @@ -2567,6 +2570,7 @@ static void vfio_release_domain(struct vfio_domain *domain)
>   		kfree(group);
>   	}
>   
> +	iommu_put_msi_cookie(domain->domain);
>   	iommu_domain_free(domain->domain);
>   }
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 99dd72998cb7f7..082274e8ba6a3d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1534,12 +1534,16 @@ void iommu_debugfs_setup(void);
>   static inline void iommu_debugfs_setup(void) {}
>   #endif
>   
> -#ifdef CONFIG_IOMMU_DMA
> +#if defined(CONFIG_IOMMU_DMA) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>   int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> +void iommu_put_msi_cookie(struct iommu_domain *domain);
>   #else /* CONFIG_IOMMU_DMA */
>   static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   {
> -	return -ENODEV;
> +	return 0;
> +}
> +static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
> +{
>   }
>   #endif	/* CONFIG_IOMMU_DMA */
>   


