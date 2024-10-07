Return-Path: <linux-kselftest+bounces-19136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C2D9922B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 04:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E1F2812D1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387E1097B;
	Mon,  7 Oct 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIy0XnaG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8BE552;
	Mon,  7 Oct 2024 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728266980; cv=none; b=F0/IsKDs/LC1g5uPy6LeMupsh25W/pMqGHHdWOlXYMSGzLLOWeavMgw9Hh1C5C5vJRWS6Q2vxqx4xjW4NCtOdurWhM8SpaUIii9GLWJNV0XbZ/eY4uplpxrDgtRYs4JW0xhLS/Emh2k7DCi82QQLwGrTa34ZZKBxi2rfmN1Hhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728266980; c=relaxed/simple;
	bh=Rf9I6YJ3IlM8R1+rQPvFKnGf8S0sIfuYFQbrgc8550k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J43EqjvbUHXqKCkivfFM4n5J3MEFBl6sMhc1E+sgKBrvYdc8TWWoZ5TA2s0mEFxFx0SLbKu+sL1LMe3vD5EacNopcXczROhTBUQdGkE2CIB/PYHTtVR7+oYrNzMI3lr7n+HaHMjDe1FhFVzh+EBza5dwec8uIPQPS9E8pIS0cBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIy0XnaG; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4583068795eso39380151cf.1;
        Sun, 06 Oct 2024 19:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728266977; x=1728871777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW/TTfT2JanQ5mxC72UwmmfTL4Vl3HPj0hyu1HT8EIU=;
        b=cIy0XnaGeob4b5sExJEVd+IiqkVXIFtqvBOWu3bSknbSWV/pwgP4wzvxrd1JmjRkAI
         tOeGvRJijyWy07EUoqn96LJ5rmnkoraKIjVCRWpzB5Ebm3jy7g7DibujfFWbG1bO9iWX
         KEz3NcgERqyvXkOayaRdBe1aZKPfC1pP9Sz2ynCNw2EQgIMAcm6vj6/OVlP4oLjoEsNX
         efSHRp4MMvPfWm+a2eCypewEky9DJonKQCg+kZMQbUYTvfNzugLEg5/vYTHxsAI2Gz9G
         1ifg6T/G+4jTEEI5I4vAg7a0bHswOyMYRno6TunYi28o4KW8RmtGI2SY6pwcd9rgNZav
         7WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728266977; x=1728871777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW/TTfT2JanQ5mxC72UwmmfTL4Vl3HPj0hyu1HT8EIU=;
        b=qjExjnIGlb3MZWwAJbWVK95fX3HZMeZ3PUdNSk+gDmI7PttlshcK2Zhtr+eoRPcmBa
         GVTUFb/3klGJ55agif7sjr5xnIu9TAyurax2Es+l1/+SgPQLALVWoOGN8XCtEX0MgpFT
         GPe6S1vgs03lVkFynKFFZ8elGDHi+u7SPozOpAnkJwbki78anIM6kgarup37adFiFrZO
         NeAh6NCz2EKkIM95+d05ByS+cI8p4SL3rX9LlpBTgUIt/ifuvyqORXqcTS5FgiQHQT8S
         XEC61GVJGKdjNpdelFMz0AFgWQJCOH6Lk5wU43dBuAaTs9xJLy11FcaNLVwCoC+w0mNQ
         +gMg==
