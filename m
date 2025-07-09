Return-Path: <linux-kselftest+bounces-36842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A5AFEF4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C645E16F657
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A6221FDE;
	Wed,  9 Jul 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xqiZ1pRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE352221F13
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080350; cv=none; b=LZjecMrpdZeFFnyhrDHKY9Jgk+0bX2xIJSDZmWMHISY1VWxhx2RNicQL5CBwW+h3BlmL68Ccn++yRNQWVeWrn7WUuQAZjsXC4z/Z++J5ImecCGmij9XNLJqWEeuFXgO91S+Z7l9Md/Z/OrAlMIHtPKxGJstliElhM747qjhzYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080350; c=relaxed/simple;
	bh=yGxwMcJwZQFmGY0FXwaOPaiDi66sXp3M37GaPltJy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tijI0wCDNUznOIdLakYEcZeXmpgiGW2iSoTzs+bPfFIueALEaKTu16paAZvs916KsNEMl3yO8cBD6Kv0X9rtHkEaEUofnXwHoeVmcXU04bMtQRZAvtFxxihU6hdC/Idop04rtBKV5vGDvm3C89DM/c96lPlIggUQcZClk40hj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xqiZ1pRU; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Jul 2025 18:58:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752080334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SmTSwGokE6/pfKrE9j0nZ7Ups7+XDSSuEFqTSsIVIX0=;
	b=xqiZ1pRUBftM4W7jFWkb3PN9Y7YNdP4pql/jWxdTKgjnbNVYMiT2PdwtMxj9NBRnEeFYa5
	dIZjC1CFfoDh/9NUI2KSHmf3N/dTOgjnUPnytA0Er+hvkQ0pXSzI2JKtnz/BthyJDNeRZR
	H8bb2mxP6DRQpgUX1qfh5DGDMU72eRw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 1/2] lib: Add STR_IS_Y and STR_IS_N for
 checking env vars
Message-ID: <20250709-bf1dae41ebcc5c636afdab9d@orel>
References: <20250709134707.1931882-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709134707.1931882-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 09, 2025 at 06:47:06AM -0700, Jesse Taube wrote:
> the line:
> (s && (*s == '1' || *s == 'y' || *s == 'Y'))
> is used in a few places add a macro for it and its 'n' counterpart.
> 
> Add a copy of Linux's IS_ENABLED macro to be used in GET_ENV_OR_CONFIG.
> Add GET_ENV_OR_CONFIG for CONFIG values which can be overridden by
> the environment.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>  - New commit
> V2 -> V3:
>  - Add IS_ENABLED so CONFIG_##name can be undefined
>  - Change GET_ENV_OR_CONFIG to GET_CONFIG_OR_ENV
>  - Fix it's to its
> ---
>  lib/argv.h        | 38 ++++++++++++++++++++++++++++++++++++++
>  lib/errata.h      |  7 ++++---
>  riscv/sbi-tests.h |  3 ++-
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/argv.h b/lib/argv.h
> index 0fa77725..111af078 100644
> --- a/lib/argv.h
> +++ b/lib/argv.h
> @@ -14,4 +14,42 @@ extern void setup_args_progname(const char *args);
>  extern void setup_env(char *env, int size);
>  extern void add_setup_arg(const char *arg);
>  
> +/*
> + * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
> + * these only work with boolean and tristate options.
> + */
> +
> +/*
> + * Getting something that works in C and CPP for an arg that may or may
> + * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
> + * we match on the placeholder define, insert the "0," for arg1 and generate
> + * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
> + * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
> + * the last step cherry picks the 2nd arg, we get a zero.
> + */
> +#define __ARG_PLACEHOLDER_1 0,
> +#define __take_second_arg(__ignored, val, ...) val
> +#define __is_defined(x)			___is_defined(x)
> +#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
> +#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
> +
> +/*
> + * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to '1', 0
> + * otherwise.
> + */
> +#define IS_ENABLED(option) __is_defined(option)

I'm tempted to say this belongs in lib/linux/kconfig.h, but since we don't
have any other kconfig stuff, then I guess argv.h is fine.

> +
> +#define STR_IS_Y(s) (s && (*s == '1' || *s == 'y' || *s == 'Y'))
> +#define STR_IS_N(s) (s && (*s == '0' || *s == 'n' || *s == 'N'))
> +
> +/*
> + * Get the boolean value of CONFIG_{name}
> + * which can be overridden by the {name}
> + * variable in the environment if present.
> + */
> +#define GET_ENV_OR_CONFIG(name) ({				\
> +	const char *genv_s = getenv(#name);			\
> +	genv_s ? STR_IS_Y(genv_s) : IS_ENABLED(CONFIG_##name);	\
> +})
> +
>  #endif
> diff --git a/lib/errata.h b/lib/errata.h
> index de8205d8..78007243 100644
> --- a/lib/errata.h
> +++ b/lib/errata.h
> @@ -7,6 +7,7 @@
>  #ifndef _ERRATA_H_
>  #define _ERRATA_H_
>  #include <libcflat.h>
> +#include <argv.h>
>  
>  #include "config.h"
>  
> @@ -28,7 +29,7 @@ static inline bool errata_force(void)
>  		return true;
>  
>  	s = getenv("ERRATA_FORCE");
> -	return s && (*s == '1' || *s == 'y' || *s == 'Y');
> +	return STR_IS_Y(s);
>  }
>  
>  static inline bool errata(const char *erratum)
> @@ -40,7 +41,7 @@ static inline bool errata(const char *erratum)
>  
>  	s = getenv(erratum);
>  
> -	return s && (*s == '1' || *s == 'y' || *s == 'Y');
> +	return STR_IS_Y(s);
>  }
>  
>  static inline bool errata_relaxed(const char *erratum)
> @@ -52,7 +53,7 @@ static inline bool errata_relaxed(const char *erratum)
>  
>  	s = getenv(erratum);
>  
> -	return !(s && (*s == '0' || *s == 'n' || *s == 'N'));
> +	return !STR_IS_N(s);
>  }
>  
>  #endif
> diff --git a/riscv/sbi-tests.h b/riscv/sbi-tests.h
> index c1ebf016..4e051dca 100644
> --- a/riscv/sbi-tests.h
> +++ b/riscv/sbi-tests.h
> @@ -37,6 +37,7 @@
>  
>  #ifndef __ASSEMBLER__
>  #include <libcflat.h>
> +#include <argv.h>
>  #include <asm/sbi.h>
>  
>  #define __sbiret_report(kfail, ret, expected_error, expected_value,						\
> @@ -94,7 +95,7 @@ static inline bool env_enabled(const char *env)
>  {
>  	char *s = getenv(env);
>  
> -	return s && (*s == '1' || *s == 'y' || *s == 'Y');
> +	return STR_IS_Y(s);
>  }
>  
>  void split_phys_addr(phys_addr_t paddr, unsigned long *hi, unsigned long *lo);
> -- 
> 2.43.0

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

