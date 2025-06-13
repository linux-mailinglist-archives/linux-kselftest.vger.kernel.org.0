Return-Path: <linux-kselftest+bounces-34879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46FAD8546
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EBF3B2583
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8D19DF62;
	Fri, 13 Jun 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="if3J+62J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B3D2DA777;
	Fri, 13 Jun 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802320; cv=none; b=JX2VYV7AwoGindnMHhqBsieTtBfrXelDjwiNURV6jh+NvmUUJ1+3KVE+n57e24hqox5ORQu9ukkfeBcop7QlzGg+59YRv/WLZuQIJkJnrj1jZ+h4wIKUYvtKSOuBz/AwUaEtcRh5vqPgLBmGPQxmPOj2o+WZoBpD7//Y4D34jxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802320; c=relaxed/simple;
	bh=m4XILQdlyhOEuGIrG8GkhmJQpyqVphUns6R2oeWJu9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux6WqrkPPHvp26IPjrQaFQ4NOXfK0tiIsjn9KlZvNeDTIgFgfNwLN/EfZK9EPzDTvT5hkpaiqIBLJIf2viGfWIlx9+rqO+rn8oA/Tsijfq24Hfiw6BivycEgHjsP+sC/S6XqQb/hnfdhZNYYPZED0fodTfXTdZoYvwVecLsZy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=if3J+62J; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=m4XILQdlyhOEuGIrG8GkhmJQpyqVphUns6R2oeWJu9E=; b=if3J+62JkNzeEHqPi1mxH/620g
	qbcmwRd9/sN2gu7fYdEieQ472dRs1NUjlLOrPe+LrNMaNOybKB9RJ5nrnr7JUciLzvr8yWDn5WPhd
	rjx68mKpzXFARN/1pSa0P3Hjh/ruZo3UBs7yEl6mKcKGqmuiQwA+oehZrJYblS8IHty47WnzTfpUQ
	aK6G7NQv89PMHFtnryrKWiKXkm0miAEO4njn+KucKk4gQdMqrpJ2Pgx/b6N0NaugMg1RZpmwXvhR3
	WKMgULs4MBp5Rbde8GCQaNGQJSHdTMEtTXgvNN8I6oW0AsGX1eM4FtI1HAHXX1V39luP1oOz+HxZO
	dQwXzi/g==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzVw-00000002v6a-2GjE;
	Fri, 13 Jun 2025 08:11:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DDD5E30BC59; Fri, 13 Jun 2025 10:11:50 +0200 (CEST)
Date: Fri, 13 Jun 2025 10:11:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
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
Message-ID: <20250613081150.GJ2273038@noisy.programming.kicks-ass.net>
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
 <20250613-deny_trampoline_structs_on_stack-v1-2-5be9211768c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613-deny_trampoline_structs_on_stack-v1-2-5be9211768c3@bootlin.com>

On Fri, Jun 13, 2025 at 09:37:11AM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> When the target function receives more arguments than available
> registers, the additional arguments are passed on stack, and so the
> generated trampoline needs to read those to prepare the bpf context,
> but also to prepare the target function stack when it is in charge of
> calling it. This works well for scalar types, but if the value is a
> struct, we can not know for sure the exact struct location, as it may
> have been packed or manually aligned to a greater value.

https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf

Has fairly clear rules on how arguments are encoded. Broadly speaking
for the kernel, if the structure exceeds 2 registers in size, it is
passed as a reference, otherwise it is passed as two registers.



