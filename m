Return-Path: <linux-kselftest+bounces-14498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E794231B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 00:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56411F2133E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343518E05A;
	Tue, 30 Jul 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T3tlHtdl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D321662F4
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379997; cv=none; b=LvpQD13pa/ni0sQmoaOxaZPIgJZw1yg0gS3syF65Laia8EE9h36zw53iVvucZTHNyBtkqqnx50Sq3nfVnOruSXNMzrSYE/c8jf7gZK9LoIWMnrvqh1bqvjc0s4+3loy+bxOfFdE0ArWHIaU1vvJMR3VQolDDGpIeNbgOEf6AKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379997; c=relaxed/simple;
	bh=/PslQQLZN/zdRD59UniGw0srRAMMcQ2Nh/BSv98frgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8fnLhy3RRM07Va6zFHXsuwKdI6cjhIzoynyvufUcgh6Gb85Ska6zxdi8WMX69q32mAhshid582IkpsAyrfBlGDOn7il2VsycR2tWgmgg7GcFZHhti9rvDiCKm0rc/JmNfSxIZBGiFtNeDia+XfuyoglALRijfTh3rsAhYa9I64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T3tlHtdl; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81f8ac6b908so28383439f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722379994; x=1722984794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPMoeXZqmKRQ4o+dKvqsFWwSIzXunsz7D3ow40LFnYU=;
        b=T3tlHtdl5DINj/s/f+RV5vPMiS5MAkwX0TKXZEhUt08YQbI258PG1bvWWeZnoO2m92
         NYsn8lRLUyfQmlMVA5NSzbfomfAnYi8vflMouCppHaWOqnjNC1xIkmEtDFhWw9XRwklr
         IH8op8xeX6wG3TBHCab3rTc4L5gwnMY0dHFOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379994; x=1722984794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPMoeXZqmKRQ4o+dKvqsFWwSIzXunsz7D3ow40LFnYU=;
        b=qrI/ocxBR791l9qgurKsP7m2Sx130w1poJQVIJfh3GZc5gkMAJ1sRb0vlE3lUmMmD7
         ZgEC/BaHwq4oholJw9cQ4Q+ekuvv6aGFlgE6/ZqFG7/jAcjdHp2JJinFGFMvxH2GZ+8M
         CrqgmnscaixiCqpGtay1+J48z+k483bJlmBX1FYqAX6siERdnJjHV4sfEVGay80BtHK9
         /hLmwlxMPbNah26VsTKDi/YlauVU4ZncHMjTRQoXYcxtxVw6tt62fzFigSUnCkYxNtn2
         3IW+lvRLsPsBQAj3I4WacwfozgmcE7dut4BLz0AIEiO5bBr11uIW/11BXO1YMZzs0TyM
         aV1A==
X-Forwarded-Encrypted: i=1; AJvYcCWzgk31I0hmmQ2p7gr9SqEyHzveQocS3g6qLUSql3ZMDW+eekgMndCUO1O+bgQos7Prlqknt/HAQJkqkAH0Ky8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MlIhC03+Xxvs43zI95SMmnOrKrUk25Kud6f0WBgedNTxfLzC
	fI44+vBXNh8DK+jul13EJgSnLDI/7+zj8j2YsOQQMf4p7FMAtcCKqU54i0nG96A=
X-Google-Smtp-Source: AGHT+IHxnD3eBdC2Bgi8Gl2hYh2pT25cjicNcqNiylFVhsrxU6nTTmpOoOUNvO58TXcK/TH8wZ8dwA==
X-Received: by 2002:a05:6e02:2185:b0:39a:e9a1:92a6 with SMTP id e9e14a558f8ab-39ae9a197a0mr97995675ab.4.1722379994441;
        Tue, 30 Jul 2024 15:53:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e97be2sm50338215ab.34.2024.07.30.15.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:53:14 -0700 (PDT)
Message-ID: <7f85416e-6e79-491c-902b-df6146928ff9@linuxfoundation.org>
Date: Tue, 30 Jul 2024 16:53:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting kselftest test modules to kunit
To: David Gow <davidgow@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 "kernel@collabora.com" <kernel@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
 <CABVgOSkbOr28j7yD-M0Lk3G6sJHey_QjpGdLZWBise1Tbeumkg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSkbOr28j7yD-M0Lk3G6sJHey_QjpGdLZWBise1Tbeumkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 23:23, David Gow wrote:
