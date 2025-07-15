Return-Path: <linux-kselftest+bounces-37356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B470AB05D59
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5171C21944
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B922E498C;
	Tue, 15 Jul 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI7SwqgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313E2E4980;
	Tue, 15 Jul 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586361; cv=none; b=Hc36RFoUNCPUbKf/r1urJb6ptWNJSllAfGiOEqztlErRJymUauefsEWuC/Gb48tnK1KbYW95d7W18dkrBAiaAYUs8sEx9tJd9FZS9zfOcfw5QEbINsv1vaSovtiMugWrbsqLeof9IbbJcgPqHCsCvUxQ4zPqKYhF33DEoTrvVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586361; c=relaxed/simple;
	bh=SKALgTAWbYSqaPqfyTvDFdr5s2YmxkBpet4kPaBBqXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuoSAwHG+MAJcdSg1PsWLA/Jh0jTUsgpLZupBQgaWkM4OBsicIiDiUnrgSm18oumwfi0AAUrTVaPXnBWCqFrwU76ZQKGiggGqIq4Y1NCt3Hyk8mNJ4NlIMy1k0wk+09xth/ryJNgIJCzjLurLvmlDru7iClXKjgj/fjBkSoq/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI7SwqgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEEEC4CEF1;
	Tue, 15 Jul 2025 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586360;
	bh=SKALgTAWbYSqaPqfyTvDFdr5s2YmxkBpet4kPaBBqXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZI7SwqgD8TbMTdcjaid36j2VW68WCjsz6IphHoD3L8oj7yvvv8AVD0gXb47xBudX9
	 Pc5lIOST05zZnar4sTA8GcsqOT1JDsnL6BxC/stKQJL/tIwrZMPyNSbLFrq1ZQzNk/
	 AcksIGBQR73ls1IkuW+NHqxXCWT2tqkJS8RocH3HegHVAjZJr6RpHFjIPS++afsXRc
	 OIAdcf/IUjuB3QHTojwD6oJ0tX+m2fDKAn4dlKbu0D8toI79/Oam/t1l6tWJ9LUqD9
	 kuYAWoTjxyYhsu7y8434uE0H1khF6wORrOc60BtaenKWXshOiwxkqAvXPvO1K94W49
	 l+sd2izuEvAug==
Date: Tue, 15 Jul 2025 14:32:33 +0100
From: Will Deacon <will@kernel.org>
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
Message-ID: <aHZYcY_9JtK8so3C@willie-the-truck>
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
 <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-arm64_relax_jit_comp-v1-1-3850fe189092@bootlin.com>

On Wed, Jul 09, 2025 at 10:36:55AM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> While introducing support for 9+ arguments for tracing programs on
> ARM64, commit 9014cf56f13d ("bpf, arm64: Support up to 12 function
> arguments") has also introduced a constraint preventing BPF trampolines
> from being generated if the target function consumes a struct argument
> passed on stack, because of uncertainties around the exact struct
> location: if the struct has been marked as packed or with a custom
> alignment, this info is not reflected in BTF data, and so generated
> tracing trampolines could read the target function arguments at wrong
> offsets.
> 
> This issue is not specific to ARM64: there has been an attempt (see [1])
> to bring the same constraint to other architectures JIT compilers. But
> discussions following this attempt led to the move of this constraint
> out of the kernel (see [2]): instead of preventing the kernel from
> generating trampolines for those functions consuming structs on stack,
> it is simpler to just make sure that those functions with uncertain
> struct arguments location are not encoded in BTF information, and so
> that one can not even attempt to attach a tracing program to such
> function. The task is then deferred to pahole (see [3]).
> 
> Now that the constraint is handled by pahole, remove it from the arm64
> JIT compiler to keep it simple.
> 
> [1] https://lore.kernel.org/bpf/20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com/
> [2] https://lore.kernel.org/bpf/CAADnVQ+sj9XhscN9PdmTzjVa7Eif21noAUH3y1K6x5bWcL-5pg@mail.gmail.com/
> [3] https://lore.kernel.org/bpf/20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com/
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 5 -----
>  1 file changed, 5 deletions(-)

This is a question born more out of ignorance that insight, but how do
we ensure that the version of pahole being used is sufficiently
up-to-date that the in-kernel check is not required?

Will

