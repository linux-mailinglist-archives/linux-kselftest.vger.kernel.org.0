Return-Path: <linux-kselftest+bounces-20057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34E9A2E8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028532849FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968082281DC;
	Thu, 17 Oct 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hkp0Q5Zu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB58219CB0
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197373; cv=none; b=Aq3ZNoNZfqhZuV9oh0IeTrnHkVZ4fFQFAWyuWUhhQCTrAhUsLTF34aTX5Z2lz7kTrc15dnYvfI5io4xmAd57pl50WB0wyFd3sPOKuGHDOeEGO3HbXqgLlhzkv1gB8zHZrPiScC+W35nUtLQV7c3aQU2Qd3r7oYoqZ7NWys2aApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197373; c=relaxed/simple;
	bh=AORgYkSEpqScrRJBsDbxUjNY993eTA7X1chV49DsV3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex7a0PePJFbkDBIwsawFkyezEV5+rTZKwbLVSb9IQd6i2cV8VUlDUxFjArrn1zC+rMUcQ0UHkwF3bWifkUiJZb9q64r2bE1o24X1cs574UFPqdkIrt+KCVg5Yk4OYG+Gbg764KnQm9u6Bnkv80R2INNKHOGFdaqjAOfgHEYMTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hkp0Q5Zu; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83a94a6032bso47225839f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729197367; x=1729802167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11ToTU7vsMi2SSsjzOsYplAbVYXVrOxGmHdlQUxuJOM=;
        b=hkp0Q5ZuAuvcKr+X2tI2e4JBjM3RV9JtVex54UgHOLXlEkKlSrMZPIMekVckzk5dLT
         4xe31MrcOPIBOOBIm7mY0iXgDRUF12niZmMSxHLk99IA0YiJXvS73iGNS7btGDcyoytC
         mteWPiWkfnWATbnKyX5K9PJd9Ec8tc4KNOQSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729197367; x=1729802167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11ToTU7vsMi2SSsjzOsYplAbVYXVrOxGmHdlQUxuJOM=;
        b=vuZC6UZQC7yz2Vb4i3NTw9wHW/EejkE4e3Efv+EZvSBTZW1/0FXfLDP2fa3GntiEma
         oWDbtKPFIbexO7vFFvK/GpDdoQIi/I+az1KHS0ilNHSYwvlfZ7Ie8v//lOjNJGtPDcMx
         nl2suYw0Xv2N6dYDCsLnAkpbkMpSB98n4FDqYnFnI1G5TP0qnxNibPJiKkTvERX+QMpo
         wYdJRRhdUxXm6Whqt+xDJ04zAPeHdo4BeChT8c2AOo+zqnZZhY2l9jgGp2t5JAi25oPU
         +KLFS63Fob/RMRoWXb5pQlhn+2Lu+yGw+OiU8Ab3dOx6Goc2xHS0t3WjBQ93kMT+0k/w
         +Azw==
X-Forwarded-Encrypted: i=1; AJvYcCX937tBfRncKCE7GRJntlpyHwUNoXj1Fq30c++VLAQ1aaz6jb2pH3f0p7ajm19k1AB1NiX6ubgdqN17BEBCCUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVkAI9ZkacKLEGSSO7HMSU9k6t7xO6qwK4s8ccKkyzgJI9qnf
	sWsuPYm5ccW9V+IEAJGp7jySbgRgl91MUWgW3y6B/WchRJg+R3qCSkwgw0IH16M=
X-Google-Smtp-Source: AGHT+IEWVBCgEov4mw1J/kJN0ZwoTJEWDfnh4NgHTLEZFUbsmenZRhqLbReeBnLs3cdVCJsyxaShVQ==
X-Received: by 2002:a05:6e02:1808:b0:3a3:dadc:12f7 with SMTP id e9e14a558f8ab-3a3e5294a27mr33585585ab.3.1729197367437;
        Thu, 17 Oct 2024 13:36:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10b83e9dsm49449173.56.2024.10.17.13.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 13:36:07 -0700 (PDT)
Message-ID: <56133d31-c94c-4c4c-9ae4-86f06b463a7d@linuxfoundation.org>
Date: Thu, 17 Oct 2024 14:36:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kunit: qemu_configs: add LoongArch config
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
 <878d5f26-ef05-44f4-93e8-01f66088c0cc@linuxfoundation.org>
 <3a49d3e2-2d76-458f-a0fd-fe52a413f376@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3a49d3e2-2d76-458f-a0fd-fe52a413f376@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/24 14:31, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> Oct 17, 2024 22:27:29 Shuah Khan <skhan@linuxfoundation.org>:
> 
>> On 10/14/24 05:36, Thomas Weißschuh wrote:
>>> Add a basic config to run kunit tests on LoongArch.
>>> This requires QEMU 9.1.0 or later for the necessary direct kernel boot
>>> support.
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>>    tools/testing/kunit/qemu_configs/loongarch.py | 16 ++++++++++++++++
>>>    1 file changed, 16 insertions(+)
>>> diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..e7bb7c07819677dfdefac012821a732555813cae
>>> --- /dev/null
>>> +++ b/tools/testing/kunit/qemu_configs/loongarch.py
>>
>> Missing SPDX-License-Identifier.
> 
> Tue others configs don't have one either.
> 
>>> @@ -0,0 +1,16 @@
>>> +from ..qemu_config import QemuArchParams
>>> +
>>> +QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
>>> +              kconfig='''
>>> +CONFIG_EFI_STUB=n
>>> +CONFIG_PCI_HOST_GENERIC=y
>>> +CONFIG_SERIAL_8250=y
>>> +CONFIG_SERIAL_8250_CONSOLE=y
>>> +CONFIG_SERIAL_OF_PLATFORM=y
>>> +''',
>>> +              qemu_arch='loongarch64',
>>> +              kernel_path='arch/loongarch/boot/vmlinux.elf',
>>> +              kernel_command_line='console=ttyS0',
>>> +              extra_qemu_params=[
>>> +                      '-machine', 'virt',
>>> +                      '-cpu', 'max',])
>>>
>>
>> Please send v2 with all the reviewed by tags. If there
>> is a resend 3.4 and 4/4 in this series, send them.
> 
> I'll do that. But it will take some weeks, as I just went on vacation.
> 

Sounds good. Enjoy your vacation.

thanks,
-- Shuah




