Return-Path: <linux-kselftest+bounces-18523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA73988D1C
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 02:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DFD1F21F76
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5574A02;
	Sat, 28 Sep 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQwLWpxD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A63320F;
	Sat, 28 Sep 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727482102; cv=none; b=BBu9faUCth2xY/fN0wQMEob4upK2bjQobIr+bHu+B3f0zJI2Jw/qiOfVldgvt+e5xAS8xe1DhGe+eMf2dRiicDdsGfzavhcOtZ4if6BXy7bUyUxItUj1+ojpTtPmKPQZyDfg6+0QXeCd2npa226qz5V43cq19pZcfBz3U+KQORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727482102; c=relaxed/simple;
	bh=NZnaE/ubMUfBRZsNm92p9tvoV2sRkyx7S3yVGMv5jWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7ZTffK91fDVCym/nY3E6UDc51BKhldYUL54K2alNUpocirjy3dIOKtiFPeSXtY8UI9zYlpWHK+DQnMQrEZ+tz8EpJgrvScOa7ERJF1Zp9MT7zjXYcbEBbblYj0BGGO9WtEAKMje99E7qaRrWMN7++hHhiBTPpY+xKj7KqxRMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQwLWpxD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so2118354a91.0;
        Fri, 27 Sep 2024 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727482100; x=1728086900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x7Vj/jgke7ZDdOraXr0s4OljmEZuP6o5TRXDU6+8auE=;
        b=LQwLWpxDrhZw5IEE3kHa3samoZpSaw9wc0JSbydtwuNH8OAaVzB6vBmTQz7jYGgjr4
         tuOmOE4modGOi0MH45Yw+tqNGjkjY0WlXCnOmJTBIVZElnVH0iWJJ9i9fkxJdhdWVFcV
         zUWrDyrKpZ1AcIjPhL/Bj+hWifMv1cGhxgtqGSRU2RCE4aqSVMrjhRCYu00tmzjSfnkB
         8ucmxzv3fxEQNgqh6CAMmLfWNqL4Kq8k4IRykvicQQi86N8n1SPIbV+RuMFxtpkrDEtZ
         e/p5h9WkyjHPVy+czP68YuUhMxuNzcF+NXLfnDbItPozKIs6/JqdmLE0mfoJQ7PyGKkd
         EDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727482100; x=1728086900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7Vj/jgke7ZDdOraXr0s4OljmEZuP6o5TRXDU6+8auE=;
        b=dCFtqKYYUjCc4AFTDSLmoV8qvx4ZRxAsOn5mHzVlMYvic9qH+m+tmU3fzzFQZ+YKDs
         W2SlrCiRRIff87dly5Hc8T+/ZM8GXm6UTbJ524ciL9dEI7/Is0DoV/eZx3IedLYwz2ss
         +mpg6R+CrXE4mc4r27B7lF+NIAyOE2dpkTI3EMmqwYzKaMkEr+5SlfoX7uOef1bxP2Vt
         Lx+fiOnpND+Yo4x810j2vnge0OjDDepvZSnHH5qKzn6pC0u3M5Y7sH93l/zL3oMHKN/c
         +BiVUYfaO5o2I5+EDeonIXsXodShEeOZktsPmPqWDncHlMCAqxJvw1GxmU5/5d9xaKR0
         knuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9p9FFp9kK+pM4DAchvXdQxjwdcsSnZik37cHuw9kgwqNVhV2VtiMtlrH5x1rMHzh0JLY/THgSAz4b@vger.kernel.org, AJvYcCUawUHrMQ6UfSXbo5xCwSUggrCgrb+PnEXyOqccLoOTtOMeocaqEyqH1jWkU31i0+Noth2wx1Wx7Ips@vger.kernel.org, AJvYcCV4oWIE0zU8MRIyAfcwmIS2J4SUxBkqv2kTjzRAsa7ht/ohm1u/6cM/Fzel170SFTRg7nhyEBg9J14NbK2pE5ru@vger.kernel.org, AJvYcCXT+2MRg5HYxsubG5Rk9dWRofWwTbd7dvOUY3qg2SRFUdr2l8RDfyqgxPd2oRh7Uywz19D9n1rdlD+BiauG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7BnAB4eFu3Qdrdgd+E3+zeaoAM8ygB0PKIDgDPcocIl+bT6m
	nfxeCSeQ3ynOF3vbEDqlz1RRkZjW6er3tRRyuJ9L7LUuSb4gA+be
