Return-Path: <linux-kselftest+bounces-24069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09EA0626F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD7D162279
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 16:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857AF1FE47F;
	Wed,  8 Jan 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEysFDu7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3211FE451
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354806; cv=none; b=NH95ctuahSz5ZfvSqC0q6hDSR3rj49sHizgtnnjivXrQBGW5TuDSRsspaRSb2zE609B9tQDAmhTkYRvejeihD9m4XtNoE3ARcjjyswx6l0delgK2RAuEGlmidkP/xi3Xc83fXoI3H3Zd5Z95KeFvneXuOEpzgRe+vOF5b78Z3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354806; c=relaxed/simple;
	bh=JFoDSdwu3BehlopDiE9xC/Q9nO3n3/dM1BuWJ5+blpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmY0IQb6CgfHyQ9pRYN1WPIpl0ts3vDfcIx5WiS8na4FnhZbSvYf1WqZJdpxf/ZLzG/Yru90kJPS0QBhseG3yziTy6hy4ZIhiM3hEeTuxD+bGbhl9BuXFOc86wMqL52wedfWWR2C+syVa9HzIkuHLpWqoYQ1TMx6C/1iLEilA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEysFDu7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736354803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLtBzk/sgQfs/lhGSB40P8RaGY6wajWRxsFpEvAFEME=;
	b=dEysFDu7suiwhoIthKhCFTXOubgW/IqLmu4uPuh0DZs3cgcjUniM2gnlc0d4gJOKUz0i2B
	RF29jSG3xAT2Safe/pxDFKeH9SmsuvOcrs9VBG4TpJhCsSKLL+cjLKC47cWmpl6OBlahzO
	TgFZU4JEmlg4kCunlC0HfNMsRH0Ea5w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-JVmxzO3yMlOx--Hk7-uyzA-1; Wed, 08 Jan 2025 11:46:42 -0500
X-MC-Unique: JVmxzO3yMlOx--Hk7-uyzA-1
X-Mimecast-MFC-AGG-ID: JVmxzO3yMlOx--Hk7-uyzA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38634103b0dso10055393f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 08:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354800; x=1736959600;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLtBzk/sgQfs/lhGSB40P8RaGY6wajWRxsFpEvAFEME=;
        b=Yx95C3JN3mytr2qVaMqJH+B25cbAwbYesYKilV9bxu2vvcEnFG5ejq5+cz6qWDM76Z
         DFnq0CHXGsHWKUuRMFBmWMgVJzmlu9+sv/VvtvMG7RCQT9I2sDXTcrKgdaecsExN3Lke
         eYLJRBBFCKeO3T1CC7lFVukVO4AU1sjg7UFLnyQ4N5UgNGtG/AzZriIfjbVUKR3rRNfd
         /k8U2tlvQRTN8cjUKxB2/dT0hZLmZpXBnt7AxjXBxELWS1GYBZSkyk/T8E6jmda4BZlt
         bvghHC6JezYaExMawSCN7u/zoG6OkM+mivyGgzwBAT3UM64mcUsTbCHQa0aB3y/cRd8T
         OTfw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPDhBy9g8vzbAJPUo4IqDz/37JzXXmfjLHhhcQQL9eTeMtZ2Juvd/gJuowajwZDR/h+PfYmeyBiP3x+Qaht8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzucvQjpawzHPd3d4+yzsknOp2zpITps1M4pT0pS1dvGD0EzLVc
	inc9gCGQazja7ffSOGru1uF/vWJCZAuxoVv91wIB0UrH7j3XH+Yitu6kjNFwF6jML1gqrIdKszQ
	RMv0737Pk2XkTzHk32ZMHYjbU1M70bK33ksYniLpoy37aE+cd8WcNScxsd+3POPz/OQ==
