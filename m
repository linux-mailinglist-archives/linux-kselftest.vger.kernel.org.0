Return-Path: <linux-kselftest+bounces-34416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0DACFE5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C887E3A1C46
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6E1BF33F;
	Fri,  6 Jun 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NjqVhN+d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005413B2A4
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198752; cv=none; b=Z/Bc1lgXqSQHZ/h4FuEb7zrit0EM5iUz7DhJWH/pt/pUbn+1CukVBVZgsmJTDqhAohTniHc1BvjhDbpuiYSh4AkM/g5QSK1HfwCxwhUcK0ozsBPhdH3LpilklybtTh7rBk5j3yWE+q3pY8Nm7hv0vjbqFvou32GrDru4h/6wX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198752; c=relaxed/simple;
	bh=sGVTNIGiiw0Q76mM1YYrcKY/BTZdy/REejIJnpFL6qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb4LSODA6lMm0Iei5XcQ8Y3OITOMImFNjQBZhsWm0guGU9bHvbxAqsAYk0nt2e9zicsKxBf+xXh/6zMJDqLjpozWi/sleQDlxAXfSLl5uvn4bqh5pDh3nQ5lBaql3aNE+UNYP2YD7Rlqlap5plQDjyZ2AiBk1d5z4gGeNvYb0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NjqVhN+d; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Jun 2025 10:32:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749198746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rjnQ5h06Wz4/Zf1hGvZjWlBwp2Qnw/DkUpb5h4A7oE=;
	b=NjqVhN+dZVzSxuBLk3run4PObbEVNl1Iw0rPv+HzYy9qcJ5Pjc/MNaf13ZNPI4zlS+8LPp
	ZMJOXfMZdaD4H7McYYSNoXMSzf9Lqf0EpF5xgqsElSgtogzW10NORVlbeFe/HA7Cs6yStN
	z+M4H84O26vYwfLlQDxe6GDB1sCdfpY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH v3 1/2] riscv: Add RV_INSN_LEN to
 processor.h
Message-ID: <20250606-cbdb324240e2de802f08d32c@orel>
References: <20250605161806.1206850-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605161806.1206850-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 05, 2025 at 09:18:05AM -0700, Jesse Taube wrote:
> When handeling traps and faults it is offten necessary to know the size

handling

often

> of the instruction at epc. Add RV_INSN_LEN to calculate the
> instruction size.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  lib/riscv/asm/processor.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/riscv/asm/processor.h b/lib/riscv/asm/processor.h
> index 40104272..631ce226 100644
> --- a/lib/riscv/asm/processor.h
> +++ b/lib/riscv/asm/processor.h
> @@ -7,6 +7,8 @@
>  #define EXCEPTION_CAUSE_MAX	24
>  #define INTERRUPT_CAUSE_MAX	16
>  
> +#define RV_INSN_LEN(insn)		((((insn) & 0x3) < 0x3) ? 2 : 4)
> +
>  typedef void (*exception_fn)(struct pt_regs *);
>  
>  struct thread_info {
> -- 
> 2.43.0
>

I've fixed the two typos while applying to riscv/sbi[1]

[1] https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/sbi

Thanks,
drew

> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

