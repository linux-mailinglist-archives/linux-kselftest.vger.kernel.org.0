Return-Path: <linux-kselftest+bounces-545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72077F7321
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 12:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C38D1F2061E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA23C200A6;
	Fri, 24 Nov 2023 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gqm+SH2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548E10E0;
	Fri, 24 Nov 2023 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7/9ELPCZSyNtTedfYVN0RIERqDSGzyj/VTh+0OOKOJ4=; b=Gqm+SH2WxYC3SW6jehiqHEIGvx
	onKuc1sq6cP7JYqCQV6I+k3G+jf98LkqC9B3LwKbgLMdVmBHLwLlEv/AGXM2juldAAUNh+/+Ifia3
	fjZe0lqpVvdtm+F+QoWzePxPpF+WHQnoTB305XXBJyQLbB9dNgFiunMC7PtaqJynhX7bXUDVkgybK
	tp029/O+KPQ1PiTV/JUSbhwK1ia7A/XvEG/q632FVmhOyfHIxoYpyiGh/MB2MIEGw6+6eWQwVBJNa
	E5CYY1M/QHrPtjv7Cu6Upz2QHzs/SFLveqZO6rIX148LBb/akZPQ+ZK7VhyuNsfhS6tn6s4CJEN27
	WO4O9WCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r6UlU-00DsrU-3A;
	Fri, 24 Nov 2023 11:54:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 86BF03002BE; Fri, 24 Nov 2023 12:54:30 +0100 (CET)
Date: Fri, 24 Nov 2023 12:54:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
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
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <20231124115430.GS3818@noisy.programming.kicks-ass.net>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
 <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>

On Fri, Nov 24, 2023 at 12:04:09PM +0100, Jonas Oberhauser wrote:

> > I think ARM64 approached this problem by adding the
> > load-acquire/store-release instructions and for TSO based code,
> > translate into those (eg. x86 -> arm64 transpilers).
> 
> 
> Although those instructions have a bit more ordering constraints.
> 
> I have heard rumors that the apple chips also have a register that can be
> set at runtime.

Oh, I thought they made do with the load-acquire/store-release thingies.
But to be fair, I haven't been paying *that* much attention to the apple
stuff.

I did read about how they fudged some of the x86 flags thing.

> And there are some IBM machines that have a setting, but not sure how it is
> controlled.

Cute, I'm assuming this is the Power series (s390 already being TSO)? I
wasn't aware they had this.

> > IIRC Risc-V actually has such instructions as well, so *why* are you
> > doing this?!?!
> 
> 
> Unfortunately, at least last time I checked RISC-V still hadn't gotten such
> instructions.
> What they have is the *semantics* of the instructions, but no actual opcodes
> to encode them.

Well, that sucks..

> I argued for them in the RISC-V memory group, but it was considered to be
> outside the scope of that group.
> 
> Transpiling with sufficient DMB ISH to get the desired ordering is really
> bad for performance.

Ha!, quite dreadful I would imagine.

> That is not to say that linux should support this. Perhaps linux should
> pressure RISC-V into supporting implicit barriers instead.

I'm not sure I count for much in this regard, but yeah, that sounds like
a plan :-)

