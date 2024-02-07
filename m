Return-Path: <linux-kselftest+bounces-4205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B171984C1D9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 02:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186872884E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 01:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96142F52;
	Wed,  7 Feb 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P+Occ8Ee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823DD27E
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268983; cv=none; b=bZ8qnz5J3676kAvyyIvsqiR1jlg9LchDAqyyL5Hh0eY8TyHSvOFRM5HrGRg0LpF69cnmU5Z8+ynPEWBZPy0xW1gCdKhQZyH/P2FRIqPtic4ZlQ5ELKKphEzi1QRA8caLqaHVrvRAB3g2Go29fRKCX/Jgh4tNsd+grny5ij+Hx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268983; c=relaxed/simple;
	bh=mXspb4roYWk2XrWglZU0jbBxJY+f98HttK8NYpqCOPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J76O+yq/4bwQ1CxYOGhCp51zaeYYTj7BsIeBFqUSL8ZMevW9GXIf0wPXXByufEAdHg+gTKDboJcBiguBiD5SRO2idjqYXadzLp6tTl8icZJTN30m63AfssIvQqoBqrf2wTcI1aUON5bSHI86ddpqxQX9p9Q+zaEFhoq5DZ/YGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P+Occ8Ee; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9908bdfb-1030-4a9f-8405-3696c5d03981@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707268978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6y56WasfFJQsr8qLV5d2+sZ4nBMU+JuvCGN+RiCB1w=;
	b=P+Occ8Ee386PcZcmFQTZj4f92V3YrDXBxVXpWF/ELnOh4fZWSpBuJQkqmhnP4njpT3T6rY
	L68cQBrIXeurnlasEt/ZaH6rvS8NR5WNPyiyT1ub9lBA485YwOBgj2jfhfEf4pF+Nyc5za
	+49YDOGl9puoM4xZZ7REq9n/hOd58eY=
Date: Tue, 6 Feb 2024 17:22:45 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow
 paths
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240131141858.1149719-1-elver@google.com>
 <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
 <CANpmjNPKACDwXMnZRw9=CAgWNaMWAyFZ2W7KY2s4ck0s_ue1ag@mail.gmail.com>
 <5a08032b-ed4d-4429-b0a9-2736689d8c33@linux.dev>
 <ZcJmok64Xqv6l4ZS@elver.google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZcJmok64Xqv6l4ZS@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/6/24 9:04 AM, Marco Elver wrote:
> On Mon, Feb 05, 2024 at 03:24PM -0800, Martin KaFai Lau wrote:
> [...]
>>> Or can you suggest different functions to hook to for the recursion test?
>>
>> I don't prefer to add another tracepoint for the selftest.
> 
> Ok - I also checked, even though it should be a no-op, it wasn't
> (compiler generated worse code).

I am interested to how the tracepoint generates worse code. Can you share some 
details ?

