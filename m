Return-Path: <linux-kselftest+bounces-14357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AC793EF9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECE11F21352
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A00884FAD;
	Mon, 29 Jul 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kRw4yzTL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9A2BB1B;
	Mon, 29 Jul 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240966; cv=none; b=Uo9uiranyQjqj5Hx/Cyk/MUDuMVtIP/Asq1Ey3ThDsUZD+px9+Um2Alu/XVm3fLu8iv2nQK7MfCwoQn3u0t62MeyMR6+CceX4nCVvcWD6h1wIp8By1OrBI8Zr2I7kWE72CmRKPaL++B0N6feSozM6wRPsOeG1Be5CSnfK21WtDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240966; c=relaxed/simple;
	bh=DIbZhU4x0f0ZVsYwZJvOoMsS4rYuWqqPQfV9Hlu9HD8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XSOdJ+VDJGM92u1Gcrhcc1V9dzilM3+t3pKG5DBS30QYLbqxzD2nmB/s9iNrPdLCavORUJ85VdaRhKTBhrV9zG8S+gEKcNLER37RSzPReZ/8EGSWDtttOVQymxxR3ufUUJYtfUaYEO6ahKDQHOp54RTvRe+Y+tga/fvhgbyKh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kRw4yzTL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722240962;
	bh=DIbZhU4x0f0ZVsYwZJvOoMsS4rYuWqqPQfV9Hlu9HD8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kRw4yzTLlS5VdK7z0d8O3flY9glZbEtlTq7DCzSVsgds8ZhN5rMj20rz2xlWRkwXR
	 Yoslwg8k5vzXnRb26NvS17cgpNeUoJpbUQeaAaV5otcb4Z4KqUDvidfe8j3m2Vro05
	 Y7woCOfr9deDuhLwXQ8Jy41qmDY2i4cxuU7mfswBDVJP6O8YdonAcf/C714uEQspwR
	 4Gbgo5KSWES26kzj6wcpF8zMSMsMW1BFZQeA9EgsZkiJOInmzKO+OkF2LOYur6PgCg
	 QcipVHyKHS6/fMRA7cNW21RakG5S2p87uzu8a4TMTDMsGCKbgMnYdBZCQQqF1Kpm8I
	 IzDwIvchXLCGA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 727853780480;
	Mon, 29 Jul 2024 08:15:59 +0000 (UTC)
Message-ID: <5d5b2042-f006-4c9b-b8a5-a28cbc3c7f5e@collabora.com>
Date: Mon, 29 Jul 2024 13:15:56 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kees@kernel.org, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Yury Norov <yury.norov@gmail.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <ZqU4FANdHOvpGc5t@yury-ThinkPad>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZqU4FANdHOvpGc5t@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/24 11:10 PM, Yury Norov wrote:
> On Fri, Jul 26, 2024 at 01:26:48PM -0600, Shuah Khan wrote:
>> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>>> In this series, test_bitmap is being converted to kunit test. Multiple
>>> patches will make the review process smooth.
>>>
>>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
>>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>>>             configuration options
>>> - Patch-3: Remove the bitmap.sh selftest
>>>
>>> Muhammad Usama Anjum (3):
>>>    bitmap: convert test_bitmap to KUnit test
>>>    bitmap: Rename module
>>>    selftests: lib: remove test_bitmap
>>>
>>>   MAINTAINERS                           |   2 +-
>>>   lib/Kconfig.debug                     |  15 +-
>>>   lib/Makefile                          |   2 +-
>>>   lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>>>   tools/testing/selftests/lib/Makefile  |   2 +-
>>>   tools/testing/selftests/lib/bitmap.sh |   3 -
>>>   tools/testing/selftests/lib/config    |   1 -
>>>   7 files changed, 295 insertions(+), 354 deletions(-)
>>>   rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>>>   delete mode 100755 tools/testing/selftests/lib/bitmap.sh
>>>
>>
>> Can you tell me how this conversion helps?
>>
>> It is removing the ability to run bitmap tests during boot.
>> It doesn't make sense to blindly convert all test under lib
>> to kunit - Nack on this change or any change that takes away
>> the ability to run tests and makes them dependent on kunit.
> 
> Hi Muhammad,
> 
> In addition to Shuah's and John's reasoning. This patch wipes the
> test history (git blame will point on you for most of the test),
When files are renamed, their history isn't lost. We just need to use
--follow option with git log to get complete history[1].

> breaks boot-time testing support, messes with config names and
> usability, and drops kselftest support for ... exactly, what?
AFAIU the kselftest wasn't detected the test results that's why I started
thinking on which could be best way to detect if any failure happens in
this test. Triggering the test from kselftest doesn't grantee the test it
would pass every time until we check results. For this kind of in-kernel
testing, kunit is best suites. Please find earlier discussion [2].

> 
> KUNIT engine here doesn't improve on readability, neither shorten
> the test length, to my taste.
> 
> If you'd like to contribute to bitmaps testing - I'm all for that.
> This is the very core and performance-sensitive piece of kernel,
> and any extra-coverage is always welcome.
> 
> But I think the best way would be either adding new cases to the
> existing test, or writing a new test, KUNIT-based, if you like.
> 

[1] https://git-scm.com/docs/git-log#Documentation/git-log.txt---follow
[2]
https://lore.kernel.org/all/327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com

> Thanks,
> Yury
> 

-- 
BR,
Muhammad Usama Anjum

