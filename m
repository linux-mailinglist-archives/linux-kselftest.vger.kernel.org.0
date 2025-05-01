Return-Path: <linux-kselftest+bounces-32096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194F3AA64DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EE73BD187
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA524E4B3;
	Thu,  1 May 2025 20:41:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A8251782;
	Thu,  1 May 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132102; cv=none; b=Q9Fo3wk6Yme36RlzGkaYHGDfj/6dnk01dtd0q2YM5qS/ACWw7KAmDl4Lx+xm6N/NV4JVfie4Xou3ip1g0CvSefWZT64rbTD3zb02V1i40mXDpmg8IRCG1yXvWH1WHZyTjIK0O+839VZvnh7GmZP12EpdXQGMwaxTvfNo1yRR2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132102; c=relaxed/simple;
	bh=BtPow0+KK2lHjTMqWNuY7h5XMiADCfLtIfFthHm7KUU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KpYsuaSLHooEmb3QvMxZi2/Hd8vrQLYm0aoEHBkw8KFtEdC1StZdrw1cv4w6Av1hEqsd7u2M0e+uughzqvuMUG/1dofCwpiCKzW7AiLGM9t8QGr0inbQdKBAwpf1xTH21N2nXLirIKK4joPy8w3I22Xyzeb20FF1UNmNdb3CNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AA78F92009C; Thu,  1 May 2025 22:41:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A33F492009B;
	Thu,  1 May 2025 21:41:31 +0100 (BST)
Date: Thu, 1 May 2025 21:41:31 +0100 (BST)
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
In-Reply-To: <6e2ed6a9-aed0-4727-b1e3-903d3a7751b5@rivosinc.com>
Message-ID: <alpine.DEB.2.21.2505012126250.31828@angie.orcam.me.uk>
References: <20250414123543.1615478-1-cleger@rivosinc.com> <20250414123543.1615478-2-cleger@rivosinc.com> <ba11b910-9959-4845-b3a3-dd9a52466823@ghiti.fr> <2c4f4422-d9c9-4d36-b0ef-f68779b91ee9@rivosinc.com> <20250422094419.GC14170@noisy.programming.kicks-ass.net>
 <6e2ed6a9-aed0-4727-b1e3-903d3a7751b5@rivosinc.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 22 Apr 2025, Clément Léger wrote:

> > x86 mostly does the first, any trap that can happen with IRQs disabled
> > is treated unconditionally as NMI like. The obvious exception is
> > page-fault, but that already has a from-non-preemptible-context branch
> > that is 'careful'.
> > 
> > As to unaligned traps from kernel space, I would imagine they mostly BUG
> > the kernel, except when there's an exception entry for that location, in
> > which case it might do a fixup?
> 
> The misaligned access exception handling currently handles misaligned
> access for the kernel as well (except if explicitly disabled).

 It's currently not clear that a kernel mode unaligned access is indeed a 
bug, as some network protocol stacks may still rely on unaligned accesses 
for performance reasons for the regular case where network headers do come 
out aligned[1][2].

 Hopefully not in the hardirq context though, and the usual approach is to 
keep interrupts disabled in the emulation path if arriving from the kernel 
mode as we don't expect kernel code to be ever paged out (the same applies 
to all kinds of machine instruction emulation).

References:

[1] "TCP SYNs broken in 2.3.41", 
    <https://marc.info/?l=linux-kernel&m=94927689929463>

[2] "Alpha: Emulate unaligned LDx_L/STx_C for data consistency", 
    <https://lore.kernel.org/lkml/87v7rd8h99.fsf@email.froward.int.ebiederm.org/>

 HTH,

  Maciej

