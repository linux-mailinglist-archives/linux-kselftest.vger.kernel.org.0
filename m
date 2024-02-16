Return-Path: <linux-kselftest+bounces-4857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF1857FE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DDA1C21F5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE712F380;
	Fri, 16 Feb 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/YPsiy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEA1292F4;
	Fri, 16 Feb 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095508; cv=none; b=HcRHzROKkcQeENli0RWjcgng3ta7sSvuiCPEfy13EpNn5RLLfrkP97F8EkBvGigjmd6tx/UdLmlOtxxYK8zitEE9uDA37GL9BlySBxF8qAP2tMbksQw5udfOrDd8hSWZchWN8Vcdrynp9FvnICCg7zfrwoAjiDc0j3ROylzMk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095508; c=relaxed/simple;
	bh=UATXrrWE0KIZjCnorRcUUIgyCjcvQQOol8XVnqqKE2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uguwsWyiOIro/lbEmOWAd2UwRHBgpFByHLmxFrJjWJoEI0BFoHWQXbIlILKB68pFHvpKW0HHAYUadokMNZn3AIjixYvibryy8p9UtA5IoLGg9z+hgILz1W7ohtUt2WPBrVExuvy/VdNQGjepduW24gw/QdduwjZ4f2jTRZ19x6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/YPsiy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E86C433F1;
	Fri, 16 Feb 2024 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095508;
	bh=UATXrrWE0KIZjCnorRcUUIgyCjcvQQOol8XVnqqKE2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/YPsiy7eNHfNsjp8pzZqaEqqgA6Exp0D19yHtLBtxaDBIQ/ZOJkVR0KDanGBVGtc
	 nzfSkhvWTRZ9lHlTNbWMoqSXTWfuUmlXh9hKqLK/SCpzN7fyRsSSR76b0JMUiISHDH
	 d9Co4G7FXvyaHgRG5U5Osjh5QG58uNve+gbdzQmOly+TxSKmKpKQyazGSgydStNbhG
	 HSG172Tn6CS2qiCVpPAr4OfxDepTphT25VAzWlXJKTSd9XUtvgP9/kpHz0JNrRLCLn
	 rK2fz16GwPprqomT9IE6Umktaac/VQzenXXYsj6RmtIsKAoSGJOG8Kk/Wu/HTZY6J+
	 IXf5ffEKzwbrw==
Date: Fri, 16 Feb 2024 15:58:20 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Message-ID: <fckhc367l6eha2gpftixhzjdsmo2jts5p6ir6ukx2q5xndsbhf@btzjwvuamcv4>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>
 <r3yhu4h23tdg2dqj7eq3lhevsigvvb3qkge3icxmaqpgkayvoi@gxfxstkr2pxl>
 <87eddccx1q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eddccx1q.fsf@toke.dk>

