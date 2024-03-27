Return-Path: <linux-kselftest+bounces-6721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF7D88EC03
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032DEB23502
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94F14D6EA;
	Wed, 27 Mar 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp0UnKHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EB148835
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558949; cv=none; b=jGXpD7ucZwcTy4gZiNy9uYKItv1ZKQ9ecJ5/fdbvfhlbufeMQcewPXcrem9AF1Q0Irk606ofm4UM8FU6ws2AL3iUh8RyC0URByMTxqNjTpoW8XIOL5Eiy/FQwvNb+VB+7IXKSFaM68LYUweyerpfBiSuZFVjOXm7Igm2lKemrPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558949; c=relaxed/simple;
	bh=tco6ZVQyvJdkc86E7n6MVZLMiHRD/WuMVxniFLNJfBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eodUQuWsQH2SP+YdYNaO0VufsQKQsvCmW8CPApumdZvPLKuAgE4+HbLRg9rRxQ600ZHRr8b6U0wVlPpyaeo8fNmJTEDxiLtb5vkXcDQIP6XTgqL/3DpA062x0s+iBBxd2Pb2XihGfV1rRiQIJtQgzUYBajewpzI+qlMhxqV0BYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fp0UnKHS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711558946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0A1JLMQh+h+WzgQyGtWZmREpjmRelVOHA7aXCkcHag0=;
	b=Fp0UnKHSZF3Z92epaGVZrd3QEbGFIo2dUcPx0HzyKMC0U1FXaJKb+JHVtqDNWvQ344pyDv
	L9XAtIoPSF09e13xqhPvUvpPY4CG7NaUfJzjgalPywq3DMYOR/pPY9EWavi/j2mqN47H7S
	np79fyBhRWgPDt0IG1Bf1f9Yk23jl7Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-j-3VvXRxMTek2gTvhhQTWg-1; Wed, 27 Mar 2024 13:02:24 -0400
X-MC-Unique: j-3VvXRxMTek2gTvhhQTWg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d6ebaf2199so19161501fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 10:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558942; x=1712163742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0A1JLMQh+h+WzgQyGtWZmREpjmRelVOHA7aXCkcHag0=;
        b=pzsHf7JusTQdeNe8geaRJgDxQU+bXG/k7AHs8yWOMeRdRoL2GdBYKUQSJw3Lo1zVoi
         aIHWlzU5/IKubgIQgwyFvIe+0gQSEaeI08EIt1Sks60oEE4MvmmrJodhBJ2JC4S0rMBO
         l5yHfGiPwSCb8/PuljW9evLaWjHwNh8t1tY6UoA/z1lGuffPvkvDRYsRjKdczSHHc2Tj
         W1+7a97/o7ZnlYelGR9DYLzRD8tcpH5IgaethLSFJc26tSvXRbw5cWyodJQvXviaSEI5
         UZHJfOy117eYnGluZvwRJRWiqs5FBdEOAjcUy95h/5kWb9xsv74gidv2Z9trB6WExW8F
         /ifQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB7G4dIywdR1B/XnVqpidIS/QoqZQBU2AbtcNtOPzL3GcdXf0em0YYbAmhOUk8u/AryTTUD1yDcBvZFnSJB0chiU6KPisD2bDYx36rbAYG
X-Gm-Message-State: AOJu0YyZHEP8pQv381hvu050e8R1Z4dracC17c/lKUbxBDbbZQ3Mp8cH
	c9gtuye8SiEonbLwnJVt+THyvVkOLMTJzwi7IOJ1ZBjubixCw7IYeCav4Mj0H7s3cQKHaVFogJ0
	kzhdwfuQ3Gn3cmAcQzYkMgL8yD7PyR/sMOf3cDA1HIRwAfw6EplANgMCBztP+IzyY4jUS883Ax1
	gGXJJ4sV1gOFBGuGRpwwrUoQOD1CYQXkUTAA0sqL8o
X-Received: by 2002:a2e:978c:0:b0:2d2:4783:872a with SMTP id y12-20020a2e978c000000b002d24783872amr99349lji.29.1711558941973;
        Wed, 27 Mar 2024 10:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbnH0NzFvaHV3NvKxHWq1yw15L4GXvDmDRNt1vWzEyHXelqw8YysCbzSzMo9N0avkk3+Ria5F7M3q6C79fdqA=
