Return-Path: <linux-kselftest+bounces-19192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 902BF993DC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 06:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02045B236F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 04:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7D34CF5;
	Tue,  8 Oct 2024 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZx/S/hl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD433CA;
	Tue,  8 Oct 2024 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360276; cv=none; b=FGK9wFs35VMQ7ZHglfngsgbTF/2l6aJXeWMGI0Jit4nXotIfS+lk5iuFv7Pa5uvqCLCSngj3T26LNqUTyiP4Ohgb1FnwpAc30zHbsF2hqvds8YsKrsz4kP1naM3PhvaEK7GY3YuLznvtNP/0XTcstYwt28QgJtrROv4GmM2F6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360276; c=relaxed/simple;
	bh=bXaRgSHofV6Rkkq4qfXRdN7k91QpXPIN6NrC9+sniNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxGBb0Y2cRJvhY1kyhIegfOKOkTcjiBulgXIdWxCXz4z4iJxLPiAytKfbqCkb8aHihgZsSeGYnI5I0/0K/ND0tGjcTmQp+nevXBCx/puP0mOSHrG3VIPPZ9etQ916JLULbHL7y0e3PZJ5EgsY+yJiNi+u4i9MMOYT+MiYdpG9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZx/S/hl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso3973460f8f.1;
        Mon, 07 Oct 2024 21:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728360273; x=1728965073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeL2eCQ3D5dxw4ZH8f6RmNsLwTsdLHD4eyRo25Vm5C0=;
        b=JZx/S/hlH+PHgw2Gs66Iq8+7FFQyj1ztnz6/do2zBUlI6tmATrEdwK5b3Mu841E94u
         HCsLy+UwBpET3tfQKKez+Ed+rXADigDEdgTBF8xwe+PjX+Ssgh/d1zW6D7nqHP7b/RZ0
         6cJtUzGbjT068VCKE9bPREHXJRX063WRKPm9LcmW41l9VUGhJLP6zLUnIXvYvTdvzKxU
         +P3tqSnB3uEyshuwuSeyAD/HYhOuYkcfqYpCZecm2OG6/Dei5542djMLkwvSjqdId5fi
         YGqFnK6UkApWLz++Zr3auS4Mj4U+vZbGJ68+Zq29CaC4oC+4E//1gxdJuzj8CtOqHT8F
         JYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360273; x=1728965073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeL2eCQ3D5dxw4ZH8f6RmNsLwTsdLHD4eyRo25Vm5C0=;
        b=HbLKG8Db6ITpR+RPOZLT5Qhr2aIERYwNsBEk4Y+RvSThDPNWFZPa8pGcsF5/YeT9+2
         fFMDVwFdWnsk+Xk+L29OR/YW3EvTRHLD1A2ZqUKToFj6P1UbzjrvlEw93jrnPdfr+0fn
         4RrtxXPC4ABzr6s81yh2lMpr1ZBWkSZJxjmePnxgXJ92D47j4fxxHQCRFXeTkAeBCg5X
         FhfF04uGETlEY5gfH6b7Jb+fQKiElctXKgXk5BNLNMFSY/neCEO57JgaCx20yxfrA5Ky
         dgwix4Mdpq1MwIc1UAMSlWnsawuBLSBL7AJtAuiFpu3GSappz/UyF63iSWftvFpfH9YO
         D1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUgMN0gOl6rTXIOdKuUL8J2JO4h+WS7lhAlgsvUFBwm1ICLYPEigZMNPiCJTMON+ppdNMc=@vger.kernel.org, AJvYcCXFJw3A2axQprYl8MWdF+CynUDihsRWG7Bes7RTyfTHJuZdpemfqA5MJeZjzYMqWinwfLku6BDchwEuT82d@vger.kernel.org, AJvYcCXvoBBRxwHuz8lPWZgwHHmdkAb6SoJd6ZAqQLsYF7LMYmk1EzH530GiKT18bW+ydPSk8WuzvcaDKJSrHEmUaLxr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8TAiELD61nrDhCAa4Mz52oAsFqpdVChPWlLyldef258fyToI
	Kw4tGNnD1pBEFIB+6ALXiByEsfTmQOq5QmYzxrS6we7l9zgvxetbM98kQIo5iFv5ScAPx2UsGds
	cZwbOqqsjnkNCySNTlyC+F1rhqsk=
X-Google-Smtp-Source: AGHT+IHq6nL5kxATCrOVR0zNdZG0uySRJFuWtC6A4pqWyJRtHOG2KIuPSxSw+beCCOE8d2wnI7WM3lsd9KiBn2RDjds=
X-Received: by 2002:a05:6000:1818:b0:37c:ca21:bc53 with SMTP id
 ffacd0b85a97d-37d0e76fdfdmr8678174f8f.26.1728360272583; Mon, 07 Oct 2024
 21:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZwOWs_XrBtlTGE24@krava> <20241007182933.8841-1-wudevelops@gmail.com>
