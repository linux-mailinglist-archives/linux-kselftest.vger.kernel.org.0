Return-Path: <linux-kselftest+bounces-26814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B378FA38E3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 22:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8383016D7DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5E11A9B52;
	Mon, 17 Feb 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI/rzHJq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852741A5BB6
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828708; cv=none; b=V9CHQLSGZA4hfuRk9Z6qQgnU8MlGXRm5/jZ1M4hOVKa2y19qHLtP8tpm+mUsrcc+LRfTUMhkQGlyTCMOGqKu8b+5Sksrw4OUIlrsn8ltIs64i4apbiMsH1jvaGgMf+8FAnEc1Q0Yp0MGmDTn/5E5xH2U73mZ4EV7VeA8gH5512w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828708; c=relaxed/simple;
	bh=YupG+oerM5zQ1jKJLPA0LZ9yHKTpX9POatmenH43x40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmYv8YVyox3pVbVsP7cq61DerJdYly3wA+h+hZXYMu5gHNBb2me1XP+WrCJSH5QO41dvZfmc19mq0EMTcVI3IoiXCNpMfi2Keq4A5jo74if0XZB6UZ+kHIkLzWncNAjHXDJ8GjROXqzHW63NX0cK+Loq6tsjttwgACJxhsZquaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI/rzHJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739828705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rynaZk8s3qbrrEEdhqi8skHEAMDYPl1Pe/lGr0ndqTw=;
	b=cI/rzHJqfS1ftxvVLXdcYipsaWLyzL1ttPaGjW7QnUkqCYQ5ckkG9kOgneULeBwEH+lGGo
	7RXxal3RS57j31ddR+hrWVEllt7O0iXRD7Z4KvNGfKeugguyxNA5NvSxbyulDEV5O4qfcg
	Uhbm42/qzIsNZKOI758p2Bp5ESkKfRo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-gr6JHaNIO1-lhgsKFKQImw-1; Mon, 17 Feb 2025 16:45:02 -0500
X-MC-Unique: gr6JHaNIO1-lhgsKFKQImw-1
X-Mimecast-MFC-AGG-ID: gr6JHaNIO1-lhgsKFKQImw_1739828702
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4393e8738b3so41090745e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 13:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739828701; x=1740433501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rynaZk8s3qbrrEEdhqi8skHEAMDYPl1Pe/lGr0ndqTw=;
        b=Tol3CKeBc3qS3P8EZhn3aZaWZoz0pHIyqvTRXWXIF0O/D/k1iDjgQFd5rV8C7MyGWs
         BaGHi56pr+m+zahaNVOZN/nrGb9xsEKF9zD0MbeHOMKzN1u6wpVR68fKMjiLRJTBkUgG
         lBlwnXaAb7DPef7NEbMiN8QMXl41O+I/eX21DZBSwJHmqxwzoQxEYsTm2FMiy7DRzcxC
         C9SB5HfWFxbktYLbqe60SipmXW33H32GwuS9HSV2SyKpP+Ejj61IrDAgf1YQbSsm6a0J
         x1B9jnugq3GwCdLlV4f+AF7ROKHOaVNb/edgYJCDY3hYwiG4jcP9h1AD2XBaXpKhEXZ2
         Pdow==
X-Forwarded-Encrypted: i=1; AJvYcCURsNQg1nynBAf1HelWJONSolLT8Lh/LiFILxV35EAzCSWzBsHQH7eOn1O4TEdjVMeIXz3CPaRq8YpSfrV7dvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDHkjovJH6moGnkg6LmUPBy6k37vYutN4rp9fzQ7BczBHHoO+
	jekd8hBj6H+/6UOzEXuirmNDiDITFoshnublDbX69Py+UNGf1P59HJyKJwYZHNxdyn1PMlnur/a
	WtXkdAUCVYYp+ePTp9kEWgohfIDla24hLOf5mNjYS+Vd2m4BeWDB21rN2ycRW+L2MXQ==
