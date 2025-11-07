Return-Path: <linux-kselftest+bounces-45111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CAC40A35
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7254E538E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FDF32D0D9;
	Fri,  7 Nov 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i59Mu426"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE802D373F
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530157; cv=none; b=sO1ao86tLTFNN/H+KH5Nw8ZbGoEVyaF+I/aNBTvj1hEbDUat+PHTCTJhC9pSHt05djsau25CaCcKve+QIkkcgrlP++c5V3q/n4Pf4EK3lLjaRExEteu0uxhqGWy5WHSX6ho0IfCIzx5VqKkaS0hI6F3JRAs/jWD/rZGVtF4e+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530157; c=relaxed/simple;
	bh=SjIbsBo1Xr0uiNwHI9BoIIlOGUI+CBWkxiEfAPLMX+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V5Ze3j8ECpWimr9gGNLQma6N9QnuD4RDebQhSYH8LFSrcInTvNes6/EOuRYPojniYXpvyMiOERY/1y6nLJyozT8+4AeKZ0J8YgHjRLodM7e3eBR670y4MTnSZaPAyhblib+Uy6SOIPSNoWeuadoWKAl0LLOprJKeDqY+mV7SKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i59Mu426; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b646768eso1019138a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 07:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762530154; x=1763134954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+vE+6EBY8j48J4+TR78EJ2NW0EkYHyMNtJyZtDGEc=;
        b=i59Mu426qLGkrnrCwSMQ7fzpRhK+4kuXJ1O4BZPx4M6czylkLYpYafhy0F3JTJOfAn
         pyavlo1A0MTMwI6DHSneCbsF8Z3DRfNTNtjIRCFvzFycH74xIKKjOz8h4l/Xnf8ZpIik
         lYPnB3mTGUH8ULrRK9NHV2dzxsyZuvcAib/z2fUTml131T06avYxdKJ3AEeP7sKnSikJ
         6rrHjEltfbMif31uN6vJ5MZk/LsMU+yWwJYBJKHM2PAuI20LlYlwD9/C0+NnIhVvkuoV
         dm5ASomF9mXKs+WDSGxWuKPQlShcpviPbU71836nKYpSAqKzeOqKY1WvPRjuKgsriCBX
         H35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530154; x=1763134954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+vE+6EBY8j48J4+TR78EJ2NW0EkYHyMNtJyZtDGEc=;
        b=gtq4OOeLypwmVRyii8+8k9iLwSbBH89Mj9xQLiNQ9/uy+Y4ovgehErGhhtsDNFdXZJ
         IQgwgO3tpkC5MrjgmlQWokFiz6YIE1V2W4wvrvz6xJ0Tss+XQA6A2d/a65Zcr2bwwiF7
         +6DJOkUwCsn8MmLz4iLcg89QSWDkuMtns1PoBumKzY/jrh4swvPDRoFAMqndtATAes9p
         e2ITSRzEE31DZCH64HShJuEZ9tJzq/MrQ9a6CxrNJw9vyh7ixX7LaHA5+Q8b5mWHkIOi
         jke0TGcCJNue+Dd8P+awFa3sXFIVEYUEpw/Mfrhlx+MUB38pB1FJil/YBJnVO49n4+2B
         8w1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQmQnFRQCDcB4sup24/rqBQFycgVUxY1JgkVrwgRPc1ewM4wdHZlOBtCK3s/SdNigRCCRUtCMkhCJ++TrQaHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHjE8Ev5VE/RgX2+O91MZs+nOlYnCwAk84tA/t9WxItxvyiOj
	i7E3a1pZjBzxF/ark7uf6vXxpokyvRqbrpsADAvdBpo1UDG+KMIIejMxyh1uhq0n+MDs3CkxN+j
	tOik0E0jFcWCLY8DcAhf6yqDLOg==
X-Google-Smtp-Source: AGHT+IEQ8+72xRcX4Lh83dJZDXTpAeoswe0M+6wUHGCveWfgq3KElXvQVuPxIFypKx+1WBdgQWa+lMSW9vth2zYOgA==
X-Received: from pjbci23.prod.google.com ([2002:a17:90a:fc97:b0:343:5259:2292])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1801:b0:340:ff7d:c2e with SMTP id 98e67ed59e1d1-3434c576a1dmr3891939a91.29.1762530154132;
 Fri, 07 Nov 2025 07:42:34 -0800 (PST)
Date: Fri, 07 Nov 2025 07:42:32 -0800
In-Reply-To: <2c61545f-befb-4681-95fd-ff281e1a947b@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020161352.69257-1-kalyazin@amazon.com> <20251020161352.69257-2-kalyazin@amazon.com>
 <aPpS2aqdobVTk_ed@google.com> <8a28ddea-35c0-490e-a7d2-7fb612fdd008@amazon.com>
 <aQPakDuteQkg0hTu@google.com> <2c61545f-befb-4681-95fd-ff281e1a947b@amazon.com>
