Return-Path: <linux-kselftest+bounces-12885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE691B0DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 22:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5821C20322
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A719538D;
	Thu, 27 Jun 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb0CFj0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D534EB37;
	Thu, 27 Jun 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521368; cv=none; b=Znb2MBffdz3w5PIVaEsqTAzFW0fxrp2zGGpzlgyxcF6DRjksUJcGUDEPtiek1cUmzS5yxxcSdIvjQHDTy6JUCOER+vWfxj98F3bEO1tLgRPmRW8ZNlk6wSa+BubZxpWASQ7CL7ifUBX2KxmUme02YRWh0FszlaO6c8BSBmuP3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521368; c=relaxed/simple;
	bh=9itKQ8NPvTVa7rAwdliA6XXmBJcdkDjX1DmA4yRWAfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBjjyIlJi1lM01LHth+hgSzlpIt0gn7syC2sj+2w0yTsPBvBbE1g/WNBBRARgYK8700YgsdAR6ayLyc+W05yVijRBu3qBARYi0taarFWc0ant0c4z5PRfgW/1HC/OXLkka64kcQrwXiYERDMTYdSyyINi8x0DOK5o4aOFt0rKes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb0CFj0K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424ab8c2d95so3747905e9.2;
        Thu, 27 Jun 2024 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521365; x=1720126165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=712BBCnkNdAhV8vgO2qEZbgLKKlhXAC/8YoQa6MyJOc=;
        b=Cb0CFj0KklZmp+8ALugfzZo71IOnqiZHeaX0pPOoocQfTRAXlJBY7Ut6xTqRFH6Kqm
         p2nlnYO48UsDsIc/ku6TBDbez6FCf65UNTXeVHPMrvS0Q5iITBK/msVSACW6CYc21oEm
         IJaoPuqyGVHONAlrJHQr0bueLuHvt9gNeb6NYgWx4uxVa+K2OHTsHMxIg8ggbrCnlmai
         SFUbWpQW2QJ7qDr6KzhA5RWpzIwPwjbncxVU+dltmVmV3PchvJwqHO5C4rllTgumuUyf
         l4rJfmAC78RxV6K1tl+M0dQS5QUcnWGik18T7Ik9Opb3cf/bmM8lVrYYVmM2Z3u4VMkm
         DTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521365; x=1720126165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=712BBCnkNdAhV8vgO2qEZbgLKKlhXAC/8YoQa6MyJOc=;
        b=nHPRCqbpsGEo7WuHHiJovE0LpHq273sk5l1fiqJQGvAuHPbspaXKnFvltDM1rwkhk/
         +wg5a5KQKaDRFl6ybAGhIS7XeI0Udg/8pJVQAwvgHxGeDFq3AVW+sxvR3jcZFwzJ7wHA
         3TpWAimZ6NKZF9U+L6EmW551MrB2ZWWSvLFffqHw72sJpkzkxhl80HUVHH/IvpBacFjB
         JqNenP19EzVcsBSMjk77freGiioqRLYy4Y3xdwcY1Z/Xr/UnYStG4VkIf8G4V1sI6IPX
         pck1OLVwjHslreqZ/79iZq+jpADQ9t1X2EvUsFrmbVC667+xSOyjCSWfHQYELqEGYpNL
         ZY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUF3w8HA9JYBgUnWldgQFiDzZ7xtbY3eRZvX84T6DOdr8gKJQOznZvwVfmyy+RSelVi8tydqLYE1UdzWdMcfUFkH4LxU8Q4GTg+mSvk
X-Gm-Message-State: AOJu0YyRAbi+UdczJuLYJfa645b+Uy5US5XB01LR3MOb1x++faYZg8+q
	QSH1fK/4eNfhUCPa2UpizfxsILO7yQvG07O/ufr2m2isuZOcrWM0
X-Google-Smtp-Source: AGHT+IF3FRjrbOPc86T5q4CmYnylpgdssA66mUjBTNsE2/t0rwKdUVUy8dYyOpl+55dG11uvZ5EVAQ==
X-Received: by 2002:a05:600c:8a4:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-42565b1b003mr19406175e9.0.1719521365145;
        Thu, 27 Jun 2024 13:49:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:8731:b664:1f4a:5ab4? ([2a01:4b00:d20e:7300:8731:b664:1f4a:5ab4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf85sm7349855e9.4.2024.06.27.13.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 13:49:24 -0700 (PDT)
Message-ID: <2f45ce9b-3d12-4cb0-9a52-a053bd4bfe50@gmail.com>
Date: Thu, 27 Jun 2024 21:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] kunit: string-stream-test: Make it a separate
 module
To: Jeff Johnson <quic_jjohnson@quicinc.com>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
 <20240618170331.264851-4-ivan.orlov0322@gmail.com>
 <dd58758a-7689-48a3-bc89-2cef3858c4b4@quicinc.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <dd58758a-7689-48a3-bc89-2cef3858c4b4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/24 19:09, Jeff Johnson wrote:
> On 6/18/24 10:03, Ivan Orlov wrote:
>> Currently, the only way to build string-stream-test is by setting
>> CONFIG_KUNIT_TEST=y. However, CONFIG_KUNIT_TEST is a config option for
>> a different test (`kunit-test.c`).
>>
>> Introduce a new Kconfig entry in order to be able to build the
>> string-stream-test test as a separate module. Import the KUnit namespace
>> in the test so we could have string-stream functions accessible.
>>
>> Reviewed-by: David Gow <davidgow@google.com>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>> V1 -> V2:
>> - No changes
>>
>>   lib/kunit/Kconfig              | 8 ++++++++
>>   lib/kunit/Makefile             | 2 +-
>>   lib/kunit/string-stream-test.c | 2 ++
>>   3 files changed, 11 insertions(+), 1 deletion(-)
>>
> ...
> 
>> diff --git a/lib/kunit/string-stream-test.c 
>> b/lib/kunit/string-stream-test.c
>> index 7511442ea98f..d03cac934e04 100644
>> --- a/lib/kunit/string-stream-test.c
>> +++ b/lib/kunit/string-stream-test.c
>> @@ -534,3 +534,5 @@ static struct kunit_suite string_stream_test_suite 
>> = {
>>       .init = string_stream_test_init,
>>   };
>>   kunit_test_suites(&string_stream_test_suite);
>> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
>> +MODULE_LICENSE("GPL");
> 
> missing MODULE_DESCRIPTION()
> this will cause a warning with make W=1
> 

Hi Jeff,

Thank you for noticing this, I'm going to add the MODULE_DESCRIPTION in 
the V3 of this patch series.

-- 
Kind regards,
Ivan Orlov


