Return-Path: <linux-kselftest+bounces-27179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0047A3F926
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8AE1882D66
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9961BBBF7;
	Fri, 21 Feb 2025 15:39:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477745009;
	Fri, 21 Feb 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152394; cv=none; b=cNuMcZA5pHDm3ZGm43pukON7/fC74iNCx40std/RzFxOegWqkBZ7Mwy82w6PCwFZAYbxqJCF4/wWyTrd3p/MneZPLyOGGdUeH/5MLc0DNPQntX94M3e/SMuU6ZVEUhjjNDU/GhhS0xnQan1KiYDZtFNf2SlvK+kM4Xtxmj3shoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152394; c=relaxed/simple;
	bh=93zTaU6eg48C24RtWHpt4n45x2dQUGHjZDmPY7Frpw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbodVo47AH1tQ48GOMJ5Erp4QIPzW1jbgYE0Iz/qA/+c7GHEUhMUF1trYonNaz2NiWArrm5wo6qAbv+uFW8lriUFio4Ke+rgoJFPDsZDd6JV7mbdkrS0uMEwCQcZM/DS0CFgShC5UMvr3flaDYs2BnxJH4XoEuV9cmkL0uAf8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD4C168F;
	Fri, 21 Feb 2025 07:40:08 -0800 (PST)
