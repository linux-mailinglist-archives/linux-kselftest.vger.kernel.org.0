Return-Path: <linux-kselftest+bounces-20176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47D9A47F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 22:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A828539E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30F205AB4;
	Fri, 18 Oct 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKhd7moi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061A2040AD
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283414; cv=none; b=oMObmxmempzVHSahNxqECgQGfMbVGFhbPHJnU/UY3E8igV21hidSnqXE72tzOwtPrZ5G28oKcsWEXdZdUZnkbprUKmcTs2rA83JkfpxHbeo6vpqtgxE9x0U8ExW6Co3TnFfoRO5EPNbRuB3qHSOnHqoggy/F6uyNg2rIpcd4JfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283414; c=relaxed/simple;
	bh=D0gG+t9UDD61HRs9Xmvdjbehwa6Ib/Pm8rzB8pZW0EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYS78QuPJg2PC8PfTw6VWk4H8PbW8MhjPG1Ed6GuwuAthtXhwxkaW9kudwTawNJ/gsFLi9L3U7pjJYPpHkUCWE+7AUdEn9j1mFzquNLDXoNIn1Pf7AgH34OBjaZVMFV4WSoajxkPSU6SX5MWwCih9YTJhdKYKAzMJTwNVo/cr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKhd7moi; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ab94452a7so58073439f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729283411; x=1729888211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Eb/bjYAyoVfge6Z8/C8u0lCt3wwAWzH/nDkL3fIlcc=;
        b=CKhd7moi/kgNIcp7p73xmbxVsuTTxjhrb6ndfjm8XLpGVrwQPgQW7F1CkNCXaXyLUr
         Y1gpOF4FqxRszFunbsICaNxl52XpiyG2yyuj5TyOJtsv4LFcMfV8rscVsD/gLtN8O/la
         gshBPVJ2R5u2IuSd6nh9g3nWK7tW/YaYzqsSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283411; x=1729888211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Eb/bjYAyoVfge6Z8/C8u0lCt3wwAWzH/nDkL3fIlcc=;
        b=gJLZEoguhiS40kUoQEsUq9nNs1ufGClO5rz8VRAyrxHlGe/LqW7UUXxgi4EWt+VwGq
         1+8wXAI9qDYX5tXZbDeUU7pseh1F0dEpijOD38bCUBEceKh6fkq00jJM+imb3p/mNhNr
         x3WawphMLSoCt+RLWFgkeIh21PyjvJWxkxqeEt8cFqm7nBdbnKk2fXHbqGov+BL0QGFC
         HX9ddT4Hx6hD/LYhJifXiRCPFE9C8s8QkIGtPmXzLzvGn1Vj58cgUov3VUXLZsNaKXrT
         INamZt8JVi18fpnP7ghNXqHwDJIw5kxdsM48t5fZ6PT61SJGa4E9qWczUlwOhVCJa2fX
         pSWg==
X-Forwarded-Encrypted: i=1; AJvYcCW92iyX31z2iylMQya1Q/8iYIHHoSD/iLXtq2FG9GpYy3Cg3PLsjw6Z+kJ/R9XcZMaINtFrh1ri+Ddoy09vtM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3aniyM77D0L+l05oIdT0rlOl46uP4Tu81IeOvlcjHhI2LAUE
	1g79VksmF7BwuvAd6RXjt25/Us2pce54rHWC8aYjprEwL9qJidsBxu9VrMz6owU=
X-Google-Smtp-Source: AGHT+IHtME0xh1bwpwUpGOSzAWusPxbbyxBma0gMXzwpjVl6rP5b2Bp9df1W13qPVhmxiPTyD4G2jw==
X-Received: by 2002:a05:6602:13d4:b0:83a:a25a:cfaf with SMTP id ca18e2360f4ac-83aba5c097amr415765139f.3.1729283410856;
        Fri, 18 Oct 2024 13:30:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c6b47asm595342173.162.2024.10.18.13.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 13:30:10 -0700 (PDT)
Message-ID: <59e6d89e-9b5b-4dd9-9c05-2acd0a51d3af@linuxfoundation.org>
Date: Fri, 18 Oct 2024 14:30:09 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Jeff Xu <jeffxu@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 pedro.falcato@gmail.com, willy@infradead.org, vbabka@suse.cz,
 Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
 <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
 <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
 <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk>
 <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
 <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/18/24 13:32, Jeff Xu wrote:
