Return-Path: <linux-kselftest+bounces-40035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D7B37B49
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7781B63223
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA73148B5;
	Wed, 27 Aug 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REkdjESr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8DEEB3;
	Wed, 27 Aug 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278705; cv=none; b=ZAUFEluSP8rl0Av+Q3ZRx8HEzwU6+KT46T/gz96e00qqtDfR/rGFcI5i/6Nzja1UjSmYVH1UejYZK5Iglulv+JGFc103knCPIIL+JzC5VmcYcPoPDu6OJJtKyc+wlOjHiTEFt66akWVQpcByFAOjWJrX/iJSgwVh1u0BOz1qzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278705; c=relaxed/simple;
	bh=o+eyEk8P/BxouS4K+NKbo1dxQq2k3r/e+F9tqo/AqLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7eQI6pHNPLHleRnRDX/J3u1TZ9RaAO1QoLL9xBckEGClZJ/UfS8qReglgGkMgp7Tdeb619aE0CiMUXVTpc9h+x4e2lYVqqotcpVcDx7uBBLE2FnkRdMqVl4A6mOCQXpB2ezA4bLKUr/SgNTwPtN5uCG0daxQGTriUPKtrRd23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=REkdjESr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=h0XIwygWDwxbY478OHB4ml45qkk8zcpKU/S5tqpb9GQ=; b=REkdjESrNrgyT4xJlSq+TVCnd6
	b5OX4YqkQwDAUHW54bsrwkboDfFA4KJQaC3z2mAbkpZhbd7C0zkGbsqqZvkeAOWsVu4maYarPz0qp
	M6YseGTW+dO1o4z3q9xWbyUqNAPh9qmJRFgTcAfA/t4ADTvU4v+OXwVPTcINbO78TPu6n07ETluYg
	VUc5HTv/ww2dkoMzjzIP9psJNRCFOwW8pdep6O/Yais8/wIF980FFT+DjfuF02DaBBD/UBsTtsp8O
	zyOat/Y1B8opth1/sGYc/6Tb1TpKRjxIsilJE+95q7sM39Z0TKDHVTL7xj1cg+ZMwfRioLLUcJN1e
	A2hiwZ6w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAJp-0000000ENbz-0ZcZ;
	Wed, 27 Aug 2025 07:11:41 +0000
Message-ID: <bdbd466f-01d3-40ac-abca-81527dbfb901@infradead.org>
Date: Wed, 27 Aug 2025 00:11:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] genpt: Generic Page Table base API
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
References: <1-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:

> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .clang-format                              |   1 +
>  drivers/iommu/Kconfig                      |   2 +
>  drivers/iommu/generic_pt/Kconfig           |  20 +
>  drivers/iommu/generic_pt/pt_common.h       | 354 ++++++++++++
>  drivers/iommu/generic_pt/pt_defs.h         | 323 +++++++++++
>  drivers/iommu/generic_pt/pt_fmt_defaults.h | 193 +++++++
>  drivers/iommu/generic_pt/pt_iter.h         | 636 +++++++++++++++++++++
>  drivers/iommu/generic_pt/pt_log2.h         | 130 +++++
>  include/linux/generic_pt/common.h          | 134 +++++
>  9 files changed, 1793 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/Kconfig
>  create mode 100644 drivers/iommu/generic_pt/pt_common.h
>  create mode 100644 drivers/iommu/generic_pt/pt_defs.h
>  create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
>  create mode 100644 drivers/iommu/generic_pt/pt_iter.h
>  create mode 100644 drivers/iommu/generic_pt/pt_log2.h
>  create mode 100644 include/linux/generic_pt/common.h
> 

> diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
> new file mode 100644
> index 00000000000000..5ed06104d38b45
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_common.h
> @@ -0,0 +1,354 @@

[snip]

