Return-Path: <linux-kselftest+bounces-17806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10A49765E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666F82841B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3F1922CE;
	Thu, 12 Sep 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzyvQb1W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8318F2F6;
	Thu, 12 Sep 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134055; cv=none; b=PDogNG3Sxc5G/drF23G3MT37zbXUZH0Hps9al0SpoviIQlAqkHgzVpGpQItPaxVM+i8Js3shNpvizVkFgUd/1qnyGFqQ9xJFgW+Bzf+imRUpJT32UPH8pKImS5Dbi1FxDH8l3iV0oEIAUxaWtDNVHau2senz/xXnGzRTRA4ZG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134055; c=relaxed/simple;
	bh=rxkvnJoNWkAjgpGfH8K6HloBZ4mqRo6xYQR5tqprdjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0a+nlEvuKr4GzvRtZ4BwWk/FAFiVZ8moBMkCzKhX/JFSUb5+N0OW6quiOcoER71nw88CEqBNsIUwEVm+6ZS+G3dLtcpLVa4RXOUXAGcFQS7ozJkSBqALzpjuVnKqPT+aI3WKunH6oELfXwzI9d8n5QqTmXk9ht6kb6YAhvuLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzyvQb1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89630C4CEC3;
	Thu, 12 Sep 2024 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726134054;
	bh=rxkvnJoNWkAjgpGfH8K6HloBZ4mqRo6xYQR5tqprdjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZzyvQb1WXexx0y/yzP7Y7QrzJWURGDmEQ3AcxkqJJlE1rp9oBQ6FapK4Eu5Vj26Js
	 AfEF4kS87Bju5AVqR6W4DPjmkR0nvu1xrD23fAUM0OMTrpnD+4nFEu/U3Hl8QXcomv
	 nmKSOiIRok0ExxGQrE95JDK3ndKHWUDxXGKDDAP/XGt4B+/j54JTgPTKGl0ZNDknOs
	 supXFeqgW23Lv0GGk4eq2/Z3BJjYRdQ8ZDk2YiNoutyNktOpmjeQchClMnKeFlPukD
	 oX3B5AATWmJoxcKi8ML+fCvRKQgIb+CEfy9fAaqu51TcuIfmHUxc2aAp0ZNc/Rf9A0
	 3EhiVW/013BoQ==
Message-ID: <e0321fe6-da0e-4745-b23c-24bb2b02613d@kernel.org>
Date: Thu, 12 Sep 2024 11:40:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: CPUMAP latency metrics (was: [PATCH bpf-next] bpf: ringbuf: Support
 consuming BPF_MAP_TYPE_RINGBUF from prog)
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 Kernel Team <kernel-team@meta.com>, kernel-team <kernel-team@cloudflare.com>
References: <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
 <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
 <CAEf4BzbHqKD87KTSmFUMokXEaAa70xNs96QqfWBHjFbuE5PL=w@mail.gmail.com>
 <rsdwvah5ov3itchsgkwgleihswoycoal5vjbeql2wbqoz5noiz@myk2atnnjaub>
 <CAEf4BzbKoyja2ErsusUcK8YaS1Rqm0VmBzwsNtQtM1-XHDhD7g@mail.gmail.com>
 <cz7qwrujjiunv3yydkfamfm5mkis5xdy4vg4odwatchjoaoolk@zzithxrzdxkv>
 <8a088e49-2b40-4a04-ae16-57cdddde09bc@app.fastmail.com>
 <d6a2da12-6442-4a8e-a5dc-6f8af5a5178c@kernel.org>
 <oq2gfokp7godtkvkedod2ixpw3m6qfnhohaiy7sz4pq7pbkitl@eiqkz2tzrxc3>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <oq2gfokp7godtkvkedod2ixpw3m6qfnhohaiy7sz4pq7pbkitl@eiqkz2tzrxc3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/09/2024 20.53, Daniel Xu wrote:
