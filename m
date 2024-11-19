Return-Path: <linux-kselftest+bounces-22284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B421E9D29CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CEC28119D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DE1D12E0;
	Tue, 19 Nov 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AavyAmE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03C1D04B9
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030618; cv=none; b=BAfiMOp4QuSgylS3b+FNBGfbMhVyEAyWZDlq6I2Xkz0OyI4owC408iL7tgfM4Ol9qE8mYEW57AqYW1AeHQco0p0rAfdh3DhTFk1JKrNr0O9iql69QsxyrCY/B+/Sg/xqzFbKmg/4E5t1QCMIGwxXvJuqq789LNshEBOQy09t+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030618; c=relaxed/simple;
	bh=K9vebJQz2YUwsc3MlNv4Uh8s8GbHzdib/lumO19eM5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcUVdS40wjeSdIS7TAVU/z3MFQy7fOKKZH2aAWm3bBT1Z+LniZ+Bxs42FxRUT30vXsvUse614ZoxszrJPuoE0XX1Fs+gdPNQaFZSLlRQzICrRaEp5f1JuCH2UUTN0Xn0EkHXtUCqeMt3DT0kDWNk9nCfMn5tAE5/fZM8Fe03zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AavyAmE4; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a76fd74099so4144245ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732030615; x=1732635415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bASOjfd+3IMg9ai8XUpmf9zDNUW1MPcgjDnaB/+DdHA=;
        b=AavyAmE4tgv+i5AcWrFHyumZt4DCiZqX+3Mop7ANTmhH6ZsOImCHqWLzeLTfhA/y+t
         V+9bkI09bCFLT7jWZwzQwm8zmeHBoSL+ksKiSurWk5HKInHVYRma1juazyIa/4RXVgmw
         D//A/EM2vGJvoH4RsKz2oogqRdB72Uj3cJOOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030615; x=1732635415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bASOjfd+3IMg9ai8XUpmf9zDNUW1MPcgjDnaB/+DdHA=;
        b=D0w6u5qtMXkmVp6ebVLm+xlldZ8CtU3+Zn4bEogIVST76iYvje9RFd9m8BTwl5qlAt
         aex3q5bc8P4XsXslcI/TXxbN+VoznctealIuyNqUPDp0KGd8EtPqvqzle++d1w0vxHwz
         ZQDEcmYmUxWKPDleAO3I1p1CpXXtg9BBtl6WHQmrsy47k60WNnet/z4yXp+Xtze2XrGt
         2uDN3+hCucwVnSpW8OdX9oifMWycxhlLFSTu+MfoApyA4O++COHnt+HVD3DudlB0PeYf
         y5wmTUmjKiPcvKROoJehFWA3ps1EuL5RV2llKs7mNGjhc05dzkrIb3vWVd5z6cwhofhD
         8e3w==
X-Forwarded-Encrypted: i=1; AJvYcCU/vjM/ASj64UY+Z85SBPHwk8tMpioQmKhJ2q6Jgcb1gepsGW1EFd2h89uBImJeIxB5rJemTnDyWi/jIBfgEWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqha0QPddF+O/jeybwRomxBNnOOmay4uboMRLrZ8soj2otii1G
	axvuQ8/gjDhFqTDnNGHf9Uoy8cSntESV+dIzyZiGc6nnyiJA5W2tbH2TlAEXWVI=
X-Google-Smtp-Source: AGHT+IHAN7wQzV37tcwUMlZ8r82+eSQ1ur4oGMRmuNc7Oy1d4b50PR5o1Q2myqNlp07Q9SDtCB6ivA==
X-Received: by 2002:a05:6e02:1a44:b0:3a7:44d9:c7dd with SMTP id e9e14a558f8ab-3a74800e6admr197277675ab.6.1732030615241;
        Tue, 19 Nov 2024 07:36:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a74807d6cdsm26165835ab.19.2024.11.19.07.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:36:54 -0800 (PST)
Message-ID: <ce995a53-7fbd-43a3-be4d-70fc57b07212@linuxfoundation.org>
Date: Tue, 19 Nov 2024 08:36:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KUnit update for Linux 6.13-rc1
To: Kuan-Wei Chiu <visitorckw@gmail.com>, David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <589ea100-ee1b-4a37-8f18-a25d86fdb082@linuxfoundation.org>
 <ZzvwEUIVs0M+/3Yu@visitorckw-System-Product-Name>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZzvwEUIVs0M+/3Yu@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 18:55, Kuan-Wei Chiu wrote:
> Hi Shuah,
> 
> On Mon, Nov 18, 2024 at 12:19:50PM -0700, Shuah Khan wrote:
>> Hi Linus,
>>
>> Please pull the following kunit update for Linux 6.13-rc1.
>>
>> kunit update for Linux 6.13-rc1
>>
>> -- fixes user-after-free (UAF) bug in kunit_init_suite()
>>
>> -- adds option to kunit tool to print just the summary of test results
>>
>> -- adds option to kunit tool to print just the failed test results
>>
>> -- fixes kunit_zalloc_skb() to use user passed in gfp value instead of
>>     hardcoding GFP_KERNEL
>>
>> -- fixes kunit_zalloc_skb() kernel doc to include allocation flags variable
>>
>> diff is attached.
>>
>> Tests passed on my kunit repo:
>>
>> - Build make allmodconfig
>>
>> ./tools/testing/kunit/kunit.py run
>> ./tools/testing/kunit/kunit.py run --alltests
>>
>> ./tools/testing/kunit/kunit.py run --arch x86_64
>> ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
>>
>> thanks,
>> -- Shuah
>>
>> ----------------------------------------------------------------
>> The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:
>>
>>    Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.13-rc1
>>
>> for you to fetch changes up to 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1:
>>
>>    kunit: tool: print failed tests only (2024-11-14 09:38:19 -0700)
>>
>> ----------------------------------------------------------------
>> linux_kselftest-kunit-6.13-rc1
>>
>> kunit update for Linux 6.13-rc1
>>
>> -- fixes user-after-free (UAF) bug in kunit_init_suite()
>>
>> -- adds option to kunit tool to print just the summary of test results
>>
>> -- adds option to kunit tool to print just the failed test results
>>
>> -- fixes kunit_zalloc_skb() to use user passed in gfp value instead of
>>     hardcoding GFP_KERNEL
>>
>> -- fixes kunit_zalloc_skb() kernel doc to include allocation flags variable
>>
>> ----------------------------------------------------------------
>> Dan Carpenter (2):
>>        kunit: skb: use "gfp" variable instead of hardcoding GFP_KERNEL
>>        kunit: skb: add gfp to kernel doc for kunit_zalloc_skb()
>>
>> David Gow (1):
>>        kunit: tool: Only print the summary
>>
>> Jinjie Ruan (1):
>>        kunit: string-stream: Fix a UAF bug in kunit_init_suite()
>>
> The patch [1] intended to address the UAF issue in kunit_init_suite()
> is not correct and does not actually fix the problem. A v2 patch [2]
> with the proper fix has been sent.
> 

Hmm. I picked this up because David reviewed it and added his
Reviewed-by. I would like David's feedback on which patch we
should be taking.

> 
> [1]: https://lore.kernel.org/lkml/20241024094303.1531810-1-ruanjinjie@huawei.com
> [2]: https://lore.kernel.org/linux-kselftest/20241112080314.407966-1-ruanjinjie@huawei.com

David, Can you take you let me know. I don't mind redoing the PR
for Linus. I just have to know which patch to take.

thanks,
-- Shuah

