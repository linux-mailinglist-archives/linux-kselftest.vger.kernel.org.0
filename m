Return-Path: <linux-kselftest+bounces-45137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4BC41062
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EC074E3857
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29558334368;
	Fri,  7 Nov 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sq+nZT9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA8328B79;
	Fri,  7 Nov 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536226; cv=none; b=SXVv2dABoIJF4svqOtf9lYvtzflHbTpzc2IFPTuSqiS7vmlscHwlBMCKZffn2GgkuF03M25XmGPljMhKIN+4GG0v+sPvJyKFYdTWckaCS6KthqBrlQHq1+ulVRjZPPo2PQpUAb/jEKfkr8qiEKSPEMD59r4C5UXevOQdEWxUjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536226; c=relaxed/simple;
	bh=MByVuksCvqaX9S6WCLgVJiIGwm5vlcY5KiFcNTNmJ90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=exL1idiVi2QuxWzEf3SPbU50NJgCQO/ZXg0fYEzP7d0B3saVwoUufmYD5cg3/ddHlC110T1g00EZ3w+TNr/8BWh3r0MGIbRnacVDOwsxjPd6T/8jcumIRR6wZ15QNxYjXCtyw2pfVCcxhLtDEW2NEAH2CgQbCoJ8IS92I0zJrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sq+nZT9U; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762536224; x=1794072224;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=ZYTs4MnUsvcTQkyzxj71ae7pzo5tQeHaCOSc3vIutPA=;
  b=sq+nZT9UHtdR6Qm3RNbCKdq7WOBuDMJE2NRHVaceD+tKezj0vdN3fPTH
   O3ekRjcKKai6MjWGETIkIkDkb+ZIslyDkPizSfGebXoRwt+sqWBc8dKkt
   DYTXjk5K7tKbSoB3U6DJBw3aQ/4p2mK+PWw3Ju5ZQHv+y44t/bzQR+Lb7
   iiUxasrbyR037LqQ2w3dlaow+7h1HPfwsbEm2osloAkO6CHX/APjf1RuH
   QQ69Fadz2g6U+dgm41CHuxwUy4RazyFhdxxh+0jEjdm7Ko25IB0k/tBQ8
   LVasU+W77PeWZfiP1UHlWgDIJ3e9+/ZZi1Y7EMvMPJfZlnwUVtuw9V4uq
   w==;
X-CSE-ConnectionGUID: jLGytu/IS3Swgxc8btdIeQ==
X-CSE-MsgGUID: eAphvwYsSrG1X7PZ3lMXog==
X-IronPort-AV: E=Sophos;i="6.19,287,1754956800"; 
   d="scan'208";a="4852040"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 17:23:26 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:9306]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.36.34:2525] with esmtp (Farcaster)
 id 65a7df21-9a1f-44f7-9ef4-1959268abc09; Fri, 7 Nov 2025 17:23:26 +0000 (UTC)
X-Farcaster-Flow-ID: 65a7df21-9a1f-44f7-9ef4-1959268abc09
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 17:23:22 +0000
Received: from [192.168.9.244] (10.106.83.15) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 7 Nov 2025
 17:23:21 +0000
Message-ID: <13d2268f-a556-4a04-a473-c595d26dfbd8@amazon.com>
Date: Fri, 7 Nov 2025 17:23:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v6 1/2] KVM: guest_memfd: add generic population via write
To: Ackerley Tng <ackerleytng@google.com>
CC: Nikita Kalyazin <kalyazin@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "jthoughton@google.com"
	<jthoughton@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
	Jack Thomson <jackabt@amazon.co.uk>, Derek Manwaring <derekmn@amazon.com>,
	Marco Cali <xmarcalx@amazon.co.uk>, Vishal Annapurve <vannapurve@google.com>,
	Sean Christopherson <seanjc@google.com>
