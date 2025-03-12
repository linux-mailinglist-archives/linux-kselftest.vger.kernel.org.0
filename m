Return-Path: <linux-kselftest+bounces-28831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6FA5E240
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D416D470
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250924EF69;
	Wed, 12 Mar 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mcmh12e1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325871E8325;
	Wed, 12 Mar 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799261; cv=none; b=V1lhe5Eun40m59FeTiIS8XWCzbuSfz9B/WUU/5IjC9/28yCnMhoNKQdlbCtXAZ0ZF4+IylYmakWlv7woRVvUZNh1aG6hbEnnpyiNg5OJmaoN4k70E7xWRfL6Ih/AiHtAj3S558+Q+MxUwGJI2Me9Fgrb2NAF+YZBtyCu84lPlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799261; c=relaxed/simple;
	bh=KU7bGNRw2hBaSyT62WP4JVFfzQvFDs5cUht4as8wkXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WXwn4LvfkWHhQvEn9GGHRRgFUUhwSV/LmandohwvKABd89vV8oR0bBAXA0tL/B+875jLq8AJVysOxTBbQszDscnWXLTWasEmCpyat8wZ0cdD2Vtk4BJoFVw+4RnC3kxXuC+6BwjXUU0HYn1bDBhf3y6XDUNQefBl6/d4uGs6jD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mcmh12e1; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741799260; x=1773335260;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Ztr9ORXkov81qwN/P6uR4+lCpsF81OEkGCUkEXKxRVc=;
  b=mcmh12e1kxKuUf2nVo/+VAzNDZBBDRObNRDf/nsTJ8kIVi6C5hCkwqPs
   50nKP/Q4g1cm/775xUrpHelqwlB8W3FnUt7JgcRIjptTwpTlyRHTBhDC2
   GigZ8cNvP93bV2F+U5+7T+vTCr7vLqSK6RtlRZQ2hwQwNdczL7c/X1l9l
   E=;
X-IronPort-AV: E=Sophos;i="6.14,242,1736812800"; 
   d="scan'208";a="502264995"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:07:30 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:18743]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.188:2525] with esmtp (Farcaster)
 id fea2e4eb-aa2a-4b2c-8892-6f264c44f4da; Wed, 12 Mar 2025 17:07:28 +0000 (UTC)
X-Farcaster-Flow-ID: fea2e4eb-aa2a-4b2c-8892-6f264c44f4da
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 17:07:28 +0000
Received: from [10.95.97.242] (10.95.97.242) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 12 Mar 2025
 17:07:27 +0000
