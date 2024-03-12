Return-Path: <linux-kselftest+bounces-6249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE6878D2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1A51C21955
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0F79CF;
	Tue, 12 Mar 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WfkGS4Xb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2238821
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211763; cv=none; b=PVjJPVGs44dhPGlFCBwX32JVD8nRdJIcVzxC7GommMnyVuReAco1z9uXcM15et3tentldaymgDy15+Q6ihHocJ2RFL6NxJxucn+KURgWFaVYaB1OaMJJNlrOsPB8GG7Q4W8LxbBVb7J/5xEYkcp1jL/wmqTP7y8m2U+mIvkORPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211763; c=relaxed/simple;
	bh=LG8tjvBnuxxg899SAnLnow23FrwucP99leAXJLBMDyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L14HfBnWKRZioStr+bKtGkKAC2sBLjD4oED1S8IF0PjYu3jh5Ov1HrOncJGM85d/x4IawYsrL0gsiNfwMlO00rv7eQfhXOQq/jcxP8cAxYSa9A7J2f8jOyktOQi4VXC26IxVX4F7E4vaLEcEWVSIcjVZpcQ6vsJNb0r94ONkUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WfkGS4Xb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29bb5bec0e4so2546314a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710211761; x=1710816561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp8FDAIHogCGtdOtPeOiQYNfgQ9IDPgMIvR+XSfvvHk=;
        b=WfkGS4XbLbTYwVv62QrPovHbbApLL4JUmXpJ5WtAN8jlZ2e8FnXxGgwOUWChToIaXF
         UTkx+bcDlDJ3zvesem2GDR1fhYpTNdBGRYj9WOriUb2b6kaxoFs+5gzBpoayhAxb/k8V
         2HIdfu88t+uPRer8yK8vOV1F0L5MT4BOx8P5fs3ZFRD5RaxiwHGmmIYnwfYymT4ObgHz
         Ka4IpN7Cdus8aQWbxWdB4rd2WfaAK8ZAtlDE1a0xPGJkU4jPulzyvaBi6TxawtDx5Bfv
         jA9dmIT37wn27bNd06h99C34fj/XvJmYxvT4C2Z9aiomAiV9nAdCuA5El4iCK8d+/YAB
         Xscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710211761; x=1710816561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp8FDAIHogCGtdOtPeOiQYNfgQ9IDPgMIvR+XSfvvHk=;
        b=HpcSjwn4SDCg24Lz+8fRJm6PAUFznnNXyGJIGWzKSqwrukv8Kb5O0OqhHCFf8LH8W/
         KTzml4pCj9rxsbQiHmeT82KMur1KL52FL9XJe/H3G17yFR33ywNE93yGCfk0qjaeK8lM
         jvCLo03qzuzwpFR6zhEAjRfTHDOjyOk37d9IO5XqD6jqgro1xmzoXYAd2P150AVo18Yb
         PICWHsX2ffYXFSpLa82NWhQ8/oqhYya3SXUV7wASDri68V4K4yj0Ht7umenNCIwgVUm9
         H+ZM0TA2tN2jqLLcXP+JyHUHljhYPMW3uTVyRuqFSchHULnhCPIeIDHUcoJfh7y4gVk0
         3vLw==
X-Forwarded-Encrypted: i=1; AJvYcCWR7qlkZFHFniefEYH7jp3u6zefYMT9v4uqMy4qrT9Hus4VGlG6NIrG1rC1L5fIe3oIc0qZLn/rjlJ0davwzT7jato+PvV17OQ5Mx+eIgyF
X-Gm-Message-State: AOJu0Yy41dX52MJgP8f8V9Y71xKyTC6hQ3Kvv8JgIYCgRfApmz+ZyYSn
	xWckLJitUPegW1g9cY0Tifudbx2rx4PeT44EyNst3oPxmjvh9Sy+Q1CsxVDxgWpD01is8mb26AP
	GY4rnTVi8QZqSTBBM4zJqPcckymPwOJaskzIvgQ==
