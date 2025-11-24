Return-Path: <linux-kselftest+bounces-46390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF0C81400
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24903A7E43
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806230DEDC;
	Mon, 24 Nov 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lek3isPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C213296159;
	Mon, 24 Nov 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996993; cv=none; b=cwhobHFqvBtVczHNchFOc58g5+wWJKq/pMOp3qeR1gwA3azzrCQCIlNl/tntvxNoWgSFbv+VXN9uga03zZ2KYpbIZ+oFMvqf+vGGZGtKLCKLz/QkVw/e+NP7sgqmtHElCA5jnzHjuYoiN4Drp/6KaCcv/UxFa+UOqSrcQzq0kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996993; c=relaxed/simple;
	bh=UuNKUt3TuSlZUnNzguJ+jbkaDA7UcbKM9pSfdm62QCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G81q/LyKX8cNVlCrxIrshRhn8NqF5u4lSxPIpmXEuOZinMIAMXRddISw4QNsFUYTmTEQfNdIo26pNf+Iq7rXJLn46xTaGvr6zUBl0oViwvtz5MFR1ntooWo/07ZKXv4ObUUtjMBIj8MR19TfqUih6WMsja+1d2OLEuGazMF1Xms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lek3isPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A37C116D0;
	Mon, 24 Nov 2025 15:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763996992;
	bh=UuNKUt3TuSlZUnNzguJ+jbkaDA7UcbKM9pSfdm62QCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lek3isPNtIB6N3n0GIvhZdhWijDxLAVSgOvnASeFW517VlnW9/1RzyxNSlSvsN0gg
	 ZPP98kUpTQ4ugwLMNzFpUYVjFK5ZtgMyp1/H+4ixzsncuDlGl8fH146PDyVxT7VXBg
	 hLTS02x4Owpo3jPegb4cH2GGSY9kjcxtbPOABSA5sWD1tF98KDw2ksyh83nxGkk7Ka
	 LcgJ1V8OTBA8puGb3EHOzl9QdnDnkSUK/W0onoWvHiQwdOO/wo1BOwC/lZAfWIlMF8
	 QvONdvjIjRI+/UPI3JfDGImnK6JmEAW0pVAxLsu10Q343giqj6gwAqHpT8Q6kWJoLH
	 JbgmuUCJIYtWA==
Date: Mon, 24 Nov 2025 17:09:43 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
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
Subject: Re: [PATCH 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
Message-ID: <aSR1NxBi9ZYoKhwT@kernel.org>
References: <20251123102707.559422-1-rppt@kernel.org>
 <20251123102707.559422-4-rppt@kernel.org>
 <ef739802-1b53-4baa-81e4-dcc674d7c1c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef739802-1b53-4baa-81e4-dcc674d7c1c6@kernel.org>

On Mon, Nov 24, 2025 at 12:05:18PM +0100, David Hildenbrand (Red Hat) wrote:
> On 11/23/25 11:27, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > When a VMA is registered with userfaulfd in minor mode, its ->fault()
> > method should check if a folio exists in the page cache and if yes
> > ->fault() should call handle_userfault(VM_UFFD_MISSING).
> > 
> > Instead of calling handle_userfault() directly from a specific ->fault()
> > implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
> > notify the core page fault handler that it should call
> > handle_userfaultfd(VM_UFFD_MISSING) to complete a page fault.
> > 
> > Replace a call to handle_userfault(VM_UFFD_MISSING) in shmem and use the
> > new VM_FAULT_UFFD_MINOR there instead.
> > 
> > Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   include/linux/mm_types.h | 3 +++
> >   mm/memory.c              | 2 ++
> >   mm/shmem.c               | 2 +-
> >   3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 90e5790c318f..eb135369940f 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1523,6 +1523,8 @@ typedef __bitwise unsigned int vm_fault_t;
> >    *				fsync() to complete (for synchronous page faults
> >    *				in DAX)
> >    * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
> > + * @VM_FAULT_UFFD_MINOR:	->fault did not modify page tables and needs
> > + *				handle_userfault(VM_UFFD_MINOR) to complete
> >    * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
> >    *
> >    */
> > @@ -1540,6 +1542,7 @@ enum vm_fault_reason {
> >   	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> >   	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> >   	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> > +	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x008000,
> >   	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
> >   };
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b59ae7ce42eb..94acbac8cefb 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5279,6 +5279,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
> >   	}
> >   	ret = vma->vm_ops->fault(vmf);
> > +	if (unlikely(ret & VM_FAULT_UFFD_MINOR))
> > +		return handle_userfault(vmf, VM_UFFD_MINOR);
> 
> If we could define VM_FAULT_UFFD_MINOR to be 0 without USERFAULTFD, we could
> optimize that check out completely on such configs.
 
It will be a bit ugly, but we can :)
 
> -- 
> Cheers
> 
> David

-- 
Sincerely yours,
Mike.