> 
>> The test in "SEC("fentry/bpf_local_storage_lookup")" is testing that the
>> initial bpf_local_storage_lookup() should work and the immediate recurred
>> bpf_task_storage_delete() will fail.
>>
>> Depends on how the new slow path function will look like in v2. The test can
>> probably be made to go through the slow path, e.g. by creating a lot of task
>> storage maps before triggering the lookup.
> 
> Below is tentative v2, but I'm struggling with fixing up the test. In
> particular, bpf_task_storage_delete() now only calls out to
> migrate_disable/enable() and bpf_selem_unlink(), because the compiler
> just ends up inlining everything it can:
> 
> <bpf_task_storage_delete>:
>     endbr64
>     nopl   0x0(%rax,%rax,1)
>     push   %r14
>     push   %rbx
>     test   %rsi,%rsi
>     je     ffffffff81280015 <bpf_task_storage_delete+0x75>
>     mov    %rsi,%rbx
>     mov    %rdi,%r14
>     call   ffffffff810f2e40 <migrate_disable>
>     incl   %gs:0x7eda9ba5(%rip)        # 29b68 <bpf_task_storage_busy>
>     mov    0xb38(%rbx),%rax
>     mov    $0xfffffffffffffffe,%rbx
>     test   %rax,%rax
>     je     ffffffff8128002f <bpf_task_storage_delete+0x8f>
>     movzwl 0x10e(%r14),%ecx
> 
>     mov    (%rax,%rcx,8),%rdi
>     test   %rdi,%rdi
>     je     ffffffff8127ffef <bpf_task_storage_delete+0x4f>
>     mov    (%rdi),%rcx
>     cmp    %r14,%rcx
>     je     ffffffff81280022 <bpf_task_storage_delete+0x82>
>     mov    0x88(%rax),%rdi
>     test   %rdi,%rdi
>     je     ffffffff8128002f <bpf_task_storage_delete+0x8f>
>     add    $0xfffffffffffffff0,%rdi
>     je     ffffffff8128002f <bpf_task_storage_delete+0x8f>
>     mov    0x40(%rdi),%rax
>     cmp    %r14,%rax
>     je     ffffffff8128001e <bpf_task_storage_delete+0x7e>
>     mov    0x10(%rdi),%rdi
>     test   %rdi,%rdi
>     jne    ffffffff8127fffb <bpf_task_storage_delete+0x5b>
>     jmp    ffffffff8128002f <bpf_task_storage_delete+0x8f>
>     mov    $0xffffffffffffffea,%rbx
>     jmp    ffffffff8128003b <bpf_task_storage_delete+0x9b>
>     add    $0x40,%rdi
>     add    $0xffffffffffffffc0,%rdi
>     xor    %ebx,%ebx
>     xor    %esi,%esi
>     call   ffffffff8127e820 <bpf_selem_unlink>
>     decl   %gs:0x7eda9b32(%rip)        # 29b68 <bpf_task_storage_busy>
>     call   ffffffff810f2ed0 <migrate_enable>
>     mov    %rbx,%rax
>     pop    %rbx
>     pop    %r14
>     cs jmp ffffffff82324ea0 <__x86_return_thunk>
> 
> 
> Could you suggest how we can fix up the tests? I'm a little stuck
> because there's not much we can hook to left.

I don't see a solution either if only the cache insertion code path is in a 
traceable function.

The prog->active counter has already been covered in another test. This test is 
mostly only covering the lookup => delete recur case and the code path is 
contained within the bpf storage logic. The future code review should be able to 
cover. I would make an exception here and remove this test case considering 
anything (e.g. tracepoint) we do here is likely to make it worse. (more on the 
test removal below).

> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Date: Tue, 30 Jan 2024 17:57:45 +0100
> Subject: [PATCH v2] bpf: Allow compiler to inline most of
>   bpf_local_storage_lookup()
> 
> In various performance profiles of kernels with BPF programs attached,
> bpf_local_storage_lookup() appears as a significant portion of CPU
> cycles spent. To enable the compiler generate more optimal code, turn
> bpf_local_storage_lookup() into a static inline function, where only the
> cache insertion code path is outlined (call instruction can be elided
> entirely if cacheit_lockit is a constant expression).

Can you share more why only putting the cache insertion code to a function 
improves the larger number of maps case. In the benchmark, cacheit_lockit should 
always be true and __bpf_local_storage_insert_cache() should always be called.

