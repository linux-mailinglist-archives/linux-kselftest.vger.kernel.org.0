Return-Path: <linux-kselftest+bounces-14557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9794341A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676E62838CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A81BBBC3;
	Wed, 31 Jul 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UB39etOI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A81A4B2B
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443176; cv=none; b=hsgWClB377D+0IwxiqOBYjk/GEHmtUOT6ICw72q92b3TfrnzQaWbvQJKOyMlWAbTiWn4UCnA3pxMNe8dPtu2QRMM5FUgA24AhU3/NJV6PA352Qog/779PzwWyToRU3eYThVJZyAE6En3QJG/kJAsR4P7Pv3S6brOIu2E7kH+a8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443176; c=relaxed/simple;
	bh=Xl4TiW5SeD2WM656o31Xvn4ZJhLVboZMA3CyRCM21cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H12e/KTz0C+lWxCQIXYpQQt2wd022q/H9AsCnHp6PlrVOMNsIL2pVv2LkqwFXO0xnBU40Du/+mKh3JBkYIVbk2SlXfmR3jCBDH1k7P2UbC5IolbotF0JuXSk5zAqeHsKI2aa5St6nEZol6FL+9xQ9hws+WRXmdBADtYX3duZAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UB39etOI; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f932ede28so31613439f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722443174; x=1723047974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESfT6J5DiPicCIoTYmPg83+VN4FfF1ZZyIzlRD0R3PM=;
        b=UB39etOIjsbSzJ83Y9GL3JmAro5r69+LcrWO/DoNtLNSBrDVMoj5nCRqGRgZCfGqo6
         ArNmKpv2fpenptxpVih0XPNpfOJJfF0TKBWa7colrmAMBXqpfppb7fHWyDCyHEKVniPx
         fX6annwYOw6epi+yf8lXJ1/lb+ZxJFhtGwaqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443174; x=1723047974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESfT6J5DiPicCIoTYmPg83+VN4FfF1ZZyIzlRD0R3PM=;
        b=HebCfg2UcyF/6J34GrU6w0lnBEqtRCpCmBLVAqnf23Mc+BZ3eDEFh/Yk7DbgVMBRFH
         rmHFGLrvViszINrH3Lr0K9OGm0X9t/WelpYI1f9HiuimSpo3d3n6vSqWtHDXC2JhoYgB
         awHjAwbtEX4mGAjAGdF1IEoMejXt/C9cziERX0c0s3HK13GzS8Ucw0nEC0RAHUgqQaCo
         vckAU55LvD0lxGkRtZ/mDM6qZtu3fXLEQS8dUUd3TCHX/JXmJJPFjROpw6DyffaIXFf1
         FlI/R20FLCtDo8Pt+xBhR5prXUXjQj+reOcQwgrMuYHW52y1ExgAl0Y4+vb5OISkdJhY
         buDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUID7sCNHlbrmO/RgrAiY9giG8bhhttUzbWBDW0/Y59+ym7GP4ql8x2eQR6ZxY5Pr+mlI9M9FsHPV8hw4VF6KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHBeQH3AvsNCwS5V+Fx3JxDuIrBKpFQLas9W/n3Wnvt5/Arfy
	iQ9JYCi+67b1F7u86vZsQL/u7fUHfqgIiHUrvrnlTuNILIycdDt8SNrWeUMyw8E=
X-Google-Smtp-Source: AGHT+IGiwZHilRDwsGrCq4IEcRdtEcK65HuE5W0tixLUguurZs7WFY535o9hhl7dIy3NatXECDK8wQ==
X-Received: by 2002:a6b:7b4d:0:b0:81f:c609:df28 with SMTP id ca18e2360f4ac-81fc609df84mr145755339f.3.1722443173857;
        Wed, 31 Jul 2024 09:26:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc3cea7sm3238717173.153.2024.07.31.09.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:26:13 -0700 (PDT)
