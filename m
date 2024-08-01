Return-Path: <linux-kselftest+bounces-14684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACEE945445
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62162B22E03
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4F14B953;
	Thu,  1 Aug 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWpTAJgA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F761D696
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722549490; cv=none; b=fT0uge5UCzWrj7HwDwMLKvSjpAfJ7bJoouRK1iLF/lQqsIVHfAtwDlzLVyr5l/d2feD+L+LLMYmIeWIKOjkE9w/CH/MONNBrUQkx//gtGto68/xnBsvwiEhO5DExzxNfy/vk19gc+0wlOgyHtC3MBi6IDzJru0Ls1vbRE5hRppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722549490; c=relaxed/simple;
	bh=RQYItWZwH4Ql8qW2fpp1u02We7daZKEImfw/+wWYyWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBBxZnEqRcAIcBlTG+jZs0edWprzYDOMUEkm7pF7zSFZIxV/QwuIjQ6DNt8tQK45ElsBrbAZ6bYaP298mCqvhGMrKQ1q2UGa5Ft14jZM2VfJ6/mQRzFdXv/lPWKmQlHEAmvfbrIav+fjOMD6wVlhjSr0LOR23yePQW8fjDucbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QWpTAJgA; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81fd1ea8606so5794439f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722549488; x=1723154288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NO6nbx+9tiNIKrfqJCv4GTpw+kRZXI/h31Bka4korBg=;
        b=QWpTAJgAQGyI/VM4HAAqp/5e5TwJNsYfrPhGmfNXceWMaehXFo5+CpGOMd/1t0Y0JF
         xNEUxpNyGr0oN4z3BRqQ466UI7ltsTfA+/ZoG8V0buKu1uImxWktcxSrAjdhg3QIxElE
         lv5DxDgeI23jMA4ucdn01k2/WxywihaueDQrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722549488; x=1723154288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NO6nbx+9tiNIKrfqJCv4GTpw+kRZXI/h31Bka4korBg=;
        b=HzMPUsOcR0Apfy2dNvMsxHHgATDYkiqk/aV4vn8PxcVMetR9iNeeYVsvw6W5d4rZaj
         Vbv+K9f2TmRZXK+wPfCiC0aNe4N6tghta+VumEDHrYk5AAeku7IRKpk36RKpsy0+PBEp
         4XTEnzaJWrQmynw3d1NSM0LNumjAqPmiBca24ZcPW7A7TTAYhLFX7KZ+PDJRR3cLXSh7
         s41SJ9cVi13HSVMwAP46KtC1LF9pzusIvBysayHwaaMHhpx6UKyg/jvusMTxnHIM8GYz
         3wtU3sCe0czhR67Qau1pkVwfVlvuYEn9Vgd/in/C4D49u4+0eAm3OYAiR4pCRPLeODmI
         YMCg==
X-Forwarded-Encrypted: i=1; AJvYcCVYr0dBrVQejwYzxL1xNm+nEihdXKiF3m3st7ImvhiTSX2GDkYa2bOGbuE2MWz2zXrmsoKZ06XuLVyrVSBT0MNwDiFhD79Vqp89VaCjSmRZ
X-Gm-Message-State: AOJu0YyPGfci9iP7fkwzrXgidDUNDLIctlTOr691rLWy05WFZOVRR84/
	ObaCjyTFQgM5TiO7dMLccQPbZzRMjY3lzOR8h2+630XLg8SUmKwt/CiqjEzW2+g=
X-Google-Smtp-Source: AGHT+IH7ya7vdahb7Fg38dGONaREdXofSfWrUYIw0guOf2OCWQESsTl4qSlWseOFrxzw38bCJqnXJQ==
X-Received: by 2002:a92:ca47:0:b0:376:3918:c50 with SMTP id e9e14a558f8ab-39b1f780a14mr12601795ab.0.1722549487874;
        Thu, 01 Aug 2024 14:58:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ae3423sm2395595ab.68.2024.08.01.14.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 14:58:07 -0700 (PDT)
