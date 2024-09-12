Return-Path: <linux-kselftest+bounces-17852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DE5976F83
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 19:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B9C1F2428E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671051BF7EA;
	Thu, 12 Sep 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e5aDD70e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F21BE86D
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162114; cv=none; b=bRulGaZCqwaGpvS15vWe5tGVWs1OliWuQljsQUGK7OsZfXYqUY/ajevWZrogbh1jDQMvhLcTWdp6GB3FUUUpghHd/2E1Z6hSUt1EWP0bjyPs9dX9Qj6tHlrphz+4nftwvHQc//6FVYQ0jdPSE9HjoAjb/OgnkwKaCiLkgsNIvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162114; c=relaxed/simple;
	bh=ZTp6DLZUohZE4ziOp5AQg/Ka4jQALIcTMbEk9b5B9VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqU5h5mN0mReCJ1jJ2acfU9L8BXJe7WAnD8uRAasWqdLByM2GIdFleF0Z8bDrt2Y880qeTd/+d0DeIE2bGhBorM9e+D3SvyjRKZARqaKKh0dLnoPxeGkSNbc9qWzY48TR+C4EAu6p6L5Q8/4HKB+nOxTMStbZw1PtTnc5KpaM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e5aDD70e; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a0220c2c6bso5499405ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726162112; x=1726766912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojQdylEuR/edm6P0t3l0EQbjxi/mFjIvSyby4tAxelQ=;
        b=e5aDD70ez4t5hO3hAMV2FHo9sCHjuEDnYo47hwKPm/uX3i/AM5sGOCZVE5zesl1fMZ
         /Uu/hDyzUr5e1Jh8tPA74+kqZgF8AQGATNMIjD5enPjLmTlI/mRgvq81PGjCTDD3nePk
         VImZndYHH9oqvR9AvjtWcAqKG0CQjJSgmU8vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162112; x=1726766912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojQdylEuR/edm6P0t3l0EQbjxi/mFjIvSyby4tAxelQ=;
        b=GTFwEwOePTADqa1LUpTIw4XE4YmXWs345s99J+ZYJWUss8/qJV2nTJSPnhfhX7V6j3
         tCymGt1LcHtoA2TCwWN671H238w/Ho4ER+DuQIzJhIuRABpZZ01pGs3RUfFvPMZJJD3U
         4dSlvhjkbyeTmJvsCctCMuXmatYnGRR5v5SLvDqsW1vibcyd/JV1Oo3cu51L7tQMGnw9
         mLS2V7Sm4gvazpVavoE3v8QhOru0fkCbSw6ORdjmpJaxz9hHnkX5zD+O9mCemePAzK73
         SCC7ZtZsDU1aZ82XUl67ijE0HU91NxuTCnE3CMGuZh+o2BV5BD6KRfI4fTJccDXAdMs3
         O8jw==
X-Forwarded-Encrypted: i=1; AJvYcCW+MyX97UY0pIJxTZtkiZLszQb8Dm1czYK/nHQha+oc83DOJRZ7kqjcbktgH5b8CJtrZKINyDkWt7ayldrgJi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXzDQNPOEzL1A9U57OrVekl6qL8PaliY6SSVgfEXryyd9UBi2
	IYZYrIfSvqFlg8SOXht2bWTywmsLOWoPJFS+TtcLmgA9nEj1Jue6WgGI41weAAcjKm5hZ+h3gM8
	o
X-Google-Smtp-Source: AGHT+IEyBc3XdFgDxw7hY6Gd9nsgNpNQtOKxJT4r9NCaxxvWyYvBogxI7FkBep7jhm5pjtRdduYOtg==
X-Received: by 2002:a05:6e02:164f:b0:39b:330b:bb25 with SMTP id e9e14a558f8ab-3a0848f7e52mr36208285ab.12.1726162111590;
        Thu, 12 Sep 2024 10:28:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a065816d89sm22413055ab.79.2024.09.12.10.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 10:28:31 -0700 (PDT)
Message-ID: <35f21581-71f3-4234-9b03-dd3e3bda664f@linuxfoundation.org>
Date: Thu, 12 Sep 2024 11:28:30 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kselftests: mm: Fail the test if userfaultfd syscall
 isn't found
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <20240912103151.1520254-2-usama.anjum@collabora.com>
 <3b700650-159d-45ad-91a3-59fca3019766@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b700650-159d-45ad-91a3-59fca3019766@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/24 10:10, Shuah Khan wrote:
> On 9/12/24 04:31, Muhammad Usama Anjum wrote:
>> The userfaultfd is enabled in the config fragment of mm selftest suite.
>> It must always be present. If it isn't present, we should throw error
>> and not just skip. This would have helped us catch the test breakage.
> 
> Please elaborate on this to help understand the what breakage was
> missed.
> 
> Also this commit log doesn't look right to me. syscall() could
> fail for any reason. Do you mean to see skip is incorrect in this
> error leg? Please see comments below.
> 
>> Adding this now to catch the future breakages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
>> index bcc73b4e805c6..d83dda8edf62c 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -95,7 +95,7 @@ int init_uffd(void)
>>       uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>>       if (uffd == -1)
>> -        return uffd;
>> +        ksft_exit_fail_perror("Userfaultfd syscall failed");
> 
> This looks wrong to me - Is missing config the only reason this syscall
> would fail?

It should still skip if __NR_userfaultfd isn't supported on a release
or an architecture.

The real problem seems to be in main():

if (init_uffd())
                 ksft_exit_pass();


Why is this ksft_exit_pass()? Looks like further investigation is
necessary to understand the problem and fix.

thanks,
-- Shuah

