Return-Path: <linux-kselftest+bounces-27573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8EA4566C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 08:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4541707BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 07:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD96326A1A0;
	Wed, 26 Feb 2025 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="guCTusCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76F19DF62;
	Wed, 26 Feb 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553921; cv=none; b=gwgMNnJJbiWyQXd3MMDbEo3Twp0zu+kcCRusuda1FLADyn9fBe/jWbGnb5DkJk54qrx/x79KWW+vgfhP66BOsU6trDLGhM/dkdaC+hEzuKJ76f7QC24tXa5GzvF3lv9CVN/Zkk0HXGY1gGRHAY9mt+919uIjM/L1RuXyz7CVkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553921; c=relaxed/simple;
	bh=wMBCCKteRxGD2wi9MxPm3ylBCleCTAsMmVmsBVLamCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6bBh7HgLzbh8JKuPWshRbHqUiHXf3KdP8I90JtVc3+1zSLmnMIfrDVRH+tw6VWWFo7Xi2LpGjk73j+CtOV8J5Pf1W8AofPu4eQ571f8R5HxI/d8KN8wsAg7sAPAnBjhiq9Pr1i1f6qioXEw8S+c4XChQi2HlHh1B0fcWsvGjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=guCTusCI; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740553907; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yDdB4bIyML299YEUA1lHDugeZxZJO/0yzLNbJ+H1stA=;
	b=guCTusCIgt3gg3pXZWmj8lBU/6e3ZZly/yqNbg3BJuSAU+ecqSIuU6KPVCdZG5JWihykT6mY9AK8pgwqTsOCbMj3jBmvDQjWO43isg7eXh5tQMq26c6R4y2Dckh0Mgv5gWWy9IyQ7fftfoNy00Pwfr7E0KdKYVnzRvAFPsmgUDI=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQHLFQu_1740553905 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Feb 2025 15:11:45 +0800
Message-ID: <e5d967b9-fbc0-497f-a4a4-6f2bdc902400@linux.alibaba.com>
Date: Wed, 26 Feb 2025 15:11:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/8] xarray: add xas_try_split() to split a multi-index
 entry
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi
 <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250218235012.1542225-1-ziy@nvidia.com>
 <20250218235012.1542225-2-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250218235012.1542225-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Zi,

