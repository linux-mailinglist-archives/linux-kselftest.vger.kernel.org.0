Return-Path: <linux-kselftest+bounces-17909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E19776C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA4A1C213E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C784D2C;
	Fri, 13 Sep 2024 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HVD6+9Ob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHBLvzLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB329AF;
	Fri, 13 Sep 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726193784; cv=none; b=Pi8vYiQr/LBHae1A2TuVqA/iz0316fcQfxyMLnH1dGMwopoOwsgpWYpL43dI+bfiM9cw152d9gr3mvs2mtaXK+FGYkLavMf++ob68LWkBkIHuBHQy2vC+HKcZZyyCgYVlG6hU96t3es12MFuE8CI6t33hwL3CCDsAWpf3Zj4VN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726193784; c=relaxed/simple;
	bh=z2bgUwreTcCy9UvliSVJMAMr5MNONPwWBUIFjx1AOrw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lX2vgHq04Dnwt0orldjSGGvshBQXJGADF8WEiko9IDVTRLZorsMq+6Z2UCqRz7EJITI8HjwSP1hK8zxarRjCVt2yPCdCejQsg5tmKrUgGMd2e+4THHnTxrZEI/jD11kOeMkoEhgK0zXG7EfjAd24o0zhnrqLv/6xvWFR4kUMUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HVD6+9Ob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHBLvzLm; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id C42A1200260;
	Thu, 12 Sep 2024 22:16:20 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Thu, 12 Sep 2024 22:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726193780;
	 x=1726200980; bh=a4A37gvGur/1SunFrHaz/UbHtm67mSj10Iif1cXizD0=; b=
	HVD6+9ObGFu9ITpTPxgDFpgUhYwl309blDUkWevFcw2rjiyUcZ3Mzic76vnb9Zef
	guNCorIlHk84nEozks8KCrHHDxP0+AsxULHKXxysIsf6aBVDwjs+QVk/C+FIMdKn
	7WibSqcTPMamYUqbwM0msWel0XZW/6cgYJ96eMNwSAL97+ViHHv0csH/bkstvlXO
	/xrLlm6UACA8JzQGu4cDRpvFLKQLCr87nDfZoTSZWYDsTRiyeTbiA474K4kFgv2b
	IvXap/BJGJlqu8ApGMPK9k4yrIZ3tAK1i6xyjGwlKCBL0WwNhatCJIukRnfYnXf4
	XrhBsx9uD/m9m5VfTH1M1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726193780; x=
	1726200980; bh=a4A37gvGur/1SunFrHaz/UbHtm67mSj10Iif1cXizD0=; b=B
	HBLvzLmulc6SN7tpGNND/bXHMY3Q5yigWedC6lV4yBM98uDrQT3tNCXTbIaqPLi4
	CV1BBIm/UIwlD0ResivqM/afAaRMynrqBwBJm5pGJd4U5YheecP6VBEzCErXJS5J
	6KGZpBK7SV+kmGHR+NKSAxI+zGAt+EfDSW4Zw+ERv9fFv8VWhliAPhtENMOiCt1z
	9/4i2+Ve/XJePu+YPBHvL6PsVkWc/Xw4v/VXfpHRy4D3JgTQns/7aOg70dg3J6ld
	UpgCIR4k7UUlRwwNlxBPbx7KMLB/6AsXV2GHLZ+9h8Zbz26AHwp/KMr/8u3xd/mW
	7uebu97Xg5P9QjzQPKoMw==
X-ME-Sender: <xms:dKDjZpyIhuUx-v-4OqQrALadh3MGyf39yCChYaplW7JIGLvkUyEAiQ>
    <xme:dKDjZpRuyhh72N40FYlQWbDeruabvVjNlUUL5QBP9-oWeMlH5cmotogp7DdJTVZwn
    wpEdupzIYPxA8CcSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgjfhfu
    tgfgsehtqhertdertdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieekudevieffkeevffeihefhtdff
    tdevteejfeeiveevffevveduteekffffleelnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhestghlohhuughflhgrrhgvrdgt
    ohhmpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohepshgufh
    esfhhomhhitghhvghvrdhmvgdprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhi
    thhovhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprh
    gtphhtthhopehhrgholhhuohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhi
    vghlsehiohhgvggrrhgsohigrdhnvght
