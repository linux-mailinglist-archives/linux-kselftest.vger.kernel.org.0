Return-Path: <linux-kselftest+bounces-32098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730BAAA64EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D517A60C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F51253949;
	Thu,  1 May 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJeb9yoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12E21ABDA;
	Thu,  1 May 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132825; cv=none; b=V/+DZ3sKER13zBew8gDxOdm/r/CY/urmX7bSLrBK4U67zfC64PCUiNioFspwr/XKmc2K3hoBrommYI4cJ+zw75Q2Jsqxf+j1BIGoC4OcO8Y754CLbesoNrjChdBu2fqRWKZt39jFZp6Um+e4e1mlglDUw4UW7bKiBmKig+3Bebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132825; c=relaxed/simple;
	bh=uf9J6K8icpSTYBFn1WPTGjVI28ZYwPtUdz2rTF6uLr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwzuea0y2UIbSc3K+dNn/lH1vX8+DCeARxbBsb4KU23X9XwE39aEUlMy9quBg3oARu92D4UMWEDRretiTj+h9XCEwfi6uRp/7t+MsY2VgtupeSZtWSLEPYHM5s69rIr3f+sD04LuwQ2AupUzxslzsMZxQ1B3sLvPWBWFsc0B6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJeb9yoQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3081f72c271so1497410a91.0;
        Thu, 01 May 2025 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746132823; x=1746737623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9IyC8UAFX/aTae5pZf/sLjV8f805gR64h9VxD6CcD0=;
        b=nJeb9yoQl5lh7bvgCZIpk6+HY5AdU5HEykmxCqBegZ4m3M+uAbcCSyi/X4nJj+q8Kd
         HJoyLJmZoEQEiD4SWmoTGs4fMZW8WPEfl17/NTYm/1WG6L7Z6kZVx1EH0QsoMf7EXW3b
         q142oDQQGuUDbdHe1jIEdQzHyr3BH1fdnQyQe8RINf/bQJL3Nb3Zs0R12M5Air6Q/6Ag
         c9rrs9xTQz9HmkTsUZZ8Z2HYh0b4S/ooRf7Cn4D4KkKVihkYwXZ3JrZwuwGglyfMTgg9
         q95nvZlIbAIa3tzriyczofiXoa+HFAFRiPf7UogtK53nLL03rojNizCUQUrnmHlHBolh
         zIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132823; x=1746737623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9IyC8UAFX/aTae5pZf/sLjV8f805gR64h9VxD6CcD0=;
        b=dWkvdPyaSZl/qyaPZMaGtniSfwp17is4LDCo5kxBIFEVmardvWO9bETSFFPtNMFRQO
         EcZVd17981Eo9/Ah5h+Pbc91YHfQQnF3ZHwoPcK+40nZpnG0qLGhp1mJyxzTqghbBkus
         p4QVjWTNWL/z3kqCNwgpijhz+BFOUhgjNbhIIj9DcI/mwyJasnVwna87o1ylq4xYNhMD
         DiImMd7w8MqoUqmpfNYkPFN35/rKEZVHBitxspH+mWRwW3UqK9QjzVh/s8E5+HVSxNPW
         CyZbklsPxju4HYZeFHsZH5/W3ighg58r5nyOKSF/uQ5J6T93aEWEmRJNdpybQDPEwVaY
         BmbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNAVavUGasBU41f2vS1DlIz68YqYE4d4FcNKk9JMNOD1ab1wVHV1mOiwABn56qLM8jyGpWBV6lTxWPb1C4kC8Rrg4Q@vger.kernel.org, AJvYcCUao22reWsQ7/VN8QQGl4JP7plztuW21k0VZS47bPSyM7Gpfn0NxHp9FnKXuwXo9stSB+k=@vger.kernel.org, AJvYcCUcQHxnx4SYeD5XhixGm3sHpOx52f4y0kp6DOdmUd/PmvdknKNmw16UOdUalZMbIV1NX7K5/y0t@vger.kernel.org, AJvYcCV8wo/j5j9VRI+p9E3WxJCeFf2yjX4TTeCs3wE0FusNErKSsDBoHbDF86U7kUL08dDFypUaRDt5jjZGkMNl@vger.kernel.org, AJvYcCVnvhdsOlpVCdelJJi0WAiHG3/FmA1xqVfab4vAgMJkjZixfO3ZTOPkHeLXy1nEB9VSKwh/e43Ih3T42r1aoWcE@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzsUJNPOF4+MkboSCrfAXBPfpL6LIQ27I9TFrMM7fYYqSO/cf
	VusI/NgLDW0/FnwXfz+6aqrm2vKNOUEEAYxLV75agTuQN1JVzWog4FiPMUvxW+qk/Gix7kyzLSb
	8VPdDv4nEMADl6tjOZjJtfeF9jHo=
