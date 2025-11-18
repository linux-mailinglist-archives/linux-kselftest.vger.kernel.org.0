Return-Path: <linux-kselftest+bounces-45873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F2C6AAF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3DA5F2C02C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634234DB47;
	Tue, 18 Nov 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNJ72i/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AA3233E5;
	Tue, 18 Nov 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484082; cv=none; b=dkdew8G32D/Rd2y4bH0JEcuO7Bg55mJ4buHekzdYJ6VmJkUO/Zf/IkUiYYmNq/jKq+MfXLGpJ1ZeF1QSfJCREh0kw3M9pRdfLOMB9MyEVOdRpmkivQK6nqvs+4ok9pQCf4biwrUr90kO8I7UjHn0D+i7D9MzWG8PyEE8AvnaEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484082; c=relaxed/simple;
	bh=76iwa07E2cia9ejh4c5uPXwKmb4vHJQCgXEZEhMo7lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TszpHmfzkanunmTdVL3589ZulsgC3ba6jbfkRpy8PPCg+rGqd2k65Mk6rCY+WVz4bCyYJkg6G4RkGqYdHWV/7aVqMQ8NFfdaXPEQwdIkVARoPkarHxu8747Bljc8BIlcT7ZcP+BftVskR0kZsbOpdlnAr83PhuDp5oykAvzIQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNJ72i/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AA5C2BC86;
	Tue, 18 Nov 2025 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763484082;
	bh=76iwa07E2cia9ejh4c5uPXwKmb4vHJQCgXEZEhMo7lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CNJ72i/QYImuXjY+Pg3BNrRhfOW78dFP48BxEYM13lc4eh3d/QCk+ootmeZ6HYp6V
	 W7R6dP1va7EYMXMgF78zewkbrvEUkCMGbv3s2J500oOaooSHnnUR90xs5zs1GC5cz7
	 jKthpLZGAoPHrKj135vstQa5Zxt/kuCMsKiCTGFzT56xrpn/caKAp6Ff6uUNf0UnJk
	 8gQsBTnrG1eFiG3M/n+uAxMqtDPNa4jK0pz3codcrfDfnjZDBjsr+K6rvlnfYvjFuM
	 4R2veWbx4NRNhwDPDpRSWJr+8B6PIbCMWj0t3veCRhz1ycxHFviUvefkCSBjEc4x2l
	 22FMPgm86U8vg==
Message-ID: <007c08e4-ce70-4c30-b3b1-e25e02dfe29d@kernel.org>
Date: Tue, 18 Nov 2025 17:41:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] userfaultfd, guest_memfd: support userfault minor
 mode in guest_memfd
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
 <20251117114631.2029447-4-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251117114631.2029447-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.11.25 12:46, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> * Export handle_userfault() for KVM module so that fault() handler in
