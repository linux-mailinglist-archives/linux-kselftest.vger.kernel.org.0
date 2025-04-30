Return-Path: <linux-kselftest+bounces-32006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A1AA411F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 04:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05C27B8C38
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634A1CDFD4;
	Wed, 30 Apr 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEePr3LU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9222111;
	Wed, 30 Apr 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981181; cv=none; b=sjnDZX8icW86Tw4+Cv9v2/9QTVmeCKndGf4URaGBtUWJwdoC6Y33EXY1ow/uy+Dcm1GNqNgULNKhCVX5xv170J2nysD29TX19m1JAGjQyJYitn2ZAUUImMJjrKTJWvapDMzqLqXzxhn5KcytqjIooKYIptfNYbLaKXxIrXuOiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981181; c=relaxed/simple;
	bh=tZj+fajqPvkq+73cH8tXJlYZvR+o5VeoP5VRKaX/kYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB+512tmcvm1Sx1W+CWuE5GUFMU/LwbY3TbX6nOPz0eO3GBQA6ml6JIVeSn6jameT+FQSRL6F2tg1Edh7kAzJdQRa8/uOb2LPcfz8P9krYe2l9VxkakdPbuu0KhPVBoI4YyBWxpWyroMLTSL+fjXgG7SLNQVarTcYfkDGXPyUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEePr3LU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso4613188f8f.1;
        Tue, 29 Apr 2025 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745981178; x=1746585978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRoA1hn+ILrnaL3QGiypq6EmGKcTVkU7YdYU9NCLYKU=;
        b=mEePr3LU84EtC9YaEi9hNKvUJIOZmFmn/Eo0/UTHWk0urD0ylMheKy1GZ/sStSeRil
         Wr/Ze2udmPdC2hkMCXgDzIhMbmbaAXYZZsMNy7w8wy+OBBeaxWt1Cr84DBR8ezusVBuU
         ZLFCNo/1oc/1in46B0jp7vAJILjNTltmXIUu+GCq0ra2fBNb2V/uqddrpZlskeMhuGaL
         v4FF/dJat/j3W5V3/kYT+cqBZrYyQGZA9tMAWKZmX3BNEBhfS6+kC87bcGLlPDGoemNB
         AymalL4OzLyFD7OUnLHESJWQpxgcUW1+uP5wJY1uVGRIibjmj8AOFGr5rXJdZtHmx6NX
         m7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745981178; x=1746585978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRoA1hn+ILrnaL3QGiypq6EmGKcTVkU7YdYU9NCLYKU=;
        b=QIC0HTmi6Oek2SC8mdBKTZhgNvxHTX+myGHy1SAQyukzCYyJktwiFFKdSAyHzsDkac
         NrnhrMJ5U17KybTaDzN/LQYQd4an2UPEhWnIuB7oeywWlVSfyI+K7AI/eEzKPtV4gi0s
         yhplMj/HNIAxJYMijcgCVa9KXljez4W5CZ4zve4DY0ZAQgPRUjzG0Fwn06wQaR17C96M
         KG7DBZAG6EGF4HtbjHaSMZg1REEpG/6L65BY2TQ16CEBepGlL84JHFi0DsxQchN94qR6
         XTJ0SogE/KxDDdOQ9eAOrvLQ0ULNhvxaKKlcfYaqJ5PNjlH84qA/JLY6NQdoMhTWGcyo
         HgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9A7LrTxqmLjDqG6bV6iYt/uj3ILLdRLDnsPO50ICpmHUxY3LFPauW+vuQiaTbHxFh+9zjeKNeRSdOZG79@vger.kernel.org, AJvYcCUAMHfQJuGEZB7mxYOdu6Vadi0XK/B1eo+OjDOrf0V8ESkeBjLWSiZoMZbDwALLa3lpCXAk1JEMUnkvNgbbDzEt@vger.kernel.org, AJvYcCUZlK77ziAXzRrY+i/GbiNLWfsIpuagwpFO7xLLhz6Oy2ZGUvaiRHK+Bqghj6LpskFWE6A=@vger.kernel.org, AJvYcCXF5oPIrrV+N3qT/HwrL9y5mnLWFggv+1jh3YhQqllsaSSklTHfkt9M7mZvnU+pgALsaQ4lpKNvz29q+555ueDmK5lq@vger.kernel.org, AJvYcCXTJWr0BEnSX28DlijCVyDsy2dib4Xoen3+inZX5Vclb8NhjNHlAx7o7M/Txk9C7+0M2PvNSC9x@vger.kernel.org
X-Gm-Message-State: AOJu0YyuIYUPW2sOZtRPKmGs3eB/L0EIVbQrEp6mDK/+4UGIatlqk+cm
	of36ArkLnoQ/Ly8evwfjrcGBu8qyGE7Ns1oxSjo7Em57Wavq4QNmWM7De2v5D5RPDSruJMIkB4q
	tLHizz1pDorQ3993cvB5Fx14f83E=
