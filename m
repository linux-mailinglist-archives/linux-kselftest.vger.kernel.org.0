Return-Path: <linux-kselftest+bounces-39333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D3AB2CD38
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353BC721A63
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABBC247DE1;
	Tue, 19 Aug 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmHoZpff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1822AE84
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632807; cv=none; b=neGmqqyDIJvK/TFzkpo1c8d9Z7yP8DT2o6hS+RZvo+EapSFD9bIPTbquBYoGyr9iHfc1F4zQIFNZ7DUokZHuAp0f5wNE6Cl3NJ0mbMxu2hSVPf9El1tK0FykBDqLiXJNvns3upHESHCVHCBsH1b9ReKCKuI2vgiV6WwyrKEWD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632807; c=relaxed/simple;
	bh=Reh6woerY8Lv+48u12oUpzwM9/rHYkBlDCEVqO22IGI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BmOSIIpFaWDSxeriEjJ91EU6cwgGHrVRw5YuehIUQjhYJZXUq2gT8GyO598rG3VcjoXfjA//ZdxGWrcorzofRk6tq0+eCVNvCAEx3qTmGAWEdtS7AQ21TBV3oR0QpjvnqEW6LztXuJ90PahZI5Oa6Kbyid5VZ/xMvk9wRqWbRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmHoZpff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755632804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRCPrFoaBBwpzmKxk6u0SdsGAQYGGoKwbnSPzMSJ69w=;
	b=PmHoZpffccQzgsp3EmT92MeQMyPqgUAyvM3rQ47cPfgdEoE0dt8dqs6Ykc43j+Cq2uOH65
	F6JKgHCaZO/oNiNWpYhRzTpmX5aQAR6zzkEN2tIv0m0Tqte0w21VQHnuOEPpwf42D0Svvp
	wehiT8mPgYtCUVa9HtFbmWFkcm07hSg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-24A_PImxMROKUoudU-m6qA-1; Tue, 19 Aug 2025 15:46:27 -0400
X-MC-Unique: 24A_PImxMROKUoudU-m6qA-1
X-Mimecast-MFC-AGG-ID: 24A_PImxMROKUoudU-m6qA_1755632787
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e931cdd05a8so5927756276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 12:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632786; x=1756237586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRCPrFoaBBwpzmKxk6u0SdsGAQYGGoKwbnSPzMSJ69w=;
        b=FNplVFL7A4N1iAucRg0wKaApUfIFV4RpC8wDIJQnaGLBZ9MGnsUyrjqLqyA+8PGr7d
         Ahh4s4NWwOpD1AcINiUlSbOu1LugXYE08XHqL3rr7wVNVGviBn/4PQp34uyQEMkNHv64
         yBRAU+zEKUhejvTTJk4N4nAEvWNO4PKinRyCw3YGmYusN1c7EB07QWCkmSJ8rd0bv0vy
         9+jdc47YE9ZibYQjs95iTqeObONcYgB6aRnEU4bAuU+aDW13Mps9W8NH6nJugzkMrvWl
         NoWzApMDwtrvbZu816Z6CSETHJv+zx8999ftkpol4xdlSQKw82qpPX4ZYgj6MXn2lhfD
         5ASg==
X-Forwarded-Encrypted: i=1; AJvYcCUtGkdYVZv9F7xzRB6D+Eg3370xUHWtkKkSFn+B7C6Q5G99Cnojjeeq2SxiOjoCc3Up+Kl6YjA6K48EKUqoQIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5k3xZgIz7hiUeZ9skPglwH7QK1YXTbuP682l9zy3e3FSbUuA
	JpWT3aARCeLkuY9fL/o+cMupRN/7cJW1zSjiEWGFcrFaBJRy93EARMEOSILZGrDIC1VgXBFNqUZ
	PdgxZ8O4MiBvrlJc9DhpkqQ8HnJIOftoKfI335F2W9qhgkRvtvYrMi+jC7b5NxSUq7wWc74SjCM
	/6sg==
