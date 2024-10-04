Return-Path: <linux-kselftest+bounces-19049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF2990A5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898D71C220D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277E1DAC80;
	Fri,  4 Oct 2024 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7MqRoLY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A321E377C
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064018; cv=none; b=sF/MKCps4Aw5PoM5OgNCrhGJ5aH5Z0x+n1trVOxz3qJ08JGefY9VSieBVgJwJDxlcnWsS6xmYrDVUxR/14dHGJsQVEYGs0DntbVtHzDUQSM4KpbvtQos555rULei1rsh61DzYI3lluSQ6BEhGB39qcebWNE3B+MAGnZ8x2h0r4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064018; c=relaxed/simple;
	bh=GwoXEC+JDw3AOgTRVFZNEvsljq1NfcUkok84EeESg7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=td90bDMb9KmmdCrVb33pJ3/B9+R0QFliPZQt9vbPClZIdhOIx+Inb9PzwEZFs4k04L7zdp5i6OgKAQTCUnzlyAldKvEg5HKxaPoaXNx+8nIgUfkMAkwIWHElzqCkZYlvXC4/gct3Wt0JkLvCT83PoCMjMEXG1v2P2PWElILoNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7MqRoLY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so7796265ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2024 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728064014; x=1728668814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXmmCzvSCA40I9sZAZE8zqvwLWduBtnIuV1E1NtN9Hw=;
        b=S7MqRoLY3kVu6m/HorMGqSrdcKPCr8Al5f+urgd68E8GIR1SyyWZtMORP7+GwLJ147
         2p1BIS5zFybWuhZG4gZY38lVsVHgn+GH0zZ11aOi/q28HhpV1MG4VPGxdqlPvf5Mo6+J
         xHTJdZaaScyTJtkNTCvnHel8XiFYvXBaCr8eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064014; x=1728668814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXmmCzvSCA40I9sZAZE8zqvwLWduBtnIuV1E1NtN9Hw=;
        b=ZUorC5RhHwWuaC2aQbw+vWWhFy0n+iwkwSriBxS3LVqKtzve/CgdhRYFllsTf8clhV
         2TwReVHSf/JWa2afSJgKNIDhOOdEVv7o3P+ofUMBRj9mef9f2LiaDX+FnLko6/6BLmEr
         OynT8JVjI50ZOcQ9jDp5wS9DXbom4MgCigZe1dljrJcBEpB/e8Hu69KGRiWR2bv7lIwX
         a0pRZ1gG5+OgJR1UGf6riiovlzVwitOx0/hShwbQEIMtcouwOo4BbzTG6ekp5XbJjz72
         Jo/flZu70Ahpi9aassQzIHwRYm5Rb33oQuDQzRc/j3InHrayepy0UZlVzzHkbJAL8dZy
         6nGA==
X-Forwarded-Encrypted: i=1; AJvYcCWqStRyg0ZhwLWJp2Uws1aUYLBUUVAT3E7QnYnSUqKptlqLrxV0+TnrgdhX0Ij3i/isbnSWT0ijsWZiSiPt9+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzvlhcRDUJVzJ9RJqX/2fjWz5It2sv5I4SJMfjUeRjYA+H1Bk
	a8Qb8kjwgnrzK7HzZWaQI1hlClgnOvSM2LW2IN744XpNbcV3UZj4HBDPifXAHzE=
X-Google-Smtp-Source: AGHT+IHqCu+1mXToIuh6Tj4b/PxFjs4AwlFkKnHoWB5eAWJ3yVV9VQlGQ32A8LuSsorPiDQr9x55Pw==
X-Received: by 2002:a05:6e02:1886:b0:39f:325f:78e6 with SMTP id e9e14a558f8ab-3a375baaad3mr27799905ab.0.1728064014394;
        Fri, 04 Oct 2024 10:46:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7fd6cdsm656365ab.21.2024.10.04.10.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:46:53 -0700 (PDT)
Message-ID: <60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org>
Date: Fri, 4 Oct 2024 11:46:52 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched_ext: Add sched_ext as proper selftest
 target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004094247.795385-1-bjorn@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004094247.795385-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 03:42, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.
> 
> When building the kselftest suite, e.g.:
> 
>    make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
>      SKIP_TARGETS="" O=/output/foo -C tools/testing/selftests install
> 
> The expectation is that the sched_ext is included, cross-built, and
> placed into /output/foo.
> 
> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   tools/testing/selftests/Makefile           |  1 +
>   tools/testing/selftests/sched_ext/Makefile | 59 +++++++++++++++-------
>   2 files changed, 41 insertions(+), 19 deletions(-)
> 

Thank you for the find. It appears *sched* is also missing
from the default TARGETS in selftests/Makefile

This change looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Tejun, Do let me know if you like me to take this through kselftest tree.

thanks,
-- Shuah



thanks,
-- Shuah




