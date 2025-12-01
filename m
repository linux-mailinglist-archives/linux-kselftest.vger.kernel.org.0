Return-Path: <linux-kselftest+bounces-46828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58BC985AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBC464E1E78
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD776334C06;
	Mon,  1 Dec 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EAdUvow/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94F2D46A1;
	Mon,  1 Dec 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607726; cv=none; b=aljCef7zF4ix0npCJ8WFywC/GeKIJtQEmiXVKV+M3Ppm7KI4ow6LEd/iGMggrBOTSNKQL03Oa57+FobA7ftoI6jokmU8oQWysR/nDTvj5WUlQdZt8RsZNB0Zi9v5bRQQK4216zijCURjExX2Nw+EPEL8JhmvLP9yzBdq68ceqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607726; c=relaxed/simple;
	bh=ijPAOiIgyO928w8Pq5+TaAfDbz/lzcbAhje0WPIo6pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kgiUn9TauIkX32p0QpqOtiwaX4MDIMZYi9+t4t1IqTlM/Yyb4kHXP8oqvy+tNu0YEVXLkcKozHXdnnRv2ESM74VTAdoBXW3tJ6kv2zgwHpB91RCf+4MBK3Yv1Mti5qQTNZnAvzOCAh7MtDr+a2bnCwiBXxCTqMiHccMuJ6PS+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EAdUvow/; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764607724; x=1796143724;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=GUFyYw4pB+c3aOIproKrVQP+K7Byw/zyZ7lr1XDUkCs=;
  b=EAdUvow/4b+JwzRwihlQ/sZ4oKVqPRZNcimnaFERmfgmUI7J6V9Dw8uP
   MHjg36G6NBdR2SpNPIr/pT4+49AC1u8cb89jSkUOUySTxc/2YxduDAQX9
   JoIZZBonVPQ0IRDdOeJfF0wBK3iuFedqeYpiH2SwBNccodi+uMbYQPnQC
   Wiqm3YwcvUOXK2EeR5Xge8AbiVrhc5o4cDQdhIyFMyLAYpkErYFQTirsW
   1vu6pRfVUCv8exf0UrCM3rJslVVKJXxndzQBFxM6KxhvrelBoArNDDcON
   Cl2KTgmGtbG6BR7F2vuUaSTYTCbEk+Uvt5xHNBMIbk6kkgelfeZh2JgXZ
   Q==;
X-CSE-ConnectionGUID: xidBH/+aRnWMIv82jcbdVQ==
X-CSE-MsgGUID: aicuxPHXSrSVLyblJP5eHw==
X-IronPort-AV: E=Sophos;i="6.20,241,1758585600"; 
   d="scan'208";a="5974415"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 16:48:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:18138]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.211:2525] with esmtp (Farcaster)
 id ee641cb8-e319-4dd3-9bca-f35a2cee9a66; Mon, 1 Dec 2025 16:48:25 +0000 (UTC)
X-Farcaster-Flow-ID: ee641cb8-e319-4dd3-9bca-f35a2cee9a66
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 16:48:24 +0000
Received: from [192.168.8.132] (10.106.82.12) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Mon, 1 Dec 2025
 16:48:23 +0000
Message-ID: <553c64e8-d224-4764-9057-84289257cac9@amazon.com>
Date: Mon, 1 Dec 2025 16:48:22 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, <linux-mm@kvack.org>
CC: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
	<peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-5-rppt@kernel.org>
 <652578cc-eeff-4996-8c80-e26682a57e6d@amazon.com>
 <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
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
In-Reply-To: <2d98c597-0789-4251-843d-bfe36de25bd2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D004EUA001.ant.amazon.com (10.252.50.27) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 01/12/2025 15:54, David Hildenbrand (Red Hat) wrote:
> On 12/1/25 14:39, Nikita Kalyazin wrote:
>>
>>
>> On 30/11/2025 11:18, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> userfaultfd notifications about minor page faults used for live 
>>> migration
>>> and snapshotting of VMs with memory backed by shared hugetlbfs or tmpfs
>>> mappings as described in detail in commit 7677f7fd8be7 ("userfaultfd: 
>>> add
>>> minor fault registration mode").
>>>
>>> To use the same mechanism for VMs that use guest_memfd to map their 
>>> memory,
>>> guest_memfd should support userfaultfd minor mode.
>>>
>>> Extend ->fault() method of guest_memfd with ability to notify core page
>>> fault handler that a page fault requires 
>>> handle_userfault(VM_UFFD_MINOR) to
>>> complete and add implementation of ->get_folio_noalloc() to guest_memfd
>>> vm_ops.
>>>
>>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>    virt/kvm/guest_memfd.c | 33 ++++++++++++++++++++++++++++++++-
>>>    1 file changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>> index ffadc5ee8e04..dca6e373937b 100644
>>> --- a/virt/kvm/guest_memfd.c
>>> +++ b/virt/kvm/guest_memfd.c
>>> @@ -4,6 +4,7 @@
>>>    #include <linux/kvm_host.h>
>>>    #include <linux/pagemap.h>
>>>    #include <linux/anon_inodes.h>
>>> +#include <linux/userfaultfd_k.h>
>>>
>>>    #include "kvm_mm.h"
>>>
>>> @@ -359,7 +360,15 @@ static vm_fault_t 
>>> kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
>>>           if (!((u64)inode->i_private & GUEST_MEMFD_FLAG_INIT_SHARED))
>>>                   return VM_FAULT_SIGBUS;
>>>
>>> -       folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>>> +       folio = filemap_lock_folio(inode->i_mapping, vmf->pgoff);
>>> +       if (!IS_ERR_OR_NULL(folio) && userfaultfd_minor(vmf->vma)) {
>>> +               ret = VM_FAULT_UFFD_MINOR;
>>> +               goto out_folio;
>>> +       }
>>
>> I realised that I might have been wrong in [1] saying that the noalloc
>> get folio was ok for our use case.  Unfortunately we rely on a minor
>> fault to get generated even when the page is being allocated.  Peter and
>> I discussed it originally in [2].  Since we want to populate guest
>> memory with the content supplied by userspace on demand, we have to be
>> able to intercept the very first access, meaning we either need a minor
>> or major UFFD event for that.  We decided to make use of the minor at
>> the time.  If we have to preserve the shmem semantics, it forces us to
>> implement support for major/UFFDIO_COPY.
> 
> If we want missing semantics then likely we should be adding ... missing
> support? :)

I believe I found the precise point where we convinced ourselves that 
minor support was sufficient: [1].  If at this moment we don't find that 
reasoning valid anymore, then indeed implementing missing is the only 
option.

[1] https://lore.kernel.org/kvm/Z9GsIDVYWoV8d8-C@x1.local

> 
> -- 
> Cheers
> 
> David