> +/**
> + * pt_entry_num_contig_lg2() - Number of contiguous items for this leaf entry
> + * @pts: Entry to query
> + *
> + * Returns the number of contiguous items this leaf entry spans. If the entry is

 * Returns:

> + * single item it returns ilog2(1).
> + */
> +static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state *pts);
> +
> +/**
> + * pt_entry_oa() - Output Address for this leaf entry
> + * @pts: Entry to query
> + *
> + * Return the output address for the start of the entry. If the entry

 * Return:
or
 * Returns:
(usually last in the kernel-doc comment block)

> + * is contigous this returns the same value for each sub-item. Ie::

         contiguous                                               I.e.::

> + *
> + *    log2_mod(pt_entry_oa(), pt_entry_oa_lg2sz()) == 0
> + *
> + * See pt_item_oa(). The format should implement one of these two functions
> + * depending on how it stores the OA's in the table.

or                                   OAs

> + */
> +static inline pt_oaddr_t pt_entry_oa(const struct pt_state *pts);
> +
> +/**
> + * pt_entry_oa_lg2sz() - Return the size of a OA entry
> + * @pts: Entry to query
> + *
> + * If the entry is not contigous this returns pt_table_item_lg2sz(), otherwise

                          contiguous

> + * it returns the total VA/OA size of the entire contiguous entry.

Modify to use
 * Returns:
?

> + */
> +static inline unsigned int pt_entry_oa_lg2sz(const struct pt_state *pts)
> +{
> +	return pt_entry_num_contig_lg2(pts) + pt_table_item_lg2sz(pts);
> +}
> +
> +/**
> + * pt_entry_oa_full() - Return the full OA for an entry
> + * @pts: Entry to query
> + *
> + * During iteration the first entry could have a VA with an offset from the
> + * natural start of the entry. Return the true full OA considering the pts's VA
> + * offset.

 *
 * Returns: the true full OA considering the pts's VA offset

> + */
> +static inline pt_oaddr_t pt_entry_oa_full(const struct pt_state *pts)
> +{
> +	return _pt_entry_oa_fast(pts) |
> +	       log2_mod(pts->range->va, pt_entry_oa_lg2sz(pts));
> +}
> +
> +/**
> + * pt_entry_set_write_clean() - Make the entry write clean
> + * @pts: Table index to change
> + *
> + * Modify the entry so that pt_entry_write_is_dirty() == false. The HW will
> + * eventually be notified of this change via a TLB flush, which is the point
> + * that the HW must become synchronized. Any "write dirty" prior to the TLB
> + * flush can be lost, but once the TLB flush completes all writes must make
> + * their entries write dirty.
> + *
> + * The format should alter the entry in a way that is compatible with any
> + * concurrent update from HW. The entire contiguous entry is changed.
> + */
> +static inline void pt_entry_set_write_clean(struct pt_state *pts);
> +
> +/**
> + * pt_entry_write_is_dirty() - True if the entry has been written to
> + * @pts: Entry to query
> + *
> + * "write dirty" means that the HW has written to the OA translated
> + * by this entry. If the entry is contiguous then the consolidated
> + * "write dirty" for all the items must be returned.
> + */
> +static inline bool pt_entry_write_is_dirty(const struct pt_state *pts);
> +
> +/**
> + * pt_full_va_prefix() - The top bits of the VA
> + * @common: Page table to query
> + *
> + * This is usually 0, but some formats have their VA space going downward from
> + * PT_VADDR_MAX, and will return that instead. This value must always be
> + * adjusted by struct pt_common max_vasz_lg2.
> + */
> +static inline pt_vaddr_t pt_full_va_prefix(const struct pt_common *common);
> +
> +/**
> + * pt_has_system_page() - True if level 0 can install a PAGE_SHIFT entry
> + * @common: Page table to query
> + *
> + * If true the caller use at level 0 pt_install_leaf_entry(PAGE_SHIFT). This is

                         uses
?
although it might just be missing a word or two? I can't tell.

> + * useful to create optimized paths for common cases of PAGE_SIZE mappings.
> + */
> +static inline bool pt_has_system_page(const struct pt_common *common);
> +
> +/**
> + * pt_install_leaf_entry() - Write a leaf entry to the table
> + * @pts: Table index to change
> + * @oa: Output Address for this leaf
> + * @oasz_lg2: Size in VA for this leaf
> + * @attrs: Attributes to modify the entry
> + *
> + * A leaf OA entry will return PT_ENTRY_OA from pt_load_entry(). It translates
> + * the VA indicated by pts to the given OA.
> + *
> + * For a single item non-contiguous entry oasz_lg2 is pt_table_item_lg2sz().
> + * For contiguous it is pt_table_item_lg2sz() + num_contig_lg2.
> + *
> + * This must not be called if pt_can_have_leaf() == false. Contigous sizes

                                                              Contiguous

> + * not indicated by pt_possible_sizes() must not be specified.
> + */
> +static inline void pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
> +					 unsigned int oasz_lg2,
> +					 const struct pt_write_attrs *attrs);
> +
> +/**
> + * pt_install_table() - Write a table entry to the table
> + * @pts: Table index to change
> + * @table_pa: CPU physical address of the lower table's memory
> + * @attrs: Attributes to modify the table index
> + *
> + * A table entry will return PT_ENTRY_TABLE from pt_load_entry(). The table_pa
> + * is the table at pts->level - 1. This is done by cmpxchg so pts must have the
> + * current entry loaded. The pts is updated with the installed entry.
> + *
> + * This must not be called if pt_can_have_table() == false.
> + *
> + * Returns true if the table was installed successfully.

 * Returns:

> + */
> +static inline bool pt_install_table(struct pt_state *pts, pt_oaddr_t table_pa,
> +				    const struct pt_write_attrs *attrs);
> +
> +/**
> + * pt_item_oa() - Output Address for this leaf item
> + * @pts: Item to query
> + *
> + * Return the output address for this item. If the item is part of a contiguous

 * Return:

> + * entry it returns the value of the OA for this individual sub item.
> + *
> + * See pt_entry_oa(). The format should implement one of these two functions
> + * depending on how it stores the OA's in the table.
> + */
> +static inline pt_oaddr_t pt_item_oa(const struct pt_state *pts);
> +
> +/**
> + * pt_load_entry_raw() - Read from the location pts points at into the pts
> + * @pts: Table index to load
> + *
> + * Return the type of entry that was loaded. pts->entry will be filled in with

 * Return:

> + * the entry's content. See pt_load_entry()
> + */
> +static inline enum pt_entry_type pt_load_entry_raw(struct pt_state *pts);
> +
> +/**
> + * pt_max_output_address_lg2() - Return the maximum OA the table format can hold
> + * @common: Page table to query
> + *
> + * The value oalog2_to_max_int(pt_max_output_address_lg2()) is the MAX for the
> + * OA. This is the absolute maximum address the table can hold. struct pt_common
> + * max_oasz_lg2 sets a lower dynamic maximum based on HW capability.
> + */
> +static inline unsigned int
> +pt_max_output_address_lg2(const struct pt_common *common);
> +
> +/**
> + * pt_num_items_lg2() - Return the number of items in this table level
> + * @pts: The current level
> + *
> + * The number of items in a table level defines the number of bits this level
> + * decodes from the VA. This function is not called for the top level,
> + * so it does not need to compute a special value for the top case. The
> + * result for the top is based on pt_common max_vasz_lg2.
> + *
> + * The value is used as part if determining the table indexes via the

                           part of
?

> + * equation::
> + *
> + *   log2_mod(log2_div(VA, pt_table_item_lg2sz()), pt_num_items_lg2())
> + */
> +static inline unsigned int pt_num_items_lg2(const struct pt_state *pts);
> +
> +/**
> + * pt_pgsz_lg2_to_level - Return the level that maps the page size
> + * @common: Page table to query
> + * @pgsize_lg2: Log2 page size
> + *
> + * Returns the table level that will map the given page size. The page

 * Returns:

> + * size must be part of the pt_possible_sizes() for some level.
> + */
> +static inline unsigned int pt_pgsz_lg2_to_level(struct pt_common *common,
> +						unsigned int pgsize_lg2);
> +
> +/**
> + * pt_possible_sizes() - Return a bitmap of possible output sizes at this level
> + * @pts: The current level
> + *
> + * Each level has a list of possible output sizes that can be installed as
> + * leaf entries. If pt_can_have_leaf() is false returns zero.
> + *
> + * Otherwise the bit in position pt_table_item_lg2sz() should be set indicating
> + * that a non-contigous singe item leaf entry is supported. The following

             non-contiguous
Also, is that               single
?
or is "singe" a real word here? (IDK.)

> + * pt_num_items_lg2() number of bits can be set indicating contiguous entries
> + * are supported. Bit pt_table_item_lg2sz() + pt_num_items_lg2() must not be
> + * set, contiguous entries cannot span the entire table.
> + *
> + * The OR of pt_possible_sizes() of all levels is the typical bitmask of all
> + * supported sizes in the entire table.
> + */
> +static inline pt_vaddr_t pt_possible_sizes(const struct pt_state *pts);
> +
> +/**
> + * pt_table_item_lg2sz() - Size of a single item entry in this table level
> + * @pts: The current level
> + *
> + * The size of the item specifies how much VA and OA a single item occupies.
> + *
> + * See pt_entry_oa_lg2sz() for the same value including the effect of contiguous
> + * entries.
> + */
> +static inline unsigned int pt_table_item_lg2sz(const struct pt_state *pts);
> +
> +/**
> + * pt_table_oa_lg2sz() - Return the VA/OA size of the entire table
> + * @pts: The current level
> + *
> + * Return the size of VA decoded by the entire table level.

 * Return:

> + */
> +static inline unsigned int pt_table_oa_lg2sz(const struct pt_state *pts)
> +{
> +	if (pts->range->top_level == pts->level)
> +		return pts->range->max_vasz_lg2;
> +	return min_t(unsigned int, pts->range->common->max_vasz_lg2,
> +		     pt_num_items_lg2(pts) + pt_table_item_lg2sz(pts));
> +}
> +
> +/**
> + * pt_table_pa() - Return the CPU physical address of the table entry
> + * @pts: Entry to query
> + *
> + * This is only ever called on PT_ENTRY_TABLE entries. Must return the same
> + * value passed to pt_install_table().
> + */
> +static inline pt_oaddr_t pt_table_pa(const struct pt_state *pts);
> +
> +/**
> + * pt_table_ptr() - Return a CPU pointer for a table item
> + * @pts: Entry to query
> + *
> + * Same as pt_table_pa() but returns a CPU pointer.
> + */
> +static inline struct pt_table_p *pt_table_ptr(const struct pt_state *pts)
> +{
> +	return __va(pt_table_pa(pts));
> +}
> +
> +/**
> + * pt_load_entry() - Read from the location pts points at into the pts
> + * @pts: Table index to load
> + *
> + * Set the type of entry that was loaded. pts->entry and pts->table_lower
> + * will be filled in with the entry's content.
> + */
> +static inline void pt_load_entry(struct pt_state *pts)
> +{
> +	pts->type = pt_load_entry_raw(pts);
> +	if (pts->type == PT_ENTRY_TABLE)
> +		pts->table_lower = pt_table_ptr(pts);
> +}
> +#endif

