Return-Path: <linux-kselftest+bounces-17652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9F974432
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 22:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61961F27264
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C081AAE2F;
	Tue, 10 Sep 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwr4Lyay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283571AAE20;
	Tue, 10 Sep 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000918; cv=none; b=jZOXcYo/0Ezjnbi770Z5mOj82H5/x+8bLIaiAhF8WCTvxO123NK2v/8IOjZuuEQ8TfebdsD12qTyyuPg85dgO+8Th9UVGn/vm5sX9eGj5rZoUggz8wlKrnHJd/UxXoQMbEC+p6E+cgMGbO6gw1wMM9hirGQGXCN+YIHhsruyjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000918; c=relaxed/simple;
	bh=tPFUvXEr4a8sFcl5Hbk+e1WdoaCv9UY6H2M6UNXz3dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GU/ZctBunkzEnVwwo36VqALks/99WlBdbdDdngXVq60rSWL42fLsw1W0tgVMmjncKL+gQPeLDiuFjW10s+leD5lYnlKRTjn5aaS3l7uxtz7LSGUXlCC+RYYHYuLGOoqUR/J7WbdLvG7yIzaxY77RKmep2gFtLwq8XBgJ3sVWa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwr4Lyay; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-70b2421471aso3991972a12.0;
        Tue, 10 Sep 2024 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726000916; x=1726605716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFOb87C5H/oGKVNSdsgwbM5DcJSf5yVJvXgC2bcG+Ac=;
        b=Fwr4Lyayfzf2VC0Z4iZAMEYH1eoKGtcdiXhMcHKq43/CH9yR5eNlqA30ZrDEj+DfRH
         0G9XaGP9RKyzQwzLJ76D0c+vMum/441EREMqjG9zvvC8A/1aYgX+pxbKv5U8gKFdU3Rg
         kmd2Dg2JQwVpNQIFrNPITuFMdgZ7IgcGDMpY22cQEAIaTnftl9zKwwjlG91LMtJOeMAK
         gLfhLYMJ/DYdel2q6qNgMxN2oXg8BHWgk8ZGGD1+JU4WFHAIsyp5hGwdsM6dVr2stICS
         SiQCf3w/c7sY6YH4G99584PX96MqdtE83ueZhyZsXbl63hSdb8enZbuaXDk8+lnhUZHy
         E8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726000916; x=1726605716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFOb87C5H/oGKVNSdsgwbM5DcJSf5yVJvXgC2bcG+Ac=;
        b=VfroqPd3snPosNvyZeey9v6WFR5p2avP/3DkWypq3PYge6xvEo+I0Oayoqdwo91lnr
         QGvbn6Zr4fIjvNMxQjm4lRtEWk3zn5MBQSUcFLk7aq6G3F1N4rOuJY7LY1x5ge3JEjfJ
         dYbcZITOTPFUUElGPwnyn21TL0Bn3/UzCh0++JBD6Ng20+12r4VseuXTTSahXZffGCY2
         szyDKIpICMXEaQB7LqPjalpMkzZFBqyKf8ZchvvMMcOHzV26WiQZ1+b5nCk624N6xd2p
         KEP7XFWhYAnNqWoBvHRCkPXjY31bfpm2hfmiV0pvGgMVK/SpLzRmBUVsoYP7FRnalJaO
         dGsg==
X-Forwarded-Encrypted: i=1; AJvYcCVDcdyrSCGl2JE+FCL940BDS6fYUHvP0Ukr5a00lPUO5PsMkhjsptJm+CfNk/FbmlnQIfwFaBRtFg4amONO@vger.kernel.org, AJvYcCW7laN3izLbvqr5qgJZ1pAti/lZL3dcfKFq2jxHspZDl8+EcwIFINRwTQE19oDmtcxTC3s=@vger.kernel.org, AJvYcCWaXAc9x5IREN+Nlo08mboXGm2LUYb3KI6b4GjsBlAobrXWaV4PTn7gmIpMtYpNDKrb28XXWSbk2M+34RCpghL4@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXl5hF0lH8Z/nzXYEIAqk5L+4ScNIoMOxkgTBxBwyYwaaIO6x
	IjgYsQjbP9hI8B5CIisWRYZHV7U9xx9hIlbyGfRmbkVd1BgLgiMxIV19KxjxlCRzHYlCr+IL5e2
	SbdmIIxidL8wsb8baLreKPT0Wf07y6g==
