Return-Path: <linux-kselftest+bounces-17155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7F96C486
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4311F24A5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA61DFE1F;
	Wed,  4 Sep 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8ZPx66o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C971E0B9B;
	Wed,  4 Sep 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469104; cv=none; b=MaBwTT45Leva7rF0G8w5gtSD9w1GfyEtY8u+X3ZD2O36HBkc+WSoXG/B0V2RyCsuLmNSVv6wwcgmdg4LjuxRl/2Yq4tvv61V4+GPFW9Ycb138m9H3ejAhxJJz7ESi50VL16w4709Rrmi5UvTsKXNZuzsgFD/SIZflt5un69XzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469104; c=relaxed/simple;
	bh=jrPsPPlIePqMYpONK4ZEimXibJHFsvp/M5Fjcx8uuLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tK9QZ2Wqdd4HF8/BxyGWBwBoVF4AHCQ+IKMHTteGddMmeYa0RmBRUBTP9lGUUlb3BfI2/BY40p0+CjVzJQHCZc/HwnlDfKnCLVGvIs5nLAUszwUnHaM38sKOaTJWUNcRaB+8pa0yfuLC0vnnlTRXuk29KUmqsOjcdME7kSbPWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8ZPx66o; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso4775621a12.1;
        Wed, 04 Sep 2024 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725469102; x=1726073902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kMy7Qn1zaAc9/IMOhqSwwfWBQGHR6tB90Jwa2IOJx1I=;
        b=K8ZPx66oc9sQ+yO0TG+GQjtsql8e8dIhtJdAeCQ7KLCM6lm9CmMA6wzn1kAd48OdDW
         OnmDrDOOGG073k7+T7NmO0MBoCjAIMCf8ZCnjMypEWWLDFYRn8o9tebp1rzNHxJls2Gb
         BC4okd1UuqBmlg6YQmNCnmnRXZiZ8SplGBHh6U2jIg8Gasomuq4O1u84zU0Ke0HWfsj9
         eGZ2LGJtYL9EJ4meky7y5mU/XIUxzcdKZLcR2gPGMidMPj60WvhyBoblZ63I0PJ+5vEe
         i8AVE6CZl/m5+Q1BD8Ws9JG2/TZfKIcLgIGaVAfC5DXhW9LV9mzHwGFY5YLVxplc1sBm
         0MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469102; x=1726073902;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMy7Qn1zaAc9/IMOhqSwwfWBQGHR6tB90Jwa2IOJx1I=;
        b=TOyEW3mlgrpKg/gh9MT9yd/OJPmsgrimioHm72C3RoVJ9xU6PzP9enFIfJLv6fJXUg
         PbNDBAWmKYNlFuDMaX0shkJX7T1qTO7qwcTMEjp11/lyobMCm+9Okefnt9+BE+XS1DMk
         gS0W/PUElVljwKMJFJapxDaUY1Dyr6HU5JVC6I8tFJNzFc4a6b/C3z/YXuqHzCIi69Ql
         G8DqYCUwLNBfmIMt+i7b/XXBKWaXXMH/Aj8NbK21wFSFSzKbww6zo5X3H4uj1zH6m+aQ
         DCKp0CMg4gmVCfejCJeOdIrnoBwpXL+Lt3quKJuhy2gJgicWbPscvqh1CFf7rKDu3q35
         wyDg==
X-Forwarded-Encrypted: i=1; AJvYcCUXgsSoLqJK8mYFB1gPjfRfysSw1pSCDtnDdNwje+E4jU0HNsJSs9i6PWsR2NgMOjMo1XAqGVrg0oUaIIZY9JD5@vger.kernel.org, AJvYcCVIwm1WOjNgNQ2I/m/Qs+29OOfrnhVJ2WIBhMIJEGGeDr4psTxa//n/qKXC43IuSHR7vObW5a5s6VXKgIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgPQxJKd6LWHkDwZR50LVldbwOpKDtb5hdKN2uHrtL655jXB7
	uqY7kdGEc3MLmo62rdLa5IslsjQFajurx0gc4d4vI9wxsNJ/3U5/
X-Google-Smtp-Source: AGHT+IG7/Tr7YqkobZcAU6j60F1cDj8e4643TsFFFzLwxv/IlYTNIaaf7jDZFBtBeELj1S/3WakAeg==
X-Received: by 2002:a05:6a21:3405:b0:1cc:e4be:5fae with SMTP id adf61e73a8af0-1cecf49ae7amr15745012637.7.1725469102108;
        Wed, 04 Sep 2024 09:58:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177853338asm1834607b3a.58.2024.09.04.09.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:58:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <78880ac2-f7fe-4dc1-b2cb-25942fb0cacf@roeck-us.net>
Date: Wed, 4 Sep 2024 09:58:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, SeongJae Park
 <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904005815.1388-1-sj@kernel.org>
 <20240904011840.973-1-sj@kernel.org>
 <whdjeq6qpccj6ms4wgiyjcnizht4nl5qbt7rbaeqfwzt67smxt@vvduwpqcuizl>
 <e83dedb2-89a3-4327-9a2f-610d3199f0e1@roeck-us.net>
 <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <54zu64vxrhdxr4wtmwbewga44shu4f7lz4ffx2hxhag46b56hn@qgrgfrb6mhbv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 20:36, Liam R. Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [240903 22:38]:
>> On 9/3/24 19:31, Liam R. Howlett wrote:
>>> * SeongJae Park <sj@kernel.org> [240903 21:18]:
>>>> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
>>>>
>>>>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>>>>
>>>>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>>>>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>>>>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>>>>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>>>>>> tree initialization code skips initialization of the mt_lock.  However,
>>>>>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>>>>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>>>>>> problem becomes celar when spinlock debugging is turned on, since it
>>>>>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>>>>>> as promised.
>>>>>>
>>>>>> You can't do this, lockdep will tell you this is wrong.
>>>>>
>>>>> Hmm, but lockdep was silence on my setup?
>>>>>
>>>>>> We need a lock and to use the lock for writes.
>>>>>
>>>>> This code is executed by a single-thread test code.  Do we still need the lock?
>>>>>
>>>>>>
>>>>>> I'd suggest using different flags so the spinlock is used.
>>>>>
>>>>> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
>>>>> causes suspicious RCU usage message.  May I ask if you have a suggestion of
>>>>> better flags?
>>>
>>> That would be the lockdep complaining, so that's good.
>>>
>>>>
>>>> I was actually thinking replacing the mt_init_flags() with mt_init(), which
>>>> same to mt_init_flags() with zero flag, like below.
>>>
>>> Yes.  This will use the spinlock which should fix your issue, but it
>>> will use a different style of maple tree.
>>>
>>> Perhaps use MT_FLAGS_ALLOC_RANGE to use the same type of maple tree, if
>>> you ever add threading you will want the rcu flag as well
>>> (MT_FLAGS_USE_RCU).
>>>
>>> I would recommend those two and just use the spinlock.
>>>
>>
>> I tried that (MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU). it also triggers
>> the suspicious RCU usage message.
>>
> 
> I am running ./tools/testing/kunit/kunit.py run '*damon*' --arch x86_64 --raw
> with:
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_SPINLOCK=y
> 
> and I don't have any issue with locking in the existing code.  How do I
> recreate this issue?
> 

You should find everything needed to reproduce the problem at
http://server.roeck-us.net/qemu/damon/

Please let me know if you need anything else.

Thanks,
Guenter


