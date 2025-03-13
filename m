Return-Path: <linux-kselftest+bounces-28985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A31A60254
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 21:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C631681CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 20:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A41F1932;
	Thu, 13 Mar 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grJ9HdPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BB1E8353
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897150; cv=none; b=XrJHacRskHG1xo6R+wH/q8pP84qGrswLOO7xE1gKbUwJ0R5q1JS2hw4F8JxzfYtDrH6j9OcE6yEGPnCTW3sPeYLOc93wqr3IQcT02NwE9Wj231BQcSB1tnkB26xQAr8H82SjhLf182ExRuKWYr/d4tCykJ03J4GWskqkdV+/z40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897150; c=relaxed/simple;
	bh=GwNXEPzVcYXJ1nmphyJMfGIxqNCqJjVL84gD7F2VovI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6EEAeDvhWrWvyM1c7BTubbfXqEXAsr1/Oh8psOQp9Jhoh+DIQoDBQYeWoN1GjNfT0GRZaU8jm8EaS5kjTh1O40bSoKrMzGVa8Ciw6RlRLyorFctTiBFzqjSAQf+i6PaZFIXgz6s4Facu68w9NXO4XVXgREBovFBuXdqNtYMZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=grJ9HdPi; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce868498d3so5492515ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741897147; x=1742501947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am1e3Yr0N9sJ7xnCyU39iPs0xuOYmSNADUSGEo4MjnQ=;
        b=grJ9HdPidBkpVJaMGcYkaPdnkYgqBBPoiTOj2LpVXuJ48La78EtB74KnK4SCU/5k+x
         yrgR8puuJghafDggQiWYA8/ig3zTbxMl5+hEa8ScDMIKI6stX3Fx6NBzwKIpf0znJPx/
         8jwIeCsKp4UFft4jh01vI/hMscLKm6+fkvyTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897147; x=1742501947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am1e3Yr0N9sJ7xnCyU39iPs0xuOYmSNADUSGEo4MjnQ=;
        b=XsFuSEcdTsaQ33IfOkk7VlAmCe2+Z5nGDyZ7CYftbXX23Va0n2aZCFyF4Gj7Q7uVWs
         CgRaBeRExlYci4OmVYGa+KO2QrvgF59fQhJGg/pP0FFpqV0ktVvMx7M8znDZ9ZvkCgMx
         9cTBqQPGF/guZzYm5IA2pFqKSMkap79PJ2GQ+elefVFE3/wRjPsekFAgAYnNBEhfOdNF
         8mC75mMsnfgrPhpSv1KvzhxCDR2b1+tm0QsLQIpEpw5LVrXuHql6iBcL9qV4awefaO/9
         rgi76UTqVHlk+56Y3QZ3ZomTV72k7G63Vwa8DNpoJi9sTKuqEp8kE/zNmAenc/dRzEVt
         CB2A==
X-Forwarded-Encrypted: i=1; AJvYcCXjCB7969V8eqZvI1o7iQiA8nuCRTfOdZwgEfr01zlmOe921YtpEkJ9JQZrp2cua1qx7UFDFMdkv+X5N1CrolY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+/Uc0cyngioiSG1PrhZbP8b1dg02UWaq0F6bstiqETG9PFdq
	SOa/YIgADEJCM4/PWBVKn+CZWzpYe9ymr1heF7Kq/OerDx7Be6RxqxMSl7SIc+Y=
X-Gm-Gg: ASbGncvBiA1btYYszh0tm5dMNV054pMUC+w0GnGaSyyGqka0Bog/irhYKeVlPiIBLTm
	bmBBAqJIB4l+X8MXz3n3mE79MIDiK2aPEWTQMyJG/y6nMxLFy9Hd7Pg8GL6SnzFA37BFpXYcHqv
	GDFW/AAF59STex32epkuWKhvc6pvbFG+JO9w9rwQgg8bX7CZpoi1n6fRHswkYFnPZPYRL8npKnM
	klhUkxReSeoLjqMsGkR0UMtHIdl+W3UUkdqFiMmmWF5cQ+jDAdP7JVSI4YeHWsj2jCMwMYivoW+
	X7XgTcjdrhFKw6VZpqsSrsE/Pxlhs3868eVodqDA4CWXmi5KB8/f6HoxHfJsmR/IeQ==
