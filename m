Return-Path: <linux-kselftest+bounces-23380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474519F1C29
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 03:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CD616988B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664751CD2B;
	Sat, 14 Dec 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="aK4LgnTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2TTGGoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E34DF49;
	Sat, 14 Dec 2024 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734144305; cv=none; b=la/wwr7j3rWsx8VvNq7PxpgjTZHzC0F/ZhANtc5wwxowTbJMsaH/lPeJDZj4gNJEOFyVphq82sLqZY1yiRQ8embcVqx7gStX9b8lWsfa4BiaLSne+rH6v+TAdb6QGi9HiTrpmYyf9j+UvS/+MVkTGa1EMesfgxz804BYFRGfDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734144305; c=relaxed/simple;
	bh=9qyDgkeCX1tal18Hf/Ny/eaU0q+9ST+DwYCRWojmXUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew4nemQn4+0EDvjoEPNl5xXLdqDwwkg38E6WcnzpwDUKVvDB4BIXZyYt5BFjJzQ/86XzPAyta4zslbFP1FqhqD4JKYXjnUuGEyyqvNZvKrJPBFQMhpHK8QdGXyIZYpxa2FzQFYDjXOBnEYn2Eub9fQo57LslEwkXl+BggnnvCto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=aK4LgnTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2TTGGoi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A661513841EB;
	Fri, 13 Dec 2024 21:45:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 21:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734144301;
	 x=1734230701; bh=JzF+XelSXj4HAebN6G10rWGrSfReZwqnUK4DNzdHLvE=; b=
	aK4LgnTZIQr2LvYmqh+sdZAcp6mZBlTwVcXtY7l2/IaeCDCPEf4oKyvBpMR0Y3h8
	8lsF7+N7lcGsQ2Ix6YrtO5hDawNVr7myi3Y2YOM+efGOxQuZGYU77KcSt42xli3b
	kn7wdbz+9fobWlMOgMalmMNFwzAdJq2Ur2HJu1NpwhBDbL2Vn/B+1IrwDGB2ZoSB
	qFdf9kq+Hp2pm6UWC8PLR/xth1Hbkrb9gjk67mURZsyMotSgO5UiugYiA6WJ2Hy8
	6kiDARd869JpTua8uq8DECTY98SZISNsNpqPRQy/GIDhMsl+5IEGr5W7ZAkoTTF2
	rKpbR+OQv+WHFz3UWzlCaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734144301; x=
	1734230701; bh=JzF+XelSXj4HAebN6G10rWGrSfReZwqnUK4DNzdHLvE=; b=X
	2TTGGoiGHB61jbOt3JIO+2DXRt+TnyMdRiQjkywVO1Hm5GoE406bhgpCSOClYWM6
	yD/Pgb84I3bkx7U3oXXJ3iqv2FswmQZoXAp0VNS1QNVcrlOrRkcBZoxIab6zIryR
	KhA7p0rJtoa0NUzJdc26390d8Mp+yn1T1P+hVwBhbJkukVVVm4aJHCjuWpadPb+M
	/rAGVUDfBYJVEmehxn3PxkBywOaXPAX+cNldUB8imX5WnUUlwG1DVGqvaibFfBpf
	8jF+AQhyltwCvMfmqBh468w4JnZiLCZZDzZgv75fWc3e78CCs0jT8C4CL+9ihz6T
	klQbKM7eJP4wz/ieqCakg==
X-ME-Sender: <xms:LPFcZ4wJZddKBDuYpgpEVJh6Kd5_PvzT5pbkHZ0_YpHzjWCEX-RMsg>
    <xme:LPFcZ8T0nvmXN9AWaMo9_EApz9rsAUotFWr6n5AoE2rNJHlipBGOahgdkNOR1telj
    CNzaqupYOQxDtXNLw>
X-ME-Received: <xmr:LPFcZ6WnpqztuP9BJS1aDML29exPp0xFn0mCsLPA5VAOceR_jGrPu1ViNNn-FOd_BFRlYR_QmFQ-HH5mRzWvjtc9x6P6pq8QBph8Ig6fRK-o9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeekgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffel
    teekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhhiihdrnh
    grkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvg
    htpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsh
    honhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LPFcZ2gLkySSqTMO_YhbArEZesnigQoXjcf8K_aOYKlgAjZ1ndhOTA>
    <xmx:LPFcZ6AP_57R1QgUv69a5iI_LwvZYRbs-Vr2QCFFGwnhor3CIYtGCw>
    <xmx:LPFcZ3IDCoN-MfP5bHzlqq5u-1i6ZF5Oc_U26usG9-mRJrG7CTFc7Q>
    <xmx:LPFcZxB1EUYMwDohZcDaygtKvP0j_ivo0b2UWSasplQ7wB9F1EoDvQ>
    <xmx:LfFcZ1UMNp2tLaZxTNMh6fNG75fQe5whelrusP6SR-6Ir6QEGBNgLO3e>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 21:44:57 -0500 (EST)
