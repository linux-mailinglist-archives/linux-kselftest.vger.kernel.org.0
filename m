Return-Path: <linux-kselftest+bounces-37756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92645B0C672
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF5F3A1462
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C861E1C02;
	Mon, 21 Jul 2025 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f+uNMXDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A31DF268
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108483; cv=none; b=Hs3rkt6k8UxqOOYGQTEAcoSeJ78kaAWhMWCATU36B5BaQkKGu7jHi2dtgNG6CC6BNDjtsGPi+qH6K1VS9MEDwIGhn7pcIVsWkhOciI0Zfr3j6U5rb0JwIuT0gMzCEyqVOw3RB6UCgrxaGk7niD65NK6QCYRByYlGnbq8uVyfTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108483; c=relaxed/simple;
	bh=E56olDj2MoY8eJpBRka+4Dj8y6CnK8s1XJDDsgAMXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3cBJAnYEsLFJf+MfaRf4QVmLGCWFnhZ1vCruNVn84C/PAn1lxuB7e87HYutHuV29QUZ7804sgZCUzenajq830IIsVJiz14NBWzD/4saEd4/kvAZtjuNpuxDPMUSsibewJ1quB2ZtGsoxQ7fZv7x4p19dkR5Wx2a/QdEp8b1lv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f+uNMXDC; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b2417fe-8b87-4fb6-9f68-2f7501b839ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753108479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8I04gcLkOlPoH/QpKo/168xzalvDclRKisftxEUbQrs=;
	b=f+uNMXDComyunc/8W5qGJQ66vKlLXS2Xgh+ZhbKGd+yC18+YpoZoKFapfZ4MmWDgNrNY7e
	x6AItxq+3kVbYiCQ00sz7Fa4x5soH9T2plCV/9TI82kf6/glFkpMKcKXtWmA7FhO8ftOD7
	Ohb+T9a8MTtsARLx+SQMGnb5BDisoWk=
Date: Mon, 21 Jul 2025 07:34:33 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
Content-Language: en-GB
To: Matt Fleming <matt@readmodwrite.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel-team@cloudflare.com,
 Jesper Dangaard Brouer <hawk@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Matt Fleming <mfleming@cloudflare.com>
References: <20250718150554.48210-1-matt@readmodwrite.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250718150554.48210-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/18/25 8:05 AM, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
>
> Add benchmarks for the standard set of operations: lookup, update,
> delete. Also, include a benchmark for trie_free() which is known to have
> terrible performance for maps with many entries.
>
> Benchmarks operate on tries without gaps in the key range, i.e. each
> test begins with a trie with valid keys in the range [0, nr_entries).
> This is intended to cause maximum branching when traversing the trie.
>
> All measurements are recorded inside the kernel to remove syscall
> overhead.
>
> Most benchmarks run an XDP program to generate stats but free needs to
> collect latencies using fentry/fexit on map_free_deferred() because it's
> not possible to use fentry directly on lpm_trie.c since commit
> c83508da5620 ("bpf: Avoid deadlock caused by nested kprobe and fentry
> bpf programs") and there's no way to create/destroy a map from within an
> XDP program.
>
> Here is example output from an AMD EPYC 9684X 96-Core machine for each
> of the benchmarks using a trie with 10K entries and a 32-bit prefix
> length, e.g.
>
>    $ ./bench lpm-trie-$op \
>    	--prefix_len=32  \
> 	--producers=1     \
> 	--nr_entries=10000
>
>    lookup: throughput    7.423 ± 0.023 M ops/s (  7.423M ops/prod), latency  134.710 ns/op
>    update: throughput    2.643 ± 0.015 M ops/s (  2.643M ops/prod), latency  378.310 ns/op
>    delete: throughput    0.712 ± 0.008 M ops/s (  0.712M ops/prod), latency 1405.152 ns/op
>      free: throughput    0.574 ± 0.003 K ops/s (  0.574K ops/prod), latency    1.743 ms/op
>
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   2 +
>   tools/testing/selftests/bpf/bench.c           |  10 +
>   tools/testing/selftests/bpf/bench.h           |   1 +
>   .../selftests/bpf/benchs/bench_lpm_trie_map.c | 345 ++++++++++++++++++
>   .../selftests/bpf/progs/lpm_trie_bench.c      | 175 +++++++++
>   .../selftests/bpf/progs/lpm_trie_map.c        |  19 +
>   6 files changed, 552 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_bench.c
>   create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_map.c
>
[...]

> +
> +static __always_inline double duration_ms(struct bench_res *res)
> +{
> +	if (!res->hits)
> +		return 0.0;
> +
> +	return res->duration_ns / res->hits / NSEC_PER_MSEC;
> +}

The above function 'duration_ms' is not used.

> +
> +static void free_ops_report_progress(int iter, struct bench_res *res,
> +				     long delta_ns)
> +{
> +	double hits_per_sec, hits_per_prod;
> +	double rate_divisor = 1000.0;
> +	char rate = 'K';
> +
> +	hits_per_sec = res->hits / (res->duration_ns / (double)NSEC_PER_SEC) /
> +		       rate_divisor;
> +	hits_per_prod = hits_per_sec / env.producer_cnt;
> +
> +	printf("Iter %3d (%7.3lfus): ", iter,
> +	       (delta_ns - NSEC_PER_SEC) / 1000.0);
> +	printf("hits %8.3lf%c/s (%7.3lf%c/prod)\n", hits_per_sec, rate,
> +	       hits_per_prod, rate);
> +}
> +

[...]


