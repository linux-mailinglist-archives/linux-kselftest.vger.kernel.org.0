Return-Path: <linux-kselftest+bounces-6264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62441879930
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E511C21763
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C47E578;
	Tue, 12 Mar 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/iSciIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A015BF;
	Tue, 12 Mar 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261754; cv=none; b=JSgeGS0tVWvZHHOYhnYS9B7j2omVCZT+7DmyCEVa/DB1HpUYhmkZea/Nvgg1VDJNaYaoWhhSdaVDQWHHSMHdpDDExtmo/0R3JLs//VSF+nq2Sas0zx6qoyqXWk3IDtXxZcO0TMR0p+Qp9Y9LBpy4qhXmjn1rpKrIPYXrEWANa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261754; c=relaxed/simple;
	bh=IOgqkFC+7YdtEWrDEG6VjFtw1asWxY5nI0CrswHAChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AirsjUnB326vLJHYVfcOpl8EJhyJUYObcTbvo92ujtEPioQlfOIV1YHkxAwMRNqurXlcY0gcNr9ODJhSktIAXX4diTthGWBU8Up27IK09A5mKeZsj2dLaE0Z9i0isftffBUq4Og4kSbGryrdROgIYUKY8et3ch2v52cLXhch7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/iSciIw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e9df3416bso1255106f8f.3;
        Tue, 12 Mar 2024 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710261751; x=1710866551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLfmcQWu5XXgWrSqV2rZUXevRLdZ2i834nrQ0vcBR5U=;
        b=d/iSciIwroGieURQlgA8fpaiaFKGNwcyk4A5FC2l9dhiKW6spTNPbw824j8YQbxmJn
         VaB1YYFXAw6zMZpjeJ8ybd6gVqTIcQ8SECsb9Gnq5t8WpFswyAocjSaErpZXlq/BJmcH
         KwTPcDoxYZakRsMKF4gbErmSAYHTPFQDtHIdKUTZ1M6tqsIzYjHudZNrU3MqBHWTtnnc
         mLG1OMez6Qc9U//258c1SDybIw5CFRqg4DJemZMoTV4VJSu3zWZNIjRM2ol4PeDbUUwf
         nptpMqqrc7XZfW6H2Hz0bKYvgzb5R/RJM9xGf1FL0KwBGe7NHyNWMCH79dbAwYso6FYZ
         bSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710261751; x=1710866551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLfmcQWu5XXgWrSqV2rZUXevRLdZ2i834nrQ0vcBR5U=;
        b=KQ29HysbZoOwqUlT5JGrEL05JJ0+wffQIvkiU7SxZ1Adjzyf1VLJh+hAy2V4BLY2PX
         jjNMRr5hG89XcjAHXnXBP4WJT8lDWqYtD3tVKPJKrIS/gd5rLJHUnorigb0DEn9mV7uy
         rtAuBYb0VUtJr6kiW3NIKZ0YFym6ic/0hIt/rcmXxeln5s30mUkZ5ZX7DBq60oj6TkdV
         ntwRbzkeeuTEbmYHpVUl5CVTWpP20y95y97V72HZ79PYMgwJsOayXXepxfyBOWcrhZUT
         VkFCzTkyORul1m1CLZzO9ebmpfD+HQTMCMmW89jP1FNB25xOYKX//FIv2bezUfg9YRXE
         yHTw==
X-Forwarded-Encrypted: i=1; AJvYcCVNssiKARFpffZ8LoFSbrjGVSAKhQXuefJJFx41gcDFjND5KLa3vPRqxsTM4wa0CCYlkJDjb5BW78pkswMq8V/BMe+Q891K3xaq6iOJgUVVkZistZI7i2ZBJEHJBBs0XAkH2pm+x8ASHdHFPA/f4Qkhk8594XPW+YTG8PWdR6pUB70qTtOiOOekI8y1OABLrihS9A+JPTyQOWhnH3/qdRuAcG6psA0ixnNyyDERJ4EbbTkj8IXs7pK0dCpq7L7WRBMeTxdisQ1i4o26e1b6Mhqh8hSRr5Bn3LhxSQ==
X-Gm-Message-State: AOJu0Yx4f6A3li4NgbiVm58JtzoXKBefug+tQwcyttaSpOxX5RWiDfuU
	QKXIk84fwa6J3YFyeIuU2cI9Lfw7kuNqaIJ6yPj5DTuTH7cQnLFq3VxpLIcNXFji9x68OAeB90l
	7ghPlqBXrzQiHMVduxhgbAKbv/ok=
X-Google-Smtp-Source: AGHT+IEa+4UMJem4Fp/QIrh+BONIvwnIkZaOvOjaYS7rj5IxmTt11nQG4gevX9xIkt30Kg19GjMMdC27opnimO5UKuk=
X-Received: by 2002:adf:fa91:0:b0:33e:11c3:7ebf with SMTP id
 h17-20020adffa91000000b0033e11c37ebfmr6854846wrr.62.1710261750841; Tue, 12
 Mar 2024 09:42:30 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Mar 2024 09:42:17 -0700
Message-ID: <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
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

On Mon, Mar 11, 2024 at 7:42=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
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

I see.
I thought you're sharing the trampoline across attachments.
(since bpf prog is the same).
But above approach cannot possibly work with a shared trampoline.
You need to create individual trampoline for all attachment
and point them to single bpf prog.

tbh I'm less excited about this feature now, since sharing
the prog across different attachments is nice, but it won't scale
to thousands of attachments.
I assumed that there will be a single trampoline with max(argno)
across attachments and attach/detach will scale to thousands.

With individual trampoline this will work for up to a hundred
attachments max.

Let's step back.
What is the exact use case you're trying to solve?
Not an artificial one as selftest in patch 9, but the real use case?