References: <20251020161352.69257-1-kalyazin@amazon.com>
 <20251020161352.69257-2-kalyazin@amazon.com> <aPpS2aqdobVTk_ed@google.com>
 <8a28ddea-35c0-490e-a7d2-7fb612fdd008@amazon.com>
 <aQPakDuteQkg0hTu@google.com>
 <2c61545f-befb-4681-95fd-ff281e1a947b@amazon.com>
 <diqzms4xdf2v.fsf@google.com>
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
In-Reply-To: <diqzms4xdf2v.fsf@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D005EUA001.ant.amazon.com (10.252.50.159) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 07/11/2025 15:42, Ackerley Tng wrote:
> Nikita Kalyazin <kalyazin@amazon.com> writes:
> 
>> On 30/10/2025 21:37, Sean Christopherson wrote:
>>> On Fri, Oct 24, 2025, Nikita Kalyazin wrote:
>>>>
>>>>
>>>> On 23/10/2025 17:07, Sean Christopherson wrote:
>>>>> On Mon, Oct 20, 2025, Nikita Kalyazin wrote:
>>>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>>>
>>>> + Vishal and Ackerley
>>>>
>>>>>>
>>>>>> write syscall populates guest_memfd with user-supplied data in a generic
>>>>>> way, ie no vendor-specific preparation is performed.  If the request is
>>>>>> not page-aligned, the remaining bytes are initialised to 0.
>>>>>>
>>>>>> write is only supported for non-CoCo setups where guest memory is not
>>>>>> hardware-encrypted.
>>>>>
>>>>> Please include all of the "why".  The code mostly communicates the "what", but
>>>>> it doesn't capture why write() support is at all interesting, nor does it explain
>>>>> why read() isn't supported.
>>>>
>>>> Hi Sean,
>>>>
>>>> Thanks for the review.
>>>>
>>>> Do you think including the explanation from the cover letter would be
>>>> sufficient?
>>>
>>> It's pretty close.  A few more details would be helpful, e.g. to explain that VMMs
>>> may use write() to populate the initial image
>>
>> Ack.
>>
>>>
>>>> Shall I additionally say that read() isn't supported because there is no use
>>>> case for it as of now or would it be obvious?
>>>
>>> Hmm, I think if you want to exclude read() support, the changelog should explicitly
>>> state why.  E.g. "there's no use case" is quite different from "deliberately
>>> don't support read() for security reasons".
>>
>> Ack.
>>
>>>
>>>>>> Signed-off-by: Nikitia Kalyazin <kalyazin@amazon.com>
>>>>>> ---
>>>>>>     virt/kvm/guest_memfd.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>>>>>
>>>>> There's a notable lack of uAPI and Documentation chanegs.  I.e. this needs a
>>>>> GUEST_MEMFD_FLAG_xxx along with proper documentation.
>>>>
>>>> Would the following be ok in the doc?
>>>>
>>>> When the capability KVM_CAP_GUEST_MEMFD_WRITE is supported, the 'flags'
>>>
>>> No capability is necessary, see d2042d8f96dd ("KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP
>>> into KVM_CAP_GUEST_MEMFD_FLAGS").
>>
>> Thanks, I didn't realise that kvm/next was behind kvm/master.
>>
>>>
>>>> field
>>>> supports GUEST_MEMFD_FLAG_WRITE. Setting this flag on guest_memfd creation
>>>> enables write() syscall operations to populate guest_memfd memory from host
>>>> userspace.
>>>>
>>>> When a write() operation is performed on a guest_memfd file descriptor with
>>>> the
>>>> GUEST_MEMFD_FLAG_WRITE set, the syscall will populate the guest memory with
>>>> user-supplied data in a generic way, without any vendor-specific
>>>> preparation.
>>>> The write operation is only supported for non-CoCo (Confidential Computing)
>>>> setups where guest memory is not hardware-encrypted.
>>>
>>> The restriction should be that guest memory must be SHARED, i.e. not PRIVATE.
>>> Strictly speaking, guest memory can be encrypted, e.g. with SME and TME (I think
>>> TME is still a thing?), but with a shared key and thus accessible from the host.
>>>
>>> Even if that weren't the case, we want to support this for CoCo VMs.
>>
>> To clarify, should it depend on GUEST_MEMFD_FLAG_INIT_SHARED for now?
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 5bd76cf394fa..5fbf65f49586 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -736,7 +736,7 @@ static inline u64
>> kvm_gmem_get_supported_flags(struct kvm *kvm)
>>           u64 flags = GUEST_MEMFD_FLAG_MMAP;
>>
>>           if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
>> -               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>> +               flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
>> GUEST_MEMFD_FLAG_WRITE;
>>
>>           return flags;
>>    }
>>
> 
> Yup! It should depend on GUEST_MEMFD_FLAG_INIT_SHARED for now.
> 
> When conversion is supported then GUEST_MEMFD_FLAG_WRITE can always be a
> supported flag, and the shared/private check can then be shifted to
> .write_begin().

Thanks for the confirmation.

> 
>>>
>>>> If the write request is not page-aligned, any remaining bytes within the page
>>>> are initialized to zero.
>>>
>>> Why?  (Honest question, e.g. is that standard file semantics?)
>>
>> The clause was originally suggested by James in v5 [1].  The behaviour
>> shouldn't be deviating from the standard semantics though, so I will
>> omit it.  Moreover, when looking at the shmem implementation, I realised
>> that I hadn't handled the case of clearing bytes _before_ written bytes
>> properly.  I will fix it in the next version.
>>
> 
> Was thinking about this a bit more. One way to think about this is that
> we could have more flexibility: Do we need to zero the parts of the page
> that were not written to? Maybe the user wanted to write only to byte offsets
> 10 to 20 within the page, and keep the rest intact? That should still be
> okay I think, there's no data leak since we're not allowing read().
> 
> Looking ahead to conversions on huge pages, I think I prefer being more
> restrictive though. For 4K pages we don't allow allocations or
> truncations that are not PAGE_ALIGNED. For huge pages the current stance
> is to return -EINVAL for allocations/truncations that are not huge page
> size aligned.
> 
> If we allow non-page-aligned writes, handling huge pages could be
> complicated. I don't see any way for guest_memfd to tell the caller
> generic_perform_write() function that it can only write to certain parts
> of a page. This means that if a huge page has mixed shared/private
> status, guest_memfd would have to split the folio just for
> generic_perform_write() to not write elsewhere.
> 
> Do you have any ideas here? Or maybe we will then use some
> other .write_iter() function.
> 
> My proposal is to impose a restriction that write()s offset/len must be
> PAGE_ALIGNED, we can check that in .write_begin(). Being more
> restrictive could be a good starting point that allows us to relax the
> constraint later. (Unless you already have a use case that requires
> writing less than a page)
> 
> That should also solve the zeroing issue, if the user must always
> provide full pages worth of data to write. :P

