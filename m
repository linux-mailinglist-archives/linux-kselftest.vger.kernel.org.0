Return-Path: <linux-kselftest+bounces-7160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C4897DD0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 04:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496B11F277A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 02:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FB1CAB3;
	Thu,  4 Apr 2024 02:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml1OKUNZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB751C6B8;
	Thu,  4 Apr 2024 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198639; cv=none; b=JawYT78KR+OlJow0YFR4z5UdKIESLQc2W29vhslma4kpYafAH3NnGXYtEGxfEALaH7pyF+ECmvDKQ+O137oPxvRvirLplcW4bGHZ9l+11/6M1OCmmTeQXvVdus7weqojZTFJ7sEiX/Ez+meZAuekWDRB+dRx0lwl87Pn+7MmSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198639; c=relaxed/simple;
	bh=psKIdU+U6l+b2x6/tbZHXd8caIyW0jeCMOT7oTXRN7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUE5Q05yI8FkB8wQQa3QWPUJ8YuDmQWN4fo/3TwGuB+tS5Vhpgz8Iso+SRMyAtz0yBm94+m7LY8VpvYzShi+ijEnHWrb9be3l20m90UL5G2F6zNsCv7ZuT32iHoEJ/oBIhMN5tARsBlnyi3HVi9oEfORrTwIWibzC0uMKVZ/2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml1OKUNZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3437f70078bso307900f8f.3;
        Wed, 03 Apr 2024 19:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712198636; x=1712803436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y7dHKRjB0zo0YRtbmypS2ui7XH0taREWt+E0r4Nb5M=;
        b=Ml1OKUNZpMk7pgxzkX2agyQzjWVlo5n6oPO3wZozcya6dKGyNXJUSDHKfWBzVA/ndF
         XdH++BmjrMlX8Xk60EH9KPKUp6vaBzdji0vGdBVb/EY2l1Mlzyep78B7tytyB8QZeuc4
         tdwv+dnEmZuAoJCec6zTxXJ2/LwvVJ4a2rAxtc8JHx+Xrmr3orCt4D74RDJdDcvwhmTs
         EO6RgAmzD//3VuLm5A8zLE1bTlsLYLrNGDoWTALtsMcYdj+WFAyGSZ4Uv/BpGBH0KLXX
         3A/z/XHWm35di6r1xArcHsBiw/On8o6GOGKVzViYA7t2wRgjQbSGVM+KpwWTDaHdqFr7
         5H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712198636; x=1712803436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y7dHKRjB0zo0YRtbmypS2ui7XH0taREWt+E0r4Nb5M=;
        b=RyNAWiSXR+C0UAb58pAv65S0/M+kLkWdXEniHEyVHl+p7GzlbIM8WVrDdBdDsd5e/N
         kDTHu2kVVtaAh7Ce3li+68YKay/5BP2yiqRYIeo/TmkE12g9Vnw9HiVSFPObUIlPiaBA
         IHtkyVjMsHqoON8ZLR5N1oXpxZ47dG3dvvMY/PbCEqh/3IH3f5nNEPAq6UjCpUFPCVB6
         PVdBPXZnoVBU9bLyuADQM9l42hyLt/+HZP8/diTFAxni4ENGbDBp/yTtxJTkeHZWeZF4
         iIk46ahi/hKEbeeCVyEY7Ria2kSnRUsna0OhCHqYFNIFQK0HqNZJJlRC2tt6LciYoL+q
         VQWw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8s1YNDzw1gLnm8yUUgG/P5QJtmKdWgZMksvkbAQ+MIy+vUOxKEAudYTY+vegKa4c2QYv9cJ9v6vlOOI6eesWfPgA0md8F8TSzTlRWRzaR0ZCE2Yop85B+kQ8AMsrVUoLQO8yWdR6LEJWhXZtCyzpFL1DnwfzLpQ17jFKq3RirgdY
X-Gm-Message-State: AOJu0YxxcdRAYcIgkSbO8ziAgFrwXPG5Z7K/VwBwOgU96hZX4peU8Gmc
	Y0Di1ErfUnc03xCCGs8q4IbpQkWsrXS/2V9G0BelwAQ901peXKmqoojAFHhEqA4fRFWJBSsF/RX
	tjaLipXNrZdA0D/ko5jOJHcNqyKA=
X-Google-Smtp-Source: AGHT+IEbABigFe63amT35wtdQVD4Q/CUivZtkYCckUplPjhTQD37UQU4l1k5W9I/nWf0gYz6cC3AKVy9xgChXLB5k9E=
X-Received: by 2002:adf:a21a:0:b0:33d:64c7:5619 with SMTP id
 p26-20020adfa21a000000b0033d64c75619mr639707wra.70.1712198635659; Wed, 03 Apr
 2024 19:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
 <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com> <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
