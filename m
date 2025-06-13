Return-Path: <linux-kselftest+bounces-34881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE91AD85B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EE316CDD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165E25B667;
	Fri, 13 Jun 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRWi8pCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEE2DA75C;
	Fri, 13 Jun 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803562; cv=none; b=KonmucDLdQrKZp2U89uFrzfKJNacrP8rAQB9oC4HAGc9/XvQog86IsmbDxkw6ZWmMl3H/PigBLBXeFmcujTdizWKOUxMmSPMACvdvS4cegO4OR7jh61WffL46BXUpTtAOxMhW6CCAORNnvx/dKdXGxx7Hq4TQFJW2BONmWhw9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803562; c=relaxed/simple;
	bh=lH/7F/aDPraj67MYN2H8m0zzpepfCQa9N8ZMrQCE/h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKMlGnOi/WzMqGQtUz77oQ9CIJM+rSewIMUqze8XN8G6nTFTmcxOtQdXMpTHUg45OSFwV/UtIePw1Pu5db4KTR6OOGzCPJz0R0hUGBgQlbHZxcX8GdxRk6TMv7HqDWRLLAV+kTSu68saS2kSpIJbcELd8/YAyMYVWhIZhr7geio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZRWi8pCI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ceyQVU1s/TeC1A0uuWSXGNuCFCVzbMABPNZsJKr21a4=; b=ZRWi8pCIRln6gDBwDpL5TpDfHk
	niUGHnvaDU0AKjQp3zTX54Kw4vhPB112ARtEB3A3tsfHGDPm6te2aBSu7kQtFjcx3+kRZgROg+c7W
	kS7pt8ASyk3TCFFxhiEm6kPTIZMPPiU8dnfjrPAPRbBVgSDRNGvQTO0GcSsXKkLM7uvdZc9X4Otcr
	A50grAGUwhRNlVjkB6SSJaMvazcQwGoFc0/VziikYdX2zpo1f5E8Gom7g2W12Se9sFjjSftOPGhfM
	tDyo0kZ13bbnUwgZboISoP0egP9ZHd1TSEPBzLl/kwGBrm/dWyTWo/out4wopH6YyoR9cHDgoastf
	/btuiUCQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzpy-00000002viF-2jCO;
	Fri, 13 Jun 2025 08:32:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94D9E300969; Fri, 13 Jun 2025 10:32:32 +0200 (CEST)
Date: Fri, 13 Jun 2025 10:32:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Menglong Dong <imagedong@tencent.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf 2/7] bpf/x86: prevent trampoline attachment when args
 location on stack is uncertain
Message-ID: <20250613083232.GL2273038@noisy.programming.kicks-ass.net>
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
 <20250613-deny_trampoline_structs_on_stack-v1-2-5be9211768c3@bootlin.com>
 <20250613081150.GJ2273038@noisy.programming.kicks-ass.net>
 <DAL9GRMH74F4.2IV0HN0NGU65X@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DAL9GRMH74F4.2IV0HN0NGU65X@bootlin.com>

On Fri, Jun 13, 2025 at 10:26:37AM +0200, Alexis Lothoré wrote:
> Hi Peter,
> 
> On Fri Jun 13, 2025 at 10:11 AM CEST, Peter Zijlstra wrote:
> > On Fri, Jun 13, 2025 at 09:37:11AM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> >> When the target function receives more arguments than available
> >> registers, the additional arguments are passed on stack, and so the
> >> generated trampoline needs to read those to prepare the bpf context,
> >> but also to prepare the target function stack when it is in charge of
> >> calling it. This works well for scalar types, but if the value is a
> >> struct, we can not know for sure the exact struct location, as it may
> >> have been packed or manually aligned to a greater value.
> >
> > https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf
> >
> > Has fairly clear rules on how arguments are encoded. Broadly speaking
> > for the kernel, if the structure exceeds 2 registers in size, it is
> > passed as a reference, otherwise it is passed as two registers.
> 
> Maybe my commit wording is not precise enough, but indeed, there's not
> doubt about whether the struct value is passed on the stack or through a
> register/a pair of registers. The doubt is rather about the struct location
> when it is passed _by value_ and _on the stack_: the ABI indeed clearly
> states that "Structures and unions assume the alignment of their most
> strictly aligned component" (p.13), but this rule is "silently broken" when
> a struct has an __attribute__((packed)) or and __attribute__((aligned(X))),
> and AFAICT this case can not be detected at runtime with current BTF info.

Ah, okay. So it is a failure of BTF. That was indeed not clear.

