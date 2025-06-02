Return-Path: <linux-kselftest+bounces-34187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7662ACBDAC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048551890D93
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 23:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB01F5435;
	Mon,  2 Jun 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="APh+fIgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A91C84D0
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748906553; cv=none; b=Xh5Wo0K7I712ZqMrEFxyO0ccDoaGw8z7ejJOfngGird7Cvk2wZr72Nz+ZRGrtx3jSzrRyVqBbKjY2/8GADYssemv+aBxkn/0MGdb2E8QQ5KyfwNkJuTTpnNCkTlp5QZe2dtg1UMS2lW5a+xBJCWNPA0BSfSjANbYdRRJI8xPEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748906553; c=relaxed/simple;
	bh=CfnMNOCbjMEyJoz3Q1bK4Y14uGlSI1+jGpZw9hAUQRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubR6XiUHbQ+RVEiDPBSV4W2bHGMF7f4VrbGxZMXx631s7AQkHaOeLXN0p7i+BSpk61mHu/jLPgFX49ETrcW1ps5DUEMBIs9ohLI0tn1lgDWpRSaFnPosxMwEVAo9EOjRZVqFQpADwrLWR01RhZYX/YgvZVx1FWDPCVwfuOUo7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=APh+fIgZ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dc9e3bd2e3so14466925ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748906550; x=1749511350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qT3wVHWE1rM3dJa7hjPLW9JGzPh24mia4Xa7cI/6U6k=;
        b=APh+fIgZbRaTlMBg0L5hPvD/oK9hS7dThYSeRpST4VS9zDZhxrckC/9rMpjXM6QTGW
         6Ws4lzX+j3sGUxu7c/scW76ocN0qlicnMhFNXpb8knwTQiq8gfZXbfl6dlqmdt62u3B4
         Vz05n4coSIcATKp9hle8EHcOu1n652kuMfBDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748906550; x=1749511350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qT3wVHWE1rM3dJa7hjPLW9JGzPh24mia4Xa7cI/6U6k=;
        b=Az++Q7EyuC5Jg6XDa0d02EgSTsDpv+Cv3xr4uKOc8HOEOQjzFdsV3Ou0zq4Q92Hxj/
         nJqcwT9LY9stbxpesUV7qW9CLF+Bjrfd+WaGZJEqYqVFTe+lY4B8G3uXMl3NQLcTON9P
         jpoCTfGTqnM4ItWeX8DZAy4lhukjyptz6LVKyxhacivy+rr/Jz1qvgHe9CNQ1OYlBUWM
         bm79pNBWsPWEqutX2FVn7SM3LZqMJdgqzxC0izd9tgojCEf3NCjI698eSMoVx+oFKcDx
         b2GDbH9oVgghomsK5luMLgzIX66mgBUhGhEtuu3Qyq+Tu1IjMFm+tZUoJihNGI/NHJXk
         M2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWnS5LbTy5le5USL25VeJdm6je1F4n3FJTFYTepiOfs72taRzB3O5tn2VvuV6HH/FmcTrGwuxnXbhem8BTEE3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9b/1Fhg9EDnkHuxoL5USTq/LWnh9/1G06eJFyrGXe1SRhd5LK
	eAHq518/r1emcJCNp/PTMngubqEKn2sVqF+jRpf1MLxEr4GllqdryFu3/I4k0MDD77A=
X-Gm-Gg: ASbGncuFb1mew20bP3kVbzCbWl+Zgu1Uz/jQYCDt5fP3HAmebXB0ILAG2amo09CzCue
	Izdv7SJ8g5Tz98b8exWD8yot/lZB9bnmarkllVwFOXWBV6Kw6S4hZh6YvR79mdrYsyNwCI7BB9w
	WmBO3CK/FbWiIrlHJKSABc83QR/yxfkIPWHDR5VPJX65DNdbJ25M/F1o0swYPxCqqExZruuuvhe
	QD/ZTD3zlk2AXQJIelmQJMy2zNq4a2OqrFAa61acf/yCVb2nO+xOaC2USkcglTmU4ntiOR+j64Y
	PJJ77D4TjtIrfMJ8KhGAymjTtBbt7MiNHg3IQmG5kY0xEkxOt15Xbd39OFdUfw==
X-Google-Smtp-Source: AGHT+IF7uLkYyb2UqK/tGnOiuFb0m76VobbyWvrOenXTHdPcdfk9UTH7o8q1NlmnaIuPiCjJgFHuQg==
X-Received: by 2002:a05:6e02:230a:b0:3dc:5be8:9695 with SMTP id e9e14a558f8ab-3dd9c989d83mr143426925ab.3.1748906550017;
        Mon, 02 Jun 2025 16:22:30 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935a7ad0sm24412105ab.66.2025.06.02.16.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 16:22:29 -0700 (PDT)
Message-ID: <c7c071ed-6a4e-4a9c-ba9d-c745fd42c22f@linuxfoundation.org>
Date: Mon, 2 Jun 2025 17:22:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: firmware: Add details in error logging
To: Harshal Wadhwa <embedkari167@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250516153955.111815-1-embedkari167@gmail.com>
 <73a4b1c9-44b4-4f06-a766-ea7ed391c578@linuxfoundation.org>
 <CAPCCTVOXHUh7j6Vb=dmnY4wi37f4NMo+Pumuho-sA7jq1iH_fQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAPCCTVOXHUh7j6Vb=dmnY4wi37f4NMo+Pumuho-sA7jq1iH_fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/25 12:26, Harshal Wadhwa wrote:
> On Fri, 23 May 2025 at 03:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/16/25 09:39, Harshal wrote:
>>> Specify details in logs of failed cases
>>>
>>> Use die() instead of exit() when write to
>>> sys_path fails
>>
>> Please explain why this change is needed?
>>
>>>
>>> Signed-off-by: Harshal <embedkari167@gmail.com>
>>> ---
>>>    tools/testing/selftests/firmware/fw_namespace.c | 17 +++++++++--------
>>>    1 file changed, 9 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
>>> index 04757dc7e546..deff7f57b694 100644
>>> --- a/tools/testing/selftests/firmware/fw_namespace.c
>>> +++ b/tools/testing/selftests/firmware/fw_namespace.c
>>> @@ -38,10 +38,11 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
>>>
>>>        fd = open(sys_path, O_WRONLY);
>>>        if (fd < 0)
>>> -             die("open failed: %s\n",
>>> +             die("open of sys_path failed: %s\n",
>>>                    strerror(errno));
>>>        if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
>>> -             exit(EXIT_FAILURE);
>>> +             die("write to sys_path failed: %s\n",
>>> +                 strerror(errno));
>>
>> Hmm. Wrapper scripts key off of the EXIT_FAILURE - how does
>> the output change with this change?
> 
> In the whole test file, all fail cases uses die() with the specified
> error log and error code, so just wanted to add a error log for this
> fault condition and maintain consistency.

You don't want to make changes to be consistent, especially when
the change alters the behavior - this change changes the results.

thanks,
-- Shuah