Date: Fri, 13 Dec 2024 19:44:55 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>

On Fri, Dec 13, 2024 at 03:02:11PM GMT, Andrii Nakryiko wrote:
> On Thu, Dec 12, 2024 at 3:23 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This commit allows progs to elide a null check on statically known map
> > lookup keys. In other words, if the verifier can statically prove that
> > the lookup will be in-bounds, allow the prog to drop the null check.
> >
> > This is useful for two reasons:
> >
> > 1. Large numbers of nullness checks (especially when they cannot fail)
> >    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> > 2. It forms a tighter contract between programmer and verifier.
> >
> > For (1), bpftrace is starting to make heavier use of percpu scratch
> > maps. As a result, for user scripts with large number of unrolled loops,
> > we are starting to hit jump complexity verification errors.  These
> > percpu lookups cannot fail anyways, as we only use static key values.
> > Eliding nullness probably results in less work for verifier as well.
> >
> > For (2), percpu scratch maps are often used as a larger stack, as the
> > currrent stack is limited to 512 bytes. In these situations, it is
> > desirable for the programmer to express: "this lookup should never fail,
> > and if it does, it means I messed up the code". By omitting the null
> > check, the programmer can "ask" the verifier to double check the logic.
> >
> > Tests also have to be updated in sync with these changes, as the
> > verifier is more efficient with this change. Notable, iters.c tests had
> > to be changed to use a map type that still requires null checks, as it's
> > exercising verifier tracking logic w.r.t iterators.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  kernel/bpf/verifier.c                         | 80 ++++++++++++++++++-
> >  tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
> >  .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
> >  .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
> >  .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
> >  5 files changed, 87 insertions(+), 13 deletions(-)
> >
> 
> Eduard has great points. I've added a few more comments below.
> 
> pw-bot: cr
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 58b36cc96bd5..4947ef884a18 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -287,6 +287,7 @@ struct bpf_call_arg_meta {
> >         u32 ret_btf_id;
> >         u32 subprogno;
> >         struct btf_field *kptr_field;
> > +       s64 const_map_key;
> >  };
> >
> >  struct bpf_kfunc_call_arg_meta {
> > @@ -9163,6 +9164,53 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
> >         return 0;
> >  }
> >
> > +/* Returns constant key value if possible, else -1 */
> > +static s64 get_constant_map_key(struct bpf_verifier_env *env,
> > +                               struct bpf_reg_state *key,
> > +                               u32 key_size)
> > +{
> > +       struct bpf_func_state *state = func(env, key);
> > +       struct bpf_reg_state *reg;
> > +       int zero_size = 0;
> > +       int stack_off;
> > +       u8 *stype;
> > +       int slot;
> > +       int spi;
> > +       int i;
> > +
> > +       if (!env->bpf_capable)
> > +               return -1;
> > +       if (key->type != PTR_TO_STACK)
> > +               return -1;
> > +       if (!tnum_is_const(key->var_off))
> > +               return -1;
> > +
> > +       stack_off = key->off + key->var_off.value;
> > +       slot = -stack_off - 1;
> > +       spi = slot / BPF_REG_SIZE;
> > +
> > +       /* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE */
> > +       stype = state->stack[spi].slot_type;
> > +       for (i = 0; i < BPF_REG_SIZE && stype[i] == STACK_ZERO; i++)
> 
> it's Friday and I'm lazy, but please double-check that this works for
> both big-endian and little-endian :)

Any tips? Are the existing tests running thru s390x hosts in CI
sufficient or should I add some tests writen in C (and not BPF
assembler)? I can never think about endianness correctly...

> 
> with Eduard's suggestion this also becomes interesting when you have
> 000mmm mix (as one example), because that gives you a small range, and
> all values might be valid keys for arrays

Can you define what "small range" means? What range is there with 0's?
Any pointers would be helpful.


> 
> > +               zero_size++;
> > +       if (zero_size == key_size)
> > +               return 0;
> > +
> > +       if (!is_spilled_reg(&state->stack[spi]))
> > +               /* Not pointer to stack */
> 
> !is_spilled_reg and "Not pointer to stack" seem to be not exactly the
> same things?

You're right - comment is not helpful. I'll make the change to
use is_spilled_scalar_reg() which is probably as clear as it gets.

[..]