On Feb 16 2024, Toke Høiland-Jørgensen wrote:
> Benjamin Tissoires <bentiss@kernel.org> writes:
> 
> > On Feb 15 2024, Martin KaFai Lau wrote:
> >> On 2/14/24 9:18 AM, Benjamin Tissoires wrote:
> >> > +static void bpf_timer_work_cb(struct work_struct *work)
> >> > +{
> >> > +	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
> >> > +	struct bpf_map *map = t->map;
> >> > +	void *value = t->value;
> >> > +	bpf_callback_t callback_fn;
> >> > +	void *key;
> >> > +	u32 idx;
> >> > +
> >> > +	BTF_TYPE_EMIT(struct bpf_timer);
> >> > +
> >> > +	rcu_read_lock();
> >> > +	callback_fn = rcu_dereference(t->sleepable_cb_fn);
> >> > +	rcu_read_unlock();
> >> 
> >> I took a very brief look at patch 2. One thing that may worth to ask here,
> >> the rcu_read_unlock() seems to be done too early. It is protecting the
> >> t->sleepable_cb_fn (?), so should it be done after finished using the
> >> callback_fn?
> >
> > Probably :)
> >
> > TBH, everytime I work with RCUs I spent countless hours trying to
> > re-understand everything, and in this case I'm currently in the "let's
> > make it work" process than fixing concurrency issues.
> > I still gave it a shot in case it solves my issue, but no, I still have
> > the crash.
> >
> > But given that callback_fn might sleep, isn't it an issue to keep the
> > RCU_reader lock so long? (we don't seem to call synchronize_rcu() so it
> > might be fine, but I'd like the confirmation from someone else).
> 
> You're right, it isn't. From the RCU/checklist.rst doc:
> 
> 13.	Unlike most flavors of RCU, it *is* permissible to block in an
> 	SRCU read-side critical section (demarked by srcu_read_lock()
> 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
> 	Please note that if you don't need to sleep in read-side critical
> 	sections, you should be using RCU rather than SRCU, because RCU
> 	is almost always faster and easier to use than is SRCU.
> 
> So we can't use the regular RCU protection for the callback in this
> usage. We'll need to either convert it to SRCU, or add another
> protection mechanism to make sure the callback function is not freed
> from under us (like a refcnt). I suspect the latter may be simpler (from
> reading the rest of that documentation around SRCU.

Currently I'm thinking at also incrementing the ->prog held in the
bpf_hrtimer which should prevent the callback to be freed, if I'm not wrong.
Then I should be able to just release the rcu_read_unlock before calling
the actual callback. And then put the ref on ->prog once done.

But to be able to do that I might need to protect ->prog with an RCU
too.

> 
> >> A high level design question. The intention of the new
> >> bpf_timer_set_sleepable_cb() kfunc is actually to delay work to a workqueue.
> >> It is useful to delay work from the bpf_timer_cb and it may also useful to
> >> delay work from other bpf running context (e.g. the networking hooks like
> >> "tc"). The bpf_timer_set_sleepable_cb() seems to be unnecessary forcing
> >> delay-work must be done in a bpf_timer_cb.
> >
> > Basically I'm just a monkey here. I've been told that I should use
> > bpf_timer[0]. But my implementation is not finished, as Alexei mentioned
> > that we should bypass hrtimer if I'm not wrong [1].
> 
> I don't think getting rid of the hrtimer in favour of
> schedule_delayed_work() makes any sense. schedule_delayed_work() does
> exactly the same as you're doing in this version of the patch: it
> schedules a timer callback, and calls queue_work() from inside that
> timer callback. It just uses "regular" timers instead of hrtimers. So I
> don't think there's any performance benefit from using that facility; on
> the contrary, it would require extra logic to handle cancellation etc;
> might as well just re-use the existing hrtimer-based callback logic we
> already have, and do a schedule_work() from the hrtimer callback like
> you're doing now.

I agree that we can nicely emulate delayed_timer with the current patch
series. However, if I understand Alexei's idea (and Martin's) there are
cases where we just want schedule_work(), without any timer involved.
That makes a weird timer (with a delay always equal to 0), but it would
allow to satisfy those latency issues.

So (and this also answers your second email today) I'm thinking at:
- have multiple flags to control the timer (with dedicated timer_cb
  kernel functions):
  - BPF_F_TIMER_HRTIMER (default)
  - BPF_F_TIMER_WORKER (no timer, just workqueue)
  - BPF_F_TIMER_DELAYED_WORKER (hrtimer + workqueue, or actual
    delayed_work, but that's re-implementing stuffs)
- have bpf_timer_set_callback() and bpf_timer_set_sleepable_cb() strictly
  equivalent in terms of processing, but the latter just instructs the
  verifier that the callback can be sleepable (so calling
  bpf_timer_set_callback() on a BPF_F_TIMER_DELAYED_WORKER is fine as
  long as the target callback is using non sleepable kfuncs).
- ensure that bpf_timer_set_sleepable_cb() is invalid when called with
  a non sleepable timer flag.
- ensure that when the bpf_timer has no hrtimer we also return -EINVAL
  when a delay is given in bpf_timer_start().

Actually, BPF_F_TIMER_DELAYED_WORKER could be just a combination of
(BPF_F_TIMER_HRTIMER | BPF_F_TIMER_WORKER) which would reflect the
reality of how things are implemented.

Thinking through this a little bit more, maybe we should have
BPF_F_TIMER_SLEEPABLE instead of BPF_F_TIMER_WORKER. We can still have
BPF_F_TIMER_SLEEPABLE_BH when WQ_BH gets merged. _SLEEPABLE allows to
not bind the flag to the implementation...

Cheers,
Benjamin

