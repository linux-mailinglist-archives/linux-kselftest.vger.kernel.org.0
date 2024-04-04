Return-Path: <linux-kselftest+bounces-7219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CC898D8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C804B28A783
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9512FB0A;
	Thu,  4 Apr 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+d6WqOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C512E1C7
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253418; cv=none; b=IVPHhy5/QP19ppiHP7zSJvqs0g8QczbNdsLOfPiemHvDS4vLcr5m+rDnt4K+9H+3Tqvos0/rnryU9PE6YIlFWqr08jrgzRtTYDMZOZXcXuag5L8jloxeJn9NcQOU0BHQDHQ4IgSJfBSkkp1F7B9bs7D8/5Zj2bwfjGZJfc8PY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253418; c=relaxed/simple;
	bh=L5Z1KtHeSyCWra/ak3cQEWjMPwF+P9JaVwq4yTb9K4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Co2zIx4W72pgn+RFjCTQVisEgCpsm2togfhT9kim+erSu3JzQjrxvKNlCIy3Gl6wyDaiWWrZHotbrc27tszzbdBRUijzPDfdd/Kt+hDzza9A79853jzfEHOrTEAtm43HM6s/Pi2cU6k7iQVCGAI/DKc0ejjWN+KAm5cOmDCiD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+d6WqOC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712253416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+nUddKgnGzsUpVaJmj75uqcQku+cMdBtxn5p2n0yuI=;
	b=V+d6WqOC8i68lBj7CG7QlzEvKNghzppgCYAVjLe9K2Yd5FcWiUZc2kV4tazAFHOYqqgNm2
	ynGbXSQI+RUXUVuFJA9oaYl1CnX1656imAjZ91kdwZjD/TIonMxGFBuJHXIBpqgKToapH/
	YX+Fj7kfEP+bkTgFQFVWhK1uqK1SWWU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-4Yqf9PwCNlmd9raD5tU8zw-1; Thu, 04 Apr 2024 13:56:54 -0400
X-MC-Unique: 4Yqf9PwCNlmd9raD5tU8zw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56c3dc8d331so901983a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 10:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253412; x=1712858212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+nUddKgnGzsUpVaJmj75uqcQku+cMdBtxn5p2n0yuI=;
        b=FJcoypKiWsJ17O+HM6vpTxi/urRuluvH5dJSZ6/8pAokVMBJaQVh1dHMtnU1XIlw6D
         41GGbekrPaHin4UMYnwEG584xgfLYPk/zDlcW1iSxpnfuH9/2hU2fF+4voKeCyGEBt+Y
         2geFzm9dYs97bQFsOrJ00qFpOrJYnXGZvIsm32/RfzwNJ7/6ZVJC3+zb65uW0AUFBY9l
         fjCoitcRLkYui4OUEEUbdE/9b5o15EvcsUgZYHHz19hG0XIBnxEuKacWZN/Z2pdeJ6vi
         ezpoITZPbfW0nRzLCYHO+bq+LM8b3j6WVPH+CqWtPj0qvTO779Sn6xGtrbEM5RuHFvbI
         Tcyw==
X-Forwarded-Encrypted: i=1; AJvYcCWG+IIvLnAbWiKKPwR4AcMdgdd+d/NkjpFmQRXP8ZDiq8L3aN4bEMsTww22nEvUAJy/mqdVOqruTCd38nwvvP89woE3UkDmSDjmltHEcsRz
X-Gm-Message-State: AOJu0YwiLtS9tl9iLxhpaDMoHW8fWChD2V8RNEGsSn933YYw4DinX3rJ
	Dm5ZJP/l/UZNpj8NYAz91PAry2jbG38Urkh/AxLJHW6I9AMOM8QK5WfV/OGEegFjNtIbtre0VfM
	Aar6BiicKHjE6DVMWNdqw8NdOPpF7PXJfW1IGsZtGBuRjuEMdSNaxSNQZHGFb+66kdEBDCFenDO
	Oy8b/cD9iJ8SOWQuLpRn+QyNCQHcU/YTSqk/hNsXjsTxtlCXx16X0=
X-Received: by 2002:a50:9507:0:b0:568:be6d:e5e5 with SMTP id u7-20020a509507000000b00568be6de5e5mr333056eda.37.1712253412427;
        Thu, 04 Apr 2024 10:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuz2mJfdvVKG6SKd8f9ftw27WMcaZq7NnSkL5KWH2HoMuzr3TqXfYdrtJVmeNRE9cwC4MBtAopilPOb6UUhTw=
X-Received: by 2002:a50:9507:0:b0:568:be6d:e5e5 with SMTP id
 u7-20020a509507000000b00568be6de5e5mr333045eda.37.1712253412054; Thu, 04 Apr
 2024 10:56:52 -0700 (PDT)
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
 <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com> <CAADnVQ+gikPakTuYpD4-oxS6yS5-Dd_HanfqyNnGW-nk7=eXNg@mail.gmail.com>
