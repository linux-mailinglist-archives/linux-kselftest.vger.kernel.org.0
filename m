Return-Path: <linux-kselftest+bounces-542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21827F710D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D485B20CA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03818636;
	Fri, 24 Nov 2023 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCFKbF3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE811719;
	Fri, 24 Nov 2023 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=X/ymfIJYGS3rgfsyyKZPvatWK1hMRdU56iYMTo6mr84=; b=rCFKbF3mDACBFhTXzRNdFrFO4O
	eoXOKmJ9nZiGJbfFMIBv6nwz3CsjBdIoMhWkUoG1xIESyQX9y7utknNb2crx4yYaVl0TokaNQnX59
	UQEefO9tha/lsxyx4F65ZPyZ5QCqVo0rlZL/kdkYuCLGIjIenfBE0G4ANfmh4TiCyiHjQw5pCSoOw
	9nE6YLG7xrJLF6VvKnJbRf5H0lcpRBYkeFjXyVCwHcJ8GALVBfL/W2eebEDWHFXmQx9wxeHAVLh5J
	AP7Md+iD5Lbnbp5HhKqJfhCerVvC52VYb0wyb/cpFm3UZZNXbX+76free6tqI6J6N/OKWjkdwAGLS
	Lh31sbQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r6TDU-00DqKC-0M;
	Fri, 24 Nov 2023 10:15:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83119300338; Fri, 24 Nov 2023 11:15:19 +0100 (CET)
Date: Fri, 24 Nov 2023 11:15:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Muellner <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <20231124101519.GP3818@noisy.programming.kicks-ass.net>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124072142.2786653-1-christoph.muellner@vrull.eu>

On Fri, Nov 24, 2023 at 08:21:37AM +0100, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> The upcoming RISC-V Ssdtso specification introduces a bit in the senvcfg
> CSR to switch the memory consistency model at run-time from RVWMO to TSO
> (and back). The active consistency model can therefore be switched on a
> per-hart base and managed by the kernel on a per-process/thread base.

You guys, computers are hartless, nobody told ya?

> This patch implements basic Ssdtso support and adds a prctl API on top
> so that user-space processes can switch to a stronger memory consistency
> model (than the kernel was written for) at run-time.
> 
> I am not sure if other architectures support switching the memory
> consistency model at run-time, but designing the prctl API in an
> arch-independent way allows reusing it in the future.

IIRC some Sparc chips could do this, but I don't think anybody ever
exposed this to userspace (or used it much).

IA64 had planned to do this, except they messed it up and did it the
wrong way around (strong first and then relax it later), which lead to
the discovery that all existing software broke (d'uh).

I think ARM64 approached this problem by adding the
load-acquire/store-release instructions and for TSO based code,
translate into those (eg. x86 -> arm64 transpilers).

IIRC Risc-V actually has such instructions as well, so *why* are you
doing this?!?!

