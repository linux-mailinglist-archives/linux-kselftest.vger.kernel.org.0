Return-Path: <linux-kselftest+bounces-37961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90920B113D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 00:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901C6AE04FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78C23B612;
	Thu, 24 Jul 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3VU9Che"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66220D4E9
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395431; cv=none; b=osS9vjCd11IpGbpZ44vNcAySwSPsbNvphnZwpIc+Lyu0sYDY6VIZ9IkLkKOqsGahkvhib4zFXN10qG+nZI8gnymKPDDEhcZUxN2wN4OGotE23wmZrCQ9SGBFwfbkkI+GjXbbdC8l4RrbpbTW94Gr2S4B3t5UYhur+vhllsJ9sqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395431; c=relaxed/simple;
	bh=772YePz7m9zjbtyHhHlhp4UYnNFKStTWbbper8PuJnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwDji2y02fb9+NmK271g7bhe2WZ/q+ixSdxf/I21iaMmxSmJSjm/z9tGuFqlY6SGKL5x76JmU3hSkhZMvLyEtjuetL+EvRKPRZk0aMu9h3hqk0cneyXAxcwyC5mWsrcy1bBIpzQYT7ghWMCSNEeDa8cVIntCYEs84glbUV5ikw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z3VU9Che; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e29788356cso5205555ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753395429; x=1754000229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSQs0NQVdoepyCBGfWzoyTl6I7sggL2Fq68RB3UkRVQ=;
        b=Z3VU9Che2QueCbhvGRre8MHJ5mpXPhTbza5i00wJ8kabxxwurqKG6EXbMM51XtLPpv
         /LWeN7QiXd5olLwWJj6gkRRoscnmB8MKKSrtWUmAmkkuXp+0hFuura0bwVvqm569S2wU
         Y4tc8NFW3e9CeBi38Izu1VPkY2BcukZoxclRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395429; x=1754000229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSQs0NQVdoepyCBGfWzoyTl6I7sggL2Fq68RB3UkRVQ=;
        b=Lv8Ows58bq6xs3HAIN2UCgye38l0/OPY1iplls22ePTXxS9dL2bXoRrvR2fCHJQ7PC
         cvjPGyI/x/TRtIMmWmiK/aQnGTCjywTA/WHneRSUKRoO2AAq4iAvgPkD42nYlACkS+wy
         MnKVQrrOqXQjFH3nIc2860iAYaPlSO+UDtVLcTJvmIHYQOjoUe6af434fW4SxpA1leTf
         S9XcK0yEX6NzsHvrokNuPg+UpkDVTBhWkjj687/wLSsLVsMX9rCBIOCbqAgUiigJ7e5v
         wQ/jy9OVGsmZM3edP9esBvYF5DCw7ejvZZZjEJdt3sBHv8OnLgbNDw3t4ydC5nTzd8jt
         SEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXxyp1s1aPPPjsBN6jo++YIVH5vCr3Cb/+g5s40Xipi+FEHPzwV9PeFXm7TFE+u3V81s/C4p/hTT3th5VdqXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46XOllBuTKTQN0zvY/s24sKjfa9VjhKZf/Yt+cbuAMN8jsI2/
	fXn6kOuABgLubYf04UZwHDkX1q+irju7J81vw4FhDxiW2Cs0WG2riDWFz3Du0COkJcbXFZ1EQkQ
	EvTzy
X-Gm-Gg: ASbGncvS42kvm6TF/NKG5PnQmHWvg7COXLGahLHghtUNxsrJSjkCJgVWLPA2veTGHjo
	chDSNhM9N06lXk5HOqRDnWmmNmTOQwEC0soOomM9aJx3g+v/ArEl7i3kvr3+ImoDZzIjyX0outv
	fDssv/Cg+f8YdilMlS056I8yU9TSpFOgc1CdMXVCGHnSLQ91nS2DejQHoL0wu156QdJU98WxMoT
	rCHej7oLvDovG0JgMzP0/7oDAY5G5Ks1KOg/DUkuvXs13fyCJJATJE4aTXKU2Im3CpR3Kr8UuOQ
	crezzDD9hcqLzEg7/TvMtrvaZnsMGp4+SBx6/J0ZgqxzZtRfYD0PPVnlx3xGj6ry+JjTNR7Jciv
	m5f/0oKv3+zDxPKhqOz0jXVjPEXvmfCwO5Q==
X-Google-Smtp-Source: AGHT+IFo24lOuKx5SqHaaZc/IvMATHZtAjF4Omlj6JcUfoLce1g4A2LyGbQFQwfN80/Mky97Asu0dg==
X-Received: by 2002:a92:cd8f:0:b0:3e2:9838:31ac with SMTP id e9e14a558f8ab-3e3355b0fa3mr157810685ab.18.1753395429159;
        Thu, 24 Jul 2025 15:17:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3b7114181sm9154805ab.16.2025.07.24.15.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:17:08 -0700 (PDT)
Message-ID: <369df3d1-8d6f-4f69-840c-46619f7cdaf4@linuxfoundation.org>
Date: Thu, 24 Jul 2025 16:17:07 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/pidfd: Fix duplicate-symbol warnings for
 SCHED_ CPP symbols
To: paulmck@kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <5b53702c-0dab-46c4-9cb0-448b4da36c2e@paulmck-laptop>
 <f82e3092-31ab-4ceb-a51f-208d13e7b2ec@linuxfoundation.org>
 <dbb9ca63-15d5-4547-beb4-5c4044938967@paulmck-laptop>
 <cc7e4fe7-299f-4bf3-af46-df6551d61997@paulmck-laptop>
 <90c793c3-91fd-4808-8fea-cbd07d2098e0@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <90c793c3-91fd-4808-8fea-cbd07d2098e0@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/25 12:26, Shuah Khan wrote:
> On 7/23/25 17:13, Paul E. McKenney wrote:
>> The pidfd selftests run in userspace and include both userspace and kernel
>> header files.  On some distros (for example, CentOS), this results in
>> duplicate-symbol warnings in allmodconfig builds, while on other distros
>> (for example, Ubuntu) it does not.
>>
>> Therefore, use #undef to get rid of the userspace definitions in favor
>> of the kernel definitions.
>>
>> Other ways of handling this include splitting up the selftest code so
>> that the userspace definitions go into one translation unit and the
>> kernel definitions into another (which might or might not be feasible)
>> or to adjust compiler command-line options to suppress the warnings
>> (which might or might not be desirable).
>>
>> [ paulmck: Apply Shuah Khan feedback. ]
> 
> Looks good to me.
>

I picked this up for Linux 6.17-rc1.

thanks,
-- Shuah

