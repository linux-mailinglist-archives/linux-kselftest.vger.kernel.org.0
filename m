Return-Path: <linux-kselftest+bounces-17729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A930F974CB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6DC1C2111B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3514AD2C;
	Wed, 11 Sep 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cxu41kz3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097213E05F;
	Wed, 11 Sep 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043582; cv=none; b=TOZnmY993ER8HDXYJAiV3CDyt2da2wsb74C77b6TmsrlnY+kenu0Yv2uLZKs8jQL1WmhjGnrIFNHoU8RzGqz+QbJE1sEO+5KnDQonxFbVL68G9CI3Pqg6Ijvhb+XjUyMA2Qz6fZngc57ojwr0cdpVmy0kXjU58ZbNVSVEMxgh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043582; c=relaxed/simple;
	bh=znEYItcv+5fj1ZTZXGAMyC07Uv8caAjmdUIwiWR6f5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqlgQku+/TWaiqF97Qn6FVo3wG4T+JQcTiP2x9SvwENnSGjYk8o2aQoTxLu3qNN6nJAnIZgYyAPQ3H9AaLuF6ywrkxBCeI+uLvHLvocWyGNHoO0O6mWGqhE0IoHs1mj8ubmEZE9LHpBGuSr6GuDKpKum+BuPTxPa777StyQASsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cxu41kz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738D2C4CEC5;
	Wed, 11 Sep 2024 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726043582;
	bh=znEYItcv+5fj1ZTZXGAMyC07Uv8caAjmdUIwiWR6f5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cxu41kz33OL28gGQ+gXnJtB6GkXD0858xrcE1IIx8x5cgG51gfwdWOeFYTkt55phG
	 8uZtYLkCiheAkwJvB+AqJXCpNKFIga+rGpPg8N+piaqomNzgSu8ycDwJFZDoFZYe7D
	 lS4/GOA7TENu2p7IZ1Jpnw7BVt/rhdYlD965x5dtS6y9FGhe+CnuM+uRssk/AXXlt5
	 uylkv1jUpz8RKADTsfwlwzNd2j2BLMQ2dVQQinn5oHdAmQLqJWm/vQwDgS8TsxfYod
	 CebMlvWi3Wg98hMo+wbPxd/2DEPvXA1aVOqIxqPr0yNwLNQjphmSVVenSsBfBP6JqV
	 9BrRHbNgmqO5w==
Message-ID: <d6a2da12-6442-4a8e-a5dc-6f8af5a5178c@kernel.org>
Date: Wed, 11 Sep 2024 10:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
To: Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Shuah Khan <shuah@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
 <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
 <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
 <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
 <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com>
 <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
 <8a088e49-2b40-4a04-ae16-57cdddde09bc@app.fastmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <8a088e49-2b40-4a04-ae16-57cdddde09bc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/09/2024 06.43, Daniel Xu wrote:
> [cc Jesper]
> 
> On Tue, Sep 10, 2024, at 8:31 PM, Daniel Xu wrote:
>> On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
>>> On Tue, Sep 10, 2024 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>>>>
>>>> On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
>>>>> On Tue, Sep 10, 2024 at 3:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>>>>>>
[...cut...]

>>> Can you give us a bit more details on what
>>> you are trying to achieve?
>>
>> BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) for each
>> entry in the cpumap. When a prog redirects to an entry in the cpumap,
>> the machinery queues up the xdp frame onto the destination CPU ptr_ring.
>> This can occur on any cpu, thus multi-producer. On processing side,
>> there is only the kthread created by the cpumap entry and bound to the
>> specific cpu that is consuming entries. So single consumer.
>>

An important detail: to get Multi-Producer (MP) to scale the CPUMAP does
bulk enqueue into the ptr_ring.  It stores the xdp_frame's in a per-CPU
array and does the flush/enqueue as part of the xdp_do_flush(). Because
I was afraid of this adding latency, I choose to also flush every 8
frames (CPU_MAP_BULK_SIZE).

Looking at code I see this is also explained in a comment:

/* General idea: XDP packets getting XDP redirected to another CPU,
  * will maximum be stored/queued for one driver ->poll() call.  It is
  * guaranteed that queueing the frame and the flush operation happen on
  * same CPU.  Thus, cpu_map_flush operation can deduct via this_cpu_ptr()
  * which queue in bpf_cpu_map_entry contains packets.
  */


>> Goal is to track the latency overhead added from ptr_ring and the
>> kthread (versus softirq where is less overhead). Ideally we want p50,
>> p90, p95, p99 percentiles.
>>

I'm very interesting in this use-case of understanding the latency of 
CPUMAP.
I'm a fan of latency histograms that I turn into heatmaps in grafana.

>> To do this, we need to track every single entry enqueue time as well as
>> dequeue time - events that occur in the tail are quite important.
>>
>> Since ptr_ring is also a ring buffer, I thought it would be easy,
>> reliable, and fast to just create a "shadow" ring buffer. Every time
>> producer enqueues entries, I'd enqueue the same number of current
>> timestamp onto shadow RB. Same thing on consumer side, except dequeue
>> and calculate timestamp delta.
>>

This idea seems overkill and will likely produce unreliable results.
E.g. the overhead of this additional ring buffer will also affect the
measurements.

>> I was originally planning on writing my own lockless ring buffer in pure
>> BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hoping I
>> could avoid that with this patch.
> 
> [...]
> 
> Alternatively, could add a u64 timestamp to xdp_frame, which makes all
> this tracking inline (and thus more reliable). But I'm not sure how precious
> the space in that struct is - I see some references online saying most drivers
> save 128B headroom. I also see:
> 
>          #define XDP_PACKET_HEADROOM 256
> 

I like the inline idea. I would suggest to add u64 timestamp into 
XDP-metadata area (ctx->data_meta code example[1]) , when XDP runs in 
RX-NAPI.  Then at the remote CPU you can run another CPUMAP-XDP program 
that pickup this timestamp, and then calc a delta from "now" timestamp.


  [1] 
https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/af_xdp_kern.c#L62-L77


> Could probably amortize the timestamp read by setting it in
> bq_flush_to_queue().

To amortize, consider that you might not need to timestamp EVERY packet 
to get sufficient statistics on the latency.

Regarding bq_flush_to_queue() and the enqueue tracepoint:
   trace_xdp_cpumap_enqueue(rcpu->map_id, processed, drops, to_cpu)

I have an idea for you, on how to measure the latency overhead from XDP 
RX-processing to when enqueue "flush" happens.  It is a little tricky to 
explain, so I will outline the steps.

1. XDP bpf_prog store timestamp in per-CPU array,
    unless timestamp is already set.

2. trace_xdp_cpumap_enqueue bpf_prog reads per-CPU timestamp
    and calc latency diff, and clears timestamp.

This measures the latency overhead of bulk enqueue. (Notice: Only the
first XDP redirect frame after a bq_flush_to_queue() will set the
timestamp). This per-CPU store should work as this all runs under same
RX-NAPI "poll" execution.

This latency overhead of bulk enqueue, will (unfortunately) also
count/measure the XDP_PASS packets that gets processed by the normal
netstack.  So, watch out for this. e.g could have XDP actions (e.g
XDP_PASS) counters as part of step 1, and have statistic for cases where
XDP_PASS interfered.


--Jesper



