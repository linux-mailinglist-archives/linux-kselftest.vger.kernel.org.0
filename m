Return-Path: <linux-kselftest+bounces-19256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB0C99562C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 20:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3241EB27774
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEA210C35;
	Tue,  8 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UVTqauF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2F20ADC9
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410842; cv=none; b=Uz5N6OKV1uRrijO8I6AKYOHPMGSPDWw+d1nCCLMQGl5AUaemK+7BurXo5/Uqvvc3JbqKtp3LwG154bdkLmrlnXlmsBjMX+cU35YChzexmFUXCLNrKtpUZXAd5fgOwm/PXYEJIco3PLAn3cRBU3sRw+4+PRpsgznetNWf65Fp7MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410842; c=relaxed/simple;
	bh=VPMRHqyb/Q9/e87LgvAazduHaCf7alPCxSWbVHZyZAM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=D9PYxlXKpHpVqu9PbF0KDq3U8KWEZoPzgw0l+5xemmKgEDPjzFazOdfnJPnX78uDnRCb1Fp7HlXQacVXREroqb0jEpzekAa6mem4J9OgQLaSfa/wF/m+OfOMZhPx3E4VKv+67fJUaQf7CvuyI42kXizix5oVyFsfVzKPLnNaztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UVTqauF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25a6fdde8so97325197b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728410840; x=1729015640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+Uxs2xH4NoLlbk4hH0dKufZ3jGhZXR1OulYKjDzCf8=;
        b=0UVTqauFm8zMhfk8+6zr8OPGexX4vM46se2Xmsn4QgKdFhFC/WQLQK+mZP+lTaQ5vE
         v8o+sH+AdAQXbEpz7Wz+399DQPj9nvaH8fFIuW9WGNLl9IcknoIUjg72rnf42BnYEZbT
         fce+FfpaYn6Ej3AOa3fKYPM29ND8HCWBVEyEBLw5hNKnds5zsVNgufJ4kLmU6ZHtfjEd
         U5r4U7JVSbpuafkOYZ6XvoSVh3vfmqg2rtrI8MkVx3qAIga5XV2C1UGDyyZNklJR0lcQ
         WVj/tRJcf8gBmegnNhQOxBDa/xERRkXUfo+qB76eiZp8ROOgjz9yjnY82PYk8uYuiXNX
         c0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410840; x=1729015640;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Uxs2xH4NoLlbk4hH0dKufZ3jGhZXR1OulYKjDzCf8=;
        b=w7ozPcOzCM9ovunz+a+zQ4GK9Bph02voYSPUPbQEJNrDQhePrs/zN55kUu/1UYLeNY
         0N9Cb5hILsapz5wo0gtomSsgJCWYdM9AIDeVMfYDWwNwOUCQ5Xn8YinsA4QYvhtuMLju
         VAtZ6ULVAW4JnX8wGTeripbc60kgNbX57vq17YJauoeyrwgzW8mYHounqyibizRx0qxs
         OMIe5xkxSHiwH2V9Oy3YoFfSInFwPMCLQ16WuCSnrTu1g3310uVtmvxJXcHJzKQfBLPX
         4r4PXpsS3wIMWK1ywr9vO3zM1V8IUZ2WxEQjk/9isGMFcOzq3jhxfi5l4SfNl0O3tknh
         gL7w==
X-Forwarded-Encrypted: i=1; AJvYcCWbqGziNxJbA5zfdwHvt5vjw4XAmapjaaPxQ7IGma7uP823hBX6wg/5Y6R5sLK1BVscR9ypnTnmDk++aCSOxqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2y/Cm0JyCofliGRx+jertriNkQV7gItxiF/6jvn3FH4ttjBsu
	iGNdOFbrpKASKmkOyz6h1RMvSJcacwryFrJIt5rnDHzJZBt0q9Qe93rtIRf6IAz/Tpw4Cf47qo9
	tT58Q0mY3vcxi/Pzo02gOug==
X-Google-Smtp-Source: AGHT+IE9oeDn9TjYqmz9fnNZvA2vGhI22YX38uYS3CQQYmwwAnoN7YG1nYKm0OprX/ZwSMpbDB3n14/P1EgAWSj+Kg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:4a8:b0:e28:e4a7:3206 with
 SMTP id 3f1490d57ef6-e28e4a732e6mr33127276.8.1728410839734; Tue, 08 Oct 2024
 11:07:19 -0700 (PDT)