Message-ID: <c41b8745-d7c9-4ff7-93df-3dd771c30a56@linuxfoundation.org>
Date: Wed, 31 Jul 2024 10:26:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: David Gow <davidgow@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <49108735-c776-4b6f-8264-62a827dd7b26@collabora.com>
 <0c2a5c8e-e48a-40f1-bc84-01669a5b8741@linuxfoundation.org>
 <CABVgOSmTtox4kdEFHwkZR=N0iHQY3tpugWSFU0exYzHOHYJp_Q@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmTtox4kdEFHwkZR=N0iHQY3tpugWSFU0exYzHOHYJp_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 21:06, David Gow wrote:
> On Tue, 30 Jul 2024 at 23:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/29/24 02:29, Muhammad Usama Anjum wrote:
>>> On 7/27/24 12:26 AM, Shuah Khan wrote:
>>>> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>>>>> In this series, test_bitmap is being converted to kunit test. Multiple
>>>>> patches will make the review process smooth.
>>>>>
>>>>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
>>>>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>>>>>               configuration options
>>>>> - Patch-3: Remove the bitmap.sh selftest
>>>>>
>>>>> Muhammad Usama Anjum (3):
>>>>>      bitmap: convert test_bitmap to KUnit test
>>>>>      bitmap: Rename module
>>>>>      selftests: lib: remove test_bitmap
>>>>>
>>>>>     MAINTAINERS                           |   2 +-
>>>>>     lib/Kconfig.debug                     |  15 +-
>>>>>     lib/Makefile                          |   2 +-
>>>>>     lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>>>>>     tools/testing/selftests/lib/Makefile  |   2 +-
>>>>>     tools/testing/selftests/lib/bitmap.sh |   3 -
>>>>>     tools/testing/selftests/lib/config    |   1 -
>>>>>     7 files changed, 295 insertions(+), 354 deletions(-)
>>>>>     rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>>>>>     delete mode 100755 tools/testing/selftests/lib/bitmap.sh
>>>>>
>>>>
>>>> Can you tell me how this conversion helps?
>>>>
>>>> It is removing the ability to run bitmap tests during boot.
>>>> It doesn't make sense to blindly convert all test under lib
>>>> to kunit - Nack on this change or any change that takes away
>>>> the ability to run tests and makes them dependent on kunit.
>>> Let's discuss this on discussion thread [1].
>>
>> So - it doesn't mean that it is a done deal. Each patch will be
>> reviewed on individual basis. This test in particular clearly its
>> use-case right in the config which was deleted without understanding
>> it.
>>
>> -config TEST_BITMAP
>> -       tristate "Test bitmap_*() family of functions at runtime"
>> -       help
>> -         Enable this option to test the bitmap functions at boot.
>>
>>
>> This line above is the important piece of information which tells
>> you how the test is intended to be used.
>>
>> 1. You can enable this option and boot the kernel to check for regressions.
> 
> Converting the test to KUnit _does not break this_. You can still
> enable this option and boot the kernel to test for regressions if it's
> a KUnit test.
> 
>> 2. You can load the module on a running kernel to check for health.
> 
> This is where the disagreement lies in my mind. While you can do this
> with KUnit, the kernel does have to have been built with CONFIG_KUNIT
> enabled (either built-in or as a module).

Right. It appears the confusion is coming in because "What's the problem
enabling CONFIG_KUNIT". The question is would you recommend enabling
CONFIG_KUNIT in distribution kernels - there is a confusion that
unit testing can be enabled in all environments.

The answer is no. Running tests should not require should not require
CONFIG_KUNIT - I would call this not disagreement, but not understanding
the role of unit (open box) vs closed box testing.

We want to users to be able to run as many tests possible without
needing to enable KUnit or other config options to verify kernels
they build. KUnit is a tool for kernel developers to verify - it
is a unit testing framework that is where it brings value.

It isn't a replacement for selftests and other tests. I am not happy
to seer tests that are supported as kselftests be changed to now
require KUNIT to be enabled.

thanks,
-- Shuah

