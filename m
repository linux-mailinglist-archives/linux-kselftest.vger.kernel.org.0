Return-Path: <linux-kselftest+bounces-17764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072B975A9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 20:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DF6B24FDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17F1BA287;
	Wed, 11 Sep 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="jhKBGsue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ltsvb1hN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916A187337;
	Wed, 11 Sep 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080835; cv=none; b=BXpSrjhmrQ3LWDKoIS1k4GtB18dJDWXN6Fv2hwnlAKyAdpYfRG+ApjqkGef43L6FPLU1lNSAEEoPgKBCo48P/efJrGqkEH/t08o6ur1kU3HprhDIH/4e5Ye7jMKAt9BvbDenSo687KS8dwHbcnR+rT8BU3BvNOwptkQ9jndx+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080835; c=relaxed/simple;
	bh=T1YNUXtauaZKRegG7ATGOac3MwWLqKwbt0G1jC2mne8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOVSb/FbdfVyGMYwfGX0JkcYE1Ho8blJaR00AZr5viKMc80osl0oYXyYSsyF+jnmBWvP42dK/Amtv93ekHKgRLpn8PWl5lrGXJnmQjXiU2BuPQhhJB+F8c7omXWiu33CW6Bwx50fM210PGA/WPwf4rCRwwyGhEpYuXSIAAwBiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=jhKBGsue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ltsvb1hN; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 0C9D9200255;
	Wed, 11 Sep 2024 14:53:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 11 Sep 2024 14:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726080831;
	 x=1726088031; bh=9fMv2GffujFwQIlQdEBnH5FOZnBoPmz6xA7sOJ1AMUA=; b=
	jhKBGsueI9Qx1CZq2FC4EKt3FzpK8IUagVi0puFUnEJC/0Db+3EpUeppVZsgP692
	JYZvhYrWWADTy8kxydJXO/SMeViV3GNbVzcxxGb/59ppwhO2Mc0GjZ1XLJsuV7Ie
	1geL/yeyoVymD6T41L0f7TVJA7A+vumFeFB2q3RQsiarcSO/wV3IqtRMQdO74yfR
	oaHroOa87G77JrmTDZZEjfJ4sJ8l1uS6AhrvSQzHKGafKyuyTtE2yRlmrhfivnw+
	qfQpRIU0PPmtOyZ6C5fURiJWdAb+AWgUZmRSofzxLGrZQULwItMYAaYD+JLaXI71
	DOF95/s23N9Be6kdq0eLRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726080831; x=
	1726088031; bh=9fMv2GffujFwQIlQdEBnH5FOZnBoPmz6xA7sOJ1AMUA=; b=L
	tsvb1hN9lQBF6f3opboaF4eo7Dk7YenTbk0anrCJgWykRINsWW8IKNzB+MZADgqN
	9S8weytcWkV6AN4WOGbYaoXBxCVoarah1vRJJaJhPXrHKK032Sza83sHkVZ5lDXv
	o8nX2mcC/fHRR5uF5k4ZQ0Tj6qMWiL/yq+2kzB7PAkykhKCh15DZv7wvge49dd1S
	+Tk3EB4NIZPheuJCVpchx8jtXnZVFivPD7v+KxPfOtiId6el7TT9vesg+HTE1qe2
	NbxqeXib/zlgu9kfIvT3ZbKeQdqLot9mA0hnjFZaGF+ltnBRso5oIZ/Rwc0tSOwK
	k9eLJ+K0gBEEImFh4QHDg==
X-ME-Sender: <xms:PufhZoIhCMMEdvCl4V6ygTYIsrSrltXO_PD6W1JF4IyLaRVK_JEquw>
    <xme:PufhZoIsX0C2B3lqQIlLMdQC2Z-o-E33QSw8fRX64QepDJwNDusRPjBj8RwIc8ai8
    DKG31_rz3lmut5hhQ>
X-ME-Received: <xmr:PufhZosXu6WjC_ozuXy6dcEhHUdHDCDHVPioQLoiaZF0Ve_axG51karv4fFeqzLBzWxnxwemrNbIsD3LtFSmMwIzXRfcNzefgUSMxvm1lSQ4ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffk
    fhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepffffgeegkeejvdejgeehteek
    udfhgfefgeevkeelhfegueeljefhleejtdekveffnecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    hlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvght
    pdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PufhZlZU1yrF9hWjmM5hU82YIL4g7JMi_oMZjhHzpKJcC3rVF8VRSA>
    <xmx:PufhZvbw_0K9S0ui6zJ_9DPNOqyKfm8wbFjHO7lv4cfTI5S2lWXrag>
    <xmx:PufhZhA5JXEwMUD2H1CtKFNZNRobgRPVIqYrB3HelyBi7S7pGjT2dg>
    <xmx:PufhZlY9e4uWGeovn7JzsV1x5t4t7cLcxpqMLCckkr9lgjFJd9Pxzg>
    <xmx:PufhZsTyuJ7gK9LjSQNMo-lkIJMD28kWvLLNjEeJotwxv-X2D_00JaNb>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 14:53:48 -0400 (EDT)
Date: Wed, 11 Sep 2024 12:53:46 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	LKML <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
Message-ID: <oq2gfokp7godtkvkedod2ixpw3m6qfnhohaiy7sz4pq7pbkitl@eiqkz2tzrxc3>
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
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6a2da12-6442-4a8e-a5dc-6f8af5a5178c@kernel.org>

