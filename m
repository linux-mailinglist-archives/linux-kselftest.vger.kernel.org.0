Return-Path: <linux-kselftest+bounces-34878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FCAD850C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EEC1709B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F695272807;
	Fri, 13 Jun 2025 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XrBZMe5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97E272814
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801190; cv=none; b=adeU3Zu8UH3Czi/3hxk93/OX/RaCzLlBIMHVXSc3KU6y1YiA080g/3hJErOtQ4HGP4B7pE/hGMrCT+nVY3rkmbQT/g0ldPoFyqvbizS/AkIeb+rClFQZORODVfyuGSEFlvzuG8HRT1fu5fTV8bqD7UmdUAv0P55435d/A7rf0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801190; c=relaxed/simple;
	bh=gTt8WZkD3Fvb2L+2bV5e+Ae8QsKj8V+jq7HRafPSUvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrSE3LJhkT0g07Ac52ngCR+kcItadRf+5ozUUVpeOq+RBKHexjW+JT5w/WLSs5evtOm1Jn798m/7Cwjuh+w+pyXxv5ywTd5uhB1ns5s+EvcCZ4e2hIe0wko4CAuJrZMbnAo9bIAGgowT0r27EdvfGwqKMdrB4xBuKWJh+/XEqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XrBZMe5A; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Jun 2025 09:52:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749801174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiGdYV7bOzsWj9YpYkDeFiIUmyn7YK9R6zHRZS1z8aM=;
	b=XrBZMe5AqJA0MZ4ohbAh1qMK1HaXdjEZVGpyEopRR0yMgenXC3lxBBZNL5tuhk6l70IGh3
	uxAGPho/XPF4vSkHtMDOpJi4/TsxIrEHcNNGwO/04KMVIZ7/hFdJ5aWvqBxDH0VF7WwPPO
	0p5FhwliRxXgGr0QdacfuQXHug0caqE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH 1/2] riscv: Allow SBI_CONSOLE with no uart
 in device tree
Message-ID: <20250613-68a39013932d854741a41c4c@orel>
References: <20250612200747.683635-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612200747.683635-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 12, 2025 at 01:07:47PM -0700, Jesse Taube wrote:
> When CONFIG_SBI_CONSOLE is enabled and there is no uart defined in the
> device tree kvm-unit-tests fails to start.
> 
> Only check if uart exists in device tree if SBI_CONSOLE is false.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  lib/riscv/io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/riscv/io.c b/lib/riscv/io.c
> index fb40adb7..96a3c048 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -104,6 +104,7 @@ static void uart0_init_acpi(void)
>  
>  void io_init(void)
>  {
> +#ifndef CONFIG_SBI_CONSOLE
>  	if (dt_available())
>  		uart0_init_fdt();
>  	else
> @@ -114,6 +115,7 @@ void io_init(void)
>  		       "Found uart at %p, but early base is %p.\n",
>  		       uart0_base, UART_EARLY_BASE);
>  	}
> +#endif

Doesn't this generate uart0_init_fdt/acpi defined but not used types of
warnings? We need to put everything unused under the #ifndef
CONFIG_SBI_CONSOLE, just as uart0_read/write already are. Alternatively,
we can keep everything out of the #ifndef and export
 
void sbi_puts(const char *s);
void uart0_puts(const char *s);

then just have a single use of the #ifdef,

void puts(const char *s)
{
#ifdef CONFIG_SBI_CONSOLE
    sbi_puts(s);
#else
    uart0_puts(s);
#endif
}

I think I like that better since it will ensure all code gets compile
tested all the time and allow an SBI console using unit test to also
access its uart if it has one, just because...

Thanks,
drew


>  }
>  
>  #ifdef CONFIG_SBI_CONSOLE
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

