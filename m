Return-Path: <linux-kselftest+bounces-6237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF077878C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4033C1F21A4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D1017CD;
	Tue, 12 Mar 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTua+S+P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C7EC3;
	Tue, 12 Mar 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207995; cv=none; b=BoASbJkUpoZufVKvOEFLoHoISHf11pILS4G4Oo5wS01qB1nAUB0o6FRmiMi5ERq78HOg9cDaNzV9C8y01veoSR7cI1SaMOHfY1Z8l2QmoDOJjnBpkeEgJSNnXpp0l/41eR7QH5seXSVTi3dsbhUk9WGVpG3Ke2PuZgC8IgJvqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207995; c=relaxed/simple;
	bh=82HXWN2sfcHPgUgrgkwArzg952jQ3uv64UrJ4J7lMgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppKb65E2UwPPSlslvKftqGqrebyat8g41jW78ExdD0/9t92l+00K9455F4p2Aq1Dd/7O/LLeqk3lEh80VUiP+01mwquFZ/hKft4RrH+M06UOm/3GuMC+kh2hO8F8LhJcLTdEqmwbO6QrQGbneuhkYzhNfPS1K8W5ckmPCmVFwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTua+S+P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41330a62bf7so4547115e9.1;
        Mon, 11 Mar 2024 18:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710207992; x=1710812792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFvEiqhX2i2GoBS6IFsYFhmAGUUKO86Ht6WflbVQ8Y8=;
        b=QTua+S+Pb5QslS5Y5dDQQEh6tQ5teYaCyX/4o7PoTgkCtzr5lowW7MqJcrmjGfQ5Bq
         iFgIsfJfuNkrHqbGIEZaqPXFrLmrhwUnnxFA2t3V83vLzjgX5acR5CPmo8SnwDV4qbHt
         5bZs1vY0JtXKE8bpBVbV0Xpy4ai+4OOTTFBPZvbKKKZyGxlf+Mn25/NgaGWnrWc4tUzL
         Qg+L/hkx+yrPELZlHiWnDzyuht6KIq8+m4cgXaiZQieJtCeVBiIR/2h9gFTwI6tLVgfR
         g4I8ZnMieS6L+G/ZONue0clYhu4rL6yik2bBDoa0FG4iMQPKSnRkz8diWfDU5Tlup+oa
         E2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710207992; x=1710812792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFvEiqhX2i2GoBS6IFsYFhmAGUUKO86Ht6WflbVQ8Y8=;
        b=k7iCUQ+8YiIwVu4ubU9I1SxQDvOKoQxf62VlXrNarL8XoMTNd50Uc6yjP091V5gOYI
         C55AXV/zQOUFS65SiY+2AcnF7zWQB7c4V7oIx+8D4a42CfYaEI0o7zFSU5FTinejLikb
         +Lv4FmyXY19+W3uOGt9lz9qpSDMuO3hn8wWm09UGAvVkeIADaqFmlOfUr6ynLQghtcCr
         olIhXtMvVdIzyoRiCHAwChPf64hNf+3oXFQ6P++lz2mkDYu/o4WWRtJZuFhxEllOVhM7
         JXWVoZLZqMAFhVcBPZ4sFy1wEZptr1cl0+KAr0Vk8YbD6X+jGM2tjuTqthXjXOBme2J/
         rR1g==
X-Forwarded-Encrypted: i=1; AJvYcCWRIyQJtjXh7OdqhEXcXxPrR8Wst407HrCH2prQGL1/L+lFo9+2bofpxvv4W9ICTvqg+mk8Vvzv//6iYuN1KqUdtVi5JzB0w4Tp4yMs+isGx5rViBOo2UMNELglki0QjJS3TvlFvjYAyVDvDl2oLui0GqCp3AzZSmelFGrr0vTa9LiNCqzJgj4oQJE0NTjckMSsDMGXEjYcuiUfJBcoU/osEGQizqI1TQagkBt1u6oYxJjr/Z/kie6ld7n9eBDHfR3fsJIAoOjwIVjfGeDxvvZ9884oTLc3yxNZlg==
X-Gm-Message-State: AOJu0Yx5JtS3JGglyCVcBL8fKvLDNE273xbAOOiGvST7icF5XNUa6I3s
	GXzzNyouPe5X1gkI/xdeHMQqs3eg8zSZ97cfswHx1p/6p9KBASB0DBlcuw9RGTnkZC3AvRVrGFd
	Fj5+s+61oeywMA7hMQmTo1wcc+6M=
X-Google-Smtp-Source: AGHT+IE2O3q08IG7koprpVBAqPH51TPrr8tIiRdpN+Hjlh32uUAnsmvFQ7iaUIR3l+9EpCJWnXc/E2rl/5o+a1GbZgw=
X-Received: by 2002:a05:600c:4711:b0:413:1a5d:96c1 with SMTP id
 v17-20020a05600c471100b004131a5d96c1mr5075871wmo.40.1710207992248; Mon, 11
 Mar 2024 18:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com> <20240311093526.1010158-2-dongmenglong.8@bytedance.com>
