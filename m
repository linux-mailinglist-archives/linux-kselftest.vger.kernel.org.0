Return-Path: <linux-kselftest+bounces-26108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF2A2D7ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 19:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A1163D42
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60524112B;
	Sat,  8 Feb 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9A1z+0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B3241107;
	Sat,  8 Feb 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037656; cv=none; b=QoWS+S5SlW9i4tBYCh8wxkW82lUqlZJXxvkRzcUg+cEzlEE2mK0+bn5S1Pq2fLQAcgGwkGFXbpgKc+FuVcKcVu+15v7pXEXr25+s+BixSaqOc/IKkwNPUMXZrX6L7GKulrWOrSzi1VF42iodhxlXrmThlu9lu6yYRqNiNb0igaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037656; c=relaxed/simple;
	bh=yPi01lgbmAIevC6u+JmsTgYoSkU/wFCQ44YinEUjDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaqFBPyYd5h69dIaNJEbOPUMBBEynFwtOFKCzNsHVVy9ItDw7iIX1tlvymnydS1Y2dvQuvC1S74yfGcIP99651hHMkg4jE4vIPOLM9EIYg36Hxxpm1VpvnQbzPQ6tCp2h+rfrwFUbiSq0xDlZVHKbYejhs8a4C+qidE2tL66DuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9A1z+0G; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f277a1ecfdso21981487b3.2;
        Sat, 08 Feb 2025 10:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739037654; x=1739642454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ50So012NUKYlUWEsNDmQqC2zUcRpvTKx1dhgNUOYI=;
        b=G9A1z+0GBpPdqEPAPdLJKDdDrc3yX2akYe44iFvL8eC57GYiwalogLvK3dxlHAW2HY
         eW82+MQjLDV5JyO/NrgbXSaR8EplXufRGFwtqy/qbZ9KUKCE7CAPQkde44ZB74CtfiUX
         zopfZU50U7XCyav4v19WryvpUCtKs4r1ai3wSmnhjxvZ4o73T8+T8tfgiJTKmq3793qH
         dPowK9RoC6DDo9p1s+JsUhCvJZVCIiEh3rTiTZGQdpraQEbk42mQcUOAfGh5wYzHRx04
         L1BRlGED64j5GXz4hIQCAN4MKU3PQEy92lP9tIElNunf/U3rLht7FowiwQRnefh7ntZO
         zfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739037654; x=1739642454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ50So012NUKYlUWEsNDmQqC2zUcRpvTKx1dhgNUOYI=;
        b=fWAgyUR9ilQs16VNA+9AjqtbGlCMHtIT3vS6VTIta+SF673AGm1jM+tKaSAjJw9+LE
         U5XGiknX8Q7qLAf6/aevSPDumkFNlxJNGobdbaUwcDKUYI0F6lOUT3T+AoSDknwYTP4g
         HDsWc4Do9GmrA3E5M8ZvTavgeonZwgpRGYDJe8ZJeOVHbLXS6GgQcdakbJQe8oHO2Ydp
         aa0PHNERQSmZyEwXvrnOgB+OLgH/f+uzjT+N9GYYnBOXt0cinx8C5B1SB/xAw6WZq/f0
         e5pMTIMmpsFh4TuZlKkjX49bPqZALas7fRDahsSF50nfDKakrrbccydnsUjQALoySDJN
         sQBg==
X-Forwarded-Encrypted: i=1; AJvYcCUtkHufcvPlFw7c1103mmOD3mTVERc1KwWhBFTCFYBZSoE57l3gwnuTbw8nHrdepxqQigTnAj1BrJZgGJc=@vger.kernel.org, AJvYcCWNwyMcLHTEUmgJ4GYA1kv2di8BYZgCeA0zlvUDZnQPpmoG16qYS2VvJNXgaMGI7Mz9CgeDDLaNXmbLYGIstn5G@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPIErp3GdNR6cyuZwY1vZhWIcGzD5RkLY++VaeXrBPVO5E6FX
	8VihdoyZnikPYYMUuGbazCujT+iGHylaMk7t2a5TKXgZWoXRKQLZpL9DHyJd
