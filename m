Return-Path: <linux-kselftest+bounces-14313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1893E05C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 19:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65711C20D81
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B5181B88;
	Sat, 27 Jul 2024 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOCb0rQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF41538A;
	Sat, 27 Jul 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722101711; cv=none; b=hE35diLFSZDANUSY+dv42PSXa9ic82J3lUWO4I4ebnS3EK/U9U2inTcF6eC6WIsoTgLGJI9bYkwSfeaEQq23Mc8aA9bODcNlI2iljxEF2RvwSa+IjnR/84jr7GV/xfHyCcxdT0C4C+ff/eFSkPsk908onmU3Eoc6qt1E5QHbixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722101711; c=relaxed/simple;
	bh=5Xk7NNgsqzKbWaGu7UtznMmNZZfuC2EGlsBxzScP1qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+XRs952oECjbOEz1VZGtnzaCVUNPnvcoDoOc09/LeoVRSWgACi+gHSnAoj6h0O2C0RPWlthlUbNTNhjRghZIzTn5WOk6t47qr5COGGubLMgE5N+N/F4lLitesIDJGHycZKmClEKgV7WZUBaS+epVUsfoQpGeVL5jny5YKs2Akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOCb0rQX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-663dd13c0bbso7047827b3.1;
        Sat, 27 Jul 2024 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722101709; x=1722706509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icnj30uNxsVPUuOFIKoBeYwoQ2EQA/WqF68AVz/6OvI=;
        b=NOCb0rQXC1h0CpTKGLKllcLe+aT4KwQP6OgUsdXioLDqkKrGsAMeg8aGUZkG9hR4XB
         tnbJEQFgAA6FW1vyqkv6gHGr9W/Pn3DzD651Zbp3vMAyzm6G1VZQmlfop7Oa6sfHdWvs
         MB/056RZIOGGzHW3/3D2WMNXS1Bhbzaf0YWfZ03wOaOL9fXpJsb655pJnc1gDfn4S+by
         grsQdDIWla3xmIkow7GtbZFwcQLhsCFeHlAAvBqERLqfrJuy5Jx1UHHIDVVmG2U4HWaX
         vn7Uxnno9pxXXAEmoNsde8YQwYe+LayLUVu48RajzZV3a72Jlu/A7J20uKBxNQxuoiQL
         p41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722101709; x=1722706509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icnj30uNxsVPUuOFIKoBeYwoQ2EQA/WqF68AVz/6OvI=;
        b=dOJoacWVlS3n7zn2et5k0Wu02QbCROIKvuKc61FBf8TNhk5aITYPWYwsMLvSSbzgHB
         AxB072+ivnQ1ZNGUxRje4YXZpCLFez168tzdXk9fTRfx1o6XL7RqSqYAjJDXZ0SwXh6/
         C8eWt+KEC6ysyGfM1o6pu7nrcEKyW32L151YOg7EnZSkBh8NEB2PMy37VFYsA0NwkeZh
         5qSp7sFLOSKSujW8C73psl6S8JGaCRT/LhZv199nRB+5FUrrWm6uEJbLvIuReqCgVKcu
         NFrCs6uIUdEe9XbmXAhtV7ZiRJfWvFqWCeKBZEtLUhEMtMacfHL2afqTdOrZGAGmWH7X
         Jo7w==
X-Forwarded-Encrypted: i=1; AJvYcCWFyx6Y5UPb0ItagrYcJZ4DYm7ERgUNCqOMMoyfcrBH6pXfPNkEAUf5sPLJDS5fg4t90FG0Sb8Vau2ax0I2Ns5ryYSTiP+5v2mqR5k7pdd8cewZDNTYrTC/913qLU/amF4OElmVtJoIa4riGdqQ
X-Gm-Message-State: AOJu0YzWS6sipgR6jck0uWPS21Q3tA0nsjdB88ZVv69QFVXkzxJ6zC4p
	R+YQuvj614tnmPZNRDWTb67Ewtp5hnpN1VtsyNVGiWIUabuvd8v3