In-Reply-To: <20240311093526.1010158-2-dongmenglong.8@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 18:46:21 -0700
Message-ID: <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support to record and
 check the accessed args
To: Menglong Dong <dongmenglong.8@bytedance.com>
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

On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
<dongmenglong.8@bytedance.com> wrote:
>
> In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
> which is used to record the accessed index of the function args in
> btf_ctx_access().
>
> Meanwhile, we add the function btf_check_func_part_match() to compare the
> accessed function args of two function prototype. This function will be
> used in the following commit.
>
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  include/linux/bpf.h |   4 ++
>  kernel/bpf/btf.c    | 108 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 110 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 95e07673cdc1..0f677fdcfcc7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1461,6 +1461,7 @@ struct bpf_prog_aux {
>         const struct btf_type *attach_func_proto;
>         /* function name for valid attach_btf_id */
>         const char *attach_func_name;
> +       u64 accessed_args;
>         struct bpf_prog **func;
>         void *jit_data; /* JIT specific data. arch dependent */
>         struct bpf_jit_poke_descriptor *poke_tab;
> @@ -2565,6 +2566,9 @@ struct bpf_reg_state;
>  int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
>  int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_=
prog *prog,
>                          struct btf *btf, const struct btf_type *t);
> +int btf_check_func_part_match(struct btf *btf1, const struct btf_type *t=
1,
> +                             struct btf *btf2, const struct btf_type *t2=
,
> +                             u64 func_args);
>  const char *btf_find_decl_tag_value(const struct btf *btf, const struct =
btf_type *pt,
>                                     int comp_idx, const char *tag_key);
>  int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type =
*pt,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 170d017e8e4a..c2a0299d4358 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6125,19 +6125,24 @@ static bool is_int_ptr(struct btf *btf, const str=
uct btf_type *t)
>  }
>
>  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_=
proto,
> -                          int off)
> +                          int off, int *aligned_idx)
>  {
>         const struct btf_param *args;
>         const struct btf_type *t;
>         u32 offset =3D 0, nr_args;
>         int i;
>
> +       if (aligned_idx)
> +               *aligned_idx =3D -ENOENT;
> +
>         if (!func_proto)
>                 return off / 8;
>
>         nr_args =3D btf_type_vlen(func_proto);
>         args =3D (const struct btf_param *)(func_proto + 1);
>         for (i =3D 0; i < nr_args; i++) {
> +               if (aligned_idx && offset =3D=3D off)
> +                       *aligned_idx =3D i;
>                 t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>                 offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
>                 if (off < offset)
> @@ -6207,7 +6212,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>                         tname, off);
>                 return false;
>         }
> -       arg =3D get_ctx_arg_idx(btf, t, off);
> +       arg =3D get_ctx_arg_idx(btf, t, off, NULL);
>         args =3D (const struct btf_param *)(t + 1);
>         /* if (t =3D=3D NULL) Fall back to default BPF prog with
>          * MAX_BPF_FUNC_REG_ARGS u64 arguments.
> @@ -6217,6 +6222,9 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>                 /* skip first 'void *__data' argument in btf_trace_##name=
 typedef */
>                 args++;
>                 nr_args--;
> +               prog->aux->accessed_args |=3D (1 << (arg + 1));
> +       } else {
> +               prog->aux->accessed_args |=3D (1 << arg);

What do you need this aligned_idx for ?
I'd expect that above "accessed_args |=3D (1 << arg);" is enough.

>         }
>
>         if (arg > nr_args) {
> @@ -7024,6 +7032,102 @@ int btf_check_type_match(struct bpf_verifier_log =
*log, const struct bpf_prog *pr
>         return btf_check_func_type_match(log, btf1, t1, btf2, t2);
>  }
>
> +static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_type=
 *t)
> +{
> +       const struct btf_param *args;
> +       u32 size =3D 0, nr_args;
> +       int i;
> +
> +       nr_args =3D btf_type_vlen(t);
> +       args =3D (const struct btf_param *)(t + 1);
> +       for (i =3D 0; i < nr_args; i++) {
> +               t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> +               size +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> +       }
> +
> +       return size;
> +}
> +
> +/* This function is similar to btf_check_func_type_match(), except that =
it
> + * only compare some function args of the function prototype t1 and t2.
> + */
> +int btf_check_func_part_match(struct btf *btf1, const struct btf_type *f=
unc1,
> +                             struct btf *btf2, const struct btf_type *fu=
nc2,
> +                             u64 func_args)

This is way too much copy paste.
Please share the code with btf_check_func_type_match.

