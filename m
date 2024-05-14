Return-Path: <linux-kselftest+bounces-10175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E388C562C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43A21F2278F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E06CDC4;
	Tue, 14 May 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QHfTH9mO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325D55C0A
	for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690886; cv=none; b=qf/rr02fz4t31Vf8PYuoxV9Es8JZOsAkQqdlKNWczyEmzUpuK8gT3uUzLZnoQafcJx2nvmMMpA8ctboNoB3VuNHTz7rE2Lb0G8r85roQJbmMNJU2gr5KRfKJN7/48ILV0lSYeTnohdMCRgqekklb/dSuNkyOYLWaHy/jB3+Iz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690886; c=relaxed/simple;
	bh=rUB5fVhGHwZq7Jc+xOgPgC8trDa/Wv8SwQlHLpgcqMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOL8lA/V+6Sc/CzxKx6xoIKElR8wMg/nAOSVvUWm5I/LLj6FBWNrQKuvFIEJ+sqrOjR1v1BIlOtgA7ixaV1InQaOXG9ph05ec9F4k7gSzdeIUGuXquF7ufFUxIjK445zTyj0rc+JiwWNc7fKpCf2DiY1VWviIgv9j21kM01fiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QHfTH9mO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34cb2bf85easo472682f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715690883; x=1716295683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEDd1uZ3WD8w5BLnI3VEk4mficDxDq165y157o9KZ8I=;
        b=QHfTH9mOlCxfNtUzf4ywH9u5VlXCNVSDFdf3yN1L/UDct3AEt+ck+4Yx3Rl5tnh5Mi
         pKSsndXyNwp21ijJZXBSTIovx8O4ak2mU50+N3R6pYMcKiKSxVD0CnRP5t4L9+jMCeS5
         wrgWWI6p4WGInUjALd1QfCIbzSVembtqIyo+XMpMr+1l4iJASQY0UxbhYcwULa5e/SoG
         AwfY6c5LD6TmF/cHPTtkLPxLPm0912zfkj3eq9XrSapsJckiAKKPgFSlUmTzr5VZ21T8
         7zcfDr/grkY+adz422QEoIza41u1VxtXdXxGaV4Qeu7t9xuRYPqFYEUpbFg8wjnIgxil
         +RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690883; x=1716295683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEDd1uZ3WD8w5BLnI3VEk4mficDxDq165y157o9KZ8I=;
        b=TH++Jx4FGaR5ubNAXPpTNLAmr4OsqXMEIpbr334utyQHSNuJSMVcXgTYw6n427+cOq
         HEGJ6UMYEBciVTTqBasYgNeKHoZgvrbOu/TQDAmE+jTwoT5Q02knDhXzCNKLsk4q5yLN
         nJ3z5ALIVpWxYbIAuyp3Brg8VPfYt9PkHAMR+hgsENgnrqzYgEIFheWZyOahWJHOa/NT
         uRGcbnOedECapd3pfVwZVy6cEyRpcFrxg7NjxE11fBoVczAk6baog6sSmC3AmIhof3Vn
         0RW1VWsY2itjm5esjhlxDXk+9E9ipumiiVd/L5iXZNtCRwEcBBuAPHKtzdj6woy0pfKP
         DWdw==
X-Forwarded-Encrypted: i=1; AJvYcCXRZSdads4IGfCwbH9CNCxPZiqKijc8xFmlD4PJ2kHqvPO5aaRQnycyPG5qbADMn04Kd1JeEusaNVwBsrJTxbC4CB5H6dD9jo+ZUUz2g+bX
X-Gm-Message-State: AOJu0Yxyb7UTlxtkgEXgqj3jJRcSb6XDDwhBrWb+pngsTsE6N3mQaf3v
	qIVbcwfm3ftXY/WqAUV7ljvFCIs2OWDBV7eN0CSMfqgE0HBqtgfwKjIEaS+EqAE=
