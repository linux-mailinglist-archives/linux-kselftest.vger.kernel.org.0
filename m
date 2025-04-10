Return-Path: <linux-kselftest+bounces-30494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4643A84DA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C6B189409B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 20:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1128D829;
	Thu, 10 Apr 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DdmOoAWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C0202F70
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315301; cv=none; b=eOEJTooLCxt6hBqTEBDy4J5FRBP1RvdK+Oz6Kbrvf0UQFjXDA6zkzjfWhWTPR22DYK11gNv6ZpdfXW495Eox8q3dbUyXveVKcBcr6zX1qw0J8mYefFDgLO2UHCg49CLfT3YMXOOCJKAPIaYQZyTmYQUHjz5QxXyh93u9lG6ERDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315301; c=relaxed/simple;
	bh=Ms/oOeKSEMXS64ZazNDVvDxHOh6Vnicgt8yf3H6sLTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBEyrFd54m9duQ+zldYex01pSR3x/i4xgsJXCRLtRX+Qi7Qtf6vKUcIxcto+9sZ5MtT/CN8jJHPoQZj2LFY87xGd+DzpVxBZffdy4H3jGI4na8/zYg1OW5IRc4q+1neMcGn6fSmE51SwUzGBCbFCldlFKDAmUCknVrgjIi94yYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DdmOoAWr; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85e73562577so120226539f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744315299; x=1744920099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTExV2/x6J7An5Mf72xYq5DzHVrycRROkLdZFeM6opQ=;
        b=DdmOoAWrcSZXGgiu+F3R4fDg6yz4wsWW4FB6JQrVhVTgO5fwKXzRyMLnsgk0uAOyJN
         0O+Ih4jQL3MmnEuu6iQYkQ5aD3JSOXGrfKyBJaOC1nS1LGJ1zOww4KhYi8+kHmlG/qoX
         2n5BbYA5r2ReXhQ5wymjPYoLhNYod81gP+pJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744315299; x=1744920099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTExV2/x6J7An5Mf72xYq5DzHVrycRROkLdZFeM6opQ=;
        b=PjtjvBIUSL4ywfvYSk+rwn9QZeiXcSldG1nODhFadaxmGnwur7qXCqSD4xMZXDPuDF
         HX1rfUHXSQkWPHF2jZwyW3vpmJI6dHlVquL/epGnAkEZl/FVANrRUGGg5/f0SBXe4OVO
         gTUond9mVxtCapNbh6NDiNnDC8deHmGxgWFyL6NTNFpPnRnIYXmgnNhhMG8dPw+Uv6Yj
         nJjE06MCtRfodDqvKCYF2/rmO033TcoK/xLrL7ZJz7m7ITrnLGP0GksH3H56GuITO0JN
         4xJFZkNLGBB5X4QZoY5naIv0FbxuixCgdBeccS5lwOgcnvxUO59CLAG0/LH4a+aUfWNP
         g0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVbg4Cy8kq5Vki4YAgCoPPcQpV0sID9Q+GyvrZfDMF6fmBNbiQSBNWs9gNlvr0yxonOyUtVaQ+gU3+K5YL8KdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAdxxAlUH5h4nzliNwnbp0ceSkZtcrLDbc+ZwYwz6Qjz5tMTt
	sL4+HjhRvwW6goCv+Pgz/I88TiFh+p+CFEXkzP0P1mIrQCknWaAQkoMC8I7QMEg=
X-Gm-Gg: ASbGncvXY19Ldr4oUxds9GuPKPnk6O/az5/75Uxg/gPTq64FBPArK6TaehSOFIVGMBB
	hkYukoIPM7VUNTcCQ5BLwzU4wnBn5GquBMM2vNODNJdiAwxiAcz2QnaZvmKGcjrky5Oyoy3IVIt
	voHpd8q+9lkgOQ/KE4IGyWAtk1S99VeLqtjt1kDg6/CM/hoQRTIZ4Zm5FrP/34qCDmwNsoLPpaS
	jKHNlhchSqqU2vGTXPjMahym7PwsIKDYJRe4Docr1LDNvkBcRMuUGtdTrLDPXFft3gyZJSBVK+Z
	6bD9HdnvkDMzrop0KYmCTEaJKFRH4Q2NKxrIXCkjnhChkvu8o70=
X-Google-Smtp-Source: AGHT+IEamSjMZo51Y/WT0FkpK3Y3HQ6M3NFrIP9orG53L5IoXNqmvwloYy4Vaei+SdIQbSb9eK1H3g==
X-Received: by 2002:a05:6e02:1806:b0:3d1:9999:4f62 with SMTP id e9e14a558f8ab-3d7ec1dc817mr2203095ab.2.1744315298542;
        Thu, 10 Apr 2025 13:01:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2ecebsm889447173.128.2025.04.10.13.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 13:01:38 -0700 (PDT)
