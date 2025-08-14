Return-Path: <linux-kselftest+bounces-38949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED46B26050
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A833B111C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6A2FB987;
	Thu, 14 Aug 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gapjnHf7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC32FC874;
	Thu, 14 Aug 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162062; cv=none; b=q9bOOBc9xfnFif2X+2KjyeIOBaAEIW/dPTmYlKrH6yf9qdSwlF00589RAIih9mJaRQW/WaTWCGRmU998ZJYeyD7c/dRiHHPNI10GlVxisgmrBJJxiZhDamfKwLelpYraPyneCBxJwMabnlAFA9ljXwPTHCd05G3V9EgDde7v7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162062; c=relaxed/simple;
	bh=kfIC01s9yQ5mKJ/rXXEH1XcjUrgB4lPfBVa1ADMWbTM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVihG2db9zrOTnh8C9mWe5vxDKUSXB/Br42IWd48zNT85TJtVVrTBJHLVTNUX5ZgrKnqkZymO/Rycl60gdeHxHMMTaEMUh6yM1UEsGw+qefcEnGJc6rraQGeGE+Eius153aN00laRlFFvDLfCA4nVROuim1LGjsA+SeIpaFk50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gapjnHf7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so4449735e9.1;
        Thu, 14 Aug 2025 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755162058; x=1755766858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDGB2cR8if6ZH2zs0PF/R7505/JlUyKM0m/lfviOAcM=;
        b=gapjnHf7zhkDXjd/6RRMMJo54DdfkIloPZjcuOmOhZFBU9Tteyoj+x8UHqn3GP+bon
         CUYrF7i5qKn+WSsUDNemPHjasXI1tggL2sCjMzopET2DEOlcpVHjF5WbU1FbnL8DNMXz
         0WAPHolVQ+OPXZdxxKM/pbAW5ZICyKuHozytfhF9x+iFK+FIfElnvuqB0rk1PbUInkBC
         +NQV0kxtnKPxuiELDc5OAWIVQxPEV1qAVsdtRhGftBIuwU80hgWHTw5jcgLFgLn7Tn2c
         gXvTod/df6qYvR8tPPJDI/fO0oucwm4y32Y+2wGetfbYZ/rwWcuU8U0DxKiGvc5eaYzq
         9q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162058; x=1755766858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDGB2cR8if6ZH2zs0PF/R7505/JlUyKM0m/lfviOAcM=;
        b=iA0/oZ6mASJepv+h4RGBNiF1Om86USTwYeDu5o55hnlU6wte7XOtT6O2IBvugcUZUd
         c7+/1lddaXgyn17m0CahZUAGmsCXVsB98NwizkmotLZU5wceefNXDnM1BQjjV1BrpvOu
         5kgN60zIdPwNg4MlKhtzrCOjHUnho5VNtkgOaDjaETU5YjaOrb9VRxzrBge4LpYDatR4
         msv83ekOIxJJim4+FnLJv76oVxSWRhrQhaGCxIqkFLm7bJc9xleyxIjF8dP3phFLFvvD
         9l3v1y/WhKDtLh1snA0EVpUi22+4C0ekUabgleYqg6Xk5d8JhT+d2B6/QT1dQE2RcjNT
         lE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUpzqDibg4tSrSLWPvyrzhc8+4KDIDTg5JIlgNuslLEUptZadRhDBbbHspAqf/k6wopD0=@vger.kernel.org, AJvYcCWZveWSPwIYbAQpJ+uX776iZ7Il51qL7VRYKtIt9txXnoVR4qs1A6lXZvxPl3/WxwubQNoadwR7TJXtdryzWnQy@vger.kernel.org, AJvYcCXsbKTgZesVhLhEXIk1KLMuIt1gxbMzAZ62Bnm176eqQfJybf9QQjdFo/vEhr8koMAowijJV6U4VvQQfq1O@vger.kernel.org
X-Gm-Message-State: AOJu0YymQ2MiHjrvzbWvrA4ppZh2/GrcHD9rxMgj3xygKWx7D/82Sw2A
	Zl7nBP21DmxJ6A80jVLI+5HfIiFwMaklDLsvI3pnpCHTzVY91Upki8IY