> Hi Mark
> 
> On Fri, Oct 18, 2024 at 11:37 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Fri, Oct 18, 2024 at 11:06:20AM -0700, Jeff Xu wrote:
>>> On Fri, Oct 18, 2024 at 6:04 AM Mark Brown <broonie@kernel.org> wrote:
>>
>>>> The problem is that the macro name is confusing and not terribly
>>>> consistent with how the rest of the selftests work.  The standard
>>>> kselftest result reporting is
>>
>>>>          ksft_test_result(bool result, char *name_format, ...);
>>>>
>>>> so the result of the test is a boolean flag which is passed in.  This
>>>> macro on the other hand sounds like a double negative so you have to
>>>> stop and think what the logic is, and it's not seen anywhere else so
>>>> nobody is going to be familiar with it.  The main thing this is doing is
>>>> burying a return statement in there, that's a bit surprising too.
>>
>>> Thanks for explaining the problem, naming is hard. Do you have a
>>> suggestion on a better naming?
>>
>> Honestly I'd probably deal with this by refactoring such that the macro
>> isn't needed and the tests follow a pattern more like:
>>
>>          if (ret != 0) {
>>                  ksft_print_msg("$ACTION failed with %d\n", ret);
>>                  return false;
>>          }
>>
> So expanding the macro to actually code ?
> But this makes the meal_test  quite large with lots of "if", and I
> would rather avoid that.
> 
> 
>> when they encouter a failure, the pattern I sketched in my earlier
>> message, or switch to kselftest_harness.h (like I say I don't know if
>> the fork()ing is an issue for these tests).  If I had to have a macro
>> it'd probably be something like mseal_assert().
>>
> I can go with mseal_assert, the original macro is used  by mseal_test
> itself, and only intended as such.
> 
> If changing name to mseal_assert() is acceptable, this seems to be a
> minimum change and I'm happy with that.
> 
>>>> I'll also note that these macros are resulting in broken kselftest
>>>> output, the name for a test has to be stable for automated systems to be
>>>> able to associate test results between runs but these print
>>
>> ....
>>
>>>> which includes the line number of the test in the name which is an
>>>> obvious problem, automated systems won't be able to tell that any two
>>>> failures are related to each other never mind the passing test.  We
>>>> should report why things failed but it's better to do that with a
>>>> ksft_print_msg(), ideally one that's directly readable rather than
>>>> requiring someone to go into the source code and look it up.
>>
>>> I don't know what  the issue you described is ? Are you saying that we
>>> are missing line numbers ? it is not. here is the sample of output:
>>
>> No, I'm saying that having the line numbers is a problem.
>>
>>> Failure in the second test case from last:
>>
>>> ok 105 test_munmap_free_multiple_ranges
>>> not ok 106 test_munmap_free_multiple_ranges_with_split: line:2573
>>> ok 107 test_munmap_free_multiple_ranges_with_split
>>
>> Test 106 here is called "test_munmap_free_multiple_ranges_with_split:
>> line:2573" which automated systems aren't going to be able to associate
>> with the passing "test_munmap_free_multiple_ranges_with_split", nor with
>> any failures that occur on any other lines in the function.
>>
> I see. That will happen when those tests are modified and line number
> changes. I could see reasoning for this argument, especially when
> those tests are flaky and get updated often.
> 
> In practice, I hope any of those kernel self-test failures should get
> fixed immediately, or even better, run before dev submitting the patch
> that affects the mm area.
> 
> Having line number does help dev to go to error directly, and I'm not
> against filling in the "action" field, but you might also agree with
> me, finding unique text for each error would require some decent
> amount of time, especially for large tests such as mseal_test.
> 
>>> I would image the needs of something similar to FAIL_TEST_IF_FALSE is
>>> common in selftest writing:
>>
>>> 1> lightweight enough so dev can pick up quickly and adapt to existing
>>> tests, instead of rewriting everything from scratch.
>>> 2> assert like syntax
>>> 3> fail the current test case, but continue running the next test case
>>> 4> take care of reporting test failures.
>>
>> Honestly this just sounds and looks like kselftest_harness.h, it's
>> ASSERT_ and EXPECT_ macros sound exactly like what you're looking for
>> for asserts.  The main gotchas with it are that it's not particularly
>> elegant for test cases which need to enumerate system features (which I
>> don't think is the case for mseal()?) and that it runs each test case in
>> a fork()ed child which can be inconvenient for some tests.  The use of
>> fork() is because that makes the overall test program much more robust
>> against breakage in individual tests and allows things like per test
>> timeouts.
> OK, I didn't know that ASSERT_ and EXPECT_ were part of the test fixture.
> 
> If I  switch to test_fixture, e,g, using TEST(test_name)
> 
> how do I pass the "seal" flag to it ?

Doesn't TH_LOG() work for you to pass arguments?

> e.g. how do I run the same test twice, first seal = true, and second seal=false.
> 
>          test_seal_mmap_shrink(false);
>          test_seal_mmap_shrink(true);
> 
> The example [1], isn't clear about that.
> 
> https://www.kernel.org/doc/html/v4.19/dev-tools/kselftest.html#example
> 
> Thanks
> 

thanks,
-- Shuah


