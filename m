Return-Path: <linux-kselftest+bounces-642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87F7F9E5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC55281356
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD818E32;
	Mon, 27 Nov 2023 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ATqUzkBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515AB136;
	Mon, 27 Nov 2023 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cAMYRwVtTk4t4CFVybTFSaosFfl7UAZUdZLXZwoFExo=; b=ATqUzkBAXvyJcu5VDkL3MVJVfz
	M/w2F2dpijW6LxyJLlqXBnQ0lCixTGvRKNlSoSiX09wPSklZT/HtWrEsqMUIdkq93s+4dAO9uWxTV
	zMJVEfgI4+fLLB/BspixOggT0/648mr9X8rGlX6pT0ysMRuueX9ZH2SJCHA6yABLLJ3WdeVUQ9nkx
	7hkUh0jav76aCSftSKzOTTuPr4TusyFps7ll+zKj+RPzbY6WUbwHRxY8UE9/5HR6OBjEBqv0sRGhO
	1hHs7A0mYGz4bDCYmyPGoVMW2Gwqq/97kzONjxkB6w/6NX7lo3vhxYcv3rFdjOgVRN8vrcTve873R
	d3HFyzHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7ZbZ-00G258-25;
	Mon, 27 Nov 2023 11:16:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 17B3A3002F1; Mon, 27 Nov 2023 12:16:44 +0100 (CET)
Date: Mon, 27 Nov 2023 12:16:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Guo Ren <guoren@kernel.org>
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
Message-ID: <20231127111643.GV3818@noisy.programming.kicks-ass.net>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
 <ZWFhSYalMCgTo+SG@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWFhSYalMCgTo+SG@gmail.com>

On Fri, Nov 24, 2023 at 09:51:53PM -0500, Guo Ren wrote:
> On Fri, Nov 24, 2023 at 11:15:19AM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> > > From: Christoph Müllner <christoph.muellner@vrull.eu>
> > > 
> > > The upcoming RISC-V Ssdtso specification introduces a bit in the senvcfg
> > > CSR to switch the memory consistency model at run-time from RVWMO to TSO
> > > (and back). The active consistency model can therefore be switched on a
> > > per-hart base and managed by the kernel on a per-process/thread base.
> > 
> > You guys, computers are hartless, nobody told ya?
> > 
> > > This patch implements basic Ssdtso support and adds a prctl API on top
> > > so that user-space processes can switch to a stronger memory consistency
> > > model (than the kernel was written for) at run-time.
> > > 
> > > I am not sure if other architectures support switching the memory
> > > consistency model at run-time, but designing the prctl API in an
> > > arch-independent way allows reusing it in the future.
> > 
> > IIRC some Sparc chips could do this, but I don't think anybody ever
> > exposed this to userspace (or used it much).
> > 
> > IA64 had planned to do this, except they messed it up and did it the
> > wrong way around (strong first and then relax it later), which lead to
> > the discovery that all existing software broke (d'uh).
> > 
> > I think ARM64 approached this problem by adding the
> > load-acquire/store-release instructions and for TSO based code,
> > translate into those (eg. x86 -> arm64 transpilers).

> Keeping global TSO order is easier and faster than mixing
> acquire/release and regular load/store. That means when ssdtso is
> enabled, the transpiler's load-acquire/store-release becomes regular
> load/store. Some micro-arch hardwares could speed up the performance.

Why is it faster? Because the release+acquire thing becomes RcSC instead
of RcTSO? Surely that can be fixed with a weaker store-release variant
ot something?

The problem I have with all of this is that you need to context switch
this state and that you need to deal with exceptions, which must be
written for the weak model but then end up running in the tso model --
possibly slower than desired.

If OTOH you only have a single model, everything becomes so much
simpler. You just need to be able to express exactly what you want.



