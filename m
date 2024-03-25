Return-Path: <linux-kselftest+bounces-6526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E87889747
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 10:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BAE1F378A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053B13B595;
	Mon, 25 Mar 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmMVSH4m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409271752;
	Mon, 25 Mar 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711327521; cv=none; b=e5A2480Mz/9HhOg/2upJcCCugXn5bK3g+JQcWfilbOHHccYpCC5RdWpsIUsvI0ngkxfiDozKjAWFdLyN9Wn3IsARFFudGbBAUSzORBNhFyYFpL2BP7jA7sSbp5cBGliLECcoMdhwYx8m+KGY74UDJB/7Vd6ogWA2aN7CXQrOpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711327521; c=relaxed/simple;
	bh=GQnkI34JwPVeoy/b99Bb5KkKeULjUupOcGCKtffSV2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InVeaN137moOYogvp3TwzTkl0sRjGhqgVIkLms13eKOzhE+UFsCntAJ7o7TTOHpUmDYWeP9goDkzY7+rb9nuESyDayolCoAELuAOM+99W80eaw9XGhVEbre5aaQgtVkRdq329wnOJXd7uuuiy6npyiKb3bm5mJWW/tJ7AeRLjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmMVSH4m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so2749039f8f.1;
        Sun, 24 Mar 2024 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711327517; x=1711932317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFHTCkHsp3z4Z58A/RrTwNT63vqGSQmFCkPu+M5aF5c=;
        b=NmMVSH4mG+bR8RJzRF5hKoVUzeq8QCUmn77ViL8aQXFtFV/CjuI6RHCzMjVBMCHs/n
         2ESSKdmJQbGrFwtLXUvDKh/mC8g7dWwUJ4NzAqYAHbO42SssBfTYHq0rYgqvB5FcCOnl
         xNSMvBJD1A3O1mxj6X1Qulp2nkpr9Cc7hh2mGMK9bqq/86wnBhgScQzTeaXsf2bAaLcd
         c7WIs0NuVN3wW2tlYan6eXMUp+zJBO7ZNEBoQeCU6vuelrgAKWH3W1LFY5dJkmwdK+bH
         BRKRgJn5bt4ZYpWY/TN+Nkfsbi7U7fJGYc3m3/eu3dEK+uP8EBoGEzJ3grGvwiNKjFf+
         ODkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711327517; x=1711932317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFHTCkHsp3z4Z58A/RrTwNT63vqGSQmFCkPu+M5aF5c=;
        b=bN9JG5A8A8QUX3metJ63hp1zaB2WzfwDNhCHZJWQ9srtmKtoW/DzickAx1iIt1udJH
         YxB2UVCluxsP20VGnJ9KuGY5KlUEA9VjwxB/b0SctIIDcI0WvbtCU6+cmeQ1Px9rSrgE
         EONxBHJb1h9mmHgNGsaGl/GRab5qyDs+Htqy6Jce+K8iyZAYDdiWImMGoqWe9EhdEzMy
         oq+hKO6z+K4f81gR6fvwNfx5SV+gilK/KVFIxKg8yRsOUtiUq4jpYFREvcsQOoLkqefL
         c+6OnLa5mTT5D8PmWR9qghQh0JYbWKmoP3b+pSoEPu0+Uv+YofYLEvvSzq4UGXzPV/oF
         wauw==
X-Forwarded-Encrypted: i=1; AJvYcCWnzPsDzndtkjcesJzpiZUDOWzb7ZFPwO0cliUoF1ygQNdpdnXfa3tEWe1GSgs6QotvrSdvpBwODvSd3Zrf8ITdi8FYjsaDY50NDdV1eBaVHgx9U/L3gYk+2tNHwzpGg82XB+BEahg90idq2rvJxwsCddhSq4RUPR2OiUadH8Jc4nAq
X-Gm-Message-State: AOJu0Yx6fh/zDYSanDu8264l8MSQ/M1EUL6BF5CANf4VVxAxMtjclZwM
	vnDX6YCwWHjUfwTuuF2RPxf9eV8CWLi2Phe+QMkIi4bgK1n60EeXL4cJDCyuIGguAoN4PRuDcS4
	T8d0X+GP730WV+TLkojvdnarIlzE=
X-Google-Smtp-Source: AGHT+IHoFwtbbPCEgmLxbNI8dDwg4hVtyd2nysCsbGqUOieqzWjZ9ExVaevFZsa/+n0x6wLZaTYo6vrsF8j2i6DYHxs=
X-Received: by 2002:adf:e102:0:b0:33d:754c:70fc with SMTP id
 t2-20020adfe102000000b0033d754c70fcmr3468297wrz.14.1711327517329; Sun, 24 Mar
 2024 17:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org> <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org>
