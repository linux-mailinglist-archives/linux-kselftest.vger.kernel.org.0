Return-Path: <linux-kselftest+bounces-7390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42489BE03
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 13:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF591C2125F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A07657C1;
	Mon,  8 Apr 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="j8zrpaIf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8F657A3
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Apr 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575185; cv=none; b=GHUsRBjzZgeNey4dAI0V02rU8ScfFl4JIbZhHkuWM7zFQjwgAU+M7w8UKMh5+Ec95UlosTY8XiFySVYxGkRLKUCKMOAJn6p28SZhGN0kzdbHVFJ0wZrSd8AufAjUctfbFS8DCv/+vBBnh/Eax+o2trMAACKjRrbEY6/2YcA3m9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575185; c=relaxed/simple;
	bh=43OKLW6FinsPWAmKzjoljUIVwv0vdGeQy+WbPiLUGCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAePH/SzFKWdoMbic0J13iwqhJtlseINc5DNm827I9cYPXUv3j7tx3kKPSYNDDEuKmzj7gGAjvFpCpvBbBVQEF1FPKNQyYjp+4FFphyPLaBfkNgTZ7zPgPSsvy2JuAgDhjdVQ7ZDVpTmuXhcP2i+/7HVW3amNFhjQFxfHR9/Yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=j8zrpaIf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343c8d7064aso570882f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Apr 2024 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712575181; x=1713179981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSk7g629HcnobUYtS9ld5wkokmcC8tpl1DGu7N0oFPU=;
        b=j8zrpaIfIve+C9k81yyhYpmocDiY095DUVPRcM+yNHwMLcHMqxx3tH6mnN9Ku5dDnc
         Y2HMgo2eWi45Jh9wVjpm0daA35Pq9OmbQql+Sciq2GvheLG6Khz/exHMQkCYpB88cj8B
         sDLJFCPHz+RoHNagFS9AdNN6KKmz3y49EYo4L8J6TwHDyx5fcl4zm4inXhT5SuT51+i9
         4zSpl0BnSTX5m4rX6VKbugQ+4QhthBzoqH1hApclgWg+5bWJeXHRd2YluE0VURfddd8L
         mFdtDb7tW+9gO/PJGiAh6JRFSiv2/DGEd89orAKSkgmu0/wG1juC02GEp6Cm0LAo3AcS
         52dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712575181; x=1713179981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSk7g629HcnobUYtS9ld5wkokmcC8tpl1DGu7N0oFPU=;
        b=wGoI1HMFA++gOtFB+tV3ymivw8/AAqfrjSLelglkkMZ3rhpxvxTuAs38fZ3YlVl7Iv
         cfVAmJ3gajTIpoOqKwz6ohW3jmkV/YjjlMa7IOhSNGHrpHmvSWBW7RjYR624K+gHnLxZ
         ZDYhgteR8NbOQw5Pg6OtXVE6A2PGX+KyGZyxx3zffPXPPxEb/Cpl5AMx4vf4N4u7U5Mt
         A+rHB1s2xHkklpQZiQOkVmuzdRoZfIo+iTD7y7qbOnVID0Ym4wePDASjYBWwBFIcbcgl
         Gzngpw/yWN/1hV4pgCwJglxs6fDPR/KzEo4iDsO5lNvXbEODIbWU1QTJp/1vAq/jwNfG
         oIqA==
X-Forwarded-Encrypted: i=1; AJvYcCUVlwCdaQY2a9vt3FIERCwFBBl5+3O4aOxVfaqV57nSFod3CTMEKO78283jZ1g1KARb3SRnjAa+YCHUXm7wJv+Ot8KA9FgvxIigRSiFKZLr
X-Gm-Message-State: AOJu0Yw30hGZzQxVNd17C+rtGOYmblCyeqCVpqvLrq7hFciQ6t9ZYU9k
	JCkxO2/jfT6sDi/CNDAurpHfKuVDLzKabLexU7f4GL8qf/r7GfJHEjJy598nLT8=