X-Gm-Gg: ASbGncuWUfd1KktIr1LR8bfra766CIEcocL0neqZQpjaVX6MYj6fDala0WD6LkOOARy
	uTIcINklUZJQOHxvukwnPg5NaKq8x4p1QUB+5/CUtmPXCz1xJdcge/3lsP0AMvyJeN/bQLv2Mx8
	p4UnP8s4+Zo/Zct3TDFHfdIUOTseGE7f+MS0Orgy9zikISCwmW2QuqevYToLcy1Td2Tmvtt2jfm
	E+mBwcHXmasA4gw2IiG1bBzEH2hxqn/f9jrKlCvPAUcg83wNBpTHBS+Y7C8KTdLNmxQCoiO6Sm1
	Mi794JMjMM4kXuq1+bVGFpvWkthJrGUsNfAuxU42GoVyj9pCPFXNxvlCpQ1Wdun0b3Deam0wrfH
	J56M3c9bFbQ==
X-Received: by 2002:a05:6902:1a45:b0:e94:e1e5:930a with SMTP id 3f1490d57ef6-e94f67885e1mr308980276.50.1755632786491;
        Tue, 19 Aug 2025 12:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/yApBWBUl4/+8VqJ2IuV7TcAO9fqPR9IL1lHy26m2I23JsUFfrLO85d8Yg/YAOv2348jagA==
X-Received: by 2002:a05:6902:1a45:b0:e94:e1e5:930a with SMTP id 3f1490d57ef6-e94f67885e1mr308948276.50.1755632786097;
        Tue, 19 Aug 2025 12:46:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ee7b9ec3sm554363276.17.2025.08.19.12.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 12:46:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <191b64e0-c15d-48ec-a947-08f2afd76cb5@redhat.com>
Date: Tue, 19 Aug 2025 15:46:24 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix some futex_numa_mpol subtests
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kselftest@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250810222742.290485-1-longman@redhat.com>
 <336a1a43-54ac-4f53-b3a8-5e46f6d45359@igalia.com>
Content-Language: en-US
In-Reply-To: <336a1a43-54ac-4f53-b3a8-5e46f6d45359@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 8:22 AM, André Almeida wrote:
> Hi Waiman,
>
> Em 10/08/2025 19:27, Waiman Long escreveu:
>> The "Memory out of range" subtest of futex_numa_mpol assumes that memory
>> access outside of the mmap'ed area is invalid. That may not be the case
>> depending on the actual memory layout of the test application. When
>> that subtest was run on an x86-64 system with latest upstream kernel,
>> the test passed as an error was returned from futex_wake(). On another
>> powerpc system, the same subtest failed because futex_wake() returned 0.
>>
>>    Bail out! futex2_wake(64, 0x86) should fail, but didn't
>>
>> Looking further into the passed subtest on x86-64, it was found that an
>> -EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
>> because the node value test with FLAGS_NUMA set failed with a node value
>> of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
>> because the supposed node number wasn't valid. If that memory location
>> happens to have a very small value (e.g. 0), the test will pass and no
>> error will be returned.
>>
>> Since this subtest is non-deterministic, it is dropped unless we
>> explicitly set a guard page beyond the mmap region.
>>
>>
> I had proposed a refactor of the futex selftests[1] and I spotted the 
> same issue with the memory out of range test. My solution for this was 
> to create a "buffer zone" with PROT_NONE to ensure that I would have a 
> invalid memory access:
>
> /*
>  * test_harness_run() calls mmap(..., MAP_SHARED, ...), which can create
>  * a valid access memory region just bellow the mmap() issue here. Then,
>  * the test for "Memory out of range" will fail because it will succeed
>  * accessing the memory address after the range. To avoid this we create
>  * a "Buffer zone" with PROT_NONE between the two mmap's.
>  */
> buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | 
> MAP_ANONYMOUS, 0, 0);
>
> [1] 
> https://lore.kernel.org/lkml/20250704-tonyk-robust_test_cleanup-v1-13-c0ff4f24c4e1@igalia.com/
>
That should work too.

I am fine with either my patch or your getting merged as it should 
address the test failure that I had encountered.

Cheers,
Longman


