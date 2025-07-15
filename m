Return-Path: <linux-kselftest+bounces-37361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18546B06179
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE791C46A69
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895F2517B9;
	Tue, 15 Jul 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUjtLAfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075CC23A9AC;
	Tue, 15 Jul 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589890; cv=none; b=ARMxt5bcYP7STRfsrGtxMBmrL2uHQjBXrYFTAvjOao385gSCfQ1o+V6jnHhc85b5mNYHp+ClgLo14ZvHEWfcHSM0cF+pLOj90WLGcwj1U1nKgCxNV28+fS0R1sJ9dvfJIDlU57UB/J0XjvIP4fTdfH+5Kk297woXrLNUCoNbtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589890; c=relaxed/simple;
	bh=o6fjSBuD3MkNah5lZdAX/PPlNa0a+5q/uZrvW1HtmUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFLTe7OppPOvmAzpi+jtP7H7ggg+rl2rFPb9W85HeQpSlKUFEoIKVAqJ0nFkRTfss7YVophLJdQEWgTVTmDfDU6OAI65AKqvBMKSSHOL7zgMgcZS8IB3HbqGX4G1HI3SZl9iTwsvSMNigmHYOw4bKvwIiWivIk1bWjwqgEY3N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUjtLAfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441E9C4CEF4;
	Tue, 15 Jul 2025 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589889;
	bh=o6fjSBuD3MkNah5lZdAX/PPlNa0a+5q/uZrvW1HtmUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUjtLAfe1YB4nzGaZVRSAmE0eRFV3Syh4ljvj87kbr+p66u6CnYRfcPBASM86tVFS
	 TfYVKeaSem01kTkoz03ibb6YGUbuaW4r+Xd7I3+Ial+CDNR3M3zjABD+gWDvDA8l55
	 7ESr1Sh4LfDxsU28e44GLHdrasU/ji+nKgV7K3dElUl7C5FKEcl1L3bIaXxjk1hJCQ
	 A9HdbABolc7poqU6y6EWBEZjsM+4ommaMLdlEXsbMSbMPs0FII+sCvJRM8KcGp3EqB
	 e5zaJbL31SrR1HrqIaznwXJdFwLj+iogDb+gCZk06X04bMeGl9krLaYKmoPU+b8203
	 DdFMyPKH78kmQ==
Date: Tue, 15 Jul 2025 15:31:21 +0100
From: Will Deacon <will@kernel.org>
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
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf, arm64: remove structs on stack constraint
Message-ID: <aHZmOVpcoyTvGY1u@willie-the-truck>
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
 <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>
 <aHZYcY_9JtK8so3C@willie-the-truck>
 <DBCONB7XHN7E.2UQMMG6RICMFY@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBCONB7XHN7E.2UQMMG6RICMFY@bootlin.com>

On Tue, Jul 15, 2025 at 04:02:25PM +0200, Alexis Lothoré wrote:
> On Tue Jul 15, 2025 at 3:32 PM CEST, Will Deacon wrote:
> > On Wed, Jul 09, 2025 at 10:36:55AM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> >> While introducing support for 9+ arguments for tracing programs on
> >> ARM64, commit 9014cf56f13d ("bpf, arm64: Support up to 12 function
> >> arguments") has also introduced a constraint preventing BPF trampolines
> >> from being generated if the target function consumes a struct argument
> >> passed on stack, because of uncertainties around the exact struct
> >> location: if the struct has been marked as packed or with a custom
> >> alignment, this info is not reflected in BTF data, and so generated
> >> tracing trampolines could read the target function arguments at wrong
> >> offsets.
> >> 
> >> This issue is not specific to ARM64: there has been an attempt (see [1])
> >> to bring the same constraint to other architectures JIT compilers. But
> >> discussions following this attempt led to the move of this constraint
> >> out of the kernel (see [2]): instead of preventing the kernel from
> >> generating trampolines for those functions consuming structs on stack,
> >> it is simpler to just make sure that those functions with uncertain
> >> struct arguments location are not encoded in BTF information, and so
> >> that one can not even attempt to attach a tracing program to such
> >> function. The task is then deferred to pahole (see [3]).
> >> 
> >> Now that the constraint is handled by pahole, remove it from the arm64
> >> JIT compiler to keep it simple.
> >> 
> >> [1] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com/
> >> [2] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com/
> >> [3] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com/
> >> 
> >> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> >> ---
> >>  arch/arm64/net/bpf_jit_comp.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >
> > This is a question born more out of ignorance that insight, but how do
> > we ensure that the version of pahole being used is sufficiently
> > up-to-date that the in-kernel check is not required?
> 
> Based on earlier discussions, I am not convinced it is worth maintaining
> the check depending on the pahole version used in BTF. Other architectures
> exposing a JIT compiler don't have the in-kernel check and so are already
> exposed to this very specific case, but discussions around my attempt to
> enforce the check on other JIT comp showed that the rarity of this case do
> not justify protecting it on kernel side (see [1]).

I can understand why doing this in pahole rather than in each individual
JIT is preferable, but I don't think there's any harm leaving the
existing two line check in arm64 as long as older versions of pahole
might be used, is there? I wouldn't say that removing it really
simplifies the JIT compiler when you consider the rest of the
implementation.

Of course, once the kernel requires a version of pahole recent enough
to contain [3], we should drop the check in the JIT compiler as the
one in pahole looks like it's more selective about the functions it
rejects.

Will