Date: Tue, 08 Oct 2024 18:07:18 +0000
In-Reply-To: <e8f55fef-1821-408e-88ed-b25200ef66c9@amazon.co.uk> (message from
 Patrick Roy on Mon, 7 Oct 2024 16:56:42 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz1q0qtqnd.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
From: Ackerley Tng <ackerleytng@google.com>
To: Patrick Roy <roypat@amazon.co.uk>
Cc: quic_eberman@quicinc.com, tabba@google.com, jgg@nvidia.com, 
	peterx@redhat.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, mike.kravetz@oracle.com, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org, 
	jgowans@amazon.com, kalyazin@amazon.co.uk, derekmn@amazon.com
Content-Type: text/plain; charset="UTF-8"

Patrick Roy <roypat@amazon.co.uk> writes:

> Hi Ackerley,
>
> On Thu, 2024-10-03 at 22:32 +0100, Ackerley Tng wrote:
>> Elliot Berman <quic_eberman@quicinc.com> writes:
>>
>>> On Tue, Sep 10, 2024 at 11:44:01PM +0000, Ackerley Tng wrote:
>>>> Since guest_memfd now supports mmap(), folios have to be prepared
>>>> before they are faulted into userspace.
>>>>
>>>> When memory attributes are switched between shared and private, the
>>>> up-to-date flags will be cleared.
>>>>
>>>> Use the folio's up-to-date flag to indicate being ready for the guest
>>>> usage and can be used to mark whether the folio is ready for shared OR
>>>> private use.
>>>
>>> Clearing the up-to-date flag also means that the page gets zero'd out
>>> whenever it transitions between shared and private (either direction).
>>> pKVM (Android) hypervisor policy can allow in-place conversion between
>>> shared/private.
>>>
>>> I believe the important thing is that sev_gmem_prepare() needs to be
>>> called prior to giving page to guest. In my series, I had made a
>>> ->prepare_inaccessible() callback where KVM would only do this part.
>>> When transitioning to inaccessible, only that callback would be made,
>>> besides the bookkeeping. The folio zeroing happens once when allocating
>>> the folio if the folio is initially accessible (faultable).
>>>
>>> From x86 CoCo perspective, I think it also makes sense to not zero
>>> the folio when changing faultiblity from private to shared:
>>>  - If guest is sharing some data with host, you've wiped the data and
>>>    guest has to copy again.
>>>  - Or, if SEV/TDX enforces that page is zero'd between transitions,
>>>    Linux has duplicated the work that trusted entity has already done.
>>>
>>> Fuad and I can help add some details for the conversion. Hopefully we
>>> can figure out some of the plan at plumbers this week.
>>
>> Zeroing the page prevents leaking host data (see function docstring for
>> kvm_gmem_prepare_folio() introduced in [1]), so we definitely don't want
>> to introduce a kernel data leak bug here.
>>
>> In-place conversion does require preservation of data, so for
>> conversions, shall we zero depending on VM type?
>>
>> + Gunyah: don't zero since ->prepare_inaccessible() is a no-op
>> + pKVM: don't zero
>> + TDX: don't zero
>> + SEV: AMD Architecture Programmers Manual 7.10.6 says there is no
>>   automatic encryption and implies no zeroing, hence perform zeroing
>> + KVM_X86_SW_PROTECTED_VM: Doesn't have a formal definition so I guess
>>   we could require zeroing on transition?
>
> Maybe for KVM_X86_SW_PROTECTED_VM we could make zero-ing configurable
> via some CREATE_GUEST_MEMFD flag, instead of forcing one specific
> behavior.

Sounds good to me, I can set up a flag in the next revision.

> For the "non-CoCo with direct map entries removed" VMs that we at AWS
> are going for, we'd like a VM type with host-controlled in-place
> conversions which doesn't zero on transitions, so if
> KVM_X86_SW_PROTECTED_VM ends up zeroing, we'd need to add another new VM
> type for that.
>
> Somewhat related sidenote: For VMs that allow inplace conversions and do
> not zero, we do not need to zap the stage-2 mappings on memory attribute
> changes, right?
>

Here are some reasons for zapping I can think of:

1. When private pages are split/merged, zapping the stage-2 mappings on
   memory attribute changes allows the private pages to be re-faulted by
   KVM at smaller/larger granularity.

2. The rationale described here
   https://elixir.bootlin.com/linux/v6.11.2/source/arch/x86/kvm/mmu/mmu.c#L7482
   ("Zapping SPTEs in this case ensures KVM will reassess whether or not
   a hugepage can be used for affected ranges.") probably refers to the
   existing implementation, when a different set of physical pages is
   used to back shared and private memory. When the same set of physical
   pages is used for both shared and private memory, then IIUC this
   rationale does not apply.

3. There's another rationale for zapping
   https://elixir.bootlin.com/linux/v6.11.2/source/virt/kvm/kvm_main.c#L2494
   to do with read vs write mappings here. I don't fully understand
   this, does this rationale still apply?

4. Is zapping required if the pages get removed/added to kernel direct
   map?

>> This way, the uptodate flag means that it has been prepared (as in
>> sev_gmem_prepare()), and zeroed if required by VM type.
>>
>> Regarding flushing the dcache/tlb in your other question [2], if we
>> don't use folio_zero_user(), can we relying on unmapping within core-mm
>> to flush after shared use, and unmapping within KVM To flush after
>> private use?
>>
>> Or should flush_dcache_folio() be explicitly called on kvm_gmem_fault()?
>>
>> clear_highpage(), used in the non-hugetlb (original) path, doesn't flush
>> the dcache. Was that intended?
>>
>>> Thanks,
>>> Elliot
>>>
>>>>
>>>> <snip>
>>
>> [1] https://lore.kernel.org/all/20240726185157.72821-8-pbonzini@redhat.com/
>> [2] https://lore.kernel.org/all/diqz34ldszp3.fsf@ackerleytng-ctop.c.googlers.com/
>
> Best,
> Patrick