On 2025/2/19 07:50, Zi Yan wrote:
> A preparation patch for non-uniform folio split, which always split a
> folio into half iteratively, and minimal xarray entry split.
> 
> Currently, xas_split_alloc() and xas_split() always split all slots from a
> multi-index entry.  They cost the same number of xa_node as the
> to-be-split slots.  For example, to split an order-9 entry, which takes
> 2^(9-6)=8 slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8
> xa_node are needed.  Instead xas_try_split() is intended to be used
> iteratively to split the order-9 entry into 2 order-8 entries, then split
> one order-8 entry, based on the given index, to 2 order-7 entries, ...,
> and split one order-1 entry to 2 order-0 entries.  When splitting the
> order-6 entry and a new xa_node is needed, xas_try_split() will try to
> allocate one if possible.  As a result, xas_try_split() would only need
> one xa_node instead of 8.
> 
> When a new xa_node is needed during the split, xas_try_split() can try to
> allocate one but no more.  -ENOMEM will be return if a node cannot be
> allocated.  -EINVAL will be return if a sibling node is split or cascade
> split happens, where two or more new nodes are needed, and these are not
> supported by xas_try_split().
> 
> xas_split_alloc() and xas_split() split an order-9 to order-0:
> 
>           ---------------------------------
>           |   |   |   |   |   |   |   |   |
>           | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>           |   |   |   |   |   |   |   |   |
>           ---------------------------------
>             |   |                   |   |
>       -------   ---               ---   -------
>       |           |     ...       |           |
>       V           V               V           V
> ----------- -----------     ----------- -----------
> | xa_node | | xa_node | ... | xa_node | | xa_node |
> ----------- -----------     ----------- -----------
> 
> xas_try_split() splits an order-9 to order-0:
>     ---------------------------------
>     |   |   |   |   |   |   |   |   |
>     | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
>     |   |   |   |   |   |   |   |   |
>     ---------------------------------
>       |
>       |
>       V
> -----------
> | xa_node |
> -----------
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> ---
>   Documentation/core-api/xarray.rst |  14 ++-
>   include/linux/xarray.h            |   7 ++
>   lib/test_xarray.c                 |  47 ++++++++++
>   lib/xarray.c                      | 138 ++++++++++++++++++++++++++----
>   tools/testing/radix-tree/Makefile |   1 +
>   5 files changed, 190 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index f6a3eef4fe7f..c6c91cbd0c3c 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index entry will set the
>   entry at every index to ``NULL`` and dissolve the tie.  A multi-index
>   entry can be split into entries occupying smaller ranges by calling
>   xas_split_alloc() without the xa_lock held, followed by taking the lock
> -and calling xas_split().
> +and calling xas_split() or calling xas_try_split() with xa_lock. The
> +difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
> +that xas_split_alloc() + xas_split() split the entry from the original
> +order to the new order in one shot uniformly, whereas xas_try_split()
> +iteratively splits the entry containing the index non-uniformly.
> +For example, to split an order-9 entry, which takes 2^(9-6)=8 slots,
> +assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() need
> +8 xa_node. xas_try_split() splits the order-9 entry into
> +2 order-8 entries, then split one order-8 entry, based on the given index,
> +to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 entries.
> +When splitting the order-6 entry and a new xa_node is needed, xas_try_split()
> +will try to allocate one if possible. As a result, xas_try_split() would only
> +need 1 xa_node instead of 8.
>   
>   Functions and structures
>   ========================
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 0b618ec04115..9eb8c7425090 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned long index);
>   int xas_get_order(struct xa_state *xas);
>   void xas_split(struct xa_state *, void *entry, unsigned int order);
>   void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
> +		gfp_t gfp);
>   #else
>   static inline int xa_get_order(struct xarray *xa, unsigned long index)
>   {
> @@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_state *xas, void *entry,
>   		unsigned int order, gfp_t gfp)
>   {
>   }
> +
> +static inline void xas_try_split(struct xa_state *xas, void *entry,
> +		unsigned int order, gfp_t gfp)
> +{
> +}
>   #endif
>   
>   /**

[snip]

> diff --git a/lib/xarray.c b/lib/xarray.c
> index 116e9286c64e..b9a63d7fbd58 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
>   	}
>   }
>   
> +static struct xa_node *__xas_alloc_node_for_split(struct xa_state *xas,
> +		void *entry, gfp_t gfp)
> +{
> +	unsigned int i;
> +	void *sibling = NULL;
> +	struct xa_node *node;
> +	unsigned int mask = xas->xa_sibs;
> +
> +	node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
> +	if (!node)
> +		return NULL;
> +	node->array = xas->xa;
> +	for (i = 0; i < XA_CHUNK_SIZE; i++) {
> +		if ((i & mask) == 0) {
> +			RCU_INIT_POINTER(node->slots[i], entry);
> +			sibling = xa_mk_sibling(i);
> +		} else {
> +			RCU_INIT_POINTER(node->slots[i], sibling);
> +		}
> +	}
> +	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
> +
> +	return node;
> +}
> +
>   /**
>    * xas_split_alloc() - Allocate memory for splitting an entry.
>    * @xas: XArray operation state.
> @@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
>   		gfp_t gfp)
>   {
>   	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
> -	unsigned int mask = xas->xa_sibs;
>   
>   	/* XXX: no support for splitting really large entries yet */
>   	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
> @@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
>   		return;
>   
>   	do {
> -		unsigned int i;
> -		void *sibling = NULL;
> -		struct xa_node *node;
> -
> -		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
> +		struct xa_node *node = __xas_alloc_node_for_split(xas, entry, gfp);
>   		if (!node)
>   			goto nomem;
> -		node->array = xas->xa;
> -		for (i = 0; i < XA_CHUNK_SIZE; i++) {
> -			if ((i & mask) == 0) {
> -				RCU_INIT_POINTER(node->slots[i], entry);
> -				sibling = xa_mk_sibling(i);
> -			} else {
> -				RCU_INIT_POINTER(node->slots[i], sibling);
> -			}
> -		}
> -		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
>   		xas->xa_alloc = node;
>   	} while (sibs-- > 0);
>   
> @@ -1122,6 +1132,102 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
>   	xas_update(xas, node);
>   }
>   EXPORT_SYMBOL_GPL(xas_split);
> +
> +/**
> + * xas_try_split() - Try to split a multi-index entry.
> + * @xas: XArray operation state.
> + * @entry: New entry to store in the array.
> + * @order: Current entry order.
> + * @gfp: Memory allocation flags.
> + *
> + * The size of the new entries is set in @xas.  The value in @entry is
> + * copied to all the replacement entries. If and only if one xa_node needs to
> + * be allocated, the function will use @gfp to get one. If more xa_node are
> + * needed, the function gives EINVAL error.
> + *
> + * Context: Any context.  The caller should hold the xa_lock.
> + */
> +void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
> +		gfp_t gfp)

The xas_try_split() may sleep if ‘gfp’ flags permit while holding the 
xa_lock, which can cause issues. So can we add a check for the ‘gfp’ or 
only use GFP_NOWAIT?