X-Gm-Gg: ASbGncuvE2t9MmpSOtttV8lCSPVLK350MOorL69KLRXQ4VnnbsjFqlj/kCR0z+WeWjd
	Z8UJRjXadPUNbbcQwAC79zicAlzECofHcWUJHhZcyv008SVDw8CvWYPJkeTwdXyXGfLtbJzNcF8
	ScLgxDgVJAVDN+HJOwIvj4vHTE4TuZKoGz3TYBwCjElE7dnfwX2BRXI2jVWueQKKlEuD5jewbjh
	7g99zluZA06SOakPMF+qoajunJxOuzQvHuONffTzgS6HB9KWEHFbzNbyAy3W3dZ0I/OI4oIM0IE
	ulsEmArv1bPLGYcSNm3QbAXIRnOoaL6eTCssWdb+CZj0CntWIzf+cDUkiKmag2QIUJUkGPOWhpg
	Ym8XJHr9LJjnshO4jPQ9fiNjqICqM1w==
X-Received: by 2002:a05:600c:46d1:b0:439:6712:643d with SMTP id 5b1f17b1804b1-4396e6a74f2mr95257755e9.9.1739828699936;
        Mon, 17 Feb 2025 13:44:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXol8v5NkAyR+xRGiXV2+BVyoGEdakLnTxHp1V14AEX4FungEeVKj/n6Dg8lytHBjs6CdwIQ==