X-Google-Smtp-Source: AGHT+IGW9uVkefg8yACg9x9N30/Cr1tq1hV6jWPbHGGjUEg003GoDm9nF+bOKw6FBfAIXrLj3LoVJuFRWlf4OcgeSQE=
X-Received: by 2002:a17:90b:4a4e:b0:2d8:cd04:c8f0 with SMTP id
 98e67ed59e1d1-2dad5136fa5mr14049568a91.39.1726000916345; Tue, 10 Sep 2024
 13:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
In-Reply-To: <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 13:41:41 -0700
Message-ID: <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Eddy Z <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 5:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Right now there exists prog produce / userspace consume and userspace
> > produce / prog consume support. But it is also useful to have prog
> > produce / prog consume.
> >
> > For example, we want to track the latency overhead of cpumap in
> > production. Since we need to store enqueue timestamps somewhere and
> > cpumap is MPSC, we need an MPSC data structure to shadow cpumap. BPF
> > ringbuf is such a data structure. Rather than reimplement (possibly
> > poorly) a custom ringbuffer in BPF, extend the existing interface to
> > allow the final quadrant of ringbuf usecases to be filled. Note we
> > ignore userspace to userspace use case - there is no need to involve
> > kernel for that.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  kernel/bpf/verifier.c                         |  6 +-
> >  tools/testing/selftests/bpf/Makefile          |  3 +-
> >  .../selftests/bpf/prog_tests/ringbuf.c        | 50 +++++++++++++++
> >  .../bpf/progs/test_ringbuf_bpf_to_bpf.c       | 64 +++++++++++++++++++
> >  4 files changed, 120 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_bpf_=
to_bpf.c
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53d0556fbbf3..56bfe559f228 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9142,7 +9142,8 @@ static int check_map_func_compatibility(struct bp=
f_verifier_env *env,
> >                     func_id !=3D BPF_FUNC_ringbuf_query &&
> >                     func_id !=3D BPF_FUNC_ringbuf_reserve_dynptr &&
> >                     func_id !=3D BPF_FUNC_ringbuf_submit_dynptr &&
> > -                   func_id !=3D BPF_FUNC_ringbuf_discard_dynptr)
> > +                   func_id !=3D BPF_FUNC_ringbuf_discard_dynptr &&
> > +                   func_id !=3D BPF_FUNC_user_ringbuf_drain)
> >                         goto error;
> >                 break;
> >         case BPF_MAP_TYPE_USER_RINGBUF:
> > @@ -9276,7 +9277,8 @@ static int check_map_func_compatibility(struct bp=
f_verifier_env *env,
> >                         goto error;
> >                 break;
> >         case BPF_FUNC_user_ringbuf_drain:
> > -               if (map->map_type !=3D BPF_MAP_TYPE_USER_RINGBUF)
> > +               if (map->map_type !=3D BPF_MAP_TYPE_USER_RINGBUF &&
> > +                   map->map_type !=3D BPF_MAP_TYPE_RINGBUF)
> >                         goto error;
>
> I think it should work.
>
> Andrii,
>
> do you see any issues with such use?
>

Not from a quick glance. Both ringbufs have the same memory layout, so
user_ringbuf_drain() should probably work fine for normal BPF ringbuf
(and either way bpf_user_ringbuf_drain() has to protect from malicious
user space, so its code is pretty unassuming).

We should make it very explicit, though, that the user is responsible
for making sure that bpf_user_ringbuf_drain() will not be called
simultaneously in two threads, kernel or user space.

Also, Daniel, can you please make sure that dynptr we return for each
sample is read-only? We shouldn't let consumer BPF program ability to
corrupt ringbuf record headers (accidentally or otherwise).

And as a thought exercise. I wonder what would it take to have an
open-coded iterator returning these read-only dynptrs for each
consumed record? Maybe we already have all the pieces together. So
consider looking into that as well.

P.S. And yeah "user_" part in helper name is kind of unfortunate given
it will work for both ringbufs. Can/should we add some sort of alias
for this helper so it can be used with both bpf_user_ringbuf_drain()
and bpf_ringbuf_drain() names?


> >                 break;
> >         case BPF_FUNC_get_stackid:
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 9905e3739dd0..233109843d4d 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -503,7 +503,8 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_=
funcs.skel.h               \
> >  LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c atomics.c        =
   \
> >         trace_printk.c trace_vprintk.c map_ptr_kern.c                  =
 \
> >         core_kern.c core_kern_overflow.c test_ringbuf.c                =
 \
> > -       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
> > +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c   =
 \
> > +       test_ringbuf_bpf_to_bpf.c

[...]

