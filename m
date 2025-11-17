Return-Path: <linux-kselftest+bounces-45772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1466C657DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 18:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1983735295C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115931327A;
	Mon, 17 Nov 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehKeqUsj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCC304BBC;
	Mon, 17 Nov 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399344; cv=none; b=phd5GLJ393PEnJSw8PPMpvKSamVu2MNpIkuvtuqls2jCew8KZ4MWmoDyFgTQENlzYIbecj0tRzbIL7cXJbAr6B8bS6DfbOeA4fgjuB0iRuhhmfhUV/q1NODrAu1pEnDnOAKp2QpUELtOJWTd6A+LgyGOUNE/141NiIG01yep294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399344; c=relaxed/simple;
	bh=RuS09nJyeqNS8Db0pvG4BOuHVgtzKyDFtBIV37Zz3OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udEve/xP67xGJ0l2FW08mlztNN2EnIwVQ+uns2oxjnbDfNmPFyfemZFCaP/tJkXoNHf2f1etid0Qwykxot2O2mVL2zXpAB1vNxHh2YnvoF+9Yl29WfeaU+gJeBMbF3p5TqEI8n10dGGpZzaPTp7HltC6IWwQPRQnSuGrEQ79aQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehKeqUsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79107C4CEF1;
	Mon, 17 Nov 2025 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763399343;
	bh=RuS09nJyeqNS8Db0pvG4BOuHVgtzKyDFtBIV37Zz3OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ehKeqUsjA8DloYD0X8DNYblCUZB3qIRIlB9+2dqOC1p/8Qa9CCGGCW+1t/ltXQgDt
	 5OBn9R76l0aDrReC4cD25v5Q9WWbeBZUzO9tfInbVvA70ywWrLmfH13JplaoHoZ8gl
	 RPMjj+zX9g961agbLV/++/j8252BXeu3IahHFFW3NRFTeL5v9KTwJrz1RY587W6nmp
	 tCjFr4SeqdXZrXnFjxR5TZUQliuX9f5YcUK9I1TXHM4CTRYjIJtW3NNORwORPCZKH+
	 A2mN7i4dg+OQ9m/+/vC239WZLil7+E7R+qeZPIN/zC5tw7bBLNZcAf+7DP8X3rpEEd
	 Cl7SfHIEbl3MQ==
Message-ID: <94fcc32f-574a-4934-b7a9-1ed8bd32a97f@kernel.org>
Date: Mon, 17 Nov 2025 18:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] userfaultfd, shmem: use a VMA callback to handle
 UFFDIO_CONTINUE
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251117114631.2029447-1-rppt@kernel.org>
 <20251117114631.2029447-3-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251117114631.2029447-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.11.25 12:46, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> it needs to get a folio that already exists in the pagecache backing