In-Reply-To: <CAADnVQ+gikPakTuYpD4-oxS6yS5-Dd_HanfqyNnGW-nk7=eXNg@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 4 Apr 2024 19:56:39 +0200
Message-ID: <CAO-hwJLz4ET8Rba-_8icR+7t9T63BPnf97JrSFjviJWG+i8dVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Apr 4, 2024 at 6:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 8:27=E2=80=AFAM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> >
> > >
> > > So we need something like:
> > >
> > > struct bpf_hrtimer {
> > >   union {
> > >     struct hrtimer timer;
> > > +   struct work_struct work;
> > >   };
> > >   struct bpf_map *map;
> > >   struct bpf_prog *prog;
> > >   void __rcu *callback_fn;
> > >   void *value;
> > >   union {
> >
> > Are you sure we need an union here? If we get to call kfree_rcu() we
> > need to have both struct rcu_head and sync_work, not one or the other.
>
> why? with an extra flag it's one or the other.
> In bpf_timer_cancel_and_free()
> if (flag & SLEEPABLE) {
>     schedule_work() to cancel_work_sync + kfree_rcu
> } else {
>    hrtimer_cancel
>    kfree_rcu
> }

I thought kfree_rcu required struct rcu_head, and given that we need
to initialize sync_work it will be poisoned...

>
> > >     struct rcu_head rcu;
> > > +   struct work_struct sync_work;
> > >   };
> > > + u64 flags; // bpf_timer_init() will require BPF_F_TIMER_SLEEPABLE
> >
> > If I understand, you want BPF_F_TIMER_SLEEPABLE in bpf_timer_init()
> > (like in my v2 or v3 IIRC). But that means that once a timer is
> > initialized it needs to be of one or the other type (especially true
> > with the first union in this struct).
>
> yes. That's an idea.
> The code to support wq vs timer seems to be diverging more
> than what we expected initially.
> It seems cleaner to set it as init time and enforce in
> other helpers.

OK, works for me.

>
> Also with two work_struct-s we're pushing the sizeof(bpf_hrtimer)
> too far.
> It's already at 112 bytes and some people use bpf_timer per flow.
> So potentially millions of such timers.
> Adding extra sizeof(struct work_struct)=3D32 * 2 that won't be
> used is too much.
> Note that sizeof(struct hrtimer)=3D64, so unions make everything
> fit nicely.

Maybe we should do
union {
  struct hrtimer timer;
  struct {
    struct work_struct work;
    struct work_struct sync_work;
  }
}

(not nice to read but at least we don't change the size at the beginning)

>
> > So should we reject during run time bpf_timer_set_callback() for
> > sleepable timers and only allow bpf_timer_set_sleepable_cb() for
> > those? (and the invert in the other case).
>
> yes.
>
> > This version of the patch allows for one timer to be used as softIRQ
> > or WQ, depending on the timer_set_callback that is used. But it might
> > be simpler for the kfree_rcu race to define the bpf_timer to be of one
> > kind, so we are sure to call the correct kfree method.
>
> I think one or another simplifies the code and makes it easier
> to think through combinations.
>
> I'm still contemplating adding new "struct bpf_wq" and new kfuncs
> to completely separate wq vs timer.
> The code reuse seems to be relatively small.

There is some code reuse in the verifier, but it can be factored out I thin=
k.

Though the biggest reuse might be in the map portion of bpf_timer,
which I haven't looked much TBH.

> We can potentially factor out internals of bpf_timer_* into smaller
> helpers and use them from bpf_timer_* and from new bpf_wq_* kfuncs.

Yeah, also, given that we are going to enforce delay =3D=3D 0 for
sleepable timers (wq), the user api would be much cleaner if we can
have a dedicated bpf_wq (and it would make the flags of bpf_timer_init
easier to deal with).

>
> One more thing.
> bpf_timer_cancel() api turned out to be troublesome.
> Not only it cancels the timer, but drops callback too.
> It was a surprising behavior for people familiar with
> kernel timer api-s.
> We should not repeat this mistake with wq.
>
> We can try to fix bpf_timer_cancel() too.
> If we drop drop_prog_refcnt() from it it shouldn't affect
> existing bpf_timer users who are forced to do:
> bpf_timer_cancel()
> bpf_timer_set_callback()
> bpf_timer_start()
> all the time.
> If/when bpf_timer_cancel() stops dropping the callback
> such bpf prog won't be affected. So low chance of breaking any prog.
> wdyt?
>

How would a program know set_callback() is not required after a
cancel() because the kernel kept it around? It seems that it's going
to be hard for them to know that (unless by trying first a start()),
and it will add more code.

timer_cancel() would be hard to change but we can always do the change
and add a new kfunc timer_cancel_no_drop() which would clearly allow
for new programs to know that set_callback() is not required to be
called. In a few kernel releases we could remove it and say that
timer_cancel() is the same (and replaced by a #define)

Anyway, the more I think of it, the more I think the best API would be
a dedicated wq API. It's probably going to need a little bit more
work, but it'll be more or less this work plus the new bpf_wq type in
the map.

Cheers,
Benjamin