X-Google-Smtp-Source: AGHT+IFsrqlt8EPvaHLsA1X/PyCnOOmKPkgttAzXmXfIr/HqmjcOS9we1W6RxidEv01fKclvnQ/mqQ==
X-Received: by 2002:a05:600c:4fd4:b0:416:5c22:1200 with SMTP id o20-20020a05600c4fd400b004165c221200mr2651159wmq.4.1712575181415;
        Mon, 08 Apr 2024 04:19:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:6327:edd6:6580:3ead? ([2a01:e0a:999:a3a0:6327:edd6:6580:3ead])
        by smtp.gmail.com with ESMTPSA id dr20-20020a5d5f94000000b0033ea499c645sm8885921wrb.4.2024.04.08.04.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:19:40 -0700 (PDT)
Message-ID: <89d4a24c-db24-487b-8c5c-bdc1fa2d42b4@rivosinc.com>
Date: Mon, 8 Apr 2024 13:19:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add parsing for Zimop ISA extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Deepak Gupta <debug@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240404103254.1752834-1-cleger@rivosinc.com>
 <20240405-091c6c174f023d74b434059d@orel>
 <CAKC1njQ3qQ8mTMoYkhhoGQfRSVtp2Tfd2LjDhAmut7UcW9-bGw@mail.gmail.com>
 <ddc5555a-3ae8-42e5-a08a-ca5ceaf0bf28@rivosinc.com>
 <20240408-6c93f3f50b55234f3825ca33@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240408-6c93f3f50b55234f3825ca33@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/04/2024 13:03, Andrew Jones wrote:
> On Mon, Apr 08, 2024 at 10:01:12AM +0200, Clément Léger wrote:
>>
>>
>> On 05/04/2024 19:33, Deepak Gupta wrote:
>>> On Fri, Apr 5, 2024 at 8:26 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>>>
>>>> On Thu, Apr 04, 2024 at 12:32:46PM +0200, Clément Léger wrote:
>>>>> The Zimop ISA extension was ratified recently. This series adds support
>>>>> for parsing it from riscv,isa, hwprobe export and kvm support for
>>>>> Guest/VM.
>>>>
>>>> I'm not sure we need this. Zimop by itself isn't useful, so I don't know
>>>> if we need to advertise it at all. When an extension comes along that
>>>> redefines some MOPs, then we'll advertise that extension, but the fact
>>>> Zimop is used for that extension is really just an implementation detail.
>>>
>>> Only situation I see this can be useful is this:--
>>>
>>> An implementer, implemented Zimops in CPU solely for the purpose that they can
>>> run mainline distro & packages on their hardware and don't want to leverage any
>>> feature which are built on top of Zimop.
>>
>> Yes, the rationale was that some binaries using extensions that overload
>> MOPs could still be run. With Zimop exposed, the loader could determine
>> if the binary can be executed without potentially crashing. We could
>> also let the program run anyway but the execution could potentially
>> crash unexpectedly, which IMHO is not really good for the user
>> experience nor for debugging. I already think that the segfaults which
>> happens when executing binaries that need some missing extension are not
>> so easy to debug, so better add more guards.
> 
> OK. It's only one more extension out of dozens, so I won't complain more,

No worries, your point *is* valid since I'm not sure yet that the loader
will actually do that one day.

BTW, are you aware of any effort to make the elf dynamic loader
"smarter" and actually check for needed extensions to be present rather
than blindly running the elf and potentially catching SIGILL ?

Thanks,

Clément

> but I was thinking that binaries that use particular extensions would
> check for those particular extensions (step 2), rather than Zimop.
> 
> Thanks,
> drew
> 
>>
>>>
>>> As an example zicfilp and zicfiss are dependent on zimops. glibc can
>>> do following
>>>
>>> 1) check elf header if binary was compiled with zicfiss and zicfilp,
>>> if yes goto step 2, else goto step 6.
>>> 2) check if zicfiss/zicfilp is available in hw via hwprobe, if yes
>>> goto step 5. else goto step 3
>>> 3) check if zimop is available via hwprobe, if yes goto step 6, else goto step 4
>>
>> I think you meant step 5 rather than step 6.
>>
>> Clément
>>
>>> 4) This binary won't be able to run successfully on this platform,
>>> issue exit syscall. <-- termination
>>> 5) issue prctl to enable shadow stack and landing pad for current task
>>> <-- enable feature
>>> 6) let the binary run <-- let the binary run because no harm can be done

