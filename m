Return-Path: <linux-kselftest+bounces-7319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53DD89A5EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 23:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758D11F22127
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38957174EDF;
	Fri,  5 Apr 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPRVBOZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDF171E41
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351277; cv=none; b=EeprcfdCb0G1Vpj8CWrUajSpVXJlfB9Tj0KhHVuueyWxr+JNKZS9XmtkgzNHKwL3U6C22V6yKAzC5qgrF+Fgs/aGzyF+36gzZySGpeSnXDjDLFDRLxEBUpCWUDc4BHx+Fl/e3pojKqzkqo9AbVLQCC6uN/EJkoDVfR5/P+dcIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351277; c=relaxed/simple;
	bh=7qfhjtYFkM6G6ZDJn3ZynqgAg7omtB8AHzvP+GXhTgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsXhf9x2XilNyk+BOPMDjIXK/t58nX6T3I6e9zzg+Vj+nSy1g35hxvXPS5eHRU6CesUYo6xZpKwnyLTEOp3pFS2AdIJ9kQZLBAmbcbcbt+oU1b8MFO5FzucVieltj7JrTjWrB28zcah4uylcFSxlRt2fZuzxdmK9IVVch4L5Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPRVBOZo; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a11328dfeso1159105ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712351274; x=1712956074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tFcMER8j7g+Kousn29UjGQVOvnMnxSE38Y7ZswRMOA=;
        b=XPRVBOZo9/KZqJNuT+uMaXeWmQcjeLORQJjde4wakAiBQUb43i+3t5eKkk0Lx75eP1
         UVS3p8oFawC9YFMbUuu/T8kjrbzVoZIPMutyRkIQiN3LAvd9XjTgPj0oDhZuyQT9T6Cn
         DknbnaZHIHjVAE1HTyYZAZOfC9FFXACEWDbXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351274; x=1712956074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tFcMER8j7g+Kousn29UjGQVOvnMnxSE38Y7ZswRMOA=;
        b=dO6VOfVNZMgwJZk7GxXm1HKFy8NtJr10UIblinm6MtCBR2VYd35Xw85bh5fAhRM6/5
         Ke9sZQbfhPOLB+w823qPyxnFoTf2HY3ql89/+1+oaZC8YK3Ub6vDxK3S5WgNEwLQPKxg
         1osgLq1e6G/MOlwt9eHk8n+59ANeccGoB49/wHJLSRD6aWnl7BaT7xGwgv7/t6zwd4k0
         xiGqR8GVWYDdtcAXagiCClIVVs54e2rBzCivoH/z61B9hao1ufihjhY1t0OxlP90TyT3
         XRvxRyw23D9lCnmJDoGDJ+FmFpVmc9lrrfszgn98VIOgOGtpkOKEdiJfVACRJjrFtO7q
         ndAw==
X-Forwarded-Encrypted: i=1; AJvYcCUYrW1AKD2IjJD0FbQY5WRFyZjSlEkp72lN9VTD9esG89D4Z7HCrEgtXc0N4UF8N3ye0bvTTk9ScDwZ7FmpG5UQgmmaIHLs4AuQCwszR0np
X-Gm-Message-State: AOJu0YwXtUC5voW+3y/gUOvSoHquw51L47DqV96dp/SeU5Oiz/7gjKM2
	0LObwgPlMyH0M+KOCzzVZ6NT4hRT4ox1zKvCplQYGemOp/5hbJUYzV3GR1jCYlc=
X-Google-Smtp-Source: AGHT+IFpUdTjNiUrmIGtr3vJSUg8kWEja0OcCt+9TF/CDdmE4VJ6Ro4tdKiAzi9GtH7u4JkONeQpNQ==
X-Received: by 2002:a6b:ec05:0:b0:7d5:bfd3:7237 with SMTP id c5-20020a6bec05000000b007d5bfd37237mr2616439ioh.0.1712351274500;
        Fri, 05 Apr 2024 14:07:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l2-20020a056638144200b0047efdf3a882sm784394jad.177.2024.04.05.14.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 14:07:53 -0700 (PDT)
Message-ID: <244a65f0-4f9c-444c-b150-ef3b18cfbaa7@linuxfoundation.org>
Date: Fri, 5 Apr 2024 15:07:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>
Cc: "kernel@collabora.com" <kernel@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
 <SA3PR13MB6372E672EA40B403EBE588EDFD032@SA3PR13MB6372.namprd13.prod.outlook.com>
 <d103fdc2-e7a1-4658-88ab-22929ae48a06@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d103fdc2-e7a1-4658-88ab-22929ae48a06@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 14:38, Muhammad Usama Anjum wrote:
> Hi Tim,
> 
> On 4/6/24 12:36 AM, Bird, Tim wrote:
>> Sorry I didn't catch this on the original submission.
>>
>>> -----Original Message-----
>>> From: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> On 4/5/24 07: 17, Muhammad Usama Anjum wrote: > "Bail out! " is not descriptive. It rather should be: "Failed: " and > then this added prefix
>>> doesn't need to be added everywhere. Usually in > the logs, we are searching for "Failed"
>>> ZjQcmQRYFpfptBannerStart
>>> Caution : This email originated from outside of Sony.
>>> Do not click links or open any attachments unless you recognize the sender and know the content is safe. Please report phishing if unsure.
>>>
>>> ZjQcmQRYFpfptBannerEnd
>>> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
>>>> "Bail out! " is not descriptive. It rather should be: "Failed: " and
>>>> then this added prefix doesn't need to be added everywhere. Usually in
>>>> the logs, we are searching for "Failed" or "Error" instead of "Bail
>>>> out" so it must be replace.
>>
>> Bail out! is the wording in the original TAP spec.  We should not change
>> it unless we plan to abandon compatibility with that spec. (which I
>> would advise against).
>>
>> See https://testanything.org/tap-specification.html
> I didn't know that exact words are coming from TAP. Thank you for catching
> it. We don't intend to move away from the spec.
> 
>>
>> The reason "Bail out!" is preferred (IMO) is that it is less likely to be emitted
>> in other test output, and is more 'grepable'.
> Makes sense.
> 
>>
>> This would get a NAK from me.
> Let's drop this series.
> 

Thank you. Dropped now.

thanks,
-- Shuah


