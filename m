Return-Path: <linux-kselftest+bounces-4287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB384D6D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 00:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549501F23C9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9770535CE;
	Wed,  7 Feb 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pIQbZVK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5338535C4
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350330; cv=none; b=icGiE+TfJgkQudluqbW5vfPtSSv+sxmxFAtVn5JMIiiwJFJ3Cd3Maz9sDpZ0gQYmpJju80vu8jH8JTpSKyNoxACh0PExgLMGRLLpdJI1EP35noaO9IunoBYNTDbmk1r2kn9DH4jtVjvinrpki6NQFRbYzWajrjCrX15DPhIyXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350330; c=relaxed/simple;
	bh=R4QNkyQjSAfAfY7FrkR0iT+UnKekRPxtGiyIy+jBGc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijBba/pMTYe/QEdAB9jnWuUXyWVaO2zq068q0Mkl7AksNMVJxS3NDY+4TWW3IKZUOYQBeq1/a0Ue0WyxwDyQWbSNM5JFkUCvA33FV8eZcuBWpjD0aUNcaoNTaNYyhZfBQVlsgjKxdRLd78OgW9uAml2MBZgEmvHWJ4jbZ4IQGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pIQbZVK9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <289242c3-052b-436d-8c7c-b0fa5ae45bce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707350324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WK54SxKnBujvpL5BBhfinuafXj82ZQYILhUA9QEnG84=;
	b=pIQbZVK96gXzmxL4IOP+dzQgVE6JGxzMqmbmaFevTzD1mAuv56f6q3U1U9WHp/ib0xUE3H
	Iu0XaTYt4fFPfLuNAuAAxKiPqMTkpNgFU1cNmnkejMeLAztzaMQtAVJOvzHXv8SqjuckFv
	Gi+F1+v+/wr3RvX0MoiDAd6zgxMhbV0=
Date: Wed, 7 Feb 2024 15:58:33 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Allow compiler to inline most of
 bpf_local_storage_lookup()