X-Gm-Gg: ASbGncsFmN9fC6CSKkuKzV+nWWelf7H8dUoAcZW1gj9KkJ/QFjlK7JlQ4a4Rn7wudOW
	kWt8FFPWtqzXHweGNZjurqvft7na76tif9h7kOgziTsBeAtDvneI8cAEZcUB3sQDkh/ZincBGzL
	/Sw55qhMDiwM+B3iakHHVZx+qKXGsU2SfljF7C9A==
X-Google-Smtp-Source: AGHT+IHX5Y/7mWlgUlKwgH183gy9bME2R0Xw6yJGkx81G6XmO+mvv9U1mwVvHzl8OF7R8sUb/DhMBqoexK0IkyG2xiE=
X-Received: by 2002:a17:90a:dfc5:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30a4e6b597cmr701796a91.35.1746132822765; Thu, 01 May 2025
 13:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426160027.177173-1-mannkafai@gmail.com> <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com> <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
In-Reply-To: <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 13:53:30 -0700
X-Gm-Features: ATxdqUGbkuqroaIZgww60DyCYIyGyUnnnV0zd58Bzi4hnregWkawXdyJ6cmycDI
Message-ID: <CAEf4BzauZi8c66FFXACdzaV=cC0fngwiMCL47ct08NhBoT26uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Kafai Wan <mannkafai@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Song Liu <song@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
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

On Wed, Apr 30, 2025 at 5:44=E2=80=AFAM Kafai Wan <mannkafai@gmail.com> wro=
te:
>
> On Wed, Apr 30, 2025 at 10:46=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Apr 26, 2025 at 9:00=E2=80=AFAM KaFai Wan <mannkafai@gmail.com>=
 wrote:
