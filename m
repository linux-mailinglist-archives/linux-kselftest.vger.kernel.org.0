Return-Path: <linux-kselftest+bounces-32860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47097AB3C03
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C952F17ACCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59E23BCF7;
	Mon, 12 May 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVFOBtSg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2A1A3175;
	Mon, 12 May 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063535; cv=none; b=FuSNxqX7+h8JhGDe8Gn/xuZc2DUgdWa/YcpLDwkRNQEOX6ZJhyfG1RnLXBqXT25XQeEtnr5uuiURiUtwUbVfW3+iO1KyQvOEXdf6z751/ZgBkd0ZXlnhT6J1MMk52enM/arFLefzRja0FC39CmykbwZJ2jPGbpuKfWN2Uzkc2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063535; c=relaxed/simple;
	bh=Hh4ngcCl+mXW4sy2NnCK66teCUw5AGrM1ZiaNHkwmSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnDnZfuLZNseAkLDrr81CE7Q8I36jT28iVoLd7apzizhLSldpaAmbL/nP4ug5Y5BAw2hXpuZxjZ83wkt+ZVWOGxBtK9r6Mps7/XwU5eI91u6kK8l5UoHTOXWXtxYpeaziSTgQYYN+SQcQqQLM2ZLARGecFboyWTct+4H8ujj09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVFOBtSg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a1b8e8b2b2so2330060f8f.2;
        Mon, 12 May 2025 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747063531; x=1747668331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsdd5z/QhZSAGjC5UyNunZpPklp7yFFA2Z524Ki7S3w=;
        b=nVFOBtSglehBDOPrQcR8xFHmy3bnjbHpk39NtxK+ZE1DK9FlfruZO/cHWVPCPIQ+Q9
         30NGfNlRPpTkRqNyxgDyqwIrP56e4cx7uagiJSPrcHhO9lq5pGuOX5u1mdU6qQgr0Qmi
         kXEcbvnhIacLgzmEguNAqQyLsRy/VZdG5vH1mKiKUWMcXlK/b7dD2M+Ii5chCvbLqKzZ
         wTAAKdnXfVP5JmqMFq/PHSSXabkLWpTV9tPuzINmVSGCUAoQL8mwFlG+9cc1/S6k/o0z
         Nz15u+l3HPlag1D0thPGIM5UR0/qJN5VniZWs8yNtxZnfbTo45nX+w4OoQaiV6qq6OOR
         Gx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747063531; x=1747668331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsdd5z/QhZSAGjC5UyNunZpPklp7yFFA2Z524Ki7S3w=;
        b=YNZSR19mw47UIJiGwgsW1Dw5ld1djpczb/LV45itaQYAcKWAmc7jRxmLPeo/9d0dxf
         q2JJ6tByhiJ7lmvApA2SpmC5NJ3es5ae2quyW+0C8tLJCmJbpsmaGAP92CKkVLvxNdBS
         YZBNb6cijZVa/CpDhH9oPUxvL2JcvKI0HzZrFhZwJgE/Y1JmcfQ88CsGZffgO/QoMwjp
         t0mAjHuVbO2HgfqAr2c3+yudoCPBHaNy+iEXO8PdvFtSK+AjtgKjHxxZZobHBvrfYf5v
         8H3/daEeYaS1bi+GQGW982J8wui5KKx4BiMnrDGUER8BSlxkq55jQlMOowjV9JWceRQv
         X6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUiiEYG+N5fD2IPNTpW/c74z1PUuzWwCdAAZSGyhm2CfvRcqggZsjX2IEqZzYtLnY0p10E=@vger.kernel.org, AJvYcCV59BCxEy+5nECVQIooZLc3cwYymowbrfZ173EAzJkNCP47mDJPV+5OFo6UM0jiBe2ppxtYvVeQWTNnKbHf@vger.kernel.org, AJvYcCVVTh+dNCCzRqy6SUUqHUA3rSMpeI1i9994g4w9SqIL0tZr2IWoxXZTsejg6cz7kpjolUNAoBDQYer2RheIc9lD+u+D@vger.kernel.org, AJvYcCViSh5k63uhnYijmZaBKkyacpPICKNkG1/jVPBfjaUB5auIc/A0fK5XzJBw4WbIk4d5kvsIOYL7@vger.kernel.org, AJvYcCXUM57T+3gqxhXj036TKaIJQhMkqIb9wW0e8CMkgl0nVMws+V1EGJXND+w8Psv40BU9BXfWt1AB7qUBqH+bbx8q@vger.kernel.org