X-ME-Proxy: <xmx:dKDjZjVlWq3TUczPBGouHoeka1Utrs4r6_mqBMo4vHfPVVz7R9PTMA>
    <xmx:dKDjZrghKo4pHhULxu71vHesY36MTm3EBWyw9-FHRBBGm_m_dBfwvw>
    <xmx:dKDjZrBvH0SKrDSKQH414TsuFMW3y8VLNsagyAyFCxaMwmZCLVkQYA>
    <xmx:dKDjZkJK4VbM-A9RSHOoI3-5jCbVEyrKToblsyqhHW8v9wUzkBRuIQ>
    <xmx:dKDjZj7BFs97VN6S5E7OtOVmpbWtj-B7WKbcwX18XVnNZi05v1DsfU64>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E988718A0065; Thu, 12 Sep 2024 22:16:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Sep 2024 19:15:59 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Jesper Dangaard Brouer" <hawk@kernel.org>
Cc: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Kernel Team" <kernel-team@meta.com>,
 kernel-team <kernel-team@cloudflare.com>
Message-Id: <4c9e00be-8c48-4a3b-a50d-79ef47740c99@app.fastmail.com>
In-Reply-To: <e0321fe6-da0e-4745-b23c-24bb2b02613d@kernel.org>
References: 
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
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
 <e0321fe6-da0e-4745-b23c-24bb2b02613d@kernel.org>
Subject: Re: CPUMAP latency metrics (was: [PATCH bpf-next] bpf: ringbuf: Support
 consuming BPF_MAP_TYPE_RINGBUF from prog)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Sep 12, 2024, at 2:40 AM, Jesper Dangaard Brouer wrote:
> On 11/09/2024 20.53, Daniel Xu wrote:
>> On Wed, Sep 11, 2024 at 10:32:56AM GMT, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 11/09/2024 06.43, Daniel Xu wrote:
>>>> [cc Jesper]
>>>>
>>>> On Tue, Sep 10, 2024, at 8:31 PM, Daniel Xu wrote:
>>>>> On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
>>>>>> On Tue, Sep 10, 2024 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz>=
 wrote:
>>>>>>>
>>>>>>> On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
>>>>>>>> On Tue, Sep 10, 2024 at 3:16=E2=80=AFPM Daniel Xu <dxu@dxuuu.xy=
z> wrote:
>>>>>>>>>
>>> [...cut...]
>>>
>>>>>> Can you give us a bit more details on what
>>>>>> you are trying to achieve?
>>>>>
>>>>> BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) fo=
r each
>>>>> entry in the cpumap. When a prog redirects to an entry in the cpum=
ap,
>>>>> the machinery queues up the xdp frame onto the destination CPU ptr=
_ring.
>>>>> This can occur on any cpu, thus multi-producer. On processing side,
>>>>> there is only the kthread created by the cpumap entry and bound to=
 the
>>>>> specific cpu that is consuming entries. So single consumer.
>>>>>
>>>
>>> An important detail: to get Multi-Producer (MP) to scale the CPUMAP =
does
>>> bulk enqueue into the ptr_ring.  It stores the xdp_frame's in a per-=
CPU
>>> array and does the flush/enqueue as part of the xdp_do_flush(). Beca=
use
>>> I was afraid of this adding latency, I choose to also flush every 8
>>> frames (CPU_MAP_BULK_SIZE).
>>>
>>> Looking at code I see this is also explained in a comment:
>>>
>>> /* General idea: XDP packets getting XDP redirected to another CPU,
>>>   * will maximum be stored/queued for one driver ->poll() call.  It =
is
>>>   * guaranteed that queueing the frame and the flush operation happe=
n on
>>>   * same CPU.  Thus, cpu_map_flush operation can deduct via this_cpu=
_ptr()
>>>   * which queue in bpf_cpu_map_entry contains packets.
>>>   */
>>>
>>>
>>>>> Goal is to track the latency overhead added from ptr_ring and the
>>>>> kthread (versus softirq where is less overhead). Ideally we want p=
50,
>>>>> p90, p95, p99 percentiles.
>>>>>
>>>
>>> I'm very interesting in this use-case of understanding the latency of
>>> CPUMAP.
>>> I'm a fan of latency histograms that I turn into heatmaps in grafana.
>>>
>>>>> To do this, we need to track every single entry enqueue time as we=
ll as
>>>>> dequeue time - events that occur in the tail are quite important.
>>>>>
>>>>> Since ptr_ring is also a ring buffer, I thought it would be easy,
>>>>> reliable, and fast to just create a "shadow" ring buffer. Every ti=
me
>>>>> producer enqueues entries, I'd enqueue the same number of current
>>>>> timestamp onto shadow RB. Same thing on consumer side, except dequ=
eue
>>>>> and calculate timestamp delta.
>>>>>
>>>
>>> This idea seems overkill and will likely produce unreliable results.
>>> E.g. the overhead of this additional ring buffer will also affect the
>>> measurements.
>>=20
>> Yeah, good point.
>>=20
>>>
>>>>> I was originally planning on writing my own lockless ring buffer i=
n pure
>>>>> BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hopi=
ng I
>>>>> could avoid that with this patch.
>>>>
>>>> [...]
>>>>
>>>> Alternatively, could add a u64 timestamp to xdp_frame, which makes =
all
>>>> this tracking inline (and thus more reliable). But I'm not sure how=
 precious
