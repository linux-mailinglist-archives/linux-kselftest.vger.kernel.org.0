Return-Path: <linux-kselftest+bounces-28307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B33A4FEF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE5016BDD0
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C22E1FCF6D;
	Wed,  5 Mar 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FxVzKQp7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B41DC9AA
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178802; cv=none; b=n2srQ3iKLeC7fJfa/4mfa7lR+WvytwY+kzRPaGmxfhHJSbQGgcvNCf5J0GrSXiMFKN3gV4MakOehmHnkHjcklVsLFRHsFOAw2JKbB1IPgTPtbjDkq27rsiXPWOudDCnOqc0LAKkgiR665whwB8PlnZLnlwRr94DP16oVu2GGySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178802; c=relaxed/simple;
	bh=WdS934lDxFuI+lDi4WoiWzb2Te4Np1NHLjMjIUYas7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL5CV6W0/hOi1V/A+6BolUM67XhRj81p9X/pSSYjJ+wuAAvRfGoa5YhqwRIMKE1nCEp0WVpU40ipitWLAJkMAamB94BesdU6RFAbpDRylRMYOyiv5OPyVv2swaZjqV2Mz4D09Pb9K3ow2U2YqUHVd3vffyxU6yi8Bm6xxgk2bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FxVzKQp7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390fb1b987fso4775726f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741178798; x=1741783598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KijU2RK+5QiUTMaMHbVobX3TCajOSEvmIS7Lj9sfhOM=;
        b=FxVzKQp7cZaM+4mdVVPpvwZdWqQF4tPb/k3yWkANko/ac8GB8GHSavmos/mkTnbotl
         5t7Zhj4ElTHAw+OxBE2pXfWgHFTETcwRsztNa/JGr4h9K2kMvJbq5BKrXk0oLp0lj4AD
         qOQoDggpJFK9ZdNasDnDOF2L7pjAiz1bqtub2dk05WMashNTmPaisAeCoZcRnOPs+hTF
         WN/qachUuOHOWD1HfyX9ctvMteY1n5Dc2H8vSaC4xmLqkWobwxy3ppc6+091lclOrs1k
         1glW+3HYbu5Yqkxn4XEt3uhU88PJfrVGyvET73R+pBcTyCUTzS26LhuPEyYBlTgrSQ2S
         Df5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178798; x=1741783598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KijU2RK+5QiUTMaMHbVobX3TCajOSEvmIS7Lj9sfhOM=;
        b=xQzhkJX142XAHQ2A9zzNqx19SbItpratRZjkQVwsyeO/dWQq/e2gpu+q+uQ2DfC4LD
         0YAh/1/emE63WGQ8Oy8NUJa/SG7+JJgVJTRFUednoAp5YRQlRUgEepOTHQUJ0Kay1PlD
         BFT8tarbhVC+/lBXfHHOgBZp2jYGxG13hwWqigSQ3rWuXwScKKj3J7tTwopgVhNEocVp
         VDtf/WJ5tomJOUREryIzlEV93St+vKa5SDRas4QPn9o2uZovBEGOKfIahm4do+gCPPNH
         pSfYgMlX1HxCHy6HTn+GYFX7/T48LXzh3col9yk0+/BAZdvYR140501HuXrmvBaax6WG
         hbiA==
X-Forwarded-Encrypted: i=1; AJvYcCWC6j53AS5kNqO+eW2G/D8on331nqNOsKj0FuUyV5AkXBF7XGtp7Sgxio7RpwHKgSYo299ojWq4GF5MkIowioM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKUmOvjGh7dCVGQ9OEU7RWsM4jGRKhCqjHcxr4svRzxTrXufp
	KPOHl0CiaQu9THk2b71jgN10CX4TtgzBbY/wg9X17wVNw7e5CnlwHGC8ICqTTwo=
X-Gm-Gg: ASbGnctiz8TkQyiHOeJ01pYy4Lm7flYa1qD4LDWp+Godw3Q/SfcjlKe78jQ+xeH5uL3
	sjHSlU1+YycKsk6XjI/lFZT7k1en4VVqj7JEbO/SifwCZU7uIDJj8c+0XoQNPtxeQNshNUT6a33
	uhvGIhyo84pA4uf/nf3+Kv1/OYcz/JCPQ3UQDQwrq8ioXKqcF/buFCHq1XrUdD4sdeMhK3FeG05
	cOGlYXEW5m1rMoR2UqLh8vQ1+dwYLOmai8gkkPhTKG6DO2lITRmCNzgUBar4uoKt2vEG4UYIsAy
	LB9SJRdsCwd7HI5Hw6uvr3EhmwO/YXmM3ONHEfaQNN/M07g=
X-Google-Smtp-Source: AGHT+IEPLJpRRf5FYWw3IKOdFaaLj6UT7vruoSQtSNaRt2Dkg2TweUaV2rcBDSTkZ88x2LYdtyxZrg==
X-Received: by 2002:a5d:59ae:0:b0:391:10f9:f3a1 with SMTP id ffacd0b85a97d-3911f7bba1fmr3029040f8f.35.1741178798392;
        Wed, 05 Mar 2025 04:46:38 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a9fsm21175534f8f.36.2025.03.05.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:46:37 -0800 (PST)
Date: Wed, 5 Mar 2025 13:46:36 +0100
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
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
Message-ID: <Z8hHrIz2wwAMtQc8@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:20:00, Tamir Duberstein wrote:
> Convert the scanf() self-test to a KUnit test.
> 
> In the interest of keeping the patch reasonably-sized this doesn't
> refactor the tests into proper parameterized tests - it's all one big
> test case.
> 
> --- a/lib/test_scanf.c
> +++ b/lib/tests/scanf_kunit.c
> @@ -15,48 +13,35 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  
> -#include "../tools/testing/selftests/kselftest_module.h"
> -
>  #define BUF_SIZE 1024
>  
> -KSTM_MODULE_GLOBALS();
> -static char *test_buffer __initdata;
> -static char *fmt_buffer __initdata;
> -static struct rnd_state rnd_state __initdata;
> +static char *test_buffer;
> +static char *fmt_buffer;
> +static struct rnd_state rnd_state;
>  
> -typedef int (*check_fn)(const char *file, const int line, const void *check_data,
> -			const char *string, const char *fmt, int n_args, va_list ap);
> +typedef void (*check_fn)(struct kunit *test, const char *file, const int line,
> +			 const void *check_data, const char *string, const char *fmt, int n_args,
> +			 va_list ap);
>  
> -static void __scanf(6, 0) __init
> -_test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
> -	const char *fmt, int n_args, ...)
> +static void __scanf(7, 0)

This should be:

static void __scanf(7, 9)

Otherwise, the compilation with W=1 produces the warning reported by
the lkp@intel.com kernel test robot, see
https://lore.kernel.org/r/202502160245.KUrryBJR-lkp@intel.com

> +_test(struct kunit *test, const char *file, const int line, check_fn fn, const void *check_data,
> +	const char *string, const char *fmt, int n_args, ...)
>  {
>  	va_list ap, ap_copy;
>  	int ret;

Otherwise, it looks good to me.

With the above fix:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