X-Received: by 2002:a2e:978c:0:b0:2d2:4783:872a with SMTP id
 y12-20020a2e978c000000b002d24783872amr99318lji.29.1711558941510; Wed, 27 Mar
 2024 10:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
In-Reply-To: <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 27 Mar 2024 18:02:09 +0100
Message-ID: <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
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

On Mon, Mar 25, 2024 at 1:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 7:56=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
> >
> > They are implemented as a workqueue, which means that there are no
> > guarantees of timing nor ordering.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
> >
> > no changes in v5
> >
> > changes in v4:
> > - dropped __bpf_timer_compute_key()
> > - use a spin_lock instead of a semaphore
> > - ensure bpf_timer_cancel_and_free is not complaining about
> >   non sleepable context and use cancel_work() instead of
> >   cancel_work_sync()
> > - return -EINVAL if a delay is given to bpf_timer_start() with
> >   BPF_F_TIMER_SLEEPABLE
> >
> > changes in v3:
> > - extracted the implementation in bpf_timer only, without
> >   bpf_timer_set_sleepable_cb()
> > - rely on schedule_work() only, from bpf_timer_start()
> > - add semaphore to ensure bpf_timer_work_cb() is accessing
> >   consistent data
> >
> > changes in v2 (compared to the one attaches to v1 0/9):
> > - make use of a kfunc
> > - add a (non-used) BPF_F_TIMER_SLEEPABLE
> > - the callback is *not* called, it makes the kernel crashes
> > ---
> >  include/uapi/linux/bpf.h |  4 +++
> >  kernel/bpf/helpers.c     | 86 ++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 88 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 3c42b9f1bada..b90def29d796 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7461,10 +7461,14 @@ struct bpf_core_relo {
> >   *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default =
it is
> >   *       relative to current time.
> >   *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the c=
aller.
> > + *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a sleepable context,=
 with
> > + *       no guarantees of ordering nor timing (consider this as being =
just
> > + *       offloaded immediately).
> >   */
> >  enum {
> >         BPF_F_TIMER_ABS =3D (1ULL << 0),
> >         BPF_F_TIMER_CPU_PIN =3D (1ULL << 1),
> > +       BPF_F_TIMER_SLEEPABLE =3D (1ULL << 2),
> >  };
> >
> >  /* BPF numbers iterator state */
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index a89587859571..38de73a9df83 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1094,14 +1094,20 @@ const struct bpf_func_proto bpf_snprintf_proto =
=3D {
> >   * bpf_timer_cancel() cancels the timer and decrements prog's refcnt.
> >   * Inner maps can contain bpf timers as well. ops->map_release_uref is
> >   * freeing the timers when inner map is replaced or deleted by user sp=
ace.
> > + *
> > + * sleepable_lock protects only the setup of the workqueue, not the ca=
llback
> > + * itself. This is done to ensure we don't run concurrently a free of =
the
> > + * callback or the associated program.
>
> I recall there was a discussion about this lock earlier,
> but I don't remember what the conclusion was.

There wasn't much of a conclusion TBH.

> The above comment is not enough to understand what it protects.
>
> In general how sleepable cb is fundamentally different
> from non-sleepable one when it comes to races ?

I think there are 2 main differences:
- it's sleepable, so classic RCU locking doesn't work (I didn't know
about rcu_read_lock_trace() up to now)
- when we cancel(_and_free) the program, we can not afford to wait for
the program to finish because that program might take ages to do so.

While OTOH, hrtimer callbacks are in soft IRQ, so with IRQ disabled,
and nothing can interrupt it AFAICT. We can also wait for the timer cb
to finish in that case because it can't sleep.

>
> bpf_timer_set_callback() is racy for both sleepable and non-sleepable
> and the latter handles it fine.

I don't think bpf_timer_set_callback() is the problem: in both cases
(sleepable or not) we are under the spinlock from bpf_timer_kern so
the race is cut short there.

>
> Note that struct bpf_hrtimer is rcu protected.
> See kfree_rcu(t, rcu); in bpf_timer_cancel_and_free().

Sorry, RCU is still always hard to grasp for me, and even if I think I
get it, I still don't see how this would be sufficient in sleepable
bpf_timer_work_cb() without any lock protecting the struct bpf_hrtimer
very first access.

>
> >   */
> >  struct bpf_hrtimer {
> >         struct hrtimer timer;
> > +       struct work_struct work;
> >         struct bpf_map *map;
> >         struct bpf_prog *prog;
> >         void __rcu *callback_fn;
> >         void *value;
> >         struct rcu_head rcu;
> > +       spinlock_t sleepable_lock;
> >  };
> >
> >  /* the actual struct hidden inside uapi struct bpf_timer */
> > @@ -1114,6 +1120,49 @@ struct bpf_timer_kern {
> >         struct bpf_spin_lock lock;
> >  } __attribute__((aligned(8)));
> >
> > +static void bpf_timer_work_cb(struct work_struct *work)
> > +{
> > +       struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer=
, work);
> > +       struct bpf_map *map =3D t->map;
> > +       bpf_callback_t callback_fn;
> > +       void *value =3D t->value;
> > +       unsigned long flags;
> > +       void *key;
> > +       u32 idx;
> > +
> > +       BTF_TYPE_EMIT(struct bpf_timer);
> > +
> > +       spin_lock_irqsave(&t->sleepable_lock, flags);
> > +
> > +       callback_fn =3D READ_ONCE(t->callback_fn);
> > +       if (!callback_fn) {
> > +               spin_unlock_irqrestore(&t->sleepable_lock, flags);
> > +               return;
> > +       }
> > +
> > +       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> > +               struct bpf_array *array =3D container_of(map, struct bp=
f_array, map);
> > +
> > +               /* compute the key */
> > +               idx =3D ((char *)value - array->value) / array->elem_si=
ze;
> > +               key =3D &idx;
> > +       } else { /* hash or lru */
> > +               key =3D value - round_up(map->key_size, 8);
> > +       }
> > +
> > +       /* prevent the callback to be freed by bpf_timer_cancel() while=
 running
> > +        * so we can release the sleepable lock
> > +        */
> > +       bpf_prog_inc(t->prog);
> > +
> > +       spin_unlock_irqrestore(&t->sleepable_lock, flags);
>
> why prog_inc ?
> The sleepable progs need rcu_read_lock_trace() + migrate_disable()
> anyway, which are missing here.
> Probably best to call __bpf_prog_enter_sleepable_recur()
> like kern_sys_bpf() does.

Sounds like a good idea.

But as I was playing with it, I realized that t->prog is not RCU
protected, so I have no guarantees that the value is correct while
calling __bpf_prog_enter_sleepable_recur(t->prog, &run_ctx)...

Should I manually call first rcu_read_lock_trace() before
__bpf_prog_enter_sleepable_recur(t->prog, &run_ctx)?

>
> Now with that, the bpf_timer_cancel() can drop prog refcnt to zero
> and it's ok, since rcu_read_lock_trace() will protect it.

OK, this is a good step forward, thanks!

>
> > +
> > +       callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0=
, 0);
> > +       /* The verifier checked that return value is zero. */
>
> the prog will finish and will be freed after rcu_read_unlock_trace().
> Seems fine to me. No need for inc/dec refcnt.

