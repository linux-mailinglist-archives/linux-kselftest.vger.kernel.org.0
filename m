Return-Path: <linux-kselftest+bounces-33523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32717AC1643
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885B71B64136
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541725DCFA;
	Thu, 22 May 2025 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vd7ThP8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AB25D20E
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950927; cv=none; b=MGN8EjjX7dyVhoa/GyATrGOnraqbQGeRNbHqLGV2owQ+ijNUs/sgwPaxHYIXKmYxig4A5Pk2v3T0W7B8fQDF8vFnIP4O1VdY5xCH1EDUrbuzsWFc+ZLSLOWpOwH9xaomkaVnVzXCOpkC0tSBNM8812tTzyINYW75ShpfwNztPGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950927; c=relaxed/simple;
	bh=XmeeadVd6Z+Q4b8dcysuWdnWYCDg66vF0EY5hAY70Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvY6p7YGzfa2JWDwCUgsi9/R4RxbxqlSbMoZxRqrgz3Sir41nb0GHgaLvSfrUoHjfmTbNPIfwzjB++1wHfD6qU25xgc0cFsnkyJiTvYe4yIHKB0ERKzsX0cPrQ6+uHEinytjx/K2n0GtynbG55+xBZKRkZ2tUUg/k5iuSW43WJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vd7ThP8u; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d80bbf3aefso22442185ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747950925; x=1748555725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsNTc721PK66RA8sSI/Jw77VKtdJQEKr1LL6A2sC2Jw=;
        b=Vd7ThP8u0CyqKnx8DDFovRIgsCsOSvWJfQZzX6fLg/d5Ce6GntXS+/eT8VG/zA8K8g
         W9o9skbnzAG97r16QcM0RAnUoD+Pn0XFmMyI0cud7bTwg4zmSRpiek6+WLiI2B+moSMN
         aj2yi5qn3vO7uRCRnIBYyTYXaUWB/o2qFlbJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747950925; x=1748555725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsNTc721PK66RA8sSI/Jw77VKtdJQEKr1LL6A2sC2Jw=;
        b=Eck3uaeKFVb0ArXH/1EdlPhoCUyeg+NG0E0LPGDB7Ej/ldUEMdL/H7fSi20wMUSeAx
         SPeLT3IXbPwul+bngZgxeEIOlMC2GKECX2VKbB79duZxbL2zN1nfRVrHCbSba5TsLY3y
         PzQBhbKHTUOXXYqHx2iUILp0ZXBCw/mepoF5PGIbCCm6SBzRRspsUD8y/Bv3rhnWJTrU
         hezJAwnYQGo45I/LOkKOSjVUwOZqAxSGqCbE3gmwZ4w1JR1GWisaP8J0qcz+0GDb+SBu
         5KcYAFkm6r4yeGUv2RTdh50Z5hkwY4WUvVynksNJ52YPI9KaFmPfMqh6xUVumd4roMvp
         KvIw==
X-Forwarded-Encrypted: i=1; AJvYcCX5P41+3rGcZ/jEagw61qBDophmfm/iG+Z6/z/n4uu0muU3dAvJ1BBjrJrpaRN75z51Da1kluFw2StkB69UyKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9beoRldh2bLpWEq9gG0W9mBle6nF2grN4fc2IKSCNrfQToqN
	VRiVnukVO4R844hHWA8/fyVIMVcK3AAQiEu6g53+3NMh/8n6IGbqTO8S/Ph7583PmEXQlhjgK5G
	XRXrB
X-Gm-Gg: ASbGncvvcM3hXoxF2Te0TVtVvrb/XKPg5kTsQqGYXMafiB8yipAKijvGpUdDf1JXwgm
	jpQk2cEsTU0D6uG2EOi/0YKuhAYKzOkBkv7BmYNeDOWt+DTZo4ywLI3aa42XXZvt/ZfuUF/td6b
	iBNq6Wh8sQVBPZj1+qH1zMXQYAEgQ9gnlmtV8438Lrwc/O3MMBgomLjdffcu+5MLbX333GJHcjr
	XwSLpdjRLa+GenfHMp/a4sgFVizsalX9OQUOks73G+HZjqF2EC5sG1BqWop0ugdJf9N2LkbMl0f
	WUx2HTLitQC0/7MKUplGt3a2oLyx6lv0uK0ApTL2II2I60nQHw4ePukjElaVVw==
X-Google-Smtp-Source: AGHT+IGTZWRdRAPzUj9NunbARRKcbmYiwV5p5BdqQMJqFvX9jNL1fBlhQhdNQn649bTrCNVyXMQ+HQ==
X-Received: by 2002:a05:6e02:1569:b0:3dc:8a5f:7cbf with SMTP id e9e14a558f8ab-3dc9323abf9mr8551935ab.1.1747950924712;
        Thu, 22 May 2025 14:55:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc899a580asm8532895ab.9.2025.05.22.14.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 14:55:24 -0700 (PDT)
Message-ID: <d51263a0-50df-490c-84c9-ebd0ac49d7d1@linuxfoundation.org>
Date: Thu, 22 May 2025 15:55:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH] selftests : timers : valid-adjtimex.c : Fixed style
 checks
To: rujra <braker.noob.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <CAG+54DbGpNn-Ps=djpsUy+K-6V+eoNcMbTcJoW8W5upz2OKn+g@mail.gmail.com>
 <CAG+54DZ1wDTdWPQSw01G4YgTdihezQ966LGa6ttmBgT2D2gTyg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAG+54DZ1wDTdWPQSw01G4YgTdihezQ966LGa6ttmBgT2D2gTyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 19:44, rujra wrote:
> fixed style checks according to Linux Kernel Coding Style standards.

Fixes

> 
> 
> 1 : fixed alignment of parenthesis.
> LOG : CHECK: Alignment should match open parenthesis
> +                       printf("ERROR: out of range value %ld actually set!\n",
> +                                       tx.freq);
> 
> 2 : fixed alignment of parenthesis.
> LOG : CHECK: Alignment should match open parenthesis
> +                               printf("Error: No failure on invalid
> ADJ_FREQUENCY %ld\n",
> +                                       invalid_freq[i]);
> 
> 3 : fixed line length of 106 to 100 and less.
> LOG :  CHECK: line length of 106 exceeds 100 columns
> +               printf("Invalid (sec: %ld  usec: %ld) did not fail! ",
> tmx.time.tv_sec, tmx.time.tv_usec);

Please refer to a few logs for examples on how to write change logs.
Also check kernel documentation on submitting patches.

thanks,
-- Shuah

