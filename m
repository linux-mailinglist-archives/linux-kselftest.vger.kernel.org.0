Return-Path: <linux-kselftest+bounces-36816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58059AFE588
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224D754803C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E928A1F2;
	Wed,  9 Jul 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KHHYqNg+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B02877F4
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055892; cv=none; b=aYsfFMMFgpJXeIeKIyHHeoRRe+QBBTOcwle2SSrivysMGXajOYcOflXgfsai4rtoJOrt/ndVCP7+7lNTdpmQYwRJvFVrhnvKhjD+VOb7RH9kV6v1Cb31yD6PaVMr8TaDWN0qaJWLzL8Ns7KITR+RvS4yfFpDelgel+uK2B9eyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055892; c=relaxed/simple;
	bh=djL7fVXYmOCynZkpkiSesui9NQSJknAb8DE/tDzGUdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3HCUHRwmZTLpcq+ppDM0IY1Pl1h2aA9ZhnDCf4+HC5roX33v19NBOfFhD4cupymyq05xaUAhnakVlBebOlP/TUGBisMLRFcEknqdgmpBMlKE8x3hmoMBiOIPIEL7kXEiA+RMlFbdI6A9xN7kevV9LQjfl4/lYaalY/SWIGGw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KHHYqNg+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Jul 2025 12:11:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752055884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvzhVKn5QMLTrSvpQmmJbAfpNgi2rhLZNaG0BHlE0eg=;
	b=KHHYqNg+6FdI7k0DG7nUbhnmLKsGb6zGctcd416DKr/dvXe+QtR5fUUosRXNHhM9PsHXvh
	Q549vP6KjK+G8kiOVICPZ+lVgoair4PE+2KljPi/KIqqCdXJf/1AL+lNtnABuCNeoSuZVX
	PuKmR8gVX5Qc04JRJ9IJ3rc/XdbAezM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/2] riscv: lib: Add sbi-exit-code to
 configure and environment
Message-ID: <20250709-93076fafcec83e14102193dc@orel>
References: <20250708154811.1888319-1-jesse@rivosinc.com>
 <20250708154811.1888319-2-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708154811.1888319-2-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 08, 2025 at 08:48:11AM -0700, Jesse Taube wrote:
> Add --[enable|disable]-sbi-exit-code to configure script.
> With the default value as disabled.
> Add a check for SBI_EXIT_CODE in the environment, so that passing
> of the test status is configurable from both the
> environment and the configure script
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  configure      | 11 +++++++++++
>  lib/riscv/io.c |  4 +++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
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
> index b1163404..c46845de 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2023, Ventana Micro Systems Inc., Andrew Jones <ajones@ventanamicro.com>
>   */
>  #include <libcflat.h>
> +#include <argv.h>
>  #include <bitops.h>
>  #include <config.h>
>  #include <devicetree.h>
> @@ -163,7 +164,8 @@ void halt(int code);
>  void exit(int code)
>  {
>  	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> -	sbi_shutdown(code == 0);
> +
> +	sbi_shutdown(GET_CONFIG_OR_ENV(SBI_EXIT_CODE) ? code == 0 : true);
>  	halt(code);
>  	__builtin_unreachable();
>  }
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

