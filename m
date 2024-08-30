Return-Path: <linux-kselftest+bounces-16857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 067C1966B48
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A791F230D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC47165EEE;
	Fri, 30 Aug 2024 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHMQw20P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AD15CD4D;
	Fri, 30 Aug 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053460; cv=none; b=cbuTO+tvZq6fkowg/werJhIBvFXSE0y8VXTbCUr5oks90anz3q6s6XAdMWm/DffBk8YFYssilpbeQhbYN8qXHkfoYSDseP36od1qrIxMfICGOEL1zQswoJZENAzn+38zQIige/+ErabgMxJwh4Bs9D6BbTuCAgwv/eHnAc9gP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053460; c=relaxed/simple;
	bh=oxmxygH9uGc52BoBejYu8D14WO4RiVYFjkPq02zYQmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kznVkCxXsu7l+Ke30kHzMOd4u3XVLKNeeGGeLue6dlc+tQCJmNLPVcGT3pcHMqXbb+vsNoNtbXqpXjn+WRqFYkVsLnO2z53noOky9zXaOPpIdHfVCOFz7kCmsYz1B+oox6+rocarfElktdV+3/1f3czoGyMK2ednyWDct7E63EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHMQw20P; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso698736a91.3;
        Fri, 30 Aug 2024 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053459; x=1725658259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsw9u+hlrD1aAH8kBVi3rfN7WXlvREHc6VwV/mggtkI=;
        b=LHMQw20PMzqV2Q+b7/aNxMb8EYM6F2R/7qvmRmu+VJ06rQCk0/Etn4MZZIIBAr7LXG
         7qp9g5ur+PW3iwGfy1hi3VtZX86k8APk4o80b+xOp685eqblAkVOWeMd9S2e6DUDgyx0
         oiZDJDRlZQzDRKQGRPU070n/XCrLDu5OLSSK0VPKSqlNwGq/j/AzIwWfnAWWRI7bjDHL
         ucue/z0xefOoE7CRkbKr2ICdwiPmE59PLye2fWBq46wRxzpBKnf7kKXFARJfsKAoTaXU
         r5tCgaCwFAnNkXM+VERQsmmTDqsDG68lUW4gKyFnFZaPvQPITf2JvyLIrYQWl1kBnIMY
         yz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053459; x=1725658259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsw9u+hlrD1aAH8kBVi3rfN7WXlvREHc6VwV/mggtkI=;
        b=WZb+XqXFRAAnVUUCZqVORGMfH8N3xCqRTPU70deqoJZHooUXTd8SG8yaIcymUUA8lV
         CpE53K8I1FecJdvnXz1/YBZsrNjdHQT+NLFnL93PTA8TCwTjN2626r6OKK4/bZ4HOP/p
         KxGE6X9au349A3Ww4bVPjc4yE27I8T1WtOqYOhRpa5NbZ29prIksy3x2vXuZdD731T1a
         Rzj2Ag8wGChLV009UE7Amb75QUwoFGDks8fyAxitWidpnphMvMt4UIAjv/WyPLtu2stZ
         okWwuCc2wwLwyJeYlZr3CiztdSrnXv5wegFLIQipnL8dPtbspF4Q5MLXenGn2e4M784v
         DHnA==
X-Forwarded-Encrypted: i=1; AJvYcCW9zG5FxpH/MKDtOFx04W1SU+m9SC/eHzQbD3OrVkgDzMvMi995MyNvoTm2GlqNVooqyA8xFRrhyoEnna0yDs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxefy1E8yORnAVLeCj6X3OLxpea4O2o+8xA9qOf7mQ6/H7I0Fy1
	mh6LdgVKQtmKjVDfh6w1ojQRO3JthMZWkLZrhpv+NiiraBBvB2HRgtHTDONASYGxoBcLdfb/SUd
	D4+5kP4mghV6wIGzgRnZDzfuMAe0=
X-Google-Smtp-Source: AGHT+IFN27bnSpXxBxf9WmN06GQLR8DHeClx5TktyZpZLh+LYSrdgsPYVx/FYpte+A7Fpy25Og6ARYzMBtHlQwwYU84=
X-Received: by 2002:a17:90a:1c17:b0:2c9:6f06:8005 with SMTP id
 98e67ed59e1d1-2d856383fdemr8093749a91.26.1725053458619; Fri, 30 Aug 2024
 14:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724976539.git.tony.ambardar@gmail.com> <ed17daaceb6fd12a62c7286958239bb34fc3f55b.1724976539.git.tony.ambardar@gmail.com>
