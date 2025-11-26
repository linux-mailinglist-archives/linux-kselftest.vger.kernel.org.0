Return-Path: <linux-kselftest+bounces-46529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2712C8B0F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8184A4ED06B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDAF33F36E;
	Wed, 26 Nov 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gc4ge9sS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734933EB1D;
	Wed, 26 Nov 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175774; cv=none; b=kzLrLnfF86JyhCC1bGqNES4QtSh7Wm4Kpr+Tn0ogOm8GJlTAUncJJVRQomA/1WVQzVjW8T9MJtpbViKDoTWq6nnmHhH+Zq7buNevkz+CmqITqn/xSxCN/Z01Hnin527q0HtcyVKM/ybMu5qQOlj/2XqvqCrnYqZ7oUBJTgyqEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175774; c=relaxed/simple;
	bh=5SsNInqEQBT6lxL7/CN96dYskG77UCJ09kLHMrzaEf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CSgZAgnrlQNmT1Ec+wsYrVi1ow4NEjKXdslQ6a4c3UGBLjlYN8BznFOYcki7m7ka1Vtc1IrVWjAKzZTIn64Mr2QzjtVDtmATKVL20jxWzsN8csv8Qc+C6Gqwf+SSjoZ7j1f0cbu7lYW6Nj9P/odvvMVI0YruKYrzaiRCWbtWLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gc4ge9sS; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764175772; x=1795711772;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=x7VXVCGx/0PdLhk+nsghb8qTMaImKePvh7JEix7jeY4=;
  b=Gc4ge9sSvir+7RM1RfcGTSS8rK588yqfel5CCL1QcTQ9lmuPZJmQadvh
   skAoGfim0+Rxq+oATzPEqPu1bLzqSFDLTtUUM/ixQJSAMLbYJYoWh08Ot
   57xbsJ84Dq3MJF7YKqyizPc5Sl3eo3PqHRN3NFm3zLuKj6wSa0dbPrSus
   PpbcWncQjPxtazR0SjJ7mGX3C+oFQ601+RQsmfeRDI6AmS/xEiFLHOQ2A
   gWJWZChQ+7vh5eJXVKRX+3xmxVfb9f41GFuH3OmeKtCzfw9MwXkg8wHoZ
   uiIPaat2myLifKcun0EhLBogOs3DHZZk130D2P4cfnaWSxrZmbbWiCl5N
   g==;
X-CSE-ConnectionGUID: PSbtWkjGQpyyl29xoV29RQ==
X-CSE-MsgGUID: m+DW7VpVTBeEayJbqQJGbg==
X-IronPort-AV: E=Sophos;i="6.20,228,1758585600"; 
   d="scan'208";a="5850247"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 16:49:13 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:14001]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.247:2525] with esmtp (Farcaster)
 id 7187bdac-8cef-490c-8568-2d44c5bc3585; Wed, 26 Nov 2025 16:49:13 +0000 (UTC)
X-Farcaster-Flow-ID: 7187bdac-8cef-490c-8568-2d44c5bc3585
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 26 Nov 2025 16:49:12 +0000
Received: from [192.168.8.204] (10.106.83.30) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 26 Nov 2025
 16:49:11 +0000
Message-ID: <6e93a9b7-f731-4609-a034-2b78423e22e5@amazon.com>
Date: Wed, 26 Nov 2025 16:49:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
To: Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand
	<david@redhat.com>, Hugh Dickins <hughd@google.com>, James Houghton
	<jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, Michal Hocko
	<mhocko@suse.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Xu
	<peterx@redhat.com>, "Sean Christopherson" <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, "David Hildenbrand (Red Hat)"
	<david@kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-4-rppt@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <20251125183840.2368510-4-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D003EUA004.ant.amazon.com (10.252.50.128) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 25/11/2025 18:38, Mike Rapoport wrote:
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
> For configurations that don't enable CONFIG_USERFAULTFD,
> VM_FAULT_UFFD_MINOR is set to 0.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/mm_types.h | 10 +++++++++-
>   mm/memory.c              |  2 ++
>   mm/shmem.c               |  2 +-
>   3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 90e5790c318f..df71b057111b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1523,6 +1523,8 @@ typedef __bitwise unsigned int vm_fault_t;
>    *                             fsync() to complete (for synchronous page faults
>    *                             in DAX)
>    * @VM_FAULT_COMPLETED:                ->fault completed, meanwhile mmap lock released
> + * @VM_FAULT_UFFD_MINOR:       ->fault did not modify page tables and needs
> + *                             handle_userfault(VM_UFFD_MINOR) to complete
>    * @VM_FAULT_HINDEX_MASK:      mask HINDEX value
>    *
>    */
> @@ -1540,6 +1542,11 @@ enum vm_fault_reason {
>          VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
>          VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
>          VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> +#ifdef CONFIG_USERFAULTFD
> +       VM_FAULT_UFFD_MINOR     = (__force vm_fault_t)0x008000,
> +#else
> +       VM_FAULT_UFFD_MINOR     = (__force vm_fault_t)0x000000,
> +#endif
>          VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
>   };
> 
> @@ -1564,7 +1571,8 @@ enum vm_fault_reason {
>          { VM_FAULT_FALLBACK,            "FALLBACK" },   \
>          { VM_FAULT_DONE_COW,            "DONE_COW" },   \
>          { VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },  \
> -       { VM_FAULT_COMPLETED,           "COMPLETED" }
> +       { VM_FAULT_COMPLETED,           "COMPLETED" },  \
> +       { VM_FAULT_UFFD_MINOR,          "UFFD_MINOR" }, \

It looks like we have to keep the last element comma-less, otherwise I'm 
seeing compile errors somewhere in fs/dax.c.

> 
>   struct vm_special_mapping {
>          const char *name;       /* The name, e.g. "[vdso]". */
> diff --git a/mm/memory.c b/mm/memory.c
> index b59ae7ce42eb..94acbac8cefb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5279,6 +5279,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>          }
> 
>          ret = vma->vm_ops->fault(vmf);
> +       if (unlikely(ret & VM_FAULT_UFFD_MINOR))
> +               return handle_userfault(vmf, VM_UFFD_MINOR);
>          if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
>                              VM_FAULT_DONE_COW)))
>                  return ret;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e16c7c8c3e1e..a9a31c0b5979 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2461,7 +2461,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>          if (folio && vma && userfaultfd_minor(vma)) {
>                  if (!xa_is_value(folio))
>                          folio_put(folio);
> -               *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> +               *fault_type = VM_FAULT_UFFD_MINOR;
>                  return 0;
>          }
> 
> --
> 2.50.1
> 


