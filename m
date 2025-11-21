Return-Path: <linux-kselftest+bounces-46223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12932C78EBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F07A54E37C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FC2DF6F4;
	Fri, 21 Nov 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9rHWLou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18058220698;
	Fri, 21 Nov 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726356; cv=none; b=QFkrEBMZak+Yau55f+1ytLQ+mxksz4yDZBYTwwAFVV+ofaxoDrz59f8Yk2BGPmigxyE+QiXNhfhITkJ+8EnoV6QxOJYS1KmaMyTAR6PdiF4kMpc+flojlZSwnh18WxWJmPiO1gL6o2Bd5Z8T5T49XR6S3EDiJrTZ71NtYWP6/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726356; c=relaxed/simple;
	bh=RiQAcjp2e+731JZhVL1+P6ye9ciRcuL6VvATes7vC24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axChEi/m29lf++nfPfGmOKIcPbNf6QE82yCsVo9jlMR571ie2bjlyKturZY2RHIrtZ20zNyKYf9TrulWAA4Mb1tF4xdMcyiU9ehXJZgnyLUHQLHdx8Svve0TaQ47pxe7rIOTHtGlTOJ3iJO3hitePgm7Tc9iDQL/pZFlgX4ePrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9rHWLou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4F2C4CEF1;
	Fri, 21 Nov 2025 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763726355;
	bh=RiQAcjp2e+731JZhVL1+P6ye9ciRcuL6VvATes7vC24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9rHWLou00pxAF6NJa4RQBnLlmDOL5cqA0B2wM2fNW2Yo3T5CM9n6+r1ARo/vkyv2
	 1tbDSVQCW4tGNdOwt/5PZe2wvr/qMDXRSCf4ncesFymiHBjirobG0VQ0xY33Yyg/kI
	 spHo1UL+T48z36hpT02GI9B7/FVKFQkfgGu+0IxyHZoFAiojYLf7aEEair0maBs0oW
	 7g8PFSncyT4fKsVC/KlKZ/f6Ma5vzE7LZT4guENhM09Eda7055CiewP3iG9GVpUY2k
	 fLjljE/8XCA+DyPPDQ4Js4IL0wa/hldO2IgPo6RPAb2j+csxcCPauHd3cA7DR1R3+3
	 7jFaYIvzEubMg==
Date: Fri, 21 Nov 2025 13:59:05 +0200
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
Subject: Re: [RFC PATCH 3/4] userfaultfd, guest_memfd: support userfault
 minor mode in guest_memfd
Message-ID: <aSBUCcjmZ5PM61ir@kernel.org>
References: <20251117114631.2029447-1-rppt@kernel.org>
 <20251117114631.2029447-4-rppt@kernel.org>
 <007c08e4-ce70-4c30-b3b1-e25e02dfe29d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007c08e4-ce70-4c30-b3b1-e25e02dfe29d@kernel.org>

On Tue, Nov 18, 2025 at 05:41:13PM +0100, David Hildenbrand (Red Hat) wrote:
> On 17.11.25 12:46, Mike Rapoport wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index fbca8c0972da..5e3c63307fdf 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -4,6 +4,7 @@
> >   #include <linux/kvm_host.h>
> >   #include <linux/pagemap.h>
> >   #include <linux/anon_inodes.h>
> > +#include <linux/userfaultfd_k.h>
> >   #include "kvm_mm.h"
> > @@ -369,6 +370,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
> >   		return vmf_error(err);
> >   	}
> > +	if (userfaultfd_minor(vmf->vma)) {
> > +		folio_unlock(folio);
> > +		folio_put(folio);
> > +		return handle_userfault(vmf, VM_UFFD_MINOR);
> > +	}
> 
> Staring at things like VM_FAULT_NEEDDSYNC, I'm wondering whether we could have a
> new return value from ->fault that would indicate that
> handle_userfault(vmf, VM_UFFD_MINOR) should be called.
> 
> Maybe some VM_FAULT_UFFD_MINOR or simply VM_FAULT_USERFAULTFD and we
> can just derive that it is VM_UFFD_MINOR.

_UFFD_MINOR sounds better, maybe we'll want something for missing later on. 
 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4f66a3206a63c..2cf17da880f0e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1601,6 +1601,8 @@ typedef __bitwise unsigned int vm_fault_t;
>   *                             fsync() to complete (for synchronous page faults
>   *                             in DAX)
>   * @VM_FAULT_COMPLETED:                ->fault completed, meanwhile mmap lock released
> + * @VM_FAULT_USERFAULTFD:      ->fault did not modify page tables and needs
> + *                             handle_userfault() to complete
>   * @VM_FAULT_HINDEX_MASK:      mask HINDEX value
>   *
>   */
> @@ -1618,6 +1620,7 @@ enum vm_fault_reason {
>         VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
>         VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
>         VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> +       VM_FAULT_USERFAULTFD    = (__force vm_fault_t)0x006000,
>         VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
>  };
> @@ -1642,6 +1645,7 @@ enum vm_fault_reason {
>         { VM_FAULT_FALLBACK,            "FALLBACK" },   \
>         { VM_FAULT_DONE_COW,            "DONE_COW" },   \
>         { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
> +       { VM_FAULT_USERFAULTFD,         "USERFAULTFD" },\
>         { VM_FAULT_COMPLETED,           "COMPLETED" }
>  struct vm_special_mapping {
> 
> 
> IIUC, we have exactly two invocations of ->fault(vmf) in memory.c where
> we would have to handle it IIUC. And the return value would never leave
> the core.

I've found only one :/
But nevertheless, I like the idea to return VM_FAULT_UFFD_MINOR from
->fault() and then call handle_userfault() from __do_fault().
 
> That way, we wouldn't have to export handle_userfault().
> 
> Just a thought ...
> 
> -- 
> Cheers
> 
> David

-- 
Sincerely yours,
Mike.

