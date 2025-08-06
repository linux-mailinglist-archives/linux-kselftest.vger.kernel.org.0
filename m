Return-Path: <linux-kselftest+bounces-38408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB8B1CBC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5909C3BDD20
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7929CB40;
	Wed,  6 Aug 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOSBM5z3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715529AB1A
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504272; cv=none; b=MXlq4jROujW0e96bAeeo4t9peeEk1DsZ/PkgbNxgapoPYdV3noYoCi5pmjbPt9QrG5G3jl5/82wY9QEf0Qlmp6Rx4D+p40sb2nrl1KYUgw5mEj/LcQ0tnMnWQcJ3rvGLABZEIVzbkOrm+21ipkfTKmRR3q9x0Lp0nFf82QS4gMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504272; c=relaxed/simple;
	bh=3FKNH/2j/7yu+W35gTHHG3ks/5yRV+BkQeegHY/jpjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coYJF12FWdwr4mIyS0pRIPHxOUe9/2itvWdrooXgClER6cAFsqc75Jq+4C0ZLj28bjxDlwiKIQOw5MJS7a1KIGW/ttUzkhUfs8g7MWon1ee8KUvir8E0iJuunsfZXEo7sFFy+dHDjZAxuhNA8j0mcUTVp9qkhOnPKrTUj3+vODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOSBM5z3; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754504259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhCFOoWcGKQbx95VvRl2b6bWCAnvya8JVL9ii3cAoDE=;
	b=EOSBM5z3ZJOmEo9Ixd9QAEvaEPUKcZfPlRtc+NfPXufXiYchRCLelhonbA7+Q6stWN31n3
	L6cY8LibCK76zwAVQXfYFdmVXcZ9kbQ5hP+H96hD4EDn7giULPUOG8jDB7jgxCoqA3VU43
	tmZvRZoTMZos8h5DeBY6UiA5YqbntRM=
Date: Wed, 6 Aug 2025 11:17:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
Content-Language: en-GB
To: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250806092458.111972-3-phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 2:24 AM, Jiawei Zhao wrote:
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> In this patch:
> - add usdt_o2 test case to cover SIB addressing usdt argument spec
>    handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |  8 +++
>   .../selftests/bpf/prog_tests/usdt_o2.c        | 71 +++++++++++++++++++
>   .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
>   3 files changed, 116 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 910d8d6402ef..68cf6a9cf05f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -759,6 +759,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>   TRUNNER_BPF_CFLAGS :=
>   $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>   
> +# Use -O2 optimization to generate SIB addressing usdt argument spec
> +# Only apply on x86 architecture where SIB addressing is relevant
> +ifeq ($(ARCH), x86)
> +$(OUTPUT)/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/cpuv4/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/no_alu32/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> +endif

I tried your selftest with gcc14 and llvm20 in my environment. See below:

llvm20:
Displaying notes found in: .note.stapsdt
   Owner                Data size        Description
   stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt1
     Location: 0x00000000000003ac, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
     Arguments: 8@-64(%rbp)

gcc14:
Displaying notes found in: .note.stapsdt
   Owner                Data size        Description
   stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descriptors)
     Provider: test
     Name: usdt1
     Location: 0x0000000000000334, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
     Arguments: 8@array(,%rax,8)

llvm20 and gcc14 generate different usdt patterns. '8@-64(%rbp)' already supports so
with SIB support, the test should pass CI, I think.

> +
>   # Define test_verifier test runner.
>   # It is much simpler than test_maps/test_progs and sufficiently different from
>   # them (e.g., test.h is using completely pattern), that it's worth just
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> new file mode 100644
> index 000000000000..f04b756b3640
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
> +#include <test_progs.h>
> +
> +#define _SDT_HAS_SEMAPHORES 1
> +#include "../sdt.h"
> +#include "test_usdt_o2.skel.h"
> +
> +int lets_test_this(int);
> +
> +#define test_value 0xFEDCBA9876543210ULL
> +#define SEC(name) __attribute__((section(name), used))
> +
> +
> +static volatile __u64 array[1] = {test_value};
> +unsigned short test_usdt1_semaphore SEC(".probes");
> +
> +static __always_inline void trigger_func(void)
> +{
> +	/* Base address + offset + (index * scale) */
> +	if (test_usdt1_semaphore) {
> +		for (volatile int i = 0; i <= 0; i++)
> +			STAP_PROBE1(test, usdt1, array[i]);
> +	}
> +}
> +
> +static void basic_sib_usdt(void)
> +{
> +	LIBBPF_OPTS(bpf_usdt_opts, opts);
> +	struct test_usdt_o2 *skel;
> +	struct test_usdt_o2__bss *bss;
> +	int err;
> +
> +	skel = test_usdt_o2__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	bss = skel->bss;
> +	bss->my_pid = getpid();
> +
> +	err = test_usdt_o2__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* usdt1 won't be auto-attached */
> +	opts.usdt_cookie = 0xcafedeadbeeffeed;
> +	skel->links.usdt1 = bpf_program__attach_usdt(skel->progs.usdt1,
> +						     0 /*self*/, "/proc/self/exe",
> +						     "test", "usdt1", &opts);
> +	if (!ASSERT_OK_PTR(skel->links.usdt1, "usdt1_link"))
> +		goto cleanup;
> +
> +	trigger_func();
> +
> +	ASSERT_EQ(bss->usdt1_called, 1, "usdt1_called");
> +	ASSERT_EQ(bss->usdt1_cookie, 0xcafedeadbeeffeed, "usdt1_cookie");
> +	ASSERT_EQ(bss->usdt1_arg_cnt, 1, "usdt1_arg_cnt");
> +	ASSERT_EQ(bss->usdt1_arg, test_value, "usdt1_arg");
> +	ASSERT_EQ(bss->usdt1_arg_ret, 0, "usdt1_arg_ret");
> +	ASSERT_EQ(bss->usdt1_arg_size, sizeof(array[0]), "usdt1_arg_size");
> +
> +cleanup:
> +	test_usdt_o2__destroy(skel);
> +}
> +
> +
> +
> +void test_usdt_o2(void)
> +{
> +	basic_sib_usdt();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_usdt_o2.c b/tools/testing/selftests/bpf/progs/test_usdt_o2.c
> new file mode 100644
> index 000000000000..14602aa54578
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_usdt_o2.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/usdt.bpf.h>
> +
> +int my_pid;
> +
> +int usdt1_called;
> +u64 usdt1_cookie;
> +int usdt1_arg_cnt;
> +int usdt1_arg_ret;
> +u64 usdt1_arg;
> +int usdt1_arg_size;
> +
> +SEC("usdt")
> +int usdt1(struct pt_regs *ctx)
> +{
> +	long tmp;
> +
> +	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	__sync_fetch_and_add(&usdt1_called, 1);
> +
> +	usdt1_cookie = bpf_usdt_cookie(ctx);
> +	usdt1_arg_cnt = bpf_usdt_arg_cnt(ctx);
> +
> +	usdt1_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
> +	usdt1_arg = (u64)tmp;
> +	usdt1_arg_size = bpf_usdt_arg_size(ctx, 0);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


