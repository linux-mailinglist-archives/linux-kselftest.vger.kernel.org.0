Return-Path: <linux-kselftest+bounces-46378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F09C80138
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D64E4749
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D426ED5E;
	Mon, 24 Nov 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdHaKGWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F2238C1B;
	Mon, 24 Nov 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982326; cv=none; b=NoCH5/7mbILmqS2wDRuhtd9ojTDGzK0bgDx67I8D9Xzy2W1BVxC/g+7wQNSAzCcNKt/sVd2Rxee0S4H920jIAPPnZjZ2Ql2eKhmfapPq3o56Fs+UBQo6L1TzIedo/I0NMKDWkgDgYNwDMD9vmpgZv3zuzwfYbFZvjxLmIIx9VK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982326; c=relaxed/simple;
	bh=xAo9jDsdZnz6/lhNhkcTyH2Vv9bCshFd2rXVbo51big=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFu9xy9KTkVVSm9Mp6d5HuibRPuy2hK62CzB3/F+lnlPGfgreSkmTggGzUIs/Y5Ff3zFDSzdl2Utja29Ymn4UUzX9uLlxxGKowViPbAsEk67ctWpkgyq61ffwm4QTzigVj/M6a0MHd3wAh1qnp6bT0OdQoSUvG1W2nAKLMsBaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdHaKGWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38170C4CEF1;
	Mon, 24 Nov 2025 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763982326;
	bh=xAo9jDsdZnz6/lhNhkcTyH2Vv9bCshFd2rXVbo51big=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NdHaKGWS1O+C+KbtPyPToMXSoUWgmsYqnLDc2FhNyH96nyxbQtDe7ZubKu/lLjdyC
	 X8ObCLyrQMQeU6tEylmtcRhWaISmSavumTsxfODA1Ru0XfV5JKiZ/cWHOJVJCtQ2Qn
	 yxnSveJJgYC/h67AQ94ObFQ2vSxyQvGr9n/+Xhjy8txtI5PsMxzLEZnNAsSAWl53hB
	 ojehVEENSrvjdmIw3jzSxpHDTX7Q+YzWt9pp8X+mZ4Pz//V3guYCyY8h1bxIEjayso
	 LNYh72Ti4ciAh1xh2f1z4kcJCDXd8y6VKCB4scGUKFphVaz8NWAhND6uGKkjYepnzw
	 ozLNRwume7YGA==
Message-ID: <ef739802-1b53-4baa-81e4-dcc674d7c1c6@kernel.org>
Date: Mon, 24 Nov 2025 12:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251123102707.559422-1-rppt@kernel.org>
 <20251123102707.559422-4-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251123102707.559422-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 11:27, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When a VMA is registered with userfaulfd in minor mode, its ->fault()
> method should check if a folio exists in the page cache and if yes
> ->fault() should call handle_userfault(VM_UFFD_MISSING).
> 
> Instead of calling handle_userfault() directly from a specific ->fault()
> implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
> notify the core page fault handler that it should call
> handle_userfaultfd(VM_UFFD_MISSING) to complete a page fault.
> 
> Replace a call to handle_userfault(VM_UFFD_MISSING) in shmem and use the
> new VM_FAULT_UFFD_MINOR there instead.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/mm_types.h | 3 +++
>   mm/memory.c              | 2 ++
>   mm/shmem.c               | 2 +-
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 90e5790c318f..eb135369940f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1523,6 +1523,8 @@ typedef __bitwise unsigned int vm_fault_t;
>    *				fsync() to complete (for synchronous page faults
>    *				in DAX)
>    * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
> + * @VM_FAULT_UFFD_MINOR:	->fault did not modify page tables and needs
> + *				handle_userfault(VM_UFFD_MINOR) to complete
>    * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
>    *
>    */
> @@ -1540,6 +1542,7 @@ enum vm_fault_reason {
>   	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
>   	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
>   	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> +	VM_FAULT_UFFD_MINOR	= (__force vm_fault_t)0x008000,
>   	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
>   };
>   
> diff --git a/mm/memory.c b/mm/memory.c
> index b59ae7ce42eb..94acbac8cefb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5279,6 +5279,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>   	}
>   
>   	ret = vma->vm_ops->fault(vmf);
> +	if (unlikely(ret & VM_FAULT_UFFD_MINOR))
> +		return handle_userfault(vmf, VM_UFFD_MINOR);

If we could define VM_FAULT_UFFD_MINOR to be 0 without USERFAULTFD, we 
could optimize that check out completely on such configs.


-- 
Cheers

David