X-Google-Smtp-Source: AGHT+IGa/5eAuSmarcFKHqqOj2hcTd+7r+7qyTF/LSe7zhj2zp1QDtRJ6+rjw+eQw5dmnyJZFVG3Mg==
X-Received: by 2002:a05:6e02:20e4:b0:3d3:fbae:3978 with SMTP id e9e14a558f8ab-3d4816fa3b5mr11336425ab.9.1741897147299;
        Thu, 13 Mar 2025 13:19:07 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637274aasm527015173.64.2025.03.13.13.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:19:06 -0700 (PDT)
Message-ID: <65050389-2b80-4355-be2e-604c1c5b6b9a@linuxfoundation.org>
Date: Thu, 13 Mar 2025 14:19:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Error during --arch x86_64 kunit test run
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
 <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com>
 <5a1e11fb-4213-45f6-a5ef-636de5e175d8@linuxfoundation.org>
 <CABVgOSmvKgE6EHcWWR0CnCSjsSkBPsJy_+sDS5thgzuq9=T14A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmvKgE6EHcWWR0CnCSjsSkBPsJy_+sDS5thgzuq9=T14A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 20:21, David Gow wrote:
> On Thu, 13 Mar 2025 at 07:51, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 3/12/25 16:52, David Gow wrote:
>>> Hi Shuah,
>>>
>>> On Thu, 13 Mar 2025 at 05:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> David, Brendan, Rae,
>>>>
>>>> I am seeing the following error when I run
>>>>
>>>> ./tools/testing/kunit/kunit.py run --arch x86_64
>>>>
>>>> ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression
>>>>
>>>> I isolated it to dependency on CONFIG_AMD_MEM_ENCRYPT
>>>>
>>>
>>> That's interesting. I recall seeing this issue briefly about a year
>>> ago on an internal branch, and we worked around it there by enabling
>>> CONFIG_AMD_MEM_ENCRYPT (which worked).
>>>
>>> But I've been totally unable to reproduce it this morning: are you
>>> seeing this on any particular branch / config / environment?
>>
>> linux_next - I did allmodconfig build prior to running the tests.
>> That means I had to run make ARCH=x86_64 mrproper before running
>>
>> ./tools/testing/kunit/kunit.py run --arch x86_64
>>
>> I tried something different checking out a fresh
>> linux_next repo and running ./tools/testing/kunit/kunit.py run --arch x86_64
>>
>> No errors on
>>
>> ./tools/testing/kunit/kunit.py run --arch x86_64
>>
>> I will try this again and let you know. Can you try this as well.
>>
>> - Clean linux_next and run tests
>> - Run tests after buidling allmodconfig and mrproper
>>
> 
> Thanks, Shuah.
> 
> Alas, I've tried both on a clean linux-next (next-20250312), and after
> doing an allmodconfig build (and make mrproper), and am still unable
> to reproduce this here.
> 
> I also dug up the old 5.10-based version we saw something similar on,
> and wasn't able to reproduce it there, either. (That had been built
> with clang, but using clang on upstream doesn't seem to reproduce it
> either.)
> 
> I'll continue to play around with different setups, but none of the
> obvious things seem to work. Worst-case, I don't think it'd be a
> _problem_ to make EFI + AMD_MEM_ENCRYPT the default for the
> x86_64/qemu KUnit configuration.
> 

I tried again starting with a clean linux_next repo next-20250313

- Ran tests first
- Built allmodconfig
- Ran mrproper
- Ran tests

Saw no problems. Let's watch and see if we can narrow the problem.
For now I was able to test the pr I will be sending soon.

thanks,
-- Shuah


