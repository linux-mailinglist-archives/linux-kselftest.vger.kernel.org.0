Return-Path: <linux-kselftest+bounces-5306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD818603ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661B528D07B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977A71740;
	Thu, 22 Feb 2024 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg0ONMBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77E5491B;
	Thu, 22 Feb 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634872; cv=none; b=G4Fv4BO0P6xS7Pfw5e3/RB98VJA/e2WUlRGruB33K6eztI3XGU3VDEaUrNEwah/y0Ip0+uKzqADRZ1k4Do/noWUDPJuPYv/Ld4bNVMotcQ8qvVrKRXgZahQVpROlBEHrOvjJb943FgdYBwkuldn0vVwK1/CoRnemMwkOZlRvhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634872; c=relaxed/simple;
	bh=aErF6fin/ExLDACGLGlOq3WdwJAaaAK8dflArbKNBWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lwdl4u/38s6hOUdBAOez6rRKwKPCeLJtX80u8EyHfngIDAxw6zFHU+CwJcnT81fS/A4NZ2baqYlkqi4Coa7nLxr5ULlasfarQfOku9uI9IXKRaYH83xe0QjdvP53jpMRKTles/ZQDHpHanKO0PSHpHyWX/x/6lz7ATfhB9GpNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg0ONMBG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33adec41b55so105619f8f.0;
        Thu, 22 Feb 2024 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708634869; x=1709239669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1ILuSYGWtcZrcYDaMPeYmzwiuIoj4bshKlioR0+zNs=;
        b=cg0ONMBGy0GcmPxweN3Ex6Tij18W0EfRDqGbheOd0uKF0sfpEC8f5Bl1oIehQx7BxK
         dgH+GnDUVJXDQR1/6dcatT7Xr2WpMXg2388//XnZgPG9hFh3KwsmwYrffvFUfovo76Ee
         A9fZ8dNN/mzLoRkDwm4hFeL4uSyX9Q8uelccZL1Nw3wbChMYa5KQt6UGLIRpaihe2cEE
         P8PBDXftqBqur8z4l5cezW0th7JkDzTcywFhsiMR41ipJY3XiuczNhUNEuTQKSgC1ToQ
         t0PdjBAyM53I3rs8pQBf+A5iOcYjJs3tvkUyWGNh/uY6j0WzGKe9qfV1uztnGJUsYBJS
         fTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708634869; x=1709239669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1ILuSYGWtcZrcYDaMPeYmzwiuIoj4bshKlioR0+zNs=;
        b=lhiJdIJrHv+hVEpPyrYv65v3ZYp5cFjQyKt8jkCIov2bM081R7x6moFHeFHczkzUWD
         +tZA4M6VOxSFQfeUkuL9Q8HSjyi7hvCjICqmPrkKtHWwwue0V3yU+81EBZpQRj+W8q04
         62OJNNpqpBidI0hQznmN4i1CkYm2WYSIZVsoVw9njJhrKKlPqAOc8oUbnUBjz8z0ZFMH
         Uzt47KKCZnWT7A/7+yyD3sQP5I52yCn5PZl3WM1nUAVuOeEm0jWxS8mKqZk0rWpTm5VX
         vs6BIsDfWCj3/CrmwzFSCoszWZJU4fIOKlwQBGMWNUcJp0peXTqmfPgDncxJRwUO4ATN
         qzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmaeijJzqnW7WDF8DyOqV11ccD6FyMLrNoRkx/kf4ue0SLuiR/fzmYo4pMCTr7jiDmuLYVWEcA9+dctgRHSN7aJTUYcyM88l5TUTJl7fWbmKcd3OpjJYyqaPYnCHQTJinVfZTdHdtcuZ0H+ZFhyIMpBVWA0uVLGF2xryv8Qbt4CvgmBZBb0jWpXLeSHRLKe9OrV+CAxcpVRkmLazbXlXXQEyGxKJ4qfT/P4dOFI7XknzcnObjAImitz9k=