X-Gm-Gg: ASbGncuSEv38vWrHQiO/GJgtJCl0p86y1usWK0H3oPPKguvC0uFjw9rv9+ToQCiOX1m
	t+CUWLd0tXGn/dUECRwa3iFrCS4UEOolw3FMaRRQ44KLexgtmu/kwtGT6KoVd+AfPwvrSENlbQp
	iaUFR/fVZ4Yte/rK1+w79w7gytXb7wAFVNzOsDTkDQH7OEuCpIj+5l9CMjQJi/SNOQwcybaKUTe
	FRJk6WkxIJxl1IEhw9ammf+h3/caC7V2SrFejo6OkwF5/8rjrvfEgmMb7k/Z0YoTnmkj+qJugsL
	XNocvp0PwTniZ1+NQEtC5FItH92D5zGfC3tjygzSX32mBTMOB/M=
X-Google-Smtp-Source: AGHT+IFRlIpmB/OwyomFOIGum1C1obghY8tVh4HH+993/Q5NYcDDdMOhv5rQxRMHdGz7A/w4A5DwlQ==
X-Received: by 2002:a05:690c:7301:b0:6f9:a3c6:b2e4 with SMTP id 00721157ae682-6f9b2a216a1mr71260247b3.37.1739037653938;
        Sat, 08 Feb 2025 10:00:53 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ffc0b73sm9596537b3.104.2025.02.08.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 10:00:52 -0800 (PST)
Date: Sat, 8 Feb 2025 13:00:50 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] bitmap: remove _check_eq_u32_array
Message-ID: <Z6eb0mO_U76CS83_@thinkpad>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <20250207-bitmap-kunit-convert-v1-1-c520675343b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-bitmap-kunit-convert-v1-1-c520675343b6@gmail.com>

On Fri, Feb 07, 2025 at 03:14:02PM -0500, Tamir Duberstein wrote:
> This has been unused since commit 3aa56885e516 ("bitmap: replace
> bitmap_{from,to}_u32array") in 2018. Remove it to avoid the need to port
> it to KUnit in this series.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

OK, 7 years is enough to drop it. Adding in bitmap-for-next for
testing.

Thanks,
Yury

> ---
>  lib/test_bitmap.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 65a75d58ed9e..c83829ef557f 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -100,34 +100,6 @@ __check_eq_pbl(const char *srcfile, unsigned int line,
>  	return true;
>  }
>  
> -static bool __init
> -__check_eq_u32_array(const char *srcfile, unsigned int line,
> -		     const u32 *exp_arr, unsigned int exp_len,
> -		     const u32 *arr, unsigned int len) __used;
> -static bool __init
> -__check_eq_u32_array(const char *srcfile, unsigned int line,
> -		     const u32 *exp_arr, unsigned int exp_len,
> -		     const u32 *arr, unsigned int len)
> -{
> -	if (exp_len != len) {
> -		pr_warn("[%s:%u] array length differ: expected %u, got %u\n",
> -			srcfile, line,
> -			exp_len, len);
> -		return false;
> -	}
> -
> -	if (memcmp(exp_arr, arr, len*sizeof(*arr))) {
> -		pr_warn("[%s:%u] array contents differ\n", srcfile, line);
> -		print_hex_dump(KERN_WARNING, "  exp:  ", DUMP_PREFIX_OFFSET,
> -			       32, 4, exp_arr, exp_len*sizeof(*exp_arr), false);
> -		print_hex_dump(KERN_WARNING, "  got:  ", DUMP_PREFIX_OFFSET,
> -			       32, 4, arr, len*sizeof(*arr), false);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
>  				    const unsigned int offset,
>  				    const unsigned int size,
> 
> -- 
> 2.48.1