> > >
> > > Adding support to use get_func_[arg|arg_cnt] helpers in raw_tp/tp_btf
> > > programs.
> > >
> > > We can use get_func_[arg|ret|arg_cnt] helpers in fentry/fexit/fmod_re=
t
> > > programs currently. If we try to use get_func_[arg|arg_cnt] helpers i=
n
> > > raw_tp/tp_btf programs, verifier will fail to load the program with:
> > >
> > > ; __u64 cnt =3D bpf_get_func_arg_cnt(ctx);
> > > 3: (85) call bpf_get_func_arg_cnt#185
> > > unknown func bpf_get_func_arg_cnt#185
> > >
> > > Adding get_func_[arg|arg_cnt] helpers in raw_tp_prog_func_proto and
> > > tracing_prog_func_proto for raw tracepoint.
> > >
> > > Adding 1 arg on ctx of raw tracepoint program and make it stores numb=
er of
> > > arguments on ctx-8, so it's easy to verify argument index and find
> > > argument's position.
> > >
> > > Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> > > ---
> > >  kernel/trace/bpf_trace.c | 17 ++++++++++++++---
> > >  net/bpf/test_run.c       | 13 +++++--------
> > >  2 files changed, 19 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 52c432a44aeb..eb4c56013493 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1892,6 +1892,10 @@ raw_tp_prog_func_proto(enum bpf_func_id func_i=
d, const struct bpf_prog *prog)
> > >                 return &bpf_get_stackid_proto_raw_tp;
> > >         case BPF_FUNC_get_stack:
> > >                 return &bpf_get_stack_proto_raw_tp;
> > > +       case BPF_FUNC_get_func_arg:
> > > +               return &bpf_get_func_arg_proto;
> > > +       case BPF_FUNC_get_func_arg_cnt:
> > > +               return &bpf_get_func_arg_cnt_proto;
> > >         case BPF_FUNC_get_attach_cookie:
> > >                 return &bpf_get_attach_cookie_proto_tracing;
> > >         default:
> > > @@ -1950,10 +1954,16 @@ tracing_prog_func_proto(enum bpf_func_id func=
_id, const struct bpf_prog *prog)
> > >         case BPF_FUNC_d_path:
> > >                 return &bpf_d_path_proto;
> > >         case BPF_FUNC_get_func_arg:
> > > +               if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > > +                   prog->expected_attach_type =3D=3D BPF_TRACE_RAW_T=
P)
> > > +                       return &bpf_get_func_arg_proto;
> > >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_=
arg_proto : NULL;
> > >         case BPF_FUNC_get_func_ret:
> > >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_=
ret_proto : NULL;
> > >         case BPF_FUNC_get_func_arg_cnt:
> > > +               if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > > +                   prog->expected_attach_type =3D=3D BPF_TRACE_RAW_T=
P)
> > > +                       return &bpf_get_func_arg_cnt_proto;
> > >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_=
arg_cnt_proto : NULL;
> > >         case BPF_FUNC_get_attach_cookie:
> > >                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > > @@ -2312,7 +2322,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *li=
nk, u64 *args)
> > >  #define REPEAT(X, FN, DL, ...)         REPEAT_##X(FN, DL, __VA_ARGS_=
_)
> > >
> > >  #define SARG(X)                u64 arg##X
> > > -#define COPY(X)                args[X] =3D arg##X
> > > +#define COPY(X)                args[X + 1] =3D arg##X
> > >
> > >  #define __DL_COM       (,)
> > >  #define __DL_SEM       (;)
> > > @@ -2323,9 +2333,10 @@ void __bpf_trace_run(struct bpf_raw_tp_link *l=
ink, u64 *args)
> > >         void bpf_trace_run##x(struct bpf_raw_tp_link *link,          =
   \
> > >                               REPEAT(x, SARG, __DL_COM, __SEQ_0_11)) =
   \
> > >         {                                                            =
   \
> > > -               u64 args[x];                                         =
   \
> > > +               u64 args[x + 1];                                     =
   \
> > > +               args[0] =3D x;                                       =
     \
> > >                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);               =
   \
> > > -               __bpf_trace_run(link, args);                         =
   \
> > > +               __bpf_trace_run(link, args + 1);                     =
   \
> >
> > This is neat, but what is this for?
> > The program that attaches to a particular raw_tp knows what it is
> > attaching to and how many arguments are there,
> > so bpf_get_func_arg_cnt() is a 5th wheel.
> >
> > If the reason is "for completeness" then it's not a good reason
> > to penalize performance. Though it's just an extra 8 byte of stack
> > and a single store of a constant.
> >
> If we try to capture all arguments of a specific raw_tp in tracing progra=
ms,
> We first obtain the arguments count from the format file in debugfs or BT=
F
> and pass this count to the BPF program via .bss section or cookie (if
> available).

To do anything useful with those arguments beside printing their
values in hex you'd need to lookup BTF anyways, no? So at that point
what's the problem just passing the number of arguments as a BPF
cookie?

And then bpf_probe_read_kernel(..., cnt * 8, ctx)?

>
> If we store the count in ctx and get it via get_func_arg_cnt helper in
> the BPF program=EF=BC=8C
> a) It's easier and more efficient to get the arguments count in the BPF p=
rogram.
> b) It could use a single BPF program to capture arguments for multiple ra=
w_tps,
> reduce the number of BPF programs when massive tracing.
>
> Thanks,
> KaFai
>
> > pw-bot: cr

