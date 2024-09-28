Return-Path: <linux-kselftest+bounces-18529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E361E9890D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 19:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD80B21424
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0381428F4;
	Sat, 28 Sep 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID/zCEpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4644A1B;
	Sat, 28 Sep 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544717; cv=none; b=sS1zHiJsHfEHIFkbGMZ0m9GXi6sp//Nw7jZAzYBZe5ULZ1TMPgta7+bQVlzXyRuALWhv9nvsAMJY41eKyE3QQrapuI6g6OPFB4EF1W4hFidAWh1G75GzGKa6B1ycMft+YQWB7pDFuMQRCxd1R567PSXbv7MbgPYE8/U9kWIcPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544717; c=relaxed/simple;
	bh=4KytN89vYLBy4nlPzKBXl21EPUQuhG4fvUp+cjUZbBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l4uy+TG2cKfatvBj1VpBCWSD/OaQQjlCAso++TQ8l2SCClx2CQQQmRWWLFH9myn+qW4wk+UN+agmY5IGrG0C7ouHn6uq/XMn9/GJ4NFpPFrNm4hmvldgTZOkUpBdrQM+fD8ffbg1AsYPMmbxACNIOQDg4Q+wn+0RN+FTbZJQCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID/zCEpe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e2855479so2246840b3a.1;
        Sat, 28 Sep 2024 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727544715; x=1728149515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gTaVBMb+pj0JNKyLVpxJl9EhZHILxudabuXGeg3+OhA=;
        b=ID/zCEpe1NBLuyRQa6NgulQ0o8ejxMbE9HVLpbv9H9s9H0lYCuHM1lB6t3NGvlv5bw
         yikE6pkG7IOM7qSXgYo4/LiyDgzmNv2T52e3+OtNn4PS4d3y72BNcLvtLQpnIZwEXl8z
         8IS7E5Z5FCR1EhIat4qC+MpNxkagrjrqMhf/BGrv2292KRceJwpVfy6lS5C/f4NZiKDK
         qirB91EB6E2yvEkNVg7v14fbPEAG5+VTNIqIaTJHx94RmZcM9kCefvF6/I7hRVXr7kyr
         TxmpRAjAgZK8vyU7gX8y/VFLkkWITeuN4ePKvOe4f+6/TlD8DioE6PZFLegbcw6X4oZ9
         ofGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727544715; x=1728149515;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTaVBMb+pj0JNKyLVpxJl9EhZHILxudabuXGeg3+OhA=;
        b=jS9hvUxPrlfAblcitfY7WZzgLuYJ1ROuN+CznboQjuqOMLA3+x2FEEqnrR/8vheBdB
         21weaBfImw+feky+yb7eV+IpGoqf9f00Mwnc/najTytiAINr/7w74Iif4QzsqnOn4/jN
         thgQ4cv+llMVS5agxOgjqjz0+PgOy+IkcVj+nC24V4H1Pcb3Q4VSeR6h+wHJC7jv/rOp
         Pe+eGpmA5m2re0u1ZTMIONL3iraUvKGj3ZlgsYmOC34qvIvCqTUdb+qcmbxItKOCyQU9
         9EoXmEGNhAGuT7iO4ITdMUefJ7qTOyJH5YLloEV/Zt5AUH1f6Dm4cJU6BFzymp2MfIIp
         9zuA==
X-Forwarded-Encrypted: i=1; AJvYcCVCSaVMcCRxac6YwOnXEisO0G/l+0+29Ly8njjPB7k0fAI5polM+Mn20HM+nh/lftxxQ3StKLzlTZ0u@vger.kernel.org, AJvYcCWMgsl/k+LkrvnBQSf+XdCSNGGobjGa83ui3rDr9g91v8y3aDAYubdvWTyhiEYWoRLnotzAHFGZlC2E@vger.kernel.org, AJvYcCWQijlSxjSItFmvSJaawoje6/SMZ0kwWcs1IpfMtBHpd4MvMb2f067IKQ5HwnGFH4chpSv332A2Bq0p6Pno5FkP@vger.kernel.org, AJvYcCXaxHxRpPVxfNG5unOEj1/Z4vgCDO5atunkxCG02gD3tQhdLhOVcS6kGPL0DhNZYDtKmZlEd8FsSyMuTB66@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwxgu9hUuDX5BJNKAPBCrQbsbbEpBXYwvm/epJJPD/4nJ0R+IH
	4pCSXoHkVBLgPrVg2ziwvhwZjKXT0Kel2+YsiwS4P9olYGdjCUyrkzKw3g==
