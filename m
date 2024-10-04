Return-Path: <linux-kselftest+bounces-19001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5A98FCD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 06:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279FBB226ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 04:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0F4D59F;
	Fri,  4 Oct 2024 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsVVIcCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB19475;
	Fri,  4 Oct 2024 04:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017535; cv=none; b=KHjw+Bt38wQpUQsbaNAhJHQ9tgaZ+JVYIGE3K4aKdx3hmWJMbzwOQiaYdgTaTZ8+XWzdifXOD5er/94RfCNbkhdZL7ByULwlVfXBhFoh6CN+h469NrICWskg5IfSQpDaRs51hcrPRxuHtbwD5urWMgRFlTnocv4b4vh/heoYqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017535; c=relaxed/simple;
	bh=ejP5C1AYJ38+W4qMlT4oQl7oYkorNke0H7+dJlDwP6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdVglQgQSAevMRgK+P6+X8a2w3j0Uj7H6LL92ajvBLRT7JFHE2rSSLRuNpcfoqceIgyHulqHuTbCsvB4a4Xlqlu45huWDKHglqSVFuJIM28GSxRTIHjm9OSI4ltZ41k7MarZchXyxJA8s9Yfm0D9IAtFBqg6ACKSNxRPYA7QmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsVVIcCr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1189783a12.0;
        Thu, 03 Oct 2024 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728017533; x=1728622333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q1IhYiz8eeuWL6vj4hcFX9KVycQYMBC7VkQ15SzUmc=;
        b=jsVVIcCrgBqEZaTrZYn/0tSw3EW0go88Znwg8lW//W6edIVSj6/MCiZiC8uM8Bt5kd
         i5K42DI4SqvtG/nIzQoKMFvLPhuUWtMh0WQGmRX5E8y2mYasQfUSNdd37+4z9oMo0xoj
         cHpLnmWV+i1qlIanJEJXFtetGuZRj6moknjqpvG3sHVxxIL8zmEFDMOlZvlkHTPs+7Wc
         PCmBukrv8TQxVYJai6otJ9D0MOsXrOrt0J2bRo12KfEiTh9w/0YAx/M08aF4K7XX/k0S
         qK1b0CtLukUW8ncqEXp44Zi1qqSAq7Mao1M86zmR7g7GrHotODFV2vUpw45vukIZSZ/J
         obtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728017533; x=1728622333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q1IhYiz8eeuWL6vj4hcFX9KVycQYMBC7VkQ15SzUmc=;
        b=pjtZgrYbN40pK8sAD9f3kRYIPBjKs+49pPrCiEyNfLVcFxWg17kGU74RqGOHqFU8qn
         OoO6NUhJQkTofEwH8hO400+cphV5t8OlREeodjzEn7sSGwGXCjMWCXSbT0kbCt7DP258
         0UQNNARVM1X8BxzV1ybp/doPQHS34FFpWSntCDQ99hD4/RWExI30vmTkMZxnjOJy2ow7
         68Y+PUhQCeKp7Q81U7SSo85VHsTntiwChiPNnnhIdVoY6MZv9+ZTSQt4JjDBbdkYObqo
         91e9uX0jHeOGMGr176XH50/ONA2c5XHzPY8p9PEfVKbNCVcG7w9CSP2+Q3wHy9yvN1LX
         XGxw==
X-Forwarded-Encrypted: i=1; AJvYcCUTxvIMHWPxHcYkoI1U7anp/O/MkejA76tZEaARvV/Yc8NW9jyC0A5h+8GchmIVkXbeWJSkpGHh6H9FNRu4OZL9@vger.kernel.org, AJvYcCUaJnqp1G/NBZWbCVbkYt8usB7EaOVyiXkcPTJv+MmmfQoz7nW93iKpucN3g4WWrP7+oAWKpSNsaCiS@vger.kernel.org, AJvYcCV+B2mfKVrPuadZdcJ5mkffv1EeDSW6CJDzydohORvToNpHVpo5jU6wF70Ru4CkvhnYHd4KHU/iXTa/k+6I@vger.kernel.org, AJvYcCVIxOO0upR4knWLuQMUAw5/VVAzqQs4ZzMeewTD/u6DbAEZGIoaAbGgyYwM3rcSOXZS8DFYG8YPskZF@vger.kernel.org
X-Gm-Message-State: AOJu0YzfidzG1+ZsxoI/T3qtTP/OynPW7rEVReLhGDOG8Sc6aoXIT0Ea
	4zy9ZowFDQmikVAeGOokenVe+IFTmFQrBVBYq0r99+yai27em037
