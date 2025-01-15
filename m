Return-Path: <linux-kselftest+bounces-24549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE269A1184A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 05:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E824C18898E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3922DF94;
	Wed, 15 Jan 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4ltg5pB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2F41760;
	Wed, 15 Jan 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736914879; cv=none; b=k0LNA+24WN5nMz9vs9Ywyl5AKKt8AJBd5i5U/cyMH1KCLx3QZL49qipU6bZSlU6Uoq5Ptr7wR3zxZm2sroGM61aKMLNPTEG5nfv/grZ89VrlgqACdwGNk7XzzVFIz+1AsqxRiWZ53WDC7FbLhpsi6IZgH3WDoCihlCrFm/DMT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736914879; c=relaxed/simple;
	bh=3rFYJALYYbhxxnudzMeaTd5kMgkFPmbCtEpp0iUEI9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmmIiu6c2DJu4PIcc5Uijd51QonJ5n0hvLjXn6Ai3dFaNBFwVhEo47CSnLO+0oAkqiYM3PrKOi8U19mx2MnCpMBihFPHIjKw6QUnyJM4UrK1UIHmxx2nlNO5miDGYerM6FhPMZtGgLnbgkch445U9OFyv1JHJ4b1zVuYjiViP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4ltg5pB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e46c6547266so9405978276.3;
        Tue, 14 Jan 2025 20:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736914877; x=1737519677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgmN9xvwVj3LAmFGvyYYHW/VcizSKvb2hYyIiEhfLdY=;
        b=d4ltg5pBuAQ1cZYUlAOCMlD9W4cNiZgHxnHTRWB8nRUfJI9Urehepo5tgX3Hjm5Rbk
         +x6oDpnLA7RqdXzxiH3OFcsEgVj8yFMS+D0LseO8hBYDDcG7wY3YAumDdshGDtmXFbht
         xWLG0XSYjOlfCfxxXy56yX4lztwcRv7GY6470W9Pw1NXUliuft6XsaPy3lsyt2XWuSNJ
         Knnrf42gHN4assst4sSfPpbuJkvkkQrTpQ+JWEuOyYeN4uINE4EeEY1fk5kzotgO05bZ
         ICbKnnMGWM2mer+in0nRQ/nImqF96vCcNflvMhNrES4j4h7uVDzbrF/sx5IASVHihAXA
         fgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736914877; x=1737519677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgmN9xvwVj3LAmFGvyYYHW/VcizSKvb2hYyIiEhfLdY=;
        b=PwL7rGRKJWZ5FHvGPDhuvHtDQnUIzUXdcZHe8CVeqChuzUZ2AafWU5szA0STt7514+
         JMpKWmGXFC5QbweVJ34ZKOkYnBHSjyTbObvoDfh9DRiv8uncK3eq2lxOH8rNlMJjDB8w
         Jll1Hp2vwBLaH35ZG1aVg4fr4gWoB2WtIPZ0UsySYWyaur7n2ng7kcOfseZIK1/3iho8
         Jo3YVmg3K3kYvXV9BNDhrGba0U6kJy/+e7XdYLF9ulcfgDVcAmdvQnhe7OCltwoF803l
         gl1X7JV2B51wxHyvOSsWiXgyC+Mf6z0W4Qxt7K/eL0DC97go++bVjpQmf7xY18XjlDeO
         F9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9qQCUiaDp2rASqAGEs2hvhS6ktAQTEPcBaY+RDUARUUjmNFu4XhkP9KJVUQtB0wBZWLv0n4EkmMY95U/jqUH@vger.kernel.org, AJvYcCV7fMeqSTRlH23HclVVN/YZlq3wUU5+b+ODI1AyOhA/ZpVFPSsKsVmWyjzihcBGg8GJjDQXDtHEmnxsnPKu@vger.kernel.org, AJvYcCWU2V92BljnFXGRIpQ0gBsLRhIx/VtH4EaquWlSVSjNOG0CPVsSCkciCyUI90nDHfqgGkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8U03OJBArajzmVwSmhi1B4VHpQMk4Pm4KLZy5mogOKj8qBZqh
	RNF/jcAGAOAOBOosCgZ636HsC4mVnTZ2UZ83V+proXTp3BOm0GbT