>>>> the space in that struct is - I see some references online saying m=
ost drivers
>>>> save 128B headroom. I also see:
>>>>
>>>>           #define XDP_PACKET_HEADROOM 256
>>>>
>>>
>>> I like the inline idea. I would suggest to add u64 timestamp into
>>> XDP-metadata area (ctx->data_meta code example[1]) , when XDP runs in
>>> RX-NAPI.  Then at the remote CPU you can run another CPUMAP-XDP prog=
ram that
>>> pickup this timestamp, and then calc a delta from "now" timestamp.
>>>
>>>
>>>   [1] https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP=
-interaction/af_xdp_kern.c#L62-L77
>>=20
>> Cool! This is a much better idea than mine :)
>>=20
>> I'll give this a try.
>>=20
>>>
>>>
>>>> Could probably amortize the timestamp read by setting it in
>>>> bq_flush_to_queue().
>>>
>>> To amortize, consider that you might not need to timestamp EVERY pac=
ket to
>>> get sufficient statistics on the latency.
>>>
>>> Regarding bq_flush_to_queue() and the enqueue tracepoint:
>>>    trace_xdp_cpumap_enqueue(rcpu->map_id, processed, drops, to_cpu)
>>>
>>> I have an idea for you, on how to measure the latency overhead from =
XDP
>>> RX-processing to when enqueue "flush" happens.  It is a little trick=
y to
>>> explain, so I will outline the steps.
>>>
>>> 1. XDP bpf_prog store timestamp in per-CPU array,
>>>     unless timestamp is already set.
>>>
>>> 2. trace_xdp_cpumap_enqueue bpf_prog reads per-CPU timestamp
>>>     and calc latency diff, and clears timestamp.
>>>
>>> This measures the latency overhead of bulk enqueue. (Notice: Only the
>>> first XDP redirect frame after a bq_flush_to_queue() will set the
>>> timestamp). This per-CPU store should work as this all runs under sa=
me
>>> RX-NAPI "poll" execution.
>>=20
>> Makes sense to me. This breaks down the latency even further. I'll ke=
ep
>> it in mind if we need further troubleshooting.
>>=20
>
> Yes, this breaks down the latency even further :-)
>
>>> This latency overhead of bulk enqueue, will (unfortunately) also
>>> count/measure the XDP_PASS packets that gets processed by the normal
>>> netstack.  So, watch out for this. e.g could have XDP actions (e.g
>>> XDP_PASS) counters as part of step 1, and have statistic for cases w=
here
>>> XDP_PASS interfered.
>>=20
>> Not sure I got this. If we only set the percpu timestamp for
>> XDP_REDIRECT frames, then I don't see how XDP_PASS interferes. Maybe I
>> misunderstand something.
>>=20
>
> Not quite. You only set timestamp for the first XDP_REDIRECT frames.
> I'm simply saying, all the packets processed *after* this timestamp wi=
ll
> attribute to the time it takes until trace_xdp_cpumap_enqueue() runs.
> That part should be obvious.  Then, I'm saying remember that an XDP_PA=
SS
> packet takes more time than a XDP_REDIRECT packet.  I hope this makes =
it
> more clear. Point: This is a pitfall you need to be aware of when
> looking at your metrics.
>
> For the inline timestamping same pitfall actually applies. There you
> timestamp the packets themselves.  Because the CPUMAP enqueue happens =
as
> the *LAST* thing in NAPI loop, during xdp_do_flush() call. This means
> that interleaved normal netstack (XDP_PASS) packets will be processed
> BEFORE this call to xdp_do_flush().  As noted earlier, to compensate f=
or
> this effect, code will enqueue-flush every 8 frames (CPU_MAP_BULK_SIZE=
).

Ah, that makes sense. Thanks for explaining.

>
> I hope, I've not confused you more :-|
>

No, that was helpful!

Thanks,
Daniel

