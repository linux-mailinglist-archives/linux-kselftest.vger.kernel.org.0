Return-Path: <linux-kselftest+bounces-25042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A2A1AC1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21717188ED4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5271CAA9E;
	Thu, 23 Jan 2025 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fd0Tjz05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652FF1ADC62
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669176; cv=none; b=AZbPGLS+CkKi0x+Ugs1NcG6Bwt0jY21pF9SQ3/y/SdiwjVnlMFYgrrSo1bk8BUTfuAXM49XS+8MaSt3zNfxGiR2eUeKtKW+1MOoo0tXgdg9GGn7+2LjtMx92zrh93p+8hbSbuds6cpKKf/RMiV1iHAlQYxhtx0ka2B1AN54iJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669176; c=relaxed/simple;
	bh=/C+oRISmBtFPzMvyMUvhgfwWSuUfo2LFplERHimzYWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5hHAztH//LeJ1Szjp1sbllGoDO66g10oiPcgZddqIcl9wGr59W0XhnulLPDWLHUv13wx0tAL0qYoTCZAl8mXSIRbHa8WMs17qzqNO6Y+JKHsstnV7tZRy+RTIo923rHllX+rtSeus+a7odqxwB1BWb73fds6E21kIRN9LyVi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fd0Tjz05; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce873818a3so11846185ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 13:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737669172; x=1738273972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5xeFnw+YG+lAPHwlwN78HoNcnUFYP8cXoXG8zMwzDc=;
        b=fd0Tjz05f/N290DdPAiCX4Yy/Rlfx9tM1gfQr6FbFhQww/EgTA3tRwInevEuj6nN7J
         //ZxEtxI6+kisakhXptzS3drV4fBakyKVWDBFUQe9wcQLb8F1bLgh2ILuzJdc49IRjfL
         5t5y8FrcifKInULA60+tZvow4lej0XmJ23FUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669172; x=1738273972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5xeFnw+YG+lAPHwlwN78HoNcnUFYP8cXoXG8zMwzDc=;
        b=WjZ3t/KMRGsZRwJOJxRzAqJb+J+LZ0QtmGBqT8ASH+ECRT3ajFkqXGaXSb9GAw+432
         5qIFduOFZP5jLxkKT3Oc1uWbwXKbquTQtSJ87OvWB/bCthHe3XWYGHpix4wyijFN9cAV
         KemXAqf9YxeLZ3TkZSH0ZZ1jonXK/+2LRq1eW+TQ9kDdcVBiIzVLbn4WIgrnKSjI7DlO
         Zqh0gmGOeq9hqawdCge45q81ZkOlsUSMCTmj7jdHGJX4mMG8IHc3SlZsPvIkhG2kyxvW
         J85FqGXOAcJOfWTHnhhFvv+/W/z6sf1zWACYrDnjZUt9T+A98pJOt/faHn+zF5FCfZmf
         7rIw==
X-Forwarded-Encrypted: i=1; AJvYcCUH34TzIeLzaynrPBwAcxYiHIPZbp23Yry5Jk3odI0q1uVP04TyfXya70aEKm4FOfGJ8Lpc16UcKxmMu1wcGhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfAlwO9Jh5L5G1Iriui+cgG02VqmGu/KrcKziUf0lXBkIBOdG
	YEnJqAe2ACGWFJsCXbCcxb6LnTKue07byueQfE4JJb/ETDWTX299C7lz1wZnjag=
X-Gm-Gg: ASbGncs8cqEHYgGI2R409NG1zuJ9Lst4hLWMba3t85pKaJHh41FQIv51ai7p8rQpJWO
	4jwTadizKeSMjGzXDD+srrRedZfqToF7vMMCw9Wdm10Pf4zKjX7vXa7KUkAH9ll7fRZVEFUmafI
	/ogePKqw9kENFTrbRo7M1CWXCAQr8FT+wqvjMHptfzFCNhzbL9FRAF1kavdu9iChUzCPtACfEZM
	oTP+ZA8oEhpBSsuGcajAjch+1H7iyEcrpLCylb3tN7bKKWTZrzBspK9sIj142Qr5AgjBfedVx1f
	m2byq6UUcpl0KTY=
X-Google-Smtp-Source: AGHT+IEpxaT2eMDUnJDloh/Iaqbi47PkQfvsbksU5MCl05aTBarJd+RK5OKbQDsmXQtf02s4mAFdxw==
X-Received: by 2002:a05:6e02:221e:b0:3cf:c773:6992 with SMTP id e9e14a558f8ab-3cfc7736a50mr12639315ab.12.1737669172438;
        Thu, 23 Jan 2025 13:52:52 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db6da22sm140981173.91.2025.01.23.13.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 13:52:52 -0800 (PST)
Message-ID: <1cf82baf-1937-42e9-add6-2a161fea434f@linuxfoundation.org>
Date: Thu, 23 Jan 2025 14:52:51 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/lam: get_user additions and LAM enabled
 check
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kirill@shutemov.name, hpa@zytor.com, x86@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
 <7qymrv7tfyt65dtqf6jhy7afkvtqftmpsa4y2hn5u65tusn7h2@3qw5dythjswm>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7qymrv7tfyt65dtqf6jhy7afkvtqftmpsa4y2hn5u65tusn7h2@3qw5dythjswm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 02:06, Maciej Wieczor-Retman wrote:
> Hello Shuah, I'd like to bump this series for visibility and ask if you still
> consider these patches okay to merge?
> 
> Just checked and there were no conflicts after applying it on the newest
> kselftest-next.
> 

This is x86 test and usually goes through x86 tree. I can take this
through kselftest tree if I get an ack from x86 maintainer.

> On 2024-11-27 at 18:35:28 +0100, Maciej Wieczor-Retman wrote:
>> Recent change in how get_user() handles pointers [1] has a specific case
>> for LAM. It assigns a different bitmask that's later used to check
>> whether a pointer comes from userland in get_user().
>>
>> While currently commented out (until LASS [2] is merged into the kernel)
>> it's worth making changes to the LAM selftest ahead of time.
>>
>> Modify cpu_has_la57() so it provides current paging level information
>> instead of the cpuid one.
>>
>> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
>> get_user() in its implementation. Execute the syscall with differently
>> tagged pointers to verify that valid user pointers are passing through
>> and invalid kernel/non-canonical pointers are not.
>>
>> Also to avoid unhelpful test failures add a check in main() to skip
>> running tests if LAM was not compiled into the kernel.
>>
>> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
>> test was ran without issues with both the LAM lines from [1] untouched
>> and commented out. The test was also ran without issues with LAM_SUP
>> both enabled and disabled.
>>
>> 4/5 level pagetables code paths were also successfully tested in Simics
>> on a 5-level capable machine.
>>
>> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
>> [2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/
>>
>> Maciej Wieczor-Retman (3):
>>   selftests/lam: Move cpu_has_la57() to use cpuinfo flag
>>   selftests/lam: Skip test if LAM is disabled
>>   selftests/lam: Test get_user() LAM pointer handling
>>
>> tools/testing/selftests/x86/lam.c | 120 ++++++++++++++++++++++++++++--
>> 1 file changed, 115 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.47.1
>>
> 

thanks,
-- Shuah


