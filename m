Return-Path: <linux-kselftest+bounces-600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF277F87ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 03:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EEFDB20EEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Nov 2023 02:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85881E;
	Sat, 25 Nov 2023 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myTtRdyU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464738A;
	Sat, 25 Nov 2023 02:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA405C433C8;
	Sat, 25 Nov 2023 02:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700880720;
	bh=G7lavvFw0e1K+LDAj1itFIJyfwyENT1UAuWAhJuGE90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myTtRdyUf1//5T3yASQ1Bcrqb9NxZjyGP/ssOpEGFf8wUIFfMgkoJfBmBudup6CWl
	 BPpBfiIDvCk7Ykf0YaxjEaQ2DOQxs8fi94CCnJPkfw+j6V+GcPiLO4zUgcIqdJTDKp
	 9ArWa+niZLE6lXFueH9UTF3KPJK5KLJZ61EZwvtLS1W4E54EeKnUvQusN0viEIeHpb
	 Y30NBQxBJbEFkS8zUI4gTHD5fefcMuHVqlzf37Vgi1sYU0iI5ce0W2ZF/NsE+2VlRD
	 GxM8x710grHq3OQJNjh3RdcNMIvNL5wJrk/8Ghcp/Y6cUmnyPqAZHgWX8EmcNRisAI
	 zvwA5ijkED9yw==
Date: Fri, 24 Nov 2023 21:51:53 -0500
From: Guo Ren <guoren@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <ZWFhSYalMCgTo+SG@gmail.com>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124101519.GP3818@noisy.programming.kicks-ass.net>

On Fri, Nov 24, 2023 at 11:15:19AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> > From: Christoph Müllner <christoph.muellner@vrull.eu>
> > 
> > The upcoming RISC-V Ssdtso specification introduces a bit in the senvcfg
> > CSR to switch the memory consistency model at run-time from RVWMO to TSO
> > (and back). The active consistency model can therefore be switched on a
> > per-hart base and managed by the kernel on a per-process/thread base.
> 
> You guys, computers are hartless, nobody told ya?
> 
> > This patch implements basic Ssdtso support and adds a prctl API on top
> > so that user-space processes can switch to a stronger memory consistency
> > model (than the kernel was written for) at run-time.
> > 
> > I am not sure if other architectures support switching the memory
> > consistency model at run-time, but designing the prctl API in an
> > arch-independent way allows reusing it in the future.
> 
> IIRC some Sparc chips could do this, but I don't think anybody ever
> exposed this to userspace (or used it much).
> 
> IA64 had planned to do this, except they messed it up and did it the
> wrong way around (strong first and then relax it later), which lead to
> the discovery that all existing software broke (d'uh).
> 
> I think ARM64 approached this problem by adding the
> load-acquire/store-release instructions and for TSO based code,
> translate into those (eg. x86 -> arm64 transpilers).
Keeping global TSO order is easier and faster than mixing
acquire/release and regular load/store. That means when ssdtso is
enabled, the transpiler's load-acquire/store-release becomes regular
load/store. Some micro-arch hardwares could speed up the performance.

Of course, you may say powerful machines could smooth out the difference
between ssdtso & load-acquire/store-release, but that's not real life.
Adding ssdtso is a flexible way to gain more choices on the cost of chip
design.

> 
> IIRC Risc-V actually has such instructions as well, so *why* are you
> doing this?!?!
> 

