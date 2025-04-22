Return-Path: <linux-kselftest+bounces-31283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBEA964C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6B4189B473
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D71201262;
	Tue, 22 Apr 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5UQ3UXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA33CA64;
	Tue, 22 Apr 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315068; cv=none; b=ToaddV7KsndIg84IEZtQXSVKUNogYbiyENY7dF0r7l172dC9Lzd3dAZYpr9/iMZINmLfBTG22EQEzKXA6oqzgWJC6kEGpTo/9/ENBGCy2b6Jw6Axzy7xv0Y7S+V2xZ5NFPGyuUzNf2g2TKHjt/mvQL3gwjxyXGBQezMiVy5gg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315068; c=relaxed/simple;
	bh=oE5GrOEZEQBZhOL5FiYD1yV7nLx+NTx0xzcMqnXHZ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad+9fu1czOzYyRHkxS0l2JBmkGAghKLU29rcCg1RCuW5NNVzFODlmiQ38YkiEAKhN03SAgWOt+UnpEQLripzaK9J/ntjFeQpFIxsYI0dK24W9fiilnV0ZKul4BVf3Iy1u8NeIvULwE3cX8mYaYc3E6tb0tSw0qaeeOvs+mgbT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T5UQ3UXL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mGbqpudR0f2iSYHQuMr6RO+VDWZ/K/atXWkQYmqqhDA=; b=T5UQ3UXLQpNmK7rF6aWvOm0hqj
	L/2+7nQcxtJqOXFVasHCfAEvHz7YhOnWbtmvIRsdJ4Upjhxk4hAwr7LcCTUkdY64AH3Rv0laU6kQH
	uWFPiWaF9/BDGJAbWVoSd1p3hzatqnKcIRNCSStg/oeRoHYpDqnLJ+6pcKC9e7Tk9pb+Rpih3XJ/o
	PDQz/8vzf0yCCaC+0XZPG7frxwN5i7npXUwpMeReUh1NYfax/PV4asf0du/xOgivmIkObzpWX5C8z
	rswplBGTlhRZbDWnfCZAqu3DeI2IUcTGk6Ty/EFnlgTU9qLMYxNkdJEf3JNlps+Jcn4DSplBMY5eE
	I6dKzO0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7AAt-00000004KFU-41jO;
	Tue, 22 Apr 2025 09:44:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6AE3D3003C4; Tue, 22 Apr 2025 11:44:19 +0200 (CEST)
Date: Tue, 22 Apr 2025 11:44:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 1/5] riscv: misaligned: factorize trap handling
Message-ID: <20250422094419.GC14170@noisy.programming.kicks-ass.net>
References: <20250414123543.1615478-1-cleger@rivosinc.com>
 <20250414123543.1615478-2-cleger@rivosinc.com>
 <ba11b910-9959-4845-b3a3-dd9a52466823@ghiti.fr>
 <2c4f4422-d9c9-4d36-b0ef-f68779b91ee9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c4f4422-d9c9-4d36-b0ef-f68779b91ee9@rivosinc.com>

On Tue, Apr 22, 2025 at 09:57:12AM +0200, Clément Léger wrote:
> 
> 
> On 21/04/2025 09:06, Alexandre Ghiti wrote:
> > Hi Clément,
> > 
> > 
> > On 14/04/2025 14:34, Clément Léger wrote:
> >> misaligned accesses traps are not nmi and should be treated as normal
> >> one using irqentry_enter()/exit().
> > 
> > 
> > All the traps that come from kernel mode are treated as nmi as it was
> > suggested by Peter here: https://lore.kernel.org/linux-riscv/
> > Yyhv4UUXuSfvMOw+@hirez.programming.kicks-ass.net/
> > 
> > I don't know the differences between irq_nmi_entry/exit() and irq_entry/
> > exit(), so is that still correct to now treat the kernel traps as non-nmi?
> 
> Hi Alex,
> 
> Actually, this discussion was raised on a previous series [1] by Maciej
> which replied that we should actually reenable interrupt depending on
> the state that was interrupted. Looking at other architecture/code, it
> seems like treating misaligned accesses as NMI is probably not the right
> way. For instance, loongarch treats them as normal IRQ using a
> irqentry_enter()/exit() and reenabling IRQS if possible.

So, a trap that happens in kernel space while IRQs are disabled, SHOULD
really be NMI-like.

You then have a choice, make all such traps from kernel space NMI-like;
this makes it easy on the trap handler, since the context is always the
same. Mistakes are 'easy' to find.

Or,.. do funny stuff and only make it NMI like if IRQs were disabled.
Which gives inconsistent context for the handler and you'll find
yourself scratching your head at some point in the future wondering why
this one rare occasion goes BOOM.

x86 mostly does the first, any trap that can happen with IRQs disabled
is treated unconditionally as NMI like. The obvious exception is
page-fault, but that already has a from-non-preemptible-context branch
that is 'careful'.

As to unaligned traps from kernel space, I would imagine they mostly BUG
the kernel, except when there's an exception entry for that location, in
which case it might do a fixup?


Anyway, the reason these exceptions should be NMI like, is because
interrupts are not allowed to nest. Notably something like:


  raw_spin_lock_irqsave(&foo);
  <IRQ>
    raw_spin_lock_irqsave(&foo);
    ...

Is an obvious problem. Exceptions that can run while IRQs are disabled,
must not use locks -- treating them as NMI-like (they are non-maskable
after all), ensures this.

