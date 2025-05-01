Return-Path: <linux-kselftest+bounces-32097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1AAA64E9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84531B65131
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 20:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37556225A5B;
	Thu,  1 May 2025 20:51:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BAC7083A;
	Thu,  1 May 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132719; cv=none; b=ntymFY6vCRryI46k6H9YfZFY7FYg5VdALS5B1uZyjK5vJC5BN980aZBGHRU2Wld3yztTeE0+kyUh9MrPBCjWe9kfuSgJx3g6fqYuxo7bjH8UPgdum9JmDDlk4DP5nImwdbmi4rkfWyWJy/A8WkdlEfEmDjrg8+pd//lA7aSGYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132719; c=relaxed/simple;
	bh=+NGialMhqR+6yV7Gdw6igTYq2XkmffzRHD69x5BSCaM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hBQdO77zgyMq00XiLYzZnv3pbAa7gCaiZ8q/E+6J1pDs7itdzD3v4fncRkVdp2pWMCBNlcOUKMPTaxcBdNVoojlpNAD4lwv8GLxpBlY2DZtPYCaCYM+UpRTCe5n7+wzPfxJCDvvj+F+/2xfTtCtZ0rIoRhQ6ECZb1LPXUg7G+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CDA2E92009C; Thu,  1 May 2025 22:51:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C110F92009B;
	Thu,  1 May 2025 21:51:54 +0100 (BST)
Date: Thu, 1 May 2025 21:51:54 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
cc: Peter Zijlstra <peterz@infradead.org>, Alexandre Ghiti <alex@ghiti.fr>, 
    "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, 
    "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Shuah Khan <shuah@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
    Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 1/5] riscv: misaligned: factorize trap handling
In-Reply-To: <alpine.DEB.2.21.2505012126250.31828@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2505012150460.31828@angie.orcam.me.uk>
References: <20250414123543.1615478-1-cleger@rivosinc.com> <20250414123543.1615478-2-cleger@rivosinc.com> <ba11b910-9959-4845-b3a3-dd9a52466823@ghiti.fr> <2c4f4422-d9c9-4d36-b0ef-f68779b91ee9@rivosinc.com> <20250422094419.GC14170@noisy.programming.kicks-ass.net>
 <6e2ed6a9-aed0-4727-b1e3-903d3a7751b5@rivosinc.com> <alpine.DEB.2.21.2505012126250.31828@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 May 2025, Maciej W. Rozycki wrote:

>  Hopefully not in the hardirq context though, and the usual approach is to 
> keep interrupts disabled in the emulation path if arriving from the kernel 
> mode as we don't expect kernel code to be ever paged out (the same applies 
> to all kinds of machine instruction emulation).

 s/code/data/, obviously.

  Maciej

