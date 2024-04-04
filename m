Return-Path: <linux-kselftest+bounces-7221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7641898DEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522CF1F22572
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862C130A76;
	Thu,  4 Apr 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOLx1oSj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D98130A48;
	Thu,  4 Apr 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255364; cv=none; b=QF30iXy/yGm1J3CLqa9ma9SSifGgYjx1grfE+kwELMxmU2NmBOaig/Qmvbn94OYJW26pHaQv3wzc5WgsjipzIprVnEdpccAH9xUuuONYhDgQju369VIQpbO3TbaLEz5OxHrnNKMV2Es0p0UmbGgiBAvUF63hrjfZVU29ycfugcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255364; c=relaxed/simple;
	bh=HMKk2OAtKW2x2LMdD/jWcBEfeS1RgaLvh6Ziw8H1c98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngClumJ0VnDag0CQCxUfh5hD2+75GqfVIJE1CbnTV4PdMDl7zKb26XNOlwO3PQJpZ14rCCypm3u5tappWaLUlERJz3elNEV3kINn1TleP7PFiiTPn6Yeho6/6aEXpd7Yc2UDCJQ/CLXjTf3PyYx4lvG5lG/+mvPd35/sW/Ub/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOLx1oSj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3438d7a05aaso829789f8f.0;
        Thu, 04 Apr 2024 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255360; x=1712860160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTpTxJ/h4Sy2oSmb8gB37Gwj4AEbOYQ5z8wuEnJIGRw=;
        b=HOLx1oSjpfDjJEzh7TCvA+7gYQ+eWzDnh3pb9R2mUKEMgpSkiaXzbLghowX04Tjzyt
         /AroJkVWMPYCU9yWcz0l3/Di0W4+JDoKpZDTKnM0QOn1kjMLDVOFtqs/uVVP2LYNwEqw
         BTVezeh/HL9eKpmQ5CbQzgIA00GPsYZgPmiRBPaoe6PbNT4MOAaULf9zi71jKKxAB31t
         vr1GwWtuRSlH8OcriU0QJ1w6jZdV3hNidMV1MWEeWu91KVpTl2/hFGqZ8CpJVTCB+t5c
         0IA4V/lO6C3SxGFSLS3PN9opucYMIwwOuGbfEOvtnY2Dil5KfmBHLLihk3vekPD7BGqN
         +g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255360; x=1712860160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTpTxJ/h4Sy2oSmb8gB37Gwj4AEbOYQ5z8wuEnJIGRw=;
        b=MmVsbgJ4+NnNQA0YbS1+8W8ga5H+p7hkSSOSdy613EBelak0mZebdvfw1s/OBwkj+7
         WlOs8P/xgpk8V60CbXGVuHRBqkGU3VXvwiKn05fGZsJ1UW9VGI1mTpNZY7U8FIpznGx9
         0Yfoy8qursHd7NgaZQNCXVK87Qtue28MS9TM7BHCJB438TtWKptQc/+HjjVah3MiYWul
         bLg5rnnD9YceqC0WSmKCfq190aX64fI0erkxQXslU+R1tAkkR/0cfr2VBdTjdWqaExm0
         YyWn3D5BRBB6isthk8dnWVk6wRigxT3p1zxRkH2b6UfhOVoHQGdYR5vvgA+PrlTfUrhA
         PeHg==
X-Forwarded-Encrypted: i=1; AJvYcCUaL0u1gWFQfjUnf27k83HCN+LtmNF+Z/NISN0LuajP+b/OfZ4Qw7fSORNeZsCnmlaAABhBSnk2QJCB17JbT10y782yprvK25DWm+4YQ6xp17JvJXrHkgIPjkMiAt5YmU3GYKatTS1+b8R4GeUugb+UNEwqOfcjXn1RnzRZa48H7RNL
X-Gm-Message-State: AOJu0Yyzk8yjwjaCk4QUFo+qCmvxH4XPNzjyYZ8kukyyPWwEN7phx0qR
	Is/EFSuG6ml/2vnQg2FLsBsQzf6zWDCqJq6NyiV044As8IIvdMf3ynPckvnbWSmG9h+vgI9SK7D
	BeNKgLP9J7y+InA91Kqh4MrLx8cw=
