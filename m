Return-Path: <linux-kselftest+bounces-17077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC796ACB0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F0CB23E8E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23D1A42D7;
	Tue,  3 Sep 2024 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoS47PWa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532B19F412
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Sep 2024 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405533; cv=none; b=bPbQWRxy7+G6kYRTiYlnKAmIZYeQcMxTLrjwC21r38dXdypKW3Xh7soL2E96bUHE5deB8tok9SwpGQAtDHbtO2Uu1LNZu7psCEgOuMYXNCiD/p6gRoSEYvfl/Ge0y4vKs80f2tMVrSjd8nGRoR52LUHeLDwY0azXtclYjwuLvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405533; c=relaxed/simple;
	bh=TUCBtKaggpC/UcwUpEU1+NQ4+NkeWsmUiPyAGS7enjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coXhxVr3kHk6hmEAaJJM34qUHMBJ/iDl2KCOni9vAsE0vNonfSPvMbS0aRPnLz1e/sRwLQWw73VuSQ8c6RHj2c0cA6smsCbEuin1TflB1mUS5mSuzp/YLp5tUb1+7B7gFRCiVZ/PpRWELNGHMYv2UMTbHeZd7vZczAdiMNFUKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoS47PWa; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a35ea3edaso199367639f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2024 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725405531; x=1726010331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpo2pP48luBYQmS5JDSku8eVTN6sAf4SlRYC5TcODbY=;
        b=GoS47PWaDfy/CqQxpXdx9vATcfUbORh10WsGrImvNclO708Wz79me5DoT1O866Bl8+
         rHXuuBj45gwPk/QIofMkmdAHJ9K/WjyF4xN5l9wVCtP8HAIDlGtIOzWRZg2B6515FpLq
         DJOrFBNKcurPZKQeyPMDctY4mHrC2wgJ50Yew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725405531; x=1726010331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpo2pP48luBYQmS5JDSku8eVTN6sAf4SlRYC5TcODbY=;
        b=BkYALHDSA0uDRnVKsXmpKXUIf0TV+YTieyaSsg8KKw8w1oqSHRLsol03P5wAPI2PcC
         hmfJxIJ3A60aHoOExnWtZ2aDjGGK6is2xRvc3v7gUWLa13fjpJIufHkyQed+D6ZuZduN
         2xgbZrxxdskfuE94V7kN4Zo83SHvYHtaQRF5QPqRQ5ntrxV4Rd46KMi6v3LK2TcxwN65
         PEn0opTDCp5hxEltnBooSKN4SZJQyCpjUNb6InGCVjMz3e9lbfcXtKD6+MsP2fP9IER2
         YImqDd8xRzh8/wM7CPaCF3cBA9CEae3FFDrv5EYFaCrqwSPCMb1FHgzg+KGUNlAKVhQk
         S2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWF679Zu0R8dWegNwRCqEelydBwJvalKitJ98H8eNEFlixXVWgJDxaBmT9mhjF7Uke6s5Nc0ETIpdDyyoQ97uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5sc1NNKFKTYqYkfEWK91NKVmcNzpliDeDF6zHzRnLPDsGSsb
	fauA/bWLyqrxa4a0sO5zoUD9yAH4d7Hj65CpXjHaUYXeXInu7GWqxbhCMPETlVl1JbBHLmzauON
	b
X-Google-Smtp-Source: AGHT+IHi01VS0Bv3/JmrZSQbDFpZYKr0seahAwb3aIGsZkDZn/NK+83bOKYZDfPijnjX92FZ+sjS5Q==
X-Received: by 2002:a05:6602:26c7:b0:82a:1e96:bce5 with SMTP id ca18e2360f4ac-82a1e96bd72mr2662073339f.10.1725405531034;
        Tue, 03 Sep 2024 16:18:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a412edbsm325803139f.16.2024.09.03.16.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 16:18:50 -0700 (PDT)
Message-ID: <eadb7bc7-a093-4229-90f0-88b730087666@linuxfoundation.org>
Date: Tue, 3 Sep 2024 17:18:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] selftests: Fix cpuid / vendor checking build
 issues
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/24 08:45, Ilpo Järvinen wrote:
> This series first generalizes resctrl selftest non-contiguous CAT check
> to not assume non-AMD vendor implies Intel. Second, it improves
> selftests such that the use of __cpuid_count() does not lead into a
> build failure (happens at least on ARM).
> 
> While ARM does not currently support resctrl features, there's an
> ongoing work to enable resctrl support also for it on the kernel side.
> In any case, a common header such as kselftest.h should have a proper
> fallback in place for what it provides, thus it seems justified to fix
> this common level problem on the common level rather than e.g.
> disabling build for resctrl selftest for archs lacking resctrl support.
> 
> I've dropped reviewed and tested by tags from the last patch in v3 due
> to major changes into the makefile logic. So it would be helpful if
> Muhammad could retest with this version.
> 
> Acquiring ARCH in lib.mk will likely allow some cleanup into some
> subdirectory makefiles but that is left as future work because this
> series focuses in fixing cpuid/build.

> 
> v4:
> - New patch to reorder x86 selftest makefile to avoid clobbering CFLAGS
>    (would cause __cpuid_count() related build fail otherwise)
> 
I don't like the way this patch series is mushrooming. I am not
convinced that changes to lib.mk and x86 Makefile are necessary.

I will take a look at this to see if this can be simplified.

thanks,
-- Shuah

