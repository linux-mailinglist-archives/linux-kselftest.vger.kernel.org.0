Return-Path: <linux-kselftest+bounces-32037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF02AA521A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 18:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154629C1714
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF54264608;
	Wed, 30 Apr 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5+jhZFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F171D7984;
	Wed, 30 Apr 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032010; cv=none; b=tCRrLQEPBVKG91S4IYbEPgr/DtBTTG/L2PiAciDWyeyBwZR5DZKqaD9gaeCgihfW4i0rc5Ocdogcstc+iaV+NQl2imOBY99mPXKjCLO6N4NMPG+1ermQbcVyZFEhg2BDzZJopQ7DDpjeL6gSRYtK7V1Nxg0FSqIkZ37mF1leiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032010; c=relaxed/simple;
	bh=BBMsd/oizy20IUV96EPxJNmvZVs0GIKVqE5EGiMLivc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtTx7XYG9NLeeVFdcBjJh4SrW4kUngxg3fLrN+7YgmnN2t4JU3c8RY93tffQSFBb6o+F+vUQmtQzzTAoKLCkWNVpNLyBLJqqBYidUjeipRxSRcXlyD2EVTrTOfkmBp5aK2tncIc4IYr2LiMwImpXRQrsD+O/166jlWOPWMOy0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5+jhZFo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso67523f8f.1;
        Wed, 30 Apr 2025 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746032007; x=1746636807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyqoFwnx1rN119y/EQDLgAAtG+9Od9yyi7V0yRmYe1Y=;
        b=j5+jhZFo1DiaCKv+6sWRLRfvn+bdSHbxC02gj9bjsob0pP/9GFhw8/33JlZGS/O/cx
         3sLdfnkLHDX1D/kdvW2tUTYAufC14MELRGdGzxdGooMdR23PcNhd/7zDNL+GVNnhMx1Z
         3/+5+BBnkzjMDnlPSJBHDbldm/IikqBdVqe86lqQha1Dnol71EpIqMshs+PCK2ItKKiE
         HujqYIDHWypVsb7kHmCsiLbU/kqhXtZNt3T33Utt03JQP4Ln7giRCPCGl+F/CNkeDrH4
         jOOGeSlD1U6nZh4rUY95PkIYFA5I6HGoItTCDXsSEY3GzbsWnKDV29nfEBpi5tIMEKR/
         H6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032007; x=1746636807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyqoFwnx1rN119y/EQDLgAAtG+9Od9yyi7V0yRmYe1Y=;
        b=FFHjlgCEqfU5cCPAEV39tUsTIa9KSWb1puzn+NaLTGPaq7MbDdl7JhLsRopjcJ3cBB
         JdKfWk4AssMkqUACxoF3DH8Kv4n+mL8AcqR5pQWo7/xbWZXhcHgJw2GMW9qlTjv/XyKA
         XvHJTtVgEZQ+3K4381aUDP0ciu0g/ElePqSkXBnZxikeUB/K2fXv23GnuzbK0TBvlzow
         2fET6zyjoC99WMeBkfPXH3cvKivmLtVWNa3LubCcQTcz1x1Zlei9Ud+PsRTzgH+aKdxA
         MkH9eb0ERcl52gAPHoZdjwWaaxJ6Vr7LMA5gXmSxANPxPXBh65vbPtL8xZH2f4DnkHfb
         w/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2rupEOH1+xPm8eyOReT7gGoBRPNIYhB+yV+qn9xgusjpkdMEQYv+HuYTuulGuupjTsfQ=@vger.kernel.org, AJvYcCUB7XXtMfRJdfw9tU5RXX9dGbXSAc8yHR/eQdCIayYgyWwd+RUFENrp7E1HPWtxIZidM8ONMzkucukuZqgN@vger.kernel.org, AJvYcCV+BwuKtHcygL4Ho7Uw059D6/SsqJfx2NOynYpSwkWgRsvp35zrHZ9U3SSFb9L1zGhC0XFww2Sw@vger.kernel.org, AJvYcCXSkOr64L3kHRgID4O0gloeVd5I53p5js1attL++W0XkU1DU5rdVZh0AM1vTDOBNoEAEH4AJt3g3+vEPhEhHU1fB45L@vger.kernel.org, AJvYcCXyOICrzdowK6K6UaGFFpfNQI6wZOvSolGvYG4Xx1qeD35HIW0necr/fA3VWsBuQcueh7XkLIJKpfoPI+I4MSi3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2TJax06/rkuF5WTzGloPodJ/RdpyGVkfWVyrRcWt41nFz8O/
	r5UHjWUpKipofo9BJGa9vsRe+DCwO+sPsX934VhuDvHQiyMJsd3LH+KN9H5G8CDw0/zSkzl6C09
	IqLQadg1j6FHs4KHTs4/5/J71TD0=
