Return-Path: <linux-kselftest+bounces-5307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3AE860408
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BE81C2428B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140571749;
	Thu, 22 Feb 2024 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL6N70+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A66E5E3;
	Thu, 22 Feb 2024 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635209; cv=none; b=iIitNdBDc+xe99SnOWhXkHCm67LeEXqbh7CvWxJbusdeVbGqmsrtRwv7KPz5fQo0amD07xyJ7f7pJY8j+9ahyvKFpGossMYmFUIGKwyQhJ9U5Hwbb2wZvLSDWNbahnipWbLH2XlFkxhL7vTmjGYjPON0D/F5I2YAQ3ANT85DeFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635209; c=relaxed/simple;
	bh=eyjeZcCLCTi4jrpIdDE5O7VkZlZmsd4qxF0wsl8QrJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r09LLDk3PrPRT089+1iCgyCzyiDCjIg/PiFkmjw/Aj9h4vXCe2DnTLiZXD8SS9hjq3/Z+SUPonasRDkjM+VpAy2qw62LILXxpIul1iVeQgv/TeZG20Pk0IUIxTL62m+UbNwr9CEW7M7yERPwkVtbyZtcp6QN+P4A7yDjfJGG2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL6N70+n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d28468666so117103f8f.0;
        Thu, 22 Feb 2024 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708635206; x=1709240006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JceZ3Vo9jkBaqN7Hbzl8yHHaM89HOhD751Rid2kTckg=;
        b=EL6N70+no0FDaVNKw0/qENHnLiyyuAfGqo/GX+coolbRN3moL1/vhX2gr6Ka+6igOY
         3jhR5vNVQfnSOQWKDVJDgEMMHIAm+0w1JjUVmMqrSKkUWysC/y1n0iKLSLlMA1v7YY1j
         w/1imxNMv5bi1rvXzt6Uz4q2shF4wN87gmaw20jpk8Whzllyy2j0uk0k2FiqK9Sh77WV
         SuaeItKKy1AuBJf+dU1p4Q095h6wW5lj0PZoYXQ+tQBMJq/16h2AOq8n1VDLoWWhgcA9
         g6+4VfG2GkDbl1XOyVX5uJ1YpEZip58m3Sej70XSo7G+oVvFJH8DHn+4BYXHgc9oqjoe
         mHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635206; x=1709240006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JceZ3Vo9jkBaqN7Hbzl8yHHaM89HOhD751Rid2kTckg=;
        b=CFTyVlpwuVu5wo2k/4SxqXfvOKAvksM+FQRVWox2D59IsxWVqWvJMZfdQM5rIHH92m
         JUYDwQQlGxtjLQdQkLmVlBdI2VvjiIQZEF4tBqSYj5vIP1Uc+7sF5QZmbURqZWu6Re2C
         lhC69zP3NSoCU+Ui/L7y9OayeW4z23IuCCmNPc+OGWlqYR3v5wLw8hAtfgH2qcbXNDnm
         gEFq7V7VD/ij/l5n0zOYasIy7SEvoDTVJ686/gyyz4lzOz1yY8Nj2fKBUjafNCGpwsE+
         /AOuht++Rb3RHFLIeVwrqzbtkJpQz24VV/pJVH/ynbUWW7L0jYf6IpqHVxz71MHZIzL4
         Uy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUp5wbywhCtYBg+uXe45xThensWhGkLVcM+KzX14T0HPZ/iAaBpPEvDFl2IIJlEnP4bDFdHhX3VWO/Ye6gCYBl37XPdH8wCgcID00Pr5GB387hvgbXpJmM995RI276q2JmIT5Co0GwWl+rXmICBXlr97yPQX/4dGOcmWoKPxretfwBGuxlBmOAykQVz/twhwpaRGmgmQPLkNhSUQ1WFLesGp+hAdUzbZdSTskMeBJk2WgLBgh82nHMXaew=
X-Gm-Message-State: AOJu0Yx6DeE10+UC8u2V+jCO8JLUKq2r18X/t9qtZKhndyAxkfeUNaJs
	CdoZkfxaJVyHler3v6UDkbsSxlnrlsEDLPhVLtwZQFLBhy7bLGHOnjLTf+Y+VHYvh04+Zr6PxHc
	4QLEXRpuiR0NrW8OPlvcpQq7cRB0=
X-Google-Smtp-Source: AGHT+IGQXXSZAMioHJFxzZ3gh0Hr4+cQqIJfOhMlIaWn+NbO9UO7H6CsfSYUHm489vRzTeoH9KgIH7yb2O+eyZOdVec=
X-Received: by 2002:a5d:6346:0:b0:33d:3a0e:9168 with SMTP id
 b6-20020a5d6346000000b0033d3a0e9168mr177429wrw.3.1708635206226; Thu, 22 Feb
 2024 12:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org> <20240221-hid-bpf-sleepable-v3-6-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-6-1fb378ca6301@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 12:53:15 -0800