Message-ID: <diqzms4xdf2v.fsf@google.com>
Subject: Re: [PATCH v6 1/2] KVM: guest_memfd: add generic population via write
From: Ackerley Tng <ackerleytng@google.com>
To: kalyazin@amazon.com, Sean Christopherson <seanjc@google.com>
Cc: Nikita Kalyazin <kalyazin@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "david@redhat.com" <david@redhat.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>, 
	Jack Thomson <jackabt@amazon.co.uk>, Derek Manwaring <derekmn@amazon.com>, 
	Marco Cali <xmarcalx@amazon.co.uk>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Nikita Kalyazin <kalyazin@amazon.com> writes:

> On 30/10/2025 21:37, Sean Christopherson wrote:
>> On Fri, Oct 24, 2025, Nikita Kalyazin wrote:
>>>
>>>
>>> On 23/10/2025 17:07, Sean Christopherson wrote:
>>>> On Mon, Oct 20, 2025, Nikita Kalyazin wrote:
>>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>>
>>> + Vishal and Ackerley
>>>
>>>>>
>>>>> write syscall populates guest_memfd with user-supplied data in a generic
>>>>> way, ie no vendor-specific preparation is performed.  If the request is
>>>>> not page-aligned, the remaining bytes are initialised to 0.
>>>>>
>>>>> write is only supported for non-CoCo setups where guest memory is not
>>>>> hardware-encrypted.
>>>>
>>>> Please include all of the "why".  The code mostly communicates the "what", but
>>>> it doesn't capture why write() support is at all interesting, nor does it explain
>>>> why read() isn't supported.
>>>
>>> Hi Sean,
>>>
>>> Thanks for the review.
>>>
>>> Do you think including the explanation from the cover letter would be
>>> sufficient?
>> 
>> It's pretty close.  A few more details would be helpful, e.g. to explain that VMMs
>> may use write() to populate the initial image
>
> Ack.
>
>> 
>>> Shall I additionally say that read() isn't supported because there is no use
>>> case for it as of now or would it be obvious?
>> 
>> Hmm, I think if you want to exclude read() support, the changelog should explicitly
>> state why.  E.g. "there's no use case" is quite different from "deliberately
>> don't support read() for security reasons".
>
> Ack.
>
>> 
>>>>> Signed-off-by: Nikitia Kalyazin <kalyazin@amazon.com>
>>>>> ---
>>>>>    virt/kvm/guest_memfd.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>>>>
>>>> There's a notable lack of uAPI and Documentation chanegs.  I.e. this needs a
>>>> GUEST_MEMFD_FLAG_xxx along with proper documentation.
>>>
>>> Would the following be ok in the doc?
>>>
>>> When the capability KVM_CAP_GUEST_MEMFD_WRITE is supported, the 'flags'
>> 
>> No capability is necessary, see d2042d8f96dd ("KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP
>> into KVM_CAP_GUEST_MEMFD_FLAGS").
>
> Thanks, I didn't realise that kvm/next was behind kvm/master.
>
>> 
>>> field
>>> supports GUEST_MEMFD_FLAG_WRITE. Setting this flag on guest_memfd creation
>>> enables write() syscall operations to populate guest_memfd memory from host
>>> userspace.
>>>
>>> When a write() operation is performed on a guest_memfd file descriptor with
>>> the
>>> GUEST_MEMFD_FLAG_WRITE set, the syscall will populate the guest memory with
>>> user-supplied data in a generic way, without any vendor-specific
>>> preparation.
>>> The write operation is only supported for non-CoCo (Confidential Computing)
>>> setups where guest memory is not hardware-encrypted.
>> 
>> The restriction should be that guest memory must be SHARED, i.e. not PRIVATE.
>> Strictly speaking, guest memory can be encrypted, e.g. with SME and TME (I think
>> TME is still a thing?), but with a shared key and thus accessible from the host.
>> 
>> Even if that weren't the case, we want to support this for CoCo VMs.
>
> To clarify, should it depend on GUEST_MEMFD_FLAG_INIT_SHARED for now?
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5bd76cf394fa..5fbf65f49586 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -736,7 +736,7 @@ static inline u64 
> kvm_gmem_get_supported_flags(struct kvm *kvm)
>          u64 flags = GUEST_MEMFD_FLAG_MMAP;
>
>          if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
> -               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> +               flags |= GUEST_MEMFD_FLAG_INIT_SHARED | 
> GUEST_MEMFD_FLAG_WRITE;
>
>          return flags;
>   }
>

Yup! It should depend on GUEST_MEMFD_FLAG_INIT_SHARED for now.

When conversion is supported then GUEST_MEMFD_FLAG_WRITE can always be a
supported flag, and the shared/private check can then be shifted to
.write_begin().

>> 
>>> If the write request is not page-aligned, any remaining bytes within the page
>>> are initialized to zero.
>> 
>> Why?  (Honest question, e.g. is that standard file semantics?)
>
> The clause was originally suggested by James in v5 [1].  The behaviour 
> shouldn't be deviating from the standard semantics though, so I will 
> omit it.  Moreover, when looking at the shmem implementation, I realised 
> that I hadn't handled the case of clearing bytes _before_ written bytes 
> properly.  I will fix it in the next version.
>