X-Gm-Gg: ASbGncuAVRb7P97v2fhocv8oHGeveLOF4o1v/SJWoee6EB1PSF6oyp2UoQrA2Wg78po
	jrHHfu5laEj+9xGyjNv87m4VCUWMKTD5C82C988TsolMbTo8IwzA+ZM7YaHNb90TpzQk858ZU59
	/k2RLDjDXMWIbt23nwo9C/0ExZOoACiqqhsRdI3aTF5+LbSgPfouYFPDI9CVMXWBgYMhCu8whD7
	HuGjZftmWZ9VALAJbiqxyogeUdEsFdJp4VsZKIwGPEPHAhhajBKXJXhYNuuo5tIKCFG4NVdSeso
	AkzMGGxuC8sWdZx9JekNj4iUiYC2LeQHIKHopscWHxOWQ7c61uw4eWRac9ACesyxKzAfyaFR
X-Google-Smtp-Source: AGHT+IEf/HOG+lNROoBVhIXSDZhNx2uqtQGIfsWzrtShrYamuDneVKSjmMOtgfiCLgih4GixA55L9Q==
X-Received: by 2002:a05:600c:3507:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-45a1b605850mr15218395e9.6.1755162058105;
        Thu, 14 Aug 2025 02:00:58 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6e336csm13777865e9.16.2025.08.14.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:00:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Aug 2025 11:00:55 +0200
To: Jiawei Zhao <phoenix500526@163.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, shuah@kernel.org, yonghong.song@linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 2/2] selftests/bpf: Add an usdt_o2 test case
 in selftests to cover SIB handling logic
Message-ID: <aJ2lxyUYfQkfQW2-@krava>
References: <20250814064504.103401-1-phoenix500526@163.com>
 <20250814064504.103401-3-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814064504.103401-3-phoenix500526@163.com>

On Thu, Aug 14, 2025 at 06:45:04AM +0000, Jiawei Zhao wrote:
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
> 
> In this patch:
> - add usdt_o2 test case to cover SIB addressing usdt argument spec
>   handling logic

hi,
on my setup (gcc15) the test generates ust register argument:

  stapsdt              0x0000002a       NT_STAPSDT (SystemTap probe descriptors)
    Provider: test
    Name: usdt1
    Location: 0x00000000007677ce, Base: 0x00000000035bc728, Semaphore: 0x0000000000000000
    Arguments: 8@%rax


  7677c6:       48 8b 04 c5 20 49 9c    mov    0x39c4920(,%rax,8),%rax
  7677cd:       03
  7677ce:       90                      nop


I'm not sure if there's reliable solution to generate SIB argument from gcc,
maybe we could generate all in assembly, but that might get complicated

jirka


> 
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  1 +
>  .../selftests/bpf/prog_tests/usdt_o2.c        | 69 +++++++++++++++++++
>  .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4863106034df..24ff1a329625 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -760,6 +760,7 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>  TRUNNER_BPF_CFLAGS :=
>  $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>  
> +
>  # Define test_verifier test runner.
>  # It is much simpler than test_maps/test_progs and sufficiently different from
>  # them (e.g., test.h is using completely pattern), that it's worth just
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> new file mode 100644
> index 000000000000..f02dcf5188ab
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
> +#include <test_progs.h>
> +
> +#include "../sdt.h"
> +#include "test_usdt_o2.skel.h"
> +
> +#if defined(__GNUC__) && !defined(__clang__)
> +__attribute__((optimize("O2")))
> +#endif
> +
> +#define test_value 0xFEDCBA9876543210ULL
> +#define SEC(name) __attribute__((section(name), used))
> +
> +int lets_test_this(int);
> +static volatile __u64 array[1] = {test_value};
> +
> +static __always_inline void trigger_func(void)
> +{
> +	/* Base address + offset + (index * scale) */
> +	for (volatile int i = 0; i <= 0; i++)
> +		STAP_PROBE1(test, usdt1, array[i]);
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
> -- 
> 2.43.0
> 
> 