On Wed, Sep 11, 2024 at 10:32:56AM GMT, Jesper Dangaard Brouer wrote:
> 
> 
> On 11/09/2024 06.43, Daniel Xu wrote:
> > [cc Jesper]
> > 
> > On Tue, Sep 10, 2024, at 8:31 PM, Daniel Xu wrote:
> > > On Tue, Sep 10, 2024 at 05:39:55PM GMT, Andrii Nakryiko wrote:
> > > > On Tue, Sep 10, 2024 at 4:44 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > 
> > > > > On Tue, Sep 10, 2024 at 03:21:04PM GMT, Andrii Nakryiko wrote:
> > > > > > On Tue, Sep 10, 2024 at 3:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > > > > > 
> [...cut...]
> 
> > > > Can you give us a bit more details on what
> > > > you are trying to achieve?
> > > 
> > > BPF cpumap, under the hood, has one MPSC ring buffer (ptr_ring) for each
> > > entry in the cpumap. When a prog redirects to an entry in the cpumap,
> > > the machinery queues up the xdp frame onto the destination CPU ptr_ring.
> > > This can occur on any cpu, thus multi-producer. On processing side,
> > > there is only the kthread created by the cpumap entry and bound to the
> > > specific cpu that is consuming entries. So single consumer.
> > > 
> 
> An important detail: to get Multi-Producer (MP) to scale the CPUMAP does
> bulk enqueue into the ptr_ring.  It stores the xdp_frame's in a per-CPU
> array and does the flush/enqueue as part of the xdp_do_flush(). Because
> I was afraid of this adding latency, I choose to also flush every 8
> frames (CPU_MAP_BULK_SIZE).
> 
> Looking at code I see this is also explained in a comment:
> 
> /* General idea: XDP packets getting XDP redirected to another CPU,
>  * will maximum be stored/queued for one driver ->poll() call.  It is
>  * guaranteed that queueing the frame and the flush operation happen on
>  * same CPU.  Thus, cpu_map_flush operation can deduct via this_cpu_ptr()
>  * which queue in bpf_cpu_map_entry contains packets.
>  */
> 
> 
> > > Goal is to track the latency overhead added from ptr_ring and the
> > > kthread (versus softirq where is less overhead). Ideally we want p50,
> > > p90, p95, p99 percentiles.
> > > 
> 
> I'm very interesting in this use-case of understanding the latency of
> CPUMAP.
> I'm a fan of latency histograms that I turn into heatmaps in grafana.
> 
> > > To do this, we need to track every single entry enqueue time as well as
> > > dequeue time - events that occur in the tail are quite important.
> > > 
> > > Since ptr_ring is also a ring buffer, I thought it would be easy,
> > > reliable, and fast to just create a "shadow" ring buffer. Every time
> > > producer enqueues entries, I'd enqueue the same number of current
> > > timestamp onto shadow RB. Same thing on consumer side, except dequeue
> > > and calculate timestamp delta.
> > > 
> 
> This idea seems overkill and will likely produce unreliable results.
> E.g. the overhead of this additional ring buffer will also affect the
> measurements.

Yeah, good point.

> 
> > > I was originally planning on writing my own lockless ring buffer in pure
> > > BPF (b/c spinlocks cannot be used w/ tracepoints yet) but was hoping I
> > > could avoid that with this patch.
> > 
> > [...]
> > 
> > Alternatively, could add a u64 timestamp to xdp_frame, which makes all
> > this tracking inline (and thus more reliable). But I'm not sure how precious
> > the space in that struct is - I see some references online saying most drivers
> > save 128B headroom. I also see:
> > 
> >          #define XDP_PACKET_HEADROOM 256
> > 
> 
> I like the inline idea. I would suggest to add u64 timestamp into
> XDP-metadata area (ctx->data_meta code example[1]) , when XDP runs in
> RX-NAPI.  Then at the remote CPU you can run another CPUMAP-XDP program that
> pickup this timestamp, and then calc a delta from "now" timestamp.
> 
> 
>  [1] https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interaction/af_xdp_kern.c#L62-L77

Cool! This is a much better idea than mine :)

I'll give this a try.

> 
> 
> > Could probably amortize the timestamp read by setting it in
> > bq_flush_to_queue().
> 
> To amortize, consider that you might not need to timestamp EVERY packet to
> get sufficient statistics on the latency.
> 
> Regarding bq_flush_to_queue() and the enqueue tracepoint:
>   trace_xdp_cpumap_enqueue(rcpu->map_id, processed, drops, to_cpu)
> 
> I have an idea for you, on how to measure the latency overhead from XDP
> RX-processing to when enqueue "flush" happens.  It is a little tricky to
> explain, so I will outline the steps.
> 
> 1. XDP bpf_prog store timestamp in per-CPU array,
>    unless timestamp is already set.
> 
> 2. trace_xdp_cpumap_enqueue bpf_prog reads per-CPU timestamp
>    and calc latency diff, and clears timestamp.
> 
> This measures the latency overhead of bulk enqueue. (Notice: Only the
> first XDP redirect frame after a bq_flush_to_queue() will set the
> timestamp). This per-CPU store should work as this all runs under same
> RX-NAPI "poll" execution.

Makes sense to me. This breaks down the latency even further. I'll keep
it in mind if we need further troubleshooting.

> This latency overhead of bulk enqueue, will (unfortunately) also
> count/measure the XDP_PASS packets that gets processed by the normal
> netstack.  So, watch out for this. e.g could have XDP actions (e.g
> XDP_PASS) counters as part of step 1, and have statistic for cases where
> XDP_PASS interfered.

Not sure I got this. If we only set the percpu timestamp for
XDP_REDIRECT frames, then I don't see how XDP_PASS interferes. Maybe I
misunderstand something.

Thanks,
Daniel