We do not have a use case for partial writes as we always write full 
pages so I am totally open to applying the restriction, especially if it 
helps huge page conversion.

> 
> 
>> [1]
>> https://lore.kernel.org/kvm/CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com/
>>
>>>
>>>>> And while it's definitely it's a-ok to land .write() in advance of the direct map
>>>>> changes, we do need to at least map out how we want the two to interact, e.g. so
>>>>> that we don't end up with constraints that are impossible to satisfy.
>>>>>
>>>>
>>>> write() shall not attempt to access a page that is not in the direct map,
>>>> which I believe can be achieved via kvm_kmem_gmem_write_begin() consulting
> 
> Btw why not just kvm_gmem_write_begin() instead of having the additional
> kmem part in the name?

You are right, no reason for an extra kmem in the name.  Thanks!

> 
>>>> the KVM_GMEM_FOLIO_NO_DIRECT_MAP in folio->private (introduced in [1]).
>>>>
>>>> Do you think we should mention it in the commit message in some way? What
>>>> particular constraint are you cautious about?
>>>
>>> I want to be cautious with respect to the ABI/uAPI.  Patrick's series also adds
>>> a flag, and guest_memfd doesn't currently provide a way to toggle flags after the
>>> file is created.  That begs the question of how GUEST_MEMFD_FLAG_NO_DIRECT_MAP
>>> will co-exist with GUEST_MEMFD_FLAG_WRITE.  Presumably the goal is to use write()
>>> to initialize memory, and _then_ nuke the direct map.
>>>
>>> I want line of sight to understanding the exact semantics/flows.  E.g. will KVM
>>> require userspace to clear GUEST_MEMFD_FLAG_WRITE before allowing
>>> NO_DIRECT_MAP?  Or will the write() simply fail?  How will the sequencing be
>>> achieved?
>>
>> No, I don't think we can clear the GUEST_MEMFD_FLAG_WRITE as we expect
>> faults and writes to different pages to be arriving interspersed: some
>> pages will be populated by write() proactively, some will be allocated
>> by faults in the user mapping on demand.  Both write() and the fault
>> handler, if they need to allocate a page, will be writing content to it
>> and "sealing" by removing it from the direct map.  If write() faces an
>> already "sealed" page, it will fail (with EEXIST [1]).
>>
> 
> IIUC this means a write() after fallocate(), or any unintended access to
> the memory before write, for a GUEST_MEMFD_FLAG_NO_DIRECT_MAP
> guest_memfd will necessarily fail.
> 
> The required ordering is kind of awkward, but I don't really have any
> good suggestions.

I don't think fallocate() needs to "seal" the page, since it doesn't 
initialise the page content.  So it should be allowed to write to a page 
that has previously been fallocated, unless there is something I'm 
missing that makes it impossible.

> 
>>>
>>>>>> +     struct inode *inode = file_inode(file);
>>>>>> +     pgoff_t index = pos >> PAGE_SHIFT;
>>>>>> +     struct folio *folio;
>>>>>> +
>>>>>> +     if (!kvm_gmem_supports_mmap(inode))
>>>>>
>>>>> Checking for MMAP is neither sufficient nor strictly necessary.  MMAP doesn't
>>>>> imply SHARED, and it's not clear to me that mmap() support should be in any way
>>>>> tied to WRITE support.
>>>>
>>>> As in my reply to the comment about doc, I plan to introduce
>>>> KVM_CAP_GUEST_MEMFD_WRITE and GUEST_MEMFD_FLAG_WRITE.  The
>>>> kvm_arch_supports_gmem_write() will be a weak symbol and relying on
>>>> !kvm_arch_has_private_mem() on x86, similar to
>>>> kvm_arch_supports_gmem_mmap().  Does it look right?
>>>
>>> No.  As above, write() should be allowed iff memory is SHARED.  Relevant commits
>>> that are now in Linus' tree:
>>>
>>>     44c6cb9fe9888b371e31165b2854bd0f4e2787d4 KVM: guest_memfd: Allow mmap() on guest_memfd for x86 VMs with private memory
>>>     9aef71c892a55e004419923ba7129abe3e58d9f1 KVM: Explicitly mark KVM_GUEST_MEMFD as depending on KVM_GENERIC_MMU_NOTIFIER
>>>     5d3341d684be80892d8f6f9812f90f9274b81177 KVM: guest_memfd: Invalidate SHARED GPAs if gmem supports INIT_SHARED
>>
>> Ack.