X-Google-Smtp-Source: AGHT+IETNLgyzh6uZkS12wgDyCLo8umv6nNmoijBBhhnpR8bMML+3pXMk3jZN+hl1DDgFHg+n8EoqP5QSNQlrqeKH1w=
X-Received: by 2002:a17:90a:5d8c:b0:29a:2860:28b9 with SMTP id
 t12-20020a17090a5d8c00b0029a286028b9mr6080591pji.48.1710211761009; Mon, 11
 Mar 2024 19:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com> <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
In-Reply-To: <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:49:10 +0800
Message-ID: <CALz3k9jy43zLe6DFjjA8K4mMFPNOxkagOEs2o8RY468ZWwfVSw@mail.gmail.com>
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

On Tue, Mar 12, 2024 at 10:42=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongm=
englong.8@bytedance.com> wrote:
>
> On Tue, Mar 12, 2024 at 10:09=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2024 at 7:01=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <do=
ngmenglong.8@bytedance.com> wrote:
> > >
> > > On Tue, Mar 12, 2024 at 9:46=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
> > > > <dongmenglong.8@bytedance.com> wrote:
> > > > >
> > > > > In this commit, we add the 'accessed_args' field to struct bpf_pr=
og_aux,
> > > > > which is used to record the accessed index of the function args i=
n
> > > > > btf_ctx_access().
> > > > >
> > > > > Meanwhile, we add the function btf_check_func_part_match() to com=
pare the
> > > > > accessed function args of two function prototype. This function w=
ill be
> > > > > used in the following commit.
> > > > >
> > > > > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > > > > ---
> > > > >  include/linux/bpf.h |   4 ++
> > > > >  kernel/bpf/btf.c    | 108 ++++++++++++++++++++++++++++++++++++++=
+++++-
> > > > >  2 files changed, 110 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 95e07673cdc1..0f677fdcfcc7 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -1461,6 +1461,7 @@ struct bpf_prog_aux {
> > > > >         const struct btf_type *attach_func_proto;
> > > > >         /* function name for valid attach_btf_id */
> > > > >         const char *attach_func_name;
> > > > > +       u64 accessed_args;
> > > > >         struct bpf_prog **func;
> > > > >         void *jit_data; /* JIT specific data. arch dependent */
> > > > >         struct bpf_jit_poke_descriptor *poke_tab;
> > > > > @@ -2565,6 +2566,9 @@ struct bpf_reg_state;
> > > > >  int btf_prepare_func_args(struct bpf_verifier_env *env, int subp=
rog);
> > > > >  int btf_check_type_match(struct bpf_verifier_log *log, const str=
uct bpf_prog *prog,
> > > > >                          struct btf *btf, const struct btf_type *=
t);
> > > > > +int btf_check_func_part_match(struct btf *btf1, const struct btf=
_type *t1,
> > > > > +                             struct btf *btf2, const struct btf_=
type *t2,
> > > > > +                             u64 func_args);
> > > > >  const char *btf_find_decl_tag_value(const struct btf *btf, const=
 struct btf_type *pt,
> > > > >                                     int comp_idx, const char *tag=
_key);
> > > > >  int btf_find_next_decl_tag(const struct btf *btf, const struct b=
tf_type *pt,
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index 170d017e8e4a..c2a0299d4358 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -6125,19 +6125,24 @@ static bool is_int_ptr(struct btf *btf, c=
onst struct btf_type *t)
> > > > >  }
> > > > >
> > > > >  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_typ=
e *func_proto,
> > > > > -                          int off)
> > > > > +                          int off, int *aligned_idx)
> > > > >  {
> > > > >         const struct btf_param *args;
> > > > >         const struct btf_type *t;
> > > > >         u32 offset =3D 0, nr_args;
> > > > >         int i;
> > > > >
> > > > > +       if (aligned_idx)
> > > > > +               *aligned_idx =3D -ENOENT;
> > > > > +
> > > > >         if (!func_proto)
> > > > >                 return off / 8;
> > > > >
> > > > >         nr_args =3D btf_type_vlen(func_proto);
> > > > >         args =3D (const struct btf_param *)(func_proto + 1);
> > > > >         for (i =3D 0; i < nr_args; i++) {
> > > > > +               if (aligned_idx && offset =3D=3D off)
> > > > > +                       *aligned_idx =3D i;
> > > > >                 t =3D btf_type_skip_modifiers(btf, args[i].type, =
NULL);
> > > > >                 offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->s=
ize, 8);
> > > > >                 if (off < offset)
> > > > > @@ -6207,7 +6212,7 @@ bool btf_ctx_access(int off, int size, enum=
 bpf_access_type type,
> > > > >                         tname, off);
> > > > >                 return false;
> > > > >         }
> > > > > -       arg =3D get_ctx_arg_idx(btf, t, off);
> > > > > +       arg =3D get_ctx_arg_idx(btf, t, off, NULL);
> > > > >         args =3D (const struct btf_param *)(t + 1);
> > > > >         /* if (t =3D=3D NULL) Fall back to default BPF prog with
> > > > >          * MAX_BPF_FUNC_REG_ARGS u64 arguments.
> > > > > @@ -6217,6 +6222,9 @@ bool btf_ctx_access(int off, int size, enum=
 bpf_access_type type,
> > > > >                 /* skip first 'void *__data' argument in btf_trac=
e_##name typedef */
> > > > >                 args++;
> > > > >                 nr_args--;
> > > > > +               prog->aux->accessed_args |=3D (1 << (arg + 1));
> > > > > +       } else {
> > > > > +               prog->aux->accessed_args |=3D (1 << arg);
> > > >
> > > > What do you need this aligned_idx for ?
> > > > I'd expect that above "accessed_args |=3D (1 << arg);" is enough.
> > > >
> > >
> > > Which aligned_idx? No aligned_idx in the btf_ctx_access(), and
> > > aligned_idx is only used in the btf_check_func_part_match().
> > >
> > > In the btf_check_func_part_match(), I need to compare the
> > > t1->args[i] and t2->args[j], which have the same offset. And
> > > the aligned_idx is to find the "j" according to the offset of
> > > t1->args[i].
> >
> > And that's my question.
> > Why you don't do the max of accessed_args across all attach
> > points and do btf_check_func_type_match() to that argno
> > instead of nargs1.
> > This 'offset +=3D btf_type_is_ptr(t1) ? 8 : roundup...
> > is odd.
>
> Hi, I'm trying to make the bpf flexible enough. Let's take an example,
> now we have the bpf program:
>
> int test1_result =3D 0;
> int BPF_PROG(test1, int a, long b, char c)
> {
>     test1_result =3D a + c;
>     return 0;
> }
>
> In this program, only the 1st and 3rd arg is accessed. So all kernel
> functions whose 1st arg is int and 3rd arg is char can be attached
> by this bpf program, even if their 2nd arg is different.
>
> And let's take another example for struct. This is our bpf program:
>
> int test1_result =3D 0;
> int BPF_PROG(test1, long a, long b, char c)
> {
>     test1_result =3D c;
>     return 0;
> }
>
> Only the 3rd arg is accessed. And we have following kernel function:
>
> int kernel_function1(long a, long b, char c)
> {
> xxx
> }
>
> struct test1 {
>     long a;
>     long b;
> };
> int kernel_function2(struct test1 a, char b)
> {
> xxx
> }
>
> The kernel_function1 and kernel_function2 should be compatible,
> as the bpf program only accessed the ctx[2], whose offset is 16.
> And the arg in kernel_function1() with offset 16 is "char c", the
> arg in kernel_function2() with offset 16 is "char b", which is
> compatible.
>
> That's why we need to check the consistency of accessed args
> by offset instead of function arg index.
>

And that's why I didn't share the code with btf_check_func_type_match().
In btf_check_func_part_match(), I'm trying to check the "real" accessed
args of t1 and t2, not by the function index, which has quite a difference
with btf_check_func_type_match().

> I'm not sure if I express my idea clearly, is this what you are
> asking?
>
> Thanks!
> Menglong Dong

