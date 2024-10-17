Return-Path: <linux-kselftest+bounces-19966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B549A25F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469BAB26078
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DDC1DE3D3;
	Thu, 17 Oct 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIs6wG9l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DC1DED68
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177352; cv=none; b=OczAtNyuykaLZ+fVewJ0tnGfbhmFwwQMX2w2MkyJvw9ut9UriFHXJCeqL0rZOI1xWXMkFKkeeo9lN6kMdjf6yoKJPmTEfbRBw8migbuv8WwIpsx0VRXkaZUMk8Q6GPIjclDNWlIAmUgk9xwpUrpNZcdknLtpQuyP5e/vj5pZdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177352; c=relaxed/simple;
	bh=w/ntyFAqggK95/tK8wJJbAo1wMmMKFiLQraFA+Jnxs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8timRE8kxrpe5nySOcn7mde13pfU9Ql/GEe7vJcUpTF6iMwZzQgc+Y+GMekZxF635nVPp1/Xd7E7rD/1djoroGP+uC7SlXeB9i+NTfRhVpUzp6YffPULm6Q4ePl6hmLqE3xh+DaAEmSBFKmIJTXiAFrIJ7tKsWCHDWaiGr/KyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIs6wG9l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729177349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MTjPh/M65BMtmIFSvA8d3L/tEAJtMt+yGdFBQYvxlzM=;
	b=QIs6wG9l29fFQs202soEGGGClC+ZuqbBP1hOhR/yDb9g4ZFqjbYlrfyJPdD8w9QJxm2R16
	PpMBtHx3OSM2ix8AwclFawifWE+i7YQeXEpzKkgYuGy2p+xxbTcG+MVD2YbdM2JcPPwSJh
	0HFPfWZuie6JX/+aBT/r71G1IPURZNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-WkUJejfwPqm49ravTDG5sA-1; Thu, 17 Oct 2024 11:02:28 -0400
X-MC-Unique: WkUJejfwPqm49ravTDG5sA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4311a383111so6582265e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 08:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177347; x=1729782147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTjPh/M65BMtmIFSvA8d3L/tEAJtMt+yGdFBQYvxlzM=;
        b=Q96oNKoGKK3izsL85WMvgptYBNlga8ycxrdToTxKztjHjEpzNpQUVH00mWvGbpMHc6
         CVsmWlsfdIqlpBrkv7xQq43xUc5yp/WrZtwFgI3qpn3nZsYDhZz6UOqSAiqPFGOaROOF
         qOU3/KWuORKPTLgLA2eNFR2WwI1fj0PjlDu8rs7FY2KUTPkvQFEXHj2lpBMAJ0bXCOql
         N0mGFugkkO9idNEEbTpGQsu0iJoCTr7qYMwPa+Wgrk8bfkWP6aKBFtudjGOCW4pXD9eb
         fsvFg5Piri1b6BeLGlJwvz7INIScjCfVaJZid7QVLlNjKGyOsvcTtu1KTeAfQycZaHlH
         JDzg==
X-Forwarded-Encrypted: i=1; AJvYcCWoBVMfdrXLgW46YvcnNA2xcXn/gHgpTXJpvuGbLC3U7skPt5zuK8mEAVVrQis6SStdB8x+pOA1r5RJiRQruuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2DkBb6NC5ckbtgH+6Y46x4PEB147b2XhP76nJl2kgICPBA+l
	MfMBJROrcM1DPFUMXltO0DJBn+HX7W01dzvX98xyqcbQjK3cVMNkh63JUp3Ye6C4O9AIPJHqaqB
	GSMoZtZQTht/JL1XPdkiRAlQs4oECS+d1eoM9/C+1dA8k7ZKV+/5jdGFiK1QmvxfL2g==
X-Received: by 2002:a05:600c:5251:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-431255dc80cmr155955635e9.8.1729177346715;
        Thu, 17 Oct 2024 08:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGFQtQQ1MHMmFwzunIp+a4xLBLgvKb4xo4upewAL+kcpCdWhaQROR4JKl6laOAfSB0CBZ4Bg==