Message-ID: <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
Date: Wed, 12 Mar 2025 17:07:25 +0000
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
 <Z89EFbT_DKqyJUxr@x1.local> <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
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
In-Reply-To: <Z9GsIDVYWoV8d8-C@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D007EUB003.ant.amazon.com (10.252.51.43) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 12/03/2025 15:45, Peter Xu wrote:
> On Tue, Mar 11, 2025 at 04:56:47PM +0000, Nikita Kalyazin wrote:
>>
>>
>> On 10/03/2025 19:57, Peter Xu wrote:
>>> On Mon, Mar 10, 2025 at 06:12:22PM +0000, Nikita Kalyazin wrote:
>>>>
>>>>
>>>> On 05/03/2025 20:29, Peter Xu wrote:
>>>>> On Wed, Mar 05, 2025 at 11:35:27AM -0800, James Houghton wrote:
>>>>>> I think it might be useful to implement an fs-generic MINOR mode. The
>>>>>> fault handler is already easy enough to do generically (though it
>>>>>> would become more difficult to determine if the "MINOR" fault is
>>>>>> actually a MISSING fault, but at least for my userspace, the
>>>>>> distinction isn't important. :)) So the question becomes: what should
>>>>>> UFFDIO_CONTINUE look like?
>>>>>>
>>>>>> And I think it would be nice if UFFDIO_CONTINUE just called
>>>>>> vm_ops->fault() to get the page we want to map and then mapped it,
>>>>>> instead of having shmem-specific and hugetlb-specific versions (though
>>>>>> maybe we need to keep the hugetlb specialization...). That would avoid
>>>>>> putting kvm/gmem/etc. symbols in mm/userfaultfd code.
>>>>>>
>>>>>> I've actually wanted to do this for a while but haven't had a good
>>>>>> reason to pursue it. I wonder if it can be done in a
>>>>>> backwards-compatible fashion...
>>>>>
>>>>> Yes I also thought about that. :)
>>>>
>>>> Hi Peter, hi James.  Thanks for pointing at the race condition!
>>>>
>>>> I did some experimentation and it indeed looks possible to call
>>>> vm_ops->fault() from userfault_continue() to make it generic and decouple
>>>> from KVM, at least for non-hugetlb cases.  One thing is we'd need to prevent
>>>> a recursive handle_userfault() invocation, which I believe can be solved by
>>>> adding a new VMF flag to ignore the userfault path when the fault handler is
>>>> called from userfault_continue().  I'm open to a more elegant solution
>>>> though.
>>>
>>> It sounds working to me.  Adding fault flag can also be seen as part of
>>> extension of vm_operations_struct ops.  So we could consider reusing
>>> fault() API indeed.
>>
>> Great!
>>
>>>>
>>>> Regarding usage of the MINOR notification, in what case do you recommend
>>>> sending it?  If following the logic implemented in shmem and hugetlb, ie if
>>>> the page is _present_ in the pagecache, I can't see how it is going to work
>>>
>>> It could be confusing when reading that chunk of code, because it looks
>>> like it notifies minor fault when cache hit. But the critical part here is
>>> that we rely on the pgtable missing causing the fault() to trigger first.
>>> So it's more like "cache hit && pgtable missing" for minor fault.
>>
>> Right, but the cache hit still looks like a precondition for the minor fault
>> event?
> 
> Yes.
> 
>>
>>>> with the write syscall, as we'd like to know when the page is _missing_ in
>>>> order to respond with the population via the write.  If going against
>>>> shmem/hugetlb logic, and sending the MINOR event when the page is missing
>>>> from the pagecache, how would it solve the race condition problem?
>>>
>>> Should be easier we stick with mmap() rather than write().  E.g. for shmem
>>> case of current code base:
>>>
>>>           if (folio && vma && userfaultfd_minor(vma)) {
>>>                   if (!xa_is_value(folio))
>>>                           folio_put(folio);
>>>                   *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
>>>                   return 0;
>>>           }
>>>
>>> vma is only availble if vmf!=NULL, aka in fault context.  With that, in
>>> write() to shmem inodes, nothing will generate a message, because minor
>>> fault so far is only about pgtable missing.  It needs to be mmap()ed first,
>>> and has nothing yet to do with write() syscalls.
>>
>> Yes, that's true that write() itself isn't going to generate a message. My
>> idea was to _respond_ to a message generated by the fault handler (vmf !=
>> NULL) with a write().  I didn't mean to generate it from write().
>>
>> What I wanted to achieve was send a message on fault + cache miss and
>> respond to the message with a write() to fill the cache followed by a
>> UFFDIO_CONTINUE to set up pagetables.  I understand that a MINOR trap (MINOR
>> + UFFDIO_CONTINUE) is preferable, but how does it fit into this model?
>> What/how will guarantee a cache hit that would trigger the MINOR message?
>>
>> To clarify, I would like to be able to populate pages _on-demand_, not only
>> proactively (like in the original UFFDIO_CONTINUE cover letter [1]).  Do you
>> think the MINOR trap could still be applicable or would it necessarily
>> require the MISSING trap?
> 
> I think MINOR can also achieve similar things.  MINOR traps the pgtable
> missing event (let's imagine page cache is already populated, or at least
> when MISSING mode not registered, it'll auto-populate on 1st access).  So

However if MISSING is not registered, the kernel will auto-populate with 
a clear page, ie there is no way to inject custom content from 
userspace.  To explain my use case a bit more, the population thread 
will be trying to copy all guest memory proactively, but there will 
inevitably be cases where a page is accessed through pgtables _before_ 
it gets populated.  It is not desirable for such access to result in a 
clear page provided by the kernel.

> as long as the content can only be accessed from the pgtable (either via
> mmap() or GUP on top of it), then afaiu it could work similarly like
> MISSING faults, because anything trying to access it will be trapped.
> 
> Said that, we can also choose to implement MISSING first.  In that case
> write() is definitely not enough, because MISSING is at least so far based
> on top of whether the page cache present, and write() won't be atomic on
> update a page.  We need to implement UFFDIO_COPY for gmemfd MISSING.
> 
> Either way looks ok to me.

Yes, I understand that write() doesn't provide an atomic way of alloc + 
add + install PTE.  Supporting UFFDIO_COPY is much more involved as it 
currently provides implementations specific to anonymous and shared 
memory, and adding guest_memfd to it brings the problem of the 
dependency on KVM back.  I suppose it's possible to abstract those by 
introducing extra callbacks in vm_ops somehow and make the code generic, 
but it would be a significant change.  If this is the only right way to 
address my use case, I will work on it.

>>
>> [1] https://lore.kernel.org/linux-fsdevel/20210301222728.176417-1-axelrasmussen@google.com/T/
>>
>>>>
>>>> Also, where would the check for the folio_test_uptodate() mentioned by James
>>>> fit into here?  Would it only be used for fortifying the MINOR (present)
>>>> against the race?
>>>>
>>>>> When Axel added minor fault, it's not a major concern as it's the only fs
>>>>> that will consume the feature anyway in the do_fault() path - hugetlbfs has
>>>>> its own path to take care of.. even until now.
>>>>>
>>>>> And there's some valid points too if someone would argue to put it there
>>>>> especially on folio lock - do that in shmem.c can avoid taking folio lock
>>>>> when generating minor fault message.  It might make some difference when
>>>>> the faults are heavy and when folio lock is frequently taken elsewhere too.
>>>>
>>>> Peter, could you expand on this?  Are you referring to the following
>>>> (shmem_get_folio_gfp)?
>>>>
>>>>         if (folio) {
>>>>                 folio_lock(folio);
>>>>
>>>>                 /* Has the folio been truncated or swapped out? */
>>>>                 if (unlikely(folio->mapping != inode->i_mapping)) {
>>>>                         folio_unlock(folio);
>>>>                         folio_put(folio);
>>>>                         goto repeat;
>>>>                 }
>>>>                 if (sgp == SGP_WRITE)
>>>>                         folio_mark_accessed(folio);
>>>>                 if (folio_test_uptodate(folio))
>>>>                         goto out;
>>>>                 /* fallocated folio */
>>>>                 if (sgp != SGP_READ)
>>>>                         goto clear;
>>>>                 folio_unlock(folio);
>>>>                 folio_put(folio);
>>>>         }
> 
> [1]
> 
>>>>
>>>> Could you explain in what case the lock can be avoided?  AFAIC, the function
>>>> is called by both the shmem fault handler and userfault_continue().
>>>
>>> I think you meant the UFFDIO_CONTINUE side of things.  I agree with you, we
>>> always need the folio lock.
>>>
>>> What I was saying is the trapping side, where the minor fault message can
>>> be generated without the folio lock now in case of shmem.  It's about
>>> whether we could generalize the trapping side, so handle_mm_fault() can
>>> generate the minor fault message instead of by shmem.c.
>>>
>>> If the only concern is "referring to a module symbol from core mm", then
>>> indeed the trapping side should be less of a concern anyway, because the
>>> trapping side (when in the module codes) should always be able to reference
>>> mm functions.
>>>
>>> Actually.. if we have a fault() flag introduced above, maybe we can
>>> generalize the trap side altogether without the folio lock overhead.  When
>>> the flag set, if we can always return the folio unlocked (as long as
>>> refcount held), then in UFFDIO_CONTINUE ioctl we can lock it.
>>
>> Where does this locking happen exactly during trapping?  I was thinking it
>> was only done when the page was allocated.  The trapping part (quoted by you
>> above) only looks up the page in the cache and calls handle_userfault().  Am
>> I missing something?
> 
> That's only what I worry if we want to reuse fault() to generalize the trap
> code in core mm, because fault() by default takes the folio lock at least
> for shmem.  I agree the folio doesn't need locking when trapping the fault
> and sending the message.

Ok, I think I understand what you mean now.  Thanks for explaining that.

> 
> Thanks,
> 
>>
>>>>
>>>>> It might boil down to how many more FSes would support minor fault, and
>>>>> whether we would care about such difference at last to shmem users. If gmem
>>>>> is the only one after existing ones, IIUC there's still option we implement
>>>>> it in gmem code.  After all, I expect the change should be very under
>>>>> control (<20 LOCs?)..
>>>>>
>>>>> --
>>>>> Peter Xu
>>>>>
>>>>
>>>
>>> --
>>> Peter Xu
>>>
>>
> 
> --
> Peter Xu
> 


