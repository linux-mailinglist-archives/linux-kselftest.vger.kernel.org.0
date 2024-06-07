Return-Path: <linux-kselftest+bounces-11427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5D900B25
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F771F235D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340619B3CC;
	Fri,  7 Jun 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HW1iP+5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1D19AA6A
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781015; cv=none; b=E8g2aIJ2aPpB68wwhhlMOt6E5LeqqgMMSnQeKK278N/XAQTANdF9/9VRsWUU5E0lNyvxYQ2hV/VHcyTpb01i10QFxgwmIs2gtgv7iugO5cD5ONH9RVkEBNkq+Wes1POkSMtYNxjl/X6qGb/5uhHfJkiOJdaKtShwFv4FBAGEqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781015; c=relaxed/simple;
	bh=14cB//h5KHUcUznPEaqXo2+YdWchHE+YGMb0lj7HDvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZYA2mEFCihBVdZh+psyAIGW3/gX/bpN0gk+6uHE4MhpTSXEShv2IE1PKRzvKfHhybZXyIpPA9tB9BWdAvzqRyO1r43NWGB5NtCT+/al/xNpBeG8jm4xjYOooLWF+u0hVZq8K+/JfyG9a05ehEy1N2vV4vFI5e3RrZ5Po7ugZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HW1iP+5G; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3734052ffd9so1120385ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717781012; x=1718385812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Akc5Ty0GPAEauJkM0VeG3fjITUzHi1T4IgTHQZ9tmRo=;
        b=HW1iP+5GxqhP4YiFnOQtLBaX7mzCTo4B/69i0DXS9g2vajmoTJxBqSV6jwiv3m0JI2
         asPP2cOTL7TEpyQUAcUcfPJ/EU7XZbuJLhepFj/vjj0kPLKb/yMUUugqmXaBHhZ2CUPd
         lj4tJ20FYyh9Jlc421VPj6pzA8lp96192ZFgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781012; x=1718385812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Akc5Ty0GPAEauJkM0VeG3fjITUzHi1T4IgTHQZ9tmRo=;
        b=eu0qRyO8INqK7zdWIs/dmqxpwVN1UY3AuFNPSCsWMNYvpVUim3U1NZA0xj/oRk6HKM
         73HIQ3UYlhKiKyOWI0oxVTdgqW6nRyA6G5JRN/OJgi7hJFr3XKOrTY9EnHWs2uupuAkl
         d0RO60KmOJ/gbWklk6Li20X0zw4cpoDLHkmv/0dq0F39B0GmQUZGcLvI1mVTV9Zzu/R2
         xbPnoMyZ553xyfbtLapuffeBf2S+8WyeEyZ2A7NHZGj3ftAH0Pau4EP9kTBx1xMO2YI4
         6s5S73ORvh6U1+oNRRUjYXjEb2H25a0pW8d80T/Jv3ILLLcqHYQIKbeqoV8QSPy/QUo+
         DSPw==
X-Forwarded-Encrypted: i=1; AJvYcCXt1CkeeYIqjef9BuMx0xTX27DFqBG8+wAtZ9YTc1tj9imHgwGakm1NEDxGpDM+FZE+ZL16wM3+AF+qgzDXTI3am7Ial7f9hkpEeZ8HPzTu
X-Gm-Message-State: AOJu0Yynt9RwBQWBXK1PooiC39Espx4p4U84QMFbllf6I0KGis0FWQVq
	IqJNxrFDdahfB3DYX9kfCd3IUcv9Wg6LBSu1pGot0bPBRV9MnyAPtMQhbuztzbA=
X-Google-Smtp-Source: AGHT+IFNYj0aUh3K6WMdox7HGSg/JSFoAobTlR/evYNDo4xsqmY6c685HkWmKmsYRynyfRTE2ZhAUw==
X-Received: by 2002:a05:6602:20c4:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7eb57247049mr338990939f.2.1717781012383;
        Fri, 07 Jun 2024 10:23:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a24d000esm941753173.164.2024.06.07.10.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 10:23:31 -0700 (PDT)
Message-ID: <b7de28bd-34fd-491a-9b66-9a37dc450e22@linuxfoundation.org>
Date: Fri, 7 Jun 2024 11:23:30 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/lib.mk: silence some clang warnings that
 gcc already ignores
To: Nathan Chancellor <nathan@kernel.org>, John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-3-jhubbard@nvidia.com>
 <20240603223609.GC1802995@thelio-3990X>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240603223609.GC1802995@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 16:36, Nathan Chancellor wrote:
> On Fri, May 31, 2024 at 11:37:51AM -0700, John Hubbard wrote:
>> gcc defaults to silence (off) for the following warnings, but clang
>> defaults to the opposite. The warnings are not useful for the kernel
>> itself, which is why they have remained disabled in gcc for the main
>> kernel build. And it is only due to including kernel data structures in
>> the selftests, that we get the warnings from clang.
>>
>>      -Waddress-of-packed-member
>>      -Wgnu-variable-sized-type-not-at-end
>>
>> In other words, the warnings are not unique to the selftests: there is
>> nothing that the selftests' code does that triggers these warnings,
>> other than the act of including the kernel's data structures. Therefore,
>> silence them for the clang builds as well.
>>
>> This eliminates warnings for the net/ and user_events/ kselftest
>> subsystems, in these files:
>>
>>      ./net/af_unix/scm_rights.c
>>      ./net/timestamping.c
>>      ./net/ipsec.c
>>      ./user_events/perf_test.c
>>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> This seems reasonable to me.
> 
> Acked-by: Nathan Chancellor <nathan@kernel.org>
> 
>> ---
>>   tools/testing/selftests/lib.mk | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index 2902787b89b2..c179c02281e9 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -50,6 +50,14 @@ else
>>   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>>   endif # CROSS_COMPILE
>>   
>> +# gcc defaults to silence (off) for the following warnings, but clang defaults
>> +# to the opposite. The warnings are not useful for the kernel itself, which is
>> +# why they have remained disabled in gcc for the main kernel build. And it is
>> +# only due to including kernel data structures in the selftests, that we get the
>> +# warnings from clang. Therefore, disable the warnings for clang builds.
>> +CFLAGS += -Wno-address-of-packed-member
>> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
>> +

Thank you for adding this comment block.

>>   CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>>   else
>>   CC := $(CROSS_COMPILE)gcc
>> -- 
>> 2.45.1
>>
>>
> 

Thank you both. I will apply this for the next release. I want this
change soaking in next for a bit.

thanks,
-- Shuah


