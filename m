Return-Path: <linux-kselftest+bounces-7726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC68A2090
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BDF28306B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77632942A;
	Thu, 11 Apr 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGreNy0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5A15E8C
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869308; cv=none; b=fbv6Xoj/rJta35RUhrVG1MXyEUlKYkV2djfXF/bh0VZCOlOaSX0LmnttJQnYDTwf6im1mOw/FNCVgmD46yuhxpGZvBb5Xhtk67avPGJX8sJWvuJAQ5iqo2++jVJpmtoPGCLeQvlQlpOo/F5V1SlZVFq278gWxkQtRg9rzLzy4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869308; c=relaxed/simple;
	bh=g9Z9OwBbBlUj3EmCyyduc+Z0LyVTi1wB3j1o6dvX7K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXyqZXY4imNKL0qZBs5N3wIjwWl2vUR3cBccLE9VTX4tX6vgtJjlYe1LBogABRtsccbUN0z1RAKLP8sNosK2Fn/5MK6eaJGHd6+WAEvJVZMbdXdMyu1fiasPAvjLET7Ac1pB1xVrvh0cBclD0Jak8DKEJVPGxz4oTS/g4OCmUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGreNy0Y; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso2415039f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869306; x=1713474106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mz0LAgWqLQ4vIJA31FUrD4xAYvlItStjsWSzrqzF/DI=;
        b=TGreNy0YEyauNqSeD7GlkAQxUm5gG2YbbhaBo/UkE/dAl7IfY3cnQVL2vggBcJMgLC
         EUVM2YwOhvW1PtPNd90BIOF0Q5x5JyhoKERjumgqE3xBinuhNhw6HuKBYWu/S6iMn8f/
         U9t4d3BkJGF247iWhkprUjqBBigCeBJr+EleA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869306; x=1713474106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz0LAgWqLQ4vIJA31FUrD4xAYvlItStjsWSzrqzF/DI=;
        b=bWQMFPxmd9Fu7TRyLxtpQ2D4k2AOqfcmh8V6hqmL57X5Yd1Cz3VzwCvpBCN8NRpDOI
         mLmYfJ9JJZt4sOOH6ch8WJ0V9niDCKU39ZRVoMF7y50k3xxhmMP8ntapZxyO1G3rXP9/
         Mer6Y6qsC2nwLV/milbbdFBJwiWZ3jzBk/83Ea48u/rVABXjeN/WvncIzwBe28F+impR
         wUZIZYIE0miB+WwH/AdTf5CxXpAlFAoEHEibuUd2aMoNWUUYRTrL31XuHXyDPskQt3ZN
         R8LhBw/4au6IZiOM4tyfHYN+C10M0DyOqIqizKbrfaAZVH7WUodfF+DwqiHIOVnoD+G3
         ICUw==
X-Forwarded-Encrypted: i=1; AJvYcCWQxXZWNSYQBfc1amCGFzrtrvZfjulJt9VwPngGiDhx2HcjBQOMepfxK5YBxsz1NxJTGZECnQry6Sgobxf0kxR2wKylGKICz07tJ/tDbV5F
X-Gm-Message-State: AOJu0YyTYCZRGxAyQ3g3t3Dj93Lvs18VM6yfnKt1mwYDqwBhS45Uqkq9
	l7um9v31Uol+MuAvTUb/AP9MGtUXLn9LwyNQQ/MPf5gkum7yb0NDXSimYxHQzcY=
X-Google-Smtp-Source: AGHT+IGsEGdSzFgXCL4lsDcVpmS1rvpe/RPrF3+da8lVZtwQ1MRvl8rCasczN/FrAV63L5n9RkrXvg==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr982307iob.0.1712869306060;
        Thu, 11 Apr 2024 14:01:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u22-20020a05663825d600b00482b91da84bsm605270jat.58.2024.04.11.14.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:01:45 -0700 (PDT)
Message-ID: <dcb1a59b-55a0-4a33-99a5-3800660b04b1@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:01:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Fix valid-adjtimex signed left-shift
 undefined behavior
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Lee Jones <joneslee@google.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240409202222.2830476-1-jstultz@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240409202222.2830476-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 14:22, John Stultz wrote:
> So, the struct adjtimex freq field takes a signed value who's
> units are in shifted (<<16) parts-per-million.
> 
> Unfortunately for negative adjustments, the straightforward use
> of:
> 	freq = ppm<<16
> will trip undefined behavior warnings with clang:
> 
> valid-adjtimex.c:66:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>          -499<<16,
>          ~~~~^
> valid-adjtimex.c:67:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>          -450<<16,
>          ~~~~^
> ...
> 
> So fix our use of shifting negative values in the valid-adjtimex
> test case to use multiply by (1<<16) to avoid this.
> 
> The patch also aligns the values a bit to make it look nicer.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Lee Jones <joneslee@google.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: linux-kselftest@vger.kernel.org
> Reported-by: Lee Jones <joneslee@google.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Link: https://lore.kernel.org/lkml/0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com/
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

Applied to linux-kselftest next for Linux6.10-rc1.

thanks,
-- Shuah


