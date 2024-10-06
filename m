Return-Path: <linux-kselftest+bounces-19126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD3991CB3
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EEF1C2167D
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3116B75C;
	Sun,  6 Oct 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocp6Y+Pr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50C2C18C;
	Sun,  6 Oct 2024 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194445; cv=none; b=GEqm6iu9SVzjGrKUaU1fcTcJGqeJxAZZ9syCqFFk72jAUBiaSjKNbpKU8fK/DGjfiSQjtGGEIXDNdO+AQziw4TFotFBnK5fmEfmi3B33+NbNCDtmYyO0Oobu7s/AtcIm/Jfyze7Utz2IYDIp9jxeB08F0gmQ6I11Z79bECeXm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194445; c=relaxed/simple;
	bh=EcNwiFqFvvy7rKkC+xt1BQpm/FRmgrtdssydaUFObIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvMmXGAAQoso/4o8Gfj6FwCHjD7UaiadSbltF3aLrGPJlslG/Rt9AjVvgKA/Bf17vBnesigA97Fk6Lk2B/xkAJkAInB3sRwbo8vja8Pup3cVruZIP4eGE5wUXKahqFYUig6Zud4H6w1X5qNO77EcOgeMZrHTtjSPmrV28D+O7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocp6Y+Pr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99de9beb2so180767285a.3;
        Sat, 05 Oct 2024 23:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728194443; x=1728799243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urvj443lDPBxCNc4tUVMzXPrl0/q53Phb4eO5bfK+/M=;
        b=Ocp6Y+PryyvTar6Umo21uap4ZK8gkMzG2DW9xQCRuf/vjatgQyANBGH+MXG/bMe80z
         bRSudbV1V0flyd/TpzDXaqroxMChum8EW3kvdGQuEkSLd6OROHhjO1s0wzej0K/4UyPK
         c+l3zLGCKm76aFpmF36Xl36YeivTVjDW5f0NhOUFWLKOBWOsUdCcgymvNk8Rx+jXq1co
         SJ8uLRFoXHaZ5e0YBozqL4ABZwBMMpp6NNH2RxY8GkQ+Ie2cnDeqtq14j/zIgjehe8UO
         tbM0PGhF74PmGI3x90OJDpAFUeFVIoKc75Mp0b6VH+vfFfYZU1vGVZDF6H59GOHdBp3g
         Is9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728194443; x=1728799243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urvj443lDPBxCNc4tUVMzXPrl0/q53Phb4eO5bfK+/M=;
        b=LX7l95MWOjY3OducCom7ZDHwZtW1ELi9J93ogC1qxmw2oRQKZPZM7Va948W7k2UCBK
         JzN63MyDrbKe0Qkj4+YJA3Ygy++XhqE+DgZ3xOb46YJgrswomingsLDnfoYxEi+F+KMS
         xeJAoeG+YpMuE0ehI9aI/wYnL7kiyCCGpY2T4J0awrmVQqsmcXb0rBrI2rZETkJ9YsT9
         rmtk5H7rd6TTcisRE+2NezG/bXQabLN+I3T3NIVaQ2enQnp2wMlWluki0cyMTv8vpQHA
         RJfIUKexPXW5v7s2RgqguE/NZ4Gwgu/Qxe3Wq+br10yTj5zXVulnhybZu1bIVYCFyvcM
         /Djw==
X-Forwarded-Encrypted: i=1; AJvYcCVIXwgT7rLLZQ1rmQkTHk+332g1Ef1CDGzYwRuuYVH7FzbxIJyXUmQTi0U4Kg7AgJe9kHkLn6JQEvsg5IS/jX2M@vger.kernel.org, AJvYcCVbZAKSxOHmsB2xHDJCox4QtS0WP5dCEBLTbKUq/hhJrC0aTRC34dd9l+HuKoRiN40c2mTHS/QnSQ8FYvHY@vger.kernel.org, AJvYcCXHR/PRVcD+IKgob+O3j20yTkb+99kLcNKEddZcfdYqXQq5Y4iy8sDy8XKKqxj8GPXYQNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGz31+NV1ajfxj35E7vSBt+uq+qYgvK94FDRXGaRBpFFZhuUC
	NmPHxwjXDGSzPtIV+C9Nph/d9qtbWxhU4CbqTF0wnY2tWIyNaP7H6LL90mQEyP8xnFBmuS5KpfS
	UFvoTJfjqREVrdWKdp2aX/4YyaEo=
X-Google-Smtp-Source: AGHT+IGNYJrfcIsI5d5/upzhEJbTEIO+lxC+Mn5Mr5wX7Vvl0pM4dvVwPk/a0atUbr30Xww8OfEs1SdX/u3UQ11IxUM=
X-Received: by 2002:a05:6214:5bc8:b0:6cb:579b:b4ce with SMTP id
 6a1803df08f44-6cb9a505308mr135617616d6.38.1728194442859; Sat, 05 Oct 2024
 23:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zv_PP6Gs5cq3W2Ey@krava> <20241004154002.10979-1-wudevelops@gmail.com>
In-Reply-To: <20241004154002.10979-1-wudevelops@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 6 Oct 2024 14:00:06 +0800
Message-ID: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: fix unpopulated name_len field in
 perf_event link info
