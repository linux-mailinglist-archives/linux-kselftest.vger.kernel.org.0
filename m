Return-Path: <linux-kselftest+bounces-32029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52741AA4B77
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 14:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800959C3269
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9325B1F8;
	Wed, 30 Apr 2025 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azgEBJsU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34225B1D2;
	Wed, 30 Apr 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017053; cv=none; b=PeGxR+B0ugwLOyID+uLtLvRRFbxI+/U4NUIR/e6SIVSPUeI6bEyloAey+Gwr7tUUA/h+GaIoHzQm8NK1QvC5afx6wSd40iCiFhFED53cAHUxTrL+9UhF9MbhDztiq+DJF+kTy86TLskqFOB5RyhBu+wg/Qncq3CDRphMIpN1858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017053; c=relaxed/simple;
	bh=0nE7QD8R9X0d9WOt6Py/ZQqnSBYaJ14Cq8HdaHinac8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGkVSV2Tsawckq3VVwurPriuqb/9WfkQ2AuZS+ek1BjjLbXfe7o74SGjM9maDKb92EKpkkR011RNVMXAHfcMvKmR4hBlp6tGZmnc9sW2cyuaoIqe78K6jHHjcoB2gBtDdaY9ppY7QIZlckN0GiMdwgCcOPLiD5HF3I1GEczZxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azgEBJsU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70427fb838cso60375657b3.2;
        Wed, 30 Apr 2025 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017050; x=1746621850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYD/e9HMz+OJe2iFW7OVgI9MMmAx8NXfVM7dg8rgiXU=;
        b=azgEBJsUXM19BEjM5fQJ9Dm6z0s1ah6T9A5ioE0ALkhlAvcur66DLpNqUh3ccbxO4L
         ow/2a6o8vhPz0ANIyX9ytjXZRfCTPS9nFFyJgoJHqruV4fJbKlo2tlk9gFIPbh2XvTr2
         HFyrH+EhewF7ypz/bfiKOg1zVm7twcXVDC+M+WPi/Q20I93mIeH+LVJTg+xJkiy2JlH9
         pP+eBl0HkdXvVJpku8IYXIE0n1OcqP9GWTBQyYGnrWpzgK/xGdDjgAayi0iTKp79NomY
         gPvJ5iYHrhazlVDnCA0dmroJfQ9ATWq4sxT94K5UBq2XSQ7RTQEAHnttcg8NVG45VYJF
         e7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017050; x=1746621850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYD/e9HMz+OJe2iFW7OVgI9MMmAx8NXfVM7dg8rgiXU=;
        b=HKex3CpK7S7TBIEyepvWx8qgeYsyBojlsafZBujLa+YGnUn+Ov6cjw58B6eZv2wSPJ
         HOYA+mkcrvy9/i1773afNU4wF65d4lgsuNFch7DGak0MFcU2nPxMD2GP9a1qwvVPFBsT
         mwavXIcMDrDjRLNnpBztfwkae3DSSrODEgNUTNlmBqIdj3GTlncjXeFVyzDNuX+Bilrt
         mYKhU1hCgaWXX2Wufe0P7uujCV/+bF1mU2dU5K2JQQJv7CEZz7Vha4smShPF7fX96vCy
         LX6QdZRRgviGrz+mJ9T2HH+PPLfmGv+A6ki/o0fjVvs5CiKFI6+3EL/B7U+OBNzC1mgR
         THqw==
X-Forwarded-Encrypted: i=1; AJvYcCV6cwz2fxlN088dXYu7crgIISS2TEPyPif9PU2sAV0IN3FqQmgrsckJwTMPdk8iPh0QTZEY9toay2/HuigmokVIL5gX@vger.kernel.org, AJvYcCVNUgzlrBsbHYK0kf5Iu2idpjxJvjDBKqUgYjaa9iDgNDJXkAGFYaAR/++jveqCR0+kBNkoY/nv@vger.kernel.org, AJvYcCVsIJr5LFCA309CuRCw1HBMXylSkwBkyrxnz3Kcq84lD1h4RdvyAkQpwFlW1GOZjABqqmG7AzF6ZmE+iGDK1L4O@vger.kernel.org, AJvYcCWBvzKmhvwGGISeNOZdQRWWAIcdh9H+7pQ4R+YWXmEThOJWgcaMrE5toMf5hIxEXP0C+6vSIhUMs4Zx6lhQ@vger.kernel.org, AJvYcCWmnGq0ps/YvkWWTxtK4shUYXYbr9VYHngJldnezkfKP3Q002xM43b5i5h5YwYMwzQthTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4GZdWQkfurxEs60mYJG+OYjczzYskCZDY4zd5b87jsuTL+oO
	eSWnWfUycUc8A0rMMudsC8nTivwRxJ/IXcPPbCZHWAthcbnzWL0VIeRsCOv4g+5PFUGPigsWg5E
	infSqrW2SbzIEJwkRJKRIBVmqjxk=
X-Gm-Gg: ASbGncupsydVj6ON9WI3srLk3EBl0uC3dFlPZSzIxSWa1BzALyLLyD7O0088LW8JmNN
	L0UiSslNmJWZao3e4R3mFyE9ge1RLNJ01X95POZh/msSXO3rfJgg9jVRB3XpCyj2JFCQjWctQTp
	i7OG7i2oEm+dX7Go51KiqKd9kaOwU4dHaC