> 
> Based on results from './benchs/run_bench_local_storage.sh' (21 trials;
> reboot between each trial) this produces improvements in throughput and
> latency in the majority of cases, with an average (geomean) improvement
> of 8%:
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
> ---
> v2:
> * Inline most of bpf_local_storage_lookup(), which produces greater
>    speedup and avoids regressing the cases with large map arrays.
> * Drop "unlikely()" hint, it didn't produce much benefit.
> * Re-run benchmark and collect 21 trials of results.
> ---
>   include/linux/bpf_local_storage.h             | 30 ++++++++++-
>   kernel/bpf/bpf_local_storage.c                | 52 +++++--------------
>   .../selftests/bpf/progs/cgrp_ls_recursion.c   |  2 +-
>   .../selftests/bpf/progs/task_ls_recursion.c   |  2 +-
>   4 files changed, 43 insertions(+), 43 deletions(-)
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
> +
> +	/* Slow path (cache miss) */
> +	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
> +				  rcu_read_lock_trace_held())
> +		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
> +			break;
> +
> +	if (!selem)
> +		return NULL;
> +	if (cacheit_lockit)
> +		__bpf_local_storage_insert_cache(local_storage, smap, selem);
> +	return SDATA(selem);
> +}
>   
>   void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
>   
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 146824cc9689..bdea1a459153 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -414,47 +414,21 @@ void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>   	bpf_selem_unlink_storage(selem, reuse_now);
>   }
>   
> -/* If cacheit_lockit is false, this lookup function is lockless */
> -struct bpf_local_storage_data *
> -bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> -			 struct bpf_local_storage_map *smap,
> -			 bool cacheit_lockit)
> +void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
> +				      struct bpf_local_storage_map *smap,
> +				      struct bpf_local_storage_elem *selem)
>   {
> -	struct bpf_local_storage_data *sdata;
> -	struct bpf_local_storage_elem *selem;
> -
> -	/* Fast path (cache hit) */
> -	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
> -				      bpf_rcu_lock_held());
> -	if (sdata && rcu_access_pointer(sdata->smap) == smap)
> -		return sdata;
> -
> -	/* Slow path (cache miss) */
> -	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
> -				  rcu_read_lock_trace_held())
> -		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
> -			break;
> -
> -	if (!selem)
> -		return NULL;
> -
> -	sdata = SDATA(selem);
> -	if (cacheit_lockit) {
> -		unsigned long flags;
> -
> -		/* spinlock is needed to avoid racing with the
> -		 * parallel delete.  Otherwise, publishing an already
> -		 * deleted sdata to the cache will become a use-after-free
> -		 * problem in the next bpf_local_storage_lookup().
> -		 */
> -		raw_spin_lock_irqsave(&local_storage->lock, flags);
> -		if (selem_linked_to_storage(selem))
> -			rcu_assign_pointer(local_storage->cache[smap->cache_idx],
> -					   sdata);
> -		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> -	}
> +	unsigned long flags;
>   
> -	return sdata;
> +	/* spinlock is needed to avoid racing with the
> +	 * parallel delete.  Otherwise, publishing an already
> +	 * deleted sdata to the cache will become a use-after-free
> +	 * problem in the next bpf_local_storage_lookup().
> +	 */
> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	if (selem_linked_to_storage(selem))
> +		rcu_assign_pointer(local_storage->cache[smap->cache_idx], SDATA(selem));
> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>   }
>   
>   static int check_flags(const struct bpf_local_storage_data *old_sdata,
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> index 610c2427fd93..6e93f3c8b318 100644
> --- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> @@ -33,7 +33,7 @@ static void __on_lookup(struct cgroup *cgrp)
>   	bpf_cgrp_storage_delete(&map_b, cgrp);
>   }
>   
> -SEC("fentry/bpf_local_storage_lookup")
> +SEC("fentry/??????????????????????????") >   int BPF_PROG(on_lookup)

Remove this BPF_PROG.

>   {
>   	struct task_struct *task = bpf_get_current_task_btf();
> diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
> index 4542dc683b44..d73b33a4c153 100644
> --- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
> +++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
> @@ -27,7 +27,7 @@ struct {
>   	__type(value, long);
>   } map_b SEC(".maps");
>   
> -SEC("fentry/bpf_local_storage_lookup")
> +SEC("fentry/??????????????????????????")

Same here. The checks related to on_lookup in prog_tests/task_local_storage.c 
need to be removed also.

>   int BPF_PROG(on_lookup)
>   {
>   	struct task_struct *task = bpf_get_current_task_btf();


