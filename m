Return-Path: <linux-kselftest+bounces-19828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E909A048E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CF8B217E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEA0202634;
	Wed, 16 Oct 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcDsvhFV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985D20125E
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068352; cv=none; b=M2TJQ2gV+3baPs7FKLs+dgmPa317PeQgYEGcW+Vg3Vg3TNrZFvkA9PCLauL4avUBld8jT8jE63wf93MiG6V/MTDow32ESTzlwkTDjd2aOxHY1ZeEBHYGlZUYfA1cv4bFNUOExwViB+c3TU3QAetNO4FWZ7hUe/fmSVCVrGSOwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068352; c=relaxed/simple;
	bh=y70J3nCPW4Zf4b2k0ldjKoKdq+ZYMA3aKP5ypGfzu2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foGVJJLB+jQ3PhF/Zsy9yrnZOGb77PDd32ve2XjEwntgWuBa9i4ZBN2/+Oaqr0mQV7zYUecSUYmBHY+l4ZsedgOXfedDFbJOIBKzlMm5mCLjP+Rx+kyWWWQf8da4HGM71Hh1nQZr5vRirJfPuXhVukS1z/Y4wNkWQTIx3Ga3GbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcDsvhFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729068349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ev+BP0zQ5YqZiq4xUeL5dtzna0XCvobzokkhpa+E2A=;
	b=FcDsvhFVIFo7ZRg3IL9yHcFE2Ze+xlG6doT7v3GfNjk/aqE13uBO8Cr+Qi+59EsI/qzMTb
	hP96Pc8UhG6EvF3J5SzMni1RE7il0/ZLpaCXfO6D/z1rQcUc7vzljLtIcpy7EG6HHqFRhW
	Tqiot0mHIVi1PsmpfuJZzhzP0fKr5xY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-h0xLaApjNy-UqISBd8vyNA-1; Wed, 16 Oct 2024 04:45:47 -0400
X-MC-Unique: h0xLaApjNy-UqISBd8vyNA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5016d21eso2371407f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068347; x=1729673147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ev+BP0zQ5YqZiq4xUeL5dtzna0XCvobzokkhpa+E2A=;
        b=qE7jSvifSXyADcnheX2aBL6SO2A0wZhEHYuptKkmWYgmgpROl6mdj4lNhpN/z83Vwv
         +uSzfCkLyPPPq9MZ4hh3NU0G7PgzffUz12ZE/ZXTpwywbiKfWormw+3+IwgEHwMI0ldd
         MnRrDJ87lDcmeOR68LRD6EIH5QJ20v5gdfAIersZQxCo92/IPswdYS8uz2NlAhMvf9Df
         AdcgbcCN6THGN5TMx0CPe2S7QezcNOlN1HUFrE3vQHsIRS37Ms1OX4UmsxmWU0btvPc7
         /QeWf/JJPtsCUWGhSFI29grwMqAccJ7sJPvYeq66ynP89gjOxxgaiwk57R3QxxX30vwc
         xIEw==
X-Forwarded-Encrypted: i=1; AJvYcCULHqmwxaK7YJg/8hTz/3lCYSN/0iSS/s7saQP0Aw2e5zchKf1KXb8Ay4uvqHgrZ8M44MSomsZv1u1iNIVSaRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FiHt5D/KzsPLt6MKLnvK7NaUfxuVQ9QrOklQ/hr7+2hAEWaK
	EBYchOHoUzGJAzQDvCMHiQF7ZxGFXsOkL23ZPq7NukqAZ/B0fxZ3FvDxH1Ds2qpfbUGjkUHUT21
	XKTeFLQQq9xa4ISz3hZ06gKKIjIwu8HIy9XSfouzOHZXPN8E3jwO/rxYsnm6TpFZV3A==
X-Received: by 2002:a05:6000:50f:b0:37d:43ad:14eb with SMTP id ffacd0b85a97d-37d86bb9d5cmr1970576f8f.14.1729068346415;
        Wed, 16 Oct 2024 01:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpXiCxx4856l38kz2ACsDaUJEeW+PY/Wyi3L7UvcU+cb61TSSSAWB863WLvSHmx95G4+Grfg==
