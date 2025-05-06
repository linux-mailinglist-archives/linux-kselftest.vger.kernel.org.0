Return-Path: <linux-kselftest+bounces-32532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F69AACF23
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 23:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13A417456B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407D19AA63;
	Tue,  6 May 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQvNfVwE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3F4B1E69;
	Tue,  6 May 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565282; cv=none; b=Hr7JnLs1RWKLR9voj09z3/EhbN06/WYvU7bs6D/7x+u0MDy+xQn89IQcrwQxVUOxtAPNXH1+AjMEbF/qnTnN2WgteLGpJJo+HutWA6oMkh2DmcbtwhrY3fm8HIWdt2GBUXHkQp13E9VwqRqEosiuzmITXJbLWIVJ5NhM1l7KcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565282; c=relaxed/simple;
	bh=IZ8gS0GxIwUMAAKTiujecI6rI4dddYCLKZaC9yCele0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKr4EcTzf7kBEpmI+pmuog1tvV2kgSd6Dh8ZW5RtKyHOtGn1XkBEp2CLK63Qpi5JeWER11c2Pw/lsHQx80fmXgoQffG0xb+hRm/66DlLOpfmvY9Twk/DxU0GWjqdfEHfgRBHoy1E+41Oj//TV3ZyZvH2cIdETV+IThpjR4YOUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQvNfVwE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3081f72c271so6139757a91.0;
        Tue, 06 May 2025 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746565279; x=1747170079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGpCXrvVakHiYqEKJnZ4rQZ11p4odiFi497LdndPBz0=;
        b=nQvNfVwE0guKsL3HPBehovUfP6HjV+LcnHi8KFJ3komjp0cFXufR09VMQod3D3Stpl
         lK1U/H7Kn3Zb6KJgJOlBZtjtn19zY7Bs6Yrw82RykzjhgTHMshIta7o2jh1RKrnJGJTl
         wMYqZravkbyLdvzbIkcfE0vxbtfcyQrgUownN93g3utG4Lh1XQWpA9NcRVjxQ+Bs2hIa
         +xGbfytkb/ZzeBJ94FX4DhWJxPZLydtPFgpXUMNiepTI0YAfzGHnxrafwq6horW1nWMP
         PzFm5umjsh20flXPxX/ygxn6RTNMgWa0a5H7K9q5ZhuflCDolnY8aNfGgEvOIfdyGQKh
         JjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565279; x=1747170079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGpCXrvVakHiYqEKJnZ4rQZ11p4odiFi497LdndPBz0=;
        b=nVfKGU/CKN2iT/f0BgvCLnAjuMOu5XdfUGn/WoL9ZHku+apLBafj9/DRghB6zDPk3T
         xeEG3kAwndS0puNtnNCQiebmmB+WCjvyEVD079DyKjGYdEBDquUNUzxbHAwgQlsriuYP
         PasBE7DxDI2R1FHZ/hYXNbNQJJGxysrQy326kcjvBgXIMEAUSr4HXSglfqQQ15gzfEe2
         fntWBuOEZcn/fbmjA+fDXCt2VAjcjOUEnfNVYEUfxzTNK5RKrZoIEo6JVCDRIwm1J+HC
         11oHpYTXZD8ago5XQoLsSHmJwz1fsUqlEceNl8jHzlT94fjJb9Z9ho4BIrHFIF495o6o
         utMw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6Un7yYXsVNeFzlULlNJNwt7YzRwaIT8RNtKXzrhmwaMi2zE46ns5/+oW+1OZ4+tXSABRHpOdD4xs3VOwiK4/qiBc@vger.kernel.org, AJvYcCUdiie15BAfUGXSgBwmtqMwwmE/57FuCKxMLECQ7kkV9iEKRFpARFS+p9K/ldjITTU+uNxS1RLNpz1MI5AR@vger.kernel.org, AJvYcCVRmPZ4tDtEKZhw53ma8Ru6TYCoFqv1dNZu7E9FoiMWtYXWQf31RVT4ju6JrwCpEOPNQsLITN7fLD72QisNvTWB@vger.kernel.org, AJvYcCXRkwAE8MJCTZLoSnpXRgAfqiybaekTBYKIU2lOPKpADn/ed7o41r9GRvPs38oAocsiG+5YfWkV@vger.kernel.org, AJvYcCXX0rypdUHYnZTT7Tb2tlFpja98+qica4/f+ABV/7s+2kiUr42Q6ZzTdig5D77ChN/7Bz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwCbgeyr58bSEe3n1KkKfJUes4XnQbS7DJPHvHhh97un9qs+t
	XGCPCkyapgpfDWr1xybZ9Mr4dL/Pndt36tqp8f8z9rlb3vzLGpuWD8O26MtvpOqr+mZCApQ1gPe
	ptrTRfROjrwOC5oBhbo35Zj3NyD5OvXwF
