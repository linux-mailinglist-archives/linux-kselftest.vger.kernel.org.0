Return-Path: <linux-kselftest+bounces-30073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91395A7A859
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E433AADE2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03F2512ED;
	Thu,  3 Apr 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KmdaZ8rx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FF19ABD4;
	Thu,  3 Apr 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699701; cv=none; b=LlqE6B7p2kyGMwqxNv4bpAcDj5VGoCPyMy3WysRzekpY3IqV4hpuvI0E4lNtF4Q9R8IcC4tmG6U0C2gJGLgMIZzWQ0hyltDZPckfP5bUuG97zfZ9RvrGYqHGSZfSGUtdAXXDig0FzYcKOI2r0iga8Fv6eIUSFzrplEKIWx+oKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699701; c=relaxed/simple;
	bh=/jPjW9qloD71ESPZMS/ulgcnMsb+t0vSmbV8OIaJYI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b5n2h67UZ5tTb7rFdXN9zJT1BlLIz9lktQhYLiNA0jG/M+JuQF73A8xjo6OuB+qbJyjSPfC7dUIUU6Ir0KSEZf72Ph4ADCi3KAMHPDobBkJrB7zp3mi/87iBimQgS9CK+PopWRCoGwG/va4KM8NF1573grOdlT5IlGfD8OlDBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KmdaZ8rx; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743699699; x=1775235699;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=fgBFSqRBMvJIhoEL8t5/weTt711thPXAbfYiTxlEOwQ=;
  b=KmdaZ8rxkk1YaYO1DJKNVN2fkft9aTY2FCE1xlV+YkV2sLPQu5k8NZgK
   JIr0S3er6jp9ZOGcFCivJ69F1LOudUf3ks83DNFQlUAP4PbRWHqGYzdJb
   pFZOxgsRAQcUdKLDYnExenp4mnZMmwPRpXjbBbCwYA7U2JSvFzyytlD+3
   A=;
X-IronPort-AV: E=Sophos;i="6.15,184,1739836800"; 
   d="scan'208";a="477267433"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 17:01:35 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:22038]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.20:2525] with esmtp (Farcaster)
 id 1e7deb8f-4698-4cb9-98e4-58e352c395be; Thu, 3 Apr 2025 17:01:34 +0000 (UTC)
X-Farcaster-Flow-ID: 1e7deb8f-4698-4cb9-98e4-58e352c395be
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 17:01:34 +0000
Received: from [192.168.28.77] (10.106.82.23) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 3 Apr 2025
 17:01:32 +0000
Message-ID: <16763ece-fa3b-4a68-9b3c-5331954d96e7@amazon.com>
Date: Thu, 3 Apr 2025 18:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 1/5] mm: userfaultfd: generic continue for non
 hugetlbfs