X-Google-Smtp-Source: AGHT+IH7qIuCcUe+n3Xpq0o4FDMm584GmXn4Kf/d6i5fSfeQjnkm13+WvWkEluAAjqSI+hTTk0yH3g==
X-Received: by 2002:a17:90a:a010:b0:2e0:d7cf:12a4 with SMTP id 98e67ed59e1d1-2e0d7cf1401mr3183501a91.2.1727482099569;
        Fri, 27 Sep 2024 17:08:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16fefesm6306762a91.6.2024.09.27.17.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 17:08:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net>
Date: Fri, 27 Sep 2024 17:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with
 struct clk_parent_data
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6f5a5b5f-71a7-4ed3-8cb3-d930bbce599b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/27/24 13:45, Shuah Khan wrote:
> On 9/27/24 10:19, Guenter Roeck wrote:
>> Copying devicetree maintainers.
>>
>> On Thu, Sep 26, 2024 at 09:39:38PM -0700, Guenter Roeck wrote:
>>> On Thu, Sep 26, 2024 at 09:14:11PM -0700, Guenter Roeck wrote:
>>>> Hi Stephen,
>>>>
>>>> On Thu, Jul 18, 2024 at 02:05:07PM -0700, Stephen Boyd wrote:
>>>>> Test that clks registered with 'struct clk_parent_data' work as
>>>>> intended and can find their parents.
>>>>>
>>>>
>>>> When testing this on arm64, I see the error below. The error is only
>>>> seen if I boot through efi, i.e., with "-bios QEMU_EFI-aarch64.fd"
>>>> qemu parameter.
>>>>
>>>> Any idea what might cause the problem ?
>>>>
>>> I noticed that the new overlay tests fail as well, also with "path '/' not
>>> found".
>>>
>>> [Maybe] answering my own question: I think the problem may be that there
>>> is no devicetree file and thus no devicetree root when booting through
>>> efi (in other words, of_root is NULL). Would it make sense to skip the
>>> tests in that case ?
>>>
>>
>> The problem is that of_root is not initialized in arm64 boots if ACPI
>> is enabled.
>>
>>  From arch/arm64/kernel/setup.c:setup_arch():
>>
>>     if (acpi_disabled)
>>         unflatten_device_tree();        // initializes of_root
>>
>> ACPI is enabled if the system boots from EFI. This also affects
>> CONFIG_OF_KUNIT_TEST, which explicitly checks if of_root exists and
>> fails the test if it doesn't.
>>
>> I think those tests need to add a check for this condition, or affected
>> machines won't be able to run those unit tests. The obvious solution would
>> be to check if of_root is set, but then the associated test case in
>> CONFIG_OF_KUNIT_TEST would not make sense.
>>
>> Any suggestions ?
>>
> 
> Would it work if these tests check if acpi_disabled and skip if it isn't
> disabled? It might be low overhead condition to check from these tests.
> 
> acpi_disabled is exported:
> 
> arch/arm64/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
> arch/loongarch/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
> arch/riscv/kernel/acpi.c:EXPORT_SYMBOL(acpi_disabled);
> arch/x86/kernel/acpi/boot.c:EXPORT_SYMBOL(acpi_disabled);
> 

I don't think that would work. Looking through the use of acpi_init,
I don't think that of_root is always NULL when acpi_init is false; that
just happens to be the case on arm64 when booting through efi.
However, even arm64 has the following code.

         if (acpi_disabled)
                 psci_dt_init();
         else
                 psci_acpi_init();

While psci_dt_init() doesn't set of_root, it does try to do a devicetree
match. So there must be some other condition where acpi_disabled is set
but of_root is set anyway. I just have not found that code path.

Guenter

