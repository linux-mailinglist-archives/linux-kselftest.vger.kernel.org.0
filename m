Return-Path: <linux-kselftest+bounces-4028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6C847648
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 18:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672E01C22796
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853214A4C3;
	Fri,  2 Feb 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1II5zjZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE47145B2D;
	Fri,  2 Feb 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895471; cv=none; b=n3tUaGPOe4N5uKjx1o1zzHA7mjO1hp4hFUK8ZiAD8NXSpyhva+mDoP0XgcRo4f2QcfdZCKSIaJA+8XGV3b7Fkrajno/Vw5D8xuRDSr4T8yG4qWa11uqOCac08WK7KIXnNDO548pBnXu27Y0FurNToWewjU5x2o9m2igKUyE9TrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895471; c=relaxed/simple;
	bh=FV/m1E7grOjaP45bX+Q462zCMaKioikg4jNtCMJ8RG0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fUUvUHUjZ4fAtJDvfHiCjCza8X8EIWew717FlQ7zsObp97A0V0mtVYTzjpMapcoH0mg4agpOR+37ZhbcY8KwNp64YwhbLE46fGl7qUaeGQxBNH8I+qvUqxrNzm/VQ+5NVjfAYTsZB9q5gJ2jNPAbaa7an+IOWnfcJkvXhvmzprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1II5zjZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so19495295e9.2;
        Fri, 02 Feb 2024 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706895468; x=1707500268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acuHhQibuujsn4pRPkaFqcAuYowoSVcKHridiNfbyLA=;
        b=a1II5zjZA9dTIO7NXb2yNksfhzjmZpnb5CteWiK/dkS9tj3BnnDx+EuB58af7ubgXZ
         6A3ZR/oFzDJWWn/GYqSF1BiykkZPQRraWRAfH9ymTwhPRRJYjUySfvFiM5qG+BboupRe
         970iYGMK+ncdUGFWJlQIqiPPR/0oftnvSKMjO0qzULIvlyvO66uQrffoSXuqihrEA8Ik
         GCfBmTuGP8NQ+9JmtLY1TESTzNkrEd8s8bIn6rB43XQLzfH7Qf8uy8KzI4knzD0XiDIf
         /VA9vL57HAphoqgonWNlpNCvqcPcGy8KpPSeOUcjlaqnNZoSlaw3LlkNmxGJxHHmPPPQ
         8A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895468; x=1707500268;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acuHhQibuujsn4pRPkaFqcAuYowoSVcKHridiNfbyLA=;
        b=ORAxmxgQ7jAiKfb/7nEY/BxU6FecFgTVuj9hMWPqww5neXBq/IFkT1fNI60DheWPR3
         HxZqlE5g9fB8stLIBYP/4VdlcseYDiOOErm7l92cEZjCMaolbvkydkt+FzIgJNpHlscF
         Ll2GVy+Exbvp5zk0fu6nOp5TspAcCtT1IzUKERJFfC2OfROJmLrEZMvfK1rzdXnSvnem
         Y+rL8CaiwsFNtSmw7KqVU3ZP/chjhD4lMzgz8klAGuqmVgFoaVSV4IQHYTiRBUFn+hR9
         7RPvE3IS3gmp8/utrTfy4dNOoJKVm/eKrbefKVe0SvsMwmufaNZs/x+4nASmbYiY6zcD
         gyaA==
X-Gm-Message-State: AOJu0YwSj9RnniR7T7eyF+b2UiQuVGphNHNc/9Y2I1UVygqgUFPHXB9t
	z0DfPTibwdZUfPhwwqfIMprxro6ZoG0HzIRqr3dovZXQyB15c9rk
X-Google-Smtp-Source: AGHT+IFP1U7E1vQNZZAEKVGRs0X7US3VdZuoJ7HCxosixrNynGfyp2sionPT/sfCZQoU7Ovm/YDo9A==
X-Received: by 2002:a5d:574d:0:b0:33a:e88e:828a with SMTP id q13-20020a5d574d000000b0033ae88e828amr4307092wrw.48.1706895468099;
        Fri, 02 Feb 2024 09:37:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4/67qMFuG0VRExjGEKwZna+M+0UfAg+Zqv1mPsb4Vsjyp8dzBNRxvCkcj2m6bl4ZuUfmOKV72fzBhh2lni7CmicfWzYTKsxvGrvSr2Gthrk1R3kxTvEKvmpHFa9KGDzzU7L2Q7nqCUhD0Ql7q6g9GnleOOl5vzIn9wpmN3dXdNJwvcziy2RYT9QaRdt6smxHiFkwYqW04DzziBu3PWzfH5mo7bL3+ZPloPlm8B/dFKTvX/nyYOGCyO64tT+egSNC5f1Va7VJL+e3Y8zivWgWlKryPkezzINcmJo6fgwroNf7iu5Ax8J0c7BVexr3yaJdYcOMtKp27XICHv7+1+XdUSsFn1ga9hSUIWKUXmn1m2qUauvFO2UoRPITb0X4gPVProX04HusH+AQA84iRLLKMQA+VHTU5AE0tb4Zokjsf3NpPuVg=
Received: from [192.168.12.38] (54-240-197-238.amazon.com. [54.240.197.238])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d45c1000000b0033b28a784dcsm352982wrs.114.2024.02.02.09.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 09:37:47 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b45ee6cf-fa51-49eb-93ba-a54f4469470e@xen.org>
Date: Fri, 2 Feb 2024 17:37:44 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 00/20] KVM: xen: update shared_info and vcpu_info
 handling
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <2b4d020c-08ba-46ac-b004-cd9cb7256bd9@xen.org> <ZbMIu84Zi2_PF9o4@google.com>
Organization: Xen Project
In-Reply-To: <ZbMIu84Zi2_PF9o4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2024 01:19, Sean Christopherson wrote:
> On Thu, Jan 25, 2024, Paul Durrant wrote:
>> On 15/01/2024 12:56, Paul Durrant wrote:
>>> From: Paul Durrant <pdurrant@amazon.com>
>>>
>>> This series has one small fix to what was in v11 [1]:
>>>
>>> * KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set
>>>
>>> The v11 patch failed to set the return code of the ioctl if the mode
>>> was not actually changed, leading to a spurious failure.
>>>
>>> This version of the series also contains a new bug-fix to the pfncache
>>> code from David Woodhouse.
>>>
>>> [1] https://lore.kernel.org/kvm/20231219161109.1318-1-paul@xen.org/
>>>
>>
>> Ping?
> 
> Sorry, I have done basically zero upstream reviews over the last few weeks, for
> a variety of reasons.  Unless yet another thing pops up, I expect to dive into
> upstream reviews tomorrow and spend a good long while there.

Hi Sean,

   Have you had any time to take a look at this?

   Paul