> On Sat, 27 Jul 2024 at 03:35, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/15/24 04:09, Muhammad Usama Anjum wrote:
>>> Hi Kees and All,
>>>
>>> There are several tests in kselftest subsystem which load modules to tests
>>> the internals of the kernel. Most of these test modules are just loaded by
>>> the kselftest, their status isn't read and reported to the user logs. Hence
>>> they don't provide benefit of executing those tests.
>>>
>>> I've found patches from Kees where he has been converting such kselftests
>>> to kunit tests [1]. The probable motivation is to move tests output of
>>> kselftest subsystem which only triggers tests without correctly reporting
>>> the results. On the other hand, kunit is there to test the kernel's
>>> internal functions which can't be done by userspace.
>>>
>>> Kselftest:    Test user facing APIs from userspace
>>> Kunit:                Test kernel's internal functions from kernelspace
>>>
>>> This brings me to conclusion that kselftest which are loading modules to
>>> test kernelspace should be converted to kunit tests. I've noted several
>>> such kselftests.
>>>
>>> This is just my understanding. Please mention if I'm correct above or more
>>> reasons to support kselftest test modules transformation into kunit test.
>>>
>>> [1] https://lore.kernel.org/all/20221018082824.never.845-kees@kernel.org/
>>>
>>
>> Please make sure you aren't taking away the ability to run these tests during
>> boot. It doesn't make sense to convert every single test especially when it
>> is intended to be run during boot without dependencies - not as a kunit test
>> but a regression test during boot.
> 
> Given KUnit tests can run at boot (and, indeed, do by default if
> enabled), I'd've assumed that this would be a good candidate for such
> a conversion. It does add the KUnit 'dependency', but I can't think of
> how that could be a problem. Is there a specific situation where
> enabling CONFIG_KUNIT would cause problems?
> 
>> bitmap is one example - pay attention to the config help test - bitmap
>> one clearly states it runs regression testing during boot. Any test that
>> says that isn't a candidate for conversion.
> 
> Again, most KUnit tests are effectively regression tests at boot, so I
> don't really understand what makes bitmap different. If it's just a
> matter of there being a different interface to it, that's surely
> something that we'll either be able to adapt to, or to have some
> wrapper/shim to maintain compatibility. I agree that having needless
> churn in formats is bad, but KUnit does seem the proper place for
> these sorts of tests.
> 

The problem is whether not kunit can test at boot time. The issue is
that this type of change removes a selftest which can be run without
kunit dependency thereby removing the ability to run these tests on
a running system without kunit.

This is absolutely necessary for testing on a running system to debug
or sopt check.

> If this isn't the case, do we need to modify the testing guide to
> mention this, as it definitely suggests KUnit for tests of in-kernel
> functionality like this.
> 

Please do. It was never the intent to convert all existing tests toi
kunit.

Repeating what I said on the bitmap removal thread:

This doesn't help people who want run a run bitmap test on a running
system. This is a wrong direction to go to say all testing has to be
done under kunit.

What happened to the effort to run selftests as is under KUnit? What
is the motivation to convert all tests to kunit instead of trying to
provide support to run kselftest under kunit environment?

We discussed this a few years ago as I recall. Let's work on that
instead of removing existing selftests and regressing current use-cases?

Can we look into providing:

1. running kselftest under kunit environment without changes
     as user space applications?

2. Leave kselftests alone so we don't weaken kernel testing by
    removing existing ones and making them dependent on kunit
    thereby removing the existing ability to be able run them on
    non-kunit kernels.


It isn't about kunit vs. kselftest. It is about overall kernel validation
and ability to test effectively by developers and users.

KUnit isn't ideal for cases where people would want to check a subsystem
on a running kernel - KUnit covers some use-cases and kselftest covers
others.

What happens if we are debugging a problem that requires us to debug on
a running system? Please don't go converting kselftest into kunit without
understanding how these frameworks are intended to be used.

Yes kselftest results need to be looked at. Write a parser which can
be improved. What you are doing is reducing the coverage and talking
away the ability to debug and test on running system.

Fix what needs to be fixed instead of deleting tests.

Think through the use-cases before advocating KUnit is suitable for
all testing needs and talking about being able to force or not force
people to use one or the other.

Reports aren't everything. The primary reason we have these tests is for
developers to be able to test. Reports can be improved and shouldn't
come at the expense of coverage and testing. Any patch that does that
will be NACKed.

I already nacked several patches and will continue to nack. Please don't
send me patches that remove existing kselftest tests and turn them into
kunit tests.

thanks,
-- Shuah