X-Gm-Message-State: AOJu0YyFocCRLYkGEh2TMyIyUYTdYOyPHDC3J9L2kKPFTdw0f3JBsM0g
	qQITLKBNG1hLtfSFGLbg6IzqN1ICKyCMTMDPl3ZWVRoOIxE+17rinN/kwQDPBlTcUwmT2+YxYk7
	qpMPbkh8QOz6vlrJkSENRT/JFLp8=
X-Gm-Gg: ASbGncv2Ky2bvwzfoRY8Ef2Htizg82h3c0BOZ45Dvdn5eusB3OGsLs4TaEE+BLVqiPV
	F0nz8jpl6nJ5dJJc17UwBKnuxbZ2LL1a8eQdHTG0H/eFumbgRM0b0I2M6gGU84TPrVV0F5q/4Tc
	EscKYrRzWBniHMfJZNhZHu9AodPuOTU2d7jknm3kyuOnE0pjdc
X-Google-Smtp-Source: AGHT+IGS6Bf/2Gq+4cKVxaawephomVRRwhQZYiDwIPFiKuQgYha5yCXHc4GqLBH1nTQlx0+5brtoLUPxKHGAhV4J7hY=
X-Received: by 2002:a05:6000:1786:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-3a1f64449e7mr10719651f8f.28.1747063531010; Mon, 12 May 2025
 08:25:31 -0700 (PDT)
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
 <f1f23c1a-f4a8-4807-8028-87e247775ec8@linux.dev> <CAEf4BzZcuCrK4UVv2qpp7LAL=uXg+YqFopNW3EzCCpUBNPq-ag@mail.gmail.com>
 <16eafae1-5014-42a9-b6c4-8be40b26cf31@linux.dev>
In-Reply-To: <16eafae1-5014-42a9-b6c4-8be40b26cf31@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 May 2025 08:25:20 -0700
X-Gm-Features: AX0GCFujhJAQAXI_VeGEfyPL_k_CBqBecCxY4XwfRdZ7WCnc6bsfzc9e3jj798Y
Message-ID: <CAADnVQJNekoXnai0VGOVj8Q3e5RPtTXhNRjdfxF_PxjoQLDYRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kafai Wan <mannkafai@gmail.com>, 
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

On Mon, May 12, 2025 at 4:12=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/5/7 05:01, Andrii Nakryiko wrote:
> > On Fri, May 2, 2025 at 7:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >>
> >>
> >> On 2025/5/1 00:53, Alexei Starovoitov wrote:
> >>> On Wed, Apr 30, 2025 at 8:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2025/4/30 20:43, Kafai Wan wrote:
> >>>>> On Wed, Apr 30, 2025 at 10:46=E2=80=AFAM Alexei Starovoitov
> >>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>>
> >>>>>> On Sat, Apr 26, 2025 at 9:00=E2=80=AFAM KaFai Wan <mannkafai@gmail=
.com> wrote:
> >>>>>>>
> >>>>
> >>
> >> [...]
> >>
> >>>>
> >>>>
> >>>> bpf_get_func_arg() will be very helpful for bpfsnoop[1] when tracing=
 tp_btf.
