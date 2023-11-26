Return-Path: <linux-kselftest+bounces-616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B787F9297
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0726B20C8A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C81113;
	Sun, 26 Nov 2023 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovWSeHXB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F9A52;
	Sun, 26 Nov 2023 12:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B280C433C8;
	Sun, 26 Nov 2023 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701002082;
	bh=M5JWFk6PhkRfznjeZqDoIn4AkQrs7NTEUWLaLy4lG2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovWSeHXBh0A2MZJQ/EfKKAo8vihoDaRc/mmDRXRdZQ1cymyR0CZgi2+igVHtCrM2T
	 zqqSG8YZAp82QWv2sbNPyhWyFUsKHKpYsHcDv/yL1TwhHNn80ikMyGbRxW/AsJ3/d5
	 Vm6XKs9LhdGkTTqWQJnmEsmkJumf6kcCT2bhDu1akObRN0JiM0Ceexv5U37GwnqANA
	 Dpr5xqPzxoq4wDmqbalgFplpTcuwjlLc39CQ06Tn6GYOZBUu3KNL+K+8FmVBN1Ku59
	 sVaVZoylBh8Q0y0qCxpzCZWRTkPcPKHQs483GcS1P5Q80sSQGesUi/xPMhvNqxbSFN
	 PzW9WCdyeh7rg==
Date: Sun, 26 Nov 2023 07:34:30 -0500
From: Guo Ren <guoren@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Christoph Muellner <christoph.muellner@vrull.eu>,
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
Message-ID: <ZWM7VvHNkW2iIRCg@gmail.com>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
 <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>
 <20231124115430.GS3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124115430.GS3818@noisy.programming.kicks-ass.net>

On Fri, Nov 24, 2023 at 12:54:30PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 24, 2023 at 12:04:09PM +0100, Jonas Oberhauser wrote:
> 
> > > I think ARM64 approached this problem by adding the
> > > load-acquire/store-release instructions and for TSO based code,
> > > translate into those (eg. x86 -> arm64 transpilers).
> > 
> > 
> > Although those instructions have a bit more ordering constraints.
> > 
> > I have heard rumors that the apple chips also have a register that can be
> > set at runtime.
I could understand the rumor, smart design! Thx for sharing.

> 
> Oh, I thought they made do with the load-acquire/store-release thingies.
> But to be fair, I haven't been paying *that* much attention to the apple
> stuff.
> 
> I did read about how they fudged some of the x86 flags thing.
> 
> > And there are some IBM machines that have a setting, but not sure how it is
> > controlled.
> 
> Cute, I'm assuming this is the Power series (s390 already being TSO)? I
> wasn't aware they had this.
> 
> > > IIRC Risc-V actually has such instructions as well, so *why* are you
> > > doing this?!?!
> > 
> > 
> > Unfortunately, at least last time I checked RISC-V still hadn't gotten such
> > instructions.
> > What they have is the *semantics* of the instructions, but no actual opcodes
> > to encode them.
> 
> Well, that sucks..
> 
> > I argued for them in the RISC-V memory group, but it was considered to be
> > outside the scope of that group.
> > 
> > Transpiling with sufficient DMB ISH to get the desired ordering is really
> > bad for performance.
> 
> Ha!, quite dreadful I would imagine.
> 
> > That is not to say that linux should support this. Perhaps linux should
> > pressure RISC-V into supporting implicit barriers instead.
> 
> I'm not sure I count for much in this regard, but yeah, that sounds like
> a plan :-)
> 

