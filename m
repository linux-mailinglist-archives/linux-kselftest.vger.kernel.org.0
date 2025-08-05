Return-Path: <linux-kselftest+bounces-38326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63553B1BB1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4A918A7E19
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE51238C1B;
	Tue,  5 Aug 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cFo00hiF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1219258E
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422962; cv=none; b=poPsy3IWMyM4nsRUbqI0vNXqMWQd9xxbIe/OBPZuRoa0GlDl2YLZjn6+IHtVB0FtZA98qDve+nIG8VrH991HyaaHIufPqLgVQu+5W1dkAayXeZPQj9LJJQFq2PtyorQmLahdNI6iWwzEBqu9q/p0Ualk85CC3p/BkBmSfqXQuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422962; c=relaxed/simple;
	bh=wbVMZzZm0FsM7sBRB2fbnJhzKB3aeB+15sAtxt5DPI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MF1R5XiZi/L6E5WhF6cajCkCvjwcfMr4n6xBIR6ay4o3Nac8RvSom27XKI8mbYfKKqoaOxyt/UAOCH+xkHLVwL6S2t0IpCmuSTddWWnGkIcoZROhGx2zgdGivVXX4DBR68Gx/ZYaZgRfVx5h59IihDUOPOVEghkkGujfgoEomxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cFo00hiF; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <058d4d74-23ff-444b-a773-9d45204900f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754422947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8Hh0fd+FvYlodGt66rzFXniTiKy9FPGxkrJsOd9fyw=;
	b=cFo00hiFs6ixjCFXnRmVvtuguF2TeAq33icVntB1HecfEcfLEM0eTlt5nhmvcV9yUltADY
	FHSPmQnbh3yB8zR892kUHBYgjBJu/7/e+v+7dwSfburSz2M5HpvjAxwCekL55vHljzdotI
	dZ5KECc3YN+UTwoW5acKwKkTjD09LDk=
Date: Tue, 5 Aug 2025 12:42:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
Content-Language: en-GB
To: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250802084803.108777-1-phoenix500526@163.com>
 <20250802084803.108777-3-phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250802084803.108777-3-phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/2/25 1:48 AM, Jiawei Zhao wrote:
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> In this patch:
> - force -O2 optimization for usdt.test.o to generate SIB addressing usdt
>    argument spec.
> - change the global variable t1 to a local variable, to avoid compiler
>    generating PC-relative addressing mode for it.
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |  8 ++++++++
>   tools/testing/selftests/bpf/prog_tests/usdt.c | 18 ++++++++++++------
>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 910d8d6402ef..4b77d06d5c42 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -759,6 +759,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
>   TRUNNER_BPF_CFLAGS :=
>   $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>   
> +# Force usdt.c to use -O2 optimization to generate SIB addressing
> +# Only apply on x86 architecture where SIB addressing is relevant
> +ifeq ($(ARCH), x86)
> +$(OUTPUT)/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> +endif

This is no good. You should not change from -O0 to -O2. The existing usdt.c
test should be kept. I assume at -O0 level, the compiler probably
won't generate SIB pattern.

You could add another usdt test e.g. usdt_o2.c and force
usdt_o2 is compiled with -O2 optimizations and in usdt_o2 focusing on
SIB probe.

> +
>   # Define test_verifier test runner.
>   # It is much simpler than test_maps/test_progs and sufficiently different from
>   # them (e.g., test.h is using completely pattern), that it's worth just
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..86f354d25aef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -14,10 +14,15 @@ static volatile int idx = 2;
>   static volatile __u64 bla = 0xFEDCBA9876543210ULL;
>   static volatile short nums[] = {-1, -2, -3, -4};
>   
> -static volatile struct {
> -	int x;
> -	signed char y;
> -} t1 = { 1, -127 };
> +/*
> + * TODO:  At O2 optimization level, t1's USDT argument spec becomes -1@4+t1(%rip).
> + * Since libbpf doesn't support RIP addressing mode yet, this causes "unrecognized register" errors.
> + * This test will be re-enabled once libbpf supports RIP addressing mode.
> + */
> +// static volatile struct {
> +//	int x;
> +//	signed char y;
> +// } t1 = { 1, -127 };
>   

[...]


