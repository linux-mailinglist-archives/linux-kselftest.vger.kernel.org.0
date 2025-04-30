Return-Path: <linux-kselftest+bounces-32052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 684AFAA5757
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 23:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1920F1C04E5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDEE2D111F;
	Wed, 30 Apr 2025 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+NlcjjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0D2D110F
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048517; cv=none; b=pTSJ6LtmnYirSa8diIxfpWMXO/XiyR/Kh01D8VvHGiVCvZPfNqMJOtRxXH/3mtMbQj3yootinXBINP4+NYS52SZQ8x4hjDpepP7hOBjtacEVMk2lgZen5kdN/GprQ2A2TaiI9cYV5JjfVf6SW5Uqcl0dQMKI2ZDC0kcpHrqwdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048517; c=relaxed/simple;
	bh=YqAluL15fN3zgcGp6EDEaNIV2TWFeVKq3zBmJjBsYhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zm8mWYrMFgy2x7CpxQPbzIcLXucvfe9hRygyNoMNge1zqLcfND6CI9iDrxOb7hczQGrwD0pk06BYY9YRi+wjnz/LVjezd1vLGhdWXQiAZ5tIHX2Q07HidM9CeMla4vfYwivk8mz6Bzf7Qhdh4nhA9U03bAGxKGGG3JcMIqBzamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+NlcjjH; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86135ac9542so15129639f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746048514; x=1746653314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6Q234hicpNrTkMdew1fU6M9FGq8oUuHNboh5He87eU=;
        b=T+NlcjjHuHfA1JZ28bnYk/soZ1SoT13mYL4RaL40AWdUr1fAdgxW+Y8zzySFN80eAi
         BuVIIdlth/NTT9r+2viqQp+ypCmBLrNTAUzV4kB7IrtoddZ5DgQjgBtFD4drg1Rnpojs
         8ZZJvzvqoQCHVTm8gBT3SN8ZVjPkrc54FcLh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048514; x=1746653314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Q234hicpNrTkMdew1fU6M9FGq8oUuHNboh5He87eU=;
        b=jvWjPdqglYrMhNFXdNNd/rscS6Duz1kTfakFTVH1faYKPYJDqtlabtC68i3nu09lsZ
         wSj4X0aZzTf8SywJsNYKoIAzwgeZ3mVgOpQt8KE0hyft8LiMsFhP5a5zpdHz+mdD0w8K
         eYsIjco79ct0lvrGwTYi5DwajGNinmi4sgx3joyPH7uvSZico+j9FeKFeTnaQ9h1BaHR
         7rJK+29PGsvZ1Syqy2se2vYHVZYnY/inwGptJyjAMEzMxNo8SS+Wx5JNSKXqn4jIjuu7
         FskFHBFv7bsS5zhl4cdOd/f5++CkLlI8SBExVMQFmAi2NHso/4wz0/4RPjIdsXYVYkp9
         7iHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMfsRJStMyeoYisvT2uNWe4wJIzySpkTedlw+y0SFdKqnTTLL9eehAGMTPafCdRyj+IY+IHgkvY5UlyAT+Qqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTwO3Y7b2fEvku9IbpLeiLoyNaduyludHzzyqJonPsl1giKcm
	RVGKefshZMqvwZc3mwyzMt2fFO1lKqKa36bwvcDttwXzpnLYChqBMjGwLSEzU2E=
X-Gm-Gg: ASbGncupPXx18yRX4YfMH27L8kxms9XdkZUx8QE0UA9k55cyhWEyqr7/b4T3vJWedCk
	KhClQY6YQdwt3JjOVo50RkRoRDpSo7PSjIp9SvB9xhzmcg2zDA7TOeo2nwy3jzKWzlXCS9oiDVx
	2udSTfoZeaz7BU6ZF/S/Hkzm6iHzXwAOFkHpGt0brD231mcZ6qWpeBhjn1NGUca0saVWBLIoKaH
	kW9WVFWv9tVIzdLH9pKh6Vpbbl4IgyRQk+DJ7ZSOhn2wiFWh8rjCp7D7UQAzd/JaUoH20pcKm5o
	sNhS11olq24xGr+2awRBLRyFlwFwAUt6y/nvXSZwf0+NS/Y9eKiXSLp2VUmHAQ==
X-Google-Smtp-Source: AGHT+IHr33UkYRxijRAM6C0PAuYUzQs+dTqaVy/R06IhM3g32uMluoDz2LA9U/xU2npCtEVgmVtjpA==
X-Received: by 2002:a05:6e02:1543:b0:3d9:6d60:709e with SMTP id e9e14a558f8ab-3d970a946afmr491905ab.4.1746048514197;
        Wed, 30 Apr 2025 14:28:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f40b9fesm10153365ab.49.2025.04.30.14.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:28:33 -0700 (PDT)
Message-ID: <041c11ba-476c-4a2f-b5ba-d686d403a023@linuxfoundation.org>
Date: Wed, 30 Apr 2025 15:28:32 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kunit: add tips to clean source tree to build help
 message
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
 corbet@lwn.net, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
 <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
 <20250430071825.1e196cb1@foz.lan>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250430071825.1e196cb1@foz.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 23:18, Mauro Carvalho Chehab wrote:
> Em Tue, 29 Apr 2025 16:27:12 -0600
> Shuah Khan <skhan@linuxfoundation.org> escreveu:
> 
>> Add tips to clean source tree to build help message. When user run
>> kunit.py after building another kernel for ARCH=foo, it is necessary
>> to run 'make ARCH=foo mrproper' to remove all build artifacts generated
>> during the build. In such cases, kunit build could fail.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/kunit/kunit.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
>> index 7f9ae55fd6d5..db86a396ed33 100755
>> --- a/tools/testing/kunit/kunit.py
>> +++ b/tools/testing/kunit/kunit.py
>> @@ -583,7 +583,7 @@ def main(argv: Sequence[str]) -> None:
>>   						'the options in .kunitconfig')
>>   	add_common_opts(config_parser)
>>   
>> -	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
>> +	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests. Successful build depends on a clean source tree. Run mrproper to clean generated artifcats for prior ARCH=foo kernel build. Run 'make ARCH=foo mrproper')
>>   	add_common_opts(build_parser)
>>   	add_build_opts(build_parser)
>>   
> Would be better instead to detect if the last build was not done
> by kunit.py and call "make mrproper" inside kunit.py?

Detecting last build and printing out the right "make ARCH= mrproper"
command is good. I don't think we want run the call make mrproper from
kunit.py - this shouldn't be a automatic step. It would be annoying
to loose build artifacts if it isn't what user would want.

thanks,
-- Shuah

> 
> Thanks,
> Mauro


