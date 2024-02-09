Return-Path: <linux-kselftest+bounces-4376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73684EE4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 01:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011FB1F28402
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066437B;
	Fri,  9 Feb 2024 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ew7zQWmo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843336C
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437920; cv=none; b=uJQQjcLRNV8AK79uGkDaPtrQdN7zqjpRStS01tV/0RZaeFjYu/zHJkJCS7jvqHxRXlVtpHsJi2m5DmGCMBMooGPzTFWj7B8Ej7TLj7W83CONYpO7ePlzfsXq5LjcKHFnwQjvFuurzzSp1ecaJcREGmiJIpYWBQatN7FFggVN3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437920; c=relaxed/simple;
	bh=WSKKcCTNo33PK/GjpGVwGWUUqvnhTnmI86MQGGvy5YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxcZD52r6ofPxTYlDDVT3N4VbgNCpQGuxNJiO3dEak/MY4DCkkdggH0ADha0GJVEJ32KgfBMTSA7aKrbkMBC+k5wKVDnaG5UnkVHeht4HgZZGOF4Vzw5ueJx6+yM08Z689H6IJLAL2XPznOggyA8pSgAzWfviIxe2UkeQKBpNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ew7zQWmo; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a35341e-770e-459c-99e6-8aa490dabad2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707437915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTm0Q3xWkDqifmugUw7mxYO7aENOaaBKIR28JygQ+dg=;
	b=ew7zQWmoiJhteMwuZc0n8wVNXKu2ZE/lvm2DgD9fVYguTggAb6e7H0sya5DP1aug1EoY6X
	69QOA2xw1vR+h6sKySeU+DoNt+CyVFoZ0WVdl17YviptitZ1SosMbTyz5P/jRC1Rz6HPt/
	CIL1QNvQgQWz0tiegF4dA8m2M905Des=
Date: Thu, 8 Feb 2024 16:18:26 -0800
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
 <289242c3-052b-436d-8c7c-b0fa5ae45bce@linux.dev>
 <CANpmjNMGW3zTGOn_69=+KjE4Txik8aQBbdefeo0GuVOkqjgV6Q@mail.gmail.com>
 <ZcSy49GKt3EWIdbK@elver.google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZcSy49GKt3EWIdbK@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 2:54 AM, Marco Elver wrote:
