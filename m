Return-Path: <linux-kselftest+bounces-25023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF227A1A89E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469E916CE53
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060CC14A4FB;
	Thu, 23 Jan 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NToe/0Ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE91145B39
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652260; cv=none; b=fXRixfNZipa5SBIZsd+YT6hjIQ3MrC9uTsLhFlcWUDjZuj0Wuj7iKFvGLsMvAhyWAIsRWRDSEPcF2M7+1DykF/IDDEcNUjE+uxQPxL74yWqDX1S7F3dSNJNxqM0EFWAovV7MFbHljnYLjkbbtXUqwzi7y/6YoCygZn4fqzRgAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652260; c=relaxed/simple;
	bh=So1bT6v/8IBUYr9O0B8Tc8G+IQCBnuKe6Hrn1SqQMRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suvUM/DlDKkzIemjUSGSpL7hn/JQcxDTSwGMaE/8qGC8OEWTob00sl9Uc4nQmRjK9b7wqUqnOw4Nw0V13k9hoZfy6ZQGHPkyMKz2ZvpX6ifk2HxzbbjtAqN2lhf+oRFx5RSe+2mvaSeS7zmlC3Q/Exa9ESm4w4NA5tvMJKYQoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NToe/0Ou; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737652257;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2lz1JhxCiAQPWfDUtfyCfkikpyW82hyEvi1Or2PPgU=;
	b=NToe/0OuIXlIkeO0rD1Zd9FJtxZrD4RZJxHJlukMl2xM0rSbTyVpOv58JaZGPQNw9zbwFr
	B786fanhgOQqLdRUjnLP5yFFq4DQ29PCvWbvfmRVuRzeW1Au0uEhZopT1C2N1/qnr+G/zb
	BqXt3WcKH1LikY1LSYsKGIryq32e5c4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-4vTHgrFXOPGIOyX1CiDLhQ-1; Thu, 23 Jan 2025 12:10:56 -0500
X-MC-Unique: 4vTHgrFXOPGIOyX1CiDLhQ-1
X-Mimecast-MFC-AGG-ID: 4vTHgrFXOPGIOyX1CiDLhQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38a35a65575so737661f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 09:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652255; x=1738257055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2lz1JhxCiAQPWfDUtfyCfkikpyW82hyEvi1Or2PPgU=;
        b=YACOgwQZtr0q4RPMrq2xRyI2wA31R6hXNGIsXc4CIDRQKPgKBfe3TuJSCw1b5MRmzx
         W4cOWXevVSobElsc/+he5MCQxYKCY71SlXBLS7rriNDnnhFWIAfnmGgsvxnmsdltGwk0
         f4lNT7Nm5q8R2J4hS69fyE7nzz61tsDCOdq4DFMDzel1irwXcUp1LpVnyfabYZh6umm/
         IrhXgtGDtIfZP2XM/2rf28iITWu73pG+Gwju4G2v5HqytQ0LdlF/OjmUw3hE8LKiZkp4
         3+YpRmvmkI4+KnpeBO/6pVIeHcI9zTo0VSNmGeB8QJvTjcuyW7SLAqN4MshZBLkjyYBo
         /jiA==
X-Forwarded-Encrypted: i=1; AJvYcCURAOF2+4xfmEz9GsydrAhwxzlU9FYevfLl1xZ0/7aLwOxGJPQVSQGOR2fkbpHzwdnt8bZe2uYP1rBLiFSkvf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHOa7w16kfI1lIaDpwYQ2blHqFHGQDBcJFsvNIjT4s80Xe6YAg
	eV2/+yUpgUmuVPVX27mfXEtb1bLZCK97HEnuDjZMxN/BwHDykRPv6CRYGUCgJnhuyFHOYN3q2Bp
	iqO1F2RoKlGSS7DO9yhS/k/NqKgNd6GFHT9BFl8qWbW4xsbLzq5XASQpnOQH3q64+TQ==
X-Gm-Gg: ASbGncuc+VY98NaWuL3vlrDMCuLpeP0eVTcYaZ23/Hq0qCfNR9ZdeL8yId/+aZUUdVN
	xt/wi8Ys5q2E1LB9+cG9gELn4NjJdE2bOaKwq04u7CCL0h5IOivVF2Vy5cWW8046GhZv6IQ2Qb4
	X5f0KQO9kyoNqcbeC4ndNMv9MbZSjv0PTGiyR//l/nbhP2Sb0LR3mysA/uz3wouYcZ6WgqIJ0KV
	FDYusKHflf64pDt7hWQ2G1TuiqQ+fV5ZtkERy4C04yyPLkV2Vl6yMo8YOTiuEHMf/jpMZCIrbUi
	/pCGyM5bYfYIq8VYH/jSqV0EofzzmcAt/YlX8QBfvw==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id ffacd0b85a97d-38bf57a9932mr29480859f8f.41.1737652255062;
        Thu, 23 Jan 2025 09:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK/5MgTOgXIu9+Lg1LjrltVZkaY8JHUprLufh35bjJjxTwBW+dXwhnf8hS5iSt70eBgqDsvw==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id ffacd0b85a97d-38bf57a9932mr29480826f8f.41.1737652254632;
        Thu, 23 Jan 2025 09:10:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31d9a39sm67975795e9.31.2025.01.23.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:10:53 -0800 (PST)
Message-ID: <1b48e138-3134-442a-9796-e3a33b106221@redhat.com>
Date: Thu, 23 Jan 2025 18:10:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, jgg@nvidia.com, kevin.tian@intel.com,
 tglx@linutronix.de, maz@kernel.org, alex.williamson@redhat.com
