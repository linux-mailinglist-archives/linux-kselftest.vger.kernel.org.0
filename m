Return-Path: <linux-kselftest+bounces-36817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EFAFE582
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9392C188721A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1359B28935D;
	Wed,  9 Jul 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHnLE4r2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80332868B0
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056094; cv=none; b=XHApqKn09LX0pxP2VJL4jJfIv+SDN41uoU6XfK4/SBQQBgiw0q4/2dgkRgpgyMLrWqvMuJsYpRdmStD2RNy755hx4sMqaLajVAvMPBdRkEDcipXA2Sl84CPk7GboWVvMOxUDo0neJ5OD6Faqb4hrrKTzK4MatXk+jBvBXTBg0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056094; c=relaxed/simple;
	bh=qluOOSzDh1RAkPrHmIQWa+80diNxqL1p9YKstAiOZQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKA2axVcV5DtS/I/npbXLZI62IMd/ASdwsWpJ9z0y0/kfLKWXdTiPUW/88tFFqGtoH13VgWVzP9ivsY/jUuS02fxzsh8wsUNTkFk4ncNaBHjuEUiH+8sWSSge8OtSbTwi95dwGYbbSOkzbNDSUAhvJlD9MKrl1puDY0FU0hZ3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHnLE4r2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Jul 2025 12:14:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752056079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKEeOEkJgKa8SgaaGBKi6AgnPwQW6DS02b4hY16t4/U=;
	b=tHnLE4r2hNVILR7jbWLs+nVFNl/zCL4zo6R7QFE1rGFvNtXDbBlKOEBpSFCTHFVli9tOQh
	WWrgObcEnGxJoNsPbtNjWmvrmQPZmiVqwNkrD4jFWxDt9raqit0kzgLnyn0z9Nx3au9y+H
	i7L5YZs8CdX2qdb2KojPliu2OQ7An48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/2] lib: Add STR_IS_Y and STR_IS_N for
 checking env vars
Message-ID: <20250709-146e598f21c7cc1fb99f88e0@orel>
References: <20250708154811.1888319-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708154811.1888319-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 08, 2025 at 08:48:10AM -0700, Jesse Taube wrote:
> the line:
> (s && (*s == '1' || *s == 'y' || *s == 'Y'))
> is used in a few places add a macro for it and it's 'n' counterpart.
> 
> Add GET_CONFIG_OR_ENV for CONFIG values which can be overridden by
> the environment.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  lib/argv.h        | 13 +++++++++++++
>  lib/errata.h      |  7 ++++---
>  riscv/sbi-tests.h |  3 ++-
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/argv.h b/lib/argv.h
> index 0fa77725..ecbb40d7 100644
> --- a/lib/argv.h
> +++ b/lib/argv.h
> @@ -14,4 +14,17 @@ extern void setup_args_progname(const char *args);
>  extern void setup_env(char *env, int size);
>  extern void add_setup_arg(const char *arg);
>  
> +#define STR_IS_Y(s) (s && (*s == '1' || *s == 'y' || *s == 'Y'))
> +#define STR_IS_N(s) (s && (*s == '0' || *s == 'n' || *s == 'N'))
> +
> +/*
> + * Get the boolean value of CONFIG_{name}
> + * which can be overridden by the {name}
> + * variable in the environment if present.
> + */
> +#define GET_CONFIG_OR_ENV(name) ({		\

This should be named GET_ENV_OR_CONFIG since the "first_or_second" naming
implies that if the first thing doesn't succeed, then try the second.

Thanks,
drew

> +	const char *s = getenv(#name);		\
> +	s ? STR_IS_Y(s) : CONFIG_##name;	\
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
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

