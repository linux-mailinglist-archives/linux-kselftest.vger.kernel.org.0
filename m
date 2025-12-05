Return-Path: <linux-kselftest+bounces-47142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C54CA8CC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 636C43036586
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1F3451B0;
	Fri,  5 Dec 2025 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+9ly+Gf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF537342C95
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959182; cv=none; b=dse4E3AKlXx/yrOF9ZNg7PyGTnhljks6cq0LMpIOjyRCxq3cnUBLJE61R+d3GWIINqAhE0pkXFpnIf9Yxm2IlfVycYA7a3Wj5GwuQr2m18vDAkJyGwCaT91IUmnMDsHMx4OTCXke2orGr5jTB30H5T0j6GkpkdNjcHBpe4DFy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959182; c=relaxed/simple;
	bh=14pKhhOlwj8VADM1+dgCRevwqsL8vEKUg7vlX+BXq44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN1zY7+SZOsugXcFlXiAPt64JQMnDs5rTckGNoyg7pkVTAPEwSIaEmTO5cePJ6mhkzB39T2nvgShWvNKPSoh33r3f8BpxayV9oP9g2YkYfJeuaAh1t6QaBzEFugWhJ+DSjNhvN+GAe3GIb+itPSgoqHTj025ooXKIBPaAzXJUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+9ly+Gf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so2572066b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764959180; x=1765563980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2RphoGA2uusC7kx+DPM5UoX7pwzwpNu3a5kRUrklWW8=;
        b=g+9ly+Gf8f4XxyrvceI4SfpPxkF1R+gWTPMcWrNKRdxiQsS1KTKe/zkUnI5LsjSf9A
         72E3lFkzV+EnH1uirghCJUnWbk4y4UBP5C7OAs6OMU9OAMCQGzf8U1nQvKYjurRbZaY+
         t7npyVlWc2p+PRWslxOoCFlADX2zipbFDWBuJLMEX/VQK85Ti5HNkIWMxE3Vz8FgcGY3
         i7zTFmcB4AeKU+K8Hfu+Chcd2ibBfRpM1gI/ADYAMfrTpofjH8imEaOP3cZS2Eg+3eK8
         R5XNSH2UnK4B3rxRVBxZWIS1kmk06h0g1/bcXACzeospjj1MauH3S2i1Q4eoILFjhfnq
         s8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959180; x=1765563980;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RphoGA2uusC7kx+DPM5UoX7pwzwpNu3a5kRUrklWW8=;
        b=OonZjgbJqEckfrhBpcS7iXvx2Dkyuotd3F5POdaH+N0WcwqVWkp5braQKV0q91UV8C
         t/o7FzJJmH1u9OmHR5carlrUkQ0y7sl8SWopaj3lH6EYY41Fb5FOooZzKiCEOJq4pott
         JBH4fySB6EE84owCNdLe7GCE6k0dLE2CYBZk3KOvdojVZd9MJ9W3nJd1VkT9W62eDvh0
         wcKj8rC4pIYFEDEtXwG7JOD2ikkRweG+1RSPSQ7sza6e8kJGdwjLyK8JZgrk6hhKOM3H
         nobqL75BEnh/f8p0oHC4P2ZAD6OQVDNtj4sn+Dclk3mgYrTS/etHwlaANgAdrfRl5zjp
         NYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQrXuqhhmBUJfVKFmM5veZR0q2jOOTQnoZLxwumkSl+jrdNbLzsTozFPb/EDSo8VGpycQfC/KChheXVvJs80Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9rQePKmz21fpRn9DWdHZ5mXrx5GZcYM57oXC6WkLuWpokAop
	ORyNj/BjxwupBC3SUCQFBCAYSoPsTL4kINOlW/z6AE/OX6pwrWTwXURWoqtu4Q==
X-Gm-Gg: ASbGncswKI5BivCQFASju9x+HKD9GrrUuOXTK/1qbpS9DXDrCqwXhRntx5ipUg9+G6p
	eYphFdVHA8OcB6atic7fmPjP7p8zWsjRw6fNEiWigT4788dUerv0TJ0HcaDKmj2XS3DjBaw0KEd
	IMCQJ5dvJfgFw2h1a0eglM8ECSr+iUesi/XtJxullzkkV2H4NRy9XFhLPm8Cdj8s1KQERZJNoGD
	vfxvtItERqrlpt2NKeQ0g2DfStbXVPV3wlYwh+Xb+avey+7rcLIZQZD9wXvKpIORdD65ijgI+w0
	hq/rDz41O8s7IF1o+psjBjCSCI95AtVG8OLbLLEXbjE/7x3xB809V53TTJ1BZFgs9zOaZ6YhbJ+
	EIJgJ6cIxJLESwGoIom4bEsv5lpOYGsbXq2/KSuBrkIPG71xtYpJMsJldTsiuD3YD9fsIZIxBEI
	KCt9Uqg5GNyK995Mgq4rmXib5pQQTNSJCxqYc9uvlD4WUOYgBSzbbiA6ZF6PY=
X-Google-Smtp-Source: AGHT+IF/2HBcUoNJyjKNnXsznND3RFIaBMXPKVdkGa4Dn73CbWeP3Yzvc7zghMTC/YOYSecM+Hp+wQ==
X-Received: by 2002:a05:6a20:7488:b0:366:14ac:8c6d with SMTP id adf61e73a8af0-3661801eeb9mr188408637.67.1764959180023;
        Fri, 05 Dec 2025 10:26:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a14f5d0fsm5270110a12.23.2025.12.05.10.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 10:26:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <45c3161a-0c57-40b0-9561-6e9d71f00049@roeck-us.net>
Date: Fri, 5 Dec 2025 10:26:18 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
To: Amir Goldstein <amir73il@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20251205171010.515236-1-linux@roeck-us.net>
 <20251205171010.515236-13-linux@roeck-us.net>
 <CAOQ4uxiqK6Hj2ggtcD-c7BAtuBcm+LrKVkQOxi93OXhwSE98Dw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAOQ4uxiqK6Hj2ggtcD-c7BAtuBcm+LrKVkQOxi93OXhwSE98Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/25 09:31, Amir Goldstein wrote:
> On Fri, Dec 5, 2025 at 6:12 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Fix
>>
>> mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
>> mount-notify_test_ns.c:494:17: warning:
>>          ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’
>>
>> by checking the return value of chdir() and displaying an error message
>> if it returns an error.
>>
>> Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Update subject and description to reflect that the patch fixes a build
>>      warning.
>>      Use perror() to display an error message if chdir() returns an error.
>>
>>   .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
>> index 9f57ca46e3af..90bec6faf64e 100644
>> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
>> @@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
>>          ASSERT_GE(ret, 0);
>>
>>          if (ret == 0) {
>> -               chdir("/");
>> +               if (chdir("/"))
>> +                       perror("chdir()");
> 
> ASSERT_EQ(0, chdir("/"));
> 
> and there is another one like this in mount-notify_test.c
> 

Done.

Thanks,
Guenter