X-Forwarded-Encrypted: i=1; AJvYcCXVsrJzqLNQGtZ/X3eS/AiP1/+zss0kFh172FETHdq/I4zaciVbZwMGDIIEnmreI+m5/EsPaxKbI2aSNx2Qm8dZ@vger.kernel.org, AJvYcCXubasyZL/oxJzfB6lZCkLzUvQ4jA0Z5Qv2lZlaOgI3fAypAN6xQGP0jFFwy4LmmYQfnPA4mUCr0opPsiGF@vger.kernel.org, AJvYcCXwzSWnQQjA5qh7iB+16RLsQZGuSuFeL+qybbbEa52qh1uru788NloYsqjkmVfBdOwyrhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66PBXYnH+xcBYQr2Jkc0e4vRxtHuBjVyN3d7jW4fV02RvnpuS
	Np4ui632V992zSSj0ND2yEL4nG0KVAO6gVp7o6wUMq43F1gtwZF2F98Hufb3ZYNOfHrGxN5jfPy
	vgVJvnuDUWV948oJbYt7npV4sSMY=
X-Google-Smtp-Source: AGHT+IGvhWZLjHdD6T0Cb/VTCGNel5TDfFx0g9wgx2uL6+QyjLjzW00UBDDMXARQsKIQ21wKUOpZwAooZxvPycap68w=
X-Received: by 2002:a05:622a:2:b0:458:294c:39e3 with SMTP id
 d75a77b69052e-45d9b95f1d5mr164970641cf.0.1728266977225; Sun, 06 Oct 2024
 19:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
 <20241006195131.563006-1-wudevelops@gmail.com>
In-Reply-To: <20241006195131.563006-1-wudevelops@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 7 Oct 2024 10:09:01 +0800
Message-ID: <CALOAHbAtfbd4KYjMr08o2raUQ6R4YZYSRJHMf3rV6hx7nHRTgQ@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: fix unpopulated name_len field in
 perf_event link info
To: tyrone-wu <wudevelops@gmail.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kernel-patches-bot@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	olsajiri@gmail.com, sdf@fomichev.me, shuah@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:51=E2=80=AFAM tyrone-wu <wudevelops@gmail.com> wro=
te:
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

LGTM
Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
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
> - Use user set *ulen in bpf_copy_to_user before overwriting *ulen
>
>  kernel/bpf/syscall.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca5..3df192a6bdcc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3565,32 +3565,35 @@ static void bpf_perf_link_dealloc(struct bpf_link=
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
> -       if (!uname)
> -               return 0;
> +
>         if (buf) {
> +               input_len =3D *ulen;
>                 len =3D strlen(buf);
> -               err =3D bpf_copy_to_user(uname, buf, ulen, len);
> -               if (err)
> -                       return err;
> -       } else {
> -               char zero =3D '\0';
> +               *ulen =3D len + 1;
>
> +               if (uname) {
> +                       err =3D bpf_copy_to_user(uname, buf, input_len, l=
en);
> +                       if (err)
> +                               return err;
> +               }
> +       } else if (uname) {
> +               char zero =3D '\0';
>                 if (put_user(zero, uname))
>                         return -EFAULT;
>         }
> @@ -3609,7 +3612,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
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
> @@ -3617,7 +3620,7 @@ static int bpf_perf_link_fill_kprobe(const struct p=
erf_event *event,
>                 info->perf_event.type =3D BPF_PERF_EVENT_KRETPROBE;
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
> -
> +       info->perf_event.kprobe.name_len =3D ulen;
>         info->perf_event.kprobe.offset =3D offset;
>         info->perf_event.kprobe.missed =3D missed;
>         if (!kallsyms_show_value(current_cred()))
> @@ -3639,7 +3642,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
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
> @@ -3648,6 +3651,7 @@ static int bpf_perf_link_fill_uprobe(const struct p=
erf_event *event,
>                 info->perf_event.type =3D BPF_PERF_EVENT_URETPROBE;
>         else
>                 info->perf_event.type =3D BPF_PERF_EVENT_UPROBE;
> +       info->perf_event.uprobe.name_len =3D ulen;
>         info->perf_event.uprobe.offset =3D offset;
>         info->perf_event.uprobe.cookie =3D event->bpf_cookie;
>         return 0;
> @@ -3673,12 +3677,18 @@ static int bpf_perf_link_fill_tracepoint(const st=
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


--=20
Regards
Yafang

