Return-Path: <linux-kselftest+bounces-46222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E5C78E8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DC1A129F48
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FE346FA7;
	Fri, 21 Nov 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJWq0rI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C573346BF;
	Fri, 21 Nov 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725969; cv=none; b=h69gejxA8To613KNvVzQ8mG9k5mOkzhIEyJGqZj9IiADduo9jIvdOrGoZNteSgoMxhpgUqnTN9nhyWz8qvN6DH2KGaU+AcGI9eutFN6D8IbEJahNact2x61fqhH201jMdd1+9nf/gUk7TMH6uaCY2l0u7rSPl4F7tOoRlsL1Id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725969; c=relaxed/simple;
	bh=tLDp/5SKdP86hRJlKh1UsL4Iwokqsb7SJ7UfEJPXDKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX26llpvKMAGv3r9q6+vo4EL9GRnPVcFuPxPU0pnLDKpqiouIuj0KoUplaosq/jpTBQj8xvSgaA3l2YE82qhXJSOnwYQgDdH5LiXuuSLF0VqsCTs05UqCe+iTVLqa76nqF/t4XYHa/buJcB+uItJ42vh0l7PE1fNAqXRnIhv/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJWq0rI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14656C116C6;
	Fri, 21 Nov 2025 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763725968;
	bh=tLDp/5SKdP86hRJlKh1UsL4Iwokqsb7SJ7UfEJPXDKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJWq0rI0IQnmD92gczmb0l8dlsvdJ9CWfbgS24/eqNYSbiEK6uVcO3F6a/sMWMiAO
	 4rYWBjkOX+HEzmZIwIK1Cyrzq+GtBuEmiXT5G3IZ4S/buX6xmzXFziRk7rA28d1BXw
	 qMHYa02ZrHgnO/9cPFPt6OdLDQQY8TGq66S0XVdH7G8GlQ2O4m8C1Te+7tqMAxgj9t
	 qI5/f4m6LXLWcvopoA8PFWHCUVx2eJV11WDLrjz3Tuwo0UieaNjEPr9Myv8Tz299i/
	 vlxOC+v45bFxKAGu9QX8nByI48z4/pxlT/kQ7mn6FlqDrVMfp1UkLiJcZVe3JQvf44
	 T+nJUudqlLLxg==
Date: Fri, 21 Nov 2025 13:52:39 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] userfaultfd, shmem: use a VMA callback to handle
 UFFDIO_CONTINUE
Message-ID: <aSBSh39-ih3rk0Ab@kernel.org>
References: <20251117114631.2029447-1-rppt@kernel.org>
 <20251117114631.2029447-3-rppt@kernel.org>
 <94fcc32f-574a-4934-b7a9-1ed8bd32a97f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94fcc32f-574a-4934-b7a9-1ed8bd32a97f@kernel.org>

On Mon, Nov 17, 2025 at 06:08:57PM +0100, David Hildenbrand (Red Hat) wrote:
> On 17.11.25 12:46, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> > it needs to get a folio that already exists in the pagecache backing
> > that VMA.
> > 
> > Instead of using shmem_get_folio() for that, add a get_pagecache_folio()
> > method to 'struct vm_operations_struct' that will return a folio if it
> > exists in the VMA's pagecache at given pgoff.
> > 
> > Implement get_pagecache_folio() method for shmem and slightly refactor
> > userfaultfd's mfill_atomic() and mfill_atomic_pte_continue() to support
> > this new API.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   include/linux/mm.h |  9 +++++++
> >   mm/shmem.c         | 20 ++++++++++++++++
> >   mm/userfaultfd.c   | 60 ++++++++++++++++++++++++++++++----------------
> >   3 files changed, 69 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index d16b33bacc32..c35c1e1ac4dd 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -690,6 +690,15 @@ struct vm_operations_struct {
> >   	struct page *(*find_normal_page)(struct vm_area_struct *vma,
> >   					 unsigned long addr);
> >   #endif /* CONFIG_FIND_NORMAL_PAGE */
> > +#ifdef CONFIG_USERFAULTFD
> > +	/*
> > +	 * Called by userfault to resolve UFFDIO_CONTINUE request.
> > +	 * Should return the folio found at pgoff in the VMA's pagecache if it
> > +	 * exists or ERR_PTR otherwise.
> > +	 */
> 
> What are the locking +refcount rules? Without looking at the code, I would
> assume we return with a folio reference held and the folio locked?

Right, will add it to the comment
 
> > +	struct folio *(*get_pagecache_folio)(struct vm_area_struct *vma,
> > +					     pgoff_t pgoff);
> 
> 
> The combination of VMA + pgoff looks weird at first. Would vma + addr or
> vma+vma_offset into vma be better?

Copied from map_pages() :)
 
> But it also makes me wonder if the callback would ever even require the VMA,
> or actually only vma->vm_file?

It's actually inode, I'm going to pass that instead of vma.
 
> Thinking out loud, I wonder if one could just call that "get_folio" or
> "get_shared_folio" (IOW, never an anon folio in a MAP_PRIVATE mapping).

Naming is hard :)

get_shared_folio() sounds good to me so unless there other suggestions I'll
stick with it.
 
> > +#endif
> >   };
> >   #ifdef CONFIG_NUMA_BALANCING

...

> > +static __always_inline bool vma_can_mfill_atomic(struct vm_area_struct *vma,
> > +						 uffd_flags_t flags)
> > +{
> > +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> > +		if (vma->vm_ops && vma->vm_ops->get_pagecache_folio)
> > +			return true;
> > +		else
> > +			return false;
> 
> Probably easier to read is
> 
> 	return vma->vm_ops && vma->vm_ops->get_pagecache_folio;
> 
> > +	}
> > +
> > +	if (vma_is_anonymous(vma) || vma_is_shmem(vma))
> > +		return true;
> > +
> > +	return false;
> 
> 
> Could also be simplified to:
> 
> return vma_is_anonymous(vma) || vma_is_shmem(vma);

Agree with for both of them. 
 
> -- 
> Cheers
> 
> David

-- 
Sincerely yours,
Mike.