X-Gm-Gg: ASbGnctlze7WOMKhjESb8wCcAj6rGAV5nQTbXzhPCl6Chs4KDbWJWGhVACHlAU/U8V4
	Eu4dySs/cSX1q+fTHMJFdAZ8Kr+2ZNAYFDnzeFe4twV46BZRUf1xpaQ82gkolrgCYcCyPMY1TcH
	caLrx+nyD2oMKIkm+nPIXvUuTi45E+c9pMyL8lPg==
X-Google-Smtp-Source: AGHT+IGktp2atpBKpp4ur5fbFBTf4kR6IH2vBfdClEMDlfV8ktjOsDPmmtEvHUeJRGc4jX1Itzt6phHMVfWVJf1Cjrg=
X-Received: by 2002:a05:6000:64a:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-3a092d0230cmr179055f8f.25.1746032006951; Wed, 30 Apr 2025
 09:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426160027.177173-1-mannkafai@gmail.com> <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
 <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com> <f951b81f-1b46-4219-82fd-0839e27ab3f3@linux.dev>
In-Reply-To: <f951b81f-1b46-4219-82fd-0839e27ab3f3@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 09:53:15 -0700
X-Gm-Features: ATxdqUHCM_hgru1Pfc1BqXTKZ-VBkhd7Cw8k1b6R1YPnD0rN_9RdWCr9fvClEug
Message-ID: <CAADnVQ+FANha0fO_BF+iHJ4iZSCPtDfoUkzR8mMFwOakw8+eCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Kafai Wan <mannkafai@gmail.com>, Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/4/30 20:43, Kafai Wan wrote:
> > On Wed, Apr 30, 2025 at 10:46=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Sat, Apr 26, 2025 at 9:00=E2=80=AFAM KaFai Wan <mannkafai@gmail.com=
> wrote:
> >>>
>
> [...]
>
> >>> @@ -2312,7 +2322,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *li=
nk, u64 *args)
> >>>  #define REPEAT(X, FN, DL, ...)         REPEAT_##X(FN, DL, __VA_ARGS_=
_)
> >>>
> >>>  #define SARG(X)                u64 arg##X
> >>> -#define COPY(X)                args[X] =3D arg##X
> >>> +#define COPY(X)                args[X + 1] =3D arg##X
> >>>
> >>>  #define __DL_COM       (,)
> >>>  #define __DL_SEM       (;)
> >>> @@ -2323,9 +2333,10 @@ void __bpf_trace_run(struct bpf_raw_tp_link *l=
ink, u64 *args)
> >>>         void bpf_trace_run##x(struct bpf_raw_tp_link *link,          =
   \
> >>>                               REPEAT(x, SARG, __DL_COM, __SEQ_0_11)) =
   \
> >>>         {                                                            =
   \
> >>> -               u64 args[x];                                         =
   \
> >>> +               u64 args[x + 1];                                     =
   \
> >>> +               args[0] =3D x;                                       =
     \
> >>>                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);               =
   \
> >>> -               __bpf_trace_run(link, args);                         =
   \
> >>> +               __bpf_trace_run(link, args + 1);                     =
   \
> >>
> >> This is neat, but what is this for?
> >> The program that attaches to a particular raw_tp knows what it is
> >> attaching to and how many arguments are there,
> >> so bpf_get_func_arg_cnt() is a 5th wheel.
> >>
> >> If the reason is "for completeness" then it's not a good reason
> >> to penalize performance. Though it's just an extra 8 byte of stack
> >> and a single store of a constant.
> >>
> > If we try to capture all arguments of a specific raw_tp in tracing prog=
rams,
> > We first obtain the arguments count from the format file in debugfs or =
BTF
> > and pass this count to the BPF program via .bss section or cookie (if
> > available).
> >
> > If we store the count in ctx and get it via get_func_arg_cnt helper in
> > the BPF program=EF=BC=8C
> > a) It's easier and more efficient to get the arguments count in the BPF=
 program.
> > b) It could use a single BPF program to capture arguments for multiple =
raw_tps,
> > reduce the number of BPF programs when massive tracing.
> >
>
>
> bpf_get_func_arg() will be very helpful for bpfsnoop[1] when tracing tp_b=
tf.
>
> In bpfsnoop, it can generate a small snippet of bpf instructions to use
> bpf_get_func_arg() for retrieving and filtering arguments. For example,
> with the netif_receive_skb tracepoint, bpfsnoop can use
> bpf_get_func_arg() to filter the skb argument using pcap-filter(7)[2] or
> a custom attribute-based filter. This will allow bpfsnoop to trace
> multiple tracepoints using a single bpf program code.

I doubt you thought it through end to end.
When tracepoint prog attaches we have this check:
        /*
         * check that program doesn't access arguments beyond what's
         * available in this tracepoint
         */
        if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
                return -EINVAL;

So you cannot have a single bpf prog attached to many tracepoints
to read many arguments as-is.
You can hack around that limit with probe_read,
but the values won't be trusted and you won't be able to pass
such untrusted pointers into skb and other helpers/kfuncs.