X-Google-Smtp-Source: AGHT+IGm4NXB0dLG/zomksnWRf8sdveV8TTKKHWO87H38b6WLnVZwIb3Yj3+5q4BwboQFIMAi1N3mw==
X-Received: by 2002:a05:6a20:9f8f:b0:1d6:8f33:fb64 with SMTP id adf61e73a8af0-1d6dfa2495emr2264224637.3.1728017532628;
        Thu, 03 Oct 2024 21:52:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df2bacsm2360585b3a.170.2024.10.03.21.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 21:52:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb1e0119-6e3e-4fd2-92ea-3fec18f5843d@roeck-us.net>
Date: Thu, 3 Oct 2024 21:52:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with
 struct clk_parent_data
To: Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J.Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Daniel Latypov
 <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240718210513.3801024-1-sboyd@kernel.org>
 <dcd8894f-1eb6-4b5c-9e6f-f6e584c601d2@roeck-us.net>
 <6f5a5b5f-71a7-4ed3-8cb3-d930bbce599b@linuxfoundation.org>
 <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net>
 <4216b852-11a2-41ae-bb01-5f9b578ee41b@roeck-us.net>
 <879831a8-2039-4cdb-bce2-aefdeb7ab25f@linuxfoundation.org>
 <da260b77-2ecb-4486-90cb-6db456d381ef@linuxfoundation.org>
 <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net>
 <4a8abb5f501279de7907629f4dd6be24.sboyd@kernel.org>
 <3e1de608-008c-4439-acd2-647a288dcdc0@roeck-us.net>
 <cd31493888acc2b64a4986954dfa43ae.sboyd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <cd31493888acc2b64a4986954dfa43ae.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 17:42, Stephen Boyd wrote:
> Quoting Guenter Roeck (2024-10-03 17:25:37)
>> On 10/3/24 16:46, Stephen Boyd wrote:
>> [ ... ]
>>> That DT test has been there for a few releases. Is this the first time
>>> those tests have been run on arm64+acpi? I didn't try after sending the
>>> patches and forgot that the patch was dropped.
>>>
>>
>> Previously I had the affected tests disabled and never tracked down the problem.
>> Since the problem is now spreading to additional tests, I finally tracked it down,
>> that is all.
> 
> Ok great. Good to know this isn't a new problem. Thanks for tracking it
> down.
> 
>>
>>> How are you running kunit tests? I installed the qemu-efi-aarch64 debian
>>> package to get QEMU_EFI.fd but passing that to the kunit.py run command
>>> with --qemu_args="-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd" didn't
>>> get me beyond the point that the EFI stub boots linux. I think the
>>> serial console must not be working and thus the kunit wrapper waits for
>>> something to show up but nothing ever does. I haven't dug any further
>>> though, so maybe you have a working command.
>>>
>>
>> I run all tests during boot, not from the command line. I also use the -bios
>> command but don't recall any issues with the console. I specify the
>> console on the qemu command line; depending on the qemu machine it is either
>> ttyS0 or ttyAMA0. The init script then finds and selects the active console.
> 
> Can you please describe how you run the kunit test? And provide the qemu
> command you run to boot arm64 with acpi?
> 

Example command line:

qemu-system-aarch64 -M virt -m 512 \
      -kernel arch/arm64/boot/Image -no-reboot -nographic \
      -snapshot \
      -bios /opt/buildbot/rootfs/arm64/../firmware/QEMU_EFI-aarch64.fd \
      -device virtio-blk-device,drive=d0 \
      -drive file=rootfs.ext2,if=none,id=d0,format=raw \
      -cpu cortex-a57 -serial stdio -monitor none -no-reboot \
      --append "kunit.stats_enabled=2 kunit.filter=speed>slow root=/dev/vda rootwait earlycon=pl011,0x9000000 console=ttyAMA0"

That works fine for me. Configuration is arm64 defconfig plus various
debug and kunit options. I built the efi image myself from sources.
The root file system is from buildroot with modified init script.
kunit tests are all built into the kernel and run during boot.

>>
>> I'll just keep the affected tests disabled on arm64 for the time being.
> 
> We should skip the tests on arm64+acpi, which is similar to disabling
> but not exactly the same. There will likely be more DT overlay usage in
> kunit and so that will lead to more test disabling. Skipping properly is
> the better solution.

Sure, but having those tests fail all the time doesn't help either.
I'll re-enable the tests if / when they are skipped.

Thanks,
Guenter


