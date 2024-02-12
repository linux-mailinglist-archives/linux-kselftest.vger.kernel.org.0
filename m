Return-Path: <linux-kselftest+bounces-4535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C8851E6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE57B25EE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631A47A73;
	Mon, 12 Feb 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNxMQvZq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9E4C62B;
	Mon, 12 Feb 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768460; cv=none; b=CoPNMcIE09E3CmaW5oYc9sR3hnTwwbHv0ybqzhPm6Ecd2P13ZHnPxWj5xI0WbVf3rUhceqIi5DoJS3iuQlYGZ2HMbVcI47Yu45ldy/EtvNMXkcXSy1ys1+nzwR3RJLVgb7PmiKVKv0cmb4WjHmYN5YDAuVWjA3/QNvD6Tlonv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768460; c=relaxed/simple;
	bh=tQQift5LfRYMBN5EkewDff6150iLifRgZR9xWKCnQZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWOoW+Am2RidqCak10nzWZ3nsrtZRBEGAvLUNbZ1RSiFDFDvUMvQ57lBXag/xiAZ6P6IQtLGXl0QLUtpn+r71z4TM/FxdepBcAITi1QcRM1jKOEVI4qfCjebO6L+5Pm+nPYLhtD30wF+7BKfr3k480Ug5+Cc2zxZIJMNAe6dEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNxMQvZq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a36126ee41eso476440166b.2;
        Mon, 12 Feb 2024 12:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707768457; x=1708373257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zs68NSeXbrdOJSL/Frd8RI1CL1CBaz7sRpwcD3iAyMo=;
        b=kNxMQvZqxOgXg1icuedkbGd/BzAEkSyReihjL8hNfD+p2RdOErQlik33+3DvWuwu/l
         8swmxgg0Yt0Z++fsHqxnl6CXmKbobt+L9Dz4aJJxlp2JAB32sQ//t5esh1FIvBMbWDfS
         y9YFBKgg6nVDz1i1lapsh3nTLd6iwg+QGYWjXPHbU8gUdPkWFD1wOHl9WKm87o/KjpMz
         neo/032De370kmOoD2Gntk8EfGjwuJtDIjzAuE/6nLtwvYr2NeiscXC5+SZ6HRH0zRWb
         9Hr8So4cvS8WpvLMu880pZoD831gymWfw9pVPKytWHD2cHlVlDmw7YNVGYN4gp5k89Fk
         Z0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768457; x=1708373257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zs68NSeXbrdOJSL/Frd8RI1CL1CBaz7sRpwcD3iAyMo=;
        b=q3PWfSLVDJUJb462JdTmsoMLhKPyst6TB/W6XJLClPUOddvwDkYRGC+3rHKYZRkikT
         V4YM+b+/vJSqWojyc0yMKJ6eU0QoqPh7Xw7fz1JY3jOoL0K24a0j0kU6e7pnqMfyPGjf
         wf7OsSBvPyyYT0ylgDtQWttz/NCsB7Nn5bfduV+KWA7A7C2gfFtvwQLPqD1FY07ZyLCk
         rwzc8Fjtj2j4zcAWib41Qg3pIH5M98wO248aQKz4ewqIpEKnW/aBUJV/xr10WHzm6ltJ
         +1QvDK0wuQ/U9ABmKfDSa9uL3qYazH/Ryw7PkEbFDX06cdwKbwsnY2Ex7jee9QJ/vdE4
         zifg==
X-Forwarded-Encrypted: i=1; AJvYcCWr32MHFjqrMszsEPFA1iBaHW0EgTGUoKiOymQFtP8S3fiWCmsZ8G1UoxxfxmB9Ljp2ZWhFRKbMXWi5mgvzTLpbCy8KplZPnJCw9ttERochhY8IP1ws9gLu5lYuhQH2lOyLx6A1/vsQ6tSGF3tt
X-Gm-Message-State: AOJu0YxJhVHoFB6e9o36QHSFgqRIXrlTBPO5g1bNpVaHNua/Bhg37ndS
	i7UL8haLD7ilwjZQEPM3hdZcdbv+jswbgbDLSQT0SUMqsZC2CHPj
X-Google-Smtp-Source: AGHT+IFZNrIdyPlOojmPw/Vtneu8i5ljKX7bOkxoN/8q79yM7pVvigpgwQs0cCSV9cTuLRKXJsYomw==
X-Received: by 2002:a17:906:5f86:b0:a36:f314:d8be with SMTP id a6-20020a1709065f8600b00a36f314d8bemr5074626eju.38.1707768456866;
        Mon, 12 Feb 2024 12:07:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxcwKeZlo0/7vxs9xbplYLDnaPVyoYNMvATTccD+tfjvZ5Jwm4BWKhRBppge8PXaCts6wbUC/OUDdjNE5yJqURt1tQfcTEIdmWvhwl+C+uOzKeQ311uvxo8TMk4RqS8VW76sopORO6+LvJECrTKTCFCQXRRF2i61lrp2VzO+liZ4rZBbZLgaG5fHWJlPtPaQ6r7CMo8GQb3hKBRuyq7Sq39+JtuWxHDltCEHqn6bjgDf/Tdg==
Received: from ?IPV6:2a02:8389:41cf:e200:8e14:1b8e:d285:8c63? (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id cf11-20020a170906b2cb00b00a37ad2c72dasm522798ejb.183.2024.02.12.12.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 12:07:36 -0800 (PST)
Message-ID: <34986860-41e5-4d03-a0c5-72af12e7e97c@gmail.com>
Date: Mon, 12 Feb 2024 21:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests: damon: add access_memory to .gitignore
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Bernd Edlinger
 <bernd.edlinger@hotmail.de>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev, linux-mm@kvack.org
References: <20240212195328.73406-1-sj@kernel.org>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240212195328.73406-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.02.24 20:53, SeongJae Park wrote:
> Hello,
> 
> On Mon, 12 Feb 2024 20:43:39 +0100 Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> This binary is missing in the .gitignore and stays as an untracked file.
>>
>> Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> 'checkpatch.pl' complains as below:
> 
>     WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>     #11:
>     Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>     Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> I guess the 'Closes:' could this link?
> https://lore.kernel.org/r/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
>

I will add the Closes tag with the right link, thank you.

> Also, note that this conflicts on mm-unstable.

Should I use mm-unstable as basis to make sure no conflicts are introduced?

> 
> Other than those,
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 
> Thanks,
> SJ
> 
> 
>> ---
>>  tools/testing/selftests/damon/.gitignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
>> index c6c2965a6607..79b32e30fce3 100644
>> --- a/tools/testing/selftests/damon/.gitignore
>> +++ b/tools/testing/selftests/damon/.gitignore
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  huge_count_read_write
>> +access_memory
>>
>> -- 
>> 2.40.1

Best regards,
Javier Carrasco