X-Gm-Gg: ASbGncuNZuFYFvlYM4Np3O7Q8k0ECKF1U65NzeFy6yNyqzwrnautd7XRLCN772fuIM0
	b09D9rJqo3v5zdR6vUP6KB24XsJso133R1GDGr81TQa3NRQwJp9CCvnHKADVFuneYjXQFDeFUSn
	KrBzklL1WlWeC0ktJFYUjRdL0mTa7HOvcEBTvxcbDPigtnc4+G7GuagKrw7TJlJqUaxv+zllOIa
	Y5dfKEGm/NH/LvgOI9nMpe49HJkT9rdHJqF23Cba3KxYPneXXVsj13q
X-Google-Smtp-Source: AGHT+IHrwG631JlG6Kmi6EHjrQvbmsegz/2N5eZ1vXYpkplcJETDUhBkp5msbW+dENi/QpXLNfCV2w==
X-Received: by 2002:a05:690c:31a:b0:6ef:7370:96ee with SMTP id 00721157ae682-6f5312209femr224981027b3.12.1736914876619;
        Tue, 14 Jan 2025 20:21:16 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c25dc1sm24136237b3.22.2025.01.14.20.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 20:21:15 -0800 (PST)
Date: Tue, 14 Jan 2025 23:21:13 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
	kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	alex.williamson@redhat.com, joro@8bytes.org, shuah@kernel.org,
	reinette.chatre@intel.com, eric.auger@redhat.com,
	yebin10@huawei.com, apatel@ventanamicro.com,
	shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
	anna-maria@linutronix.de, nipun.gupta@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFCv2 07/13] iommufd: Implement sw_msi support natively
Message-ID: <Z4c3ueuDgM7YqElp@thinkpad>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <f70451cf4274bc5955824efe9f98ec7dfdd10927.1736550979.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70451cf4274bc5955824efe9f98ec7dfdd10927.1736550979.git.nicolinc@nvidia.com>

On Fri, Jan 10, 2025 at 07:32:23PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> iommufd has a model where the iommu_domain can be changed while the VFIO
> device is attached. In this case the MSI should continue to work. This
> corner case has not worked because the dma-iommu implementation of sw_msi
> is tied to a single domain.
> 
> Implement the sw_msi mapping directly and use a global per-fd table to
> associate assigned iova to the MSI pages. This allows the MSI pages to
> loaded into a domain before it is attached ensuring that MSI is not

s/loaded/be loaded/ ?