In-Reply-To: <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 17:45:05 -0700
Message-ID: <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 7:56=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> They are implemented as a workqueue, which means that there are no
> guarantees of timing nor ordering.
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> no changes in v5
>
> changes in v4:
> - dropped __bpf_timer_compute_key()
> - use a spin_lock instead of a semaphore
> - ensure bpf_timer_cancel_and_free is not complaining about
>   non sleepable context and use cancel_work() instead of
>   cancel_work_sync()
> - return -EINVAL if a delay is given to bpf_timer_start() with
>   BPF_F_TIMER_SLEEPABLE
>
> changes in v3:
> - extracted the implementation in bpf_timer only, without
>   bpf_timer_set_sleepable_cb()
> - rely on schedule_work() only, from bpf_timer_start()
> - add semaphore to ensure bpf_timer_work_cb() is accessing
>   consistent data
>
> changes in v2 (compared to the one attaches to v1 0/9):
> - make use of a kfunc
> - add a (non-used) BPF_F_TIMER_SLEEPABLE
> - the callback is *not* called, it makes the kernel crashes
> ---
>  include/uapi/linux/bpf.h |  4 +++
>  kernel/bpf/helpers.c     | 86 ++++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3c42b9f1bada..b90def29d796 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7461,10 +7461,14 @@ struct bpf_core_relo {
>   *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it=
 is
>   *       relative to current time.
>   *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the cal=
ler.
> + *     - BPF_F_TIMER_SLEEPABLE: Timer will run in a sleepable context, w=
ith
> + *       no guarantees of ordering nor timing (consider this as being ju=
st
> + *       offloaded immediately).
>   */
>  enum {
>         BPF_F_TIMER_ABS =3D (1ULL << 0),
>         BPF_F_TIMER_CPU_PIN =3D (1ULL << 1),
> +       BPF_F_TIMER_SLEEPABLE =3D (1ULL << 2),
>  };
>
>  /* BPF numbers iterator state */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a89587859571..38de73a9df83 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1094,14 +1094,20 @@ const struct bpf_func_proto bpf_snprintf_proto =
=3D {
>   * bpf_timer_cancel() cancels the timer and decrements prog's refcnt.
>   * Inner maps can contain bpf timers as well. ops->map_release_uref is
>   * freeing the timers when inner map is replaced or deleted by user spac=
e.
> + *
> + * sleepable_lock protects only the setup of the workqueue, not the call=
back
> + * itself. This is done to ensure we don't run concurrently a free of th=
e
> + * callback or the associated program.

I recall there was a discussion about this lock earlier,
but I don't remember what the conclusion was.
The above comment is not enough to understand what it protects.

In general how sleepable cb is fundamentally different
from non-sleepable one when it comes to races ?

bpf_timer_set_callback() is racy for both sleepable and non-sleepable
and the latter handles it fine.

Note that struct bpf_hrtimer is rcu protected.
See kfree_rcu(t, rcu); in bpf_timer_cancel_and_free().

>   */
>  struct bpf_hrtimer {
>         struct hrtimer timer;
> +       struct work_struct work;
>         struct bpf_map *map;
>         struct bpf_prog *prog;
>         void __rcu *callback_fn;
>         void *value;
>         struct rcu_head rcu;
> +       spinlock_t sleepable_lock;
>  };
>
>  /* the actual struct hidden inside uapi struct bpf_timer */
> @@ -1114,6 +1120,49 @@ struct bpf_timer_kern {
>         struct bpf_spin_lock lock;
>  } __attribute__((aligned(8)));
>
> +static void bpf_timer_work_cb(struct work_struct *work)
> +{
> +       struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer, =
work);
> +       struct bpf_map *map =3D t->map;
> +       bpf_callback_t callback_fn;
> +       void *value =3D t->value;
> +       unsigned long flags;
> +       void *key;
> +       u32 idx;
> +
> +       BTF_TYPE_EMIT(struct bpf_timer);
> +
> +       spin_lock_irqsave(&t->sleepable_lock, flags);
> +
> +       callback_fn =3D READ_ONCE(t->callback_fn);
> +       if (!callback_fn) {
> +               spin_unlock_irqrestore(&t->sleepable_lock, flags);
> +               return;
> +       }
> +
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> +               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
> +
> +               /* compute the key */
> +               idx =3D ((char *)value - array->value) / array->elem_size=
;
> +               key =3D &idx;
> +       } else { /* hash or lru */
> +               key =3D value - round_up(map->key_size, 8);
> +       }
> +
> +       /* prevent the callback to be freed by bpf_timer_cancel() while r=
unning
> +        * so we can release the sleepable lock
> +        */
> +       bpf_prog_inc(t->prog);
> +
> +       spin_unlock_irqrestore(&t->sleepable_lock, flags);

why prog_inc ?
The sleepable progs need rcu_read_lock_trace() + migrate_disable()
anyway, which are missing here.
Probably best to call __bpf_prog_enter_sleepable_recur()
like kern_sys_bpf() does.

Now with that, the bpf_timer_cancel() can drop prog refcnt to zero
and it's ok, since rcu_read_lock_trace() will protect it.

> +
> +       callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, =
0);
> +       /* The verifier checked that return value is zero. */