X-Google-Smtp-Source: AGHT+IGVEGF08XZDzG15bu9gOfdbspeTE9QO+ua8mJgOIRn1Vq/L/BtUcTGdbsFwJ2X/XkYBaoi7b250MWo5d7NP88k=
X-Received: by 2002:adf:a1c2:0:b0:343:c43d:2eeb with SMTP id
 v2-20020adfa1c2000000b00343c43d2eebmr354454wrv.0.1712255360571; Thu, 04 Apr
 2024 11:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
 <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
 <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
 <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com>
 <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com>
 <CAADnVQ+gikPakTuYpD4-oxS6yS5-Dd_HanfqyNnGW-nk7=eXNg@mail.gmail.com> <CAO-hwJLz4ET8Rba-_8icR+7t9T63BPnf97JrSFjviJWG+i8dVQ@mail.gmail.com>
In-Reply-To: <CAO-hwJLz4ET8Rba-_8icR+7t9T63BPnf97JrSFjviJWG+i8dVQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 11:29:09 -0700
Message-ID: <CAADnVQ+MSqf1=FesorSxT63Qh83+4W79HX3HDyOWupajk_rTHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:56=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Thu, Apr 4, 2024 at 6:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 4, 2024 at 8:27=E2=80=AFAM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > >
> > > >
> > > > So we need something like:
> > > >
> > > > struct bpf_hrtimer {
> > > >   union {
> > > >     struct hrtimer timer;
> > > > +   struct work_struct work;
> > > >   };
> > > >   struct bpf_map *map;
> > > >   struct bpf_prog *prog;
> > > >   void __rcu *callback_fn;
> > > >   void *value;
> > > >   union {
> > >
> > > Are you sure we need an union here? If we get to call kfree_rcu() we
> > > need to have both struct rcu_head and sync_work, not one or the other=
.
> >
> > why? with an extra flag it's one or the other.
> > In bpf_timer_cancel_and_free()
> > if (flag & SLEEPABLE) {
> >     schedule_work() to cancel_work_sync + kfree_rcu
> > } else {
> >    hrtimer_cancel
> >    kfree_rcu
> > }
>
> I thought kfree_rcu required struct rcu_head, and given that we need
> to initialize sync_work it will be poisoned...

yes. It needs rcu_head.
But where do you see a conflict?
INIT_WORK + schedule_work() will use that space,
then cancel_work_sync() will wait on a different work_struct,
then kfree_rcu() will reuse that space.

In case of hrtimers none of the work_structs will be used.

>
> >
> > > >     struct rcu_head rcu;
> > > > +   struct work_struct sync_work;
> > > >   };
> > > > + u64 flags; // bpf_timer_init() will require BPF_F_TIMER_SLEEPABLE
> > >
> > > If I understand, you want BPF_F_TIMER_SLEEPABLE in bpf_timer_init()
> > > (like in my v2 or v3 IIRC). But that means that once a timer is
> > > initialized it needs to be of one or the other type (especially true
> > > with the first union in this struct).
> >
> > yes. That's an idea.
> > The code to support wq vs timer seems to be diverging more
> > than what we expected initially.
> > It seems cleaner to set it as init time and enforce in
> > other helpers.
>
> OK, works for me.
>
> >
> > Also with two work_struct-s we're pushing the sizeof(bpf_hrtimer)
> > too far.
> > It's already at 112 bytes and some people use bpf_timer per flow.
> > So potentially millions of such timers.
> > Adding extra sizeof(struct work_struct)=3D32 * 2 that won't be
> > used is too much.
> > Note that sizeof(struct hrtimer)=3D64, so unions make everything
> > fit nicely.
>
> Maybe we should do
> union {
>   struct hrtimer timer;
>   struct {
>     struct work_struct work;
>     struct work_struct sync_work;
>   }
> }

It's also ok, but sharing rcu_head and work_struct seems
cleaner, since it highlights that they're exclusive.

> (not nice to read but at least we don't change the size at the beginning)
>
> >
> > > So should we reject during run time bpf_timer_set_callback() for
> > > sleepable timers and only allow bpf_timer_set_sleepable_cb() for
> > > those? (and the invert in the other case).
> >
> > yes.
> >
> > > This version of the patch allows for one timer to be used as softIRQ
> > > or WQ, depending on the timer_set_callback that is used. But it might
> > > be simpler for the kfree_rcu race to define the bpf_timer to be of on=
e
> > > kind, so we are sure to call the correct kfree method.
> >
> > I think one or another simplifies the code and makes it easier
> > to think through combinations.
> >
> > I'm still contemplating adding new "struct bpf_wq" and new kfuncs
> > to completely separate wq vs timer.
> > The code reuse seems to be relatively small.
>
> There is some code reuse in the verifier, but it can be factored out I th=
ink.
>
> Though the biggest reuse might be in the map portion of bpf_timer,
> which I haven't looked much TBH.

Right. It's all the 'case BPF_TIMER:' in various places.
New 'struct bpf_wq' would need another entry in btf_field_type.
But that should be a straightforward addition.

>
> > We can potentially factor out internals of bpf_timer_* into smaller
> > helpers and use them from bpf_timer_* and from new bpf_wq_* kfuncs.
>
> Yeah, also, given that we are going to enforce delay =3D=3D 0 for
> sleepable timers (wq), the user api would be much cleaner if we can
> have a dedicated bpf_wq (and it would make the flags of bpf_timer_init
> easier to deal with).

It seems so.
Kinda hard to judge one way or the other without looking at
the final code, but it seems separation is worth attempting, at least.

Also if we ever do hrtimer+wq we probably will be using
'struct delayed_work' instead of rolling our own
'struct hrtimer' + 'struct work_struct' combo.

It seems wq logic already made such a combination special enough
and thought through the races, so we better just follow that path.
In that case it might be yet another 'struct bpf_delayed_wq'
and another set of kfuncs.
Considering that cancel_work() and cancel_delayed_work()
are separate api in the kernel.
Multiplexing all of them under bpf_timer_cancel()
seems wrong.
In the past we were somewhat limited in terms of helpers.
We tried not to add them unless absolutely necessary because
of uapi considerations.
Now with kfuncs we can add/tweak/remove them at will.

>
> >
> > One more thing.
> > bpf_timer_cancel() api turned out to be troublesome.
> > Not only it cancels the timer, but drops callback too.
> > It was a surprising behavior for people familiar with
> > kernel timer api-s.
> > We should not repeat this mistake with wq.
> >
> > We can try to fix bpf_timer_cancel() too.
> > If we drop drop_prog_refcnt() from it it shouldn't affect
> > existing bpf_timer users who are forced to do:
> > bpf_timer_cancel()
> > bpf_timer_set_callback()
> > bpf_timer_start()
> > all the time.
> > If/when bpf_timer_cancel() stops dropping the callback
> > such bpf prog won't be affected. So low chance of breaking any prog.
> > wdyt?
> >
>
> How would a program know set_callback() is not required after a
> cancel() because the kernel kept it around? It seems that it's going
> to be hard for them to know that (unless by trying first a start()),
> and it will add more code.
>
> timer_cancel() would be hard to change but we can always do the change
> and add a new kfunc timer_cancel_no_drop() which would clearly allow

that works too.

> for new programs to know that set_callback() is not required to be
> called. In a few kernel releases we could remove it and say that
> timer_cancel() is the same (and replaced by a #define)

#define won't work, since mechanics of detecting and calling
helpers vs kfuncs is quite different.

> Anyway, the more I think of it, the more I think the best API would be
> a dedicated wq API. It's probably going to need a little bit more
> work, but it'll be more or less this work plus the new bpf_wq type in
> the map.

It seems to me as well.

Thanks for brainstorming.