X-Gm-Gg: ASbGnctKC3FZYpKCl81deylRNJQp/JcqBivd8fVsawLBmGqUGdEEAe9CxJPnBOnHgFG
	skQBBStPbEkPCZLHEuuEpTbzs2rONk7QTS2WxGlj1291TD3z3lJ2w6n/r5aLbJYvAgd2fFD6vh1
	PwofZyxQMsEBq0MYyTZESJWCfT14NjOVPt0DlNUw==
X-Google-Smtp-Source: AGHT+IEseH2I0pUjM+B8W45c5JTdHLZ05e9zXlXFhwq6KjuhDIGYFugjVOnMpqk2DxAdfmZQOfc3MHYNAs8vZ5GnN6A=
X-Received: by 2002:a5d:64e5:0:b0:391:4bfd:6d5 with SMTP id
 ffacd0b85a97d-3a08ff5558emr512089f8f.52.1745981177742; Tue, 29 Apr 2025
 19:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426160027.177173-1-mannkafai@gmail.com> <20250426160027.177173-2-mannkafai@gmail.com>
In-Reply-To: <20250426160027.177173-2-mannkafai@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 19:46:05 -0700
X-Gm-Features: ATxdqUFMquDKYdhGCyZiHIRKlu07tHBastoNqC0uT60dUlJw9_rSYO-AjZ2fBT4
Message-ID: <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: KaFai Wan <mannkafai@gmail.com>
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

On Sat, Apr 26, 2025 at 9:00=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> Adding support to use get_func_[arg|arg_cnt] helpers in raw_tp/tp_btf
> programs.
>
> We can use get_func_[arg|ret|arg_cnt] helpers in fentry/fexit/fmod_ret
> programs currently. If we try to use get_func_[arg|arg_cnt] helpers in
> raw_tp/tp_btf programs, verifier will fail to load the program with:
>
> ; __u64 cnt =3D bpf_get_func_arg_cnt(ctx);
> 3: (85) call bpf_get_func_arg_cnt#185
> unknown func bpf_get_func_arg_cnt#185
>
> Adding get_func_[arg|arg_cnt] helpers in raw_tp_prog_func_proto and
> tracing_prog_func_proto for raw tracepoint.
>
> Adding 1 arg on ctx of raw tracepoint program and make it stores number o=
f
> arguments on ctx-8, so it's easy to verify argument index and find
> argument's position.
>
> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> ---
>  kernel/trace/bpf_trace.c | 17 ++++++++++++++---
>  net/bpf/test_run.c       | 13 +++++--------
>  2 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 52c432a44aeb..eb4c56013493 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1892,6 +1892,10 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>                 return &bpf_get_stackid_proto_raw_tp;
>         case BPF_FUNC_get_stack:
>                 return &bpf_get_stack_proto_raw_tp;
> +       case BPF_FUNC_get_func_arg:
> +               return &bpf_get_func_arg_proto;
> +       case BPF_FUNC_get_func_arg_cnt:
> +               return &bpf_get_func_arg_cnt_proto;
>         case BPF_FUNC_get_attach_cookie:
>                 return &bpf_get_attach_cookie_proto_tracing;
>         default:
> @@ -1950,10 +1954,16 @@ tracing_prog_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         case BPF_FUNC_d_path:
>                 return &bpf_d_path_proto;
>         case BPF_FUNC_get_func_arg:
> +               if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> +                   prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> +                       return &bpf_get_func_arg_proto;
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
proto : NULL;
>         case BPF_FUNC_get_func_ret:
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_=
proto : NULL;
>         case BPF_FUNC_get_func_arg_cnt:
> +               if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> +                   prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> +                       return &bpf_get_func_arg_cnt_proto;
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
cnt_proto : NULL;
>         case BPF_FUNC_get_attach_cookie:
>                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> @@ -2312,7 +2322,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, =
u64 *args)
>  #define REPEAT(X, FN, DL, ...)         REPEAT_##X(FN, DL, __VA_ARGS__)
>
>  #define SARG(X)                u64 arg##X
> -#define COPY(X)                args[X] =3D arg##X
> +#define COPY(X)                args[X + 1] =3D arg##X
>
>  #define __DL_COM       (,)
>  #define __DL_SEM       (;)
> @@ -2323,9 +2333,10 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link,=
 u64 *args)
>         void bpf_trace_run##x(struct bpf_raw_tp_link *link,             \
>                               REPEAT(x, SARG, __DL_COM, __SEQ_0_11))    \
>         {                                                               \
> -               u64 args[x];                                            \
> +               u64 args[x + 1];                                        \
> +               args[0] =3D x;                                           =
 \
>                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);                  \
> -               __bpf_trace_run(link, args);                            \
> +               __bpf_trace_run(link, args + 1);                        \

This is neat, but what is this for?
The program that attaches to a particular raw_tp knows what it is
attaching to and how many arguments are there,
so bpf_get_func_arg_cnt() is a 5th wheel.

If the reason is "for completeness" then it's not a good reason
to penalize performance. Though it's just an extra 8 byte of stack
and a single store of a constant.

pw-bot: cr

