Return-Path: <linux-kselftest+bounces-14565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0482943572
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F41F21FB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7A13BBF2;
	Wed, 31 Jul 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEg7gBcY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC6C38FA6
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449577; cv=none; b=PlLoHZvY/UDl4TjVP79uZuGpIo+AEeM/q97Lp2jUntFv3pVgT9e5pCvOuabNwUQ0Ld0biteWozXAZ1NT4PdC5rjw6G263PPspE2fj8/HByzSkbN4s3PNopuqwem/lz7CJZLTaZlKA6zs1yuui0ZdwntvJoBA8l9XIm8nUw56zGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449577; c=relaxed/simple;
	bh=S0MQ2z3dmBqZt6+3Bx7AfL2LRp26WD88yxieDIts1Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL+ArF2AsqVdzi7/x//eIuy0ojtP6FXIZHObdAJigAjYCJ/cxsxQ8icoW+MxmNcgF+cHQMxzYBj9amEgYOPkVVBs+35baNyKHovh2knRsmEl+71T42G+ZlJmmO2fg6Gyku4BxeQqOgnl8kNmCKs1d/2gWtcoROx0+dZDnwc2HNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FEg7gBcY; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81f8bc5af74so35356739f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722449575; x=1723054375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJBncn61k4ebAYF7HIFvMqHJSlvpAG+JPwvZ+JUXIck=;
        b=FEg7gBcYfVqzAGS6Hm3oV6gksLCgq/Ds5aI5wY4H+Uuvk6gPAMPNm/rFmyTzV4jgT0
         cDqPUeLy89MYPvh/E+YhsOB5Goq9iO29oBwORseNaM5vpmYtn4fQnBpemZQlY1oGcMaA
         s9oeb+AjUcPEVpff/qVhs8qlnk7ozdO91faN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449575; x=1723054375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJBncn61k4ebAYF7HIFvMqHJSlvpAG+JPwvZ+JUXIck=;
        b=r7kwFc2O2qDdPNzGvCQu/hU9qYXKnCjtTGa8U710QHr+963eIBuj9xio9/7i0WwKXE
         yvF1Sa/WjkGkJ6x498Hts6pZnOcw1aJ7LSgwIdwk0Xbbq7oMtp1EeQ8FJHYFdwECc2GB
         7nMFVgHCOLWOG5An45sto/WBr5ge6bZ14uI++nPUEozjP4ZUX3N1AEZlyynCJlBCPlJc
         AhtmmkG6+j4OKRFBlcAXy7q3R+KCBxfINa3KLkIwqsw4R4XadyXSHImGh6/cnHo7j5UY
         rlriLSAo0MvlucTozmx3J82zdWWznp24fDQPKDPSiPHirMCE7fcH5h+axzCda5hzTiHJ
         evuw==
X-Forwarded-Encrypted: i=1; AJvYcCUxwv5UVt26NpFCdldtv4iEa/AK8eCDXYMIxeBXsEcdXrakAFHh99rj0t4hj4GGwqQlU8HMWVN2Zi+SA3sbHNBmEnwJR44eXZR0pUZmFHpj
X-Gm-Message-State: AOJu0YyOtHtnyuZUHJSCp0gAQoWrssjKy4UdRj/RDS1B5t5lRXgUv/R5
	6QGFHQAw9BlHpiw7dwjdGnJuBXNnjbxmB3+eehTjDt44lgBPHkNEOzGcTIvB1Aw=
X-Google-Smtp-Source: AGHT+IFTOL9folxvmqsGsGihzUJMIxe01fGordOndxhE2uHPb2+FQ8qHMfim77CH3RRL6kK61zayGQ==
X-Received: by 2002:a5d:958a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-81fcbe581b4mr12908339f.0.1722449575146;
        Wed, 31 Jul 2024 11:12:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d7ae876sm416014139f.32.2024.07.31.11.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 11:12:54 -0700 (PDT)
Message-ID: <a0b7f869-ac4f-4cbc-857d-a186497fca14@linuxfoundation.org>
Date: Wed, 31 Jul 2024 12:12:54 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
 <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
 <5B0BBE86-C3F3-4CA3-87F5-49F0DB1B28EE@kernel.org>
 <6d903772-2186-4d52-8391-df5ac2682b84@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6d903772-2186-4d52-8391-df5ac2682b84@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 23:13, Muhammad Usama Anjum wrote:
> On 7/31/24 7:33 AM, Kees Cook wrote:
>>
>>
>> On July 30, 2024 3:36:11 PM PDT, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>> On 7/25/24 08:44, Shuah Khan wrote:
>>>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>>>> The user test suite has only one test, test_user_copy which loads
>>>>> test_user_copy module for testing. But test_user_copy module has already
>>>>> been converted to kunit (see fixes). Hence remove the entire suite.
>>>>>
>>>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>>>
>>>> Remove fixes tag - this isn't a fix and we don't want this propagating
>>>> to stable releases without kunit test for this.
>>>>
>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> ---
>>>>
>>>> Thanks,
>>>> -- Shuah
>>>>
>>>
>>> As mentioned in other threads on this conversion to kunit and removal
>>> of kselfttest - NACK on this patch.
>>>
>>> Please don't send me any more of these conversion and removal patches.
>>>
>>
>> I think there is a misunderstanding about these particular patches (for string and usercopy selftests). Those were already converted, as desired, by the maintainer (me) to KUnit. These associated patches are cleaning up the dangling kselftest part of them, and should land (with the Fixes tag, which is aimed at the commit that did the conversion).
> Yes, this is misunderstanding and these patches should be taken to remove
> dead tests in kselftests as their corresponding test modules have been
> moved already. So these patches are fixes.
> 

Thank you both for the clarification

Applied linux-kselftest for Linux 6.12-rc1

thanks,
-- Shuah


