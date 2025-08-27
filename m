Return-Path: <linux-kselftest+bounces-40030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A61C2B379A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 07:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C0A4603E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865FF2D6E68;
	Wed, 27 Aug 2025 05:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQlwW+r6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F52BD5AD;
	Wed, 27 Aug 2025 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756271025; cv=none; b=j0JQ5caRQ44pUuRjvdnWjRMN7LBvnATBxAgfGaGy3zq5PNCUueJDPHPLDfCl5hVopQ045+dCk3iru+4TxCX02xkU/pZZLJDP78pC3M/w2BaKGTpPpcHoWQCSy/qVPu1YosIaqZ06vh8QGhyRM+GH551UODEWRvG7IY2e9EMJ0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756271025; c=relaxed/simple;
	bh=qDXquoYk+8o0rjiAG7tvN2W4p6DdsjPuvtejvqKkkNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJ1D0VT6l/+1pQBEYXfq1c2f4br9GSGSH1dAXIE+tlKx4/TSzElbcypWuTrFdtm8XNzOVCr0pj91HhxegKBVx17x1swuVD5Grfg2Su2BBVEbFTB/Fja2P00T/8yBQJKPvV9APa1nXfcPtjA995qo0CJKyjrz4C4vZgDvh+tQhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cQlwW+r6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+T7zQzI6PFbG9oj0elGrFsd3wpqplYSQjpEjlSCxTP4=; b=cQlwW+r6MX6JrypRxmiW9hcirs
	Ggrs0UaEo5SIYDSEBJgZcPtJ8QO81WScKPELSk7DeYL3pvlQ2GagzS8Rj1jb4lOfE5J9lHoPSHZl9
	R26+QIF0pBMCrYMOBG4FokItxJ2Xkca+e0/OaOxoIebOM4c4y9zYAHslaHEQr2LZohKYqx3PrFM8C
	odfELtNRZ/zxaArswzPtckpWgTQFPRTtyDqr0qZOpQnJx+mZDYtXmdjis25u2hLoLcVgcsyMcfWjG
	fFA6SMlAOYHLDEahBQIbx9M+KjxIhlQ8BqOlnUwY9jiWk09Zhqo3XHx0gh3Kz45nMeuXULnpldJJZ
	I77EFeQg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur8Jx-0000000E4Cb-2J6c;
	Wed, 27 Aug 2025 05:03:41 +0000
Message-ID: <cc96baee-2be5-433f-9902-a160765e2fae@infradead.org>
Date: Tue, 26 Aug 2025 22:03:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] iommupt: Add the basic structure of the iommu
 implementation
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
References: <3-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> The existing IOMMU page table implementations duplicate all of the working
> algorithms for each format. By using the generic page table API a single C
> version of the IOMMU algorithms can be created and re-used for all of the
> different formats used in the drivers. The implementation will provide a
> single C version of the iommu domain operations: iova_to_phys, map, unmap,
> and read_and_clear_dirty.
> 
> Further, adding new algorithms and techniques becomes easy to do across
> the entire fleet of drivers and formats.
> 
> The C functions are drop in compatible with the existing iommu_domain_ops
> using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
> compilation unit will produce exported symbols following the pattern
> pt_iommu_FMT_map_pages() which the macro directly maps to the
> iommu_domain_ops members. This avoids the additional function pointer
> indirection like io-pgtable has.
> 
> The top level struct used by the drivers is pt_iommu_table_FMT. It
> contains the other structs to allow container_of() to move between the
> driver, iommu page table, generic page table, and generic format layers.
> 
>    struct pt_iommu_table_amdv1 {
>        struct pt_iommu {
> 	      struct iommu_domain domain;
>        } iommu;
>        struct pt_amdv1 {
> 	      struct pt_common {
> 	      } common;
>        } amdpt;
>    };
> 
> The driver is expected to union the pt_iommu_table_FMT with it's own

                                                              its
(not "it is")

> existing domain struct:
> 
>    struct driver_domain {
>        union {
> 	       struct iommu_domain domain;
> 	       struct pt_iommu_table_amdv1 amdv1;
>        };
>    };
>    PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);
> 
> To create an alias to avoid renaming 'domain' in a lot of driver code.
> 
> This allows all the layers to access all the necessary functions to
> implement their different roles with no change to any of the existing
> iommu core code.
> 
> Implement the basic starting point: pt_iommu_init(), get_info() and
> deinit().
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/Kconfig              |  12 +
>  drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
>  drivers/iommu/generic_pt/iommu_pt.h           | 264 ++++++++++++++++++
>  include/linux/generic_pt/iommu.h              | 118 ++++++++
>  4 files changed, 433 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
>  create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
>  create mode 100644 include/linux/generic_pt/iommu.h
> 


> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> new file mode 100644
> index 00000000000000..03e1f3daa7a2ef
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -0,0 +1,264 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * "Templated C code" for implementing the iommu operations for page tables.
> + * This is compiled multiple times, over all the page table formats to pick up
> + * the per-format definitions.
> + */
> +#ifndef __GENERIC_PT_IOMMU_PT_H
> +#define __GENERIC_PT_IOMMU_PT_H
> +
> +#include "pt_iter.h"
> +
> +#include <linux/iommu.h>
> +#include "../iommu-pages.h"
> +#include <linux/export.h>

