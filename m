Return-Path: <linux-kselftest+bounces-11703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4AB9045D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DD5285D91
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C9152503;
	Tue, 11 Jun 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="adkztwbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E14B1411ED
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138272; cv=none; b=MVO7uyE8+yLE/00wAWskNxfa9vomfVnzzxy/cCbr0ko6S6WeByRTQOpXSUmhVrwh30yaPReSstPj+naHZ+R36INHpkSn+kZ+58YHujF8c+anKDwD4HbRy/O/Qlt7fAUC8a07lx21sIOuvD0nB0P01TL5KArnJUFwnOfljEx4ZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138272; c=relaxed/simple;
	bh=V/biF71bv6Pq6LJwgeITRAa/Hj0e5fUOoj2yUgJnfGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsCGhyZIB0UqTJoagqG5ex2GWZ4CmxvR5ZQKkXTknVBD46eZs4XybfcYKNQXL+bW4ghiiHGwVYTZ+vofAL8mZiLmCsAxY8nfIuVir+un5+oPfDF0ht5AKurx+V2HRLJgG3345t7KeRDeDKzuQ3n/Vri9Q4fRdJpOO9lib8f1vuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=adkztwbw; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254f646b625so29034fac.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718138269; x=1718743069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HE5nrSg/RT1klcR6UUxM42f0bi6ZlwGGrbOCaO2TDuk=;
        b=adkztwbwTy9OQIWxtu2NEFEG3SJlYgNHYbeLgpVRFlf13rtJyjFCuGUSW1xv3FnUms
         J2AIjeOPywAzUBIyMuV4Zh0DahHErlkw2ZVs5vJNOIyM8N8XEI74zIXWaMIDlGR9hZVr
         pyeUGR7kPURudihsjrKNPVeG1oOe4y7rdG21U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138269; x=1718743069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HE5nrSg/RT1klcR6UUxM42f0bi6ZlwGGrbOCaO2TDuk=;
        b=meARknhWDvhHaHAPlx2yKusOXZnrqXY4702F2FDv4/23hpNUCAG0JHE31uUMvw+YaI
         LJAhhyg242JIo5+vhvMdWpDsNHA0n5btw2k1VPCcE1+RiTh4HKYdX8hymKoTgz+KRK3i
         VszJvirDBYIzM4+seQOYwY8dNKVo9QDnc5gvOHyD/h5KoUoEuyV7Vef1uKYyDoEL9mcl
         sojFxUmOTwfM6N23pkxHRgNBQcmchJ5XwCMmWTmp+YNSY2Y2BS0F99C/HyDvgOIwlsWj
         vbNyzZw+rKdhafHfdv7MXe4Usc4VKqaxictqBqy1fPyTz7QQJqmOsp0YwRZvsCUpdw6T
         piVA==
X-Forwarded-Encrypted: i=1; AJvYcCWPdL4khD1RzoRGquKdzpKK6OQ0nMF/QzlzHnger3LfqLk4Le+ob/aPvfQm+Uzfibgg1V0q6k4rOPk1CVonFiTJ2iu5FlC0hTl8G5qM9ziH
X-Gm-Message-State: AOJu0YwRfGbHh/NFu31QNbB21AhRfZRufkzesAMcYL3flYCtIZU9Wf0e
	dRDHtK/nIwz0sfnc7TksSz44DHxBZj7NgjMzNGInLdpdI/Okv4gcJMaCzxORhzmrKBoZ87dJyxG
	B
X-Google-Smtp-Source: AGHT+IG90OE/6gP5cB7neVTC/ES16EBOsNBxZKxN58g10F5pDUw3PniO9bBtreO7MSfSgGyUV2P++A==
X-Received: by 2002:a05:6870:3310:b0:254:7dbe:1b89 with SMTP id 586e51a60fabf-2547dbec04cmr12704059fac.1.1718138269159;
        Tue, 11 Jun 2024 13:37:49 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955086fb96sm379035885a.37.2024.06.11.13.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:37:48 -0700 (PDT)
Message-ID: <b3741c08-5cc2-4b82-be26-7c2a0f79fa86@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:37:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] kselftests: vdso: conform tests to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610054129.1527389-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/24 23:41, Muhammad Usama Anjum wrote:
> Conform individual tests to TAP output. One patch conform one test. With
> this series, all vDSO tests become TAP conformant.
> 
> First patch conform the test by using kselftest_harness.h. Other patches
> are conforming using default kselftest.h helpers.
> 
> All tests have been tested multiple times before and after these
> patches. They are working correctly and outputting TAP messaging to find
> failures quikly when they happen.
> ---
> Changes since v1:
> - Update cover letter
> - Update commit message of first patch
> 
> Muhammad Usama Anjum (4):
>    kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
>    kselftests: vdso: vdso_test_correctness: conform test to TAP output
>    kselftests: vdso: vdso_test_getcpu: conform test to TAP output
>    kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output
> 
>   .../selftests/vDSO/vdso_test_clock_getres.c   |  68 ++++----
>   .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
>   .../testing/selftests/vDSO/vdso_test_getcpu.c |  16 +-
>   .../selftests/vDSO/vdso_test_gettimeofday.c   |  23 +--
>   4 files changed, 126 insertions(+), 127 deletions(-)
> 

I see two changes:

- concvering this test to use kselftes_harness. I am not seeing a value to this.
- Second converting every single print to TAP. This isn't necessary since the
   kselftest wrapper prints appropriate summary message based on the KSFT_ code

I want to output before and after to assess the value of this change. TAP conversions
make sense if and when they add value.

thanks,
-- Shuah