the prog will finish and will be freed after rcu_read_unlock_trace().
Seems fine to me. No need for inc/dec refcnt.

> +
> +       bpf_prog_put(t->prog);
> +}
> +
>  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
> @@ -1192,6 +1241,8 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *,=
 timer, struct bpf_map *, map
>         t->prog =3D NULL;
>         rcu_assign_pointer(t->callback_fn, NULL);
>         hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
> +       INIT_WORK(&t->work, bpf_timer_work_cb);
> +       spin_lock_init(&t->sleepable_lock);
>         t->timer.function =3D bpf_timer_cb;
>         WRITE_ONCE(timer->timer, t);
>         /* Guarantee the order between timer->timer and map->usercnt. So
> @@ -1237,6 +1288,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer=
_kern *, timer, void *, callb
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> +       spin_lock(&t->sleepable_lock);
>         if (!atomic64_read(&t->map->usercnt)) {
>                 /* maps with timers must be either held by user space
>                  * or pinned in bpffs. Otherwise timer might still be
> @@ -1263,6 +1315,8 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer=
_kern *, timer, void *, callb
>         }
>         rcu_assign_pointer(t->callback_fn, callback_fn);
>  out:
> +       if (t)
> +               spin_unlock(&t->sleepable_lock);
>         __bpf_spin_unlock_irqrestore(&timer->lock);

If lock is really needed why timer->lock cannot be reused?
The pattern of two locks in pretty much the same data structure
is begging for questions about what is going on here.

>         return ret;
>  }
> @@ -1283,8 +1337,12 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern =
*, timer, u64, nsecs, u64, fla
>
>         if (in_nmi())
>                 return -EOPNOTSUPP;
> -       if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> +       if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER=
_SLEEPABLE))
>                 return -EINVAL;
> +
> +       if ((flags & BPF_F_TIMER_SLEEPABLE) && nsecs)
> +               return -EINVAL;
> +
>         __bpf_spin_lock_irqsave(&timer->lock);
>         t =3D timer->timer;
>         if (!t || !t->prog) {
> @@ -1300,7 +1358,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern =
*, timer, u64, nsecs, u64, fla
>         if (flags & BPF_F_TIMER_CPU_PIN)
>                 mode |=3D HRTIMER_MODE_PINNED;
>
> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +       if (flags & BPF_F_TIMER_SLEEPABLE)
> +               schedule_work(&t->work);
> +       else
> +               hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>  out:
>         __bpf_spin_unlock_irqrestore(&timer->lock);
>         return ret;
> @@ -1348,13 +1409,22 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_ker=
n *, timer)
>                 ret =3D -EDEADLK;
>                 goto out;
>         }
> +       spin_lock(&t->sleepable_lock);
>         drop_prog_refcnt(t);
> +       spin_unlock(&t->sleepable_lock);

this also looks odd.

>  out:
>         __bpf_spin_unlock_irqrestore(&timer->lock);
>         /* Cancel the timer and wait for associated callback to finish
>          * if it was running.
>          */
>         ret =3D ret ?: hrtimer_cancel(&t->timer);
> +
> +       /* also cancel the sleepable work, but *do not* wait for
> +        * it to finish if it was running as we might not be in a
> +        * sleepable context
> +        */
> +       ret =3D ret ?: cancel_work(&t->work);
> +
>         rcu_read_unlock();
>         return ret;
>  }
> @@ -1383,11 +1453,13 @@ void bpf_timer_cancel_and_free(void *val)
>         t =3D timer->timer;
>         if (!t)
>                 goto out;
> +       spin_lock(&t->sleepable_lock);
>         drop_prog_refcnt(t);
>         /* The subsequent bpf_timer_start/cancel() helpers won't be able =
to use
>          * this timer, since it won't be initialized.
>          */
>         WRITE_ONCE(timer->timer, NULL);
> +       spin_unlock(&t->sleepable_lock);

This one I don't understand either.

pw-bot: cr