> diff --git a/drivers/iommu/generic_pt/pt_defs.h b/drivers/iommu/generic_pt/pt_defs.h
> new file mode 100644
> index 00000000000000..3673566708495d
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_defs.h
> @@ -0,0 +1,323 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * This header is included before the format. It contains definitions
> + * that are required to compile the format. The header order is:
> + *  pt_defs.h
> + *  fmt_XX.h
> + *  pt_common.h
> + */
> +#ifndef __GENERIC_PT_DEFS_H
> +#define __GENERIC_PT_DEFS_H
> +
> +#include <linux/generic_pt/common.h>
> +
> +#include <linux/types.h>
> +#include <linux/atomic.h>
> +#include <linux/bits.h>
> +#include <linux/limits.h>
> +#include <linux/bug.h>
> +#include <linux/kconfig.h>
> +#include "pt_log2.h"
> +
> +/* Header self-compile default defines */
> +#ifndef pt_write_attrs
> +typedef u64 pt_vaddr_t;
> +typedef u64 pt_oaddr_t;
> +#endif
> +
> +struct pt_table_p;
> +
> +enum {
> +	PT_VADDR_MAX = sizeof(pt_vaddr_t) == 8 ? U64_MAX : U32_MAX,
> +	PT_VADDR_MAX_LG2 = sizeof(pt_vaddr_t) == 8 ? 64 : 32,
> +	PT_OADDR_MAX = sizeof(pt_oaddr_t) == 8 ? U64_MAX : U32_MAX,
> +	PT_OADDR_MAX_LG2 = sizeof(pt_oaddr_t) == 8 ? 64 : 32,
> +};