To: tyrone-wu <wudevelops@gmail.com>
Cc: olsajiri@gmail.com, andrii.nakryiko@gmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, kernel-patches-bot@fb.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	sdf@fomichev.me, shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:40=E2=80=AFPM tyrone-wu <wudevelops@gmail.com> wr=
ote:
>
> Previously when retrieving `bpf_link_info.perf_event` for
> kprobe/uprobe/tracepoint, the `name_len` field was not populated by the
> kernel, leaving it to reflect the value initially set by the user. This
> behavior was inconsistent with how other input/output string buffer
> fields function (e.g. `raw_tracepoint.tp_name_len`).
>
> This patch fills `name_len` with the actual size of the string name.
>
> Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy1=
6-yb0Snztmtg@mail.gmail.com/
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Signed-off-by: tyrone-wu <wudevelops@gmail.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
> V3 -> V4:
> Link: https://lore.kernel.org/bpf/Zv_PP6Gs5cq3W2Ey@krava/
> - Split patch into separate kernel and selftest change
>
> V2 -> V3:
> Link: https://lore.kernel.org/bpf/Zv7sISV0yEyGlEM3@krava/
> - Use clearer variable name for user set/inputted name len (name_len -> i=
nput_len)
> - Change (name_len -> input_len) type from size_t to u32 since it's only =
received and used as u32
>
> V1 -> V2:
> Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
> - Use user set *ulen in bpf_copy_to_user before overwriting *ulen
>
>  kernel/bpf/syscall.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..56c556fcf325 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3565,27 +3565,31 @@ static void bpf_perf_link_dealloc(struct bpf_link=
 *link)
>  }
>
>  static int bpf_perf_link_fill_common(const struct perf_event *event,
> -                                    char __user *uname, u32 ulen,
> +                                    char __user *uname, u32 *ulen,
>                                      u64 *probe_offset, u64 *probe_addr,
>                                      u32 *fd_type, unsigned long *missed)
>  {
>         const char *buf;
> -       u32 prog_id;
> +       u32 prog_id, input_len;
>         size_t len;
>         int err;
>
> -       if (!ulen ^ !uname)
> +       if (!(*ulen) ^ !uname)
>                 return -EINVAL;
>
>         err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
>                                       probe_offset, probe_addr, missed);
>         if (err)
>                 return err;
> +
> +       input_len =3D *ulen;
> +       len =3D strlen(buf);

The buf might be NULL, so we should check it.

> +       *ulen =3D len + 1;
>         if (!uname)
>                 return 0;
> +
>         if (buf) {
> -               len =3D strlen(buf);
> -               err =3D bpf_copy_to_user(uname, buf, ulen, len);
> +               err =3D bpf_copy_to_user(uname, buf, input_len, len);
>                 if (err)
>                         return err;
>         } else {
> @@ -3609,7 +3613,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
erf_event *event,
>
>         uname =3D u64_to_user_ptr(info->perf_event.kprobe.func_name);
>         ulen =3D info->perf_event.kprobe.name_len;
> -       err =3D bpf_perf_link_fill_common(event, uname, ulen, &offset, &a=
ddr,
> +       err =3D bpf_perf_link_fill_common(event, uname, &ulen, &offset, &=
addr,
>                                         &type, &missed);
>         if (err)
>                 return err;
> @@ -3617,7 +3621,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
erf_event *event,
>                 info->perf_event.type =3D BPF_PERF_EVENT_KRETPROBE;
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
> -
> +       info->perf_event.kprobe.name_len =3D ulen;
>         info->perf_event.kprobe.offset =3D offset;
>         info->perf_event.kprobe.missed =3D missed;
>         if (!kallsyms_show_value(current_cred()))
> @@ -3639,7 +3643,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
erf_event *event,
>
>         uname =3D u64_to_user_ptr(info->perf_event.uprobe.file_name);
>         ulen =3D info->perf_event.uprobe.name_len;
> -       err =3D bpf_perf_link_fill_common(event, uname, ulen, &offset, &a=
ddr,
> +       err =3D bpf_perf_link_fill_common(event, uname, &ulen, &offset, &=
addr,
>                                         &type, NULL);
>         if (err)
>                 return err;
> @@ -3648,6 +3652,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
erf_event *event,
>                 info->perf_event.type =3D BPF_PERF_EVENT_URETPROBE;
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_UPROBE;
> +       info->perf_event.uprobe.name_len =3D ulen;
>         info->perf_event.uprobe.offset =3D offset;
>         info->perf_event.uprobe.cookie =3D event->bpf_cookie;
>         return 0;
> @@ -3673,12 +3678,18 @@ static int bpf_perf_link_fill_tracepoint(const st=
ruct perf_event *event,
>  {
>         char __user *uname;
>         u32 ulen;
> +       int err;
>
>         uname =3D u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
>         ulen =3D info->perf_event.tracepoint.name_len;
> +       err =3D bpf_perf_link_fill_common(event, uname, &ulen, NULL, NULL=
, NULL, NULL);
> +       if (err)
> +               return err;
> +
>         info->perf_event.type =3D BPF_PERF_EVENT_TRACEPOINT;
> +       info->perf_event.tracepoint.name_len =3D ulen;
>         info->perf_event.tracepoint.cookie =3D event->bpf_cookie;
> -       return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, =
NULL, NULL);
> +       return 0;
>  }
>
>  static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
> --
> 2.43.0
>


--
Regards


Yafang