To: James Houghton <jthoughton@google.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <peterx@redhat.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250402160721.97596-1-kalyazin@amazon.com>
 <20250402160721.97596-2-kalyazin@amazon.com>
 <CADrL8HW2bFsFqifTytY8+Fy1nH-arFZ2JqAKi44_4nMtkPksDA@mail.gmail.com>
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
In-Reply-To: <CADrL8HW2bFsFqifTytY8+Fy1nH-arFZ2JqAKi44_4nMtkPksDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D009EUA004.ant.amazon.com (10.252.50.97) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 02/04/2025 20:04, James Houghton wrote:
> On Wed, Apr 2, 2025 at 9:07 AM Nikita Kalyazin <kalyazin@amazon.com> wrote:
>>
>> Remove shmem-specific code from UFFDIO_CONTINUE implementation for
>> non-huge pages by calling vm_ops->fault().  A new VMF flag,
>> FAULT_FLAG_NO_USERFAULT_MINOR, is introduced to avoid recursive call to
>> handle_userfault().
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   include/linux/mm_types.h |  3 +++
>>   mm/hugetlb.c             |  2 +-
>>   mm/shmem.c               |  3 ++-
>>   mm/userfaultfd.c         | 25 ++++++++++++++++++-------
>>   4 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 0234f14f2aa6..91a00f2cd565 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1429,6 +1429,8 @@ enum tlb_flush_reason {
>>    * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>>    *                        We should only access orig_pte if this flag set.
>>    * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
>> + * @FAULT_FLAG_NO_USERFAULT_MINOR: The fault handler must not call userfaultfd
>> + *                                 minor handler.
> 
> Perhaps instead a flag that says to avoid the userfaultfd minor fault
> handler, maybe we should have a flag to indicate that vm_ops->fault()
> has been called by UFFDIO_CONTINUE. See below.
> 
>>    *
>>    * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>>    * whether we would allow page faults to retry by specifying these two
>> @@ -1467,6 +1469,7 @@ enum fault_flag {
>>          FAULT_FLAG_UNSHARE =            1 << 10,
>>          FAULT_FLAG_ORIG_PTE_VALID =     1 << 11,
>>          FAULT_FLAG_VMA_LOCK =           1 << 12,
>> +       FAULT_FLAG_NO_USERFAULT_MINOR = 1 << 13,
>>   };
>>
>>   typedef unsigned int __bitwise zap_flags_t;
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 97930d44d460..ba90d48144fc 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6228,7 +6228,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>>                  }
>>
>>                  /* Check for page in userfault range. */
>> -               if (userfaultfd_minor(vma)) {
>> +               if (userfaultfd_minor(vma) && !(vmf->flags & FAULT_FLAG_NO_USERFAULT_MINOR)) {
>>                          folio_unlock(folio);
>>                          folio_put(folio);
>>                          /* See comment in userfaultfd_missing() block above */
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 1ede0800e846..5e1911e39dec 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2467,7 +2467,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>          fault_mm = vma ? vma->vm_mm : NULL;
>>
>>          folio = filemap_get_entry(inode->i_mapping, index);
>> -       if (folio && vma && userfaultfd_minor(vma)) {
>> +       if (folio && vma && userfaultfd_minor(vma) &&
>> +           !(vmf->flags & FAULT_FLAG_NO_USERFAULT_MINOR)) {
>>                  if (!xa_is_value(folio))
>>                          folio_put(folio);
>>                  *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>> index d06453fa8aba..68a995216789 100644
>> --- a/mm/userfaultfd.c
>> +++ b/mm/userfaultfd.c
>> @@ -386,24 +386,35 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>>                                       unsigned long dst_addr,
>>                                       uffd_flags_t flags)
>>   {
>> -       struct inode *inode = file_inode(dst_vma->vm_file);
>> -       pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
>>          struct folio *folio;
>>          struct page *page;
>>          int ret;
>> +       struct vm_fault vmf = {
>> +               .vma = dst_vma,
>> +               .address = dst_addr,
>> +               .flags = FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE |
>> +                   FAULT_FLAG_NO_USERFAULT_MINOR,
>> +               .pte = NULL,
>> +               .page = NULL,
>> +               .pgoff = linear_page_index(dst_vma, dst_addr),
>> +       };
>> +
>> +       if (!dst_vma->vm_ops || !dst_vma->vm_ops->fault)
>> +               return -EINVAL;
>>
>> -       ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
>> -       /* Our caller expects us to return -EFAULT if we failed to find folio */
>> -       if (ret == -ENOENT)
>> +       ret = dst_vma->vm_ops->fault(&vmf);
> 
> shmem_get_folio() was being called with SGP_NOALLOC, and now it is
> being called with SGP_CACHE (by shmem_fault()). This will result in a
> UAPI change: UFFDIO_CONTINUE for a VA without a page in the page cache
> should result in EFAULT, but now the page will be allocated.
> SGP_NOALLOC was carefully chosen[1], so I think a better way to do
> this will be to:
> 
> 1. Have a FAULT_FLAG_USERFAULT_CONTINUE (or something)
> 2. In shmem_fault(), if FAULT_FLAG_USERFAULT_CONTINUE, use SGP_NOALLOC
> instead of SGP_CACHE (and make sure not to drop into
> handle_userfault(), of course)

Yes, that is very true.  Thanks for pointing out.  Will apply in the 
next version.

> 
> [1]: https://lore.kernel.org/linux-mm/20220610173812.1768919-1-axelrasmussen@google.com/
> 
>> +       if (ret & VM_FAULT_ERROR) {
>>                  ret = -EFAULT;
>> -       if (ret)
>>                  goto out;
>> +       }
>> +
>> +       page = vmf.page;
>> +       folio = page_folio(page);
>>          if (!folio) {
> 
> What if ret == VM_FAULT_RETRY? I think we should retry instead instead
> of returning -EFAULT.

True.  I'm going to retry the vm_ops->fault() call in this case.

> 
> And I'm not sure how VM_FAULT_NOPAGE should be handled, like if we
> need special logic for it or not.

As far as I see, the only case it can come up in shmem is during a fault 
when a hole is being punched [1].  I'm thinking of returning EAGAIN to 
the userspace if this happens.

[1] https://elixir.bootlin.com/linux/v6.14-rc6/source/mm/shmem.c#L2670

> 
>>                  ret = -EFAULT;
>>                  goto out;
>>          }
>>
>> -       page = folio_file_page(folio, pgoff);
>>          if (PageHWPoison(page)) {
>>                  ret = -EIO;
>>                  goto out_release;
>> --
>> 2.47.1
>>