> On Thu, Feb 08, 2024 at 08:37AM +0100, Marco Elver wrote:
>> On Thu, 8 Feb 2024 at 00:58, Yonghong Song <yonghong.song@linux.dev> wrote:
>>> On 2/7/24 4:26 AM, Marco Elver wrote:
>>>> In various performance profiles of kernels with BPF programs attached,
>>>> bpf_local_storage_lookup() appears as a significant portion of CPU
>>>> cycles spent. To enable the compiler generate more optimal code, turn
>>>> bpf_local_storage_lookup() into a static inline function, where only the
>>>> cache insertion code path is outlined
>>>>
>>>> Notably, outlining cache insertion helps avoid bloating callers by
>>>> duplicating setting up calls to raw_spin_{lock,unlock}_irqsave() (on
>>>> architectures which do not inline spin_lock/unlock, such as x86), which
>>>> would cause the compiler produce worse code by deciding to outline
>>>> otherwise inlinable functions. The call overhead is neutral, because we
>>>> make 2 calls either way: either calling raw_spin_lock_irqsave() and
>>>> raw_spin_unlock_irqsave(); or call __bpf_local_storage_insert_cache(),
>>>> which calls raw_spin_lock_irqsave(), followed by a tail-call to
>>>> raw_spin_unlock_irqsave() where the compiler can perform TCO and (in
>>>> optimized uninstrumented builds) turns it into a plain jump. The call to
>>>> __bpf_local_storage_insert_cache() can be elided entirely if
>>>> cacheit_lockit is a false constant expression.
>>>>
>>>> Based on results from './benchs/run_bench_local_storage.sh' (21 trials,
>>>> reboot between each trial; x86 defconfig + BPF, clang 16) this produces
>>>> improvements in throughput and latency in the majority of cases, with an
>>>> average (geomean) improvement of 8%:
>> [...]
>>>>    include/linux/bpf_local_storage.h             | 30 ++++++++++-
>>>>    kernel/bpf/bpf_local_storage.c                | 52 +++++--------------
>>>>    .../bpf/prog_tests/task_local_storage.c       |  6 ---
>>>>    .../selftests/bpf/progs/cgrp_ls_recursion.c   | 26 ----------
>>>>    .../selftests/bpf/progs/task_ls_recursion.c   | 17 ------
>>>>    5 files changed, 41 insertions(+), 90 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
>>>> index 173ec7f43ed1..dcddb0aef7d8 100644
>>>> --- a/include/linux/bpf_local_storage.h
>>>> +++ b/include/linux/bpf_local_storage.h
>>>> @@ -129,10 +129,36 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>>>>                            struct bpf_local_storage_cache *cache,
>>>>                            bool bpf_ma);
>>>>
>>>> -struct bpf_local_storage_data *
>>>> +void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
>>>> +                                   struct bpf_local_storage_map *smap,
>>>> +                                   struct bpf_local_storage_elem *selem);
>>>> +/* If cacheit_lockit is false, this lookup function is lockless */
>>>> +static inline struct bpf_local_storage_data *
>>>>    bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
>>>>                         struct bpf_local_storage_map *smap,
>>>> -                      bool cacheit_lockit);
>>>> +                      bool cacheit_lockit)
>>>> +{
>>>> +     struct bpf_local_storage_data *sdata;
>>>> +     struct bpf_local_storage_elem *selem;
>>>> +
>>>> +     /* Fast path (cache hit) */
>>>> +     sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
>>>> +                                   bpf_rcu_lock_held());
>>>> +     if (sdata && rcu_access_pointer(sdata->smap) == smap)
>>>> +             return sdata;
>>> I think we should focus on fast path (your v1 patch)
>>> and I suppose most production environments
>>> want to hit fast path in most times. In your production environment did
>>> you see more than 16 local storage maps per entity (task/sk/inode)?
>> I think having more than 16 local storage maps isn't entirely unlikely
>> as eBPF usage grows. But at the moment, it should be rare.
>>
>>> In the fast path, the memory accesses are
>>>     two from local_storage->cache[smap->cache_idx] and
>>>     one from sdata->smap
>>>
>>>
>>>> +
>>>> +     /* Slow path (cache miss) */
>>>> +     hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
>>>> +                               rcu_read_lock_trace_held())
>>>> +             if (rcu_access_pointer(SDATA(selem)->smap) == smap)
>>>> +                     break;
>>> But if we reach slow path here which means we have more than 16 local
>>> storage maps, then traversing the list and getting SDATA(selem)->smap
>>> will be very expensive, in addition to memory accesses in fast path.
>>>
>>> I suppose here we mostly care about socket local storage since it is
>>> totally possible for a production workload to have millions of sockets.
>>> To improve performance, fast path should hit in most cases.
>>> If there are too many sk local storage maps, some kind of sharing
>>> can be done so multiple applications might be using a single sk
>>> local storage.
>>>
>>> Your above inlining/outlining analysis also show how tricky it is
>>> for compilation optimization. Without profiling, it is totally
>>> possible that compiler might do optimization differently in
>>> the future.
>> Sure, but it's usually the case that we have to help the compiler a
>> little to produce more optimal code - if the compiler becomes stupid
>> in future, we need either fix the compiler or help it some more.
>>
>>> So here is my suggestion, let us do inlining
>>> for fast path and focus on performance of fast path.
>> The slow-path (iterate list w/o cache insertion) is still relatively
>> small (it's a pointer-chasing loop and a compare), and I decided that
>> it can be justified inlining it. Martin asked in v1 why there were
>> slowdowns above 16 local maps, and I analyzed, and concluded that
>> inlining most is needed to fix and does not hurt performance: in fact,
>> the current version is better than v1 in all cases (even for 16 maps
>> or below).
>>
>> Let me know which version you prefer, and I'll change it. However,
>> based on the results, I would prefer the current version.

I compared asm code between v1 and v2. In bpf_local_storage_update(),
bpf_local_storage_lookup() is called twice with cacheit_lockit == false.
Fully inlining bpf_local_storage_lookup() in bpf_local_storage_update()
should generate better code compared to v1.

So let us do v2.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> FTR, these were the results going from v1 (before) -> v2 (after):
>
> +---- Local Storage ----------------------
> |
> | + num_maps: 1
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 38.593 M ops/s       | 39.068 M ops/s (+1.2%)
> |   +- hits latency                       | 25.913 ns/op         | 25.598 ns/op   (-1.2%)
> |   +- important_hits throughput          | 38.593 M ops/s       | 39.068 M ops/s (+1.2%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 44.406 M ops/s       | 44.926 M ops/s (+1.2%)
> |   +- hits latency                       | 22.521 ns/op         | 22.259 ns/op   (-1.2%)
> |   +- important_hits throughput          | 44.406 M ops/s       | 44.926 M ops/s (+1.2%)
> |
> | + num_maps: 10
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 37.583 M ops/s       | 38.099 M ops/s (+1.4%)
> |   +- hits latency                       | 26.609 ns/op         | 26.248 ns/op   (-1.4%)
> |   +- important_hits throughput          | 3.758 M ops/s        | 3.810 M ops/s  (+1.4%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 40.698 M ops/s       | 41.145 M ops/s (+1.1%)
> |   +- hits latency                       | 24.573 ns/op         | 24.307 ns/op   (-1.1%)
> |   +- important_hits throughput          | 14.535 M ops/s       | 14.695 M ops/s (+1.1%)
> |
> | + num_maps: 16
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 38.061 M ops/s       | 38.341 M ops/s (  ~  )
> |   +- hits latency                       | 26.275 ns/op         | 26.083 ns/op   (  ~  )
> |   +- important_hits throughput          | 2.379 M ops/s        | 2.396 M ops/s  (  ~  )
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 40.890 M ops/s       | 41.338 M ops/s (+1.1%)
> |   +- hits latency                       | 24.458 ns/op         | 24.193 ns/op   (-1.1%)
> |   +- important_hits throughput          | 13.010 M ops/s       | 13.153 M ops/s (+1.1%)
> |
> | + num_maps: 17
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 31.799 M ops/s       | 32.756 M ops/s (+3.0%)
> |   +- hits latency                       | 31.448 ns/op         | 30.530 ns/op   (-2.9%)
> |   +- important_hits throughput          | 1.873 M ops/s        | 1.929 M ops/s  (+3.0%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 35.284 M ops/s       | 36.110 M ops/s (+2.3%)
> |   +- hits latency                       | 28.343 ns/op         | 27.697 ns/op   (-2.3%)
> |   +- important_hits throughput          | 10.742 M ops/s       | 10.993 M ops/s (+2.3%)
> |
> | + num_maps: 24
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 17.947 M ops/s       | 19.937 M ops/s (+11.1%)
> |   +- hits latency                       | 55.725 ns/op         | 50.166 ns/op   (-10.0%)
> |   +- important_hits throughput          | 0.748 M ops/s        | 0.831 M ops/s  (+11.1%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 21.379 M ops/s       | 23.332 M ops/s (+9.1%)
> |   +- hits latency                       | 46.775 ns/op         | 42.865 ns/op   (-8.4%)
> |   +- important_hits throughput          | 6.014 M ops/s        | 6.564 M ops/s  (+9.1%)
> |
> | + num_maps: 32
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 13.279 M ops/s       | 14.626 M ops/s (+10.1%)
> |   +- hits latency                       | 75.317 ns/op         | 68.381 ns/op   (-9.2%)
> |   +- important_hits throughput          | 0.416 M ops/s        | 0.458 M ops/s  (+10.2%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 16.444 M ops/s       | 17.906 M ops/s (+8.9%)
> |   +- hits latency                       | 60.816 ns/op         | 55.865 ns/op   (-8.1%)
> |   +- important_hits throughput          | 4.590 M ops/s        | 4.998 M ops/s  (+8.9%)
> |
> | + num_maps: 100
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 4.912 M ops/s        | 5.528 M ops/s  (+12.5%)
> |   +- hits latency                       | 207.291 ns/op        | 183.059 ns/op  (-11.7%)
> |   +- important_hits throughput          | 0.049 M ops/s        | 0.055 M ops/s  (+12.7%)
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 6.039 M ops/s        | 6.498 M ops/s  (+7.6%)
> |   +- hits latency                       | 167.325 ns/op        | 152.877 ns/op  (-8.6%)
> |   +- important_hits throughput          | 1.577 M ops/s        | 1.697 M ops/s  (+7.6%)
> |
> | + num_maps: 1000
> | :                                         <before>             | <after>
> | +-+ local_storage cache sequential get  +----------------------+----------------------
> |   +- hits throughput                    | 0.342 M ops/s        | 0.354 M ops/s  (+3.6%)
> |   +- hits latency                       | 2930.550 ns/op       | 2827.139 ns/op (-3.5%)
> |   +- important_hits throughput          | 0.000 M ops/s        | 0.000 M ops/s  (  ~  )
> | :
> | :                                         <before>             | <after>
> | +-+ local_storage cache interleaved get +----------------------+----------------------
> |   +- hits throughput                    | 0.413 M ops/s        | 0.403 M ops/s  (-2.5%)
> |   +- hits latency                       | 2427.830 ns/op       | 2487.555 ns/op (+2.5%)
> |   +- important_hits throughput          | 0.104 M ops/s        | 0.101 M ops/s  (-2.6%)
> |
> | Geomean:
> | hits throughput: 102.93%
> | hits latency: 97.11%
> | important_hits throughput: 102.77%