> On Wed, Sep 11, 2024 at 10:32:56AM GMT, Jesper Dangaard Brouer wrote:
>>
>>
>> On 11/09/2024 06.43, Daniel Xu wrote:
>>> [cc Jesper]
>>>
>>> On Tue, Sep 10, 2024, at 8:31 PM, Daniel Xu wrote:
>>>> On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
>>>>> On Tue, Sep 10, 2024 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>>>>>>
>>>>>> On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
>>>>>>> On Tue, Sep 10, 2024 at 3:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>>>>>>>>
>> [...cut...]
>>
>>>>> Can you give us a bit more details on what
>>>>> you are trying to achieve?
>>>>
>>>> BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) for each
>>>> entry in the cpumap. When a prog redirects to an entry in the cpumap,
>>>> the machinery queues up the xdp frame onto the destination CPU ptr_ring.
>>>> This can occur on any cpu, thus multi-producer. On processing side,
>>>> there is only the kthread created by the cpumap entry and bound to the
>>>> specific cpu that is consuming entries. So single consumer.
>>>>
>>
>> An important detail: to get Multi-Producer (MP) to scale the CPUMAP does
>> bulk enqueue into the ptr_ring.  It stores the xdp_frame's in a per-CPU
>> array and does the flush/enqueue as part of the xdp_do_flush(). Because
>> I was afraid of this adding latency, I choose to also flush every 8
>> frames (CPU_MAP_BULK_SIZE).
>>
>> Looking at code I see this is also explained in a comment:
>>
>> /* General idea: XDP packets getting XDP redirected to another CPU,
>>   * will maximum be stored/queued for one driver ->poll() call.  It is
>>   * guaranteed that queueing the frame and the flush operation happen on
>>   * same CPU.  Thus, cpu_map_flush operation can deduct via this_cpu_ptr()
>>   * which queue in bpf_cpu_map_entry contains packets.
>>   */
>>
>>
>>>> Goal is to track the latency overhead added from ptr_ring and the
>>>> kthread (versus softirq where is less overhead). Ideally we want p50,
>>>> p90, p95, p99 percentiles.
>>>>
>>
>> I'm very interesting in this use-case of understanding the latency of
>> CPUMAP.
>> I'm a fan of latency histograms that I turn into heatmaps in grafana.
>>
>>>> To do this, we need to track every single entry enqueue time as well as
>>>> dequeue time - events that occur in the tail are quite important.
>>>>
>>>> Since ptr_ring is also a ring buffer, I thought it would be easy,
>>>> reliable, and fast to just create a "shadow" ring buffer. Every time
>>>> producer enqueues entries, I'd enqueue the same number of current
>>>> timestamp onto shadow RB. Same thing on consumer side, except dequeue
>>>> and calculate timestamp delta.
>>>>
>>
>> This idea seems overkill and will likely produce unreliable results.
>> E.g. the overhead of this additional ring buffer will also affect the
>> measurements.
> 
> Yeah, good point.
> 
>>
>>>> I was originally planning on writing my own lockless ring buffer in pure
>>>> BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hoping I
>>>> could avoid that with this patch.
>>>
>>> [...]
>>>
>>> Alternatively, could add a u64 timestamp to xdp_frame, which makes all
>>> this tracking inline (and thus more reliable). But I'm not sure how precious
>>> the space in that struct is - I see some references online saying most drivers
>>> save 128B headroom. I also see:
>>>
>>>           #define XDP_PACKET_HEADROOM 256
>>>
>>
>> I like the inline idea. I would suggest to add u64 timestamp into
>> XDP-metadata area (ctx->data_meta code example[1]) , when XDP runs in
>> RX-NAPI.  Then at the remote CPU you can run another CPUMAP-XDP program that
>> pickup this timestamp, and then calc a delta from "now" timestamp.
>>
>>
>>   [1] https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/af_xdp_kern.c#L62-L77
> 
> Cool! This is a much better idea than mine :)
> 
> I'll give this a try.
> 
>>
>>
>>> Could probably amortize the timestamp read by setting it in
>>> bq_flush_to_queue().
>>
>> To amortize, consider that you might not need to timestamp EVERY packet to
>> get sufficient statistics on the latency.
>>
>> Regarding bq_flush_to_queue() and the enqueue tracepoint:
>>    trace_xdp_cpumap_enqueue(rcpu->map_id, processed, drops, to_cpu)
>>
>> I have an idea for you, on how to measure the latency overhead from XDP
>> RX-processing to when enqueue "flush" happens.  It is a little tricky to
>> explain, so I will outline the steps.
>>
>> 1. XDP bpf_prog store timestamp in per-CPU array,
>>     unless timestamp is already set.
>>
>> 2. trace_xdp_cpumap_enqueue bpf_prog reads per-CPU timestamp
>>     and calc latency diff, and clears timestamp.
>>
>> This measures the latency overhead of bulk enqueue. (Notice: Only the
>> first XDP redirect frame after a bq_flush_to_queue() will set the
>> timestamp). This per-CPU store should work as this all runs under same
>> RX-NAPI "poll" execution.
> 
> Makes sense to me. This breaks down the latency even further. I'll keep
> it in mind if we need further troubleshooting.
> 

Yes, this breaks down the latency even further :-)

>> This latency overhead of bulk enqueue, will (unfortunately) also
>> count/measure the XDP_PASS packets that gets processed by the normal
>> netstack.  So, watch out for this. e.g could have XDP actions (e.g
>> XDP_PASS) counters as part of step 1, and have statistic for cases where
>> XDP_PASS interfered.
> 
> Not sure I got this. If we only set the percpu timestamp for
> XDP_REDIRECT frames, then I don't see how XDP_PASS interferes. Maybe I
> misunderstand something.
> 

Not quite. You only set timestamp for the first XDP_REDIRECT frames.
I'm simply saying, all the packets processed *after* this timestamp will
attribute to the time it takes until trace_xdp_cpumap_enqueue() runs.
That part should be obvious.  Then, I'm saying remember that an XDP_PASS
packet takes more time than a XDP_REDIRECT packet.  I hope this makes it
more clear. Point: This is a pitfall you need to be aware of when
looking at your metrics.

For the inline timestamping same pitfall actually applies. There you
timestamp the packets themselves.  Because the CPUMAP enqueue happens as
the *LAST* thing in NAPI loop, during xdp_do_flush() call. This means
that interleaved normal netstack (XDP_PASS) packets will be processed
BEFORE this call to xdp_do_flush().  As noted earlier, to compensate for
this effect, code will enqueue-flush every 8 frames (CPU_MAP_BULK_SIZE).

I hope, I've not confused you more :-|

--Jesper