Was thinking about this a bit more. One way to think about this is that
we could have more flexibility: Do we need to zero the parts of the page
that were not written to? Maybe the user wanted to write only to byte offsets
10 to 20 within the page, and keep the rest intact? That should still be
okay I think, there's no data leak since we're not allowing read().

Looking ahead to conversions on huge pages, I think I prefer being more
restrictive though. For 4K pages we don't allow allocations or
truncations that are not PAGE_ALIGNED. For huge pages the current stance
is to return -EINVAL for allocations/truncations that are not huge page
size aligned.

If we allow non-page-aligned writes, handling huge pages could be
complicated. I don't see any way for guest_memfd to tell the caller
generic_perform_write() function that it can only write to certain parts
of a page. This means that if a huge page has mixed shared/private
status, guest_memfd would have to split the folio just for
generic_perform_write() to not write elsewhere.

Do you have any ideas here? Or maybe we will then use some
other .write_iter() function. 

My proposal is to impose a restriction that write()s offset/len must be
PAGE_ALIGNED, we can check that in .write_begin(). Being more
restrictive could be a good starting point that allows us to relax the
constraint later. (Unless you already have a use case that requires
writing less than a page)

That should also solve the zeroing issue, if the user must always
provide full pages worth of data to write. :P


> [1] 
> https://lore.kernel.org/kvm/CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com/
>
>> 
>>>> And while it's definitely it's a-ok to land .write() in advance of the direct map
>>>> changes, we do need to at least map out how we want the two to interact, e.g. so
>>>> that we don't end up with constraints that are impossible to satisfy.
>>>>
>>>
>>> write() shall not attempt to access a page that is not in the direct map,
>>> which I believe can be achieved via kvm_kmem_gmem_write_begin() consulting

Btw why not just kvm_gmem_write_begin() instead of having the additional
kmem part in the name?

>>> the KVM_GMEM_FOLIO_NO_DIRECT_MAP in folio->private (introduced in [1]).
>>>
>>> Do you think we should mention it in the commit message in some way? What
>>> particular constraint are you cautious about?
>> 
>> I want to be cautious with respect to the ABI/uAPI.  Patrick's series also adds
>> a flag, and guest_memfd doesn't currently provide a way to toggle flags after the
>> file is created.  That begs the question of how GUEST_MEMFD_FLAG_NO_DIRECT_MAP
>> will co-exist with GUEST_MEMFD_FLAG_WRITE.  Presumably the goal is to use write()
>> to initialize memory, and _then_ nuke the direct map.
>> 
>> I want line of sight to understanding the exact semantics/flows.  E.g. will KVM
>> require userspace to clear GUEST_MEMFD_FLAG_WRITE before allowing
>> NO_DIRECT_MAP?  Or will the write() simply fail?  How will the sequencing be
>> achieved?
>
> No, I don't think we can clear the GUEST_MEMFD_FLAG_WRITE as we expect 
> faults and writes to different pages to be arriving interspersed: some 
> pages will be populated by write() proactively, some will be allocated 
> by faults in the user mapping on demand.  Both write() and the fault 
> handler, if they need to allocate a page, will be writing content to it 
> and "sealing" by removing it from the direct map.  If write() faces an 
> already "sealed" page, it will fail (with EEXIST [1]).
>

IIUC this means a write() after fallocate(), or any unintended access to
the memory before write, for a GUEST_MEMFD_FLAG_NO_DIRECT_MAP
guest_memfd will necessarily fail.

The required ordering is kind of awkward, but I don't really have any
good suggestions.

>> 
>>>>> +     struct inode *inode = file_inode(file);
>>>>> +     pgoff_t index = pos >> PAGE_SHIFT;
>>>>> +     struct folio *folio;
>>>>> +
>>>>> +     if (!kvm_gmem_supports_mmap(inode))
>>>>
>>>> Checking for MMAP is neither sufficient nor strictly necessary.  MMAP doesn't
>>>> imply SHARED, and it's not clear to me that mmap() support should be in any way
>>>> tied to WRITE support.
>>>
>>> As in my reply to the comment about doc, I plan to introduce
>>> KVM_CAP_GUEST_MEMFD_WRITE and GUEST_MEMFD_FLAG_WRITE.  The
>>> kvm_arch_supports_gmem_write() will be a weak symbol and relying on
>>> !kvm_arch_has_private_mem() on x86, similar to
>>> kvm_arch_supports_gmem_mmap().  Does it look right?
>> 
>> No.  As above, write() should be allowed iff memory is SHARED.  Relevant commits
>> that are now in Linus' tree:
>> 
>>    44c6cb9fe9888b371e31165b2854bd0f4e2787d4 KVM: guest_memfd: Allow mmap() on guest_memfd for x86 VMs with private memory
>>    9aef71c892a55e004419923ba7129abe3e58d9f1 KVM: Explicitly mark KVM_GUEST_MEMFD as depending on KVM_GENERIC_MMU_NOTIFIER
>>    5d3341d684be80892d8f6f9812f90f9274b81177 KVM: guest_memfd: Invalidate SHARED GPAs if gmem supports INIT_SHARED
>
> Ack.