> >>>>
> >>>> In bpfsnoop, it can generate a small snippet of bpf instructions to =
use
> >>>> bpf_get_func_arg() for retrieving and filtering arguments. For examp=
le,
> >>>> with the netif_receive_skb tracepoint, bpfsnoop can use
> >>>> bpf_get_func_arg() to filter the skb argument using pcap-filter(7)[2=
] or
> >>>> a custom attribute-based filter. This will allow bpfsnoop to trace
> >>>> multiple tracepoints using a single bpf program code.
> >>>
> >>> I doubt you thought it through end to end.
> >>> When tracepoint prog attaches we have this check:
> >>>         /*
> >>>          * check that program doesn't access arguments beyond what's
> >>>          * available in this tracepoint
> >>>          */
> >>>         if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
> >>>                 return -EINVAL;
> >>>
> >>> So you cannot have a single bpf prog attached to many tracepoints
> >>> to read many arguments as-is.
> >>> You can hack around that limit with probe_read,
> >>> but the values won't be trusted and you won't be able to pass
> >>> such untrusted pointers into skb and other helpers/kfuncs.
> >>
> >> I understand that a single bpf program cannot be attached to multiple
> >> tracepoints using tp_btf. However, the same bpf code can be reused to
> >> create multiple bpf programs, each attached to a different tracepoint.
> >>
> >> For example:
> >>
> >> SEC("fentry")
> >> int BPF_PROG(fentry_fn)
> >> {
> >>         /* ... */
> >>         return BPF_OK;
> >> }
> >>
> >> The above fentry code can be compiled into multiple bpf programs to
> >> trace different kernel functions. Each program can then use the
> >> bpf_get_func_arg() helper to access the arguments of the traced functi=
on.
> >>
> >> With this patch, tp_btf will gain similar flexibility. For example:
> >>
> >> SEC("tp_btf")
> >> int BPF_PROG(tp_btf_fn)
> >> {
> >>         /* ... */
> >>         return BPF_OK;
> >> }
> >>
> >> Here, bpf_get_func_arg() can be used to access tracepoint arguments.
> >>
> >> Currently, due to the lack of bpf_get_func_arg() support in tp_btf,
> >> bpfsnoop[1] uses bpf_probe_read_kernel() to read tracepoint arguments.
> >> This is also used when filtering specific argument attributes.
> >>
> >> For instance, to filter the skb argument of the netif_receive_skb
> >> tracepoint by 'skb->dev->ifindex =3D=3D 2', the translated bpf instruc=
tions
> >> with bpf_probe_read_kernel() would look like this:
> >>
> >> bool filter_arg(__u64 * args):
> >> ; filter_arg(__u64 *args)
> >>  209: (79) r1 =3D *(u64 *)(r1 +0) /* all tracepoint's argument has bee=
n
> >> read into args using bpf_probe_read_kernel() */
> >>  210: (bf) r3 =3D r1
> >>  211: (07) r3 +=3D 16
> >>  212: (b7) r2 =3D 8
> >>  213: (bf) r1 =3D r10
> >>  214: (07) r1 +=3D -8
> >>  215: (85) call bpf_probe_read_kernel#-125280
> >>  216: (79) r3 =3D *(u64 *)(r10 -8)
> >>  217: (15) if r3 =3D=3D 0x0 goto pc+10
> >>  218: (07) r3 +=3D 224
> >>  219: (b7) r2 =3D 8
> >>  220: (bf) r1 =3D r10
> >>  221: (07) r1 +=3D -8
> >>  222: (85) call bpf_probe_read_kernel#-125280
> >>  223: (79) r3 =3D *(u64 *)(r10 -8)
> >>  224: (67) r3 <<=3D 32
> >>  225: (77) r3 >>=3D 32
> >>  226: (b7) r0 =3D 1
> >>  227: (15) if r3 =3D=3D 0x2 goto pc+1
> >>  228: (af) r0 ^=3D r0
> >>  229: (95) exit
> >>
> >> If bpf_get_func_arg() is supported in tp_btf, the bpf program will
> >> instead look like:
> >>
> >> static __noinline bool
> >> filter_skb(void *ctx)
> >> {
> >>     struct sk_buff *skb;
> >>
> >>     (void) bpf_get_func_arg(ctx, 0, (__u64 *) &skb);
> >>     return skb->dev->ifindex =3D=3D 2;
> >> }
> >>
> >> This will simplify the generated code and eliminate the need for
> >> bpf_probe_read_kernel() calls. However, in my tests (on kernel
> >> 6.8.0-35-generic, Ubuntu 24.04 LTS), the pointer returned by
> >> bpf_get_func_arg() is marked as a scalar rather than a trusted pointer=
:
> >>
> >>         0: R1=3Dctx() R10=3Dfp0
> >>         ; if (!filter_skb(ctx))
> >>         0: (85) call pc+3
> >>         caller:
> >>          R10=3Dfp0
> >>         callee:
> >>          frame1: R1=3Dctx() R10=3Dfp0
> >>         4: frame1: R1=3Dctx() R10=3Dfp0
> >>         ; filter_skb(void *ctx)
> >>         4: (bf) r3 =3D r10                      ; frame1: R3_w=3Dfp0 R=
10=3Dfp0
> >>         ;
> >>         5: (07) r3 +=3D -8                      ; frame1: R3_w=3Dfp-8
> >>         ; (void) bpf_get_func_arg(ctx, 0, (__u64 *) &skb);
> >>         6: (b7) r2 =3D 0                        ; frame1: R2_w=3D0
> >>         7: (85) call bpf_get_func_arg#183     ; frame1: R0_w=3Dscalar(=
)
> >>         ; return skb->dev->ifindex =3D=3D 2;
> >>         8: (79) r1 =3D *(u64 *)(r10 -8)         ; frame1: R1_w=3Dscala=
r() R10=3Dfp0
> >> fp-8=3Dmmmmmmmm
> >>         ; return skb->dev->ifindex =3D=3D 2;
> >>         9: (79) r1 =3D *(u64 *)(r1 +16)
> >>         R1 invalid mem access 'scalar'
> >>         processed 7 insns (limit 1000000) max_states_per_insn 0 total_=
states 0
> >> peak_states 0 mark_read 0
> >>
> >> If the returned skb is a trusted pointer, the verifier will accept
> >> something like:
> >>
> >> static __noinline bool
> >> filter_skb(struct sk_buff *skb)
> >> {
> >>     return skb->dev->ifindex =3D=3D 2;
> >> }
> >>
> >> Which will compile into much simpler and more efficient instructions:
> >>
> >> bool filter_skb(struct sk_buff * skb):
> >> ; return skb->dev->ifindex =3D=3D 2;
> >>   92: (79) r1 =3D *(u64 *)(r1 +16)
> >> ; return skb->dev->ifindex =3D=3D 2;
> >>   93: (61) r1 =3D *(u32 *)(r1 +224)
> >>   94: (b7) r0 =3D 1
> >> ; return skb->dev->ifindex =3D=3D 2;
> >>   95: (15) if r1 =3D=3D 0x2 goto pc+1
> >>   96: (b7) r0 =3D 0
> >> ; return skb->dev->ifindex =3D=3D 2;
> >>   97: (95) exit
> >>
> >> In conclusion:
> >>
> >> 1. It will be better if the pointer returned by bpf_get_func_arg() is
> >> trusted, only when the argument index is a known constant.
> >
> > bpf_get_func_arg() was never meant to return trusted arguments, so
> > this, IMO, is pushing it too far.
> >
> >> 2. Adding bpf_get_func_arg() support to tp_btf will significantly
> >> simplify and improve tools like bpfsnoop.
> >
> > "Significantly simplify and improve" is a bit of an exaggeration,
> > given BPF cookies can be used for getting number of arguments of
> > tp_btf, as for the getting rid of bpf_probe_read_kernel(), tbh, more
> > generally useful addition would be an untyped counterpart to
> > bpf_core_cast(), which wouldn't need BTF type information, but will
> > treat all accessed memory as raw bytes (but will still install
> > exception handler just like with bpf_core_cast()).
> >
>
> Cool! The bpf_rdonly_cast() kfunc used by the bpf_core_cast() macro
> works well in bpfsnoop.
>
> The expression 'skb->dev->ifindex =3D=3D 2' is translated into:
>
> bool filter_arg(__u64 * args):
> ; filter_arg(__u64 *args)
>  209: (bf) r9 =3D r1
>  210: (79) r8 =3D *(u64 *)(r9 +0)
>  211: (bf) r1 =3D r8
>  212: (b7) r2 =3D 6973
>  213: (bf) r0 =3D r1
>  214: (79) r1 =3D *(u64 *)(r0 +16)
>  215: (15) if r1 =3D=3D 0x0 goto pc+12
>  216: (07) r1 +=3D 224
>  217: (bf) r3 =3D r1
>  218: (b7) r2 =3D 8
>  219: (bf) r1 =3D r10
>  220: (07) r1 +=3D -8
>  221: (85) call bpf_probe_read_kernel#-125280
>  222: (79) r8 =3D *(u64 *)(r10 -8)
>  223: (67) r8 <<=3D 32
>  224: (77) r8 >>=3D 32
>  225: (55) if r8 !=3D 0x2 goto pc+2
>  226: (b7) r8 =3D 1
>  227: (05) goto pc+1
>  228: (af) r8 ^=3D r8
>  229: (bf) r0 =3D r8
>  230: (95) exit
>
> However, since bpf_rdonly_cast() is a kfunc, it causes registers r1=E2=80=
=93r5
> to be considered volatile.

It is not.
See:
BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL)
and relevant commits.