X-Gm-Gg: ASbGncvpHKbFDWPFNzfIL3P5uxRO+E42BfMOBnw7SibXR72Bg/ixXN2T9w7kXwAAYpV
	GL80ehnXU6pz2UzPt+ZbBl0wtmFzBeNQpsvoMqot7aq4Zd/UIpetmWJzDYFWEjjdagWCu9sljkL
	KJweWYYQoU0F0DoOwOBiZdhfkSRtvRLHvnNuYhbGfL9ER5a2J9
X-Google-Smtp-Source: AGHT+IFMcyh4aXFPcfQujordcZVIHNjq/wxigDu2SLJkT2sBX0naL1Q0JPVAhGhhuKjF3m/Sxj0NE1i3H1F25gqXN1Y=
X-Received: by 2002:a17:90b:2d06:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-30aac19b522mr1382746a91.8.1746565279421; Tue, 06 May 2025
 14:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426160027.177173-1-mannkafai@gmail.com> <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
 <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
 <f951b81f-1b46-4219-82fd-0839e27ab3f3@linux.dev> <CAADnVQ+FANha0fO_BF+iHJ4iZSCPtDfoUkzR8mMFwOakw8+eCg@mail.gmail.com>
 <f1f23c1a-f4a8-4807-8028-87e247775ec8@linux.dev>
In-Reply-To: <f1f23c1a-f4a8-4807-8028-87e247775ec8@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 14:01:07 -0700
X-Gm-Features: ATxdqUF8ebtWDuYIV69M8X_0fqB0M8DpSL5JRmslRryRsSdSpdPkgSOf-2FIwi8
Message-ID: <CAEf4BzZcuCrK4UVv2qpp7LAL=uXg+YqFopNW3EzCCpUBNPq-ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kafai Wan <mannkafai@gmail.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
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
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 7:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 2025/5/1 00:53, Alexei Starovoitov wrote:
> > On Wed, Apr 30, 2025 at 8:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >>
> >> On 2025/4/30 20:43, Kafai Wan wrote:
> >>> On Wed, Apr 30, 2025 at 10:46=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Sat, Apr 26, 2025 at 9:00=E2=80=AFAM KaFai Wan <mannkafai@gmail.c=
om> wrote:
> >>>>>
> >>
>
> [...]
>
> >>
> >>
> >> bpf_get_func_arg() will be very helpful for bpfsnoop[1] when tracing t=
p_btf.
> >>
> >> In bpfsnoop, it can generate a small snippet of bpf instructions to us=
e
> >> bpf_get_func_arg() for retrieving and filtering arguments. For example=
,
> >> with the netif_receive_skb tracepoint, bpfsnoop can use
> >> bpf_get_func_arg() to filter the skb argument using pcap-filter(7)[2] =
or
> >> a custom attribute-based filter. This will allow bpfsnoop to trace
> >> multiple tracepoints using a single bpf program code.
> >
> > I doubt you thought it through end to end.
> > When tracepoint prog attaches we have this check:
> >         /*
> >          * check that program doesn't access arguments beyond what's
> >          * available in this tracepoint
> >          */
> >         if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
> >                 return -EINVAL;
> >
> > So you cannot have a single bpf prog attached to many tracepoints
> > to read many arguments as-is.
> > You can hack around that limit with probe_read,
> > but the values won't be trusted and you won't be able to pass
> > such untrusted pointers into skb and other helpers/kfuncs.
>
> I understand that a single bpf program cannot be attached to multiple
> tracepoints using tp_btf. However, the same bpf code can be reused to
> create multiple bpf programs, each attached to a different tracepoint.
>
> For example:
>
> SEC("fentry")
> int BPF_PROG(fentry_fn)
> {
>         /* ... */
>         return BPF_OK;
> }
>
> The above fentry code can be compiled into multiple bpf programs to
> trace different kernel functions. Each program can then use the
> bpf_get_func_arg() helper to access the arguments of the traced function.
>
> With this patch, tp_btf will gain similar flexibility. For example:
>
> SEC("tp_btf")
> int BPF_PROG(tp_btf_fn)
> {
>         /* ... */
>         return BPF_OK;
> }
>
> Here, bpf_get_func_arg() can be used to access tracepoint arguments.
>
> Currently, due to the lack of bpf_get_func_arg() support in tp_btf,
> bpfsnoop[1] uses bpf_probe_read_kernel() to read tracepoint arguments.
> This is also used when filtering specific argument attributes.
>
> For instance, to filter the skb argument of the netif_receive_skb
> tracepoint by 'skb->dev->ifindex =3D=3D 2', the translated bpf instructio=
ns
> with bpf_probe_read_kernel() would look like this:
>
> bool filter_arg(__u64 * args):
> ; filter_arg(__u64 *args)
>  209: (79) r1 =3D *(u64 *)(r1 +0) /* all tracepoint's argument has been
> read into args using bpf_probe_read_kernel() */
>  210: (bf) r3 =3D r1
>  211: (07) r3 +=3D 16
>  212: (b7) r2 =3D 8
>  213: (bf) r1 =3D r10
>  214: (07) r1 +=3D -8
>  215: (85) call bpf_probe_read_kernel#-125280
>  216: (79) r3 =3D *(u64 *)(r10 -8)
>  217: (15) if r3 =3D=3D 0x0 goto pc+10
>  218: (07) r3 +=3D 224
>  219: (b7) r2 =3D 8
>  220: (bf) r1 =3D r10
>  221: (07) r1 +=3D -8
>  222: (85) call bpf_probe_read_kernel#-125280
>  223: (79) r3 =3D *(u64 *)(r10 -8)
>  224: (67) r3 <<=3D 32
>  225: (77) r3 >>=3D 32
>  226: (b7) r0 =3D 1
>  227: (15) if r3 =3D=3D 0x2 goto pc+1
>  228: (af) r0 ^=3D r0
>  229: (95) exit
>
> If bpf_get_func_arg() is supported in tp_btf, the bpf program will
> instead look like:
>
> static __noinline bool
> filter_skb(void *ctx)
> {
>     struct sk_buff *skb;
>
>     (void) bpf_get_func_arg(ctx, 0, (__u64 *) &skb);
>     return skb->dev->ifindex =3D=3D 2;
> }
>
> This will simplify the generated code and eliminate the need for
> bpf_probe_read_kernel() calls. However, in my tests (on kernel
> 6.8.0-35-generic, Ubuntu 24.04 LTS), the pointer returned by
> bpf_get_func_arg() is marked as a scalar rather than a trusted pointer:
>
>         0: R1=3Dctx() R10=3Dfp0
>         ; if (!filter_skb(ctx))
>         0: (85) call pc+3
>         caller:
>          R10=3Dfp0
>         callee:
>          frame1: R1=3Dctx() R10=3Dfp0
>         4: frame1: R1=3Dctx() R10=3Dfp0
>         ; filter_skb(void *ctx)
>         4: (bf) r3 =3D r10                      ; frame1: R3_w=3Dfp0 R10=
=3Dfp0
>         ;
>         5: (07) r3 +=3D -8                      ; frame1: R3_w=3Dfp-8
>         ; (void) bpf_get_func_arg(ctx, 0, (__u64 *) &skb);
>         6: (b7) r2 =3D 0                        ; frame1: R2_w=3D0
>         7: (85) call bpf_get_func_arg#183     ; frame1: R0_w=3Dscalar()
>         ; return skb->dev->ifindex =3D=3D 2;
>         8: (79) r1 =3D *(u64 *)(r10 -8)         ; frame1: R1_w=3Dscalar()=
 R10=3Dfp0