Cc: joro@8bytes.org, shuah@kernel.org, reinette.chatre@intel.com,
 yebin10@huawei.com, apatel@ventanamicro.com,
 shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
 anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com, ddutile@redhat.com
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Nicolin,

On 1/11/25 4:32 AM, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
>
> All the iommu cases simply want to override the MSI page's address with
those which translate MSIs
> the IOVA that was mapped through the iommu. This doesn't need a cookie
> pointer, we just need to store the IOVA and its page size in the msi_desc.
>
> Instead provide msi_desc_set_iommu_msi_iova() which allows the IOMMU side
> to specify the IOVA that the MSI page is placed during
> iommu_dma_prepare(). This is stored in the msi_desc and then
iommu_dma_prepare_msi()
> iommu_dma_compose_msi_msg() is a simple inline that sets address_hi/lo.
>
> The next patch will correct the naming.
>
> This is done because we cannot correctly lock access to group->domain in
> the atomic context that iommu_dma_compose_msi_msg() is called under. Today
> the locking miss is tolerable because dma_iommu.c operates under an
> assumption that the domain does not change while a driver is probed.
>
> However iommufd now permits the domain to change while the driver is
> probed and VFIO userspace can create races with IRQ changes calling
> iommu_dma_prepare/compose_msi_msg() and changing/freeing the iommu_domain.
and is it safe in iommu_dma_prepare_msi()?
>
> Removing the pointer, and critically, the call to
> iommu_get_domain_for_dev() during compose resolves this race.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h     |  6 ------
>  include/linux/msi.h       | 45 +++++++++++++++++++++++----------------
>  drivers/iommu/dma-iommu.c | 30 +++++---------------------
>  3 files changed, 32 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 318d27841130..3a4215966c1b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1513,7 +1513,6 @@ static inline void iommu_debugfs_setup(void) {}
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>  
>  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> -void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
>  
>  #else /* CONFIG_IOMMU_DMA */
>  
> @@ -1529,11 +1528,6 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_a
>  {
>  	return 0;
>  }
> -
> -static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> -{
> -}
> -
>  #endif	/* CONFIG_IOMMU_DMA */
>  
>  /*
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index b10093c4d00e..d442b4a69d56 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -184,7 +184,8 @@ struct msi_desc {
>  	struct msi_msg			msg;
>  	struct irq_affinity_desc	*affinity;
>  #ifdef CONFIG_IRQ_MSI_IOMMU
> -	const void			*iommu_cookie;
you may add kernel doc comments above
> +	u64				iommu_msi_iova : 58;
> +	u64				iommu_msi_page_shift : 6;
>  #endif
>  #ifdef CONFIG_SYSFS
>  	struct device_attribute		*sysfs_attrs;
> @@ -285,28 +286,36 @@ struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
>  
>  #define msi_desc_to_dev(desc)		((desc)->dev)
>  
> -#ifdef CONFIG_IRQ_MSI_IOMMU
> -static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
> -{
> -	return desc->iommu_cookie;
> -}
> -
> -static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> -					     const void *iommu_cookie)
> +static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc,
> +					       u64 msi_iova,
> +					       unsigned int page_shift)
>  {
> -	desc->iommu_cookie = iommu_cookie;
> -}
> -#else
> -static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
> -{
> -	return NULL;
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	desc->iommu_msi_iova = msi_iova >> page_shift;
> +	desc->iommu_msi_page_shift = page_shift;
> +#endif
>  }
>  
> -static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> -					     const void *iommu_cookie)
> +/**
> + * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> + * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> + * @msg: MSI message containing target physical address
> + */
> +static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> +					     struct msi_msg *msg)
>  {
> -}
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	if (desc->iommu_msi_page_shift) {
> +		u64 msi_iova = desc->iommu_msi_iova
> +			       << desc->iommu_msi_page_shift;
> +
> +		msg->address_hi = upper_32_bits(msi_iova);
> +		msg->address_lo = lower_32_bits(msi_iova) |
> +				  (msg->address_lo &
> +				   ((1 << desc->iommu_msi_page_shift) - 1));
> +	}
>  #endif
> +}
>  
>  int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
>  			       struct msi_desc *init_desc);
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2a9fa0c8cc00..bf91e014d179 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1815,7 +1815,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>  
>  	if (!domain || !domain->iova_cookie) {
> -		desc->iommu_cookie = NULL;
> +		msi_desc_set_iommu_msi_iova(desc, 0, 0);
>  		return 0;
>  	}
>  
> @@ -1827,33 +1827,13 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  	mutex_lock(&msi_prepare_lock);
>  	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
>  	mutex_unlock(&msi_prepare_lock);
> -
> -	msi_desc_set_iommu_cookie(desc, msi_page);
> -
>  	if (!msi_page)
>  		return -ENOMEM;
> -	return 0;
> -}
>  
> -/**
> - * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> - * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> - * @msg: MSI message containing target physical address
> - */
> -void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> -{
> -	struct device *dev = msi_desc_to_dev(desc);
> -	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	const struct iommu_dma_msi_page *msi_page;
> -
> -	msi_page = msi_desc_get_iommu_cookie(desc);
> -
> -	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
> -		return;
> -
> -	msg->address_hi = upper_32_bits(msi_page->iova);
> -	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
> -	msg->address_lo += lower_32_bits(msi_page->iova);
> +	msi_desc_set_iommu_msi_iova(
> +		desc, msi_page->iova,
> +		ilog2(cookie_msi_granule(domain->iova_cookie)));
> +	return 0;
>  }
>  
>  static int iommu_dma_init(void)


