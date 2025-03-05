Return-Path: <linux-kselftest+bounces-28313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9DA5031D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1100E17745D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E624EF8F;
	Wed,  5 Mar 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YGFw0zVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2524EAB6
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186915; cv=none; b=K7waaeMb4GPzkPH0tAsEbiSKuwOL1sYrQkrMvpysZtqOim+pzwmQG5/yRElCVPx1hyoQIH0IZSShShQHL0A4fNwo442FbtT9wgxY1k73NcvS/pMf8YkLesYLra3L5asTfv5AmQU3kqlHcRUPmCYW0NA+1QAAiRj/tzeaU6NoNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186915; c=relaxed/simple;
	bh=zKKT2DNZYDc2x71LTbFaTEx2RuLk5HlEdgpYM1jM5P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCGP70bZG+uJhfZjLzP+1hS6DJwi+ZMEY9sM7f8hNSgSCOhW5fjhGxMi165vJCs7Y4+AB1YmzZLWRTeHwEMDn5iIEEBDUznvRKBfrOLttInY9AiAN/pUJ/KqLuogMWbMf4cGzPGvfEfaNoLqX6skgCalHkd48DD9vlp/9CTg9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YGFw0zVy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39127512371so209233f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741186911; x=1741791711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdG7Oh58MvZC/b9QkwGcr8sXSCEuBrBHhrkMxJGjcHU=;
        b=YGFw0zVy3WSA/6putAI2jgf/T8d0KSL3U2g2Z5+AyHEbwchjI242tsnm0yHuNenBli
         ydsP/WwSZbzp3FUtJ3t8JQX+CRCrDCWTRqClGJJ7E/vHo0gaovd0ZJiZT3kEMdqmVF7b
         okHcO2JIGYM3j0SUooA2qN+55hwRqhbEoK9GUNRDqYJiqYR8SmuL3tEbiD6Yml/ixA4d
         Uzn60Hc2ayvlsHE029gVCuILOkVrvjwj4fk2MYeNjIrsIBQ40hs6eZ+xacQzAg2bYzNH
         buhW0oy2nTn77waUl72nc/kiNl8t4aZitQSjKGlqLDwTkfa21rc/ix+r4iRQXa1YrAUb
         3oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186911; x=1741791711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdG7Oh58MvZC/b9QkwGcr8sXSCEuBrBHhrkMxJGjcHU=;
        b=eDgVNpB4D55ESKATzj1sN8S33Q9ryjiu5LVqxlxuIEoMx6dzNxTPIV3DnxRl+Nw+hU
         qTebiPm1fkVJYfQwEK5+t62pVmUJ+Fs7FYoSwtCa0YvDgzNr+f57XtKeGVJsh6bdqxmH
         6V2JCdaiybGQsjseMsxu7ONr1Wm5enKtiEfj2bMT7U6A2jympPOo4WUkWwLNo1iKMXmp
         GUl1uUjbpWmsmiIfQYpb5b6uQs7uUg82bRnKxZy82DREmBKx0TGpmbmOuqtW1rgVLpAe
         HFbwihUfyfYdZDAX4AwQYMKv+xHswsh93VK99ptdjtEEbqelJsAROsUnrrMnZO6WM/Vu
         TStw==
X-Forwarded-Encrypted: i=1; AJvYcCVHkxAQPBSVRfnp6ob3SREtOuzME93+0anMG64Bmk9Q6D6QZb5XYcJkyxrgBVfgJefE80/dNsQsgEVX1mjTwfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQMvwJVMWf2CNc0qKV7sQyE4p24N0XXnxI/98BTK4EOtqmqJF
	rH0fw8/hWX1JtvO88XY6HAkTIXof3tLoLlZu1KJ1LpWArB8sNopm0x35GzoAA80=
X-Gm-Gg: ASbGncsXxO/h2/R1INWHQ2HMVZqWrbK76HTbcRd1/Kb/Z3YuXD5xWpyr5SKysi2k+5N
	gQJ+KcKoJFWrknSHuUI28cpuj4c9CsxUTtGxqidOjWCygzlInOmk4fg80v8umgcs6GBvHoX1o4S
	eK9VnQydpYeKOhy+LO/796ODVmS359XQFfjhkBY0YS4Tuum0z+EgoUCrYB1wa7C5xYldg8+WtTG
	K/yVTftgwF4bNw6d+2djIowreUICpHcNpWcfGjY8jKFFb2N8Pw1srvwdvmFEVwCjeKWgFLS45yO
	78JAtPNf9RZO78pvVfuZQKY9yp8y9Q4PY6PdAqz2IlbF+H0=
X-Google-Smtp-Source: AGHT+IGqBRaV7VEC5+Vtf+25z+O2urVf1kefaBeNF88lAB89SNBcrx+nzT2eKgiA1ohzGWdX3prvOw==
X-Received: by 2002:a05:6000:2cd:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3911f76f519mr3471109f8f.31.1741186910970;
        Wed, 05 Mar 2025 07:01:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844ac6sm21068688f8f.71.2025.03.05.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:01:50 -0800 (PST)
Date: Wed, 5 Mar 2025 16:01:48 +0100
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
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
Message-ID: <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:
> Use `suite_init` and move some tests into `scanf_test_cases`. This
> gives us nicer output in the event of a failure.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  lib/tests/scanf_kunit.c | 95 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
> index 3bbad9ebe437..fa215a7db366 100644
> --- a/lib/tests/scanf_kunit.c
> +++ b/lib/tests/scanf_kunit.c
> @@ -4,14 +4,10 @@
>   */
>  
>  #include <kunit/test.h>
> -#include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/overflow.h>
> -#include <linux/printk.h>
>  #include <linux/prandom.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
> +#include <linux/sprintf.h>
>  
>  #define BUF_SIZE 1024

It would make more sense to do this clean up in the 3rd patch
where some code was replaced by the kunit macros.

Also I am not sure about the choice. It might make sense to remove
<include/printk.h> because the pr_*() calls were removed.
But what about the others? Did anyone request the clean up, please?

I do not want to open a bike shadding because different people
have different opinion.

I would personally prefer to keep the explicit includes when the
related API is still used. It helps to optimize nested includes
in the header files which helps to speedup build. AFAIK, there
are people working in this optimization and they might need
to revert this change.


> @@ -50,10 +46,9 @@ do {										\
>  	for (; n_args > 0; n_args--, expect++) {				\
>  		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
>  		if (got != *expect) {						\
> -			KUNIT_FAIL(test,					\
> -				   "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
> -				   file, line, str, fmt, *expect, got);		\
> -			return;							\
> +			KUNIT_FAIL_AND_ABORT(test,				\
> +					     "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
> +					     file, line, str, fmt, *expect, got); \

I am just curious. Is there any particular reason why
KUNIT_FAIL() is replaced with KUNIT_FAIL_AND_ABORT()?

Did the move of some tests into KUNIT_CASE() increased the number of
reported errors?

Why is _ABORT() variant used in _check_numbers_template() and not in _test()?

I do not have strong opinion. The change just looks a bit ad-hoc and
inconsistent.


>  		}								\
>  	}									\
>  } while (0)

Otherwise, the change looks good to me.

Best Regards,
Petr

PS: I suggest to wait at least one or two days with the respin. Other
    reviewers might want to add their own opinion.

