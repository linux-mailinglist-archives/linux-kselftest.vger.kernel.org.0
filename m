Return-Path: <linux-kselftest+bounces-41401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1AAB553D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6182AE122C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52894313275;
	Fri, 12 Sep 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPtRqWx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0F2253FD
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691556; cv=none; b=L17feBEoqonKXZaCdpEKwWiDmkradPxyvaGyfU2zhbkpKvQhjauEqBbG6zAuVhTq8knqm9k9qUgGbB2o0U+aq8rRBWpPyuoP7bfQVbhCQxeumnFzCSJ+qmeCp7Zo50CARAA/Qc5zDsukuk/ESHdErqMmIfIWmOWSuFiGwhxxvF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691556; c=relaxed/simple;
	bh=GRXHdoeXgs2rRRY6tyhSrt4hGOweA6vNgajT9/12Zek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfaDree1zBOy4Pri99IHEpwPNXgN7iPBqELpgOPmzR249bbJsKSLayM39NEY5Ck+xcuOulbnqGq0xcZ9UNuey65wsn7ECRyobDgbfUUpGJxBX5mgw+FdKAnnNP5+hJDp9uVBoy6fFUMxRlJQwJSYdb/JgXqo5ZG+asw8n1K3K50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPtRqWx8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757691553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2pXtBqfp2bEFBqLzvF+btY6ON3Qyio7xhH4wSuKco70=;
	b=XPtRqWx8H5JnYl+NW3HknulchBddcW1hhOm/Ww7YMwH6aG9QnVNwlgRYzV2htv+ooBsQhF
	75/XmGR0SVCyXhMwM9QZIz+U8fdn/DptvQ6JMDVoXK3m90WXiYALtrvZGW4hLDa4JZ+EqM
	7oSW+lAT9v3Xg2uTIXSrjMq6jJkmcM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wwCLNxlZORuFNAOPFR0qzw-1; Fri, 12 Sep 2025 11:39:12 -0400
X-MC-Unique: wwCLNxlZORuFNAOPFR0qzw-1
X-Mimecast-MFC-AGG-ID: wwCLNxlZORuFNAOPFR0qzw_1757691551
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb612d362so11458415e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 08:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691551; x=1758296351;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pXtBqfp2bEFBqLzvF+btY6ON3Qyio7xhH4wSuKco70=;
        b=O+JNCGqjPIgIvnGZqKrrFxSNxQ99ELQwERpX6uA9ZEuaO71u4XxUkkURUDP/72FM+x
         ffH5/WIQlIlitdxLMvmHSWTt1e99dPNwSTb70ZTHbrdMXYf9VlmcNweQRdltsN2xbasF
         jSwDNo4QBuEm1oOQuiwC4lb8VRln02XXG4VT5Q6+iIQSI4X5AuWEV1Rjwn3zDcl2U5Au
         pBm0vv1R8gAyeA1+ofvEvpG9G7ZJzUp6+l3Rt17jOAev6xaN4FoVwKUSNO7xEyDPcNbB
         0hf8SRjwMyzM634Axk1DNIuyUHIzE4s/z3AZE/qRUnzSr9unu1qizehlkZhr1q10yGda
         kQHg==
X-Forwarded-Encrypted: i=1; AJvYcCUk2eAoWpI0G3rK2sw9Jhiwsp02j3pKL0v2FXs061dXqdQxKvePAM3Fx8xcEK1Bx/5SQ5CDnolxevFZ1iPjDXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsH7kRvmRaDrjyMxkVPSZD6Yn+FnFOeno+nE4CkmoGc2zadlRD
	3La7XcdX9gUSwK88OckFpzncITubm+f7dP9O7qYw+YxBrPD2ab6Q1Lsm6NizzHiAvhD+tfs+PM5
	+m3mklZLJM1BgSpIKZ1tNSeXl0dBAad66SmG4ywoA6L1IfXhys/DfkKahhITPBZ3mj5gDog==
