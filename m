Return-Path: <linux-kselftest+bounces-39971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80BB370BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EED7C2788
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98B2D46D1;
	Tue, 26 Aug 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZ5oM5Jn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E9280037
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227110; cv=none; b=GeSVoAR52XyOFXnmced87qxeNdceiUi78PmWNVH3+QXx0God/6qXdHs5OUNHHeUuvxys9soKJ1Kts80AAoCy6H66w329PIJSf/vmmqxOf/TJJ8FosK6FkXZ+30b5bSWfNBZRR8EM5mfm0+iy5ShHw8x/OwqqwRZe9CDOzWLmQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227110; c=relaxed/simple;
	bh=er1lq/dzsrmFZwsv2XyfdQy2+0Y7HeZOJLs86tFN+BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzHXz7fG2dX8QOrOHY8s/J0rQVr+u9uTGcAzYqXQ0Y8v2bH0QoLHPlrXx8suj3xdthNzoIaH037/97AheJ8yN1Cpn1hDL3SIofZWkKsUzociu7Cbijcpyx606g0lEt40GHJqeOjnls7vY78SEB0gtl+dVPwhqHmLaATg+IHeUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZ5oM5Jn; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d438bf3a-a9c9-4d34-b814-63f2e9bb3a85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756227096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnzpS995oSOSAmi/9OR2XBD5gzrE04xt0mbKyF2sQXU=;
	b=GZ5oM5JnBURFXQr6PfYeyqv3JcusbV4mlcSjz/z3d+E2E2iRcqUy3EcwG7jLGSkJylG4t1
	GlqPh0K3FekjPeIlrW44T8vStlPQhGUNYV+6OcLpa5SP0UwSPDGfXOLc46Nr6k6TIeJzNQ
	tYEz1DfuwUbulkj+hrRAUy16k3ooCa0=
Date: Tue, 26 Aug 2025 09:51:08 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v15 2/2] selftests/bpf: Enrich subtest_basic_usdt
 case in selftests to cover SIB handling logic
Content-Language: en-GB
To: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250823071839.1191350-1-phoenix500526@163.com>
 <20250823071839.1191350-3-phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250823071839.1191350-3-phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/23/25 12:18 AM, Jiawei Zhao wrote:
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

You can remove "-1@t+t1(%rip)" which is not relavent to this patch.

Also, please also mention usage of STAP_PROBE_ASM so the test works
for both gcc and clang.

I tested the patch with gcc/clang for x86_64 and it works fine.
I didn't test 32-bit x86 arch.

>
> In this patch:
> - enrich subtest_basic_usdt test case to cover SIB addressing usdt argument spec
>    handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/usdt.c | 62 ++++++++++++++++++-
>   tools/testing/selftests/bpf/progs/test_usdt.c | 32 ++++++++++
>   2 files changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 9057e983cc54..4b264f7d3324 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -10,6 +10,26 @@
>   
>   int lets_test_this(int);
>   
> +#if defined(__x86_64__) || defined(__i386__)
> +/*
> + * SIB (Scale-Index-Base) addressing format:
> + *   "size@(base_reg, index_reg, scale)"
> + * - 'size' is the size in bytes of the array element, and its sign indicates
> + *		whether the type is signed (negative) or unsigned (positive).
> + * - 'base_reg' is the register holding the base address, normally rdx or edx
> + * - 'index_reg' is the register holding the index, normally rax or eax
> + * - 'scale' is the scaling factor (typically 1, 2, 4, or 8), which matches the
> + *		size of the element type.
> + *
> + * For example, for an array of 'short' (signed 2-byte elements), the SIB spec would be:
> + *	- size: -2 (negative because 'short' is signed)
> + *	- scale: 2 (since sizeof(short) == 2)
> + *	The resulting SIB format: "-2@(%%rdx,%%rax,2)"
> + */
> +static volatile short array[] = {-1, -2, -3, -4};
> +#define USDT_SIB_ARG_SPEC -2@(%%rdx,%%rax,2)
> +#endif
> +
>   static volatile int idx = 2;
>   static volatile __u64 bla = 0xFEDCBA9876543210ULL;
>   static volatile short nums[] = {-1, -2, -3, -4};
> @@ -25,6 +45,10 @@ unsigned short test_usdt0_semaphore SEC(".probes");
>   unsigned short test_usdt3_semaphore SEC(".probes");
>   unsigned short test_usdt12_semaphore SEC(".probes");
>   
> +#if defined(__x86_64__) || defined(__i386__)
> +unsigned short test_usdt_sib_semaphore SEC(".probes");
> +#endif
> +
>   static void __always_inline trigger_func(int x) {
>   	long y = 42;
>   
> @@ -40,12 +64,27 @@ static void __always_inline trigger_func(int x) {
>   	}
>   }
>   
> +#if defined(__x86_64__) || defined(__i386__)
> +static void trigger_sib_spec(void)
> +{
> +	/* Base address + offset + (index * scale) */
> +	/* Force SIB addressing with inline assembly */
> +	asm volatile(
> +		STAP_PROBE_ASM(test, usdt_sib, USDT_SIB_ARG_SPEC)
> +		:
> +		: "d"(array), "a"(0)
> +		: "memory"
> +	);
> +}
> +#endif
> +
>   static void subtest_basic_usdt(void)
>   {
>   	LIBBPF_OPTS(bpf_usdt_opts, opts);
>   	struct test_usdt *skel;
>   	struct test_usdt__bss *bss;
>   	int err, i;
> +	const __u64 expected_cookie = 0xcafedeadbeeffeed;
>   
>   	skel = test_usdt__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -59,20 +98,29 @@ static void subtest_basic_usdt(void)
>   		goto cleanup;
>   
>   	/* usdt0 won't be auto-attached */
> -	opts.usdt_cookie = 0xcafedeadbeeffeed;
> +	opts.usdt_cookie = expected_cookie;
>   	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
>   						     0 /*self*/, "/proc/self/exe",
>   						     "test", "usdt0", &opts);
>   	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
>   		goto cleanup;
>   
> +#if defined(__x86_64__) || defined(__i386__)
> +	opts.usdt_cookie = expected_cookie;
> +	skel->links.usdt_sib = bpf_program__attach_usdt(skel->progs.usdt_sib,
> +								0 /*self*/, "/proc/self/exe",
> +								"test", "usdt_sib", &opts);

