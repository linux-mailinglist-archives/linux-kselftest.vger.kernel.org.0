Return-Path: <linux-kselftest+bounces-10670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090468CE7B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F03EB21255
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DA12EBD4;
	Fri, 24 May 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeDStk13"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29312EBC2
	for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564012; cv=none; b=WT4Vtl39WzN0RPWvNl9VcMQwPCqzEA/a5Mjv74u7qeYRoz8m6Yi44DLHnx1wpWgETpVuWAtORYbuDOBxWzyQ8ULQnroSiKs/BX8iJv8ktTyuFF6tTchhtwGIdMWS9xpP42gCbq8upi0B+dKpP8iTLFh42jV4/DW8gwRwviFqjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564012; c=relaxed/simple;
	bh=CiO/lvnALkYRYbRd1zlLaDYsKNI9Jx8F2Ri4OFHTdJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwDXbRPaUbG6o5E8NG35TcdS7L0hxMusXPyDdUFQbgcnLvmN9kOOhpCUIVW72BWQmHIAykOASFLDHhh1ayQdT4gTgxzdcAAQEc2BU/gUjjyKCJSsJs7qVvbep9AQ9A1mHZxToWYtkEKLqHsLF4pBSCPoNylOFLis7HtDv/CAI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeDStk13; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716564009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ZIpjSpVhGXFqbeIYTEMQJjeeXWxW1gA9+eSsQ9QaIk=;
	b=FeDStk13quYHuHiJNMTyetiTSrZBsuxy1sqdh3sL1wGXUtJrjbuXQCpmORwtGQZmbGDsZC
	vJ/iKg1ofJ++Ov+8AVGXdI8Jd/V87kwzUsOIOGnXza3488aHPtjrDwub9f30kGdIZO1YlJ
	V5szLHVw2DKlc2VIuLVJkX07VxshNhw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Hhlsev9lPT2wgGOAsPHaxA-1; Fri, 24 May 2024 11:20:08 -0400
X-MC-Unique: Hhlsev9lPT2wgGOAsPHaxA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-420fc4241ccso3015045e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 08:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564007; x=1717168807;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZIpjSpVhGXFqbeIYTEMQJjeeXWxW1gA9+eSsQ9QaIk=;
        b=H6YBipkeZ3sAGN6vufLLxWk6EiVwBcy805BLt7AYLFvEyZ+CHUWYQLcQm5+I/w6jAd
         yVaYeS9F1EJo5ctYbGeIpDkj7q8dqlsRe4j561N3BvW37N56olpDJxUl2AMKxXAJ7TXi
         WUEINJVGfia4heixoOsYgtiIwGsX4AnXL37omJl0Tuu47nB6pJ7COfEsinA1UH/zR1BS
         fN5dGKVkSVLWWymIJ/e0rairGHL2UlKc15Tp61qChXQQ+8PKt/T2T+BYW9sCDsyLmzPB
         Umj2XPuezZZmvFv+ZAAOQuoBSQZIAEYCDGhIgQdxCk7ug8X5SjQ7Fs4Q5a4Idx9uX6kW
         95PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqlFMvqLIBa8AGLyTMQgeS4ePo/A4TkuAF8n3pGwAgdxvumeDiE8yp2qNWBhpk4yY7PTTU7+P8dTzBLk7pmU0fu4FWVHXIm7Le/6NhR4kA
X-Gm-Message-State: AOJu0YyIpC0zlHSGbnDjF+JfcG9WPRRg3eQEkbgJEwoNG8mM6dQYm5rJ
	4bbhH5fStwyqU8GcEvIyYpvqX56qeOTg5LqL0SdjpHZ9utX/nA2VcyG77rmU4fPkBBecYD9qBdR
	dsjFGGXO/ndr7M/J3WU6dxsUSqCeLtRTrmKgLlOEjMJc8ZChtNHeqj2U0Ozyrp9uwhw==