X-Received: by 2002:a05:600c:46d1:b0:439:6712:643d with SMTP id 5b1f17b1804b1-4396e6a74f2mr95257615e9.9.1739828699487;
        Mon, 17 Feb 2025 13:44:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:900:900f:3c9e:2f7b:5d0a? (p200300cbc7390900900f3c9e2f7b5d0a.dip0.t-ipconnect.de. [2003:cb:c739:900:900f:3c9e:2f7b:5d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd46sm13257522f8f.21.2025.02.17.13.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 13:44:58 -0800 (PST)
Message-ID: <0bb75517-9418-4145-8aa8-b05373010711@redhat.com>
Date: Mon, 17 Feb 2025 22:44:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] xarray: add xas_try_split() to split a multi-index
 entry.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250211155034.268962-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.02.25 16:50, Zi Yan wrote:
> It is a preparation patch for non-uniform folio split, which always split
> a folio into half iteratively, and minimal xarray entry split.
> 
> Currently, xas_split_alloc() and xas_split() always split all slots from a
> multi-index entry. They cost the same number of xa_node as the to-be-split
> slots. For example, to split an order-9 entry, which takes 2^(9-6)=8
> slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8 xa_node are
> needed. Instead xas_try_split() is intended to be used iteratively to split
> the order-9 entry into 2 order-8 entries, then split one order-8 entry,
> based on the given index, to 2 order-7 entries, ..., and split one order-1
> entry to 2 order-0 entries. When splitting the order-6 entry and a new
> xa_node is needed, xas_try_split() will try to allocate one if possible.
> As a result, xas_try_split() would only need one xa_node instead of 8.
> 
> When a new xa_node is needed during the split, xas_try_split() can try to
> allocate one but no more. -ENOMEM will be return if a node cannot be
> allocated. -EINVAL will be return if a sibling node is split or
> cascade split happens, where two or more new nodes are needed, and these
> are not supported by xas_try_split().
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
> ---
>   Documentation/core-api/xarray.rst |  14 ++-
>   include/linux/xarray.h            |   7 ++
>   lib/test_xarray.c                 |  47 +++++++++++
>   lib/xarray.c                      | 136 ++++++++++++++++++++++++++----
>   tools/testing/radix-tree/Makefile |   1 +
>   5 files changed, 188 insertions(+), 17 deletions(-)
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
> diff --git a/lib/test_xarray.c b/lib/test_xarray.c
> index 6932a26f4927..598ca38a2f5b 100644
> --- a/lib/test_xarray.c
> +++ b/lib/test_xarray.c
> @@ -1857,6 +1857,49 @@ static void check_split_1(struct xarray *xa, unsigned long index,
>   	xa_destroy(xa);
>   }
>   
> +static void check_split_2(struct xarray *xa, unsigned long index,
> +				unsigned int order, unsigned int new_order)
> +{
> +	XA_STATE_ORDER(xas, xa, index, new_order);
> +	unsigned int i, found;
> +	void *entry;
> +
> +	xa_store_order(xa, index, order, xa, GFP_KERNEL);
> +	xa_set_mark(xa, index, XA_MARK_1);
> +
> +	xas_lock(&xas);
> +	xas_try_halve(&xas, xa, order, GFP_KERNEL);
> +	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
> +	    new_order < order - 1) {
> +		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) != -EINVAL);
> +		xas_unlock(&xas);
> +		goto out;
> +	}
> +	for (i = 0; i < (1 << order); i += (1 << new_order))
> +		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
> +	xas_unlock(&xas);
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		unsigned int val = index + (i & ~((1 << new_order) - 1));
> +		XA_BUG_ON(xa, xa_load(xa, index + i) != xa_mk_index(val));
> +	}
> +
> +	xa_set_mark(xa, index, XA_MARK_0);
> +	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
> +
> +	xas_set_order(&xas, index, 0);
> +	found = 0;
> +	rcu_read_lock();
> +	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
> +		found++;
> +		XA_BUG_ON(xa, xa_is_internal(entry));
> +	}
> +	rcu_read_unlock();
> +	XA_BUG_ON(xa, found != 1 << (order - new_order));
> +out:
> +	xa_destroy(xa);
> +}
> +
>   static noinline void check_split(struct xarray *xa)
>   {
>   	unsigned int order, new_order;
> @@ -1868,6 +1911,10 @@ static noinline void check_split(struct xarray *xa)
>   			check_split_1(xa, 0, order, new_order);
>   			check_split_1(xa, 1UL << order, order, new_order);
>   			check_split_1(xa, 3UL << order, order, new_order);
> +
> +			check_split_2(xa, 0, order, new_order);
> +			check_split_2(xa, 1UL << order, order, new_order);
> +			check_split_2(xa, 3UL << order, order, new_order);
>   		}
>   	}
>   }
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 116e9286c64e..c38beca77830 100644
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
> @@ -1122,6 +1132,100 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
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
> +{
> +	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
> +	unsigned int offset, marks;
> +	struct xa_node *node;
> +	void *curr = xas_load(xas);
> +	int values = 0;
> +
> +	node = xas->xa_node;
> +	if (xas_top(node))
> +		return;
> +
> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> +		gfp |= __GFP_ACCOUNT;
> +
> +	marks = node_get_marks(node, xas->xa_offset);
> +
> +	offset = xas->xa_offset + sibs;
> +	do {
> +		if (xas->xa_shift < node->shift) {
> +			struct xa_node *child = xas->xa_alloc;
> +			unsigned int expected_sibs =
> +				(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
> +
> +			/*
> +			 * No support for splitting sibling entries
> +			 * (horizontally) or cascade split (vertically), which
> +			 * requires two or more new xa_nodes.
> +			 * Since if one xa_node allocation fails,
> +			 * it is hard to free the prior allocations.
> +			 */
> +			if (sibs || xas->xa_sibs != expected_sibs) {
> +				xas_destroy(xas);
> +				xas_set_err(xas, -EINVAL);
> +				return;
> +			}
> +
> +			if (!child) {
> +				child = __xas_alloc_node_for_split(xas, entry,
> +						gfp);
> +				if (!child) {
> +					xas_destroy(xas);
> +					xas_set_err(xas, -ENOMEM);
> +					return;
> +				}
> +			}

No expert on this, just wondering ...

... what is the effect if we halfway-through fail the split? Is it okay 
to leave that "partially split" thing in place? Can callers deal with that?

-- 
Cheers,

David / dhildenb


