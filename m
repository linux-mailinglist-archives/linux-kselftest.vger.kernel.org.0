Return-Path: <linux-kselftest+bounces-6247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77F878D10
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108F71C2113C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773C7883C;
	Tue, 12 Mar 2024 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YeLgFJ0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C91FA2
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211346; cv=none; b=OP+GsWmfWvczHyUyLDOp7Ug4Lb5CaDp53Ko30EQjWJ/v+y6B9yt2tsB9ieni1i76VwbB/Of/vqG/jXn4Zc1GmZBnhz2Rgr5Qbv41UfKlQihdA0VhqsCPH6dfw9ks2WsHpCQUV8kHfpGfZfdfdqyTXm5Gf+CbjnQeR/gjIi8pI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211346; c=relaxed/simple;
	bh=A1etVzSHW+e/mqqVDMMdwEbh1AH+28mTZN4/5W0ATXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6qZ4eN8KtcIf8gG5nAIy7LEps/EAJGEimIoQnp/jnDUNbeYREwaUfKHhkyaVUz0W/AuIYi9IXH+10jB3y/KfRzZGvTbwVwstWw6XHqPGTegMW5ZiYe+DEj9QNv+CjLaVLIwNtwdiZ4k7vdVe/hctQEjlfUP/pulXIkEzqJEB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YeLgFJ0Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e64997a934so3951941b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 19:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710211343; x=1710816143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OINlgsu2YF3PvJN8OnOTR/8+uoasAh0pp34EJQtDWyM=;
        b=YeLgFJ0QiDEotFeBmWDSLzNDjy/T7F3k8Yg0kw0dyHRBU8wmRjcp7ehr3+JQocZyKf
         w9bf0zJwkCCVMePgScz1MRMFPbNXPJyUk0E+UVS6wTFOfIHn1ITpjm7vgN0NTkZdRpJU
         tQYWn0OwnYxAuUW8p9EFRk2piZ1j4QvE3mcCGPq6JDz/5xkyA2bGndtoji0YFM9TXOyT
         /vRuD1Da270foUMUzszyvPbKMr+hYL0menX3tSFZl9iKITpFjakTOV8NJLW4oAKYBtxf
         iUSqrRQ62rcsPx4J9nvEsyyjLA/qhV9yTOlKcByIVEP2jvl1wLMx8ryInai4H6PX73Zg
         FTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710211343; x=1710816143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OINlgsu2YF3PvJN8OnOTR/8+uoasAh0pp34EJQtDWyM=;
        b=mkPAlLT3phyaasqGWlhE1AQAGr6QWxCXTWdvwZdbyNGWQgUMFrddCzHQofv+c6/j1Q
         ynRvPG+NVLo4y42kd+5igKkqmsLlRw0YgZXRpcVyaOby0y6mjCVGPP1mfAoDIpOLZ3mx
         1TawvNqsnugGG+t4196ezE9OoZk72TcUc4Wj3jwf3K4qF8znphWh5Vw/qE/vGVcUL2S2
         VvDZWUNxBcJlCsC2f3EOhz98awjmg2LDQApuuBVT/vQalKwfpLwYWG4dW5MEk7rXG5X0
         uuF+9v4P3jsS9Y0N7kwzeuMw/N+Z+bfJBZQAubDbYxPysCBV23ye82ssI/i9IrefPwjW
         VEpg==
X-Forwarded-Encrypted: i=1; AJvYcCU1JpfUSBO+ITRZ/dVDEup0ll9IIdV3szCvp15d0QSOSFukurarQJmS8ErAzrGVJlVg1ISW4QjhHeYG4x9bfAUy6UaPbY7albnkgExr7QHi
X-Gm-Message-State: AOJu0YyErNx36pY5gbxJTXqeiAkwNdaH55ryMebj1zF143oKYWfKy++U
	5P2t0An+AP56eaUMVIiAHeGHPAzezO8jZeC+g8AIntDlGyTlZVin2WtXUGQ6zImswamzi1sWb9Q
	UR5Tt/TUKrgP2CtMVrFHTD4PU121tCrIYx0xqeQ==
X-Google-Smtp-Source: AGHT+IE6GiGxyRIp3/3XVD9fFBz8UVdgjg1PGxNjY7GVvBs/so+9qa/wgGoxFVME4bk660EppcQoDtMhnKII7BlTwZk=
X-Received: by 2002:a05:6a21:32a2:b0:1a1:2b49:9f04 with SMTP id
 yt34-20020a056a2132a200b001a12b499f04mr2426596pzb.46.1710211343317; Mon, 11
 Mar 2024 19:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com> <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
