Return-Path: <linux-kselftest+bounces-40012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327CB37578
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1991BA2A5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF9304BBA;
	Tue, 26 Aug 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZN/eUk8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4429BD90;
	Tue, 26 Aug 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250460; cv=none; b=TfJxxHujXLa//0zIZP/uj8e+QMdRXdWv2ppQT1jzKHTzKttDWRgu3sPLh9gYHCuBA7mSnpCcubck1gQwauXylokMovv+IamsWszZDCbWYQ3O7F0t2AqG3IEDvQ0tli0PxdxdWzM4X477es2C2YHMjrodGUjdMsR3vyMowkM9PdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250460; c=relaxed/simple;
	bh=4JztsWOXxaNw/MW7O5iCvXzmvGGxquSUTrJMlIKbZeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOwOMBFMPoj0eJiRipwYNrhPK+/JysWPSekfbMojM6GfNBUKeqaLv9J3l3jM2bIFqEG4ErKfHfZyj7Ai+7lte6u1VT8EN9TTppv21xtm4gOxVfJcGa/e4NXIl1Gde5YL9oVDN3tAbet4fLUDUOmbHVleJamEOWd3SWjW81g2VZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZN/eUk8w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=58PKSnkaNXZ7dYOOuXTdylSdXrVJpRTgtX2b86oy1M8=; b=ZN/eUk8w54n3WKCh0soZlXbogy
	uroA3WDBcrBimk4WvO0pNWvr4KX7NutaJ8/oec5OUHF5zsNpaXdejW69qLnA1Iwl/GGWWM/q7X/qg
	vg2WZOMv+Hee/4LBnpuULqtF6drrP3AqdmARO7MIwSVbzF/hr+33ekQTazmv3LkrCjYhd23L0O6jr
	AcmwRVgbeZVS9ZyaePigAxwmm9WHvVm5EobZndcXHhzQtk9sbxMX7UbNkakORIF+PxZP6twXkbp1M
	3pit4NxKSKB9Ox2BEl5409tHVEdcL5V7hh+r7bYl4ZRoTcqBhiBNAYYbn/5M6y3sQKZqiYOix+Rn9
	uu8rcxEA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur2yF-0000000DL6g-3kG1;
	Tue, 26 Aug 2025 23:20:55 +0000
Message-ID: <c17f0cf1-9a80-4f1a-94a1-8869b8ed0a53@infradead.org>
Date: Tue, 26 Aug 2025 16:20:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <7-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 480 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |  58 ++++
>  2 files changed, 538 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index 53901a4a977935..ee762dde6fd531 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h

[snip]


> +
> +/**
> + * map_range() - Install translation for an IOVA range

Maybe I don't understand the macros (haven't looked lately).

Function name appears to be map_pages(), not map_range().

> + * @iommu_table: Table to manipulate
> + * @iova: IO virtual address to start
> + * @paddr: Physical/Output address to start
> + * @len: Length of the range starting from @iova
> + * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
> + * @gfp: GFP flags for any memory allocations
> + * @gather: Gather struct that must be flushed on return
> + *

and the @params above don't match the actual function arguments. (?)

> + * The range starting at IOVA will have paddr installed into it. The rage is
> + * automatically segmented into optimally sized table entries, and can have any
> + * valid alignment.
> + *
> + * On error the caller will probably want to invoke unmap on the range from iova
> + * up to the amount indicated by @mapped to return the table back to an
> + * unchanged state.
> + *
> + * Context: The caller must hold a write range lock that includes the whole
> + * range.
> + *
> + * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
> + * mapped are added to @mapped, @mapped is not zerod first.
> + */
> +int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
> +			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			 int prot, gfp_t gfp, size_t *mapped)
> +{


> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> index 382596b70e394e..2ca62812b5a152 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -11,6 +11,7 @@
>  
>  struct iommu_iotlb_gather;
>  struct pt_iommu_ops;
> +struct pt_iommu_flush_ops;
>  
>  /**
>   * DOC: IOMMU Radix Page Table
> @@ -43,6 +44,12 @@ struct pt_iommu {
>  	 */
>  	const struct pt_iommu_ops *ops;
>  
> +	/**
> +	 * @hw_flush_ops - Function pointers provided by the HW driver to flush
> +	 * HW caches after changes to the page table.

All of these "@param -" should be "@param:" (or "@param :" if you prefer that.)
Otherwise a kernel-doc build warning happens for each one of them.

(others deleted...)


>  
> +/**
> + * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
> + *
> + * The IOMMU driver should implement these using container_of(iommu_table) to
> + * get to it's iommu_domain dervied structure. All ops can be called in atomic
> + * contexts as they are buried under DMA API calls.
> + */
> +struct pt_iommu_flush_ops {
> +	/**
> +	 * change_top() - Update the top of table pointer

This should be
	 * @change_top: Update the top of table pointer
since it is a struct member, not a function. Otherwise it causes
build warnings.


> +	 * @iommu_table: Table to operate on
> +	 * @top_paddr: New CPU physical address of the top pointer
> +	 * @top_level: IOMMU PT level of the new top

We don't really have a way to document parameters of a callback function
inside a struct, but for now kernel-doc.py won't complain about it.
(Somehow kernel-doc.pl did once upon a time and then that became dead code.)

> +	 *
> +	 * Called under the get_top_lock() spinlock. The driver must update all
> +	 * HW references to this domain with a new top address and
> +	 * configuration. On return mappings placed in the new top must be
> +	 * reachable by the HW.
> +	 *
> +	 * top_level encodes the level in IOMMU PT format, level 0 is the
> +	 * smallest page size increasing from there. This has to be translated
> +	 * to any HW specific format. During this call the new top will not be
> +	 * visible to any other API.
> +	 *
> +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> +	 * enabled.
> +	 */
> +	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
> +			   unsigned int top_level);
> +
> +	/**
> +	 * get_top_lock() - Return a lock to hold when changing the table top

This one should be
	 * @get_top_lock: <description>

This is just a struct.member so it should be documented like one; otherwise
it causes a kernel warning.


> +	 * @iommu_table: Table to operate on
> +	 *
> +	 * page table from being stored in HW. The lock will be held prior
> +	 * to calling change_top() and released once the top is fully visible.
> +	 *
> +	 * Typically this would be a lock that protects the iommu_domain's
> +	 * attachment list.
> +	 *
> +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> +	 * enabled.
> +	 */
> +	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
> +};
> +

-- 
~Randy