> disrupted.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: set sw_msi pointer in nested hwpt allocators]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  23 +++-
>  drivers/iommu/iommufd/device.c          | 158 ++++++++++++++++++++----
>  drivers/iommu/iommufd/hw_pagetable.c    |   3 +
>  drivers/iommu/iommufd/main.c            |   9 ++
>  4 files changed, 170 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 063c0a42f54f..3e83bbb5912c 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -19,6 +19,22 @@ struct iommu_group;
>  struct iommu_option;
>  struct iommufd_device;
>  
> +struct iommufd_sw_msi_map {
> +	struct list_head sw_msi_item;
> +	phys_addr_t sw_msi_start;
> +	phys_addr_t msi_addr;
> +	unsigned int pgoff;
> +	unsigned int id;
> +};
> +
> +/* Bitmap of struct iommufd_sw_msi_map::id */
> +struct iommufd_sw_msi_maps {
> +	DECLARE_BITMAP(bitmap, 64);
> +};
> +
> +int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		   phys_addr_t msi_addr);
> +
>  struct iommufd_ctx {
>  	struct file *file;
>  	struct xarray objects;
> @@ -26,6 +42,10 @@ struct iommufd_ctx {
>  	wait_queue_head_t destroy_wait;
>  	struct rw_semaphore ioas_creation_lock;
>  
> +	struct mutex sw_msi_lock;
> +	struct list_head sw_msi_list;
> +	unsigned int sw_msi_id;
> +
>  	u8 account_mode;
>  	/* Compatibility with VFIO no iommu */
>  	u8 no_iommu_mode;
> @@ -283,10 +303,10 @@ struct iommufd_hwpt_paging {
>  	struct iommufd_ioas *ioas;
>  	bool auto_domain : 1;
>  	bool enforce_cache_coherency : 1;
> -	bool msi_cookie : 1;
>  	bool nest_parent : 1;
>  	/* Head at iommufd_ioas::hwpt_list */
>  	struct list_head hwpt_item;
> +	struct iommufd_sw_msi_maps present_sw_msi;
>  };
>  
>  struct iommufd_hwpt_nested {
> @@ -383,6 +403,7 @@ struct iommufd_group {
>  	struct iommu_group *group;
>  	struct iommufd_hw_pagetable *hwpt;
>  	struct list_head device_list;
> +	struct iommufd_sw_msi_maps required_sw_msi;
>  	phys_addr_t sw_msi_start;
>  };
>  
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 38b31b652147..f75b3c23cd41 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -5,6 +5,7 @@
>  #include <linux/iommufd.h>
>  #include <linux/slab.h>
>  #include <uapi/linux/iommufd.h>
> +#include <linux/msi.h>
>  
>  #include "../iommu-priv.h"
>  #include "io_pagetable.h"
> @@ -293,36 +294,149 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
>  
> +/*
> + * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
> + * layer. The mapping to IOVA is global to the iommufd file descriptor, every
> + * domain that is attached to a device using the same MSI parameters will use
> + * the same IOVA.
> + */
> +static struct iommufd_sw_msi_map *
> +iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
> +		       phys_addr_t sw_msi_start)
> +{
> +	struct iommufd_sw_msi_map *cur;
> +	unsigned int max_pgoff = 0;
> +
> +	lockdep_assert_held(&ictx->sw_msi_lock);
> +
> +	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
> +		if (cur->sw_msi_start != sw_msi_start)
> +			continue;
> +		max_pgoff = max(max_pgoff, cur->pgoff + 1);
> +		if (cur->msi_addr == msi_addr)
> +			return cur;
> +	}
> +
> +	if (ictx->sw_msi_id >=
> +	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
> +	if (!cur)
> +		cur = ERR_PTR(-ENOMEM);
> +	cur->sw_msi_start = sw_msi_start;
> +	cur->msi_addr = msi_addr;
> +	cur->pgoff = max_pgoff;
> +	cur->id = ictx->sw_msi_id++;
> +	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
> +	return cur;
> +}
> +
> +static int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
> +				  struct iommufd_hwpt_paging *hwpt_paging,
> +				  struct iommufd_sw_msi_map *msi_map)
> +{
> +	unsigned long iova;
> +
> +	lockdep_assert_held(&ictx->sw_msi_lock);
> +
> +	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
> +	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
> +		int rc;
> +
> +		rc = iommu_map(hwpt_paging->common.domain, iova,
> +			       msi_map->msi_addr, PAGE_SIZE,
> +			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
> +			       GFP_KERNEL_ACCOUNT);
> +		if (rc)
> +			return rc;
> +		set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
> +	}
> +	return 0;
> +}

So, does sw_msi_lock protect the present_sw_msi bitmap? If so, you
should use non-atomic __set_bit(). If not, you'd do something like:

        if (test_and_set_bit(...))
                return 0;

        rc = iommu_map(...);
        if (rc)
                clear_bit(...);

        return rc

Now it looks like a series of atomic accesses, which is not atomic, and it
misleads...

> +
> +/*
> + * Called by the irq code if the platform translates the MSI address through the
> + * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
> + * allocate a fd global iova for the physical page that is the same on all
> + * domains and devices.
> + */
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		   phys_addr_t msi_addr)
> +{
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct iommu_attach_handle *raw_handle;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_attach_handle *handle;
> +	struct iommufd_sw_msi_map *msi_map;
> +	struct iommufd_ctx *ictx;
> +	unsigned long iova;
> +	int rc;
> +
> +	raw_handle =
> +		iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);

Nit: no need to break the line.

