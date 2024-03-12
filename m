Return-Path: <linux-kselftest+bounces-6245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547F878CC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985911C20F64
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC053A1;
	Tue, 12 Mar 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ1qkU7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E779C0;
	Tue, 12 Mar 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209379; cv=none; b=VPNeafI1D45HEKvcRtm24FUGzoV5crV5QHQlbuPLSuIWGh0FyUPfdOphZrdZZYJ/GUpE195rC7K2UA3x22IZ3rR3ZnBQZh2L3YXpwGMKawcFCxTz0kejccapdNOO6Plwpzh2j3iAFtKAJw7e18la8Ac5NHLan72UINkc1TPta6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209379; c=relaxed/simple;
	bh=MUN7lvB0UfY/wJL8qyyPEvDzT/66bkDUGhfDsuGFPYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UG3dhBTmHuSUFLgvolaqyuRF7bRhIdX07GZ8igRbuAE94zHvc+u2qzmw313NXbfJq1IVD4uB0CSFflXQlHkLuxYjNqI8bMvLUyM+563UIELv4P0Xr2OMNPCAQzQ2Y4R1YJO16TiUMHaaPF/cAxR741iQwjoGV678iEqpbsKPPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ1qkU7K; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e285a33bdso2931514f8f.2;
        Mon, 11 Mar 2024 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710209376; x=1710814176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7OazjLh3TJZJaBxgYhNmL2BYNu/aO7IPEXCMBRgvJk=;
        b=TQ1qkU7K1LIz072vCKojVBdHTguIKr0PDP7G0Ksy5EyEQPIaeXfwq38iCT1nUD+21p
         vkRH3hL+wKcbQef5pi4j0M3JlEmsMP2bJ4DvsxlFfVfMIZ0zBGmZukYRQQxjdHVnfMhc
         GxH/hXrAX48DS0aUHp4ideUmS2OBKXA7QscPpFM8G5O4RlVuAbdph1gI8xKmJWjLg83o
         GP2E0/iW1ad6hrMUqzL+VjDG5pJbkVlO2hvYF4zKC68M/pd1/6rrWWFfOYjp4PIZDvkk
         LpwSwu/I6WsXRspS/+fq9UgpxUAFvHOPzFFySkMiVNS+DxkfVhwHn8TXy0he4Ap4e9ja
         D6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710209376; x=1710814176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7OazjLh3TJZJaBxgYhNmL2BYNu/aO7IPEXCMBRgvJk=;
        b=OApJ2pE/DB1ratz3ZA0YvEkbfTrND8RRd1DH1uHOsNlLOoHezhwCNdE6dr7AOXH0BT
         HZNIGvOAI16q1oJibESBXEUnKjZvtLBJ8oxzBdbJQU/2as0LzT2VhxqFNiGcoiNpNvIR
         0vBp9mWYghuRae5i0l5dLkDLdTX6aBV2LBFy3NmDmph6FZeLom8NhuS0NoDQYX/MO9vJ
         91huYSEJs22Y2EhPgJfQZTZldZ0mVQ0OFtmboUkqSMGsNMbCbnpcmw7QKZRO/fiI5WG1
         muTWylxTyXDjwWaCplzUr8dc72Gtmq+UdWAbmmF38a1Sl5fgGcbJ1AKexYk/Q1WcIjjM
         B3vA==
X-Forwarded-Encrypted: i=1; AJvYcCUdsa5COikWxxa3WK5bu3L71y8Gd3wDhzRdUAXSvUFEZcNh+2mZignmRPbnpC0eB2qRwxwcmKWi79p4rIVkri2SPmTTs18ikStMH4bNknPez/5THY6x7GEBb3XnPUvd3eq3JF4aw6nau6wMaQsEMT1BfrypKj9ZNAwauISaVEwV2+oZUF61pq8AI9C1fDkbA5oWjifhw6sXbRn9b8GZLrftGvck80ve215iotIu7/5RRJbX19rpVUr/BwhHM+YDVSIqCk0ZnRaB3GecFyYRnX/NGfDhnumsNCQJ7g==
X-Gm-Message-State: AOJu0YzNar4qdJGkYE/rKROcW6n+fqhheBajHhfpM0EhGGs1VLde8ApX
	BuXVdpTk+vIv3I+0V8H5LOtCYizYEFIR7qu3WoJC91mjLhwkCjLQdIgABvTCrb5z0RKzimQsDPO
	XycjVn8jqkRBWJbXfVdIGbqgWqd0=
X-Google-Smtp-Source: AGHT+IEicWbuFZqdg/xqQNzdGQlw9skotEo3jcZk3zVibmZ6sCWBpxxOKUqsLebol1eFrvMKXlFvA4Sc4ycQD3B2uCo=
X-Received: by 2002:a5d:424d:0:b0:33e:7adc:516c with SMTP id
 s13-20020a5d424d000000b0033e7adc516cmr5003733wrr.57.1710209376134; Mon, 11
 Mar 2024 19:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