Could you put <linux/export.h> before <linux/iommu.h?
Does something prevent that?

> +> +#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
> +
> +struct pt_iommu_collect_args {
> +	struct iommu_pages_list free_list;
> +	u8 ignore_mapped : 1;
> +};
> +
> +static int __collect_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	struct pt_iommu_collect_args *collect = arg;
> +	int ret;
> +
> +	if (collect->ignore_mapped && !pt_can_have_table(&pts))
> +		return 0;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type == PT_ENTRY_TABLE) {
> +			iommu_pages_list_add(&collect->free_list, pts.table_lower);
> +			ret = pt_descend(&pts, arg, __collect_tables);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +		if (pts.type == PT_ENTRY_OA && !collect->ignore_mapped)
> +			return -EADDRINUSE;
> +	}
> +	return 0;
> +}
> +
> +static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
> +						 uintptr_t top_of_table,
> +						 gfp_t gfp)
> +{
> +	struct pt_iommu *iommu_table = iommu_from_common(common);
> +
> +	/*
> +	 * Top doesn't need the free list or otherwise, so it technically
> +	 * doesn't need to use iommu pages. Use the API anyhow as the top is
> +	 * usually not smaller than PAGE_SIZE to keep things simple.
> +	 */
> +	return iommu_alloc_pages_node_sz(
> +		iommu_table->nid, gfp,
> +		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
> +}
> +
> +static void NS(get_info)(struct pt_iommu *iommu_table,
> +			 struct pt_iommu_info *info)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_top_range(common);
> +	struct pt_state pts = pt_init_top(&range);
> +	pt_vaddr_t pgsize_bitmap = 0;
> +
> +	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
> +		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
> +		     pts.level++) {
> +			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
> +				break;
> +			pgsize_bitmap |= pt_possible_sizes(&pts);
> +		}
> +	} else {
> +		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
> +			pgsize_bitmap |= pt_possible_sizes(&pts);
> +	}
> +
> +	/* Hide page sizes larger than the maximum OA */
> +	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
> +}
> +
> +static void NS(deinit)(struct pt_iommu *iommu_table)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_range range = pt_all_range(common);
> +	struct pt_iommu_collect_args collect = {
> +		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
> +		.ignore_mapped = true,
> +	};
> +
> +	iommu_pages_list_add(&collect.free_list, range.top_table);
> +	pt_walk_range(&range, __collect_tables, &collect);
> +
> +	/*
> +	 * The driver has to already have fenced the HW access to the page table
> +	 * and invalidated any caching referring to this memory.
> +	 */
> +	iommu_put_pages_list(&collect.free_list);
> +}
> +
> +static const struct pt_iommu_ops NS(ops) = {
> +	.get_info = NS(get_info),
> +	.deinit = NS(deinit),
> +};
> +
> +static int pt_init_common(struct pt_common *common)
> +{
> +	struct pt_range top_range = pt_top_range(common);
> +
> +	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
> +		return -EINVAL;
> +
> +	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
> +	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
> +		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
> +
> +	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
> +		common->features |= BIT(PT_FEAT_FULL_VA);
> +
> +	/* Requested features must match features compiled into this format */
> +	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
> +	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
> +	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
> +		     PT_FORCE_ENABLED_FEATURES))
> +		return -EOPNOTSUPP;
> +
> +	if (common->max_oasz_lg2 == 0)
> +		common->max_oasz_lg2 = pt_max_output_address_lg2(common);
> +	else
> +		common->max_oasz_lg2 = min(common->max_oasz_lg2,
> +					   pt_max_output_address_lg2(common));
> +	return 0;
> +}
> +
> +static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
> +				struct iommu_domain *domain)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_iommu_info info;
> +	struct pt_range range;
> +
> +	NS(get_info)(iommu_table, &info);
> +
> +	domain->type = __IOMMU_DOMAIN_PAGING;
> +	domain->pgsize_bitmap = info.pgsize_bitmap;
> +
> +	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
> +		range = _pt_top_range(common,
> +				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
> +	else
> +		range = pt_top_range(common);
> +
> +	/*
> +	 * A 64 bit high address space table on a 32 bit system cannot work.

	     64-bit                               32-bit

> +	 */
> +	domain->geometry.aperture_start = (unsigned long)range.va;
> +	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va)
> +		return -EOVERFLOW;
> +
> +	/*
> +	 * The aperture is limited to what the API can do after considering all
> +	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
> +	 * to store a VA. Set the aperture to something that is valid for all
> +	 * cases. Saturate instead of truncate the end if the types are smaller
> +	 * than the top range. aperture_end is a last.

Does "is a last" have something to do with terminating loop iteration?
Is it inclusive or exclusive?

> +	 */
> +	domain->geometry.aperture_end = (unsigned long)range.last_va;
> +	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
> +		domain->geometry.aperture_end = ULONG_MAX;
> +		domain->pgsize_bitmap &= ULONG_MAX;
> +	}
> +	domain->geometry.force_aperture = true;
> +
> +	return 0;
> +}
> +
> +static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
> +{
> +	struct pt_iommu *iommu_table = &fmt_table->iommu;
> +	struct pt_iommu cfg = *iommu_table;
> +
> +	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
> +	memset_after(fmt_table, 0, iommu.domain);
> +
> +	/* The caller can initialize some of these values */
> +	iommu_table->nid = cfg.nid;
> +}
> +
> +#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
> +#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)

