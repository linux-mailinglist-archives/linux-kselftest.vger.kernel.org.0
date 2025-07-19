Return-Path: <linux-kselftest+bounces-37632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E64B0B030
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072121782D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01172874E5;
	Sat, 19 Jul 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knA3+jwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC32286D7A;
	Sat, 19 Jul 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752930912; cv=none; b=K7dgOdm7RF88UeZkHW8zIrJOmtwBRhZPmK8w2KC6tH72bxP3K1fCF9X9eT8aKayLCgD0B5dtyzUOhibQi1F4bQ4h9m5D9F13A/RWgE5ZF806K6SUlvCkvyuKKBp3/Lux+fwyUPTzfW15xiYfScFoMmWLG2/j5H+244EHe9tCKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752930912; c=relaxed/simple;
	bh=Y56Y9TszFLVMWinBCZFOHZxvFqKUs/k3AHWrTwYXNBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hu/bMnjaZrVZToIzftaVycHSpLZkw5uXt63gWuKArNvaHD8wT9oYhJGGUVP2evgmjBGNaK+US3eWrFLdR0ITvSCfv51x0Iu+dWvcPl9uyz6OY0+Y/wXHCdElYy9SJ/DzCd37P5t4/tmjbv+Jp/dy8i1ZHqtzhRpSgNnc2xXdkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knA3+jwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC0AC4CEE3;
	Sat, 19 Jul 2025 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752930912;
	bh=Y56Y9TszFLVMWinBCZFOHZxvFqKUs/k3AHWrTwYXNBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=knA3+jwxJ5/pPrzTMnyfUBfKL1V+3ZIfj6r1GGRWjfwBiKnjAuDznBaXjQsa1Dh0b
	 ObE3uIAwdhux6+4Yjk313yDknHRfADprbR0oNEbrYTP399z4+xIYGjJc8azdxFbF+F
	 UmwnxH+tj5kT2IJrgVk81w3nLnV4mRYdWwzKbDoxYtWuTeF80xHPDMaKWVC/ketKdr
	 NsnZ3zWsqMUUABAI8HJwiiU3cakyDe8vO9JJs0mEiFtdv0FBIIYemXINpD5s7L4n4L
	 agNBid3yCcvCfV7n6zgACi5P1ogwui64zpkSiWi/ME3lOixtn7pbgBNLLKkVA7Uvud
	 KUVvYyiVznBUg==
Message-ID: <81cd8749-6212-4fcf-8e1a-5eba5a8e2a73@kernel.org>
Date: Sat, 19 Jul 2025 15:15:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, kernel-team@cloudflare.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Matt Fleming <mfleming@cloudflare.com>,
 Yonghong Song <yonghong.song@linux.dev>, Netdev <netdev@vger.kernel.org>
References: <20250718150554.48210-1-matt@readmodwrite.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250718150554.48210-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/07/2025 17.05, Matt Fleming wrote:
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

I've already tested + reviewed this and different version of this 
benchmark during internal development.  Thanks to Matt for working on this.

Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>

You can add my reviewed by when we resolve below comment.

Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>


> [...]
> diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
> new file mode 100644
> index 000000000000..c335718cc240
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
> @@ -0,0 +1,175 @@
[...]
> +
> +static __always_inline void atomic_inc(long *cnt)
> +{
> +	__atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
> +}
> +
> +static __always_inline long atomic_swap(long *cnt, long val)
> +{
> +	return __atomic_exchange_n(cnt, val, __ATOMIC_SEQ_CST);
> +}

For userspace includes we have similar defines in bench.h.
Except they use __ATOMIC_RELAXED and here __ATOMIC_SEQ_CST.
Which is the correct to use?

For BPF kernel-side do selftests have another header file that define
these `atomic_inc` and `atomic_swap` ?

--Jesper