formate issue in the above?

> +	if (!ASSERT_OK_PTR(skel->links.usdt_sib, "usdt_sib_link"))
> +		goto cleanup;
> +#endif
> +
>   	trigger_func(1);
>   
>   	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
>   	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
>   	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
>   
> -	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
> +	ASSERT_EQ(bss->usdt0_cookie, expected_cookie, "usdt0_cookie");
>   	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
>   	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
>   	ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
> @@ -156,6 +204,16 @@ static void subtest_basic_usdt(void)
>   	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
>   	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
>   
> +#if defined(__x86_64__) || defined(__i386__)
> +	trigger_sib_spec();
> +	ASSERT_EQ(bss->usdt_sib_called, 1, "usdt_sib_called");
> +	ASSERT_EQ(bss->usdt_sib_cookie, expected_cookie, "usdt_sib_cookie");
> +	ASSERT_EQ(bss->usdt_sib_arg_cnt, 1, "usdt_sib_arg_cnt");
> +	ASSERT_EQ(bss->usdt_sib_arg, nums[0], "usdt_sib_arg");
> +	ASSERT_EQ(bss->usdt_sib_arg_ret, 0, "usdt_sib_arg_ret");
> +	ASSERT_EQ(bss->usdt_sib_arg_size, sizeof(nums[0]), "usdt_sib_arg_size");
> +#endif
> +
>   cleanup:
>   	test_usdt__destroy(skel);
>   }
> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> index 096488f47fbc..63db72253316 100644
> --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> @@ -107,4 +107,36 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
>   	return 0;
>   }
>   
> +
> +int usdt_sib_called;
> +u64 usdt_sib_cookie;
> +int usdt_sib_arg_cnt;
> +int usdt_sib_arg_ret;
> +u64 usdt_sib_arg;
> +int usdt_sib_arg_size;
> +
> +/*
> + * usdt_sib is only tested on x86-related architectures, so it requires
> + * manual attach since auto-attach will panic tests under other architectures
> + */
> +SEC("usdt")
> +int usdt_sib(struct pt_regs *ctx)
> +{
> +	long tmp;
> +
> +	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	__sync_fetch_and_add(&usdt_sib_called, 1);
> +
> +	usdt_sib_cookie = bpf_usdt_cookie(ctx);
> +	usdt_sib_arg_cnt = bpf_usdt_arg_cnt(ctx);
> +
> +	usdt_sib_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
> +	usdt_sib_arg = (short)tmp;

Maybe change usdt_sib_arg type as short?

> +	usdt_sib_arg_size = bpf_usdt_arg_size(ctx, 0);
> +
> +	return 0;
> +}
> +
>   char _license[] SEC("license") = "GPL";


