Return-Path: <linux-kselftest+bounces-7375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B039989B997
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAEF281874
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FE28DBF;
	Mon,  8 Apr 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Bip6JL3E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C42D03B
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Apr 2024 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563278; cv=none; b=mBkYo1jLoVegEMWnCcjo/gKD+wI8p4owCW+oIw56sCGqf1L00pnwKXl9ALcflQZT5VKtjMJgVfuPXwmGLj+IMDiDTW2G8//KzonYpg1XH2b+xg1bS3yk7cMHdW/vvWmCdhddIQJlH/vOmK3nS9fdpAh1wmssG+PfC9bVW5b7xJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563278; c=relaxed/simple;
	bh=oFtZMMMzF5IIyBLE1OofkhOkb8Z20H1FcMxpZ0BjJv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb9EJQISVq2HJu7p+MPWjkXiY+F9pWBeAQNllNsVAVZDlcKlWhQ0s7SRd6pzCWyuH04mnATMv84SrJ2v+b03+aiPYo+aKQR0vDVwPJNNd6qFUPBZKtg8fMmDWgYcdSmraEU5Ppu0SL5RSiOTHHYzyPXISvx9Aok3cf5eKOj8lY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Bip6JL3E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-416463e82fbso1612595e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Apr 2024 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712563275; x=1713168075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEXus2Ynno1AeuPQLNpTk8iPF9Mbvy8RxA45xKLQHC0=;
        b=Bip6JL3E5DmYfcHSQhhsjkUrX2FhlhScGfa3gp3f7UXkyJ6GwmgIrMmBAkeJwGHzZT
         4bYXkqgmjaKO2CxXaUgbKsBJpBzduYctad1Y7wq9sNGEzKrHH3oA9s/RMJMiwo+0XeaJ
         UOB2hjcxyvBBe98dnlClXCpESUeIFaKrnEgSKcASp/7AbGNKuA7oHeGvsgQFFPC4y/M0
         iZdDt9refM7EPnt1/ks0Gl+5WTG0+y86cYwKTKVE+RzDUgCG4HeQfoh+3fSdg5niiuhX
         qyb7qhc0Z/R5gaOIRI96amQkpLa3wponaInlsOcdTbNzd4lq92F4WQ8CUEkTcJEkhXwK
         0nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563275; x=1713168075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEXus2Ynno1AeuPQLNpTk8iPF9Mbvy8RxA45xKLQHC0=;
        b=DK/AJIqCV014t+FIdImOLdNBU6ag+cwkEc6memk8uRaJueIDDlVb7LH0NQn+feK5hJ
         j8pQatQqV7jOgl/oiwLmZq+f5BK6y4ifL25O9mbMGwms9cZlouwd8CpDoddj6FzT5EE0
         w8CMtQkCXTXkhHFS9BWC6qaJsak49V1bZOcye0+4pBYULwo1c4dXZxOO7Ps+STto8VYy
         c0vjrONwhwYUHpxNWE8DLwylZF0eb1tfFExtPXrjO0uPwyCxzmUzV0uNyEoKDCUv2jMX
         Gi9Mz+BqlmdDO+HZas6jI8Xz4tqOkKpsxjeC3UyqZd5VOOxIe/aKRhNwgJtGsE8zAb7K
         NOug==
X-Forwarded-Encrypted: i=1; AJvYcCXeS1y8kPn4pNIPo51RU3CBA2VdkuGBSqldT+Wihogd6aDJPRuBC3FP/ApMV+tyhPqgpdiIwufBERuZ5Ijn5nuYbUZX+/aq6vCxLuy+AKUa
X-Gm-Message-State: AOJu0Yyagl2xkkHDRtV0Wjl6GztJdPEbw8WFbLKmvB/YMcrDHMww9Ukp
	iK1UKTZWjbRxW2IHKULulRAUrj/OTiyCwiDxmUYEoPLsR+BaEN6XziLs3t0aXFc=
X-Google-Smtp-Source: AGHT+IEQUCd5IWDe0mYq0rDe9VUQhrgm0s8IGNzOcuAIRUoN4LcKFabia6A+gxLsv3jGCmScuNsjTA==
X-Received: by 2002:a05:600c:3b96:b0:416:7b2c:df09 with SMTP id n22-20020a05600c3b9600b004167b2cdf09mr834824wms.1.1712563274884;
        Mon, 08 Apr 2024 01:01:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:6327:edd6:6580:3ead? ([2a01:e0a:999:a3a0:6327:edd6:6580:3ead])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c3ba000b00415612e29a1sm12515475wms.30.2024.04.08.01.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:01:13 -0700 (PDT)
Message-ID: <ddc5555a-3ae8-42e5-a08a-ca5ceaf0bf28@rivosinc.com>
Date: Mon, 8 Apr 2024 10:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add parsing for Zimop ISA extension
To: Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240404103254.1752834-1-cleger@rivosinc.com>
 <20240405-091c6c174f023d74b434059d@orel>
 <CAKC1njQ3qQ8mTMoYkhhoGQfRSVtp2Tfd2LjDhAmut7UcW9-bGw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKC1njQ3qQ8mTMoYkhhoGQfRSVtp2Tfd2LjDhAmut7UcW9-bGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/04/2024 19:33, Deepak Gupta wrote:
> On Fri, Apr 5, 2024 at 8:26 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>
>> On Thu, Apr 04, 2024 at 12:32:46PM +0200, Clément Léger wrote:
>>> The Zimop ISA extension was ratified recently. This series adds support
>>> for parsing it from riscv,isa, hwprobe export and kvm support for
>>> Guest/VM.
>>
>> I'm not sure we need this. Zimop by itself isn't useful, so I don't know
>> if we need to advertise it at all. When an extension comes along that
>> redefines some MOPs, then we'll advertise that extension, but the fact
>> Zimop is used for that extension is really just an implementation detail.
> 
> Only situation I see this can be useful is this:--
> 
> An implementer, implemented Zimops in CPU solely for the purpose that they can
> run mainline distro & packages on their hardware and don't want to leverage any
> feature which are built on top of Zimop.

Yes, the rationale was that some binaries using extensions that overload
MOPs could still be run. With Zimop exposed, the loader could determine
if the binary can be executed without potentially crashing. We could
also let the program run anyway but the execution could potentially
crash unexpectedly, which IMHO is not really good for the user
experience nor for debugging. I already think that the segfaults which
happens when executing binaries that need some missing extension are not
so easy to debug, so better add more guards.

> 
> As an example zicfilp and zicfiss are dependent on zimops. glibc can
> do following
> 
> 1) check elf header if binary was compiled with zicfiss and zicfilp,
> if yes goto step 2, else goto step 6.
> 2) check if zicfiss/zicfilp is available in hw via hwprobe, if yes
> goto step 5. else goto step 3
> 3) check if zimop is available via hwprobe, if yes goto step 6, else goto step 4

I think you meant step 5 rather than step 6.

Clément

> 4) This binary won't be able to run successfully on this platform,
> issue exit syscall. <-- termination
> 5) issue prctl to enable shadow stack and landing pad for current task
> <-- enable feature
> 6) let the binary run <-- let the binary run because no harm can be done

