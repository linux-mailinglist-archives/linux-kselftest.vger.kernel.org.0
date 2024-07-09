Return-Path: <linux-kselftest+bounces-13410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701492C67D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 01:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EBBB21372
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 23:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006B18005C;
	Tue,  9 Jul 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKgVVo53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C113DB92
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566922; cv=none; b=lB9egS4QH/juIgb8nEv/tCx1QpfmlKQtPhvKpGtbEI6ldaF4nyaWAkwZHAfvG/1rVg44ykfHW8PHnu2tjcVqAt6+pVt0sNd503fyOO1Hnnw0Djz31fkjUDXWhTxbnZoi8LMKHpjTWJaDsMy1pp6v5/ZYQcd3dtjue3OETNEdxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566922; c=relaxed/simple;
	bh=xdCnr56OuqPlvWKQlDFwlk443RCYNdLU+1M4K1ccl6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvR9/jNyKOJdnS0F9B6JZFb8AQBN/T6diXrRErpo2XGwsMa5NndVHKZqsAukspgs3U6QjB4ZLvHGjIq7wkCtOq4JslsbwJKdCAEQa/Mb/jHjMSlUtHJM73p5PplrWNUK34XO1YLUxYFXIz26aQmgaDRQ4klDbhQRJyVq4yWUmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKgVVo53; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-38b4276d643so282295ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720566920; x=1721171720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlgU1fdu7thu5cfqXl2G2BTvQ4EnATZJ3QFE+8p9PZw=;
        b=GKgVVo53i9NPRUXUAteKBqPCLAQF7oSqI9h8ACc5MDNZe6JnGafKW2ZJysdhKUBr+R
         qvQj1hn0oSPKqGXsSTUAJNV0qQsB4ePFClkZkx81G1hcdA27yKBSr1ngmADWsxKyRrD+
         TTa7ciqeCjVvr+hoywbXeyMFJd7Xp2f+QHih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566920; x=1721171720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlgU1fdu7thu5cfqXl2G2BTvQ4EnATZJ3QFE+8p9PZw=;
        b=RCAA0NM6WqTewxkQl3yfF4O2l1hTyygx8QU9M8uZwWjsg8rjTSAbd5ksUxYrI64J79
         etczzTjVC3X076BHSzEUUkhHPLK13pOAGEXutVjNn7WC2VylJYwIUPS3XKjZPl4reTma
         +JwnPfIBN3Yq+1naR1F6FUSXQCzkHmI3B/RnnzUzt9dRqBYGNsKfWBNAy7JaLumJq6Zv
         yDSW9Z1W4vWkdd7M/wtC0mzSnVojU4CB8iofLswe1c8f8T4wZBECjGbONZFxjH4wvYor
         II7sZEnL1CmAMDb0NC6VeoNVVoCPsiHlrutP7AfzYTc7T/fe0AlNKS8yaGre36Gj6EwT
         wO9w==
X-Forwarded-Encrypted: i=1; AJvYcCXK9gpG6LYzcGCDwRRlVzdkboJNBuD0RpVANvVGzC7kA7tfGvJgSLXxDRr2chavtfQSqohPXw5F5KZShuiZ1AjOzhPB3goYzS1dGP77wkGB
X-Gm-Message-State: AOJu0YzTZ3zDx5iU6Nql7uowB0z+771AvrU2HJzI4d4UuCHr2e+Mx5u0
	bEp2bT8S1YBoTvoCOmSwlqLtgScFMwG6qp1LiKfdBPsAmQijhbLGeK/agfxqmvM=
X-Google-Smtp-Source: AGHT+IFVDdAds7MWO8IlspwtWaVh7rNNP2ClDNoot6td8R2fz9nyj/+vsj68PO2yV6pnSbmjFiF+mA==
X-Received: by 2002:a92:cdac:0:b0:38b:3d5c:bcb0 with SMTP id e9e14a558f8ab-38b3d5ccb9amr28429655ab.0.1720566920286;
        Tue, 09 Jul 2024 16:15:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4be43493sm6384255ab.71.2024.07.09.16.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:15:19 -0700 (PDT)
Message-ID: <4bc3373a-6afc-497d-aed8-c6cd138df46d@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:15:19 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kselftests: vdso: vdso_test_clock_getres: conform
 test to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
 <20240610054129.1527389-2-usama.anjum@collabora.com>
 <7b020209-3b20-48f4-92fb-099d80aee625@linuxfoundation.org>
 <87e6beea-4618-4a5c-a883-42ef64a2d584@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87e6beea-4618-4a5c-a883-42ef64a2d584@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 02:17, Muhammad Usama Anjum wrote:
> On 6/12/24 1:32 AM, Shuah Khan wrote:
>> On 6/9/24 23:41, Muhammad Usama Anjum wrote:
>>> Conform the layout, informational and status messages to TAP. No
>>> functional change is intended other than the layout of output messages.
>>> Use kselftest_harness.h to conform to TAP as the number of tests depend
>>> on the available options at build time. The kselftest_harness makes the
>>
>>
>> How does converting to kselftest_harness help with available options ay
>> build time? Can you explain?
>>
>> I am not seeing any value in converting this test to the harness? I want
>> to see a better justification.
> 
> Before:
> ./vdso_test_clock_getres
> clock_id: CLOCK_REALTIME [PASS]
> clock_id: CLOCK_BOOTTIME [PASS]
> clock_id: CLOCK_TAI [PASS]
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> clock_id: CLOCK_MONOTONIC [PASS]
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> 
> Here is the output of the test before this patch. The test output test
> names and if they are passed or failed. It doesn't output information
> related to error when it occurs. I wanted to convert it to standard format
> by using kselftest.h where we can get the error related information as
> well. But as the number of tests depend on how many of CLOCK_BOOTTIME,
> CLOCK_TAI etc are defined, static counting is difficult. Test harness is
> best suited for this. Output:
> 
> ./vdso_test_clock_getres

The reason I don't want to take this patch is if you run the test
using the recommended method:

make -C tools/testing/selftests/vDSO/ run_tests you will get the
TAP output because lib.mk runtests framework takes care of this.

or

make kselftest TARGETS=vDSO will do the same.

Please don't send TAP conversions for individual runs. You will
start seeing duplicate TAP output which will make it unreadable.

Run the test using make -C or make kselftest TARGETS before
investing time to concert to TAP. I am not going to take TAP
conversions patches if make -C or make kselftest TARGETS
shows TAP.

thanks,
-- Shuah