X-Received: by 2002:a05:6000:50f:b0:37d:43ad:14eb with SMTP id ffacd0b85a97d-37d86bb9d5cmr1970519f8f.14.1729068345810;
        Wed, 16 Oct 2024 01:45:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:a200:af8e:d144:6284:4f93? (p200300cbc742a200af8ed14462844f93.dip0.t-ipconnect.de. [2003:cb:c742:a200:af8e:d144:6284:4f93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa9090asm3713585f8f.57.2024.10.16.01.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:45:45 -0700 (PDT)
Message-ID: <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
Date: Wed, 16 Oct 2024 10:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Ackerley Tng <ackerleytng@google.com>, Peter Xu <peterx@redhat.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
 jgg@nvidia.com, rientjes@google.com, fvdl@google.com, jthoughton@google.com,
 seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
 fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
 muchun.song@linux.dev, erdemaktas@google.com, vannapurve@google.com,
 qperret@google.com, jhubbard@nvidia.com, willy@infradead.org,
 shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com,
 kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org,
 richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com,
 ajones@ventanamicro.com, vkuznets@redhat.com,
 maciej.wieczor-retman@intel.com, pgonda@google.com, oliver.upton@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n> <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n> <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.24 01:42, Ackerley Tng wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Fri, Oct 11, 2024 at 11:32:11PM +0000, Ackerley Tng wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
>>>>> The faultability xarray is stored on the inode since faultability is a
>>>>> property of the guest_memfd's memory contents.
>>>>>
>>>>> In this RFC, presence of an entry in the xarray indicates faultable,
>>>>> but this could be flipped so that presence indicates unfaultable. For
>>>>> flexibility, a special value "FAULT" is used instead of a simple
>>>>> boolean.
>>>>>
>>>>> However, at some stages of a VM's lifecycle there could be more
>>>>> private pages, and at other stages there could be more shared pages.
>>>>>
>>>>> This is likely to be replaced by a better data structure in a future
>>>>> revision to better support ranges.
>>>>>
>>>>> Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
>>>>> pointer. inode->i_mapping->i_private_data.
>>>>
>>>> Could you help explain the difference between faultability v.s. the
>>>> existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
>>>> confused, otherwise might be good to enrich the commit message.
>>>
>>> Thank you for this question, I'll add this to the commit message to the
>>> next revision if Fuad's patch set [1] doesn't make it first.
>>>
>>> Reason (a): To elaborate on the explanation in [1],
>>> KVM_MEMORY_ATTRIBUTE_PRIVATE is whether userspace wants this page to be
>>> private or shared, and faultability is whether the page is allowed to be
>>> faulted in by userspace.
>>>
>>> These two are similar but may not be the same thing. In pKVM, pKVM
>>> cannot trust userspace's configuration of private/shared, and other
>>> information will go into determining the private/shared setting in
>>> faultability.
>>
>> It makes sense to me that the kernel has the right to decide which page is
>> shared / private.  No matter if it's for pKVM or CoCo, I believe the normal
>> case is most / all pages are private, until some requests to share them for
>> special purposes (like DMA).  But that'll need to be initiated as a request
>> from the guest not the userspace hypervisor.
> 
> For TDX, the plan is that the guest will request the page to be remapped
> as shared or private, and the handler for that request will exit to
> the userspace VMM.
> 
> The userspace VMM will then do any necessary coordination (e.g. for a
> shared to private conversion it may need to unpin pages from DMA), and
> then use the KVM_SET_MEMORY_ATTRIBUTES ioctl to indicate agreement with
> the guest's requested conversion. This is where
> KVM_MEMORY_ATTRIBUTE_PRIVATE will be provided.
> 
> Patch 38 [1] updates
> tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c to
> demonstrate the usage flow for x86.
> 
> Fuad will be in a better position to explain the flow for pKVM.
> 
>> I must confess I totally have no idea how KVM_MEMORY_ATTRIBUTE_PRIVATE is
>> planned to be used in the future. Currently it's always set at least in
>> QEMU if gmemfd is enabled, so it doesn't yet tell me anything..
>>
>> If it's driven by the userspace side of the hypervisor, I wonder when
>> should the user app request some different value it already was, if the
>> kernel already has an answer in this case.  It made me even more confused,
>> as we have this in the API doc:
>>
>>          Note, there is no "get" API.  Userspace is responsible for
>>          explicitly tracking the state of a gfn/page as needed.
>>
>> And I do wonder whether we will still need some API just to query whether
>> the kernel allows the page to be mapped or not (aka, the "real" shared /
>> private status of a guest page).  I guess that's not directly relevant to
>> the faultability to be introduced here, but if you or anyone know please
>> kindly share, I'd love to learn about it.
> 
> The userspace VMM will track the initial shared/private state, in the
> sense that when the VM is created, the mem_attr_array is initialized
> such that the guest pages are all shared.
> 
> Then when the userspace VMM calls the KVM_SET_MEMORY_ATTRIBUTES ioctl,
> it should record all changes so it knows what the state is in the
> kernel.
> 
> Even if userspace VMM doesn't record the state properly, if the
> KVM_SET_MEMORY_ATTRIBUTES ioctl is used to request no change
> (e.g. setting an already private page to private), it will just be a
> no-op in the kernel.
> 
>>>
>>> Perhaps Fuad can elaborate more here.
>>>
>>> Reason (b): In this patch series (mostly focus on x86 first), we're
>>> using faultability to prevent any future faults before checking that
>>> there are no mappings.
>>>
>>> Having a different xarray from mem_attr_array allows us to disable
>>> faulting before committing to changing mem_attr_array. Please see
>>> `kvm_gmem_should_set_attributes_private()` in this patch [2].
>>>
>>> We're not completely sure about the effectiveness of using faultability
>>> to block off future faults here, in future revisions we may be using a
>>> different approach. The folio_lock() is probably important if we need to
>>> check mapcount. Please let me know if you have any ideas!
>>>
>>> The starting point of having a different xarray was pKVM's requirement
>>> of having separate xarrays, and we later realized that the xarray could
>>> be used for reason (b). For x86 we could perhaps eventually remove the
>>> second xarray? Not sure as of now.
>>
>> Just had a quick look at patch 27:
>>
>> https://lore.kernel.org/all/5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com/
>>
>> I'm not yet sure what's protecting from faultability being modified against
>> a concurrent fault().
>>
>> I wonder whether one can use the folio lock to serialize that, so that one
>> needs to take the folio lock to modify/lookup the folio's faultability,
>> then it may naturally match with the fault() handler design, where
>> kvm_gmem_get_folio() needs to lock the page first.
>>
>> But then kvm_gmem_is_faultable() will need to also be called only after the
>> folio is locked to avoid races.
> 
> My bad. In our rush to get this series out before LPC, the patch series
> was not organized very well. Patch 39 [2] adds the
> lock. filemap_invalidate_lock_shared() should make sure that faulting
> doesn't race with faultability updates.
> 
>>>> The latter is per-slot, so one level higher, however I don't think it's a
>>>> common use case for mapping the same gmemfd in multiple slots anyway for
>>>> KVM (besides corner cases like live upgrade).  So perhaps this is not about
>>>> layering but something else?  For example, any use case where PRIVATE and
>>>> FAULTABLE can be reported with different values.
>>>>
>>>> Another higher level question is, is there any plan to support non-CoCo
>>>> context for 1G?
>>>
>>> I believe guest_memfd users are generally in favor of eventually using
>>> guest_memfd for non-CoCo use cases, which means we do want 1G (shared,
>>> in the case of CoCo) page support.
>>>
>>> However, core-mm's fault path does not support mapping at anything
>>> higher than the PMD level (other than hugetlb_fault(), which the
>>> community wants to move away from), so core-mm wouldn't be able to map
>>> 1G pages taken from HugeTLB.
>>
>> Have you looked at vm_operations_struct.huge_fault()?  Or maybe you're
>> referring to some other challenges?
>>
> 
> IIUC vm_operations_struct.huge_fault() is used when creating a PMD, but
> PUD mappings will be needed for 1G pages, so 1G pages can't be mapped by
> core-mm using vm_operations_struct.huge_fault().


Just to clarify a bit for Peter: as has been discussed previously, there 
are rather big difference between CoCo and non-CoCo VMs.

In CoCo VMs, the primary portion of all pages are private, and they are 
not mapped into user space. Only a handful of pages are commonly shared 
and mapped into user space.

In non-CoCo VMs, all pages are shared and (for the time being) all pages 
are mapped into user space from where KVM will consume them.


Installing pmd/pud mappings into user space (recall: shared memory only) 
is currently not really a requirement for CoCo VMs, and therefore not 
the focus of this work.

Further, it's currently considered to be incompatible with getting 
in-place private<->share conversion on *page* granularity right, as we 
will be exposing huge/gigantic folios via individual small folios to 
core-MM. Mapping a PMD/PUD into core-mm, that is composed of multiple 
folios is not going to fly, unless using a PFNMAP, which has been 
briefly discussed as well, bu disregarded so far (no page pinning support).

So in the context of this work here, huge faults and PUD/PMD *user space 
page tables* do not apply.

For non-CoCo VMs there is no in-place conversion problem. One could use 
the same CoCo implementation, but without user space pud/pmd mappings. 
KVM and VFIO would have to consume this memory via the guest_memfd in 
memslots instead of via the user space mappings to more easily get 
PMD/PUD mappings into the secondary MMU. And the downsides would be 
sacrificing the vmemmap optimization and PMD/PUD user space mappings, 
while at the same time benefiting from being able to easily map only 
parts of a huge/gigantic page into user space.


So I consider pmd/pud user space mappings for non-CoCo an independent 
work item, not something that is part of the current effort of 
huge/gigantic pages with in-place conversion at page granularity for 
CoCo VMs.


More information is available in the bi-weekly upstream MM meeting (that 
was recorded) and the LPC talks, where most of that has been discussed.

-- 
Cheers,

David / dhildenb