> that VMA.
> 
> Instead of using shmem_get_folio() for that, add a get_pagecache_folio()
> method to 'struct vm_operations_struct' that will return a folio if it
> exists in the VMA's pagecache at given pgoff.
> 
> Implement get_pagecache_folio() method for shmem and slightly refactor
> userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
> this new API.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/mm.h |  9 +++++++
>   mm/shmem.c         | 20 ++++++++++++++++
>   mm/userfaultfd.c   | 60 ++++++++++++++++++++++++++++++----------------
>   3 files changed, 69 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d16b33bacc32..c35c1e1ac4dd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -690,6 +690,15 @@ struct vm_operations_struct {
>   	struct page *(*find_normal_page)(struct vm_area_struct *vma,
>   					 unsigned long addr);
>   #endif /* CONFIG_FIND_NORMAL_PAGE */
> +#ifdef CONFIG_USERFAULTFD
> +	/*
> +	 * Called by userfault to resolve UFFDIO_CONTINUE request.
> +	 * Should return the folio found at pgoff in the VMA's pagecache if it
> +	 * exists or ERR_PTR otherwise.
> +	 */

What are the locking +refcount rules? Without looking at the code, I 
would assume we return with a folio reference held and the folio locked?

> +	struct folio *(*get_pagecache_folio)(struct vm_area_struct *vma,
> +					     pgoff_t pgoff);


The combination of VMA + pgoff looks weird at first. Would vma + addr or 
vma+vma_offset into vma be better?

But it also makes me wonder if the callback would ever even require the 
VMA, or actually only vma->vm_file?


Thinking out loud, I wonder if one could just call that "get_folio" or 
"get_shared_folio" (IOW, never an anon folio in a MAP_PRIVATE mapping).

> +#endif
>   };
>   
>   #ifdef CONFIG_NUMA_BALANCING
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b9081b817d28..4ac122284bff 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3260,6 +3260,20 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>   	shmem_inode_unacct_blocks(inode, 1);
>   	return ret;
>   }
> +
> +static struct folio *shmem_get_pagecache_folio(struct vm_area_struct *vma,
> +					       pgoff_t pgoff)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +	struct folio *folio;
> +	int err;
> +
> +	err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return folio;
> +}
>   #endif /* CONFIG_USERFAULTFD */
>   
>   #ifdef CONFIG_TMPFS
> @@ -5292,6 +5306,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
>   	.set_policy     = shmem_set_policy,
>   	.get_policy     = shmem_get_policy,
>   #endif
> +#ifdef CONFIG_USERFAULTFD
> +	.get_pagecache_folio	= shmem_get_pagecache_folio,
> +#endif
>   };
>   
>   static const struct vm_operations_struct shmem_anon_vm_ops = {
> @@ -5301,6 +5318,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
>   	.set_policy     = shmem_set_policy,
>   	.get_policy     = shmem_get_policy,
>   #endif
> +#ifdef CONFIG_USERFAULTFD
> +	.get_pagecache_folio	= shmem_get_pagecache_folio,
> +#endif
>   };
>   
>   int shmem_init_fs_context(struct fs_context *fc)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8dc964389b0d..60b3183a72c0 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -382,21 +382,17 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>   				     unsigned long dst_addr,
>   				     uffd_flags_t flags)
>   {
> -	struct inode *inode = file_inode(dst_vma->vm_file);
>   	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
>   	struct folio *folio;
>   	struct page *page;
>   	int ret;
>   
> -	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> +	folio = dst_vma->vm_ops->get_pagecache_folio(dst_vma, pgoff);
>   	/* Our caller expects us to return -EFAULT if we failed to find folio */
> -	if (ret == -ENOENT)
> -		ret = -EFAULT;
> -	if (ret)
> -		goto out;
> -	if (!folio) {
> -		ret = -EFAULT;
> -		goto out;
> +	if (IS_ERR_OR_NULL(folio)) {
> +		if (PTR_ERR(folio) == -ENOENT || !folio)
> +			return -EFAULT;
> +		return PTR_ERR(folio);
>   	}
>   
>   	page = folio_file_page(folio, pgoff);
> @@ -411,13 +407,12 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>   		goto out_release;
>   
>   	folio_unlock(folio);
> -	ret = 0;
> -out:
> -	return ret;
> +	return 0;
> +
>   out_release:
>   	folio_unlock(folio);
>   	folio_put(folio);
> -	goto out;
> +	return ret;
>   }
>   
>   /* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
> @@ -694,6 +689,22 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
>   	return err;
>   }
>   
> +static __always_inline bool vma_can_mfill_atomic(struct vm_area_struct *vma,
> +						 uffd_flags_t flags)
> +{
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> +		if (vma->vm_ops && vma->vm_ops->get_pagecache_folio)
> +			return true;
> +		else
> +			return false;

Probably easier to read is

	return vma->vm_ops && vma->vm_ops->get_pagecache_folio;

> +	}
> +
> +	if (vma_is_anonymous(vma) || vma_is_shmem(vma))
> +		return true;
> +
> +	return false;


Could also be simplified to:

return vma_is_anonymous(vma) || vma_is_shmem(vma);


-- 
Cheers

David