X-Received: by 2002:a05:600c:5251:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-431255dc80cmr155954485e9.8.1729177345769;
        Thu, 17 Oct 2024 08:02:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4061bsm28726975e9.25.2024.10.17.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:02:25 -0700 (PDT)
Message-ID: <a809ed94-e3b8-4f1e-964b-44a049de8a81@redhat.com>
Date: Thu, 17 Oct 2024 17:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Peter Xu <peterx@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
 quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com,
 rientjes@google.com, fvdl@google.com, jthoughton@google.com,
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
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com> <ZxAfET87vwVwuUfJ@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZxAfET87vwVwuUfJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.24 22:16, Peter Xu wrote:
> On Wed, Oct 16, 2024 at 10:45:43AM +0200, David Hildenbrand wrote:
>> On 16.10.24 01:42, Ackerley Tng wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Fri, Oct 11, 2024 at 11:32:11PM +0000, Ackerley Tng wrote:
>>>>> Peter Xu <peterx@redhat.com> writes:
>>>>>
>>>>>> On Tue, Sep 10, 2024 at 11:43:57PM +0000, Ackerley Tng wrote:
>>>>>>> The faultability xarray is stored on the inode since faultability is a
>>>>>>> property of the guest_memfd's memory contents.
>>>>>>>
>>>>>>> In this RFC, presence of an entry in the xarray indicates faultable,
>>>>>>> but this could be flipped so that presence indicates unfaultable. For
>>>>>>> flexibility, a special value "FAULT" is used instead of a simple
>>>>>>> boolean.
>>>>>>>
>>>>>>> However, at some stages of a VM's lifecycle there could be more
>>>>>>> private pages, and at other stages there could be more shared pages.
>>>>>>>
>>>>>>> This is likely to be replaced by a better data structure in a future
>>>>>>> revision to better support ranges.
>>>>>>>
>>>>>>> Also store struct kvm_gmem_hugetlb in struct kvm_gmem_hugetlb as a
>>>>>>> pointer. inode->i_mapping->i_private_data.
>>>>>>
>>>>>> Could you help explain the difference between faultability v.s. the
>>>>>> existing KVM_MEMORY_ATTRIBUTE_PRIVATE?  Not sure if I'm the only one who's
>>>>>> confused, otherwise might be good to enrich the commit message.
>>>>>
>>>>> Thank you for this question, I'll add this to the commit message to the
>>>>> next revision if Fuad's patch set [1] doesn't make it first.
>>>>>
>>>>> Reason (a): To elaborate on the explanation in [1],
>>>>> KVM_MEMORY_ATTRIBUTE_PRIVATE is whether userspace wants this page to be
>>>>> private or shared, and faultability is whether the page is allowed to be
>>>>> faulted in by userspace.
>>>>>
>>>>> These two are similar but may not be the same thing. In pKVM, pKVM
>>>>> cannot trust userspace's configuration of private/shared, and other
>>>>> information will go into determining the private/shared setting in
>>>>> faultability.
>>>>
>>>> It makes sense to me that the kernel has the right to decide which page is
>>>> shared / private.  No matter if it's for pKVM or CoCo, I believe the normal
>>>> case is most / all pages are private, until some requests to share them for
>>>> special purposes (like DMA).  But that'll need to be initiated as a request
>>>> from the guest not the userspace hypervisor.
>>>
>>> For TDX, the plan is that the guest will request the page to be remapped
>>> as shared or private, and the handler for that request will exit to
>>> the userspace VMM.
>>>
>>> The userspace VMM will then do any necessary coordination (e.g. for a
>>> shared to private conversion it may need to unpin pages from DMA), and
>>> then use the KVM_SET_MEMORY_ATTRIBUTES ioctl to indicate agreement with
>>> the guest's requested conversion. This is where
>>> KVM_MEMORY_ATTRIBUTE_PRIVATE will be provided.
>>>
>>> Patch 38 [1] updates
>>> tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c to
>>> demonstrate the usage flow for x86.
>>>
>>> Fuad will be in a better position to explain the flow for pKVM.
>>>
>>>> I must confess I totally have no idea how KVM_MEMORY_ATTRIBUTE_PRIVATE is
>>>> planned to be used in the future. Currently it's always set at least in
>>>> QEMU if gmemfd is enabled, so it doesn't yet tell me anything..
>>>>
>>>> If it's driven by the userspace side of the hypervisor, I wonder when
>>>> should the user app request some different value it already was, if the
>>>> kernel already has an answer in this case.  It made me even more confused,
>>>> as we have this in the API doc:
>>>>
>>>>           Note, there is no "get" API.  Userspace is responsible for
>>>>           explicitly tracking the state of a gfn/page as needed.
>>>>
>>>> And I do wonder whether we will still need some API just to query whether
>>>> the kernel allows the page to be mapped or not (aka, the "real" shared /
>>>> private status of a guest page).  I guess that's not directly relevant to
>>>> the faultability to be introduced here, but if you or anyone know please
>>>> kindly share, I'd love to learn about it.
>>>
>>> The userspace VMM will track the initial shared/private state, in the
>>> sense that when the VM is created, the mem_attr_array is initialized
>>> such that the guest pages are all shared.
>>>
>>> Then when the userspace VMM calls the KVM_SET_MEMORY_ATTRIBUTES ioctl,
>>> it should record all changes so it knows what the state is in the
>>> kernel.
>>>
>>> Even if userspace VMM doesn't record the state properly, if the
>>> KVM_SET_MEMORY_ATTRIBUTES ioctl is used to request no change
>>> (e.g. setting an already private page to private), it will just be a
>>> no-op in the kernel.
>>>
>>>>>
>>>>> Perhaps Fuad can elaborate more here.
>>>>>
>>>>> Reason (b): In this patch series (mostly focus on x86 first), we're
>>>>> using faultability to prevent any future faults before checking that
>>>>> there are no mappings.
>>>>>
>>>>> Having a different xarray from mem_attr_array allows us to disable
>>>>> faulting before committing to changing mem_attr_array. Please see
>>>>> `kvm_gmem_should_set_attributes_private()` in this patch [2].
>>>>>
>>>>> We're not completely sure about the effectiveness of using faultability
>>>>> to block off future faults here, in future revisions we may be using a
>>>>> different approach. The folio_lock() is probably important if we need to
>>>>> check mapcount. Please let me know if you have any ideas!
>>>>>
>>>>> The starting point of having a different xarray was pKVM's requirement
>>>>> of having separate xarrays, and we later realized that the xarray could
>>>>> be used for reason (b). For x86 we could perhaps eventually remove the
>>>>> second xarray? Not sure as of now.
>>>>
>>>> Just had a quick look at patch 27:
>>>>
>>>> https://lore.kernel.org/all/5a05eb947cf7aa21f00b94171ca818cc3d5bdfee.1726009989.git.ackerleytng@google.com/
>>>>
>>>> I'm not yet sure what's protecting from faultability being modified against
>>>> a concurrent fault().
>>>>
>>>> I wonder whether one can use the folio lock to serialize that, so that one
>>>> needs to take the folio lock to modify/lookup the folio's faultability,
>>>> then it may naturally match with the fault() handler design, where
>>>> kvm_gmem_get_folio() needs to lock the page first.
>>>>
>>>> But then kvm_gmem_is_faultable() will need to also be called only after the
>>>> folio is locked to avoid races.
>>>
>>> My bad. In our rush to get this series out before LPC, the patch series
>>> was not organized very well. Patch 39 [2] adds the
>>> lock. filemap_invalidate_lock_shared() should make sure that faulting
>>> doesn't race with faultability updates.
>>>
>>>>>> The latter is per-slot, so one level higher, however I don't think it's a
>>>>>> common use case for mapping the same gmemfd in multiple slots anyway for
>>>>>> KVM (besides corner cases like live upgrade).  So perhaps this is not about
>>>>>> layering but something else?  For example, any use case where PRIVATE and
>>>>>> FAULTABLE can be reported with different values.
>>>>>>
>>>>>> Another higher level question is, is there any plan to support non-CoCo
>>>>>> context for 1G?
>>>>>
>>>>> I believe guest_memfd users are generally in favor of eventually using
>>>>> guest_memfd for non-CoCo use cases, which means we do want 1G (shared,
>>>>> in the case of CoCo) page support.
>>>>>
>>>>> However, core-mm's fault path does not support mapping at anything
>>>>> higher than the PMD level (other than hugetlb_fault(), which the
>>>>> community wants to move away from), so core-mm wouldn't be able to map
>>>>> 1G pages taken from HugeTLB.
>>>>
>>>> Have you looked at vm_operations_struct.huge_fault()?  Or maybe you're
>>>> referring to some other challenges?
>>>>
>>>
>>> IIUC vm_operations_struct.huge_fault() is used when creating a PMD, but
>>> PUD mappings will be needed for 1G pages, so 1G pages can't be mapped by
>>> core-mm using vm_operations_struct.huge_fault().
>>
>>
>> Just to clarify a bit for Peter: as has been discussed previously, there are
>> rather big difference between CoCo and non-CoCo VMs.
>>
>> In CoCo VMs, the primary portion of all pages are private, and they are not
>> mapped into user space. Only a handful of pages are commonly shared and
>> mapped into user space.
>>
>> In non-CoCo VMs, all pages are shared and (for the time being) all pages are
>> mapped into user space from where KVM will consume them.
>>
>>
>> Installing pmd/pud mappings into user space (recall: shared memory only) is
>> currently not really a requirement for CoCo VMs, and therefore not the focus
>> of this work.
>>
>> Further, it's currently considered to be incompatible with getting in-place
>> private<->share conversion on *page* granularity right, as we will be
>> exposing huge/gigantic folios via individual small folios to core-MM.
>> Mapping a PMD/PUD into core-mm, that is composed of multiple folios is not
>> going to fly, unless using a PFNMAP, which has been briefly discussed as
>> well, bu disregarded so far (no page pinning support).
>>
>> So in the context of this work here, huge faults and PUD/PMD *user space
>> page tables* do not apply.
>>
>> For non-CoCo VMs there is no in-place conversion problem. One could use the
>> same CoCo implementation, but without user space pud/pmd mappings. KVM and
>> VFIO would have to consume this memory via the guest_memfd in memslots
>> instead of via the user space mappings to more easily get PMD/PUD mappings
>> into the secondary MMU. And the downsides would be sacrificing the vmemmap
> 
> Is there chance that when !CoCo will be supported, then external modules
> (e.g. VFIO) can reuse the old user mappings, just like before gmemfd?

I expect this at least initially to be the case. At some point, we might 
see a transition to fd+offset for some interfaces.

I recall that there was a similar discussion when specifying "shared" 
memory in a KVM memory slot that will be backed by a guest_memfd: 
initially, this would be via VA and not via guest_memfd+offset. I recall 
Sean and James wants it to stay that way (sorry if I am wrong!), and 
James might require that to get the fancy uffd mechanism flying.

> 
> To support CoCo, I understand gmem+offset is required all over the places.
> However in a non-CoCo context, I wonder whether the other modules are
> required to stick with gmem+offset, or they can reuse the old VA ways,
> because how it works can fundamentally be the same as before, except that
> the folios now will be managed by gmemfd.
 > > I think the good thing with such approach is when developing CoCo 
support
> for all these modules, there's less constraints / concerns to be compatible
> with non-CoCo use case, also it'll make it even easier to be used in
> production before all CoCo facilities ready, as most infrastructures are
> already around and being used for years if VA can be mapped and GUPed like
> before.

Right, but even if most interfaces support guest_memfd+offset, things 
like DIRECT_IO to shared guest memory will require VA+GUP (someone 
brought that up at LPC).

-- 
Cheers,

David / dhildenb