Hm, duplicated enum entry values?
Interesting.

> +
> +/*
> + * The format instantiation can have features wired off or on to optimize the
> + * code gen. Supported features are just a reflection of what the current set of
> + * kernel users want to use.
> + */
> +#ifndef PT_SUPPORTED_FEATURES
> +#define PT_SUPPORTED_FEATURES 0
> +#endif
> +
> +/*
> + * When in debug mode we compile all formats with all features. This allows the
> + * kunit to test the full matrix. SIGN_EXTEND can't co-exist with DYNAMIC_TOP or
> + * FULL_VA.
> + */
> +#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
> +enum {
> +	PT_ORIG_SUPPORTED_FEATURES = PT_SUPPORTED_FEATURES,
> +	PT_DEBUG_SUPPORTED_FEATURES =
> +		UINT_MAX &
> +		~((PT_ORIG_SUPPORTED_FEATURES & BIT(PT_FEAT_SIGN_EXTEND)) ?
> +			  BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_FULL_VA) :
> +			  BIT(PT_FEAT_SIGN_EXTEND)),
> +};
> +#undef PT_SUPPORTED_FEATURES
> +#define PT_SUPPORTED_FEATURES PT_DEBUG_SUPPORTED_FEATURES
> +#endif
> +
> +#ifndef PT_FORCE_ENABLED_FEATURES
> +#define PT_FORCE_ENABLED_FEATURES 0
> +#endif
> +
> +/**
> + * DOC: Generic Page Table Language
> + *
> + * Language used in Generic Page Table
> + *  va
> + *     The input address to the page table, often the virtual address.
> + *  oa
> + *     The output address from the page table, often the physical address.
> + *  leaf
> + *     An entry that results in an output address. Ie a physical memory addr

	                                              I.e.,

> + *  start/end
> + *     An open range, eg [0,0) refers to no VA.

	                 e.g.,

and is a half-open (or right-open) range or interval, not open.

Open would be (0, 0).
Closed would be [0, 0].
I used to think that was "clopen" but now I read that clopen refers
to sets and not intervals.



> + *  start/last
> + *     An inclusive closed range, eg [0,0] refers to the VA 0

	                             e.g.,

> + *  common
> + *     The generic page table container struct pt_common
> + *  level
> + *     The number of table hops from the lowest leaf. Level 0
> + *     is always a table of only leaves of the least significant VA bits. The
> + *     labels used by HW descriptions are never used.
> + *  top_level
> + *     The inclusive highest level of the table. A two level table

	                                               two-level

> + *     has a top level of 1.
> + *  table
> + *     A linear array of entries representing the translation items for that
> + *     level.
> + *  index
> + *     The position in a table of an element: item = table[index]
> + *  item
> + *     A single position in a table
> + *  entry
> + *     A single logical element in a table. If contiguous pages are not
> + *     supported then item and entry are the same thing, otherwise entry refers
> + *     to the all the items that comprise a single contiguous translation.
> + *  item/entry_size
> + *     The number of bytes of VA the table translates for.
> + *     If the item is a table entry then the next table covers
> + *     this size. If the entry is an output address then the
> + *     full OA is: OA | (VA % entry_size)
> + *  contig_count
> + *     The number of consecutive items fused into a single entry.
> + *     item_size * contig_count is the size of that entry's translation.
> + *  lg2
> + *     Indicates the value is encoded as log2, ie 1<<x is the actual value.

	                                          i.e.,

> + *     Normally the compiler is fine to optimize divide and mod with log2 values
> + *     automatically when inlining, however if the values are not constant
> + *     expressions it can't. So we do it by hand, we want to avoid 64 bit

	                                       hand;                  64-bit

> + *     divmod.
> + */
> +
> +/* Returned by pt_load_entry() and for_each_pt_level_entry() */
> +enum pt_entry_type {
> +	PT_ENTRY_EMPTY,
> +	PT_ENTRY_TABLE,
> +	/* Entry is valid and returns an output address */
> +	PT_ENTRY_OA,
> +};
> +
> +struct pt_range {
> +	struct pt_common *common;
> +	struct pt_table_p *top_table;
> +	pt_vaddr_t va;
> +	pt_vaddr_t last_va;
> +	u8 top_level;
> +	u8 max_vasz_lg2;
> +};
> +
> +/*
> + * Similar to xa_state, this records information about an in progress parse at a

                                                             in-progress

> + * single level.
> + */
> +struct pt_state {
> +	struct pt_range *range;
> +	struct pt_table_p *table;
> +	struct pt_table_p *table_lower;
> +	u64 entry;
> +	enum pt_entry_type type;
> +	unsigned short index;
> +	unsigned short end_index;
> +	u8 level;
> +};
> +
> +#define pt_cur_table(pts, type) ((type *)((pts)->table))
> +
> +/*
> + * Try to install a new table pointer. The locking methodology requires this to
> + * be atomic, multiple threads can race to install a pointer, the losing threads

         atomic;                                        pointer;

> + * will fail the atomic and return false. They should free any memory and
> + * reparse the table level again.
> + */