X-Google-Smtp-Source: AGHT+IFVSMx6r+9xvLAlfO62j5IU/jBOv4h47dZ+HB9stjJy87/P6nY2mF6tVSFzpXL0p93chsv1SMcI66Wv81nUArY=
X-Received: by 2002:a05:690c:7009:b0:6fe:b88e:4d94 with SMTP id
 00721157ae682-708abd8f399mr45436957b3.19.1746017049961; Wed, 30 Apr 2025
 05:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426160027.177173-1-mannkafai@gmail.com> <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
In-Reply-To: <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
From: Kafai Wan <mannkafai@gmail.com>
Date: Wed, 30 Apr 2025 20:43:58 +0800
X-Gm-Features: ATxdqUH4VhW7N1bQc1Q9VVv6LfEr-XG7U9j0iRwNg1M8Kh8644-dVZBS560qWHY
Message-ID: <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Apr 26, 2025 at 9:00=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> w=
rote:
> >
> > Adding support to use get_func_[arg|arg_cnt] helpers in raw_tp/tp_btf
> > programs.
> >
> > We can use get_func_[arg|ret|arg_cnt] helpers in fentry/fexit/fmod_ret
> > programs currently. If we try to use get_func_[arg|arg_cnt] helpers in
> > raw_tp/tp_btf programs, verifier will fail to load the program with:
> >
> > ; __u64 cnt =3D bpf_get_func_arg_cnt(ctx);
> > 3: (85) call bpf_get_func_arg_cnt#185
> > unknown func bpf_get_func_arg_cnt#185
> >
> > Adding get_func_[arg|arg_cnt] helpers in raw_tp_prog_func_proto and
> > tracing_prog_func_proto for raw tracepoint.
> >
> > Adding 1 arg on ctx of raw tracepoint program and make it stores number=
 of
> > arguments on ctx-8, so it's easy to verify argument index and find
> > argument's position.
> >
> > Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> > ---
> >  kernel/trace/bpf_trace.c | 17 ++++++++++++++---
> >  net/bpf/test_run.c       | 13 +++++--------
> >  2 files changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 52c432a44aeb..eb4c56013493 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1892,6 +1892,10 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
> >                 return &bpf_get_stackid_proto_raw_tp;
> >         case BPF_FUNC_get_stack:
> >                 return &bpf_get_stack_proto_raw_tp;
> > +       case BPF_FUNC_get_func_arg:
> > +               return &bpf_get_func_arg_proto;
> > +       case BPF_FUNC_get_func_arg_cnt:
> > +               return &bpf_get_func_arg_cnt_proto;
> >         case BPF_FUNC_get_attach_cookie:
> >                 return &bpf_get_attach_cookie_proto_tracing;
> >         default:
> > @@ -1950,10 +1954,16 @@ tracing_prog_func_proto(enum bpf_func_id func_i=
d, const struct bpf_prog *prog)
> >         case BPF_FUNC_d_path:
> >                 return &bpf_d_path_proto;
> >         case BPF_FUNC_get_func_arg:
> > +               if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > +                   prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> > +                       return &bpf_get_func_arg_proto;
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ar=
g_proto : NULL;
> >         case BPF_FUNC_get_func_ret:
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_re=
t_proto : NULL;
> >         case BPF_FUNC_get_func_arg_cnt:
> > +               if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > +                   prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> > +                       return &bpf_get_func_arg_cnt_proto;
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ar=
g_cnt_proto : NULL;
> >         case BPF_FUNC_get_attach_cookie:
> >                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > @@ -2312,7 +2322,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link=
, u64 *args)
> >  #define REPEAT(X, FN, DL, ...)         REPEAT_##X(FN, DL, __VA_ARGS__)
> >
> >  #define SARG(X)                u64 arg##X
> > -#define COPY(X)                args[X] =3D arg##X
> > +#define COPY(X)                args[X + 1] =3D arg##X
> >
> >  #define __DL_COM       (,)
> >  #define __DL_SEM       (;)
> > @@ -2323,9 +2333,10 @@ void __bpf_trace_run(struct bpf_raw_tp_link *lin=
k, u64 *args)
> >         void bpf_trace_run##x(struct bpf_raw_tp_link *link,            =
 \
> >                               REPEAT(x, SARG, __DL_COM, __SEQ_0_11))   =
 \
> >         {                                                              =
 \
> > -               u64 args[x];                                           =
 \
> > +               u64 args[x + 1];                                       =
 \
> > +               args[0] =3D x;                                         =
   \
> >                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);                 =
 \
> > -               __bpf_trace_run(link, args);                           =
 \
> > +               __bpf_trace_run(link, args + 1);                       =
 \
>
> This is neat, but what is this for?
> The program that attaches to a particular raw_tp knows what it is
> attaching to and how many arguments are there,
> so bpf_get_func_arg_cnt() is a 5th wheel.
>
> If the reason is "for completeness" then it's not a good reason
> to penalize performance. Though it's just an extra 8 byte of stack
> and a single store of a constant.
>
If we try to capture all arguments of a specific raw_tp in tracing programs=
,
We first obtain the arguments count from the format file in debugfs or BTF
and pass this count to the BPF program via .bss section or cookie (if
available).

If we store the count in ctx and get it via get_func_arg_cnt helper in
the BPF program=EF=BC=8C
a) It's easier and more efficient to get the arguments count in the BPF pro=
gram.
b) It could use a single BPF program to capture arguments for multiple raw_=
tps,
reduce the number of BPF programs when massive tracing.

Thanks,
KaFai

> pw-bot: cr

