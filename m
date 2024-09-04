Return-Path: <linux-kselftest+bounces-17092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E596AE1E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DE8B22833
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF8FBF0;
	Wed,  4 Sep 2024 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7Ac36Ls"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390A1EC01C;
	Wed,  4 Sep 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414873; cv=none; b=Il8JNnotsQGfBskdVfcUV6GhNr7w9doH3ubSHFQsTVFDX4WPQPbqscgmzE790pL66ocNlrBYetwr+qDt3ohekv/35OsAkxZo/x+KmWJxnicpdWNMcrFla7ciX7rWEo46bmd8T96gGZlmFVYY7phd+TwGBJJ1K/HRuPDo8YDs3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414873; c=relaxed/simple;
	bh=8b/nagbitnKcWOzyEcnGY06sbCkaMXu1Gh0SIeftmXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqlqI2GYB7iIXKkiOKaJsvpVqoQvgaoJ3bm4UG7CGc75bJbJKSuuhBeDPxvuQyLaqDAwdtKZ6Zq7P2OuOJY9LmJU1c/monMc1zgjaZ0w5espBYMcPypxESI2UqBQ6NoMrM8VEkUSYmv9GjVJYUm7Sp8jm/L0mCTk/WIfVFS3SaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7Ac36Ls; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71774dcd09aso897284b3a.0;
        Tue, 03 Sep 2024 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725414871; x=1726019671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CisdtnKEerpy0QokjP5pH46AQQjjuc5fegYZvSOfX6A=;
        b=e7Ac36Ls+6KMGvx5+7/szUQMoSKSCG7759oUYc7x0SxMikOLhW2OCTA1Z8rQYTfBQ+
         LcSUsMtoOxwad2f/R3lPsA0EH+JjzbczwwvDWkiFQkI4pt9rCO/Vls7luQUnGP0Y4eAU
         kAEoUseDblEblFIgcDWz0xMZGo9aslXuJBdosWIjdVq2QkpQbzfMZWHunktuy26lrEDl
         HjyDzPvP4jUynqE+3JuGR72SoL3nlA4flYhJP++XjyPlgVFce8QhdpCcVwQY5qq1DMa4
         +DAfFoqOGOm54ufxAhN9gUqPkEAlyPgbXxjXwq6xpza4u4swr3rSpQWuY5Q5leMRVv1h
         7psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725414871; x=1726019671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CisdtnKEerpy0QokjP5pH46AQQjjuc5fegYZvSOfX6A=;
        b=J7UJrs2tHVjQL8FYevI704mQf/zD6YiQ4vuH0grA01+9ZNTbfhRidVI+xDwYEgfXcA
         Vk7QkNwjWxtGeIacgTL7xAUmIzqiLR7eqpXEsRb980tKQZ2Y+0la8iM1ffMGHAKs5fXL
         jbqqZMA+2Z2zSZgSjFkCUJjvivznwaTCsr7G7rNwq9+7oo70fvMOjepUJ4FLFV+tu1Jk
         sFBfrus5xMjXTEN1lSiMUBn8jUKevvj8ny3bwiLIjU48jwDgYL35kOYAqjkiXSIQ0Kkl
         /5TlOCV+UNu4Fm8nSFx4aDohEx24Q2UiTxl3tJrQYvUjXVlOy8qWhb/JptTOQMAc8QUr
         ZsLA==
X-Forwarded-Encrypted: i=1; AJvYcCUf6IsATKQ/OjYRP2q1SzdGluWRT320NUE5c6T9+evC22yaj6OEA4SbfnyHJ83tKU7Xh387fNgCfKTTaXi6BPx+@vger.kernel.org, AJvYcCWm6mvDxhRZlj7I/Tmzd+853kl3kChs+QlB4oCw6gI4Kgom0K7C7qjHEgfhVRsgp37nGAAlcjGCv+5JioE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93hOutITSE+6RHpnLG9dwDR5pWaxrqIgEOoCkfdQBW35u5IZR
	dBXYpoBjkN0NsMQNbbRdj3/ZoxtvGaTr60WbjjgJ7+ZgknM8+h9qQ1cx+w==
X-Google-Smtp-Source: AGHT+IHXYOi8OP9XYA1Qdvbzpe21teNaeNAJcKIyj5+H8sosQACX2TLwSECTQpwAHdzo0peFxAzi9Q==
X-Received: by 2002:a05:6a21:114d:b0:1c6:fc7d:5546 with SMTP id adf61e73a8af0-1cece5d166dmr14010663637.37.1725414871203;
        Tue, 03 Sep 2024 18:54:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea684bdsm4118095ad.254.2024.09.03.18.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 18:54:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ab03b853-07c5-4997-8983-68e547e3c873@roeck-us.net>
Date: Tue, 3 Sep 2024 18:54:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for
 MM_MT_FLAGS-initialized maple tree
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>, damon@lists.linux.dev, linux-mm@kvack.org,
 kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240904011840.973-1-sj@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240904011840.973-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 18:18, SeongJae Park wrote:
> On Tue,  3 Sep 2024 17:58:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
>> On Tue, 3 Sep 2024 20:48:53 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>
>>> * SeongJae Park <sj@kernel.org> [240903 20:45]:
>>>> damon_test_three_regions_in_vmas() initializes a maple tree with
>>>> MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
>>>> mt_lock of the maple tree will not be used.  And therefore the maple
>>>> tree initialization code skips initialization of the mt_lock.  However,
>>>> __link_vmas(), which adds vmas for test to the maple tree, uses the
>>>> mt_lock.  In other words, the uninitialized spinlock is used.  The
>>>> problem becomes celar when spinlock debugging is turned on, since it
>>>> reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
>>>> as promised.
>>>
>>> You can't do this, lockdep will tell you this is wrong.
>>
>> Hmm, but lockdep was silence on my setup?
>>
>>> We need a lock and to use the lock for writes.
>>
>> This code is executed by a single-thread test code.  Do we still need the lock?
>>
>>>
>>> I'd suggest using different flags so the spinlock is used.
>>
>> The reporter mentioned simply dropping MT_FLAGS_LOCK_EXTERN from the flags
>> causes suspicious RCU usage message.  May I ask if you have a suggestion of
>> better flags?
> 
> I was actually thinking replacing the mt_init_flags() with mt_init(), which
> same to mt_init_flags() with zero flag, like below.
> 
> ```
> --- a/mm/damon/tests/vaddr-kunit.h
> +++ b/mm/damon/tests/vaddr-kunit.h
> @@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
>                  (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
>          };
> 
> -       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> +       mt_init(&mm.mm_mt);
>          if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
>                  kunit_skip(test, "Failed to create VMA tree");
> ```
> 
> And just confirmed it also convinces the reproducer.  But because I'm obviously
> not familiar with maple tree, would like to hear some comments from Liam or
> others first.
> 
Same here. That is why I gave up after trying MT_FLAGS_ALLOC_RANGE and
"MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU". After all, I really don't know what
I am doing and was just playing around ... and there isn't really a good
explanation why initializing the maple tree with MT_FLAGS_ALLOC_RANGE (but not
MT_FLAGS_USE_RCU) would trigger rcu warnings.

Guenter


