Return-Path: <linux-kselftest+bounces-14678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E7945360
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAD1F25BEB
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA66149C47;
	Thu,  1 Aug 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BctJWv/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2EA1487E9
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540439; cv=none; b=Foim0uWAtWLkV4XU4fdECT8gpRtNgm5osqaDFl8rPhRwoOJuC4xsaussiR9LDkMzF+YmY6YhVZGtD2FQDd6dMXVKYFL69vxzDCzeXOkisksfJifhcmcr82IymhtSgBn2z4dx8iKV+0lRbDrT2vZxvmuwt7JEq/RHH5g2xo+Fepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540439; c=relaxed/simple;
	bh=tywakX45M1InnvuZ/1MtoJOyWN5YWGbgUz3ZqaFBEcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDkM3pJAVXG1P96QMK6RbJNVx/Qu/hqYgsK1zWoCaD8WVWjmCf5ov4ufsV4QiPeZf2F9w88zknkVqCDcgamvoNBeJjffA4gfHhzjswKjXX72EjYYmkj+YPIb3isrj8OYCnJn8dJY5yxo0Q4MsAsx3nuB9QbRvprejq2A+vuHklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BctJWv/G; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81f902e94e6so33482139f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722540437; x=1723145237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8iCP5X47UzqYC6qlEo1ldBtwUGspd9bUTugmBKJccM=;
        b=BctJWv/Gtywp29aDAKzJq/uKSG4kqNuzP/k0kuZc0eoJBhyFn+s+cKuJ8YwO/pVRRs
         SSFrBasnyUFYIJ9PSftK4Vua+zN5ey+EHzkdYuGDM3kNaN+YN3xitgR2x4fDiB6Jyy8g
         byleyLjhj41zPugFM+HOGJdTze/LhUDdSP5fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540437; x=1723145237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8iCP5X47UzqYC6qlEo1ldBtwUGspd9bUTugmBKJccM=;
        b=qT5P49E9iHIMBDL0VjMN2aku82JfT0aoLR8nHBZcdoUneM0W96HtcT0LvToOnCZo+A
         TivcSTUXYywHHd4t7+U65OWkJ1M2WpbWlY7E3/eFLDNp5DaJWVuEjp5TIgUSgAGjc2O6
         CGajrd1E859APiBRo+OreePuL2aKIHjLdyuQ+n2TcPIdE1uVHbo8PsR4fIFw3rzqBKih
         hWQgUttm2UR0FTafBwmEe9T8cVfJvHyZtXO+97gdB+KvZUC0RP9Cfp3uHcQgNkPbjIhW
         wuaB61WgzKw4WFOvoUQZPclAPomrqLfVyhWIc4cAMXCo8/F0QiwTQV68tROPHricdsBQ
         DsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPWdCgb3mgO4FqQg4fRu5eZQeq28VP4G+wcaxiVHCeeLkuQRlGQHve0KqztGE7BCKe6dvdt1KeUZ5C9DfGpk5x4BFyBjyBPznpDHCHUz5
X-Gm-Message-State: AOJu0Yzwd/3XGkepPMvl44wH+/8wEOcTWtv9lS15HTsT+mHdyLhyy1x/
	wc0K57I7sLmo9k64qWCg8GdeUZGFwfefk/fW4TQKktGUQHzSy6DUh6bKYaJsPQw=
X-Google-Smtp-Source: AGHT+IG+QhYotam1Zq0uZwDDVTTlIRWPmDDMs/QX6rzhcqHTGs2NgsqWN4Uu2eTVDnnUaXffRnlmYA==
X-Received: by 2002:a5e:da04:0:b0:81f:9748:7376 with SMTP id ca18e2360f4ac-81fd42b73admr90684839f.0.1722540436687;
        Thu, 01 Aug 2024 12:27:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6987e98sm78792173.29.2024.08.01.12.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 12:27:16 -0700 (PDT)
Message-ID: <a32a8cdf-b488-4b6f-a0d9-d709b9beb769@linuxfoundation.org>
Date: Thu, 1 Aug 2024 13:27:15 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
To: Peter Zijlstra <peterz@infradead.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
 <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
 <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
 <257c9106-c33a-46c1-9761-111505309176@linuxfoundation.org>
 <20240731212325.GY40213@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731212325.GY40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 15:23, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 12:14:16PM -0600, Shuah Khan wrote:
>> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
>>> Kind reminder
>>>
>>> On 7/2/24 3:17 PM, Muhammad Usama Anjum wrote:
>>>> Kind reminder
>>
>> Top post ???
>>
>>>>
>>>> On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
>>>>> There are no maintainers specified for tools/testing/selftests/x86.
>>>>> Shuah has mentioned [1] that the patches should go through x86 tree or
>>>>> in special cases directly to Shuah's tree after getting ack-ed from x86
>>>>> maintainers. Different people have been confused when sending patches as
>>>>> correct maintainers aren't found by get_maintainer.pl script. Fix
>>>>> this by adding entry to MAINTAINERS file.
>>>>>
>>>>> [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
>>>>>
>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> ---
>>>>>    MAINTAINERS | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>
>> Applied to linux-kselftest next for Linux 6.12-rc1.
> 
> You are applying things for the x86 entry, without an x86 ack, srsly?

People are having problems with s86 selftests not making it to x86 lists.
I figured it will make it easier for the x86 team.

I don't have issues dropping this patch.

thanks,
-- Shuah