My eyes would appreciate a blank line here.

> +int pt_iommu_init(struct pt_iommu_table *fmt_table,
> +		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
> +{
> +	struct pt_iommu *iommu_table = &fmt_table->iommu;
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +	struct pt_table_p *table_mem;
> +	int ret;

[snip]

> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));

                             Page table
for consistency.

> +MODULE_IMPORT_NS("GENERIC_PT");
> +
> +#endif
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
> new file mode 100644
> index 00000000000000..9d2152bc64c0d6
> --- /dev/null
> +++ b/include/linux/generic_pt/iommu.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __GENERIC_PT_IOMMU_H
> +#define __GENERIC_PT_IOMMU_H
> +
> +#include <linux/generic_pt/common.h>
> +#include <linux/iommu.h>
> +#include <linux/mm_types.h>
> +
> +struct pt_iommu_ops;
> +
> +/**
> + * DOC: IOMMU Radix Page Table
> + *
> + * The iommu implementation of the Generic Page Table provides an ops struct

s/iommu/IOMMU/ in text (not functions/structs/etc.) where possible.

> + * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
> + * the generic map/unmap interface.
> + *
> + * This interface uses a caller provided locking approach. The caller must have
> + * a VA range lock concept that prevents concurrent threads from calling ops on
> + * the same VA. Generally the range lock must be at least as large as a single
> + * map call.
> + */
> +
> +/**
> + * struct pt_iommu - Base structure for iommu page tables
> + *
> + * The format specific struct will include this as the first member.

          format-specific

> + */
> +struct pt_iommu {
> +	/**
> +	 * @domain - The core iommu domain. The driver should use a union to

struct members should be like this:

	 * @domain: <description>

> +	 * overlay this memory with its previously existing domain struct to
> +	 * create an alias.
> +	 */
> +	struct iommu_domain domain;
> +
> +	/**
> +	 * @ops - Function pointers to access the API
> +	 */
> +	const struct pt_iommu_ops *ops;
> +
> +	/**
> +	 * @nid - Node ID to use for table memory allocations. The iommu driver
> +	 * may want to set the NID to the device's NID, if there are multiple
> +	 * table walkers.
> +	 */
> +	int nid;
> +};
> +
> +/**
> + * struct pt_iommu_info - Details about the iommu page table
> + *
> + * Returned from pt_iommu_ops->get_info()
> + */
> +struct pt_iommu_info {
> +	/**
> +	 * @pgsize_bitmap - A bitmask where each set bit indicates

Ditto.

> +	 * a page size that can be natively stored in the page table.
> +	 */
> +	u64 pgsize_bitmap;
> +};
> +
> +struct pt_iommu_ops {
> +	/**
> +	 * get_info() - Return the pt_iommu_info structure

	 * @get_info: Return the pt_iommu_info structure

> +	 * @iommu_table: Table to query
> +	 *
> +	 * Return some basic static information about the page table.
> +	 */
> +	void (*get_info)(struct pt_iommu *iommu_table,
> +			 struct pt_iommu_info *info);
> +
> +	/**
> +	 * deinit() - Undo a format specific init operation

Same reformatting.

> +	 * @iommu_table: Table to destroy
> +	 *
> +	 * Release all of the memory. The caller must have already removed the
> +	 * table from all HW access and all caches.
> +	 */
> +	void (*deinit)(struct pt_iommu *iommu_table);
> +};
> +
> +static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
> +{
> +	/*
> +	 * It is safe to call pt_iommu_deinit() before an init, or if init
> +	 * fails. The ops pointer will only become non-NUL if deinit needs to be

s/NUL/NULL/
NUL is the ASCII character with value 0; NULL is a pointer value.

> +	 * run.
> +	 */
> +	if (iommu_table->ops)
> +		iommu_table->ops->deinit(iommu_table);
> +}
> +
> +/**
> + * struct pt_iommu_cfg - Common configuration values for all formats
> + */
> +struct pt_iommu_cfg {
> +	/**
> +	 * @features - Features required. Only these features will be turned on.

	 * @features:

Similar for below.

> +	 * The feature list should reflect what the IOMMU HW is capable of.
> +	 */
> +	unsigned int features;
> +	/**
> +	 * @hw_max_vasz_lg2 - Maximum VA the IOMMU HW can support. This will
> +	 * imply the top level of the table.
> +	 */
> +	u8 hw_max_vasz_lg2;
> +	/**
> +	 * @hw_max_oasz_lg2 - Maximum OA the IOMMU HW can support. The format
> +	 * might select a lower maximum OA.
> +	 */
> +	u8 hw_max_oasz_lg2;
> +};
> +
> +#endif

-- 
~Randy