Message-ID: <928fd388-e714-4e84-bde3-bf684c1ccff0@linuxfoundation.org>
Date: Thu, 1 Aug 2024 15:58:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] kselftest: devices: Add test to detect missing
 devices
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Bird, Tim" <Tim.Bird@sony.com>, Laura Nao <laura.nao@collabora.com>,
 Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 kernel@collabora.com, kernelci@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
 <9d0b73ce-704c-4633-bb11-06ca4cb7a9a1@linuxfoundation.org>
 <f9a457c8-f558-4c45-96e0-baa97d143c7b@notapiano>
 <41a912af-4f59-4d54-a072-3de9ee912dee@linuxfoundation.org>
 <22688e55-b611-41b3-9bf0-06691454e3b1@notapiano>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <22688e55-b611-41b3-9bf0-06691454e3b1@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 15:03, Nícolas F. R. A. Prado wrote:
> On Thu, Aug 01, 2024 at 02:13:05PM -0600, Shuah Khan wrote:
>> On 8/1/24 13:15, Nícolas F. R. A. Prado wrote:
>>> On Wed, Jul 31, 2024 at 05:19:45PM -0600, Shuah Khan wrote:
>>>> On 7/24/24 15:40, Nícolas F. R. A. Prado wrote:
>>>>> Introduce a new test to identify regressions causing devices to go
>>>>> missing on the system.
>>>>>
>>>>> For each bus and class on the system the test checks the number of
>>>>> devices present against a reference file, which needs to have been
>>>>> generated by the program at a previous point on a known-good kernel, and
>>>>> if there are missing devices they are reported.
>>>>
>>>> Can you elaborate on how to generate reference file? It isn't clear.
>>>
>>> Indeed, I'll make that information clearer in future versions.
>>>
>>> The reference file is generated by passing the --generate-reference flag to the
>>> test:
>>>
>>> ./exist.py --generate-reference
>>>
>>> It will be printed as standard output.
>>
>> How about adding an option to generate file taking filename?
>> Makes it easier to use.
> 
> Sure, we can do that. Another option would be to write it to the filename that
> would be looked for by default. So for your machine just calling
> 
>    ./exist.py --generate-reference
> 
> could write the reference to ./LENOVO,20XH005JUS.yaml.

You could. Do mention this as the default option and to the
help message.

>
>>>
>>> No, that repository would just be a place where people could find pre-generated
>>> reference files (which we'll be using when running this test in KernelCI), but
>>> anyone can always generate their own reference files and store them wherever
>>> they want.
>>>
>>
>> Thanks for the clarification. This might be good addition to the document.
>> I think this test could benefit from a README or howto
> 
> Sure, I can add a README in the next revision.
> 
>>
>>>>
>>>> This is what I see when I run the test on my system:
>>>>
>>>> make -C tools/testing/selftests/devices/exist/ run_tests
>>>> make: Entering directory '/linux/linux_6.11/tools/testing/selftests/devices/exist'
>>>> TAP version 13
>>>> 1..1
>>>> # timeout set to 45
>>>> # selftests: devices/exist: exist.py
>>>> # TAP version 13
>>>> # # No matching reference file found (tried './LENOVO,20XH005JUS.yaml')
>>>
>>> First generate the reference file for your system like so:
>>>
>>> tools/testing/selftests/devices/exist/exist.py --generate-reference > tools/testing/selftests/devices/exist/LENOVO,20XH005JUS.yaml
>>>
>>
>> Worked - I see
>>
>> TAP version 13
>> # Using reference file: ./LENOVO,20XH005JUS.yaml
>> 1..76
>>
>> ---
>> # Totals: pass:76 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>>
>> Things to improve:
>>
>> - Have the script take a file instead of assuming that the reference file
>>    is in the current directory.
>>    e.g: exist.py -f reference_file
> 
> The script also has another parameter to specify a different directory to look
> for the reference file: --reference-dir
> 
> But the file name is currently fixed and determined from the system's ID (DMI or
> Devicetree compatible).
> 
> We can definitely have another flag to force a different file name if that's
> useful. In theory it shouldn't be needed given the machine name is used as
> filename, but might come in handy if there are machine name clashes or if you
> want to have references for different kernel stable versions for the same
> machine in the same directory.

Providing an option to force is good.

thanks,
-- Shuah

