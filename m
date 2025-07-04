Return-Path: <linux-kselftest+bounces-36512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD0EAF8BB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E341892AB5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE5246BBA;
	Fri,  4 Jul 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DOepv9ob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB21EF1D
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617075; cv=none; b=Er1pUYjsqvRhNUNKcKSetsB5h+qyyVWV/RtcK2M/c2DnwYMGJAF7Acm4kZNEOhOhIEO2siauouEYW8w/pMvepkSARePTjML7XPgNy11xG7176QHhxVx65zwL/DWGYzJA3s4q6l/4i82y19fpsxRsyUvWYecZKbu2N0noOI7g4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617075; c=relaxed/simple;
	bh=0lqAuo6UHKIcEVdcAhQ0RFFWEYzjNGi1bzBgpaylOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0a5VhoA14FvL/NU71UtYjq0a7W37GBAdEj0bUtZggmyAXaLOwsGF70Iybk6tuuHJbDkGuYjmSw5iY6SGHGCEoyNzajZ0qQHWhg4EQ9XeIeOg/gvmxf7jlK0IUsIzxyYUSc2HX5azZUpw/oDzy4DyQK5QRO+56fMhF4U6oUVVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DOepv9ob; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 4 Jul 2025 10:17:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751617061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASASzrlKQboUIkLWluBZCrMel/BU8gIUIO5M+yGTLBA=;
	b=DOepv9ob4oyEgjlwBbB1vq7+7jS4+iMelHgcPgmwT+0LSL9PngbsDS1WFEIz7g4iXTIm+h
	CFrbZdLKyj25uRPSu+SLUGfRvUj1rC8DDIzz0Ts5LjZT+kFlTd5/M3CDq6L6LiazYQ/G8B
	iPQxH8ltXx5yJQYujzO5OLz2R9awH1w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH] riscv: lib: Add sbi-exit-code to
 configure and environment
Message-ID: <20250704-d2ca01be799a71427b5163f9@orel>
References: <20250703133601.1396848-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703133601.1396848-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 03, 2025 at 06:36:00AM -0700, Jesse Taube wrote:
> Add --[enable|disable]-sbi-exit-code to configure script.
> With the default value disabled.
> Add a check for SBI_PASS_EXIT_CODE in the environment, so that passing
> of the test status is configurable from both the
> environment and the configure script
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  configure      | 11 +++++++++++
>  lib/riscv/io.c | 12 +++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 20bf5042..7c949bdc 100755
> --- a/configure
> +++ b/configure
> @@ -67,6 +67,7 @@ earlycon=
>  console=
>  efi=
>  efi_direct=
> +sbi_exit_code=0
>  target_cpu=
>  
>  # Enable -Werror by default for git repositories only (i.e. developer builds)
> @@ -141,6 +142,9 @@ usage() {
>  	                           system and run from the UEFI shell. Ignored when efi isn't enabled
>  	                           and defaults to enabled when efi is enabled for riscv64.
>  	                           (arm64 and riscv64 only)
> +	    --[enable|disable]-sbi-exit-code
> +	                           Enable or disable sending pass/fail exit code to SBI SRST.
> +	                           (disabled by default, riscv only)
>  EOF
>      exit 1
>  }
> @@ -236,6 +240,12 @@ while [[ $optno -le $argc ]]; do
>  	--disable-efi-direct)
>  	    efi_direct=n
>  	    ;;
> +	--enable-sbi-exit-code)
> +	    sbi_exit_code=1
> +	    ;;
> +	--disable-sbi-exit-code)
> +	    sbi_exit_code=0
> +	    ;;
>  	--enable-werror)
>  	    werror=-Werror
>  	    ;;
> @@ -551,6 +561,7 @@ EOF
>  elif [ "$arch" = "riscv32" ] || [ "$arch" = "riscv64" ]; then
>      echo "#define CONFIG_UART_EARLY_BASE ${uart_early_addr}" >> lib/config.h
>      [ "$console" = "sbi" ] && echo "#define CONFIG_SBI_CONSOLE" >> lib/config.h
> +    echo "#define CONFIG_SBI_EXIT_CODE ${sbi_exit_code}" >> lib/config.h
>      echo >> lib/config.h
>  fi
>  echo "#endif" >> lib/config.h
> diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> index b1163404..0e666009 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -162,8 +162,18 @@ void halt(int code);
>  
>  void exit(int code)
>  {
> +	char *s = getenv("SBI_PASS_EXIT_CODE");
> +	bool pass_exit = CONFIG_SBI_EXIT_CODE;

This is the first case of what may become more common - a config variable
which also has an env override. I think it may be good convention to
name them the same, i.e. the env name would also be CONFIG_SBI_EXIT_CODE,
unless you think that would be confusing for some reason?

> +
>  	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> -	sbi_shutdown(code == 0);
> +
> +	if (s)
> +		pass_exit = (*s == '1' || *s == 'y' || *s == 'Y');

We now have this logic in four places[1]. I think it's time we factor it,
and it's counterpart "!(s && (*s == '0' || *s == 'n' || *s == 'N'))"
into a couple helper macros. I'm not sure where the best place for
those macros to live is, though. I guess libcflat.h, but we really
ought to split that thing apart someday...

[1]
 - twice in lib/errata.h
 - once in riscv/sbi-tests.ha
 - and now here

> +
> +	if (pass_exit)
> +		sbi_shutdown(code == 0);
> +	else
> +		sbi_shutdown(true);

nit: can be written more concisely as

 sbi_shutdown(pass_exit ? code == 0 : true)

>  	halt(code);
>  	__builtin_unreachable();
>  }
> -- 
> 2.43.0
>

Thanks,
drew