X-Received: by 2002:a05:600c:3152:b0:421:757:4d3e with SMTP id 5b1f17b1804b1-42108a40f7emr28519955e9.16.1716564006948;
        Fri, 24 May 2024 08:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0+MT4DE5ofWCxfrSzCht7nuRPo1YsHdujhPfIDVrENkF3v+gPtlH5pDAMVQnnZJrG1araOA==
X-Received: by 2002:a05:600c:3152:b0:421:757:4d3e with SMTP id 5b1f17b1804b1-42108a40f7emr28519685e9.16.1716564006451;
        Fri, 24 May 2024 08:20:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896f442sm23071615e9.11.2024.05.24.08.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:20:05 -0700 (PDT)
Message-ID: <b9a66589-5313-4b7e-89db-3f328d5638f3@redhat.com>
Date: Fri, 24 May 2024 17:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during
 __bio_release_pages()
To: Donet Tom <donettom@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <songmuchun@bytedance.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com>
 <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
 <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
 <20240523195734.bc03a8822a34b1a97880fb65@linux-foundation.org>
 <7792c8ba-39e6-47ee-9b43-108270325c15@redhat.com> <87o78vsoav.fsf@gmail.com>
 <c9ee47d3-77cd-4333-805a-d457e4a1bb80@redhat.com>
 <3c6e5e78-aa49-4002-941f-af8fd2b81d10@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3c6e5e78-aa49-4002-941f-af8fd2b81d10@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.05.24 11:31, Donet Tom wrote:
> 
> On 5/24/24 12:31, David Hildenbrand wrote:
>> On 24.05.24 08:43, Ritesh Harjani (IBM) wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>> dropping stable@vger.kernel.org
>>>
>>>> On 24.05.24 04:57, Andrew Morton wrote:
>>>>> On Thu, 23 May 2024 22:40:25 +0200 David Hildenbrand
>>>>> <david@redhat.com> wrote:
>>>>>
>>>>>>> You have stable@vger.kernel.org in the mail headers, so I assume
>>>>>>> you're
>>>>>>> proposing this for backporting.  When doing this, please include
>>>>>>>
>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>>
>>>>>>> in the changelog footers and also include a Fixes: target.  I'm
>>>>>>> assuming the suitable Fixes: target for this patch is 38b43539d64b?
>>>>>>
>>>>>> This adds a new selfest to make sure what was fixed (and
>>>>>> backported to
>>>>>> stable) remains fixed.
>>>>>
>>>>> Sure.  But we should provide -stable maintainers guidance for "how far
>>>>> back to go".  There isn't much point in backporting this into kernels
>>>>> where it's known to fail!
>>>>
>>>> I'm probably missing something important.
>>>>
>>>> 1) It's a test that does not fall into the common stable kernels
>>>> categories (see Documentation/process/stable-kernel-rules.rst).
>>>>
>>>> 2) If it fails in a kernel *it achieved its goal* of highlighting that
>>>> something serious is broken.
>>>>
>>>>>
>>>>> I'm still thinking that we want this in kernels which have
>>>>> 38b43539d64b?
>>>>
>>>> To hide that the other kernels are seriously broken and miss that fix?
>>>>
>>>> Really (1) this shouldn't be backported. I'm not even sure it should be
>>>> a selftest (sounds more like a reproducer that we usually attach to
>>>> commits, but that's too late). And if people care about backporting it,
>>>> (2) you really want this test to succeed everywhere. Especially also to
>>>> find kernels *without* 38b43539d64b
>>>
>>>
>>> Sorry about the noise and cc'd to stable. I believe we don't need to
>>> backport this test. The idea of adding a selftests was "also" to
>>> catch any
>>> future bugs like this.
>>
>> Yes, for that purpose it's fine, but it has quite the "specific
>> reproducer taste". Having it as part of something that is prepared to
>> run against arbitrary kernels (which selftests frequently are not) to
>> detect known problems feels better.
>>
> I have seen some hugetlbfs directio tests in LTP. If you think
> selftest is not the correct place to add this test, we can drop this
> test from selftests and add it to LTP.

I think LTP might be a better fit to spot such issues in the wild. But I 
don't have a strong opinion.

-- 
Cheers,

David / dhildenb


