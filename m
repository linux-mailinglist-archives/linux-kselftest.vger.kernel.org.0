Return-Path: <linux-kselftest+bounces-46220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBD6C78C9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 090854EB401
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CF434320A;
	Fri, 21 Nov 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHY9wxoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65872F066A
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724335; cv=none; b=dYqO4XTH4ymyk3z5JgShaH21Dni0b+xcZ46cQI3Vf/AhyyAbQ5mVvFgAZTfNa9oEW7bKGcauKuFuRBTYO3Us16lZvOdelIirYl110GlbuKSPpjnO4YbyzSaPJHpUioVokLJVrsqdN5ym/O+iZV5twOgiKR2nbs/Rwjfz8i1GeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724335; c=relaxed/simple;
	bh=8P/0vMrJ7/1yTba68Y+FKzZMS9Q2EMuIiaaIaG79oRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdAKNG40rv04Ps6SiyIruQHGGkriWIRH3GTEfOl/MxtQTw+TJQbZY6zc/VuTrTgePPM3kU2ZzzrZCWjhAlVhQQF/sXJdg/AzddGdSPnKmovtJXRmmMOnG0ihCz2UD9TPXGDzPwR/2lha08MS8zSHgjjHOBjlAnHLIONguwwJZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHY9wxoD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a1c28778so21767525e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724332; x=1764329132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0xm/PimYBI7QTShSUbqekIyDmRlXD3/nFnREaHBgqw=;
        b=nHY9wxoD1kmRwMNLVNWPzFWiTmiq73lKEen9TrTGqRYT/eyUzCDUk1+HsKAG0HT2nI
         c32ujdKVRjaUaNM9ZA0i86s/MknP9pIEQVbTLvUJxczUZNNYlndw96CiiP6NXvycGgms
         9xXuOyaUpa2KEcNdExC7CJDZ/pQgS29imybc8/CNg5EDz404hjUOU8NFv6vzXBkDOwnD
         VWuPJE44JDhuNXBx6/JS/pU49Z0dTlUW+Y1EyUKOLXXeJpc5CO3CNbcE55jAGDV5kHIR
         wy9CedQbHEWuRRg21XDha0o5a7joiUHaOdsN+hZxMPUHpjQtO50aqYZ/yHLeOuUNfh3J
         dQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724332; x=1764329132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0xm/PimYBI7QTShSUbqekIyDmRlXD3/nFnREaHBgqw=;
        b=CtquI+DvyGMzbN/YggEq1iQysck5BuJqYe0viwXJqkCDhWBLE1CGIX8/WfVakE4z0u
         m0tGPp8ojIDRIlkiDEvu6DSFKvySOEeoMzQmpjVSQ5l+Oek6vQ/anbRxe/teS2e4Td09
         vbIr1y/aWTLZAKsZD0jkMbhV3n0Us5LEKUSJZqcYDISJWYybIsmov3PFElmcLLOcEvC4
         D19iOwJXdonXZTzTtEyNzvcp+ixfmGkihGe3tBrOgnkvJRJ3hMpGf++t2BQPuoaHsmfK
         IyFF+z9Ba3PVQKz+rmzrZWGtQMULKS8bKJO29sf9H/tasRbjXGJYXOcnxql2r9+wHKuv
         MNqA==
X-Forwarded-Encrypted: i=1; AJvYcCXBW8FhFpQXtikYJzs2O/UvwNXB7bHApbyGK57f6bvJFlNX+S6TvMrOwbUazHr43jI65+2pInC4/kLvRDX0ylg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoac/PVlSqqg4t8708Zxg06tpYr+uQxv2w4wVR1ChAVZ0u5BOV
	ev2ZB5bkxgO81EtjGvEOkgFE7ivGctLEKTXIS2NaCf9uLOa0cMsAQF7d
X-Gm-Gg: ASbGncuJtw0fFRdy//62zGgE+atqB8yPxkX3MlIj9g8yJf2AO9eUFwYuGyuR03vh4QD
	k5TWuCWHIQw56+rGVcgkZhs/vpJefYOvaOjV3Gs59ziuL6/VcQNKcCdC1w6Rx6xwQ7B2f9ulcAv
	y2hJ3po+rqIQJGopzYcC2Th2TlHE0tjCVB8dO+BnfGVFtE5dkz4+ZQcL4xK+dWYCoCS/uDIMJEr
	kEiPaUgTEtbMeLYAG8qP9KC+hDRRUy5axmVOIrCagfsjBz7CdCHY35X7/9kULUICoG6+eM3EXjP
	bCQxvLc6RX4P2l/oCFtNkmQY4ZIy7xNzolgDTJ3I1kSVFkV3u8lO6DlaFfVfiptHNnFjMO+Pi11
	5PwOacyFrk+pb57kYgCsEGnq/48T6zus1oKnDPDRnS5U7JH7xoI3PfAr9ydrjbg0EuzrB4H3oLa
	sxx0KMDtQ+KN4mWuEPcdFlZGQ=
X-Google-Smtp-Source: AGHT+IEQgLDezxuB/3Bt5w+9c4IjI+5mMo4URpXWEj4gL76tDkRoyLjFbJw02JhBlsBW/bbk9MSoqg==
X-Received: by 2002:a5d:5f48:0:b0:42b:3867:b3a7 with SMTP id ffacd0b85a97d-42cc1cd5cffmr1874053f8f.8.1763724331793;
        Fri, 21 Nov 2025 03:25:31 -0800 (PST)
Received: from [192.168.0.38] ([86.12.216.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e598sm10317686f8f.4.2025.11.21.03.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 03:25:31 -0800 (PST)
Message-ID: <05dd180e-f12f-44ef-96e2-2a6013da14df@gmail.com>
Date: Fri, 21 Nov 2025 11:25:30 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] arm64/sme: Support disabling streaming mode via
 ptrace on SME only systems
Content-Language: en-US
To: Catalin Marinas <cmarinas@kernel.org>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, David Spickett
 <david.spickett@arm.com>, Thiago Jung Bauermann
 <thiago.bauermann@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
 <176341325906.789443.15370787298292895484.b4-ty@arm.com>
From: Luis <luis.machado.foss@gmail.com>
In-Reply-To: <176341325906.789443.15370787298292895484.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[off-list, as I'm having bouncing issues]

Hi,

On 17/11/2025 21:00, Catalin Marinas wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> On Wed, 15 Oct 2025 18:56:35 +0100, Mark Brown wrote:
>> Currently it is not possible to disable streaming mode via ptrace on SME
>> only systems, the interface for doing this is to write via NT_ARM_SVE but
>> such writes will be rejected on a system without SVE support. Enable this
>> functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format data
>> via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
>> writes currently error since we require that a vector length is specified
>> which should minimise the risk that existing software is relying on current
>> behaviour.
>>
>> [...]
> 
> I don't think we'll get gdb feedback soon. Thanks David for the LLDB
> ack.

Unfortunately this flew under the radar for me, and I haven´t been 
following these discussions closely.

Is there someone working to rectify/validate this in GDB from Arm's side?

I´d gladly review it and get it through into upstream gdb.