> fp-8=3Dmmmmmmmm
>         ; return skb->dev->ifindex =3D=3D 2;
>         9: (79) r1 =3D *(u64 *)(r1 +16)
>         R1 invalid mem access 'scalar'
>         processed 7 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0
> peak_states 0 mark_read 0
>
> If the returned skb is a trusted pointer, the verifier will accept
> something like:
>
> static __noinline bool
> filter_skb(struct sk_buff *skb)
> {
>     return skb->dev->ifindex =3D=3D 2;
> }
>
> Which will compile into much simpler and more efficient instructions:
>
> bool filter_skb(struct sk_buff * skb):
> ; return skb->dev->ifindex =3D=3D 2;
>   92: (79) r1 =3D *(u64 *)(r1 +16)
> ; return skb->dev->ifindex =3D=3D 2;
>   93: (61) r1 =3D *(u32 *)(r1 +224)
>   94: (b7) r0 =3D 1
> ; return skb->dev->ifindex =3D=3D 2;
>   95: (15) if r1 =3D=3D 0x2 goto pc+1
>   96: (b7) r0 =3D 0
> ; return skb->dev->ifindex =3D=3D 2;
>   97: (95) exit
>
> In conclusion:
>
> 1. It will be better if the pointer returned by bpf_get_func_arg() is
> trusted, only when the argument index is a known constant.

bpf_get_func_arg() was never meant to return trusted arguments, so
this, IMO, is pushing it too far.

> 2. Adding bpf_get_func_arg() support to tp_btf will significantly
> simplify and improve tools like bpfsnoop.

"Significantly simplify and improve" is a bit of an exaggeration,
given BPF cookies can be used for getting number of arguments of
tp_btf, as for the getting rid of bpf_probe_read_kernel(), tbh, more
generally useful addition would be an untyped counterpart to
bpf_core_cast(), which wouldn't need BTF type information, but will
treat all accessed memory as raw bytes (but will still install
exception handler just like with bpf_core_cast()).

>
> [1] https://github.com/bpfsnoop/bpfsnoop
>
> Thanks,
> Leon
>
>

