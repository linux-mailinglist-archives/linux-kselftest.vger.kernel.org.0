Return-Path: <linux-kselftest+bounces-35733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953AAE7A58
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3255C1705BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E421B1B9;
	Wed, 25 Jun 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H0nVjQMO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46720C46D
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840391; cv=none; b=EBBd255bVGWRIx89y3qDamw4+jG3OlLoNsQ5hZkqousHJPx8oEWszCV1r1YI7rqef1Qc0VR/fxzYxihT4UhSAQIlFOvEIAEzMX8DqfplERL0ZDLM/fYT1vtHqqhX12rAM9SUB2N21Gb0lc2UzZcLLfgpb6gc5sNxU9WW4/FmIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840391; c=relaxed/simple;
	bh=7HyHTivDjUk5L/aMX6QjOKJ0k+am7AT9bX7/LBE5A0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZUjEj+MCZ6NwAm90LQVqOnYJ3ya/2Q6rK9ym7MXt3zNJkdbt+S20yr5icAzYkq5IXtRTi/RaTfWvarMUDFUXjW1zJ34F2Ujbot8Z7EtQGW/8Qve6dTAGz7TSTjFJiJNb6biu8wlvhLWKsuJBTPMfaroZcumkX3+FWcWMRZy/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H0nVjQMO; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Jun 2025 10:33:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750840386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RdDpK0Q/BrscCsHE2b67l2XshKAMI4QDH//eQ76vYQ=;
	b=H0nVjQMOiY4+H4PxAmGP2EbqofC0puApMp7X2a9Zc6REb298iwGRlvJJPjAgLypCPTWsNp
	7f7QvRn072mqsSsfxCtCtbFY7L0BXhf5bJByuEGW2xchIdFou7NKdBDNHgPFG30/Em4iCN
	BpYP7Dq1na3uBlU/rHsPuz/ti47HgSw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, James Raphael Tiovalen <jamestiotio@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Cade Richard <cade.richard@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2] riscv: lib: sbi_shutdown add pass/fail
 exit code.
Message-ID: <20250625-fc81fec2cf6d7ee195c0eb6c@orel>
References: <20250624192317.278437-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624192317.278437-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 24, 2025 at 12:23:17PM -0700, Jesse Taube wrote:
> When exiting it may be useful for the sbi implementation to know if
> kvm-unit-tests passed or failed.
> Add exit code to sbi_shutdown, and use it in exit() to pass
> success/failure (0/1) to sbi.
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
> index fb40adb7..0bde25d4 100644
> --- a/lib/riscv/io.c
> +++ b/lib/riscv/io.c
> @@ -150,7 +150,7 @@ void halt(int code);
>  void exit(int code)
>  {
>  	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> -	sbi_shutdown();
> +	sbi_shutdown(!!code);
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
>  	puts("SBI shutdown failed!\n");
>  }
>  
> -- 
> 2.43.0
>

I enhanced the commit message, changed the parameter to a boolean, and
applied to riscv/sbi

https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/sbi

but I'm having some second thoughts on it. It looks like opensbi and the
two KVM VMMs I looked at (QEMU and kvmtool) all currently ignore this
parameter and we don't know what they might choose to do if they stop
ignoring it. For example, they could choose to hang, rather than complete
the shutdown when they see a "system failure" reason. It may make sense
to indicate system failure if the test aborts, since, in those cases,
something unexpected with the testing occurred. However, successfully
running tests which find and report failures isn't unexpected, so it
shouldn't raise an alarm to the SBI implementation in those cases.

Do you already have a usecase for this in mind? If so, we could make
the behavior optional to enable that use case and use cases like it
but we'd keep that behavior off by default to avoid problems with SBI
implementations that do things with the "system failure" information we'd
rather they not do.

Thanks,
drew