[snup]


> +/*
> + * The full va (fva) versions permit the lg2 value to be == PT_VADDR_MAX_LG2 and
> + * generate a useful defined result. The non fva versions will malfunction at

                                            non-fva

> + * this extreme.
> + */
> +static inline pt_vaddr_t fvalog2_div(pt_vaddr_t a, unsigned int b_lg2)
> +{
> +	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
> +		return 0;
> +	return log2_div_t(pt_vaddr_t, a, b_lg2);
> +}
> +
> +static inline pt_vaddr_t fvalog2_mod(pt_vaddr_t a, unsigned int b_lg2)
> +{
> +	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
> +		return a;
> +	return log2_mod_t(pt_vaddr_t, a, b_lg2);
> +}
> +
> +static inline bool fvalog2_div_eq(pt_vaddr_t a, pt_vaddr_t b,
> +				  unsigned int c_lg2)
> +{
> +	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && c_lg2 == PT_VADDR_MAX_LG2)
> +		return true;
> +	return log2_div_eq_t(pt_vaddr_t, a, b, c_lg2);
> +}
> +
> +static inline pt_vaddr_t fvalog2_set_mod(pt_vaddr_t a, pt_vaddr_t val,
> +					 unsigned int b_lg2)
> +{
> +	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
> +		return val;
> +	return log2_set_mod_t(pt_vaddr_t, a, val, b_lg2);
> +}
> +
> +static inline pt_vaddr_t fvalog2_set_mod_max(pt_vaddr_t a, unsigned int b_lg2)
> +{
> +	if (PT_SUPPORTED_FEATURE(PT_FEAT_FULL_VA) && b_lg2 == PT_VADDR_MAX_LG2)
> +		return PT_VADDR_MAX;
> +	return log2_set_mod_max_t(pt_vaddr_t, a, b_lg2);
> +}
> +

