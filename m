Return-Path: <linux-kselftest+bounces-4838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26827857778
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABFF1C20C02
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CD1A5BA;
	Fri, 16 Feb 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhi5FVbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349681B94A;
	Fri, 16 Feb 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071197; cv=none; b=Amo2pjih51gsyV+JiQKiklmfrfruJGQt5i6CaAbQf8iiqL9KPbl+h3qQXfxB2CAdvwTb4aBRFpAY5OkxaQX14YYf8ILV9l1yRse221yRoqjYvqZilfP7q6YjfxfnDuwIP+xPQkgt3yC5eK9nQxHVyharHileLm+bQ5U96OkQJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071197; c=relaxed/simple;
	bh=2yAzUFrshahCJDeF/Txc7JdTyHzEPst4ox4Ao1JajmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROD6BN9KPPb9VpUB1M7IyBIJC+6uR57uiwD3FIMS5cxSu/HBunSWah6gOTk/AaNqGFT8I5oJxTbCgtED+lUmf6raNXdS+QA5Onc/2rKcaQySvffccb/Y5vB61Ee8MaCJC/eEDEqOGMf6qkdLOBXkhpDji7d+tHeVCc7d+YEddnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhi5FVbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CDEC433F1;
	Fri, 16 Feb 2024 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708071196;
	bh=2yAzUFrshahCJDeF/Txc7JdTyHzEPst4ox4Ao1JajmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hhi5FVbwJBQGJrQ5LdUmS8j/Le4dlaV8h1U5wH5BlNyGQrrM2XqyMxRnsnAKFbMZx
	 SFQaP2/aGi379Z5SHpZ7wDWSp5e8G7tgjc9AzIziwGmtse4q48U46iFQcjxylokg1P
	 K/KhkeBJZ0tIrTsozcIJ3KwcSyKyhvNudlZ1i40K93iF9DdiWTEHMtM1Ctlw8Rn0FL
	 87TYT0ZzNruWA3tPglsbxs14kOOquqHn11S8ZJYb+kCD+bHh6l0sKaOq/r8DsSVhnE
	 pjRSDqix+iI+/rl9GYYLZNkr/LrWhcipZI7K9C8xWWE9FHcnzdDXIKPhtSPxTBM90q
	 HQKdGiuY7w7pQ==
Date: Fri, 16 Feb 2024 09:13:03 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
Message-ID: <r3yhu4h23tdg2dqj7eq3lhevsigvvb3qkge3icxmaqpgkayvoi@gxfxstkr2pxl>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>

On Feb 15 2024, Martin KaFai Lau wrote:
> On 2/14/24 9:18 AM, Benjamin Tissoires wrote:
> > +static void bpf_timer_work_cb(struct work_struct *work)
> > +{
> > +	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer, work);
> > +	struct bpf_map *map = t->map;
> > +	void *value = t->value;
> > +	bpf_callback_t callback_fn;
> > +	void *key;
> > +	u32 idx;
> > +
> > +	BTF_TYPE_EMIT(struct bpf_timer);
> > +
> > +	rcu_read_lock();
> > +	callback_fn = rcu_dereference(t->sleepable_cb_fn);
> > +	rcu_read_unlock();
> 
> I took a very brief look at patch 2. One thing that may worth to ask here,
> the rcu_read_unlock() seems to be done too early. It is protecting the
> t->sleepable_cb_fn (?), so should it be done after finished using the
> callback_fn?

Probably :)

TBH, everytime I work with RCUs I spent countless hours trying to
re-understand everything, and in this case I'm currently in the "let's
make it work" process than fixing concurrency issues.
I still gave it a shot in case it solves my issue, but no, I still have
the crash.

But given that callback_fn might sleep, isn't it an issue to keep the
RCU_reader lock so long? (we don't seem to call synchronize_rcu() so it
might be fine, but I'd like the confirmation from someone else).

> 
> A high level design question. The intention of the new
> bpf_timer_set_sleepable_cb() kfunc is actually to delay work to a workqueue.
> It is useful to delay work from the bpf_timer_cb and it may also useful to
> delay work from other bpf running context (e.g. the networking hooks like
> "tc"). The bpf_timer_set_sleepable_cb() seems to be unnecessary forcing
> delay-work must be done in a bpf_timer_cb.

Basically I'm just a monkey here. I've been told that I should use
bpf_timer[0]. But my implementation is not finished, as Alexei mentioned
that we should bypass hrtimer if I'm not wrong [1].

> 
> Have you thought about if it is possible to create a more generic kfunc like
> bpf_schedule_work() to delay work to a workqueue ?
> 

AFAIU if we were to have a separate bpf_schedule_work(), we still need
all of the infra of bpf_timer, because we need to keep the programs
around in the same way bpf_timer does. So basically, bpf_timer will not
only be about hrtimers, but anything that need to run an async callback.

I submitted this RFC v2 not for the "this is ready", but mostly because
there is a crash and I can't see where it comes from, and I suspect this
is from a piece I do not understand (translation from the BPF langage
into actual elf assembly).


Cheers,
Benjamin

[0] https://lore.kernel.org/bpf/ztou4yyrsdfmmhdwgu2f2noartpqklhvtbw7vj2ptk54eqohvb@qci7bcnbd56q/T/#mc9cab17138b13c83299f0836ca0b2dde0643ea4b
[1] https://lore.kernel.org/bpf/ztou4yyrsdfmmhdwgu2f2noartpqklhvtbw7vj2ptk54eqohvb@qci7bcnbd56q/T/#mf59824ad625992b980afbc4f27c83e76245815e7

> 
> 
> > +	if (!callback_fn)
> > +		return;
> > +
> > +	/* FIXME: do we need any locking? */
> > +	if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> > +		struct bpf_array *array = container_of(map, struct bpf_array, map);
> > +
> > +		/* compute the key */
> > +		idx = ((char *)value - array->value) / array->elem_size;
> > +		key = &idx;
> > +	} else { /* hash or lru */
> > +		key = value - round_up(map->key_size, 8);
> > +	}
> > +
> > +	/* FIXME: this crashes the system with
> > +	 * BUG: kernel NULL pointer dereference, address: 000000000000000b
> > +	 */
> > +	/* callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0); */
> > +	/* The verifier checked that return value is zero. */
> > +}
> > +
> 
> [ ... ]
> 
> > +/* FIXME: use kernel doc style */
> > +/* Description
> > + *	Configure the timer to call *callback_fn* static function in a
> > + *	sleepable context.
> > + * Return
> > + *	0 on success.
> > + *	**-EINVAL** if *timer* was not initialized with bpf_timer_init() earlier.
> > + *	**-EPERM** if *timer* is in a map that doesn't have any user references.
> > + *	The user space should either hold a file descriptor to a map with timers
> > + *	or pin such map in bpffs. When map is unpinned or file descriptor is
> > + *	closed all timers in the map will be cancelled and freed.
> > + */
> > +__bpf_kfunc int bpf_timer_set_sleepable_cb(struct bpf_timer_kern *timer,
> > +					   int (callback_fn)(void *map, int *key, struct bpf_timer *timer))
> > +{
> > +	struct bpf_throw_ctx ctx = {};
> > +
> > +	/* FIXME: definietely not sure this is OK */
> > +	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
> > +	WARN_ON_ONCE(!ctx.aux);
> > +
> > +	if (!ctx.aux)
> > +		return -EINVAL;
> > +
> > +	return __bpf_timer_set_callback(timer, (void *)callback_fn, ctx.aux, true);
> > +}
> > +
> 