X-Google-Smtp-Source: AGHT+IFe1dRVmkB1/oPC61qywBvaee0ia6xRc5GKDk0ZftS91pmd8oOAB/sk26VPRQ5WxDKVoBlCig==
X-Received: by 2002:a05:600c:3548:b0:418:9941:ca28 with SMTP id 5b1f17b1804b1-41feac49036mr92211155e9.2.1715690882999;
        Tue, 14 May 2024 05:48:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:1660:5f6e:2f9c:91b9? ([2a01:e0a:999:a3a0:1660:5f6e:2f9c:91b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42016a511a7sm67036525e9.0.2024.05.14.05.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 05:48:02 -0700 (PDT)
Message-ID: <9d0840ff-d00a-4866-8f45-e8676f369ad6@rivosinc.com>
Date: Tue, 14 May 2024 14:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] riscv: add ISA extensions validation
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240429150553.625165-1-cleger@rivosinc.com>
 <20240429150553.625165-3-cleger@rivosinc.com>
 <20240429-subtext-tabby-3a1532f058a5@spud>
 <5d5febd5-d113-4e8c-9535-9e75acf23398@rivosinc.com>
 <20240430-payable-famished-6711765d5ca4@wendy>
 <e57f8b70-7981-42c1-bb04-2060054dd796@rivosinc.com>
 <20240514-sip-exclusion-014b07b01f4c@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240514-sip-exclusion-014b07b01f4c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/05/2024 14:43, Conor Dooley wrote:
> On Tue, May 14, 2024 at 09:53:08AM +0200, Clément Léger wrote:
>>
>>
>> On 30/04/2024 13:44, Conor Dooley wrote:
>>> On Tue, Apr 30, 2024 at 09:18:47AM +0200, Clément Léger wrote:
>>>>
>>>>
>>>> On 30/04/2024 00:15, Conor Dooley wrote:
>>>>> On Mon, Apr 29, 2024 at 05:04:55PM +0200, Clément Léger wrote:
>>>>>> Since a few extensions (Zicbom/Zicboz) already needs validation and
>>>>>> future ones will need it as well (Zc*) add a validate() callback to
>>>>>> struct riscv_isa_ext_data. This require to rework the way extensions are
>>>>>> parsed and split it in two phases. First phase is isa string or isa
>>>>>> extension list parsing and consists in enabling all the extensions in a
>>>>>> temporary bitmask without any validation. The second step "resolves" the
>>>>>> final isa bitmap, handling potential missing dependencies. The mechanism
>>>>>> is quite simple and simply validate each extension described in the
>>>>>> temporary bitmap before enabling it in the final isa bitmap. validate()
>>>>>> callbacks can return either 0 for success, -EPROBEDEFER if extension
>>>>>> needs to be validated again at next loop. A previous ISA bitmap is kept
>>>>>> to avoid looping mutliple times if an extension dependencies are never
>>>>>> satisfied until we reach a stable state. In order to avoid any potential
>>>>>> infinite looping, allow looping a maximum of the number of extension we
>>>>>> handle. Zicboz and Zicbom extensions are modified to use this validation
>>>>>> mechanism.
>>>>>
>>>>> Your reply to my last review only talked about part of my comments,
>>>>> which is usually what you do when you're gonna implement the rest, but
>>>>> you haven't.
>>>>> I like the change you've made to shorten looping, but I'd at least like
>>>>> a response to why a split is not worth doing :)
>>>>
>>>> Hi Conor,
>>>>
>>>> Missed that point since I was feeling that my solution actually
>>>> addresses your concerns. Your argument was that there is no reason to
>>>> loop for Zicbom/Zicboz but that would also apply to Zcf in case we are
>>>> on RV64 as well (since zcf is not supported on RV64). So for Zcf, that
>>>> would lead to using both mecanism or additional ifdefery with little to
>>>> no added value since the current solution actually solves both cases:
>>>>
>>>> - We don't have any extra looping if all validation callback returns 0
>>>> (except the initial one on riscv_isa_ext, which is kind of unavoidable).
>>>> - Zicbom, Zicboz callbacks will be called only once (which was one of
>>>> your concern).
>>>>
>>>> Adding a second kind of callback for after loop validation would only
>>>> lead to a bunch of additional macros/ifdefery for extensions with
>>>> validate() callback, with validate_end() or with both (ie Zcf)). For
>>>> these reasons, I do not think there is a need for a separate mechanism
>>>> nor additional callback for such extensions except adding extra code
>>>> with no real added functionality.
>>>>
>>>> AFAIK, the platform driver probing mechanism works the same, the probe()
>>>> callback is actually called even if for some reason properties are
>>>> missing from nodes for platform devices and thus the probe() returns
>>>> -EINVAL or whatever.
>>>>
>>>> Hope this answers your question,
>>>
>>> Yeah, pretty much I am happy with just an "it's not worth doing it"
>>> response. Given it wasn't your first choice, I doubt you're overly happy
>>> with it either, but I really would like to avoid looping to closure to
>>> sort out dependencies - particularly on the boot CPU before we bring
>>> anyone else up, but if the code is now more proactive about breaking
>>> out, I suppose that'll have to do :)
>>> I kinda wish we didn't do this at all, but I think we've brought this
>>> upon ourselves via hwprobe. I'm still on the fence as to whether things
>>> that are implied need to be handled in this way. I think I'll bring this
>>> up tomorrow at the weekly call, because so far it's only been you and I
>>> discussing this really and it's a policy decision that hwprobe-ists
>>> should be involved in I think.
>>
>> Hi Conor,
>>
>> Were you able to discuss that topic ?
> 
> I realised last night that I'd not got back to this thread and meant to
> do that today (I had accidentally deleted it from my mailbox), but I had
> a migraine this morning and so didn't.
> I did bring it up and IIRC Palmer was of the opinion that we should try
> our best to infer extensions.
> 
>>> Implied extensions aside, I think we will eventually need this stuff
>>> anyway, for extensions that make no sense to consider if a config option
>>> for a dependency is disabled.
>>> From talking to Eric Biggers the other week about
>>> riscv_isa_extension_available() I'm of the opinion that we need to do
>>> better with that interface w.r.t. extension and config dependencies,
>>> and what seems like a good idea to me at the moment is putting tests for
>>> IS_ENABLED(RISCV_ISA_FOO) into these validate hooks.
>>>
>>> I'll try to look at the actual implementation here tomorrow.
>>
>> Did you found time to look at the implementation ?
> 
> No, with the above excuse. I'll try to get to it today or tomorrow...

No worries, I was on vacation and was just checking if I hadn't missed
anything in the meantime. Take your time ;)

Thanks,

Clément


