Return-Path: <linux-kselftest+bounces-14476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7429415B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBED1C22D08
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414181B583A;
	Tue, 30 Jul 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQrYj5Gd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489C145A18
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354545; cv=none; b=LzT1um2IktlgMHjUiJM73bsthDL2QYB0Yw5yOpLxUYKAvCpXQHzQ/T5vgQWG1KYaX7/OMM3uR5Xn6ZTxy9sr+hbGEcIrH7YrrF6g3qc1ndqzoLOk3hwjlPnAtOniIUoGQ3x06i9VVIPoT9D+jLnbgFvASBXS+R7FVMXsIzFiX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354545; c=relaxed/simple;
	bh=DtxHjqDr9/+H+qDRKYNts3sw180njy8mP9ePF4XWO1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT4Z7AUSQp1u/aTIumVf1nGhDyZJHYs5Hk5e0umrNbDHB2WSVIyu2xc54vPhQIu5rZHxp5RpcNgQ2JjLKZokDQ6X1BzdQ8gsG4Kl7Dv533Hevf/4lNbYe199EO1B4CZLEoOdb6Msm3er5q83rIin4ovzRxLFP3Y8IFv7BhcXBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQrYj5Gd; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81d05359badso29343939f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722354542; x=1722959342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mev30KGqnlBlpGHJGVl7Ejl2ZmKiLYlTI1eQYHYfd/A=;
        b=NQrYj5GdnTBU/FBCUuvC8oEPUunssa0f0hZablQFCROHCEXChOHkwG/svNaMrzc+1O
         5pC18Pz7gi2jRmZBT4BBPoxqNa+W4yIA+gKYfVCYlzOXDx+rnq9qHqFQpiDM3sgHwBsm
         QotdY0jAHKvZH3sY7KZt2IT/zcDgmb5XQwczE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354542; x=1722959342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mev30KGqnlBlpGHJGVl7Ejl2ZmKiLYlTI1eQYHYfd/A=;
        b=drTut7eqIofbWD/iMGniK3K5Twzm9V/PHpt+OM8lPaRjkZZuZGcB1t4lpPYsym9Ai2
         AljPvUFp7YwYUfo6HVnFrtMq4KBSH4rJ69ZVNpA+eWO2QbpyXrOL5vmUkwwDMeVqP7Z0
         QwutCmX380Udx2bnlmVmPiRuxmRTmpAHQR7mXKhSfAlBp/+/gfa77jkldhIIwHtDrRuG
         n9HDU35EinxyAolQfjTtmm/46Qqp7xjIbv9r6shI4S0s68XWHMEy4CSOo2dxhwnmfI8x
         BwvcIrVbB8Mohc8zUxQlGdKsPBrKlBNIE07ZuLsk3vPLG0jUrdMNsHh1B/uWLdO4zDsf
         kLjA==
X-Forwarded-Encrypted: i=1; AJvYcCX7d78FiNCr/MxLTLp2Bm8f8hpBOCMqV56l3nXUtlRVtVPNaNxuq0F+UEMVPE2LSKrYISu8b746ZTkPoXLHHvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJ/AciFMMOU7VOYd1L4b73gJQoiBtJevcF8iC8Gv0KYenNtpX
	9mYZo/wWwYbhXHuHaiKrwAEyyNqHpSlfBaLamZJLlu/w1cTtuDz5m3j160ZQkYs=
X-Google-Smtp-Source: AGHT+IHSqzeRA2h10jSoO0M9t1ndA9WyM4BSG0C7WwrpgC5e8zfRRY5o8xMkGyn0lWOFXE3YK+skwA==
X-Received: by 2002:a05:6e02:1d96:b0:39a:eb61:c02d with SMTP id e9e14a558f8ab-39aeb61c0ebmr82823505ab.1.1722354542422;
        Tue, 30 Jul 2024 08:49:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e7e79fsm48059655ab.4.2024.07.30.08.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:49:02 -0700 (PDT)
Message-ID: <0c2a5c8e-e48a-40f1-bc84-01669a5b8741@linuxfoundation.org>
Date: Tue, 30 Jul 2024 09:49:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <49108735-c776-4b6f-8264-62a827dd7b26@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <49108735-c776-4b6f-8264-62a827dd7b26@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/24 02:29, Muhammad Usama Anjum wrote:
> On 7/27/24 12:26 AM, Shuah Khan wrote:
>> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
>>> In this series, test_bitmap is being converted to kunit test. Multiple
>>> patches will make the review process smooth.
>>>
>>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
>>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
>>>              configuration options
>>> - Patch-3: Remove the bitmap.sh selftest
>>>
>>> Muhammad Usama Anjum (3):
>>>     bitmap: convert test_bitmap to KUnit test
>>>     bitmap: Rename module
>>>     selftests: lib: remove test_bitmap
>>>
>>>    MAINTAINERS                           |   2 +-
>>>    lib/Kconfig.debug                     |  15 +-
>>>    lib/Makefile                          |   2 +-
>>>    lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
>>>    tools/testing/selftests/lib/Makefile  |   2 +-
>>>    tools/testing/selftests/lib/bitmap.sh |   3 -
>>>    tools/testing/selftests/lib/config    |   1 -
>>>    7 files changed, 295 insertions(+), 354 deletions(-)
>>>    rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
>>>    delete mode 100755 tools/testing/selftests/lib/bitmap.sh
>>>
>>
>> Can you tell me how this conversion helps?
>>
>> It is removing the ability to run bitmap tests during boot.
>> It doesn't make sense to blindly convert all test under lib
>> to kunit - Nack on this change or any change that takes away
>> the ability to run tests and makes them dependent on kunit.
> Let's discuss this on discussion thread [1].

So - it doesn't mean that it is a done deal. Each patch will be
reviewed on individual basis. This test in particular clearly its
use-case right in the config which was deleted without understanding
it.

-config TEST_BITMAP
-	tristate "Test bitmap_*() family of functions at runtime"
-	help
-	  Enable this option to test the bitmap functions at boot.


This line above is the important piece of information which tells
you how the test is intended to be used.

1. You can enable this option and boot the kernel to check for regressions.
2. You can load the module on a running kernel to check for health.

Converting it to kunit drops support for these two use-cases which
are user-space regressions. You don't want to do that.
  
-
-	  If unsure, say N.
-
  config TEST_UUID
  	tristate "Test functions located in the uuid module at runtime"
  
@@ -2813,6 +2806,14 @@ config USERCOPY_KUNIT_TEST
  	  on the copy_to/from_user infrastructure, making sure basic
  	  user/kernel boundary testing is working.
  
+config BITMAP_KUNIT_TEST
+	tristate "KUnit Test for bitmap_*() family of functions"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the "bitmap_kunit" module that runs tests for
+	  bitmaps int the kernel making sure that there isn't any bug.

And this isn't complete even. I don'ty see tristate in here.

I responded to the thread that started this flurry of conversion activity
stating that converting tests without thinking through the use-cases
isn't what we want to do.

Reports aren't everything. The primary reason we have these tests is for
developers to be able to test. Reports can be improved and shouldn't
come at the expense of coverage and testing. Any patch that does that
will be NACKed.

thanks,
-- Shuah

