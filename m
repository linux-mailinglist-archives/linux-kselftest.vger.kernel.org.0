Return-Path: <linux-kselftest+bounces-29043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B9A611F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF17AC03A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC11FF1A4;
	Fri, 14 Mar 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FVC0cYeu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD482E3398
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957474; cv=none; b=Bs8KYiNIm+bZjABlr7p/zkIIGuOW6IBB72Sw7DlmfATuQLts5ShAhmkOQwePHnWKKi25cI7bkFLS/LfjBOdl6Lwvn3BZUPI7839j467IUGZCI8Zw2GaOeGWP1bp+z6E0nxEDrzOKYVKTxy4TiY8bb71pH1/z8qNzb7IcJWUVXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957474; c=relaxed/simple;
	bh=YrtvhfhP/Znn3fNZU4UiIYAYE8ptrotjbF/EGYUxQK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw5BdgP6s4kvXAoI+0l891bOKJ5SjZvKvpH7cD1XbeGwGoD/M6/joyHbTMv5XWnXAsdTomWnctIKLB4GBWpY/etCMXUldDx5yVD5s4TKXG1MKikW6Pc2ANto3Cf6HgoHiyyFWxqkkQcGxm9Z2TkkOVaUWvv2kUlv3MEMZYM84CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FVC0cYeu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso14268905e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741957470; x=1742562270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXEAhjO+FZzhjAKSipo0fbPH75GS1MBoxQtrIWgvBF8=;
        b=FVC0cYeuzs7pNCqvicGAQv1g5hluybS2mHAoYAfP8+fJkhAEl4aS3EE0v69oB0agcE
         sahcxak3kFs4otGN7ipVLs0mriF+NknzUr3rwMInepXp2fJuk74f7XngBuY0iGC7qyoQ
         ZntLWyuWR9zeRCQp9ugBIDfPcM6pPdi0QZ17McEb2HsWBBlpnmIv8rL/QtdgW8jRER1X
         gtbNsy+cG5PualPgGUSIutNm1seLKBgq4ah7NgQNm14sUWlagQ4V7n6MQsjPKoF2WfMb
         3nndap5ssyZmceFZ/3K1V1UFknitgeNwfSXW7LiLs2koC/tEQC76l8v2APMxV8zYtlLR
         z5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741957470; x=1742562270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXEAhjO+FZzhjAKSipo0fbPH75GS1MBoxQtrIWgvBF8=;
        b=ZV4uJpIZvKpzHCK3k0eG7kRIiVGWjUeXJCSZzcO3JWGbiievsepT8WFxwvUuhWAQXi
         yVt99Fr/PoR5KjoPAMhX1JJpCxOj3FuEC3OoXjwrqJSEBBWVfmMZzym8jyytK+t374Nt
         q1AJwauVEc14acTFWIdL2Xn274/GmogQP1d4r60GG9Z3Gb2P6hUuWP3UYz5fQeskw5qT
         GU1BaJDQaUFembaKDF8Oj9mmYMtB9QcT6KCbk3gv0xAp2swpftGsM7sepqOOkiLVWVFO
         0sZsNXTIaeGcowhjVTApmalrHbPR+3WYiw8zM/Tt3WlWVcnSB8jmLUB2R/J/BTtKHwoE
         WTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURdXfva1wHE7qkcsGEtXsftKkoGe+vxPEJWus3+RdjZDmlWcZE64aC89w9K5GRJw2ltHnhImIWkd2b0Jbhyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2gwYmPx6gdDasR3XMH8FxF+a9g4Ks+O2FG9JuVDp8TcL0Rvb
	eXLS93TYDcP2Q5gw55Ws1+V6WnV42Twcu3Y0T8sNnl9k+Y61cv8dTKj3+oUBkzk=
X-Gm-Gg: ASbGncs8SeZA1iyTAW4H4gxYFhdge/eIHZgZhqmL4oIAL8HjhJgflU5aADXg/13yOAc
	THlskFDkyE1Lmxm2sd+jaVvoGlnR09Boyxxyi5cT82boA0MYZNQfXDqayl4naV6/gkv74c9/ehk
	POXshLsxXNGsK00VN80EnLNqrWeOClvHEIH0d1K7jFIPA+h/eLCyxj5JWO8hxlh/3Zbqf3OjhIm
	8bCqZXjhlMpMUdUeyUZnLLnUJ5vkpvPVOhrv+/UsXzLlbXvu78XnW+J144SJPZTDuUa8+oklreb
	5LmBgqM2sBrrHdZ24CuSSy1+Hkxy4L7odHgvte1oJd4wW/w=
X-Google-Smtp-Source: AGHT+IHX8lnwJXQp9lmsaTQS54crU+G64pDcAvklWf9R0V2hsgHpJVwfSwI5w9rxAsR7GygmwCqXlA==
X-Received: by 2002:a05:600c:1c29:b0:43d:ce4:ef3f with SMTP id 5b1f17b1804b1-43d1ecbc1damr30518925e9.12.1741957469797;
        Fri, 14 Mar 2025 06:04:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc4173sm16908685e9.20.2025.03.14.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:04:29 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:04:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 5/6] scanf: tidy header `#include`s
Message-ID: <Z9QpWwlJn1U3tTjP@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:38, Tamir Duberstein wrote:
> Remove the unused `kernel.h`. Replace `string.h` with `sprintf.h` as the
> former doesn't seem to be used directly.

> --- a/lib/tests/scanf_kunit.c
> +++ b/lib/tests/scanf_kunit.c
> @@ -5,12 +5,11 @@
>  
>  #include <kunit/test.h>
>  #include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/prandom.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
> +#include <linux/sprintf.h>
>  
>  #define BUF_SIZE 1024
>  


The change makes sense and looks good to me. I would go with it.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Further improvements might be done later in a separate patchset...

Best Regards,
Petr

