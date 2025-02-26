Return-Path: <linux-kselftest+bounces-27622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7AA46500
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33721622C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3721CC67;
	Wed, 26 Feb 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT3AWPDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E021CC54
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583830; cv=none; b=skpRBwpdZZ+z+8Rg8zPEKd5rtmT7Qa9MKu+0qmQ1wAQRemPMKTXGl5fNC0int5nSNdcsJSjUghIVGP4fQT0NcfiDcgzlqDpNiLJ3HETifW4eeOzFtFCDVGsEjiAGtkxW0nTZOZ7fJ9rLEg7k15NYzRBvmDVsW6YWY7PfCbhViag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583830; c=relaxed/simple;
	bh=/wpDNLjk/fNjvfimoUDJdbZDLqeC6MxKiLnD31fpHaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul/xj6fK6rPeITviOjcoWMtcvbGIRb9FC9uV7mFBKzZwD/Ax8n1klaAI6JJH5HE9CTa8ToN94MjzZZuwG1w/Qj7Hm0w4bfACNNsLpoDdRSwASSB7rLKwHMAuOsu7nBHct/sAJvVsrzcclxKCvOSgsd1MPj5LRi47W8NeADXvbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QT3AWPDv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740583827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gVt0qzRRcwLYzm8lqhyi37nC1mPHa9gt3lqzImxJBfw=;
	b=QT3AWPDvYiG1Ns55Xtrjynf2lxluI+6DGRtdImQS05zXDvQ5w3+jFXhchskOIIHQPw8JU6
	HcOxpT4WojGLvHiRHwy1sUkxxtsLoU0VXnugSCARNVhHnMA3CwmGA6V06/jPBTQX/DIQk4
	zOb2JYlVBIAROWoSVJpHU/pdd6V1T/k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-mjGiAibFM8aGPbS4ly6t6g-1; Wed, 26 Feb 2025 10:30:24 -0500
X-MC-Unique: mjGiAibFM8aGPbS4ly6t6g-1
X-Mimecast-MFC-AGG-ID: mjGiAibFM8aGPbS4ly6t6g_1740583824
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935e09897so47508285e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 07:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583824; x=1741188624;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVt0qzRRcwLYzm8lqhyi37nC1mPHa9gt3lqzImxJBfw=;
        b=Mt+flIwqH4ISWhvEseu9PWM7XqY5POTaV4Izt8tRLDZxPH0hizlBSe93KqGuOllo7E
         PQFOFIvxFAEPHLY78PwGHFTJagOJY6DkmSzZqIqw7JjWEH+S7zB4fXmYVZuOgy6COSwo
         51BujLnbD5wHdaTjYrEd42y67Izaey/YLwrpoDQ66LLSR2IJp0WSHrqQ0rVol/IuER0P
         2m6iKgbx5vs/myiI4C3mYV6UcCRZ8vgzlxrp3c6a3wpL/eqmICmVJjvX6FZ6LhdGvP4t
         kWKcCvdM2AZmuf8/UVGJ8/2bw7wRntN2zukNaCaNSBSgpHMEHv2QAuBjPCyWM/BNM56y
         5FhA==
X-Forwarded-Encrypted: i=1; AJvYcCXybtOflM4Z+kHRyka3JhjhduMb5hFmPH/n89ArBigShe6NPbeT2bcI9QjOi9Jd0fFxAMG4inr1zh8/zF8Cwq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK82jbq85Th1Yr5qTPmN13hKt+bDXTNyUy4XbMBBRkh+BpGdN
	byqpihsIrc2wHGx+8lhqUXmkohyZREz5gTMYkszAWY8Rlf2V+Bsont8lqPOehm/qirV9buyf5Wg
	yW4cM5BBkiriXcARNzMbQCXcRn8zrsG0nY8TQ6F9I8HsMdUkeA5f1bC55/g0CfqbAgQ==
X-Gm-Gg: ASbGncvjKEEzlTH0kCD2uBISyms+3w9olMoNbrrUiRQbimYqb0FDj1CS+ZA/SW99wIJ
	/fHSp4jbYxYKhbpX1hL5iGhGjdUXShP4vzV1b/wdH5sc9jBFugeJard/UUIV2if3UPw1Y7ePnpR
	fM4/qXMKpyLMwxi6KalT1P5oCRHsi4/3TJxCgSYSb9tvEE1UBrV1StNmL5Muw9db0ygw5SkvYgg
	RzImLkknX8RyUdQagRtGt9x1tp6Il4GO3sjLxNJI5ZbWInPd5hzoImUAeh47buyyIRfI9CZ3uXR
	JDWSHe7K2sLLXSQL5cDNSq/imepvA8FG9qdlwyr43+jlkLVYY+FoLcA09xxYoHJl0W0g8w5mTMc
	Tgej5f2cNxvY8NHQjhBZLUWyCHcF4mZ+6HMOtlvufQZA=
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id 5b1f17b1804b1-43ab8fd1f46mr35729615e9.4.1740583823436;
        Wed, 26 Feb 2025 07:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDQ1Rg5mJ7gASlDo38k12X1agotgAvbBBn2p1lMp4aSsVrgnQa+7aXZITK3QN/pmv/rHAjsw==
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id 5b1f17b1804b1-43ab8fd1f46mr35729205e9.4.1740583822963;
        Wed, 26 Feb 2025 07:30:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52bc54sm26843285e9.5.2025.02.26.07.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:30:22 -0800 (PST)
Message-ID: <9ffce724-23c9-4aa1-bc53-8292e1029991@redhat.com>
Date: Wed, 26 Feb 2025 16:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] KVM: guest_memfd: Add flag to remove from direct
 map