In-Reply-To: <ed17daaceb6fd12a62c7286958239bb34fc3f55b.1724976539.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 14:30:46 -0700
Message-ID: <CAEf4Bzb++vMkc=Q44QhQ5BXJcnUWahVtBUgQBUwkdVvC1QYKnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] libbpf: Support creating light skeleton
 of either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:30=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Track target endianness in 'struct bpf_gen' and process in-memory data in
> native byte-order, but on finalization convert the embedded loader BPF
> insns to target endianness.
>
> The light skeleton also includes a target-accessed data blob which is
> heterogeneous and thus difficult to convert to target byte-order on
> finalization. Add support functions to convert data to target endianness
> as it is added to the blob.
>
> Also add additional debug logging for data blob structure details and
> skeleton loading.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |   1 +
>  tools/lib/bpf/gen_loader.c       | 187 +++++++++++++++++++++++--------
>  tools/lib/bpf/libbpf.c           |   1 +
>  tools/lib/bpf/skel_internal.h    |   3 +-
>  4 files changed, 147 insertions(+), 45 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_int=
ernal.h
> index fdf44403ff36..6ff963a491d9 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h
> @@ -34,6 +34,7 @@ struct bpf_gen {
>         void *data_cur;
>         void *insn_start;
>         void *insn_cur;
> +       bool swapped_endian;
>         ssize_t cleanup_label;
>         __u32 nr_progs;
>         __u32 nr_maps;
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index cf3323fd47b8..4374399bc3f8 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -401,6 +401,15 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_prog=
s, int nr_maps)
>                 opts->insns_sz =3D gen->insn_cur - gen->insn_start;
>                 opts->data =3D gen->data_start;
>                 opts->data_sz =3D gen->data_cur - gen->data_start;
> +
> +               /* use target endianness for embedded loader */
> +               if (gen->swapped_endian) {
> +                       struct bpf_insn *insn =3D (struct bpf_insn *)opts=
->insns;
> +                       int insn_cnt =3D opts->insns_sz / sizeof(struct b=
pf_insn);
> +
> +                       for (i =3D 0; i < insn_cnt; i++)
> +                               bpf_insn_bswap(insn++);
> +               }
>         }
>         return gen->error;
>  }
> @@ -414,6 +423,31 @@ void bpf_gen__free(struct bpf_gen *gen)
>         free(gen);
>  }
>
> +/*
> + * Fields of bpf_attr are set to values in native byte-order before bein=
g
> + * written to the target-bound data blob, and may need endian conversion=
.
> + * This macro allows providing the correct value in situ more simply tha=
n
> + * writing a separate converter for *all fields* of *all records* includ=
ed
> + * in union bpf_attr. Note that sizeof(rval) should match the assignment
> + * target to avoid runtime problems.
> + */
> +#define tgt_endian(rval) ({                                    \
> +       typeof(rval) _val;                                      \
> +       if (!gen->swapped_endian)                               \

if/else has to have balanced branches w.r.t. {}. Either both should
have it or both shouldn't. In this case both should have it.

> +               _val =3D (rval);                                  \
> +       else {                                                  \
> +               switch (sizeof(rval)) {                         \
> +               case 1: _val =3D (rval); break;                   \
> +               case 2: _val =3D bswap_16(rval); break;           \
> +               case 4: _val =3D bswap_32(rval); break;           \
> +               case 8: _val =3D bswap_64(rval); break;           \
> +               default:_val =3D (rval);                          \
> +                       pr_warn("unsupported bswap size!\n");   \

this is a weird formatting,  but you can also just unconditionally
assign _val, and only swap it if gen->swapped_endian

typeof(rval) _val =3D (rval);

if (gen->swapped_endian) {
    switch (...) {
        case 1: ...
        ...
        case 8: ...
        default: pr_warn("...");
    }
}

_val;


seems simpler and cleaner, imo

> +               }                                               \
> +       }                                                       \
> +       _val;                                                   \
> +})
> +


for the rest, Alexei, can you please review and give your ack?