> +	if (!raw_handle)
> +		return 0;
> +	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
> +
> +	handle = to_iommufd_handle(raw_handle);
> +	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
> +	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
> +		return 0;
> +
> +	ictx = handle->idev->ictx;
> +	guard(mutex)(&ictx->sw_msi_lock);
> +	/*
> +	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
> +	 * assume the caller has checked that it is contained with a MMIO region
> +	 * that is secure to map at PAGE_SIZE.
> +	 */
> +	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
> +					 msi_addr & PAGE_MASK,
> +					 handle->idev->igroup->sw_msi_start);
> +	if (IS_ERR(msi_map))
> +		return PTR_ERR(msi_map);
> +
> +	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
> +	if (rc)
> +		return rc;
> +	set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);

Same here. I guess, sw_msi_lock protects required_sw_msi.bitmap,
right?

Thanks,
Yury

> +
> +	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
> +	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * FIXME: when a domain is removed any ids that are not in the union of
> + * all still attached devices should be removed.
> + */
> +
>  static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>  				   struct iommufd_hwpt_paging *hwpt_paging)
>  {
> -	phys_addr_t sw_msi_start = igroup->sw_msi_start;
> -	int rc;
> +	struct iommufd_ctx *ictx = igroup->ictx;
> +	struct iommufd_sw_msi_map *cur;
> +
> +	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
> +		return 0;
>  
>  	/*
> -	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
> -	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
> -	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
> -	 * domain after request_irq(). If it is not done interrupts will not
> -	 * work on this domain.
> -	 *
> -	 * FIXME: This is conceptually broken for iommufd since we want to allow
> -	 * userspace to change the domains, eg switch from an identity IOAS to a
> -	 * DMA IOAS. There is currently no way to create a MSI window that
> -	 * matches what the IRQ layer actually expects in a newly created
> -	 * domain.
> +	 * Install all the MSI pages the device has been using into the domain
>  	 */
> -	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt_paging->msi_cookie) {
> -		rc = iommu_get_msi_cookie(hwpt_paging->common.domain,
> -					  sw_msi_start);
> +	guard(mutex)(&ictx->sw_msi_lock);
> +	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
> +		int rc;
> +
> +		if (cur->sw_msi_start != igroup->sw_msi_start ||
> +		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
> +			continue;
> +
> +		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
>  		if (rc)
>  			return rc;
> -
> -		/*
> -		 * iommu_get_msi_cookie() can only be called once per domain,
> -		 * it returns -EBUSY on later calls.
> -		 */
> -		hwpt_paging->msi_cookie = true;
>  	}
>  	return 0;
>  }
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index f7c0d7b214b6..538484eecb3b 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -156,6 +156,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  			goto out_abort;
>  		}
>  	}
> +	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>  
>  	/*
>  	 * Set the coherency mode before we do iopt_table_add_domain() as some
> @@ -251,6 +252,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>  		goto out_abort;
>  	}
>  	hwpt->domain->owner = ops;
> +	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>  
>  	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>  		rc = -EINVAL;
> @@ -303,6 +305,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
>  		goto out_abort;
>  	}
>  	hwpt->domain->owner = viommu->iommu_dev->ops;
> +	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>  
>  	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>  		rc = -EINVAL;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 97c5e3567d33..7cc9497b7193 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -227,6 +227,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>  	xa_init(&ictx->groups);
>  	ictx->file = filp;
>  	init_waitqueue_head(&ictx->destroy_wait);
> +	mutex_init(&ictx->sw_msi_lock);
> +	INIT_LIST_HEAD(&ictx->sw_msi_list);
>  	filp->private_data = ictx;
>  	return 0;
>  }
> @@ -234,6 +236,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>  static int iommufd_fops_release(struct inode *inode, struct file *filp)
>  {
>  	struct iommufd_ctx *ictx = filp->private_data;
> +	struct iommufd_sw_msi_map *next;
> +	struct iommufd_sw_msi_map *cur;
>  	struct iommufd_object *obj;
>  
>  	/*
> @@ -262,6 +266,11 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>  			break;
>  	}
>  	WARN_ON(!xa_empty(&ictx->groups));
> +
> +	mutex_destroy(&ictx->sw_msi_lock);
> +	list_for_each_entry_safe(cur, next, &ictx->sw_msi_list, sw_msi_item)
> +		kfree(cur);
> +
>  	kfree(ictx);
>  	return 0;
>  }
> -- 
> 2.43.0

