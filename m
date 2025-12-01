Return-Path: <linux-kselftest+bounces-46812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2595C9821F
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9987B3436FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0578F333445;
	Mon,  1 Dec 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smsBE6HJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02DD33343E;
	Mon,  1 Dec 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604502; cv=none; b=g1ZC+gpy1W8qMJ9vifvAc31KAW3IP9EEXefBf9YtBJoyYMlYwKhbrFaHBM0x0pV7QG+mfbrB3FZLkvyVnj6z3preDhpS4JK+00bhMIuMfOUO5L9Cll1sAgs1FG/eXUjvF+TvYtw4EApGnApk8Jz9OwWsb7ip21cSKiwlbg2Rcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604502; c=relaxed/simple;
	bh=A2bhAHCrw29Gn04uGgzYEmynbjTQgb8sVC7Kb2YAar8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xmlfhs/oADOVZtA9Y9UiHQ0DXJKsuEGgSJcO9bR63/NNS90qcvYkiUahwaE58Mov8D78m1+wenmdlSuaxEP2mtx/swvMYT1V3L41iMv4sSFSKbue+hn+vTQ7WJ6s8nduFvIDtcWYF2gspAdKA/+P9tBR8v12Wx6dNFPJ5ezsIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smsBE6HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C437C16AAE;
	Mon,  1 Dec 2025 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764604502;
	bh=A2bhAHCrw29Gn04uGgzYEmynbjTQgb8sVC7Kb2YAar8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=smsBE6HJo57XGVHY+R3/NXxGlT70EutobA9ZHAG37qQxBteEMSs8iiALqNACEX/lB
	 XM7cw6uALYdyYimZ8qeDw0ti+SXt6eAnuEjN6SvfvTYp3ESDQgupwedvasAnNiQUl4
	 +Npr5UTXMcsXdRIUwu3ai2+NT8nzskfHozuTM0ppbeKZ1pFUqJxCYy7Ny1dprih60S
	 N/62Te0hf+IYLcy0r57iuQ2JF83dZ7VSvxhxhz7sWll4bZQoCfnRn+mAgDtRUM77o7
	 CvoBXRLv6TUmA2VLchO0nOpDYR6aE0/lzDhe/x8N/SAcWa44PbwXiUQY67ZYhBrZNn
	 EMxobJQMv5d9w==
Message-ID: <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
Date: Mon, 1 Dec 2025 16:54:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: kalyazin@amazon.com, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 14:39, Nikita Kalyazin wrote:
> 
> 
> On 30/11/2025 11:18, Mike Rapoport wrote:
>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>
>> userfaultfd notifications about minor page faults used for live migration
>> and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
>> mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: add
>> minor fault registration mode").
>>
>> To use the same mechanism for VMs that use guest_memfd to map their memory,
>> guest_memfd should support userfaultfd minor mode.
>>
>> Extend ->fault() method of guest_memfd with ability to notify core page
>> fault handler that a page fault requires handle_userfault(VM_UFFD_MINOR) to
>> complete and add implementation of ->get_folio_noalloc() to guest_memfd
>> vm_ops.
>>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>>    virt/kvm/guest_memfd.c | 33 ++++++++++++++++++++++++++++++++-
>>    1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index ffadc5ee8e04..dca6e373937b 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -4,6 +4,7 @@
>>    #include <linux/kvm_host.h>
>>    #include <linux/pagemap.h>
>>    #include <linux/anon_inodes.h>
>> +#include <linux/userfaultfd_k.h>
>>
>>    #include "kvm_mm.h"
>>
>> @@ -359,7 +360,15 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>           if (!((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED))
>>                   return VM_FAULT_SIGBUS;
>>
>> -       folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>> +       folio = filemap_lock_folio(inode->i_mapping, vmf->pgoff);
>> +       if (!IS_ERR_OR_NULL(folio) && userfaultfd_minor(vmf->vma)) {
>> +               ret = VM_FAULT_UFFD_MINOR;
>> +               goto out_folio;
>> +       }
> 
> I realised that I might have been wrong in [1] saying that the noalloc
> get folio was ok for our use case.  Unfortunately we rely on a minor
> fault to get generated even when the page is being allocated.  Peter and
> I discussed it originally in [2].  Since we want to populate guest
> memory with the content supplied by userspace on demand, we have to be
> able to intercept the very first access, meaning we either need a minor
> or major UFFD event for that.  We decided to make use of the minor at
> the time.  If we have to preserve the shmem semantics, it forces us to
> implement support for major/UFFDIO_COPY.

If we want missing semantics then likely we should be adding ... missing 
support? :)

-- 
Cheers

David