In-Reply-To: <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 19:43:44 -0700
Message-ID: <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com>
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

On Wed, Apr 3, 2024 at 6:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 11:50=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 10:02=E2=80=AFAM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > > > >                 goto out;
> > > > >         }
> > > > > +       spin_lock(&t->sleepable_lock);
> > > > >         drop_prog_refcnt(t);
> > > > > +       spin_unlock(&t->sleepable_lock);
> > > >
> > > > this also looks odd.
> > >
> > > I basically need to protect "t->prog =3D NULL;" from happening while
> > > bpf_timer_work_cb is setting up the bpf program to be run.
> >
> > Ok. I think I understand the race you're trying to fix.
> > The bpf_timer_cancel_and_free() is doing
> > cancel_work()
> > and proceeds with
> > kfree_rcu(t, rcu);
> >
> > That's the only race and these extra locks don't help.
> >
> > The t->prog =3D NULL is nothing to worry about.
> > The bpf_timer_work_cb() might still see callback_fn =3D=3D NULL
> > "when it's being setup" and it's ok.
> > These locks don't help that.
> >
> > I suggest to drop sleepable_lock everywhere.
> > READ_ONCE of callback_fn in bpf_timer_work_cb() is enough.
> > Add rcu_read_lock_trace() before calling bpf prog.
> >
> > The race to fix is above 'cancel_work + kfree_rcu'
> > since kfree_rcu might free 'struct bpf_hrtimer *t'
> > while the work is pending and work_queue internal
> > logic might UAF struct work_struct work.
> > By the time it may luckily enter bpf_timer_work_cb() it's too late.
> > The argument 'struct work_struct *work' might already be freed.
> >
> > To fix this problem, how about the following:
> > don't call kfree_rcu and instead queue the work to free it.
> > After cancel_work(&t->work); the work_struct can be reused.
> > So set it up to call "freeing callback" and do
> > schedule_work(&t->work);
> >
> > There is a big assumption here that new work won't be
> > executed before cancelled work completes.
> > Need to check with wq experts.
> >
> > Another approach is to do something smart with
> > cancel_work() return code.
> > If it returns true set a flag inside bpf_hrtimer and
> > make bpf_timer_work_cb() free(t) after bpf prog finishes.
>
> Looking through wq code... I think I have to correct myself.
> cancel_work and immediate free is probably fine from wq pov.
> It has this comment:
>         worker->current_func(work);
>         /*
>          * While we must be careful to not use "work" after this, the tra=
ce
>          * point will only record its address.
>          */
>         trace_workqueue_execute_end(work, worker->current_func);
>
> the bpf_timer_work_cb() might still be running bpf prog.
> So it shouldn't touch 'struct bpf_hrtimer *t' after bpf prog returns,
> since kfree_rcu(t, rcu); could have freed it by then.
> There is also this code in net/rxrpc/rxperf.c
>         cancel_work(&call->work);
>         kfree(call);

Correction to correction.
Above piece in rxrpc is buggy.
The following race is possible:
cpu 0
process_one_work()
set_work_pool_and_clear_pending(work, pool->id, 0);

    cpu 1
    cancel_work()
    kfree_rcu(work)

worker->current_func(work);

Here 'work' is a pointer to freed memory.
Though wq code will not be touching it, callback will UAF.

Also what I proposed earlier as:
INIT_WORK(A); schedule_work(); cancel_work(); INIT_WORK(B); schedule_work()=
;
won't guarantee the ordering.
Since the callback function is different,
find_worker_executing_work() will consider it a separate work item.

Another option is to to keep bpf_timer_work_cb callback
and add a 'bool free_me;' to struct bpf_hrtimer
and let the callback free it.
But it's also racy.
cancel_work() may return false, though worker->current_func(work)
wasn't called yet.
So we cannot set 'free_me' in bpf_timer_cancel_and_free()
in race free maner.

After brainstorming with Tejun it seems the best is to use
another work_struct to call a different callback and do
cancel_work_sync() there.

So we need something like:

struct bpf_hrtimer {
  union {
    struct hrtimer timer;
+   struct work_struct work;
  };
  struct bpf_map *map;
  struct bpf_prog *prog;
  void __rcu *callback_fn;
  void *value;
  union {
    struct rcu_head rcu;
+   struct work_struct sync_work;
  };
+ u64 flags; // bpf_timer_init() will require BPF_F_TIMER_SLEEPABLE
 };

'work' will be used to call bpf_timer_work_cb.
'sync_work' will be used to call cancel_work_sync() + kfree_rcu().

And, of course,
schedule_work(&t->sync_work); from bpf_timer_cancel_and_free()
instead of kfree_rcu.