In-Reply-To: <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:42:12 +0800
Message-ID: <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 7:01=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 9:46=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
> > > <dongmenglong.8@bytedance.com> wrote:
> > > >
> > > > In this commit, we add the 'accessed_args' field to struct bpf_prog=
_aux,
> > > > which is used to record the accessed index of the function args in
> > > > btf_ctx_access().
> > > >
> > > > Meanwhile, we add the function btf_check_func_part_match() to compa=
re the
> > > > accessed function args of two function prototype. This function wil=
l be
> > > > used in the following commit.
> > > >
> > > > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > > > ---
> > > >  include/linux/bpf.h |   4 ++
> > > >  kernel/bpf/btf.c    | 108 ++++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  2 files changed, 110 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 95e07673cdc1..0f677fdcfcc7 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1461,6 +1461,7 @@ struct bpf_prog_aux {
> > > >         const struct btf_type *attach_func_proto;
> > > >         /* function name for valid attach_btf_id */
> > > >         const char *attach_func_name;
> > > > +       u64 accessed_args;
> > > >         struct bpf_prog **func;
> > > >         void *jit_data; /* JIT specific data. arch dependent */
> > > >         struct bpf_jit_poke_descriptor *poke_tab;
> > > > @@ -2565,6 +2566,9 @@ struct bpf_reg_state;
> > > >  int btf_prepare_func_args(struct bpf_verifier_env *env, int subpro=
g);
> > > >  int btf_check_type_match(struct bpf_verifier_log *log, const struc=
t bpf_prog *prog,
> > > >                          struct btf *btf, const struct btf_type *t)=
;
> > > > +int btf_check_func_part_match(struct btf *btf1, const struct btf_t=
ype *t1,
> > > > +                             struct btf *btf2, const struct btf_ty=
pe *t2,
> > > > +                             u64 func_args);
> > > >  const char *btf_find_decl_tag_value(const struct btf *btf, const s=
truct btf_type *pt,
> > > >                                     int comp_idx, const char *tag_k=
ey);
> > > >  int btf_find_next_decl_tag(const struct btf *btf, const struct btf=
_type *pt,
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 170d017e8e4a..c2a0299d4358 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6125,19 +6125,24 @@ static bool is_int_ptr(struct btf *btf, con=
st struct btf_type *t)
> > > >  }
> > > >
> > > >  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type =
*func_proto,
> > > > -                          int off)
> > > > +                          int off, int *aligned_idx)
> > > >  {
> > > >         const struct btf_param *args;
> > > >         const struct btf_type *t;
> > > >         u32 offset =3D 0, nr_args;
> > > >         int i;
> > > >
> > > > +       if (aligned_idx)
> > > > +               *aligned_idx =3D -ENOENT;
> > > > +
> > > >         if (!func_proto)
> > > >                 return off / 8;
> > > >
> > > >         nr_args =3D btf_type_vlen(func_proto);
> > > >         args =3D (const struct btf_param *)(func_proto + 1);
> > > >         for (i =3D 0; i < nr_args; i++) {
> > > > +               if (aligned_idx && offset =3D=3D off)
> > > > +                       *aligned_idx =3D i;
> > > >                 t =3D btf_type_skip_modifiers(btf, args[i].type, NU=
LL);
> > > >                 offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->siz=
e, 8);
> > > >                 if (off < offset)
> > > > @@ -6207,7 +6212,7 @@ bool btf_ctx_access(int off, int size, enum b=
pf_access_type type,
> > > >                         tname, off);
> > > >                 return false;
> > > >         }
> > > > -       arg =3D get_ctx_arg_idx(btf, t, off);
> > > > +       arg =3D get_ctx_arg_idx(btf, t, off, NULL);
> > > >         args =3D (const struct btf_param *)(t + 1);
> > > >         /* if (t =3D=3D NULL) Fall back to default BPF prog with
> > > >          * MAX_BPF_FUNC_REG_ARGS u64 arguments.
> > > > @@ -6217,6 +6222,9 @@ bool btf_ctx_access(int off, int size, enum b=
pf_access_type type,
> > > >                 /* skip first 'void *__data' argument in btf_trace_=
##name typedef */
> > > >                 args++;
> > > >                 nr_args--;
> > > > +               prog->aux->accessed_args |=3D (1 << (arg + 1));
> > > > +       } else {
> > > > +               prog->aux->accessed_args |=3D (1 << arg);
> > >
> > > What do you need this aligned_idx for ?
> > > I'd expect that above "accessed_args |=3D (1 << arg);" is enough.
> > >
> >
> > Which aligned_idx? No aligned_idx in the btf_ctx_access(), and
> > aligned_idx is only used in the btf_check_func_part_match().
> >
> > In the btf_check_func_part_match(), I need to compare the
> > t1->args[i] and t2->args[j], which have the same offset. And
> > the aligned_idx is to find the "j" according to the offset of
> > t1->args[i].
>
> And that's my question.
> Why you don't do the max of accessed_args across all attach
> points and do btf_check_func_type_match() to that argno
> instead of nargs1.
> This 'offset +=3D btf_type_is_ptr(t1) ? 8 : roundup...
> is odd.

Hi, I'm trying to make the bpf flexible enough. Let's take an example,
now we have the bpf program:

int test1_result =3D 0;
int BPF_PROG(test1, int a, long b, char c)
{
    test1_result =3D a + c;
    return 0;
}

In this program, only the 1st and 3rd arg is accessed. So all kernel
functions whose 1st arg is int and 3rd arg is char can be attached
by this bpf program, even if their 2nd arg is different.

And let's take another example for struct. This is our bpf program:

int test1_result =3D 0;
int BPF_PROG(test1, long a, long b, char c)
{
    test1_result =3D c;
    return 0;
}

Only the 3rd arg is accessed. And we have following kernel function:

int kernel_function1(long a, long b, char c)
{
xxx
}

struct test1 {
    long a;
    long b;
};
int kernel_function2(struct test1 a, char b)
{
xxx
}

The kernel_function1 and kernel_function2 should be compatible,
as the bpf program only accessed the ctx[2], whose offset is 16.
And the arg in kernel_function1() with offset 16 is "char c", the
arg in kernel_function2() with offset 16 is "char b", which is
compatible.

That's why we need to check the consistency of accessed args
by offset instead of function arg index.

I'm not sure if I express my idea clearly, is this what you are
asking?

Thanks!
Menglong Dong