Message-ID: <CAADnVQK_2qhcZD0Wtd=8Bb8NVwBCg5Q+j8bF0HY8Hm91ACNrNA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 06/16] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:25=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> In this patch, bpf_timer_set_sleepable_cb() is functionally equivalent
> to bpf_timer_set_callback(), to the exception that it enforces
> the timer to be started with BPF_F_TIMER_SLEEPABLE.
>
> But given that bpf_timer_set_callback() is a helper when
> bpf_timer_set_sleepable_cb() is a kfunc, we need to teach the verifier
> about its attached callback.
> Marking that callback as sleepable will be done in a separate patch
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> new in v3 (split from v2 02/10)
> ---
>  kernel/bpf/helpers.c  | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+--
>  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f9add0abe40a..2c6dc3d0ffff 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1108,6 +1108,7 @@ struct bpf_hrtimer {
>         void __rcu *callback_fn;
>         void *value;
>         struct semaphore sleepable_lock;
> +       bool is_sleepable;
>  };
>
>  /* the actual struct hidden inside uapi struct bpf_timer */
> @@ -1270,8 +1271,8 @@ static const struct bpf_func_proto bpf_timer_init_p=
roto =3D {
>         .arg3_type      =3D ARG_ANYTHING,
>  };
>
> -BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void =
*, callback_fn,
> -          struct bpf_prog_aux *, aux)
> +static int __bpf_timer_set_callback(struct bpf_timer_kern *timer, void *=
callback_fn,
> +                                   struct bpf_prog_aux *aux, bool is_sle=
epable)
>  {
>         struct bpf_prog *prev, *prog =3D aux->prog;
>         struct bpf_hrtimer *t;
> @@ -1311,12 +1312,19 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_tim=
er_kern *, timer, void *, callb
>                 t->prog =3D prog;
>         }
>         rcu_assign_pointer(t->callback_fn, callback_fn);
> +       t->is_sleepable =3D is_sleepable;
>         up(&t->sleepable_lock);
>  out:
>         __bpf_spin_unlock_irqrestore(&timer->lock);
>         return ret;
>  }
>
> +BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void =
*, callback_fn,
> +          struct bpf_prog_aux *, aux)
> +{
> +       return __bpf_timer_set_callback(timer, callback_fn, aux, false);
> +}
> +
>  static const struct bpf_func_proto bpf_timer_set_callback_proto =3D {
>         .func           =3D bpf_timer_set_callback,
>         .gpl_only       =3D true,
> @@ -1342,6 +1350,11 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern =
*, timer, u64, nsecs, u64, fla
>                 goto out;
>         }
>
> +       if (t->is_sleepable && !(flags & BPF_F_TIMER_SLEEPABLE)) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
>         if (flags & BPF_F_TIMER_ABS)
>                 mode =3D HRTIMER_MODE_ABS_SOFT;
>         else
> @@ -2606,6 +2619,36 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>         WARN(1, "A call to BPF exception callback should never return\n")=
;
>  }
>
> +/**
> + * bpf_timer_set_sleepable_cb() - Configure the timer to call %callback_=
fn
> + * static function in a sleepable context.
> + * @timer: The bpf_timer that needs to be configured
> + * @callback_fn: a static bpf function
> + *
> + * @returns %0 on success. %-EINVAL if %timer was not initialized with
> + * bpf_timer_init() earlier. %-EPERM if %timer is in a map that doesn't
> + * have any user references.
> + * The user space should either hold a file descriptor to a map with tim=
ers
> + * or pin such map in bpffs. When map is unpinned or file descriptor is
> + * closed all timers in the map will be cancelled and freed.
> + *
> + * This kfunc is equivalent to %bpf_timer_set_callback except that it te=
lls
> + * the verifier that the target callback is run in a sleepable context.
> + */
> +__bpf_kfunc int bpf_timer_set_sleepable_cb(struct bpf_timer_kern *timer,
> +                                          int (callback_fn)(void *map, i=
nt *key, struct bpf_timer *timer))
> +{
> +       struct bpf_throw_ctx ctx =3D {};
> +
> +       arch_bpf_stack_walk(bpf_stack_walker, &ctx);
> +       WARN_ON_ONCE(!ctx.aux);

Sorry. Why such complexity?
Please see how do_misc_fixups() handles BPF_FUNC_timer_set_callback.