To: Patrick Roy <roypat@amazon.co.uk>, rppt@kernel.org, seanjc@google.com
Cc: pbonzini@redhat.com, corbet@lwn.net, willy@infradead.org,
 akpm@linux-foundation.org, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tabba@google.com, jgowans@amazon.com,
 graf@amazon.com, kalyazin@amazon.com, xmarcalx@amazon.com,
 derekmn@amazon.com, jthoughton@google.com,
 Elliot Berman <quic_eberman@quicinc.com>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-4-roypat@amazon.co.uk>
 <a3178c50-2e76-4743-8008-9a33bd0af93f@redhat.com>
 <8642de57-553a-47ec-81af-803280a360ec@amazon.co.uk>
 <bfe43591-66b6-4fb9-bf6c-df79ddeffb17@redhat.com>
 <7f38018b-dc89-4d79-a309-149557796121@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7f38018b-dc89-4d79-a309-149557796121@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 16:14, Patrick Roy wrote:
> 
> 
> On Wed, 2025-02-26 at 09:08 +0000, David Hildenbrand wrote:
>> On 26.02.25 09:48, Patrick Roy wrote:
>>>
>>>
>>> On Tue, 2025-02-25 at 16:54 +0000, David Hildenbrand wrote:> On 21.02.25 17:07, Patrick Roy wrote:
>>>>> Add KVM_GMEM_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD() ioctl. When
>>>>> set, guest_memfd folios will be removed from the direct map after
>>>>> preparation, with direct map entries only restored when the folios are
>>>>> freed.
>>>>>
>>>>> To ensure these folios do not end up in places where the kernel cannot
>>>>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>>>>> address_space if KVM_GMEM_NO_DIRECT_MAP is requested.
>>>>>
>>>>> Note that this flag causes removal of direct map entries for all
>>>>> guest_memfd folios independent of whether they are "shared" or "private"
>>>>> (although current guest_memfd only supports either all folios in the
>>>>> "shared" state, or all folios in the "private" state if
>>>>> !IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM)). The usecase for removing
>>>>> direct map entries of also the shared parts of guest_memfd are a special
>>>>> type of non-CoCo VM where, host userspace is trusted to have access to
>>>>> all of guest memory, but where Spectre-style transient execution attacks
>>>>> through the host kernel's direct map should still be mitigated.
>>>>>
>>>>> Note that KVM retains access to guest memory via userspace
>>>>> mappings of guest_memfd, which are reflected back into KVM's memslots
>>>>> via userspace_addr. This is needed for things like MMIO emulation on
>>>>> x86_64 to work. Previous iterations attempted to instead have KVM
>>>>> temporarily restore direct map entries whenever such an access to guest
>>>>> memory was needed, but this turned out to have a significant performance
>>>>> impact, as well as additional complexity due to needing to refcount
>>>>> direct map reinsertion operations and making them play nicely with gmem
>>>>> truncations.
>>>>>
>>>>> This iteration also doesn't have KVM perform TLB flushes after direct
>>>>> map manipulations. This is because TLB flushes resulted in a up to 40x
>>>>> elongation of page faults in guest_memfd (scaling with the number of CPU
>>>>> cores), or a 5x elongation of memory population. On the one hand, TLB
>>>>> flushes are not needed for functional correctness (the virt->phys
>>>>> mapping technically stays "correct",  the kernel should simply to not it
>>>>> for a while), so this is a correct optimization to make. On the other
>>>>> hand, it means that the desired protection from Spectre-style attacks is
>>>>> not perfect, as an attacker could try to prevent a stale TLB entry from
>>>>> getting evicted, keeping it alive until the page it refers to is used by
>>>>> the guest for some sensitive data, and then targeting it using a
>>>>> spectre-gadget.
>>>>>
>>>>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>>>>
>>>> ...
>>>>
>>>>>
>>>>> +static bool kvm_gmem_test_no_direct_map(struct inode *inode)
>>>>> +{
>>>>> +     return ((unsigned long) inode->i_private) & KVM_GMEM_NO_DIRECT_MAP;
>>>>> +}
>>>>> +
>>>>>     static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>>>>     {
>>>>> +     struct inode *inode = folio_inode(folio);
>>>>> +
>>>>> +     if (kvm_gmem_test_no_direct_map(inode)) {
>>>>> +             int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
>>>>> +                                                  false);
>>>>
>>>> Will this work if KVM is built as a module, or is this another good
>>>> reason why we might want guest_memfd core part of core-mm?
>>>
>>> mh, I'm admittedly not too familiar with the differences that would come
>>> from building KVM as a module vs not. I do remember something about the
>>> direct map accessors not being available for modules, so this would
>>> indeed not work. Does that mean moving gmem into core-mm will be a
>>> pre-requisite for the direct map removal stuff?
>>
>> Likely, we'd need some shim.
>>
>> Maybe for the time being it could be fenced using #if IS_BUILTIN() ...
>> but that sure won't win in a beauty contest.
> 
> Is anyone working on such a shim at the moment? Otherwise, would it make
> sense for me to look into it? (although I'll probably need a pointer or
> two for what is actually needed)
> 
> I saw your comment on Fuad's series [1] indicating that he'll also need
> some shim, so probably makes sense to tackle it anyway instead of
> hacking around it with #if-ery.

Elliot (CC) was working on "guestmem library" project [1], but it was 
unclear what we could factor out into the core.

Looks like a simple shim for such stuff might be a good starting point, 
although not the final idea of encapsulating more in the library.

@Elliot, are you currently still looking into this?


[1] 
https://lore.kernel.org/all/20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com/T/#u

-- 
Cheers,

David / dhildenb