In-Reply-To: <20241007182933.8841-1-wudevelops@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 21:04:17 -0700
Message-ID: <CAEf4Bzb1JzE7OPieODoq7H5hg_z2WwkBZo91dyGuRQ56cJ03jg@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: fix unpopulated name_len field in
 perf_event link info
To: Tyrone Wu <wudevelops@gmail.com>
Cc: olsajiri@gmail.com, laoar.shao@gmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, kernel-patches-bot@fb.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	sdf@fomichev.me, shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:29=E2=80=AFAM Tyrone Wu <wudevelops@gmail.com> wr=
ote:
>
> From: tyrone-wu <wudevelops@gmail.com>
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
> Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> ---
> V5 -> V6:
> Link: https://lore.kernel.org/bpf/ZwOWs_XrBtlTGE24@krava/
> - Use simpler buf check while keeping V4
> - Fix netdev/checkpatch warning for 80 cols exceeded
> - Fix Signed-off-by to use real name instead of git username
>
> V4 -> V5:
> Link: https://lore.kernel.org/bpf/CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCW=
iOVqTKmdZp-Q@mail.gmail.com/
> - Check that buf is not NULL before retrieving/using its length
>
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

Please drop all the Link: tags, our scripts will accumulate all of
them in the final commit and it becomes very confusing. Our script
will add the final Link: for your latest applied version anyways.

Also, git still shows:

Author: tyrone-wu <wudevelops@gmail.com>

So please try to fix that.

But generally, looks good and I almost applied, but see one small
issue below, which I think needs fixing.

pw-bot: cr

> - Use user set *ulen in bpf_copy_to_user before overwriting *ulen
>
>  kernel/bpf/syscall.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..b5a7e428ac16 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3565,27 +3565,33 @@ static void bpf_perf_link_dealloc(struct bpf_link=
 *link)
>  }
>
>  static int bpf_perf_link_fill_common(const struct perf_event *event,
> -                                    char __user *uname, u32 ulen,
> +                                    char __user *uname, u32 *ulen,

nit: I'd do what Jiri suggested, use `u32 *ulenp` here

>                                      u64 *probe_offset, u64 *probe_addr,
>                                      u32 *fd_type, unsigned long *missed)
>  {
>         const char *buf;
> -       u32 prog_id;
> +       u32 prog_id, input_len;

and then just `u32 ulen;` here.

>         size_t len;
>         int err;
>

start with just

ulen =3D *ulenp;

> -       if (!ulen ^ !uname)
> +       if (!(*ulen) ^ !uname)

and remove all the `*ulen` uses except the final assignment

>                 return -EINVAL;
>
>         err =3D bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
>                                       probe_offset, probe_addr, missed);
>         if (err)
>                 return err;
> +
> +       if (buf) {
> +               input_len =3D *ulen;
> +               len =3D strlen(buf);
> +               *ulen =3D len + 1;
> +       }

don't we need

} else {
    *ulen =3D 1;
}

for cases when we don't have buf returned from
bpf_get_perf_event_info()? Though I don't think it can happen
currently, existing code is clearly ready to handle that case, so
let's keep it consistent.

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
> @@ -3609,7 +3615,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
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
> @@ -3617,7 +3623,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
erf_event *event,
>                 info->perf_event.type =3D BPF_PERF_EVENT_KRETPROBE;
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
> -
> +       info->perf_event.kprobe.name_len =3D ulen;
>         info->perf_event.kprobe.offset =3D offset;
>         info->perf_event.kprobe.missed =3D missed;
>         if (!kallsyms_show_value(current_cred()))
> @@ -3639,7 +3645,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
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
> @@ -3648,6 +3654,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
erf_event *event,
>                 info->perf_event.type =3D BPF_PERF_EVENT_URETPROBE;
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_UPROBE;
> +       info->perf_event.uprobe.name_len =3D ulen;
>         info->perf_event.uprobe.offset =3D offset;
>         info->perf_event.uprobe.cookie =3D event->bpf_cookie;
>         return 0;
> @@ -3673,12 +3680,19 @@ static int bpf_perf_link_fill_tracepoint(const st=
ruct perf_event *event,
>  {
>         char __user *uname;
>         u32 ulen;
> +       int err;
>
>         uname =3D u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
>         ulen =3D info->perf_event.tracepoint.name_len;
> +       err =3D bpf_perf_link_fill_common(event, uname, &ulen, NULL, NULL=
, NULL,
> +                                       NULL);

nit: keep it on a single line

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

