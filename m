Return-Path: <linux-kselftest+bounces-46784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C2C96565
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEF5334419E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5E3002A9;
	Mon,  1 Dec 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8zdSJ62"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CD2FFF9D;
	Mon,  1 Dec 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580367; cv=none; b=Q9QKpyZpG9R3bYRqrEZwzag2YV1jMn0/m7QbRguBhZi2hajp4N7fnX3/UXRviljhrB666dE7wV5bZADLyGjky2WnVFUex1byf5XLMAaxzDuvYXp3NuvE4C5stwl3hv9ynqLcybUkSr/dA2r+lyyAFNim7j5qk+JOENmHvzkS2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580367; c=relaxed/simple;
	bh=InzzoRi4sMwF5UAjcjxn8h6bfGO56WHUkwSr4ysFVAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm+9ecieEDOPJdmZtmUZfbCLYI9rv/SPk6qM3pEnlPVnOmTSyIJu/t/xl/m3iYVmHYXLBE31x1O35ig9BiJYwsNxLWjTh0aR7pFvfbne2ggKY8/9LjHmKLX8ZbxiIHVsuO4BfGsgMOGE/IOTc1e7QQQe/uy7wXMDJAChVgXqRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8zdSJ62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C80C4CEF1;
	Mon,  1 Dec 2025 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764580366;
	bh=InzzoRi4sMwF5UAjcjxn8h6bfGO56WHUkwSr4ysFVAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O8zdSJ62lsZX1UqcRK56slWK1In8AZrXMfXAd2VdEbVk2Xgn+zXW6pigE42wp/BLx
	 JOgSmGg2QpEtSdamdFLOsSOfx81Oh6q5uN4Wae0Mjs6thxYpfTIeR1AVP3hycf2kCk
	 HhTGTeO+roQo6HTCW4AqTK+xOJtDMo+4GtudAnmSze9y0se0WAFD8eNAf/tW1lAxDT
	 JEjoGXoJDZuHIKqwfVbjHImB2pJTw+MCNlFms74PVN1SX5QUUl0DXX53ZSg8d8nXJ1
	 6YPGx/UbSwjz1j4BmMeZJI59h4wO09tf7mo0KjfzD/30bvjTjfmavRhdSfcsb7aUqz
	 R01CkzAKLSo9g==
Message-ID: <c3ae6036-df95-4874-ad7a-6077a30ae726@kernel.org>
Date: Mon, 1 Dec 2025 10:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
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
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251130111812.699259-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/25 12:18, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> userfaultfd notifications about minor page faults used for live migration
> and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
> mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: add
> minor fault registration mode").
> 
> To use the same mechanism for VMs that use guest_memfd to map their memory,
> guest_memfd should support userfaultfd minor mode.
> 
> Extend ->fault() method of guest_memfd with ability to notify core page
> fault handler that a page fault requires handle_userfault(VM_UFFD_MINOR) to
> complete and add implementation of ->get_folio_noalloc() to guest_memfd
> vm_ops.
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   virt/kvm/guest_memfd.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index ffadc5ee8e04..dca6e373937b 100644
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
> @@ -359,7 +360,15 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>   	if (!((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED))
>   		return VM_FAULT_SIGBUS;
>   
> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> +	folio = filemap_lock_folio(inode->i_mapping, vmf->pgoff);
> +	if (!IS_ERR_OR_NULL(folio) && userfaultfd_minor(vmf->vma)) {

Can we ever get NULL here?

> +		ret = VM_FAULT_UFFD_MINOR;
> +		goto out_folio;
> +	}
> +
> +	if (PTR_ERR(folio) == -ENOENT)
> +		folio = kvm_gmem_get_folio(inode, vmf->pgoff);

Was briefly wondering what the performance impact of that two-step 
approach is (two lookups in case we have to create it IIUC)

Wouldn't it be better to limit it to the userfaultfd_minor(vmf->vma) case?


if (userfaultfd_minor(vmf->vma)) {
	folio = filemap_lock_folio(inode->i_mapping, vmf->pgoff);
	if (!IS_ERR(folio)) {
		ret = VM_FAULT_UFFD_MINOR;
		goto out_folio;
	}
} else {
	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
}

if (IS_ERR(folio)) {
...

-- 
Cheers

David