Received: from [10.57.36.60] (unknown [10.57.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 381703F59E;
	Fri, 21 Feb 2025 07:39:47 -0800 (PST)
Message-ID: <5b9e15e1-8081-46ef-b9db-3872e98a6f35@arm.com>
Date: Fri, 21 Feb 2025 15:39:45 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] iommu: Make iommu_dma_prepare_msi() into a generic
 operation
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 tglx@linutronix.de, maz@kernel.org
Cc: joro@8bytes.org, will@kernel.org, shuah@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com, patches@lists.linux.dev
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-20 1:31 am, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> SW_MSI supports IOMMU to translate an MSI message before the MSI message
> is delivered to the interrupt controller. On such systems, an iommu_domain
> must have a translation for the MSI message for interrupts to work.
> 
> The IRQ subsystem will call into IOMMU to request that a physical page be
> set up to receive MSI messages, and the IOMMU then sets an IOVA that maps
> to that physical page. Ultimately the IOVA is programmed into the device
> via the msi_msg.
> 
> Generalize this by allowing iommu_domain owners to provide implementations
> of this mapping. Add a function pointer in struct iommu_domain to allow a
> domain owner to provide its own implementation.
> 
> Have dma-iommu supply its implementation for IOMMU_DOMAIN_DMA types during
> the iommu_get_dma_cookie() path. For IOMMU_DOMAIN_UNMANAGED types used by
> VFIO (and iommufd for now), have the same iommu_dma_sw_msi set as well in
> the iommu_get_msi_cookie() path.
> 
> Hold the group mutex while in iommu_dma_prepare_msi() to ensure the domain
> doesn't change or become freed while running. Races with IRQ operations
> from VFIO and domain changes from iommufd are possible here.
> 
> Replace the msi_prepare_lock with a lockdep assertion for the group mutex
> as documentation. For the dmau_iommu.c each iommu_domain is unique to a
> group.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h     | 44 ++++++++++++++++++++++++++-------------
>   drivers/iommu/dma-iommu.c | 33 +++++++++++++----------------
>   drivers/iommu/iommu.c     | 29 ++++++++++++++++++++++++++
>   3 files changed, 73 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index caee952febd4..761c5e186de9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,8 @@ struct iommu_dma_cookie;
>   struct iommu_fault_param;
>   struct iommufd_ctx;
>   struct iommufd_viommu;
> +struct msi_desc;
> +struct msi_msg;
>   
>   #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>   #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
> @@ -216,6 +218,12 @@ struct iommu_domain {
>   	struct iommu_domain_geometry geometry;
>   	struct iommu_dma_cookie *iova_cookie;
>   	int (*iopf_handler)(struct iopf_group *group);
> +
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> +	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> +		      phys_addr_t msi_addr);
> +#endif
> +
>   	void *fault_data;
>   	union {
>   		struct {
> @@ -234,6 +242,16 @@ struct iommu_domain {
>   	};
>   };
>   
> +static inline void iommu_domain_set_sw_msi(
> +	struct iommu_domain *domain,
> +	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> +		      phys_addr_t msi_addr))
> +{
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> +	domain->sw_msi = sw_msi;
> +#endif
> +}

Yuck. Realistically we are going to have no more than two different 
implementations of this; a fiddly callback interface seems overkill. All 
we should need in the domain is a simple indicator of *which* MSI 
translation scheme is in use (if it can't be squeezed into the domain 
type itself), then iommu_dma_prepare_msi() can simply dispatch between 
iommu-dma and IOMMUFD based on that, and then it's easy to solve all the 
other fragility issues too.

Thanks,
Robin.

> +
>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>   {
>   	return domain->type & __IOMMU_DOMAIN_DMA_API;
> @@ -1470,6 +1488,18 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
>   static inline void iommu_free_global_pasid(ioasid_t pasid) {}
>   #endif /* CONFIG_IOMMU_API */
>   
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +#ifdef CONFIG_IOMMU_API
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> +#else
> +static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
> +					phys_addr_t msi_addr)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IOMMU_API */
> +#endif /* CONFIG_IRQ_MSI_IOMMU */
> +
>   #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
>   void iommu_group_mutex_assert(struct device *dev);
>   #else
> @@ -1503,26 +1533,12 @@ static inline void iommu_debugfs_setup(void) {}
>   #endif
>   
>   #ifdef CONFIG_IOMMU_DMA
> -#include <linux/msi.h>
> -
>   int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> -
> -int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> -
>   #else /* CONFIG_IOMMU_DMA */
> -
> -struct msi_desc;
> -struct msi_msg;
> -
>   static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   {
>   	return -ENODEV;
>   }
> -
> -static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> -{
> -	return 0;
> -}
>   #endif	/* CONFIG_IOMMU_DMA */
>   
>   /*
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index bf91e014d179..3b58244e6344 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -24,6 +24,7 @@
>   #include <linux/memremap.h>
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
> +#include <linux/msi.h>
>   #include <linux/of_iommu.h>
>   #include <linux/pci.h>
>   #include <linux/scatterlist.h>
> @@ -102,6 +103,9 @@ static int __init iommu_dma_forcedac_setup(char *str)
>   }
>   early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>   
> +static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +			    phys_addr_t msi_addr);
> +
>   /* Number of entries per flush queue */
>   #define IOVA_DEFAULT_FQ_SIZE	256
>   #define IOVA_SINGLE_FQ_SIZE	32768
> @@ -398,6 +402,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   		return -ENOMEM;
>   
>   	mutex_init(&domain->iova_cookie->mutex);
> +	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>   	return 0;
>   }
>   
> @@ -429,6 +434,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   
>   	cookie->msi_iova = base;
>   	domain->iova_cookie = cookie;
> +	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>   	return 0;
>   }
>   EXPORT_SYMBOL(iommu_get_msi_cookie);
> @@ -443,6 +449,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iommu_dma_msi_page *msi, *tmp;
>   
> +	if (domain->sw_msi != iommu_dma_sw_msi)
> +		return;
> +
>   	if (!cookie)
>   		return;
>   
> @@ -1800,33 +1809,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	return NULL;
>   }
>   
> -/**
> - * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
> - * @desc: MSI descriptor, will store the MSI page
> - * @msi_addr: MSI target address to be mapped
> - *
> - * Return: 0 on success or negative error code if the mapping failed.
> - */
> -int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> +static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +			    phys_addr_t msi_addr)
>   {
>   	struct device *dev = msi_desc_to_dev(desc);
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iommu_dma_msi_page *msi_page;
> -	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
> +	const struct iommu_dma_msi_page *msi_page;
>   
> -	if (!domain || !domain->iova_cookie) {
> +	if (!domain->iova_cookie) {
>   		msi_desc_set_iommu_msi_iova(desc, 0, 0);
>   		return 0;
>   	}
>   
> -	/*
> -	 * In fact the whole prepare operation should already be serialised by
> -	 * irq_domain_mutex further up the callchain, but that's pretty subtle
> -	 * on its own, so consider this locking as failsafe documentation...
> -	 */
> -	mutex_lock(&msi_prepare_lock);
> +	iommu_group_mutex_assert(dev);
>   	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
> -	mutex_unlock(&msi_prepare_lock);
>   	if (!msi_page)
>   		return -ENOMEM;
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 870c3cdbd0f6..022bf96a18c5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3596,3 +3596,32 @@ int iommu_replace_group_handle(struct iommu_group *group,
>   	return ret;
>   }
>   EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
> +
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> +/**
> + * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
> + * @desc: MSI descriptor, will store the MSI page
> + * @msi_addr: MSI target address to be mapped
> + *
> + * The implementation of sw_msi() should take msi_addr and map it to
> + * an IOVA in the domain and call msi_desc_set_iommu_msi_iova() with the
> + * mapping information.
> + *
> + * Return: 0 on success or negative error code if the mapping failed.
> + */
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> +{
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct iommu_group *group = dev->iommu_group;
> +	int ret = 0;
> +
> +	if (!group)
> +		return 0;
> +
> +	mutex_lock(&group->mutex);
> +	if (group->domain && group->domain->sw_msi)
> +		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +#endif /* CONFIG_IRQ_MSI_IOMMU */


