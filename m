Return-Path: <linux-kselftest+bounces-19058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2772990F39
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 21:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA79281015
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C821E7C23;
	Fri,  4 Oct 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egOAVtTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781071E7C1D
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067314; cv=none; b=Q4IOAwFzKlFXLomQRw6NbKUHEh9lNoRV3/hifO/k+u+6INEhKkjc+3VknWIzndtiGV7KmhLGlQ5va4YByPM8u36q/JtkgwfSD8EHBrJsYuQv2zCpJlnn2ulEhwgWM+XIIy9R3mcAeZk7EtWEPmSIG3+dGwPpb5sFuwntVcsnqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067314; c=relaxed/simple;
	bh=4TK0He8dwCtdTdLxI3+U12GZbKcleL278kKQAMrdJKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC6rlHn3kCED61CEcFybySYPcRSQli/0d62AOXTF9ZrIIHhqVTYZWJ2iu2aGVNnDFjzxMG15CcFIltoqxSRaD17h5LrgQro66OVLCey8/eyjT7x2nFoSwIE5i4AsDAb3KafxCSnyRzqb5Y/e6KLEkLVpMGdUmRmH+MaIDfVy2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egOAVtTQ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a341ab4573so11273215ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2024 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728067311; x=1728672111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwwzeEiJ51opqJhPS5gdsXb8wf45NCbyQcZ446sEan4=;
        b=egOAVtTQtrQOlbXthuXG/9kL4F0hEEOD6k9IfhFzUFNiTzzrffCe79KS45OzJOpWhG
         Fjns4A3jtKGTS3fRTVdEUYG7t8zfVpj70rVpHy5OtEYkWdmPdBR0nyBW88d1Foj3wByA
         Cjw8kt/S112/uGELF2Pnu+4dkX6GfiZWUgNGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728067311; x=1728672111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwwzeEiJ51opqJhPS5gdsXb8wf45NCbyQcZ446sEan4=;
        b=DiHff7jPRLGv/24Xq7iFIrs85ubBpsibTB2cs7xEIHZU+sHj6R+uCtJu+CgkD1jDPA
         m5n9vxDqjzB+R05ZBQJ+sLAj6PYv/PolBlzA2Pg8BwN9d/6Uz7JP+3EENaYOi6YmBmR3
         YtmWXBJHZEd2s2V0qM2LY+ckhX5RPYpopgneucDX2K0SguztkN3heyEB/9vYq8uBh65b
         uHSU2p0XszUT8S4R36Lm48CUw84SCqPTQsL5KCR7cXc6yCes5e/82ifNsMYtolSXPuvx
         XKb+BISQGFx8TNyRCZJZvzns8eNLviaOSsqggpA4NerKGBIVfIRghCHT2cJsK9VWHloP
         ZEbg==
X-Forwarded-Encrypted: i=1; AJvYcCW9I8hFCrfaPqgx/N/nN3y6NdbYz7ORqOHYSdVDy1xB269H9/RlVhnvpSNAbZHdhnbARvvyw1w4xHXN5Kse3Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rsid3y5HaWQ2Sw55Azvd75qJpgLnv4sspEx/RTSUyr4ep4V2
	vA96Du8Qqof3VTvGaBZlI1uP11sql4jHjFAMtVROcZNYJJgUUz9UQCQZ0g7BWmY=
X-Google-Smtp-Source: AGHT+IH6mnLmqEkMpwU9kQVlZPZu54bW9Eh6OfVXFm/vCfvFb75bqD/YaW5wJrThyLGG3oGPjMxzCQ==
X-Received: by 2002:a05:6e02:190e:b0:3a0:8eb3:5160 with SMTP id e9e14a558f8ab-3a3759a102dmr37743035ab.11.1728067311627;
        Fri, 04 Oct 2024 11:41:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb868e3sm84295173.75.2024.10.04.11.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 11:41:51 -0700 (PDT)
Message-ID: <67224962-4ea4-4d78-923f-2c520488a090@linuxfoundation.org>
Date: Fri, 4 Oct 2024 12:41:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched_ext: Add sched_ext as proper selftest
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 Anders Roxell <anders.roxell@linaro.org>
References: <20241004094247.795385-1-bjorn@kernel.org>
 <60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 11:46, Shuah Khan wrote:
> On 10/4/24 03:42, Björn Töpel wrote:
>> From: Björn Töpel <bjorn@rivosinc.com>
>>
>> The sched_ext selftests is missing proper cross-compilation support, a
>> proper target entry, and out-of-tree build support.
>>
>> When building the kselftest suite, e.g.:
>>
>>    make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
>>      SKIP_TARGETS="" O=/output/foo -C tools/testing/selftests install
>>
>> The expectation is that the sched_ext is included, cross-built, and
>> placed into /output/foo.
>>
>> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
>> selftest.
>>
>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>   tools/testing/selftests/Makefile           |  1 +
>>   tools/testing/selftests/sched_ext/Makefile | 59 +++++++++++++++-------
>>   2 files changed, 41 insertions(+), 19 deletions(-)
>>
> 
> Thank you for the find. It appears *sched* is also missing
> from the default TARGETS in selftests/Makefile
> 
> This change looks good to me.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Tejun, Do let me know if you like me to take this through kselftest tree.
> 

Please don't take this patch at the moment.

Adding Mark.

After catching up with my Inbox - this is a no for me. This test
depends on bpf and will fail in CIs that don't have the support.

We are discussing the issue here in this thread.

https://patchwork.kernel.org/project/linux-kselftest/patch/20241004095348.797020-1-bjorn@kernel.org/

thanks,
-- Shuah