X-Google-Smtp-Source: AGHT+IEegVniNcFlYkEcpGrlOruMefYvhdkG6RAmpo+kjp/LIpyW+xGKe4IXejIyN3ms205DzHCGzw==
X-Received: by 2002:a05:6a00:1915:b0:718:9625:cca0 with SMTP id d2e1a72fcca58-71b25f3aec8mr11784402b3a.7.1727544714793;
        Sat, 28 Sep 2024 10:31:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bb0c8sm3363110b3a.51.2024.09.28.10.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 10:31:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4216b852-11a2-41ae-bb01-5f9b578ee41b@roeck-us.net>
Date: Sat, 28 Sep 2024 10:31:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with
 struct clk_parent_data
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <skhan@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 patches@lists.linux.dev, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Daniel Latypov
 <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20240718210513.3801024-1-sboyd@kernel.org>
 <20240718210513.3801024-9-sboyd@kernel.org>
 <6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net>
 <a339ec8c-38f6-425a-94d1-ad69b5ddbd88@roeck-us.net>
 <dcd8894f-1eb6-4b5c-9e6f-f6e584c601d2@roeck-us.net>
 <6f5a5b5f-71a7-4ed3-8cb3-d930bbce599b@linuxfoundation.org>
 <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/27/24 17:08, Guenter Roeck wrote:
> On 9/27/24 13:45, Shuah Khan wrote:
>> On 9/27/24 10:19, Guenter Roeck wrote:
>>> Copying devicetree maintainers.
>>>
>>> On Thu, Sep 26, 2024 at 09:39:38PM -0700, Guenter Roeck wrote:
>>>> On Thu, Sep 26, 2024 at 09:14:11PM -0700, Guenter Roeck wrote:
>>>>> Hi Stephen,
>>>>>
>>>>> On Thu, Jul 18, 2024 at 02:05:07PM -0700, Stephen Boyd wrote:
>>>>>> Test that clks registered with 'struct clk_parent_data' work as
>>>>>> intended and can find their parents.
>>>>>>
>>>>>
>>>>> When testing this on arm64, I see the error below. The error is only
>>>>> seen if I boot through efi, i.e., with "-bios QEMU_EFI-aarch64.fd"
>>>>> qemu parameter.
>>>>>
>>>>> Any idea what might cause the problem ?
>>>>>
>>>> I noticed that the new overlay tests fail as well, also with "path '/' not
>>>> found".
>>>>
>>>> [Maybe] answering my own question: I think the problem may be that there
>>>> is no devicetree file and thus no devicetree root when booting through
>>>> efi (in other words, of_root is NULL). Would it make sense to skip the
>>>> tests in that case ?
>>>>
>>>
>>> The problem is that of_root is not initialized in arm64 boots if ACPI
>>> is enabled.
>>>
>>>  From arch/arm64/kernel/setup.c:setup_arch():
>>>
>>>     if (acpi_disabled)
>>>         unflatten_device_tree();        // initializes of_root
>>>
>>> ACPI is enabled if the system boots from EFI. This also affects
>>> CONFIG_OF_KUNIT_TEST, which explicitly checks if of_root exists and
>>> fails the test if it doesn't.
>>>
>>> I think those tests need to add a check for this condition, or affected
>>> machines won't be able to run those unit tests. The obvious solution would
>>> be to check if of_root is set, but then the associated test case in
>>> CONFIG_OF_KUNIT_TEST would not make sense.
>>>
>>> Any suggestions ?
>>>
>>
>> Would it work if these tests check if acpi_disabled and skip if it isn't
>> disabled? It might be low overhead condition to check from these tests.
>>
>> acpi_disabled is exported:
>>
>> arch/arm64/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
>> arch/loongarch/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
>> arch/riscv/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
>> arch/x86/kernel/acpi/boot.c:EXPORT_SYMBOL(acpi_disabled);
>>
> 
> I don't think that would work. Looking through the use of acpi_init,
> I don't think that of_root is always NULL when acpi_init is false; that
> just happens to be the case on arm64 when booting through efi.
> However, even arm64 has the following code.
> 
>          if (acpi_disabled)
>                  psci_dt_init();
>          else
>                  psci_acpi_init();
> 
> While psci_dt_init() doesn't set of_root, it does try to do a devicetree
> match. So there must be some other condition where acpi_disabled is set
> but of_root is set anyway. I just have not found that code path.
> 

I ended up disabling all affected unit tests for arm64. I'll do the same
for other architectures if I encounter the problem there as well.

Unfortunately that includes all clock unit tests because the tests requiring
devicetree support can not be enabled/disabled separately, but that can't be
helped and is still better than "mandatory" failures.

Guenter