Message-ID: <58b846c8-ce58-44b3-b93e-828fbe98b42d@linuxfoundation.org>
Date: Thu, 10 Apr 2025 14:01:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/32] kselftest harness and nolibc compatibility
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
 <04bf6bbc-d813-488d-9117-def19717b8b5@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <04bf6bbc-d813-488d-9117-def19717b8b5@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/25 09:19, Shuah Khan wrote:
> On 4/7/25 00:52, Thomas Weißschuh wrote:
>> Nolibc is useful for selftests as the test programs can be very small,
>> and compiled with just a kernel crosscompiler, without userspace support.
>> Currently nolibc is only usable with kselftest.h, not the more
>> convenient to use kselftest_harness.h
>> This series provides this compatibility by adding new features to nolibc
>> and removing the usage of problematic features from the harness.
>>
>> The first half of the series are changes to the harness, the second one
>> are for nolibc. Both parts are very independent and should go through
>> different trees.
>> The last patch is not meant to be applied and serves as test that
>> everything works together correctly.
>>
>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> ---
>> Changes in v2:
>> - Rebase unto v6.15-rc1
>> - Rename internal nolibc symbols
>> - Handle edge case of waitpid(INT_MIN) == ESRCH
>> - Fix arm configurations for final testing patch
>> - Clean up global getopt.h variable declarations
>> - Add Acks from Willy
>> - Link to v1: https://lore.kernel.org/r/20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de
> 
> Thank you. I am going to start reviewing the series. It could take
> me a few days to get through all 32 patches. :)
> 
>>
>> ---
>> Thomas Weißschuh (32):
>>        selftests: harness: Add harness selftest
>>        selftests: harness: Use C89 comment style
>>        selftests: harness: Ignore unused variant argument warning
>>        selftests: harness: Mark functions without prototypes static
>>        selftests: harness: Remove inline qualifier for wrappers
>>        selftests: harness: Remove dependency on libatomic
>>        selftests: harness: Implement test timeouts through pidfd
>>        selftests: harness: Don't set setup_completed for fixtureless tests
>>        selftests: harness: Always provide "self" and "variant"
>>        selftests: harness: Move teardown conditional into test metadata
>>        selftests: harness: Add teardown callback to test metadata
>>        selftests: harness: Stop using setjmp()/longjmp()
>>        selftests: harness: Guard includes on nolibc
>>        tools/nolibc: handle intmax_t/uintmax_t in printf
>>        tools/nolibc: use intmax definitions from compiler
>>        tools/nolibc: use pselect6_time64 if available
>>        tools/nolibc: use ppoll_time64 if available
>>        tools/nolibc: add tolower() and toupper()
>>        tools/nolibc: add _exit()
>>        tools/nolibc: add setpgrp()
>>        tools/nolibc: implement waitpid() in terms of waitid()
>>        Revert "selftests/nolibc: use waitid() over waitpid()"
>>        tools/nolibc: add dprintf() and vdprintf()
>>        tools/nolibc: add getopt()
>>        tools/nolibc: allow different write callbacks in printf
>>        tools/nolibc: allow limiting of printf destination size
>>        tools/nolibc: add snprintf() and friends
>>        selftests/nolibc: use snprintf() for printf tests
>>        selftests/nolibc: rename vfprintf test suite
>>        selftests/nolibc: add test for snprintf() truncation
>>        tools/nolibc: implement width padding in printf()
>>        HACK: selftests/nolibc: demonstrate usage of the kselftest harness
>>
>>   tools/include/nolibc/Makefile                      |    1 +
>>   tools/include/nolibc/getopt.h                      |  101 ++
>>   tools/include/nolibc/nolibc.h                      |    1 +
>>   tools/include/nolibc/stdint.h                      |    4 +-
>>   tools/include/nolibc/stdio.h                       |  127 +-
>>   tools/include/nolibc/string.h                      |   17 +
>>   tools/include/nolibc/sys.h                         |  105 +-
>>   tools/testing/selftests/Makefile                   |    1 +
>>   tools/testing/selftests/kselftest/.gitignore       |    1 +
>>   tools/testing/selftests/kselftest/Makefile         |    6 +
>>   .../testing/selftests/kselftest/harness-selftest.c |  129 ++

One more thing. You are missing kselftest_harness maintainers.
Please send v3 with the changes I requested for test name and
directory, and make cleanup?

The fixes to existing kselftest_harness compile warnings and such
can go in an upcoming rc and the others can go into the next release.

>>   .../selftests/kselftest/harness-selftest.expected  |   62 +
>>   .../selftests/kselftest/harness-selftest.sh        |   14 +
>>   tools/testing/selftests/kselftest_harness.h        |  181 +-
>>   tools/testing/selftests/nolibc/Makefile            |   13 +-
>>   tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
>>   tools/testing/selftests/nolibc/nolibc-test.c       | 1729 +-------------------
>>   tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
>>   18 files changed, 635 insertions(+), 1860 deletions(-)
>> ---
>> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
>> change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
>>
> 

thanks,
-- Shuah