Content-Language: en-GB
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240207122626.3508658-1-elver@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240207122626.3508658-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/7/24 4:26 AM, Marco Elver wrote:
> In various performance profiles of kernels with BPF programs attached,
> bpf_local_storage_lookup() appears as a significant portion of CPU
> cycles spent. To enable the compiler generate more optimal code, turn
> bpf_local_storage_lookup() into a static inline function, where only the
> cache insertion code path is outlined
>
> Notably, outlining cache insertion helps avoid bloating callers by
> duplicating setting up calls to raw_spin_{lock,unlock}_irqsave() (on
> architectures which do not inline spin_lock/unlock, such as x86), which
> would cause the compiler produce worse code by deciding to outline
> otherwise inlinable functions. The call overhead is neutral, because we
> make 2 calls either way: either calling raw_spin_lock_irqsave() and
> raw_spin_unlock_irqsave(); or call __bpf_local_storage_insert_cache(),
> which calls raw_spin_lock_irqsave(), followed by a tail-call to
> raw_spin_unlock_irqsave() where the compiler can perform TCO and (in
> optimized uninstrumented builds) turns it into a plain jump. The call to
> __bpf_local_storage_insert_cache() can be elided entirely if
> cacheit_lockit is a false constant expression.
>
> Based on results from './benchs/run_bench_local_storage.sh' (21 trials,
> reboot between each trial; x86 defconfig + BPF, clang 16) this produces
> improvements in throughput and latency in the majority of cases, with an
> average (geomean) improvement of 8%:
>
> +---- Hashmap Control --------------------
> |
> | + num keys: 10
> | :                                         <before>             | <after>
> | +-+ hashmap (control) sequential get    +----------------------+----------------------
> |   +- hits throughput                    | 14.789 M ops/s       | 14.745 M ops/s (  ~  )
> |   +- hits latency                       | 67.679 ns/op         | 67.879 ns/op   (  ~  )
> |   +- important_hits throughput          | 14.789 M ops/s       | 14.745 M ops/s (  ~  )
> |
> | + num keys: 1000
> | :                                         <before>             | <after>
> | +-+ hashmap (control) sequential get    +----------------------+----------------------
> |   +- hits throughput                    | 12.233 M ops/s       | 12.170 M ops/s (  ~  )
> |   +- hits latency                       | 81.754 ns/op         | 82.185 ns/op   (  ~  )
> |   +- important_hits throughput          | 12.233 M ops/s       | 12.170 M ops/s (  ~  )
> |
> | + num keys: 10000
> | :                                         <before>             | <after>
> | +-+ hashmap (control) sequential get    +----------------------+----------------------
> |   +- hits throughput                    | 7.220 M ops/s        | 7.204 M ops/s  (  ~  )
> |   +- hits latency                       | 138.522 ns/op        | 138.842 ns/op  (  ~  )
> |   +- important_hits throughput          | 7.220 M ops/s        | 7.204 M ops/s  (  ~  )
> |
> | + num keys: 100000
> | :                                         <before>             | <after>
> | +-+ hashmap (control) sequential get    +----------------------+----------------------
> |   +- hits throughput                    | 5.061 M ops/s        | 5.165 M ops/s  (+2.1%)
> |   +- hits latency                       | 198.483 ns/op        | 194.270 ns/op  (-2.1%)
> |   +- important_hits throughput          | 5.061 M ops/s        | 5.165 M ops/s  (+2.1%)
> |
> | + num keys: 4194304
> | :                                         <before>             | <after>
> | +-+ hashmap (control) sequential get    +----------------------+----------------------
> |   +- hits throughput                    | 2.864 M ops/s        | 2.882 M ops/s  (  ~  )
> |   +- hits latency                       | 365.220 ns/op        | 361.418 ns/op  (-1.0%)
> |   +- important_hits throughput          | 2.864 M ops/s        | 2.882 M ops/s  (  ~  )
> |
> +---- Local Storage ----------------------
> |
> | + num_maps: 1
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 33.005 M ops/s       | 39.068 M ops/s (+18.4%)
> |   +- hits latency                       | 30.300 ns/op         | 25.598 ns/op   (-15.5%)
> |   +- important_hits throughput          | 33.005 M ops/s       | 39.068 M ops/s (+18.4%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 37.151 M ops/s       | 44.926 M ops/s (+20.9%)
> |   +- hits latency                       | 26.919 ns/op         | 22.259 ns/op   (-17.3%)
> |   +- important_hits throughput          | 37.151 M ops/s       | 44.926 M ops/s (+20.9%)
> |
> | + num_maps: 10
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 32.288 M ops/s       | 38.099 M ops/s (+18.0%)
> |   +- hits latency                       | 30.972 ns/op         | 26.248 ns/op   (-15.3%)
> |   +- important_hits throughput          | 3.229 M ops/s        | 3.810 M ops/s  (+18.0%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 34.473 M ops/s       | 41.145 M ops/s (+19.4%)
> |   +- hits latency                       | 29.010 ns/op         | 24.307 ns/op   (-16.2%)
> |   +- important_hits throughput          | 12.312 M ops/s       | 14.695 M ops/s (+19.4%)
> |
> | + num_maps: 16
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 32.524 M ops/s       | 38.341 M ops/s (+17.9%)
> |   +- hits latency                       | 30.748 ns/op         | 26.083 ns/op   (-15.2%)
> |   +- important_hits throughput          | 2.033 M ops/s        | 2.396 M ops/s  (+17.9%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 34.575 M ops/s       | 41.338 M ops/s (+19.6%)
> |   +- hits latency                       | 28.925 ns/op         | 24.193 ns/op   (-16.4%)
> |   +- important_hits throughput          | 11.001 M ops/s       | 13.153 M ops/s (+19.6%)
> |
> | + num_maps: 17
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 28.861 M ops/s       | 32.756 M ops/s (+13.5%)
> |   +- hits latency                       | 34.649 ns/op         | 30.530 ns/op   (-11.9%)
> |   +- important_hits throughput          | 1.700 M ops/s        | 1.929 M ops/s  (+13.5%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 31.529 M ops/s       | 36.110 M ops/s (+14.5%)
> |   +- hits latency                       | 31.719 ns/op         | 27.697 ns/op   (-12.7%)
> |   +- important_hits throughput          | 9.598 M ops/s        | 10.993 M ops/s (+14.5%)
> |
> | + num_maps: 24
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 18.602 M ops/s       | 19.937 M ops/s (+7.2%)
> |   +- hits latency                       | 53.767 ns/op         | 50.166 ns/op   (-6.7%)
> |   +- important_hits throughput          | 0.776 M ops/s        | 0.831 M ops/s  (+7.2%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 21.718 M ops/s       | 23.332 M ops/s (+7.4%)
> |   +- hits latency                       | 46.047 ns/op         | 42.865 ns/op   (-6.9%)
> |   +- important_hits throughput          | 6.110 M ops/s        | 6.564 M ops/s  (+7.4%)
> |
> | + num_maps: 32
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 14.118 M ops/s       | 14.626 M ops/s (+3.6%)
> |   +- hits latency                       | 70.856 ns/op         | 68.381 ns/op   (-3.5%)
> |   +- important_hits throughput          | 0.442 M ops/s        | 0.458 M ops/s  (+3.6%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 17.111 M ops/s       | 17.906 M ops/s (+4.6%)
> |   +- hits latency                       | 58.451 ns/op         | 55.865 ns/op   (-4.4%)
> |   +- important_hits throughput          | 4.776 M ops/s        | 4.998 M ops/s  (+4.6%)
> |
> | + num_maps: 100
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 5.281 M ops/s        | 5.528 M ops/s  (+4.7%)
> |   +- hits latency                       | 192.398 ns/op        | 183.059 ns/op  (-4.9%)
> |   +- important_hits throughput          | 0.053 M ops/s        | 0.055 M ops/s  (+4.9%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 6.265 M ops/s        | 6.498 M ops/s  (+3.7%)
> |   +- hits latency                       | 161.436 ns/op        | 152.877 ns/op  (-5.3%)
> |   +- important_hits throughput          | 1.636 M ops/s        | 1.697 M ops/s  (+3.7%)
> |
> | + num_maps: 1000
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 0.355 M ops/s        | 0.354 M ops/s  (  ~  )
> |   +- hits latency                       | 2826.538 ns/op       | 2827.139 ns/op (  ~  )
> |   +- important_hits throughput          | 0.000 M ops/s        | 0.000 M ops/s  (  ~  )
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 0.404 M ops/s        | 0.403 M ops/s  (  ~  )
> |   +- hits latency                       | 2481.190 ns/op       | 2487.555 ns/op (  ~  )
> |   +- important_hits throughput          | 0.102 M ops/s        | 0.101 M ops/s  (  ~  )
>
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> ---
> v2:
> * Inline most of bpf_local_storage_lookup(), which produces greater
>    speedup and avoids regressing the cases with large map arrays.
> * Drop "likely()" hint, it didn't produce much benefit.
> * Re-run benchmark and collect 21 trials of results.
> * Remove the on_lookup tests, which no longer work because
>    e.g. bpf_task_storage_delete() no longer does calls to
>    bpf_local_storage_*() helpers.
> ---
>   include/linux/bpf_local_storage.h             | 30 ++++++++++-
>   kernel/bpf/bpf_local_storage.c                | 52 +++++--------------
>   .../bpf/prog_tests/task_local_storage.c       |  6 ---
>   .../selftests/bpf/progs/cgrp_ls_recursion.c   | 26 ----------
>   .../selftests/bpf/progs/task_ls_recursion.c   | 17 ------
>   5 files changed, 41 insertions(+), 90 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 173ec7f43ed1..dcddb0aef7d8 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -129,10 +129,36 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>   			    struct bpf_local_storage_cache *cache,
>   			    bool bpf_ma);
>   
> -struct bpf_local_storage_data *
> +void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
> +				      struct bpf_local_storage_map *smap,
> +				      struct bpf_local_storage_elem *selem);
> +/* If cacheit_lockit is false, this lookup function is lockless */
> +static inline struct bpf_local_storage_data *
>   bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
>   			 struct bpf_local_storage_map *smap,
> -			 bool cacheit_lockit);
> +			 bool cacheit_lockit)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct bpf_local_storage_elem *selem;
> +
> +	/* Fast path (cache hit) */
> +	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
> +				      bpf_rcu_lock_held());
> +	if (sdata && rcu_access_pointer(sdata->smap) == smap)
> +		return sdata;

I think we should focus on fast path (your v1 patch)
and I suppose most production environments
want to hit fast path in most times. In your production environment did
you see more than 16 local storage maps per entity (task/sk/inode)?

In the fast path, the memory accesses are
   two from local_storage->cache[smap->cache_idx] and
   one from sdata->smap
    

> +
> +	/* Slow path (cache miss) */
> +	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
> +				  rcu_read_lock_trace_held())
> +		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
> +			break;

But if we reach slow path here which means we have more than 16 local
storage maps, then traversing the list and getting SDATA(selem)->smap
will be very expensive, in addition to memory accesses in fast path.

I suppose here we mostly care about socket local storage since it is
totally possible for a production workload to have millions of sockets.
To improve performance, fast path should hit in most cases.
If there are too many sk local storage maps, some kind of sharing
can be done so multiple applications might be using a single sk
local storage.

Your above inlining/outlining analysis also show how tricky it is
for compilation optimization. Without profiling, it is totally
possible that compiler might do optimization differently in
the future. So here is my suggestion, let us do inlining
for fast path and focus on performance of fast path.

> +	if (!selem)
> +		return NULL;
> +	if (cacheit_lockit)
> +		__bpf_local_storage_insert_cache(local_storage, smap, selem);
> +	return SDATA(selem);
> +}
>   
>   void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
>   
[...]

