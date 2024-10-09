Return-Path: <linux-kselftest+bounces-19405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15D2997752
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 23:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862621F22ED4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173D1E231E;
	Wed,  9 Oct 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e1D++d8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AE1A4E92
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508383; cv=none; b=XPN7CtaZjO2wmTBDMqoj3PsAkK0X49yuEIPemNZnbAtCqvngAcO4IYEV2EfHJ50CtJh27A2P22LyzdmLxIF2sihhuL+s7bFYio/BXR3BFujaS9JxD3TxAH4qAIvoE57NP+/SRce3XIzLdLIHnjn1oZfUnuuA2k5j503vzOQZ2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508383; c=relaxed/simple;
	bh=6a4rFQhw/VZcPnHLsZT6nLi4tQP9vAYKfT2SVzIGbyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRcQ/lLfpHHaabnf0dcD/fxl3Hot3NEiKNfipuOj77FC2Mz4Tny7u41meyqWgVDDkvigyWGR5ESHyHj6U9FegfF2jTWJo4F/ZKP858sKvl1mVQS7//ZyU+/spz4AA4tHG/EG8XeRwYlwXAU3gVLndi32u8+vHFq1V8RoSZdSLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e1D++d8e; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3525ba6aaso1108785ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728508380; x=1729113180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYJ7JU/5K0pgGRgUC6cCFixqutRrf8flVTqhOdXWq/Y=;
        b=e1D++d8e1/rMBg3mxpX1UzEI/eNZKwgwivT5ZX50zGkZzpSPA6HCPS/olx1q/O9atl
         JkvOroADHG1PyhUZWsQrwLcjRjGZeDgJ5vgGMX2RLblbP2RWFCChT0dDil2x3CLviM/R
         k/AahPNDAgcwrnCHTcJiqbvb+sCg661Rli7sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508380; x=1729113180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYJ7JU/5K0pgGRgUC6cCFixqutRrf8flVTqhOdXWq/Y=;
        b=uFUyS9J9H/8HmLEyxeIq9kjpNe54BukJtHSCebM1l3m1HP4kkYeUKFOSQl32Zwg0ow
         LqRM2fS064WB3rMirKNiM6sPh0bp5b6WTTA9XD8lnlCQTwBlPpoKJo7Z/4xJGKlo4peP
         Ucl8U2RSQq7exyXLFWXLZ/BHwxRR20l1kzY3EPyb9JUPuj9B+Ka+XePMBTI6ZFco5hQl
         440X2bTcE3WSR71gaRQu3RtdUCRBsAB0Iju2aMddtTMpvGVr6jmjBw5xodcBbtPI4MpL
         HMoWg/wFxxHNyFYd6mRgZOx4DjYmuLKsuWIimUh8+HKHoyfEpkWHp6lZFa7gersMVfqG
         Ripw==
X-Forwarded-Encrypted: i=1; AJvYcCU/mz7gintdAgRPOOH1pacX8qGyqw7HMqYNV69SQ1mAUhH+DEvUEJtZNpnGP6TnM1RT7/QVbsX9i7tsoDoZB9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywzZO0H2NfMP9pvpnjo6kbMXbKYcFpDHRnQbD3lEsyUHDeFh7
	EEq0avs9/YgQQCH18W6zlxPVBUZuk0DGH3L/Vuk7mQGsRVxB1da8h8GI7iSMjTU=
X-Google-Smtp-Source: AGHT+IHv1vuMSCa1zYs4UVV/zvu9uihnHQASurLyDa8xluFOQ8BbfOHymK8Jxbawrhw68bVJSGQhBg==
X-Received: by 2002:a05:6e02:1a01:b0:3a3:968b:4e3f with SMTP id e9e14a558f8ab-3a397d25948mr39294515ab.18.1728508379895;
        Wed, 09 Oct 2024 14:12:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db979a26aasm834317173.76.2024.10.09.14.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 14:12:59 -0700 (PDT)
Message-ID: <16c3dfe5-3e99-4376-a88b-96c4247cde32@linuxfoundation.org>
Date: Wed, 9 Oct 2024 15:12:58 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftests/rseq: Fix mm_cid test failure
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241009012801.2062026-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241009012801.2062026-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 19:28, Mathieu Desnoyers wrote:
> Adapt the rseq.c/rseq.h code to follow GNU C library changes introduced by:
> 
> glibc commit 2e456ccf0c34 ("Linux: Make __rseq_size useful for feature detection (bug 31965)")
> 
> Without this fix, rseq selftests for mm_cid fail:
> 
> ./run_param_test.sh
> Default parameters
> Running test spinlock
> Running compare-twice test spinlock
> Running mm_cid test spinlock
> Error: cpu id getter unavailable
> 
> [ This is based on the following branch:
>    https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>    branch: fixes ]

Did you forget version prefix? It get confusing without
it. Pleas eremeber to add prefix and version information.

> 
> Fixes: 18c2355838e7 ("selftests/rseq: Implement rseq mm_cid field support")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> CC: Carlos O'Donell <carlos@redhat.com>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: linux-kselftest@vger.kernel.org
> CC: stable@vger.kernel.org
> ---

Applied to linux-kselftest fixes for next rc.

Did you forget version prefix? It was a bit confuing
>   tools/testing/selftests/rseq/rseq.c | 110 +++++++++++++++++++---------
>   tools/testing/selftests/rseq/rseq.h |  10 +--
>   2 files changed, 77 insertions(+), 43 deletions(-)
> 

thanks,
-- Shuah


