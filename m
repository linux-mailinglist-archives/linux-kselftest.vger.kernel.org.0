Return-Path: <linux-kselftest+bounces-7597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD528A0062
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5EE1F24670
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57452180A95;
	Wed, 10 Apr 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bmHwTHjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DEF13BAF9;
	Wed, 10 Apr 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776435; cv=none; b=BmiD9oHPboWEf1042pX42W5QLootXNMuoUWVfJqD5tOq42rZc+XSBXsi/CyPonnpvbT7gSTG7yiMaeGRAiKI2SB/W4Jn8ShakOJPTfswSUU9SOxDKZN2ljtoLSvO5h4QBeJXchKsbpcMR9bLpBR4pn7vHPJIxIGBv+O7Elsu4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776435; c=relaxed/simple;
	bh=EiF+lApd4HUudR6Z3CKHixqIXlXakDIAySWD/Tqrfmk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hqR7HNW9Bsj1gEFW93xHD/vGB/jp5Rx4rFFA8MT7LJAZD5fHt4WpVOAANK/gBfH071/j9je+rFB+unIf9oBhVqyRJUvwi2C6PpuRYxKMQ/Ltt9NKrQ74dQ+Q4kmdqcy1zPV3jomKFgDRaTEP5C2MiHUh9KfHmQmuvbznEGKB3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bmHwTHjb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712776431;
	bh=EiF+lApd4HUudR6Z3CKHixqIXlXakDIAySWD/Tqrfmk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bmHwTHjbBZPgZl9A5hlKPr+ZsEdnRCCHZR/gFpHTNvYE/mkBAdidb+qlddiTofmvE
	 zeLlD3/gjrQbgHMN0Vr4zi8uyuDxiaNJmZLgWjiCrHdtFACKO4pXKtWbvPylgdtKG9
	 eChFQdhQIZRaG/ewPem9xaqhQ7IZ/qAjpbLTuoBLGL/jaOwnZ0hPDgKhgJhbUdSlvN
	 pwdvsMhdoPy2SSFVQrmajcLU7mIJQq9ybA/aWoDHQwd1/cAYgiqtpRC/qD/UNosYwT
	 WMF5XB6xVO6+lNpbGZsrOI/2O/aivwEI3/DXb3lBSwGLGBX3iF4e/+Ffrugu9Iuo8h
	 b0BTD0iEEenDQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9AA233781107;
	Wed, 10 Apr 2024 19:13:40 +0000 (UTC)
Message-ID: <b9c837e0-9182-4e59-9763-23ff47b0f587@collabora.com>
Date: Thu, 11 Apr 2024 00:13:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Lee Jones <joneslee@google.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: timers: Fix valid-adjtimex signed left-shift
 undefined behavior
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240409202222.2830476-1-jstultz@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240409202222.2830476-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 1:22 AM, John Stultz wrote:
> So, the struct adjtimex freq field takes a signed value who's
> units are in shifted (<<16) parts-per-million.
> 
> Unfortunately for negative adjustments, the straightforward use
> of:
> 	freq = ppm<<16
> will trip undefined behavior warnings with clang:
> 
> valid-adjtimex.c:66:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>         -499<<16,
>         ~~~~^
> valid-adjtimex.c:67:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>         -450<<16,
>         ~~~~^
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../testing/selftests/timers/valid-adjtimex.c | 69 ++++++++++---------
>  1 file changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
> index 48b9a803235a..9606d45767e7 100644
> --- a/tools/testing/selftests/timers/valid-adjtimex.c
> +++ b/tools/testing/selftests/timers/valid-adjtimex.c
> @@ -62,45 +62,46 @@ int clear_time_state(void)
>  #define NUM_FREQ_OUTOFRANGE 4
>  #define NUM_FREQ_INVALID 2
>  
> +#define SHIFTED_PPM (1 << 16)
>  long valid_freq[NUM_FREQ_VALID] = {
> -	-499<<16,
> -	-450<<16,
> -	-400<<16,
> -	-350<<16,
> -	-300<<16,
> -	-250<<16,
> -	-200<<16,
> -	-150<<16,
> -	-100<<16,
> -	-75<<16,
> -	-50<<16,
> -	-25<<16,
> -	-10<<16,
> -	-5<<16,
> -	-1<<16,
> +	 -499 * SHIFTED_PPM,
> +	 -450 * SHIFTED_PPM,
> +	 -400 * SHIFTED_PPM,
> +	 -350 * SHIFTED_PPM,
> +	 -300 * SHIFTED_PPM,
> +	 -250 * SHIFTED_PPM,
> +	 -200 * SHIFTED_PPM,
> +	 -150 * SHIFTED_PPM,
> +	 -100 * SHIFTED_PPM,
> +	  -75 * SHIFTED_PPM,
> +	  -50 * SHIFTED_PPM,
> +	  -25 * SHIFTED_PPM,
> +	  -10 * SHIFTED_PPM,
> +	   -5 * SHIFTED_PPM,
> +	   -1 * SHIFTED_PPM,
>  	-1000,
> -	1<<16,
> -	5<<16,
> -	10<<16,
> -	25<<16,
> -	50<<16,
> -	75<<16,
> -	100<<16,
> -	150<<16,
> -	200<<16,
> -	250<<16,
> -	300<<16,
> -	350<<16,
> -	400<<16,
> -	450<<16,
> -	499<<16,
> +	    1 * SHIFTED_PPM,
> +	    5 * SHIFTED_PPM,
> +	   10 * SHIFTED_PPM,
> +	   25 * SHIFTED_PPM,
> +	   50 * SHIFTED_PPM,
> +	   75 * SHIFTED_PPM,
> +	  100 * SHIFTED_PPM,
> +	  150 * SHIFTED_PPM,
> +	  200 * SHIFTED_PPM,
> +	  250 * SHIFTED_PPM,
> +	  300 * SHIFTED_PPM,
> +	  350 * SHIFTED_PPM,
> +	  400 * SHIFTED_PPM,
> +	  450 * SHIFTED_PPM,
> +	  499 * SHIFTED_PPM,
>  };
>  
>  long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
> -	-1000<<16,
> -	-550<<16,
> -	550<<16,
> -	1000<<16,
> +	-1000 * SHIFTED_PPM,
> +	 -550 * SHIFTED_PPM,
> +	  550 * SHIFTED_PPM,
> +	 1000 * SHIFTED_PPM,
>  };
>  
>  #define LONG_MAX (~0UL>>1)

-- 
BR,
Muhammad Usama Anjum