X-Google-Smtp-Source: AGHT+IH5RgppEweMGkk04/JUkI4d9ivRRtVBXq2qhjztezx2vwksWltCQXaYDTHTsx6LJqYzi6vHyw==
X-Received: by 2002:a05:6902:2183:b0:e08:5a7e:19ac with SMTP id 3f1490d57ef6-e0b5459ffd7mr3090731276.31.1722101709118;
        Sat, 27 Jul 2024 10:35:09 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b59480d85sm295071276.29.2024.07.27.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 10:35:08 -0700 (PDT)
Date: Sat, 27 Jul 2024 10:35:07 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kees@kernel.org,
	David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>,
	kernel@collabora.com
Subject: Re: [PATCH 2/3] bitmap: Rename module
Message-ID: <ZqUvy_h4YblYkIXU@yury-ThinkPad>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726110658.2281070-3-usama.anjum@collabora.com>

On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
> Rename module to bitmap_kunit and rename the configuration option
> compliant with kunit framework.

... , so those enabling bitmaps testing in their configs by setting
"CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
not realize it until something nasty will happen.

Sorry, NAK for config rename.
 
> Cc: kees@kernel.org
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  MAINTAINERS                           |  2 +-
>  lib/Kconfig.debug                     | 15 ++++++++-------
>  lib/Makefile                          |  2 +-
>  lib/{test_bitmap.c => bitmap_kunit.c} |  0
>  4 files changed, 10 insertions(+), 9 deletions(-)
>  rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12b870712da4a..289b727344d64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3814,13 +3814,13 @@ F:	include/linux/find.h
>  F:	include/linux/nodemask.h
>  F:	include/linux/nodemask_types.h
>  F:	include/vdso/bits.h
> +F:	lib/bitmap_kunit.c
>  F:	lib/bitmap-str.c
>  F:	lib/bitmap.c
>  F:	lib/cpumask.c
>  F:	lib/cpumask_kunit.c
>  F:	lib/find_bit.c
>  F:	lib/find_bit_benchmark.c
> -F:	lib/test_bitmap.c
>  F:	tools/include/linux/bitfield.h
>  F:	tools/include/linux/bitmap.h
>  F:	tools/include/linux/bits.h
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a30c03a661726..6bb02990a73e7 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2420,13 +2420,6 @@ config TEST_PRINTF
>  config TEST_SCANF
>  	tristate "Test scanf() family of functions at runtime"
>  
> -config TEST_BITMAP
> -	tristate "Test bitmap_*() family of functions at runtime"
> -	help
> -	  Enable this option to test the bitmap functions at boot.
> -
> -	  If unsure, say N.
> -
>  config TEST_UUID
>  	tristate "Test functions located in the uuid module at runtime"
>  
> @@ -2813,6 +2806,14 @@ config USERCOPY_KUNIT_TEST
>  	  on the copy_to/from_user infrastructure, making sure basic
>  	  user/kernel boundary testing is working.
>  
> +config BITMAP_KUNIT_TEST
> +	tristate "KUnit Test for bitmap_*() family of functions"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the "bitmap_kunit" module that runs tests for
> +	  bitmaps int the kernel making sure that there isn't any bug.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index 322bb127b4dc6..37e7359a7065e 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_SCANF) += test_scanf.o
>  
> -obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
>  ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
>  # FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
>  GCOV_PROFILE_test_bitmap.o := n
> @@ -388,6 +387,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>  obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
>  obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
> +obj-$(CONFIG_BITMAP_KUNIT_TEST) += bitmap_kunit.o
>  
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>  
> diff --git a/lib/test_bitmap.c b/lib/bitmap_kunit.c
> similarity index 100%
> rename from lib/test_bitmap.c
> rename to lib/bitmap_kunit.c
> -- 
> 2.39.2

