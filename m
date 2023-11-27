Return-Path: <linux-kselftest+bounces-643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 896427F9F4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 13:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD4BB20AAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26F1CA9D;
	Mon, 27 Nov 2023 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64F20F5;
	Mon, 27 Nov 2023 04:14:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70492F4;
	Mon, 27 Nov 2023 04:15:07 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59403F73F;
	Mon, 27 Nov 2023 04:14:16 -0800 (PST)
Date: Mon, 27 Nov 2023 12:14:13 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?us-ascii?Q?Bj=22orn_T=22opel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
Message-ID: <ZWSIFV9JGc-Mysvh@FVFF77S0Q05N>
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
> > > I think ARM64 approached this problem by adding the
> > > load-acquire/store-release instructions and for TSO based code,
> > > translate into those (eg. x86 -> arm64 transpilers).
> > 
> > Although those instructions have a bit more ordering constraints.
> > 
> > I have heard rumors that the apple chips also have a register that can be
> > set at runtime.
> 
> Oh, I thought they made do with the load-acquire/store-release thingies.
> But to be fair, I haven't been paying *that* much attention to the apple
> stuff.
> 
> I did read about how they fudged some of the x86 flags thing.

I don't know what others may have built specifically, but architecturally on
arm64 we expect people to express ordering requirements through instructions.
ARMv8.0 has load-acquire and store-release, ARMv8.3 added RCpc forms of
load-acquire as part of FEAT_LRCPC, and ARMv8.4 added a number of instructions
as part of FEAT_LRCPC2.

For a number of reasons we avoid IMPLEMENTATION DEFINED controls for things
like this.

Thanks
Mark.

