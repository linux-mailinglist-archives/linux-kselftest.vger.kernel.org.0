Return-Path: <linux-kselftest+bounces-41867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DDB85E7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E162443C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE84F3161B4;
	Thu, 18 Sep 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjgGsBQW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C131619A
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211458; cv=none; b=DqvRpdD/kAweEH+keX/IpoCl3Atho3vfXYD7l6b+txZ8AeoFXrPZdynqeOP/ckbpMqlM6kTf7mc01NKGQAapS0VoOM6M39UpbiCm301R/U79LVJOkIhoq1eh2GvD6yynvoHoSypWcwClsJZJmO0OJzx+VwFVSIryUEiQTg9yfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211458; c=relaxed/simple;
	bh=y6c8lw8EKlOPBKyWspS/31sWHR2owEThgD2fvz6wrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwosqMnJe5nmbOwz3AvPd+7gYeFW+DW/BBRepilkSKl89JsCZfb3zQMUPGZf+SiUbZaSk/zWDGsodZSb5XXWGV5ztXlYR5aawV6y1lWOcwcjc1saiOPJgfARPfqsYK3JJgxlDqweDiV7xd4UogvzccGH7l2y9Z5pbJFMakciw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjgGsBQW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8250869d5d8so151037085a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758211456; x=1758816256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQgPx54SvuoVw16CwN5aQ4H7UCLvlv+FoxUfiYTem8g=;
        b=HjgGsBQW/ujV3dr1oewnRVQi5GiLtqBFU+HTqI6pDGmpiMuWK0EiFL/Naw7PPocwkW
         J3U0jO2QSxjtiVADvZnAmvdyYRh0X5FWI8Biyvlpg4wx6WDJENE2EtRpCkhuEDaTWA+x
         OB/4434CTDCYrgkkvq1FkMA8G7vJ83nI+b9XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211456; x=1758816256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQgPx54SvuoVw16CwN5aQ4H7UCLvlv+FoxUfiYTem8g=;
        b=Ub0uxbXPwSIX3F4IuI3KQTFJ98q5Hx0LVkARSKkHgtZrF0248Z9vCTmi5l3XPUH7J9
         CjVsexLUuoyTzhDLX6n8Wi4UgVdbcwqKQhnizQipmnbdqO8qR2nygdNiTAx+WpOcVtRV
         RUBTkhRZhBGiw9zmJmlKovk8IgBL/THSYucYarFdkWEmnjKWohuxec0Llhr49SooVk0L
         aV6Dx+t4QwGz3I45+UVkIP5Ep0kzEwcEtFVNPAXn6xmUS/bQfqz1mBEpWlfUkiVPUMw/
         2ez4tGNAZKZ0WZYKeJFhfbCX9LHRTmH1hUD1k1g95wOS33KdwoUmEnAw2MIOWTI9Mm07
         10Mw==
X-Gm-Message-State: AOJu0Yz/hVxro0/2c7o6mWbGRXNYdkk17MVTYuXDcULtUXAFToD0NeAg
	GlzPKE7CVX3HaZWuJ5jKt1UfJB0vzIVGTVdIDkiCOYUhnJJuKRLKNdVgC9BvtWB76JU=
X-Gm-Gg: ASbGncssRcbcgI4vHVVTkEmUH6aqMqV7hkuwf+ijnCSc0DGPFhanz42/FuRsavcLuO/
	NzFrw40ATEPjabnifSVwhJCUyXa9VvCImHBrHj8GMtifjuyvcU/ZPO2m9UuNqYN/aHVs/M9kOTP
	ljFJst36hZbJF5ij63ro5LG22HTQUfVB+d2tBhmD79zmG3FDDtacicN7MSzs+5tFbMuBlrxqFHN
	fO2qY5fX9D4TbAyUcCa+DjrNmt6LwaHr9CiZK8mS2Hrp/3579e5M3Xm8+LtvQQXr5263IKgFVXJ
	xdXn+ct6ovubzg9BGm4qMV8Xat3AIvbUL/23j/Sfgtl2cbFeUv5dVsQ9LGpFHHGN7k+F55mxBSa
	rtekhokcDrsUJ6m0jTmlPogTgxoQHG5ZibC8veTKuTVC59AZPNdNcsAI1qs69kdj+XwDdCOc2V5
	ixrbzgiutWUVRwdEUi28nMqTEOVxGPW+jifvwWidJFAEfa256UW0h1Jg80lq0mNhaGnoRm6ho=
