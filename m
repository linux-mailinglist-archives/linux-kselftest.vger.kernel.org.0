Return-Path: <linux-kselftest+bounces-28759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD813A5CB67
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C3F17BF29
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BF260A58;
	Tue, 11 Mar 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lbjV6Vna"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C953184F;
	Tue, 11 Mar 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712220; cv=none; b=IkloNwa0A3QujEplnpPJk+PZH54gMMm4b+Qpq5lKmOer4hO88nANbFuQIyVSspSbkb+btRL0ZZrzmIiQeM0RWY2725oVii7FuqPvMZGfjtuYhtjE0gU0AB/zALFmk8T13bX2Q8nY4DL3/hDznYThvabti2FUuPzEqIRqur0XEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712220; c=relaxed/simple;
	bh=nDMt8eiwz7+zam9WwPXd2KG0XnvM1fHkqQ7RgCtM+vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZNST/oMdN0+akNSbFu7MfKLU8PoTxJqokakPIPwJ0TBUaRRfv7hMjyz1RK5bFu2FfFDLYoEElbhrQNwL0QJwBF/OiRrHq8vJvftCk6bNDanhlNeGIu/ooBZW+Xaujfm6U0gMvWdiED6R/fqiT7KoQM5CleJ7zIofLhdCpIH/LVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lbjV6Vna; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741712219; x=1773248219;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=tlV9Mo9aek/qm0du1iKz9kkFBfH6SyE9Qgk2PjqxtjE=;
  b=lbjV6VnaIXFhjHX8QYJsT9wL0C7i3XdJzLBucFTccLiaqePr6YNfELW+
   vKhWBa0V5M2L39XbwgJc9gqU+3P8MGbY1gTJxdQsnIIYA26ri5r9cRAnS
   IbnDJqKAAVcZ/0ZPhUwMob0ebmjzq3sUBsbb+MRzvFwyGfkLFtMYR5SrV
   E=;
X-IronPort-AV: E=Sophos;i="6.14,239,1736812800"; 
   d="scan'208";a="385729533"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 16:56:50 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:6023]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.251:2525] with esmtp (Farcaster)
 id f548cd40-c792-49af-ad1d-1f5d23f80cf5; Tue, 11 Mar 2025 16:56:49 +0000 (UTC)
X-Farcaster-Flow-ID: f548cd40-c792-49af-ad1d-1f5d23f80cf5
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 16:56:49 +0000
Received: from [10.95.111.253] (10.95.111.253) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 16:56:48 +0000
Message-ID: <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
Date: Tue, 11 Mar 2025 16:56:47 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
To: Peter Xu <peterx@redhat.com>
CC: James Houghton <jthoughton@google.com>, <akpm@linux-foundation.org>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lorenzo.stoakes@oracle.com>, <david@redhat.com>,
	<ryan.roberts@arm.com>, <quic_eberman@quicinc.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250303133011.44095-1-kalyazin@amazon.com>
 <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local> <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
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
In-Reply-To: <Z89EFbT_DKqyJUxr@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUA004.ant.amazon.com (10.252.50.94) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 10/03/2025 19:57, Peter Xu wrote:
> On Mon, Mar 10, 2025 at 06:12:22PM +0000, Nikita Kalyazin wrote:
>>
>>
>> On 05/03/2025 20:29, Peter Xu wrote:
>>> On Wed, Mar 05, 2025 at 11:35:27AM -0800, James Houghton wrote:
>>>> I think it might be useful to implement an fs-generic MINOR mode. The
>>>> fault handler is already easy enough to do generically (though it
>>>> would become more difficult to determine if the "MINOR" fault is
>>>> actually a MISSING fault, but at least for my userspace, the
>>>> distinction isn't important. :)) So the question becomes: what should
>>>> UFFDIO_CONTINUE look like?
>>>>
>>>> And I think it would be nice if UFFDIO_CONTINUE just called
>>>> vm_ops->fault() to get the page we want to map and then mapped it,
>>>> instead of having shmem-specific and hugetlb-specific versions (though
>>>> maybe we need to keep the hugetlb specialization...). That would avoid
>>>> putting kvm/gmem/etc. symbols in mm/userfaultfd code.
>>>>
>>>> I've actually wanted to do this for a while but haven't had a good
>>>> reason to pursue it. I wonder if it can be done in a
>>>> backwards-compatible fashion...
>>>
>>> Yes I also thought about that. :)
>>
>> Hi Peter, hi James.  Thanks for pointing at the race condition!
>>
>> I did some experimentation and it indeed looks possible to call
>> vm_ops->fault() from userfault_continue() to make it generic and decouple
>> from KVM, at least for non-hugetlb cases.  One thing is we'd need to prevent
>> a recursive handle_userfault() invocation, which I believe can be solved by
>> adding a new VMF flag to ignore the userfault path when the fault handler is
>> called from userfault_continue().  I'm open to a more elegant solution
>> though.
> 
> It sounds working to me.  Adding fault flag can also be seen as part of
> extension of vm_operations_struct ops.  So we could consider reusing
> fault() API indeed.

Great!