[snip]

> diff --git a/drivers/iommu/generic_pt/pt_fmt_defaults.h b/drivers/iommu/generic_pt/pt_fmt_defaults.h
> new file mode 100644
> index 00000000000000..8738008d024b0b
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_fmt_defaults.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * Default definitions for formats that don't define these functions.
> + */
> +#ifndef __GENERIC_PT_PT_FMT_DEFAULTS_H
> +#define __GENERIC_PT_PT_FMT_DEFAULTS_H
> +
> +#include "pt_defs.h"
> +#include <linux/log2.h>
> +
> +/* Header self-compile default defines */
> +#ifndef pt_load_entry_raw
> +#include "fmt/amdv1.h"
> +#endif
> +
> +/*
> + * The format must provide PT_GRANULE_LG2SZ, PT_TABLEMEM_LG2SZ, and
> + * PT_ITEM_WORD_SIZE. The must be the same at every level excluding the top.

                         They

> + */

[snip]

> diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_pt/pt_iter.h
> new file mode 100644
> index 00000000000000..abbd243f10d879
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/pt_iter.h
> @@ -0,0 +1,636 @@

[snip]

> +/*
> + * Add index_count_lg2 number of entries to pts's VA and index. The va will be

s/VA/va/ for consistency?
since it ("va") is defined in Generic Page Table Language.

> + * adjusted to the end of the contiguous block if it is currently in the middle.
> + */
> +static inline void _pt_advance(struct pt_state *pts,
> +			       unsigned int index_count_lg2)
> +{
> +	pts->index = log2_set_mod(pts->index + log2_to_int(index_count_lg2), 0,
> +				  index_count_lg2);
> +}
> +
> +/**
> + * pt_item_fully_covered() - Check if the item or entry is entirely contained
> + *                           within pts->range
> + * @pts: Iteration State
> + * @oasz_lg2: The size of the item to check, pt_table_item_lg2sz() or
> + *            pt_entry_oa_lg2sz()
> + *
> + * True if the item is fully enclosed by the pts->range.

 * Return: true if the item ...

> + */
> +static inline bool pt_item_fully_covered(const struct pt_state *pts,
> +					 unsigned int oasz_lg2)
> +{
> +	struct pt_range *range = pts->range;
> +
> +	/* Range begins at the start of the entry */
> +	if (log2_mod(pts->range->va, oasz_lg2))
> +		return false;
> +
> +	/* Range ends past the end of the entry */
> +	if (!log2_div_eq(range->va, range->last_va, oasz_lg2))
> +		return true;
> +
> +	/* Range ends at the end of the entry */
> +	return log2_mod_eq_max(range->last_va, oasz_lg2);
> +}
> +
> +/**
> + * pt_range_to_index() - Starting index for an iteration
> + * @pts: Iteration State
> + *
> + * Return the starting index for the iteration in pts.

 * Return:

> + */
> +static inline unsigned int pt_range_to_index(const struct pt_state *pts)
> +{
> +	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
> +
> +	PT_WARN_ON(pts->level > pts->range->top_level);
> +	if (pts->range->top_level == pts->level)
> +		return log2_div(fvalog2_mod(pts->range->va,
> +					    pts->range->max_vasz_lg2),
> +				isz_lg2);
> +	return log2_mod(log2_div(pts->range->va, isz_lg2),
> +			pt_num_items_lg2(pts));
> +}
> +
> +/**
> + * pt_range_to_end_index() - Ending index iteration
> + * @pts: Iteration State
> + *
> + * Return the last index for the iteration in pts.

 * Return:

> + */
> +static inline unsigned int pt_range_to_end_index(const struct pt_state *pts)
> +{
> +	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
> +	struct pt_range *range = pts->range;
> +	unsigned int num_entries_lg2;
> +
> +	if (range->va == range->last_va)
> +		return pts->index + 1;
> +
> +	if (pts->range->top_level == pts->level)
> +		return log2_div(fvalog2_mod(pts->range->last_va,
> +					    pts->range->max_vasz_lg2),
> +				isz_lg2) +
> +		       1;
> +
> +	num_entries_lg2 = pt_num_items_lg2(pts);
> +
> +	/* last_va falls within this table */
> +	if (log2_div_eq(range->va, range->last_va, num_entries_lg2 + isz_lg2))
> +		return log2_mod(log2_div(pts->range->last_va, isz_lg2),
> +				num_entries_lg2) +
> +		       1;
> +
> +	return log2_to_int(num_entries_lg2);
> +}
> +
> +static inline void _pt_iter_first(struct pt_state *pts)
> +{
> +	pts->index = pt_range_to_index(pts);
> +	pts->end_index = pt_range_to_end_index(pts);
> +	PT_WARN_ON(pts->index > pts->end_index);
> +}
> +
> +static inline bool _pt_iter_load(struct pt_state *pts)
> +{
> +	if (pts->index >= pts->end_index)
> +		return false;
> +	pt_load_entry(pts);
> +	return true;
> +}
> +
> +/**
> + * pt_next_entry() - Advance pts to the next entry
> + * @pts: Iteration State
> + *
> + * Update pts to go to the next index at this level. If pts is pointing at a
> + * contiguous entry then the index may advance my more than one.

                                                  by

> + */
> +static inline void pt_next_entry(struct pt_state *pts)
> +{
> +	if (pts->type == PT_ENTRY_OA &&
> +	    !__builtin_constant_p(pt_entry_num_contig_lg2(pts) == 0))
> +		_pt_advance(pts, pt_entry_num_contig_lg2(pts));
> +	else
> +		pts->index++;
> +	pt_index_to_va(pts);
> +}
> +
> +/**
> + * for_each_pt_level_entry() - For loop wrapper over entries in the range
> + * @pts: Iteration State
> + *
> + * This is the basic iteration primitive, it iterates over all the entries in

                                  primitive. It

> + * pts->range that fall within the pts's current table level. Each step does
> + * pt_load_entry(pts).
> + */
> +#define for_each_pt_level_entry(pts) \
> +	for (_pt_iter_first(pts); _pt_iter_load(pts); pt_next_entry(pts))
> +