Ack

>
> > +
> > +       bpf_prog_put(t->prog);
> > +}
> > +
> >  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
> >
> >  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
> > @@ -1192,6 +1241,8 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern =
*, timer, struct bpf_map *, map
> >         t->prog =3D NULL;
> >         rcu_assign_pointer(t->callback_fn, NULL);
> >         hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
> > +       INIT_WORK(&t->work, bpf_timer_work_cb);
> > +       spin_lock_init(&t->sleepable_lock);
> >         t->timer.function =3D bpf_timer_cb;
> >         WRITE_ONCE(timer->timer, t);
> >         /* Guarantee the order between timer->timer and map->usercnt. S=
o
> > @@ -1237,6 +1288,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_tim=
er_kern *, timer, void *, callb
> >                 ret =3D -EINVAL;
> >                 goto out;
> >         }
> > +       spin_lock(&t->sleepable_lock);
> >         if (!atomic64_read(&t->map->usercnt)) {
> >                 /* maps with timers must be either held by user space
> >                  * or pinned in bpffs. Otherwise timer might still be
> > @@ -1263,6 +1315,8 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_tim=
er_kern *, timer, void *, callb
> >         }
> >         rcu_assign_pointer(t->callback_fn, callback_fn);
> >  out:
> > +       if (t)
> > +               spin_unlock(&t->sleepable_lock);
> >         __bpf_spin_unlock_irqrestore(&timer->lock);
>
> If lock is really needed why timer->lock cannot be reused?
> The pattern of two locks in pretty much the same data structure
> is begging for questions about what is going on here.

Agree, but I can't find a way to reuse timer->lock:
- ideally I should add struct work_struct into struct bpf_timer_kern
directly, but there is a warning about the size of bpf_timer_kern
which makes me feel like we can not extend it
- adding a pointer back from struct bpf_hrtimer to bpf_timer_kern is
also not a solution as we might be freed if we are outside of the lock
in bpf_timer_kern...

Though if I have reliable access from bpf_timer_work_cb() to the
matching bpf_timer_kern, I could spinlock ->lock while I need to
access ->timer, and then everything would be much easier.

>
> >         return ret;
> >  }
> > @@ -1283,8 +1337,12 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_ker=
n *, timer, u64, nsecs, u64, fla
> >
> >         if (in_nmi())
> >                 return -EOPNOTSUPP;
> > -       if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> > +       if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIM=
ER_SLEEPABLE))
> >                 return -EINVAL;
> > +
> > +       if ((flags & BPF_F_TIMER_SLEEPABLE) && nsecs)
> > +               return -EINVAL;
> > +
> >         __bpf_spin_lock_irqsave(&timer->lock);
> >         t =3D timer->timer;
> >         if (!t || !t->prog) {
> > @@ -1300,7 +1358,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_ker=
n *, timer, u64, nsecs, u64, fla
> >         if (flags & BPF_F_TIMER_CPU_PIN)
> >                 mode |=3D HRTIMER_MODE_PINNED;
> >
> > -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > +       if (flags & BPF_F_TIMER_SLEEPABLE)
> > +               schedule_work(&t->work);
> > +       else
> > +               hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> >  out:
> >         __bpf_spin_unlock_irqrestore(&timer->lock);
> >         return ret;
> > @@ -1348,13 +1409,22 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_k=
ern *, timer)
> >                 ret =3D -EDEADLK;
> >                 goto out;
> >         }
> > +       spin_lock(&t->sleepable_lock);
> >         drop_prog_refcnt(t);
> > +       spin_unlock(&t->sleepable_lock);
>
> this also looks odd.

I basically need to protect "t->prog =3D NULL;" from happening while
bpf_timer_work_cb is setting up the bpf program to be run.

>
> >  out:
> >         __bpf_spin_unlock_irqrestore(&timer->lock);
> >         /* Cancel the timer and wait for associated callback to finish
> >          * if it was running.
> >          */
> >         ret =3D ret ?: hrtimer_cancel(&t->timer);
> > +
> > +       /* also cancel the sleepable work, but *do not* wait for
> > +        * it to finish if it was running as we might not be in a
> > +        * sleepable context
> > +        */
> > +       ret =3D ret ?: cancel_work(&t->work);
> > +
> >         rcu_read_unlock();
> >         return ret;
> >  }
> > @@ -1383,11 +1453,13 @@ void bpf_timer_cancel_and_free(void *val)
> >         t =3D timer->timer;
> >         if (!t)
> >                 goto out;
> > +       spin_lock(&t->sleepable_lock);
> >         drop_prog_refcnt(t);
> >         /* The subsequent bpf_timer_start/cancel() helpers won't be abl=
e to use
> >          * this timer, since it won't be initialized.
> >          */
> >         WRITE_ONCE(timer->timer, NULL);
> > +       spin_unlock(&t->sleepable_lock);
>
> This one I don't understand either.

Same as above, I do not want t->prog to be set to NULL.

Also, side note: if anyone feels like it would go faster to fix those
races by themself instead of teaching me how to properly do it, this
is definitely fine from me :)

Cheers,
Benjamin


