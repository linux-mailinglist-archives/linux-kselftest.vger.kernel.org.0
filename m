Return-Path: <linux-kselftest+bounces-13830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2AC933B8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E741C22A30
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750217F37F;
	Wed, 17 Jul 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4CKWnfCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BB1878;
	Wed, 17 Jul 2024 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213732; cv=none; b=VmsY6NLNFQ2rieQ6uePBnAddwMl+vWEeMMuQOVWyEBGG/Zrx4oViydDNj1TWr6Sf/yP1hFlRL8ZD3z5c7eciie48ah3FbqHJCeMjNDU/F58oJH/VqJ6OHwpLpgEWkLaukOarT39Rbka0RHwZvtePN/wbZjHnfGXM7hI7zrMqvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213732; c=relaxed/simple;
	bh=SJQNnmcv2NjxOJ7XJuOS/Xoz+HHb+3EHVbIUnJw2mRY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FvMecjayJKYXnXHd/dSf4FaNQRj7dL9V9KeqnSmGhySUPioVbJsBEINnXxE+BE86THEER1sLmRPMhE7VHg2wrPUYnvEs6TxSdW5fjmECCUqKHeAs1DXtFGjx/bzx5Sw4RAd7zXmezLZAh124bMtw17qvntjogHHU3Y4bhfcFb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4CKWnfCc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721213729;
	bh=SJQNnmcv2NjxOJ7XJuOS/Xoz+HHb+3EHVbIUnJw2mRY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=4CKWnfCcWsXXdY3gNCnIRx3W09uVQhBvuhwWUJYGkHs6Ukd2ihn0+X3odxTiZcyPH
	 ko8sXOZY//OPSfLfvdJTMUJGHN2Qjd70TKGqQcZeUMpok4xxALK9cWP94zgVxCiKEU
	 VophlLap/GYHE6hXRRu0Nkv1YLZKz6XSo5dWq0joLwJkZGA2UuHOGjjrEJgo6p1aUK
	 4YoHPMvxbBPXwgRg+Xo8X9HNwTT5kVw5RDZ3W7IzyXWLz8+mNKRxXc9obTWJQ/HlJ6
	 j5540TscnTPioiwgk1u1j1I6x/v5LVvcOmem5DW/hBzXWbGBSRR7SE3evjd5zzoj7X
	 Hyo3mALsGH09A==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B2B263780BC9;
	Wed, 17 Jul 2024 10:55:24 +0000 (UTC)
Message-ID: <fe3885c8-c3d4-44f1-91c1-fce8af3cb99d@collabora.com>
Date: Wed, 17 Jul 2024 15:55:18 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, davidgow@google.com,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: Converting kselftest test modules to kunit
To: Kees Cook <kees@kernel.org>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <202407150936.C32FE24CA@keescook>
 <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>
 <202407161005.CACE2E355@keescook>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202407161005.CACE2E355@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 10:59 PM, Kees Cook wrote:
> On Tue, Jul 16, 2024 at 01:11:14PM +0500, Muhammad Usama Anjum wrote:
>> On 7/15/24 9:40 PM, Kees Cook wrote:
>>> On Mon, Jul 15, 2024 at 03:09:24PM +0500, Muhammad Usama Anjum wrote:
>>>> Hi Kees and All,
>>>>
>>>> There are several tests in kselftest subsystem which load modules to tests
>>>> the internals of the kernel. Most of these test modules are just loaded by
>>>> the kselftest, their status isn't read and reported to the user logs. Hence
>>>> they don't provide benefit of executing those tests.
>>>>
>>>> I've found patches from Kees where he has been converting such kselftests
>>>> to kunit tests [1]. The probable motivation is to move tests output of
>>>> kselftest subsystem which only triggers tests without correctly reporting
>>>> the results. On the other hand, kunit is there to test the kernel's
>>>> internal functions which can't be done by userspace.
>>>>
>>>> Kselftest:	Test user facing APIs from userspace
>>>> Kunit:		Test kernel's internal functions from kernelspace
>>>
>>> I would say this is a reasonable guide to how these things should
>>> be separated, yes. That said, much of what was kind of ad-hoc kernel
>>> internals testing that was triggered via kselftests is better done via
>>> KUnit these days, but not everything.
>> I started investigated when I found that kselftest doesn't parse the kernel
>> logs to mark these tests pass/fail. (kselftest/lib is good example of it)
>>
>>>
>>>> This brings me to conclusion that kselftest which are loading modules to
>>>> test kernelspace should be converted to kunit tests. I've noted several
>>>> such kselftests.
>>>
>>> I would tend to agree, yes. Which stand out to you? I've mainly been
>>> doing the conversions when I find myself wanting to add new tests, etc.
>> lib
>> 	test_bitmap
>> 	prime_numbers
>> 	test_printf
>> 	test_scanf
> 
> Yeah, these would be nice to convert.
I've created TODOs on my end. I'll start working on conversion soon.

> 
>> 	test_strscpy (already converted, need to remove this test)
> 
> Yup, converted in bb8d9b742aa7 ("string: Merge strscpy KUnit tests into string_kunit.c")
> 
>> lock
>> 	test-ww_mutex module
>> net
>> 	test_blackhole_dev
> 
> I don't know these very well, but yeah worth looking into.
> 
>> user
>> 	test_user_copy (probably already converted, need to remove this test)
> 
> This is done in -next via cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
> 
>> firmware
>> 	test_firmware
> 
> This might not work to convert: there's a userspace half for testing
> firmware loading (see the kselftest side...)
> 
>> fpu
>> 	test_fpu
> 
> Seems reasonable.
> 
>> Most of these modules are found in lib/*.
>>
>> Would it be desired to move these to kunit?
> 
> Checking with the authors/maintainer is probably the first thing to do;
> check the git history to see who has been working on them.
> 

-- 
BR,
Muhammad Usama Anjum