X-Gm-Gg: ASbGncu3y3pxrx1iewltKqYjzdFuASHA/7m/CTGBzmcvQIye/P/8Ch2lX9/TBmN7HLg
	qXDm1jJZOVJlapKWcbhJoJaJWqpzjRRZTRANDOwfxXVBTlOWTnn4E+daOmkDPovXZUE4gZzz1dc
	KUUKlJW4XSskJPeR1No6wI6ShgvCNtjrmcSqTFGxZoWYIWAw8kDs+SQ8dSxl4B0VhAgfMLJjCBi
	qfhdjDWwEmVfNl/qRCsi2xQ2m2VtS+IFb/T5g1nWyYG0/nsnsY4IJYwwwB126Ll5MzyfQ3KIXAq
	18eOI4blUIihW2UQQ9EhgFHGax+/PXnl1VbeABGfz0bUiONOolahd4I0dOByZ4OBTn4kgzepIyf
	U2JKxWFK0qzz6BK+ixtQHu24ShWw9UO4IyPqwuNWZR1pxKuVNdWZB9iQXIp25OSOPs1o=
X-Received: by 2002:a05:600c:1991:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45f2120717dmr33991085e9.34.1757691551037;
        Fri, 12 Sep 2025 08:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu0gMuqkCIPX52SGtePGrKmTkbOBkfc+AQ06Rj5/vieuYX7W284rbFR/kLNgC2eQweLIIqGw==
X-Received: by 2002:a05:600c:1991:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45f2120717dmr33990575e9.34.1757691550592;
        Fri, 12 Sep 2025 08:39:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01984a62sm37029785e9.4.2025.09.12.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:39:10 -0700 (PDT)
Message-ID: <55b727fc-8fd3-4e03-8143-1ed6dcab2781@redhat.com>
Date: Fri, 12 Sep 2025 17:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: kalyazin@amazon.com, James Houghton <jthoughton@google.com>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael.day@amd.com" <michael.day@amd.com>,
 "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
 <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
 <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
 <bc26eaf1-9f01-4a65-87a6-1f73fcd00663@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bc26eaf1-9f01-4a65-87a6-1f73fcd00663@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.09.25 16:48, Nikita Kalyazin wrote:
> 
> 
> On 12/09/2025 14:36, David Hildenbrand wrote:
>> On 11.09.25 12:15, Nikita Kalyazin wrote:
>>>
>>>
>>> On 10/09/2025 22:23, James Houghton wrote:
>>>> On Tue, Sep 2, 2025 at 4:20 AM Kalyazin, Nikita
>>>> <kalyazin@amazon.co.uk> wrote:
>>>>>
>>>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>>>
>>>> Hi Nikita,
>>>
>>> Hi James,
>>>
>>> Thanks for the review!
>>>
>>>
>>>>>
>>>>> write syscall populates guest_memfd with user-supplied data in a
>>>>> generic
>>>>> way, ie no vendor-specific preparation is performed.  This is supposed
>>>>> to be used in non-CoCo setups where guest memory is not
>>>>> hardware-encrypted.
>>>>
>>>> What's meant to happen if we do use this for CoCo VMs? I would expect
>>>> write() to fail, but I don't see why it would (seems like we need/want
>>>> a check that we aren't write()ing to private memory).
>>>
>>> I am not so sure that write() should fail even in CoCo VMs if we access
>>> not-yet-prepared pages.  My understanding was that the CoCoisation of
>>> the memory occurs during "preparation".  But I may be wrong here.
>>
>> But how do you handle that a page is actually inaccessible and should
>> not be touched?
>>
>> IOW, with CXL you could crash the host.
>>
>> There is likely some state check missing, or it should be restricted to
>> VM types.
> 
> Sorry, I'm missing the link between VM types and CXL.  How are they related?

I think what you explain below clarifies it.

> 
> My thinking was it is a regular (accessible) page until it is "prepared"
> by the CoCo hardware, which is currently tracked by the up-to-date flag,
> so it is safe to assume that until it is "prepared", it is accessible
> because it was allocated by filemap_grab_folio() ->
> filemap_alloc_folio() and hasn't been taken over by the CoCo hardware.
> What scenario can you see where it doesn't apply as of now?

Thanks for clarifying, see below.

> 
> I am aware of an attempt to remove preparation tracking from
> guest_memfd, but it is still at an RFC stage AFAIK [1].
> 
>>
>> Do we know how this would interact with the direct-map removal?
> 
> I'm using folio_test_uptodate() to determine if the page has been
> removed from the direct map as kvm_gmem_mark_prepared() is what
> currently removes the page from the direct map and marks it as
> up-to-date.  [2] is a Firecracker feature branch where the two work in
> combination.

Ah, okay. Yes, I recalled [1] that we wanted to change these semantics 
to be "uptodate: was zeroed", and that preparation handling would be 
essentially handled by the arch backend.

-- 
Cheers

David / dhildenb


