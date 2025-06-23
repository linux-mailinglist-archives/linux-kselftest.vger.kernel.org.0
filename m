Return-Path: <linux-kselftest+bounces-35633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFAAE4B89
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4933A4303
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3A24DCE8;
	Mon, 23 Jun 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PP5hhr3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127821B4242
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698084; cv=none; b=U4UyqCbKabu4C5qFAQElw/hQRR2bKZ9thWKR3wXhwuxUbOK3iVcIhWI7N3jqAIqOwn0zE7X9z48dsZdFY8/gxRhPBb1dT0FLOA245UqMGg/8P4n1qBm7J4qUtL4h7TedJbJ6rMDTrMirBN+t3yUCJAXpmM7845uQiWZUZA9MMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698084; c=relaxed/simple;
	bh=rVjZlLZQ279KxL8vUzwjbUdQ9GXdGuGGWoZ+ZFn26Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt5Rs3i1tz3jNT0L0MMMPFZ/gcLqMJBmiKArL6KHvRC/5WbghjjaIpZkviaxEifn7dCF/TZucbK3o17vt0u+zRsnz+oYBw7ACj0Sx76pi3UdRgCQ19na5kqf6yup4RHaOU0xB1M4ahQ6Kn0fGIxve7Sa/NErLj7fKRYIuhRjP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PP5hhr3w; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Jun 2025 19:01:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750698069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTE7I/KO8H35amQtJL/anmk4SKSD+jA1F2S0AsyESUo=;
	b=PP5hhr3wB6JmmQ6qEiog3eYoJv/oEWsi8ERj4nQhYPItLzopEtHk7ouTbsJOIe9xoYVLZH
	sUDUwU4xmxtfmziuV2KTrmCmf/EuxwER3jwPvNrtudOmXW7kBzwzRnAzfQxerGmjGy2ajg
	ixxQ8F1gc5Sl7TmBKqK6jlSPCflOLSk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH] riscv: lib: sbi_shutdown add exit code.
Message-ID: <20250623-c4c3115e6402176024bac6ea@orel>
References: <20250620155051.68377-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620155051.68377-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 20, 2025 at 08:50:51AM -0700, Jesse Taube wrote:
> When exiting it may be useful for the sbi implementation to know the
> exit code.
> Add exit code to sbi_shutdown, and use it in exit().
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  lib/riscv/asm/sbi.h | 2 +-
>  lib/riscv/io.c      | 2 +-
>  lib/riscv/sbi.c     | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
> index a5738a5c..de11c109 100644
> --- a/lib/riscv/asm/sbi.h
> +++ b/lib/riscv/asm/sbi.h
> @@ -250,7 +250,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg3, unsigned long arg4,
>  			unsigned long arg5);
>  
> -void sbi_shutdown(void);
> +void sbi_shutdown(unsigned int code);
>  struct sbiret sbi_hart_start(unsigned long hartid, unsigned long entry, unsigned long sp);
>  struct sbiret sbi_hart_stop(void);
>  struct sbiret sbi_hart_get_status(unsigned long hartid);
> diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> index fb40adb7..02231268 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -150,7 +150,7 @@ void halt(int code);
>  void exit(int code)
>  {
>  	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> -	sbi_shutdown();
> +	sbi_shutdown(code & 1);
>  	halt(code);
>  	__builtin_unreachable();
>  }
> diff --git a/lib/riscv/sbi.c b/lib/riscv/sbi.c
> index 2959378f..9dd11e9d 100644
> --- a/lib/riscv/sbi.c
> +++ b/lib/riscv/sbi.c
> @@ -107,9 +107,9 @@ struct sbiret sbi_sse_inject(unsigned long event_id, unsigned long hart_id)
>  	return sbi_ecall(SBI_EXT_SSE, SBI_EXT_SSE_INJECT, event_id, hart_id, 0, 0, 0, 0);
>  }
>  
> -void sbi_shutdown(void)
> +void sbi_shutdown(unsigned int code)
>  {
> -	sbi_ecall(SBI_EXT_SRST, 0, 0, 0, 0, 0, 0, 0);
> +	sbi_ecall(SBI_EXT_SRST, 0, 0, code, 0, 0, 0, 0);

We can't do this because a kvm-unit-tests exit code is not an
SRST::reset_reason[1]. This could result in the SBI implementation
returning an error, or doing something else, rather than shutting
down.

If this is a custom kvm-unit-tests-specific SBI implementation, then
we could pass in a reset_reason in the 0xE0000000 - 0xEFFFFFFF range.

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-sys-reset.adoc#table_srst_system_reset_reasons

Thanks,
drew
 

>  	puts("SBI shutdown failed!\n");
>  }
>  
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