>    guest_memfd would be able to notify userspace about page faults in its
>    address space.
> * Implement get_pagecache_folio() for guest_memfd.
> * And finally, introduce UFFD_FEATURE_MINOR_GENERIC that will allow
>    using userfaultfd minor mode with memory types other than shmem and
>    hugetlb provided they are allowed to call handle_userfault() and
>    implement get_pagecache_folio().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   fs/userfaultfd.c                 |  4 +++-
>   include/uapi/linux/userfaultfd.h |  8 +++++++-
>   virt/kvm/guest_memfd.c           | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 54c6cc7fe9c6..964fa2662d5c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -537,6 +537,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>   out:
>   	return ret;
>   }
> +EXPORT_SYMBOL_FOR_MODULES(handle_userfault, "kvm");
>   
>   static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>   					      struct userfaultfd_wait_queue *ewq)
> @@ -1978,7 +1979,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>   	uffdio_api.features = UFFD_API_FEATURES;
>   #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>   	uffdio_api.features &=
> -		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
> +		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |
> +		  UFFD_FEATURE_MINOR_GENERIC);
>   #endif
>   #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 2841e4ea8f2c..c5cbd4a5a26e 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -42,7 +42,8 @@
>   			   UFFD_FEATURE_WP_UNPOPULATED |	\
>   			   UFFD_FEATURE_POISON |		\
>   			   UFFD_FEATURE_WP_ASYNC |		\
> -			   UFFD_FEATURE_MOVE)
> +			   UFFD_FEATURE_MOVE |			\
> +			   UFFD_FEATURE_MINOR_GENERIC)
>   #define UFFD_API_IOCTLS				\
>   	((__u64)1 << _UFFDIO_REGISTER |		\
>   	 (__u64)1 << _UFFDIO_UNREGISTER |	\
> @@ -210,6 +211,10 @@ struct uffdio_api {
>   	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
>   	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
>   	 *
> +	 * UFFD_FEATURE_MINOR_GENERIC indicates that minor faults can be
> +	 * intercepted for file-backed memory in case subsystem backing this
> +	 * memory supports it.
> +	 *
>   	 * UFFD_FEATURE_EXACT_ADDRESS indicates that the exact address of page
>   	 * faults would be provided and the offset within the page would not be
>   	 * masked.
> @@ -248,6 +253,7 @@ struct uffdio_api {
>   #define UFFD_FEATURE_POISON			(1<<14)
>   #define UFFD_FEATURE_WP_ASYNC			(1<<15)
>   #define UFFD_FEATURE_MOVE			(1<<16)
> +#define UFFD_FEATURE_MINOR_GENERIC		(1<<17)
>   	__u64 features;
>   
>   	__u64 ioctls;
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index fbca8c0972da..5e3c63307fdf 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,7 @@
>   #include <linux/kvm_host.h>
>   #include <linux/pagemap.h>
>   #include <linux/anon_inodes.h>
> +#include <linux/userfaultfd_k.h>
>   
>   #include "kvm_mm.h"
>   
> @@ -369,6 +370,12 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>   		return vmf_error(err);
>   	}
>   
> +	if (userfaultfd_minor(vmf->vma)) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		return handle_userfault(vmf, VM_UFFD_MINOR);
> +	}

Staring at things like VM_FAULT_NEEDDSYNC, I'm wondering whether we could have a
new return value from ->fault that would indicate that
handle_userfault(vmf, VM_UFFD_MINOR) should be called.

Maybe some VM_FAULT_UFFD_MINOR or simply VM_FAULT_USERFAULTFD and we
can just derive that it is VM_UFFD_MINOR.


diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4f66a3206a63c..2cf17da880f0e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1601,6 +1601,8 @@ typedef __bitwise unsigned int vm_fault_t;
   *                             fsync() to complete (for synchronous page faults
   *                             in DAX)
   * @VM_FAULT_COMPLETED:                ->fault completed, meanwhile mmap lock released
+ * @VM_FAULT_USERFAULTFD:      ->fault did not modify page tables and needs
+ *                             handle_userfault() to complete
   * @VM_FAULT_HINDEX_MASK:      mask HINDEX value
   *
   */
@@ -1618,6 +1620,7 @@ enum vm_fault_reason {
         VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
         VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
         VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+       VM_FAULT_USERFAULTFD    = (__force vm_fault_t)0x006000,
         VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
  };
  
@@ -1642,6 +1645,7 @@ enum vm_fault_reason {
         { VM_FAULT_FALLBACK,            "FALLBACK" },   \
         { VM_FAULT_DONE_COW,            "DONE_COW" },   \
         { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
+       { VM_FAULT_USERFAULTFD,         "USERFAULTFD" },\
         { VM_FAULT_COMPLETED,           "COMPLETED" }
  
  struct vm_special_mapping {


IIUC, we have exactly two invocations of ->fault(vmf) in memory.c where
we would have to handle it IIUC. And the return value would never leave
the core.

That way, we wouldn't have to export handle_userfault().

Just a thought ...

-- 
Cheers

David