X-Google-Smtp-Source: AGHT+IGIwAd/uoNV9XL+0qecZOvEJzFlnVi+Hy8TF9s9PCR5fJ4tPFqi0Aa5Sz/TtZFISSFPPfxp7g==
X-Received: by 2002:a05:620a:205e:b0:825:4783:5c6a with SMTP id af79cd13be357-83ba29b6c60mr12732285a.11.1758211455131;
        Thu, 18 Sep 2025 09:04:15 -0700 (PDT)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836262b559dsm183650585a.1.2025.09.18.09.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:04:14 -0700 (PDT)
Message-ID: <6712e20a-0fa9-44f5-ae0d-f4d9c3324028@linuxfoundation.org>
Date: Thu, 18 Sep 2025 10:04:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kselftest and cargo
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-integrity@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <aMlqouOSU8XN7V5H@kernel.org>
 <f18854b2-f9c8-44a3-a09d-3b2ddbcb971a@linuxfoundation.org>
 <aMwf89qekCuAdD1L@kernel.org> <aMwh95tMxB7sMEzy@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aMwh95tMxB7sMEzy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 09:15, Jarkko Sakkinen wrote:
> On Thu, Sep 18, 2025 at 06:06:31PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Sep 16, 2025 at 04:39:37PM -0600, Shuah Khan wrote:
>>> On 9/16/25 07:48, Jarkko Sakkinen wrote:
>>>> Hi,
>>>>
>>>> The pre-existing kselftest for TPM2 is derived works of my earlier Python
>>>> based rudimentary TPM2 stack called 'tpm2-scripts'.
>>>>
>>>> In order to get more coverage and more mainintainable and extensible test
>>>> suite I'd like to eventually rewrite the tests with bash and tpm2sh, which
>>>> is a TPM2 cli written with Rust and based on my new TPM2 stack [1] [2].
>>>>
>>>> Given linux-rust work, would it be acceptable to require cargo to install
>>>> a runner for kselftest? 

What is runner for kselftest in this context?

I'm finishing off now 0.11 version of the tool,
>>>> which will take some time (versions before that are honestly quite bad,
>>>> don't try them) but after that this would be something I'd like to
>>>> put together.
>>>
>>> Probably fine - how does this impact kselftest default run?
>>
>> OK so this was early query: I might introduce such test as part
>> of series that hasa waited for long time for an update [1]. I can
>> use tpm2sh more easily to reproduce equivalent crypto as kernel
>> does and make a test that can compare the results in a meaningful
>> manner. I also plan to relocate tpm2sh as part of git.kernel.org
>> custody from Github, as its main dependency tpm2-protocol crate
>> already is [2].
> 
> Some motivation context, I left out on doing the aforementioned
> patch set because I did not see importing TPM2 keys useful enough
> application but recently I've been dealing with remote attestation
> and that levels up the feature something quite useful.
> 
> I.e. so called attestation identity keys are persisted to the NVRAM of a
> TPM chip and it would great if kernel could at boot time reserve
> selected (in the command-line) NV indexes and wrap them up into keyring
> keys. Since in UKI model command-line is signed that effectively locks
> them in into controlled use only through keyring as kernel can
> guard that via the device.
> 
> I could put tons more detail into this but point to open up this
> complexity is that getting all cryptography right is easiest done
> by reproducing it in a test in user space and comparing the
> results, and Rust and the crate I did give sort of powerful
> way to describe all this. And also because of the complexity
> it needs to be anchroed with some kind of sufficient test.
> 

I would say get this in a shape where you can share it for review.
We can discuss the changes. One thing to keep in mind is dependencies
for kselftest default run need to be minimal so these tests can run
on rings with minimal tool support.

thanks,
-- Shuah