>>
>> Regarding usage of the MINOR notification, in what case do you recommend
>> sending it?  If following the logic implemented in shmem and hugetlb, ie if
>> the page is _present_ in the pagecache, I can't see how it is going to work
> 
> It could be confusing when reading that chunk of code, because it looks
> like it notifies minor fault when cache hit. But the critical part here is
> that we rely on the pgtable missing causing the fault() to trigger first.
> So it's more like "cache hit && pgtable missing" for minor fault.

Right, but the cache hit still looks like a precondition for the minor 
fault event?

>> with the write syscall, as we'd like to know when the page is _missing_ in
>> order to respond with the population via the write.  If going against
>> shmem/hugetlb logic, and sending the MINOR event when the page is missing
>> from the pagecache, how would it solve the race condition problem?
> 
> Should be easier we stick with mmap() rather than write().  E.g. for shmem
> case of current code base:
> 
>          if (folio && vma && userfaultfd_minor(vma)) {
>                  if (!xa_is_value(folio))
>                          folio_put(folio);
>                  *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
>                  return 0;
>          }
> 
> vma is only availble if vmf!=NULL, aka in fault context.  With that, in
> write() to shmem inodes, nothing will generate a message, because minor
> fault so far is only about pgtable missing.  It needs to be mmap()ed first,
> and has nothing yet to do with write() syscalls.

Yes, that's true that write() itself isn't going to generate a message. 
My idea was to _respond_ to a message generated by the fault handler 
(vmf != NULL) with a write().  I didn't mean to generate it from write().

What I wanted to achieve was send a message on fault + cache miss and 
respond to the message with a write() to fill the cache followed by a 
UFFDIO_CONTINUE to set up pagetables.  I understand that a MINOR trap 
(MINOR + UFFDIO_CONTINUE) is preferable, but how does it fit into this 
model?  What/how will guarantee a cache hit that would trigger the MINOR 
message?

To clarify, I would like to be able to populate pages _on-demand_, not 
only proactively (like in the original UFFDIO_CONTINUE cover letter 
[1]).  Do you think the MINOR trap could still be applicable or would it 
necessarily require the MISSING trap?

[1] 
https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/T/

>>
>> Also, where would the check for the folio_test_uptodate() mentioned by James
>> fit into here?  Would it only be used for fortifying the MINOR (present)
>> against the race?
>>
>>> When Axel added minor fault, it's not a major concern as it's the only fs
>>> that will consume the feature anyway in the do_fault() path - hugetlbfs has
>>> its own path to take care of.. even until now.
>>>
>>> And there's some valid points too if someone would argue to put it there
>>> especially on folio lock - do that in shmem.c can avoid taking folio lock
>>> when generating minor fault message.  It might make some difference when
>>> the faults are heavy and when folio lock is frequently taken elsewhere too.
>>
>> Peter, could you expand on this?  Are you referring to the following
>> (shmem_get_folio_gfp)?
>>
>>        if (folio) {
>>                folio_lock(folio);
>>
>>                /* Has the folio been truncated or swapped out? */
>>                if (unlikely(folio->mapping != inode->i_mapping)) {
>>                        folio_unlock(folio);
>>                        folio_put(folio);
>>                        goto repeat;
>>                }
>>                if (sgp == SGP_WRITE)
>>                        folio_mark_accessed(folio);
>>                if (folio_test_uptodate(folio))
>>                        goto out;
>>                /* fallocated folio */
>>                if (sgp != SGP_READ)
>>                        goto clear;
>>                folio_unlock(folio);
>>                folio_put(folio);
>>        }
>>
>> Could you explain in what case the lock can be avoided?  AFAIC, the function
>> is called by both the shmem fault handler and userfault_continue().
> 
> I think you meant the UFFDIO_CONTINUE side of things.  I agree with you, we
> always need the folio lock.
> 
> What I was saying is the trapping side, where the minor fault message can
> be generated without the folio lock now in case of shmem.  It's about
> whether we could generalize the trapping side, so handle_mm_fault() can
> generate the minor fault message instead of by shmem.c.
> 
> If the only concern is "referring to a module symbol from core mm", then
> indeed the trapping side should be less of a concern anyway, because the
> trapping side (when in the module codes) should always be able to reference
> mm functions.
> 
> Actually.. if we have a fault() flag introduced above, maybe we can
> generalize the trap side altogether without the folio lock overhead.  When
> the flag set, if we can always return the folio unlocked (as long as
> refcount held), then in UFFDIO_CONTINUE ioctl we can lock it.

Where does this locking happen exactly during trapping?  I was thinking 
it was only done when the page was allocated.  The trapping part (quoted 
by you above) only looks up the page in the cache and calls 
handle_userfault().  Am I missing something?

>>
>>> It might boil down to how many more FSes would support minor fault, and
>>> whether we would care about such difference at last to shmem users. If gmem
>>> is the only one after existing ones, IIUC there's still option we implement
>>> it in gmem code.  After all, I expect the change should be very under
>>> control (<20 LOCs?)..
>>>
>>> --
>>> Peter Xu
>>>
>>
> 
> --
> Peter Xu
> 


