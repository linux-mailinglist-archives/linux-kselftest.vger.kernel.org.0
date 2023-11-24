Return-Path: <linux-kselftest+bounces-546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33F87F748C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B42BB210DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D8286A2;
	Fri, 24 Nov 2023 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Muf2VTyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0279D71;
	Fri, 24 Nov 2023 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1700831128;
	bh=6Y8qQKiNapfxIiyPU0awITssjjLEv8Lqe9dkOsuewfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Muf2VTywqEgHzegB/nAYDtxju24jHb7b6xljhCIq+59yo1LqKOiMI8hHN6TIOQj/t
	 JOZD4Ol4zOUuz//nId6dzwBldfv9dLBQoc4UI5Dp3ykNfbtRGTdZzdEzf9Y6v0Wg1O
	 0VXZwf9FDnMLX+W/BaGAdfkK1N0pQBZKgeAA33boLATaOM+7T7QOo3aNyvWElDUhN2
	 jmnA8eUVZfkfo9aeoHFOMrzbRMCT4mu+SyCm18IPUmCOPybpxWQ4rJsG6sKGgTwQBt
	 ewBl8pQYuqBGWOSUCH2d7wN8BzI3M2I5i/g2OjApQ8plVpz84DtFeRrbzd0DwlcHVz
	 pa11Xh/2NXhTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ScFZm6CGZz4xNt;
	Sat, 25 Nov 2023 00:05:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>, Jonas Oberhauser
 <jonas.oberhauser@huaweicloud.com>
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Anup Patel
 <apatel@ventanamicro.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Conor Dooley
 <conor.dooley@microchip.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Alan Stern
 <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will
 Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
In-Reply-To: <20231124115430.GS3818@noisy.programming.kicks-ass.net>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
 <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>
 <20231124115430.GS3818@noisy.programming.kicks-ass.net>
Date: Sat, 25 Nov 2023 00:05:16 +1100
Message-ID: <87plzzqp2r.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Nov 24, 2023 at 12:04:09PM +0100, Jonas Oberhauser wrote:
>
>> > I think ARM64 approached this problem by adding the
>> > load-acquire/store-release instructions and for TSO based code,
>> > translate into those (eg. x86 -> arm64 transpilers).
>> 
>> 
>> Although those instructions have a bit more ordering constraints.
>> 
>> I have heard rumors that the apple chips also have a register that can be
>> set at runtime.
>
> Oh, I thought they made do with the load-acquire/store-release thingies.
> But to be fair, I haven't been paying *that* much attention to the apple
> stuff.
>
> I did read about how they fudged some of the x86 flags thing.
>
>> And there are some IBM machines that have a setting, but not sure how it is
>> controlled.
>
> Cute, I'm assuming this is the Power series (s390 already being TSO)? I
> wasn't aware they had this.

Are you referring to Strong Access Ordering? That is a per-page
attribute, not a CPU mode, and was removed in ISA v3.1 anyway.

cheers

