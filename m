Return-Path: <linux-kselftest+bounces-34076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D88AC9452
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB654A3CC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372B1D619D;
	Fri, 30 May 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HM9tOlRV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284314A4F0
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624652; cv=none; b=azcmcCSPHD1YFVFO5mFObM/P1ng1VOlYx8QSIC3f5FhmlmwSeIkzOqoT9Yv+VSSYnTTKxOBpN9qvy3IutMO3JuBG4+kLCMvWvV/fUMSv1JcqdxIGa59XRvnK8ULmNssL9LEGG9lRRivNnLhvAoJhZDwEiONX3fA6B1rsDeHnrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624652; c=relaxed/simple;
	bh=rNCnAenY8Ad5bsIaOZF+Zf4Al/gRRnjtnKUNbK4d7OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUZVAL6Mp8RDDqAoNLojtbmJLhAa3wWwgnUOjWvgZN1yj0F6TqozK/iesHg/eO7kfpgfSFWjaSWOF+fSkL5Hug3CIjFUfuZfa10gcf7ZjKRT9yQ+oxQ5Bh7DF1jbwh/PUa73En52MstpWbeZzJB/g0/nCN1QceF8fWBhops1wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HM9tOlRV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6face367320so14250666d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748624649; x=1749229449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24qe/xyB6X5FQMMCm8zjaCW0EV4mdf1CAxWLXZQVNAM=;
        b=HM9tOlRVgadNMihsxrhjpr6IJcZBYlMBOo9LBf8JOSjNF6wnG7UfY9EaXCbSD7KUyE
         eYVrmR9kgcJlO0G0Wc+Eg7o8L3j6iWawMVLkz5S34E/qNdJVLe6LlHYBksjptd6A1zWv
         FCxTLHO4QsyOdrg8P7lgU1Nzgkz5qNsBBvOTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748624649; x=1749229449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24qe/xyB6X5FQMMCm8zjaCW0EV4mdf1CAxWLXZQVNAM=;
        b=XhcFgM3P/TpzeWMTAaLgVxlP+Sz3ajiIz4jS5qWk4nR2YNyETAM5riCBqdvBvCtoXl
         AIs05SIl60IDzmE57DfK5hySTZ3dDwO63+6XdRSxbRGgwPSfztQig0stnK4OUCQsArjy
         tH1cGVpr917h4hzmg99ahir6knCh6Btn1uIyjHOwwI6b1pXsL6Nioj6PncluTcPaA8BQ
         womLjTcofYacGG1noS5s4aA0MGHMml9JyuwXfgw/oxpN9fM9plI+AXMVGn+Shmk+zcHW
         C+e28sEjTmfKzyJRGdCxbzLGvAlrqBwTj/AIsh4HTbpspUAcWYYj+dSKp2cA2cv97W1G
         HFkw==
X-Forwarded-Encrypted: i=1; AJvYcCW2utNg0HDInH+ui7JuoX3lE8UOD9prIh75dkHQw8mdbszI9D/IrK4dqLK8eR47fm6shsWsvw7KpVPiPVO5iRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZASgRe089sMhDUf+/QGOpCWqcgP1CdcUyL2udgws0IwzOJjVF
	bEmSK7bVh05g4X3fNtuQXNOj9m+UCmuyRZSlhkxRD8rCuCN6MSJlU3c+Qke5LKVqbqUplj1545o
	qg3Ef
X-Gm-Gg: ASbGnct5B/InpNr/8tB79cZDzt+ZEe3bhqE3GIgICKsQdQbkWeuLPUno1XVCrTrhtGI
	/Z+cgPPJ13xRcn46FI9IGa7wygCEcnJ1Gm2A1tdb3SnjGtJSlHI448Y1wgQeeDnAm6BxrLwCcoP
	GOLrJ/OHRy4NOYm8BmLEm1UgjBQul9NEKFwGqHq3VHeAeB87Dn0crW+IpsgJTrPjFpKr03f6QMy
	2A7ugh/Ppqd32+YDUPSTCgl8pQ4lF3JxTTtxWfPDsPSkN2/GCkDb483lzuCf/Xtp62WQOE2OYUR
	6hGEWQW6KmkKEt8Vf9SxXGr7yMYguksShqiT8dAQc3H7PoIoJIK7JIdOhv++Zg==
X-Google-Smtp-Source: AGHT+IH8q+FpbqaoQpSMxQv90UHs12PrJul7zhJ4Jiejs0nou04xqJn9tgyjzjILKLWZMXwJWHkp7w==
X-Received: by 2002:a05:6e02:2702:b0:3dc:90fc:282a with SMTP id e9e14a558f8ab-3dd9cbf8ce6mr33605055ab.21.1748624638251;
        Fri, 30 May 2025 10:03:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f00b7dsm530225173.130.2025.05.30.10.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 10:03:57 -0700 (PDT)
Message-ID: <46ba862e-b540-4037-a0ed-8bf5fa12b863@linuxfoundation.org>
Date: Fri, 30 May 2025 11:03:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, brendan.higgins@linux.dev, davidgow@google.com,
 rmoar@google.com, broonie@kernel.org, rf@opensource.cirrus.com,
 mic@digikod.net, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250530135800.13437-1-kuba@kernel.org>
 <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/25 10:59, Shuah Khan wrote:
> On 5/30/25 07:58, Jakub Kicinski wrote:
>> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
>>
>> The commit in question breaks kunit for older compilers:
>> > $ gcc --version
>>   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
>>
>> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
>>   Configuring KUnit Kernel ...
>>   Regenerating .config ...
>>   Populating config with:
>>   $ make ARCH=x86_64 O=.kunit olddefconfig
> 
> 
>>   ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>>   This is probably due to unsatisfied dependencies.
>>   Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
> 
> Does adding config option work for you?
> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN
> 
> 
>>
>> Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
>> Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> I'd like to take this in via netdev since it fixes our CI.
>> We'll send it to Linus next week.
>>
> 
> I am good with reverting it for now.
Meant to add Ack.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

> 
> David, Brendan,
> We will have to enable this at a later time. Also we saw this problem
> before with other configs. Anyway way to fix this for alltests case?
> 

thanks,
-- Shuah