In-Reply-To: <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 19:09:25 -0700
Message-ID: <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
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

On Mon, Mar 11, 2024 at 7:01=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> On Tue, Mar 12, 2024 at 9:46=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
> > <dongmenglong.8@bytedance.com> wrote:
> > >
> > > In this commit, we add the 'accessed_args' field to struct bpf_prog_a=
ux,
> > > which is used to record the accessed index of the function args in
> > > btf_ctx_access().
> > >
> > > Meanwhile, we add the function btf_check_func_part_match() to compare=
 the
> > > accessed function args of two function prototype. This function will =
be
> > > used in the following commit.
> > >
> > > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > > ---
> > >  include/linux/bpf.h |   4 ++
> > >  kernel/bpf/btf.c    | 108 ++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 110 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 95e07673cdc1..0f677fdcfcc7 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1461,6 +1461,7 @@ struct bpf_prog_aux {
> > >         const struct btf_type *attach_func_proto;
> > >         /* function name for valid attach_btf_id */
> > >         const char *attach_func_name;
> > > +       u64 accessed_args;
> > >         struct bpf_prog **func;
> > >         void *jit_data; /* JIT specific data. arch dependent */
> > >         struct bpf_jit_poke_descriptor *poke_tab;
> > > @@ -2565,6 +2566,9 @@ struct bpf_reg_state;
> > >  int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)=
;
> > >  int btf_check_type_match(struct bpf_verifier_log *log, const struct =
bpf_prog *prog,
> > >                          struct btf *btf, const struct btf_type *t);
> > > +int btf_check_func_part_match(struct btf *btf1, const struct btf_typ=
e *t1,
> > > +                             struct btf *btf2, const struct btf_type=
 *t2,
> > > +                             u64 func_args);
> > >  const char *btf_find_decl_tag_value(const struct btf *btf, const str=
uct btf_type *pt,
> > >                                     int comp_idx, const char *tag_key=
);
> > >  int btf_find_next_decl_tag(const struct btf *btf, const struct btf_t=
ype *pt,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 170d017e8e4a..c2a0299d4358 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6125,19 +6125,24 @@ static bool is_int_ptr(struct btf *btf, const=
 struct btf_type *t)
> > >  }
> > >
> > >  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *f=
unc_proto,
> > > -                          int off)
> > > +                          int off, int *aligned_idx)
> > >  {
> > >         const struct btf_param *args;
> > >         const struct btf_type *t;
> > >         u32 offset =3D 0, nr_args;
> > >         int i;
> > >
> > > +       if (aligned_idx)
> > > +               *aligned_idx =3D -ENOENT;
> > > +
> > >         if (!func_proto)
> > >                 return off / 8;
> > >
> > >         nr_args =3D btf_type_vlen(func_proto);
> > >         args =3D (const struct btf_param *)(func_proto + 1);
> > >         for (i =3D 0; i < nr_args; i++) {
> > > +               if (aligned_idx && offset =3D=3D off)
> > > +                       *aligned_idx =3D i;
> > >                 t =3D btf_type_skip_modifiers(btf, args[i].type, NULL=
);
> > >                 offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size,=
 8);
> > >                 if (off < offset)
> > > @@ -6207,7 +6212,7 @@ bool btf_ctx_access(int off, int size, enum bpf=
_access_type type,
> > >                         tname, off);
> > >                 return false;
> > >         }
> > > -       arg =3D get_ctx_arg_idx(btf, t, off);
> > > +       arg =3D get_ctx_arg_idx(btf, t, off, NULL);
> > >         args =3D (const struct btf_param *)(t + 1);
> > >         /* if (t =3D=3D NULL) Fall back to default BPF prog with
> > >          * MAX_BPF_FUNC_REG_ARGS u64 arguments.
> > > @@ -6217,6 +6222,9 @@ bool btf_ctx_access(int off, int size, enum bpf=
_access_type type,
> > >                 /* skip first 'void *__data' argument in btf_trace_##=
name typedef */
> > >                 args++;
> > >                 nr_args--;
> > > +               prog->aux->accessed_args |=3D (1 << (arg + 1));
> > > +       } else {
> > > +               prog->aux->accessed_args |=3D (1 << arg);
> >
> > What do you need this aligned_idx for ?
> > I'd expect that above "accessed_args |=3D (1 << arg);" is enough.
> >
>
> Which aligned_idx? No aligned_idx in the btf_ctx_access(), and
> aligned_idx is only used in the btf_check_func_part_match().
>
> In the btf_check_func_part_match(), I need to compare the
> t1->args[i] and t2->args[j], which have the same offset. And
> the aligned_idx is to find the "j" according to the offset of
> t1->args[i].

And that's my question.
Why you don't do the max of accessed_args across all attach
points and do btf_check_func_type_match() to that argno
instead of nargs1.
This 'offset +=3D btf_type_is_ptr(t1) ? 8 : roundup...
is odd.