X-Gm-Gg: ASbGnctfkVirRTFZaAtzdTA7o1sKosNuDeCQyLjx3DN/z1PoCMrAlldsM1Ow3+niXeD
	qk9Xozdpkpqt9yDvhwg88YJOSgATDpic/+HzCnS7t3Wn4zXNMlgO8Rqx/IBRetz4AXbRJf7Y6XP
	lJFsgpmIQ2mLbYJuq0i0Ie9pPh7jljRRtbG+F31KHdDJ3cGeHptpSSvX8KKiEktkHHzianSFTLi
	43s9KixLLTWqWuxDXNPRbTiAFjFvOnU73DIYxtDmTXASVGPW2EbGWitJcjxKKcmZ8hrSM9t9T4n
	hnI5N/mkpU1NbaECPc822Ymn89+z3W3mHyhyxqmA5/Vtr4zIjFX1nc7Xc/KAuuvRiki/AhYc14/
	MtuzmPg==
X-Received: by 2002:adf:a312:0:b0:38a:88f8:aacc with SMTP id ffacd0b85a97d-38a88f8acf1mr2115594f8f.56.1736354800561;
        Wed, 08 Jan 2025 08:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxWHNxKUTicaDbJ8h2ZEv2XhiA24TGALc6sYrIuKwdB/BhEUpVvB2iic7z7xiM5gTtnXIffA==
X-Received: by 2002:adf:a312:0:b0:38a:88f8:aacc with SMTP id ffacd0b85a97d-38a88f8acf1mr2115572f8f.56.1736354800085;
        Wed, 08 Jan 2025 08:46:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da79c0sm26729805e9.6.2025.01.08.08.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:46:39 -0800 (PST)
Message-ID: <618798d5-71b2-43d6-8f5c-78d911c5dd43@redhat.com>
Date: Wed, 8 Jan 2025 17:46:37 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
 <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.01.25 17:13, Thomas Weißschuh wrote:
> On Wed, Jan 08, 2025 at 02:36:57PM +0100, David Hildenbrand wrote:
>> On 08.01.25 09:05, Thomas Weißschuh wrote:
>>> On Wed, Jan 08, 2025 at 11:46:19AM +0530, Dev Jain wrote:
>>>>
>>>> On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
>>>>> If not enough physical memory is available the kernel may fail mmap();
>>>>> see __vm_enough_memory() and vm_commit_limit().
>>>>> In that case the logic in validate_complete_va_space() does not make
>>>>> sense and will even incorrectly fail.
>>>>> Instead skip the test if no mmap() succeeded.
>>>>>
>>>>> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
>>>>> Cc: stable@vger.kernel.org
>>
>> CC stable on tests is ... odd.
> 
> I thought it was fairly common, but it isn't.
> Will drop it.

As it's not really a "kernel BUG", it's rather uncommon.

>>
>> Note that with MAP_NORESRVE, most setups we care about will allow mapping as
>> much as you want, but on access OOM will fire.
> 
> Thanks for the hint.
> 
>> So one could require that /proc/sys/vm/overcommit_memory is setup properly
>> and use MAP_NORESRVE.
> 
> Isn't the check for lchunks == 0 essentially exactly this?

I assume paired with MAP_NORESERVE?

Maybe, but it could be better to have something that says "if 
overcommit_memory is not setup properly I will SKIP this test", but 
otherwise I expect this to work and will FAIL if it doesn't".

Or would you expect to run into lchunks == 0 even if overcommit_memory 
is setup properly and MAP_NORESERVE is used? (very very low memory that 
we cannot even create all the VMAs?)

> 
>> Reading from anonymous memory will populate the shared zeropage. To mitigate
>> OOM from "too many page tables", one could simply unmap the pieces as they
>> are verified (or MAP_FIXED over them, to free page tables).
> 
> The code has to figure out if a verified region was created by mmap(),
> otherwise an munmap() could crash the process.
> As the entries from /proc/self/maps may have been merged and (I assume)

Yes, and partial unmap (in chunk granularity?) would split them again.

> the ordering of mappings is not guaranteed, some bespoke logic to establish
> the link will be needed.


My thinking was that you simply process one /proc/self/maps entry in 
some chunks. After processing a chunk, you munmap() it.

So you would process + munmap in chunks.

> 
> Is it fine to rely on CONFIG_ANON_VMA_NAME?
> That would make it much easier to implement.

Can you elaborate how you would do it?

> 
> Using MAP_NORESERVE and eager munmap()s, the testcase works nicely even
> in very low physical memory conditions.

Cool.

-- 
Cheers,

David / dhildenb


