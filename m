Return-Path: <linux-kselftest+bounces-14494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BBC9422FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 00:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D390A1C217CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3E1917D1;
	Tue, 30 Jul 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzlsCUme"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE818E051
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378976; cv=none; b=plBgHMOt7kK22j9ouJLEBidwCevQKah7+/XI7RxqaYAe2Sp7aLH8283dSRmMKFXSn5kHgrmjXjWG21hvKy32JowG43GkvN6l8zxfELanpszlgg1mvv9L9qLsmyqepa/jd+lYIbu5a3qYt86uSX3wvUBq3HVYTxqrlV3Fcjy01dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378976; c=relaxed/simple;
	bh=cc8vLvsFZ3snkQtVLxmq6IYaFp9srndCvo2xz44J+ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnrsEBgfOW1WSkOByuRVujHbIsGD6xjJX395eFjlXvVgCMT1q4qoA0b8qZQzUlN8L7rn37u2b2PhWjwwoKuPFu3hhqRGokxvhS6YVPV8MQBImFHdQAFrmDXffXjulawyvTrtD0UDrCMqSQM5/WmPk6fjsiaGuBq8k9d/eRVgztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzlsCUme; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f99bf3099so13049439f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722378973; x=1722983773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfufdps93lvhHBZU/7yGC32I/ET/zYnuXNh/RR8RkPU=;
        b=UzlsCUmeb1GWG3pXVAnKntEUYU+OB3FGr7Wd7D6hi5FvqANWKdLnghfvNrjEdSdft3
         1qifpwU4bWQeb3yr60VSezyW6q2nv3VY/igj5FbcprAtvnrB9OHui4q4hQ5vRMtK83vQ
         VhVlZ2Kwgti8cFniKyaZkv/9Bs767VRlFPY8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378973; x=1722983773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfufdps93lvhHBZU/7yGC32I/ET/zYnuXNh/RR8RkPU=;
        b=DzMNw6lMm4GJ6MRaMMDrufaWlfrlqaq7QyAN8PSQpXaDC4WjwTSr3qyMA8OrJHlIiD
         zCo4o/8GSPNrjIn/OCoVCz8mBDuNyU8nebqSx2S3B/IXf1s6tdQ3d/hCqMm9nZ3Y3QKa
         dPu9EUeLFptyBKGc8rW0vVb3DAbkqRl6kJmFAcZjaaOrnrpeapv2UvUmCFM7yWe8oXSR
         E+uxXXevcysDnBnmygK2D/3EojPExrHxoF9TtGVa6dTzoQSCR3Qoz5fO+A0VKOcc1LO3
         UrbOzdKuV8DwaM1OySzbweFdm5hWX5zrZGpLxJFx96DWchJZXLRY87MtpoeKAa7geeja
         voDA==
X-Forwarded-Encrypted: i=1; AJvYcCXE+vthu4AOWVI9PDaF1A1Cf4GAKvuIBOGOhZutaQahfvslf3Xr6FfBqSuJ3ZtIRx6rAukx/Kn7iTE59zr/3Gx1ssf8TH5MPO80V0SVp3Qk
X-Gm-Message-State: AOJu0YynPekfe5QLe6M1dcq7QbSnaLYdh8C8bSMz5FzpWRNu14pGhqjI
	I5y6B7oDwVj7fvFywZuKNzZ+sMtiv9RjLpYqyMLl9M17xEng4xPmBDSfWjwN1Zg=
X-Google-Smtp-Source: AGHT+IGbHwtVL0eUe7UecSlj4yXroIjkL5fDWuqr1JOjoz63uTFv+YGrH76ZeX+kX7TEvLqN/LgsMw==
X-Received: by 2002:a6b:d303:0:b0:81f:9748:7376 with SMTP id ca18e2360f4ac-81f974874fcmr670378339f.0.1722378973431;
        Tue, 30 Jul 2024 15:36:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbdbf2fsm2986709173.104.2024.07.30.15.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:36:12 -0700 (PDT)
Message-ID: <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
Date: Tue, 30 Jul 2024 16:36:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 08:44, Shuah Khan wrote:
> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>> The user test suite has only one test, test_user_copy which loads
>> test_user_copy module for testing. But test_user_copy module has already
>> been converted to kunit (see fixes). Hence remove the entire suite.
>>
>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
> 
> Remove fixes tag - this isn't a fix and we don't want this propagating
> to stable releases without kunit test for this.
> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
> 
> Thanks,
> -- Shuah
> 

As mentioned in other threads on this conversion to kunit and removal
of kselfttest - NACK on this patch.

Please don't send me any more of these conversion and removal patches.

thanks,
-- Shuah