X-Gm-Message-State: AOJu0YwBmtaBSyYzAg332QdBaCrAC3pjoqRnERJ1L0Y9rHRZenPCynwp
	ROvQ13qAnZtwq3FsNq1SZKuoahMl4l4w7Nc7rRbtpR+IjNNCZ+k+KtrAQyEwwtMxEZq+hgxgFQr
	kx/U1Xzc+UucR6tVzvvTOlqQmOHc=
X-Google-Smtp-Source: AGHT+IEKR3AJiHLSCutZrsofKd8gyElVibjB6tMVQvKDAdvXuWb7cdSzQfC6AtrCwpLc4z9uXof99rbbN67j1a20mi0=
X-Received: by 2002:adf:face:0:b0:33d:3abc:8a4a with SMTP id
 a14-20020adfface000000b0033d3abc8a4amr163040wrs.62.1708634868547; Thu, 22 Feb
 2024 12:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org> <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 12:47:37 -0800
Message-ID: <CAADnVQJ=a2BnOwcs5uNqnyHfbS=gv=X4Z8eaGU-Tx1o8LwyJdQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable bpf_timers
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
>  /* the actual struct hidden inside uapi struct bpf_timer */
> @@ -1113,6 +1120,55 @@ struct bpf_timer_kern {
>         struct bpf_spin_lock lock;
>  } __attribute__((aligned(8)));
>
> +static u32 __bpf_timer_compute_key(struct bpf_hrtimer *timer)
> +{
> +       struct bpf_map *map =3D timer->map;
> +       void *value =3D timer->value;
> +
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> +               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
> +
> +               /* compute the key */
> +               return ((char *)value - array->value) / array->elem_size;
> +       }
> +
> +       /* hash or lru */
> +       return *(u32 *)(value - round_up(map->key_size, 8));
> +}
> +
> +static void bpf_timer_work_cb(struct work_struct *work)
> +{
> +       struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer, =
work);
> +       struct bpf_map *map =3D t->map;
> +       void *value =3D t->value;
> +       bpf_callback_t callback_fn;
> +       u32 key;
> +
> +       BTF_TYPE_EMIT(struct bpf_timer);
> +
> +       down(&t->sleepable_lock);
> +
> +       callback_fn =3D READ_ONCE(t->callback_fn);
> +       if (!callback_fn) {
> +               up(&t->sleepable_lock);
> +               return;
> +       }
> +
> +       key =3D __bpf_timer_compute_key(t);
> +
> +
> +       callback_fn((u64)(long)map, (u64)(long)&key, (u64)(long)value, 0,=
 0);
> +       /* The verifier checked that return value is zero. */
> +
> +       bpf_prog_put(t->prog);
> +}
> +
>  static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>
>  static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
> @@ -1121,8 +1177,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrt=
imer *hrtimer)
>         struct bpf_map *map =3D t->map;
>         void *value =3D t->value;
>         bpf_callback_t callback_fn;
> -       void *key;
> -       u32 idx;
> +       u32 key;
>
>         BTF_TYPE_EMIT(struct bpf_timer);
>         callback_fn =3D rcu_dereference_check(t->callback_fn, rcu_read_lo=
ck_bh_held());
> @@ -1136,17 +1191,9 @@ static enum hrtimer_restart bpf_timer_cb(struct hr=
timer *hrtimer)
>          * bpf_map_delete_elem() on the same timer.
>          */
>         this_cpu_write(hrtimer_running, t);
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> -               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
> -
> -               /* compute the key */
> -               idx =3D ((char *)value - array->value) / array->elem_size=
;
> -               key =3D &idx;
> -       } else { /* hash or lru */
> -               key =3D value - round_up(map->key_size, 8);
> -       }
> +       key =3D __bpf_timer_compute_key(t);

Please don't mix such "cleanup" with main changes.
It's buggy for a hash map.
Instead of passing a pointer to the real key into bpf prog
you're reading the first 4 bytes from the key. Copying it into a temp var
and passing an address to that.
It would have been very painful to debug such a bug if it slipped through,
since bpf prog would sort-of work for 4-byte keys.

