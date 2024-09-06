Return-Path: <linux-kselftest+bounces-17396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5696F66A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01BE1C21A12
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219EE1D0DF2;
	Fri,  6 Sep 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SklHqHyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E51D04A4
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632060; cv=none; b=EINGRU3LoUWKNY6uiy9ocWClcf1uZHfA21RQOpBO2ISSBGK/tDSUptBrVCARh6miUR+hqnpSjgP8ADJtS8TOmOfcm7ZX2GRpd49FCvknWWqCjkC8AZJDooDzkney/eWRVJHydNkhKAdt52MhjElXXz9hK6OAn2F2QP3ET42dY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632060; c=relaxed/simple;
	bh=23suZZslrElYAyZQHWDA+IOgBKqdPtOdcjQ8BplQZZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTpMGqRiEcaP5qYmGkqo+K7A71TSdWa7poeBlzLmv3CKrdCtkmLpytBbUhFxf9BmvhSiAJadPStmArTMvlrnQ9pHwANhO5gKyEtMYf+F1jNoVALy92QaYgm3x1+3fPv8FXf9+yBVjsCigUveqHj7mFtYfHDd/LnahK0NJC09ogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SklHqHyu; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a8f3e7a10so70640939f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725632057; x=1726236857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vViw6BTWp76nUCRilCQyxEbSqwSDETKDM1RYVM6mLFE=;
        b=SklHqHyuX8n95D8ffRvrALZ/EEl3rH3jYDxgIBT8xlNSO5HRlwGB8oLxtew8pe7DSC
         q+xqPwbDxoW7K5lsdr/JyOtlfNwyIIAye98J+u45QBLpVRJgI+AjRtqQCOqL8tKQ/zhq
         71daY/HPbAm2tFWtgfLwQJD0Wb5BylXdyNzaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632057; x=1726236857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vViw6BTWp76nUCRilCQyxEbSqwSDETKDM1RYVM6mLFE=;
        b=DCBdv3ruUo7pja16lDVWOeSDT2yLCmELzhX83toK38EV1E435R25FuOAREDRCDIEOx
         ALspAg0o+5ys+RxGbCe6WClwtI9K0y9H6lU3Xr8JS0e/F2Vv1IsEsYuL/bGYCox6uXA/
         D7iRLqrgTu+FthvP+gagZTakCO0C96k0wvDvQvGT6LFqrkMUkDMCoTu6/WRwKbYDEqTH
         3mxDfnef0WNywEI6GXvpCmoeU101YQ5x5UJcNc5h0LmiiHYhngilDxgeZX4tCs9+lk4G
         xjxLM+CHGgSSXNgayQ0QXhUOnsrwJMf8kNqdiVbggJFgiI68c5qyEFVtzB3f6dxs1wcb
         5neA==
X-Forwarded-Encrypted: i=1; AJvYcCX8SipGKOYA1WUtEgMhhIATNTnb46PYDf/n1Wt+DmGks1K0hUfW6Llqu+TDp10+8tAKFBaWyV4qspn4HqQQQYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSD81h58tO9WjIPZ4Zf+VQh14yokaDBPf1Oa3oDUlv4Uw0nsH
	6TVFZF56mk0mC6JGW8rUlDvsuvST4c1cib0z0Kau9O3gdYQpCUaJQ4psdsoY53g=
X-Google-Smtp-Source: AGHT+IGlBnlDVHagXUvARTKh4F7dvKYhw6L2wgcgb9XFUgHOWtzaogoxzxw4GnvS6B0z13xrB7sNmw==
X-Received: by 2002:a05:6602:154f:b0:82a:2385:74a6 with SMTP id ca18e2360f4ac-82a9618c4f3mr341912439f.5.1725632056435;
        Fri, 06 Sep 2024 07:14:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d08a22e664sm210986173.67.2024.09.06.07.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:14:16 -0700 (PDT)
Message-ID: <cff1553c-d342-44e3-a685-9b074af87858@linuxfoundation.org>
Date: Fri, 6 Sep 2024 08:14:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: shuah@kernel.org, fenghua.yu@intel.com,
 Reinette Chatre <reinette.chatre@intel.com>, usama.anjum@collabora.com,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
 <21267ef6-6fcf-2eed-a3da-2782d1e7013a@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <21267ef6-6fcf-2eed-a3da-2782d1e7013a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 04:12, Ilpo Järvinen wrote:
> On Thu, 5 Sep 2024, Shuah Khan wrote:
> 
>> When resctrl is built on architectures without __cpuid_count()
>> support, build fails. resctrl uses __cpuid_count() defined in
>> kselftest.h.
>>
>> Even though the problem is seen while building resctrl on aarch64,
>> this error can be seen on any platform that doesn't support CPUID.
>>
>> CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
>> will fail to build on all other architectures.
>>
>> All others tests call __cpuid_count() do so from x86/x86_64 code paths
>> when _i386__ or __x86_64__ are defined. resctrl is an exception.
>>
>> Fix the problem by defining __cpuid_count() only when __i386__ or
>> __x86_64__ are defined in kselftest.h and changing resctrl to call
>> __cpuid_count() only when __i386__ or __x86_64__ are defined.
>>
>> In file included from resctrl.h:24,
>>                   from cat_test.c:11:
>> In function ‘arch_supports_noncont_cat’,
>>      inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
>>    304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
>>    306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>
>> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> When the small things from Muhammad and Reinette addressed, this seems
> okay.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 

Will do. Thank you for the review.

> Thanks for the solution.
> 
> 
> I'm still left to wonder if the x86 selftest is supposed to clobber
> CFLAGS? It seems that problem is orthogonal to this cpuid/resctrl problem.
> I mean this question from the perspective of coherency in the entire
> kselftest framework, lib.mk seems to want to adjust CFLAGS but those
> changes will get clobbered in the case of x86 selftest.
> 

This isn't the case x86 clobbering the CFLAGS. This falls into the case
of x86 customizing the flags for the test and the ones set by the common
lib.mk might interfere with the flags it needs.

There isn't anything here to fix based on the history of this test and
lib.mk.

thanks,
-- Shuah