[snip]

> +/*
> + * pt_walk_descend_all() - Recursively invoke the walker for a table item
> + * @pts: Iteration State

 * @parent_pts:

> + * @fn: Walker function to call
> + * @arg: Value to pass to the function
> + *
> + * With pts pointing at a table item this will descend and over the entire lower
> + * table. This creates a new walk and does not alter pts or pts->range.
> + */
> +static __always_inline int
> +pt_walk_descend_all(const struct pt_state *parent_pts, pt_level_fn_t fn,
> +		    void *arg)
> +{


[snip]

> +/**
> + * PT_MAKE_LEVELS() - Build an unwound walker
> + * @fn: Name of the walker function
> + * @do_fn: Function to call at each level
> + *
> + * This builds a function call tree that can be fully inlined,

                                                         inlined.

> + * The caller must provide a function body in an __always_inline function::
> + *

[snip]



> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
> new file mode 100644
> index 00000000000000..91869fad33fbdf
> --- /dev/null
> +++ b/include/linux/generic_pt/common.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __GENERIC_PT_COMMON_H
> +#define __GENERIC_PT_COMMON_H
> +
> +#include <linux/types.h>
> +#include <linux/build_bug.h>
> +#include <linux/bits.h>
> +
> +/**
> + * DOC: Generic Radix Page Table
> + *
> + * Generic Radix Page Table is a set of functions and helpers to efficiently
> + * parse radix style page tables typically seen in HW implementations. The
> + * interface is built to deliver similar code generation as the mm's pte/pmd/etc
> + * system by fully inlining the exact code required to handle each table level.
> + *
> + * Like the MM each format contributes its parsing implementation under common

maybe          MM system,

> + * names and the common code implements the required algorithms.
> + *
> + * The system is divided into three logical levels:
> + *
> + *  - The page table format and its manipulation functions
> + *  - Generic helpers to give a consistent API regardless of underlying format
> + *  - An algorithm implementation (eg IOMMU/DRM/KVM/MM)

                                     (e.g.,

> + *
> + * Multiple implementations are supported, the intention is to have the generic

                                   supported. The

> + * format code be re-usable for whatever specalized implementation is required.
> + * The generic code is solely about the format of the radix tree, it does not

                                                               tree;

> + * include memory allocation or higher level decisions that are left for the
> + * implementation.
> + *
> + * The generic framework supports a superset of functions across many HW
> + * implementations:
> + *
> + *  - Entries comprised of contiguous blocks of IO PTEs for larger page sizes
> + *  - Multi-level tables, up to 6 levels. Runtime selected top level
> + *  - Runtime variable table level size (ARM's concatenated tables)
> + *  - Expandable top level allowing dynamic sizing of table levels
> + *  - Optional leaf entries at any level
> + *  - 32 bit/64 bit virtual and output addresses, using every address bit

         32-bit/64-bit

> + *  - Dirty tracking
> + */
> +
> +/**
> + * struct pt_common

    * struct pt_common - <some short struct description>

> + */
> +struct pt_common {
> +	/**
> +	 * @top_of_table: Encodes the table top pointer and the top level in a
> +	 * single value. Must use READ_ONCE/WRITE_ONCE to access it. The lower
> +	 * bits of the aligned table pointer are used for the level.
> +	 */
> +	uintptr_t top_of_table;
> +	/**
> +	 * @max_oasz_lg2: Maximum number of bits the OA can contain. Upper bits
> +	 * must be zero. This may be less than what the page table format
> +	 * supports, but must not be more.
> +	 */
> +	u8 max_oasz_lg2;
> +	/**
> +	 * @max_vasz_lg2: Maximum number of bits the VA can contain. Upper bits
> +	 * are 0 or 1 depending on pt_full_va_prefix(). This may be less than
> +	 * what the page table format supports, but must not be more. When
> +	 * PT_FEAT_DYNAMIC_TOP this reflects the maximum VA capability.

	   PT_FEAT_DYNAMIC_TOP is set, this reflects ...
?

> +	 */
> +	u8 max_vasz_lg2;
> +	/**
> +	 * @features: Bitmap of `enum pt_features`
> +	 */
> +	unsigned int features;
> +};
> +
> +/* Encoding parameters for top_of_table */
> +enum {
> +	PT_TOP_LEVEL_BITS = 3,
> +	PT_TOP_LEVEL_MASK = GENMASK(PT_TOP_LEVEL_BITS - 1, 0),
> +};
> +
> +/**
> + * enum pt_features - Features turned on in the table. Each symbol is a bit
> + * position.
> + */
> +enum pt_features {
> +	/**
> +	 * @PT_FEAT_FULL_VA: The table can span the full VA range from 0 to
> +	 * PT_VADDR_MAX.
> +	 */
> +	PT_FEAT_FULL_VA,
> +	/**
> +	 * @PT_FEAT_DYNAMIC_TOP: The table's top level can be increased
> +	 * dynamically during map. This requires HW support for atomically
> +	 * setting both the table top pointer and the starting table level.
> +	 */
> +	PT_FEAT_DYNAMIC_TOP,
> +	/**
> +	 * @PT_FEAT_SIGN_EXTEND: The top most bit of the valid VA range sign
> +	 * extends up to the full pt_vaddr_t. This divides the page table into
> +	 * three VA ranges::
> +	 *
> +	 *   0         -> 2^N - 1             Lower
> +	 *   2^N       -> (MAX - 2^N - 1)     Non-Canonical
> +	 *   MAX - 2^N -> MAX                 Upper
> +	 *
> +	 * In this mode pt_common::max_vasz_lg2 includes the sign bit and the
> +	 * upper bits that don't fall within the translation are just validated.
> +	 *
> +	 * If not set there is no sign extension and valid VA goes from 0 to 2^N
> +	 * - 1.
> +	 */
> +	PT_FEAT_SIGN_EXTEND,
> +	/**
> +	 * @PT_FEAT_FLUSH_RANGE: IOTLB maintenance is done by flushing IOVA
> +	 * ranges which will clean out any walk cache or any IOPTE fully
> +	 * contained by the range. The optimization objective is to minimize the
> +	 * number of flushes even if ranges include IOVA gaps that do not need
> +	 * to be flushed.
> +	 */
> +	PT_FEAT_FLUSH_RANGE,
> +	/**
> +	 * @PT_FEAT_FLUSH_RANGE_NO_GAPS: Like PT_FEAT_FLUSH_RANGE except that
> +	 * the optimization objective is to only flush IOVA that has been
> +	 * changed. This mode is suitable for cases like hypervisor shadowing
> +	 * where flushing unchanged ranges may cause the hypervisor to reparse
> +	 * significant amount of page table.
> +	 */
> +	PT_FEAT_FLUSH_RANGE_NO_GAPS,
> +	/* private: */
> +	PT_FEAT_FMT_START,
> +};
> +
> +#endif
-- 
~Randy


