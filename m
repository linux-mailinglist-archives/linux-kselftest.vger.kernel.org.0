Return-Path: <linux-kselftest+bounces-918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A27FFE12
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252A2281721
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1A5DF20;
	Thu, 30 Nov 2023 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bI3/0Z3y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2610DC
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 13:55:03 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b393fd9419so7923239f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Nov 2023 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701381302; x=1701986102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e04FJ5HkCxCNtwu/2sZDSNmWApJID/B0pVuXmiOybLU=;
        b=bI3/0Z3yaFfg5mTTaeGPIiomTbMIBAzd3d7/DmcnfgXjHaKsbBmovLVqVUy2jkE6vz
         qDvBLlqOfsJS0X26huoYtKHKcGtvTPR1RMVMGqIBzAnzBKo9JV7vpsEi9yBEueH8Dq0E
         ylsYWQzAixpHefuc3Un9UqFiCDePhK5LxTeEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381302; x=1701986102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e04FJ5HkCxCNtwu/2sZDSNmWApJID/B0pVuXmiOybLU=;
        b=fA2TYsCl+A7vN/9ToLv7r+sHaoE8lBU00XuXVNbbyGfQ0HP56XePbieZsntg78/Wrb
         zyiu1b6j7d8ZLDQKFkK5g5ZeQEeBGw17AprIkOYHXuhOnbmaIk/gf2L7luVNWXgzFUVn
         AGiAwOll2HslMY0g168jCfhEI2eII6F0JQUOhZb+43wLfs6Bjs8lKvy6mfEDWaX2RBbc
         zxlRoA5EuxH2JgLYMK+7xeUMY+WTsxjRLANjC+RCFgrfoCEZxSsSRdeJwvULVxXX7ihC
         7y3MJCmIh7V/Dt63DORdeTTZIv0jb9qYM+Pa/hQZOZpuLqjdStfIW1It1gAzvSilUdZa
         Oefg==
X-Gm-Message-State: AOJu0YxyKaVuTyaMNBTVZHWC+TVVr7RDoyGg4B3DH0UFRJC8iJE1sMiD
	A5QH/aNljjvf5ysbsEsKPhzbMw==
X-Google-Smtp-Source: AGHT+IHzdE0Pvg+4VyN4syVAt13mooU7RiUg8cDjPxDm8LSTAz93fMDB2rm9Jmm9vXmZS8r0gn3ayQ==
X-Received: by 2002:a05:6e02:4a8:b0:35d:39b1:6282 with SMTP id e8-20020a056e0204a800b0035d39b16282mr4330767ils.1.1701381302597;
        Thu, 30 Nov 2023 13:55:02 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id n7-20020a92dd07000000b0035d4633cf5dsm325408ilm.61.2023.11.30.13.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 13:55:02 -0800 (PST)
Message-ID: <329c848f-fa31-4902-9519-da771da0fd4a@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:55:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kselftest/vDSO: Output formatting cleanups for
 vdso_test_abi
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 03:45, Mark Brown wrote:
> These patches update the output of the vdso_test_abi test program to
> bring it into line with expected KTAP usage, the main one being the
> first patch which ensures we log distinct test names for each reported
> result making it much easier for automated systems to track the status
> of the tests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (3):
>        kselftest/vDSO: Make test name reporting for vdso_abi_test tooling friendly
>        kselftest/vDSO: Fix message formatting for clock_id logging
>        kselftest/vDSO: Use ksft_print_msg() rather than printf in vdso_test_abi
> 
>   tools/testing/selftests/vDSO/vdso_test_abi.c | 72 +++++++++++++++-------------
>   1 file changed, 39 insertions(+), 33 deletions(-)
> ---
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> change-id: 20231122-kselftest-vdso-test-name-44fcc7e16a38
> 
> Best regards,

Thank you. Applied to linux-kselftest next for Linux 6.8-rc1

thanks,
-- Shuah

