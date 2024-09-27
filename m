Return-Path: <linux-kselftest+bounces-18519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8078988BFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 23:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB41B1C20DC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A58172BDE;
	Fri, 27 Sep 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf8iaDpI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5C14BF8B;
	Fri, 27 Sep 2024 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473664; cv=none; b=Gnt/RyKuheOR2MG0I9eO0D5+ncZAMl6aRQQbvygCNEj+SDmiBb7xW+uYpct/RWFJjXukkgdlZG0xjYABMLqEbTDtqAFU6VbE9BEvP0sU8CZl/+E5cz/69LEoDjFEpapI4ydvVwmlXGIWImROLapOMQwkExgcEJwquYPiHrMmmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473664; c=relaxed/simple;
	bh=tMzO2lsBneKl9hDEYNfpRPmt6b2853y7PPtJ2lz5hfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8ALdbz5HItKjkUCwtrSj2C3rJljf2CYDrzNC+3AcudM/I93vORhYzuQe8GPoPUiHQ8H4W2oIYn+XR/mQ09O8UkvAGkDs0qXLmnZA1QEfBghsfOttChHE/fzwjeQ0Gy414mR6zKxGV804J6hBfCcuCaywmM0ANA46Ay0WKcBoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf8iaDpI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059204f448so24789715ad.0;
        Fri, 27 Sep 2024 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727473661; x=1728078461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+ttPIAQLS1mSyjPNXdKJqImDO3MuUBRJJf3XXWrCsg=;
        b=hf8iaDpITirLxmXuZMotTF9YqNKbhGMBZefk3CNTvS7JxGnVbsxW+ytyyJJ+FN2Bfe
         x9dihvwmaXtGP0ed7bp4Lve/PM7Q5zM8F5itdzLkkC7bvKvWKZtj9J26SzxRMz3bPa9I
         AoRDcGobwgKskNKk93FpWITM2KCWZqlJ1aWkV1e23MAh4ebiHt+sZ7F2H0RYQwACMVfU
         eubB9Q5+GPd0usAbkgTj92Nf2+9Fv0ujCjeiZU4abjQQ3p2gW3j84K1E3vG4k7uRW9jA
         N8SHKhOADLOh9Qg2ykw2mg8evK45I73Es+oEJNEZ3WnTXmAI3WzlgR2FhwQKzl/uYuA2
         ut2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727473661; x=1728078461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+ttPIAQLS1mSyjPNXdKJqImDO3MuUBRJJf3XXWrCsg=;
        b=eR+NafjftOGFUQN0tThQvjTNF6pfKXwcd6B2W09jBldVL/gcqxBnGWPQaTMAAMgu8Z
         Hv1Hb1BmPBbxWPXV0ujU8YgPYHwRGT3fkz2wCZuuTy3R5dAQvD22kpzryZaJCmrSFPl+
         PUpCktsrJTvCz/RC1iCelUn5TUwgDWk9bPH4eDmgYHeuZ6Yo1QdvzBxfd25AQ3ZdQaii
         F+ek0zO+thqM0+Q/mstdN7QaC6QUC6ozZwVxNRwclWKC2KfjADlXssXkU/7x0eZ9pTkd
         10zUtI0TlH1XnBkfyAIk8meDNnMEKlBlzFdNz+ZTo8czZ/o0kP65lFknIuZMJJspnaVC
         m99w==
X-Forwarded-Encrypted: i=1; AJvYcCXqUT4WNd9frWmHlOphzqCJJ4DWsjtrUefdhg3ZOOqJSUj7esQ6Xbq8uDPS5bXieAy77k6UgKlouk8R1TR7qN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtzJIDtFj4i4d0/CJ+qQjFIl//KPDRPMHm7xh0NQtE6x9ckAB
	gQIUVvNiYQru/VkY8YXlr3k6cUNCdrXFaNiU6fLHSGjsUsdVtaV00cDsQ925wvGz8dXIKPSPkSz
	j6li09U5NUHnQFFrgxF9XWKv0tzI=
X-Google-Smtp-Source: AGHT+IHsbB6Uo8WJweEk1SI4ElFHp2PIOyNu8OqtL+gU4b/l6dbmlLhoidF5wLZ94jbH4r3UpIoHr8/Ezel+getL4/E=
X-Received: by 2002:a17:90b:3555:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2e0b8f07960mr4174943a91.40.1727473660300; Fri, 27 Sep 2024
 14:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726475448.git.tony.ambardar@gmail.com> <133407ab20e0dd5c07cab2a6fa7879dee1ffa4bc.1726475448.git.tony.ambardar@gmail.com>
In-Reply-To: <133407ab20e0dd5c07cab2a6fa7879dee1ffa4bc.1726475448.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 14:47:27 -0700
Message-ID: <CAEf4BzbizHEPoQXecYMNz7xEzTZaJcsRVt=yHrdEEZBwO=kNNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 1:38=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Support for handling BTF data of either endianness was added in [1], but
> did not include BTF.ext data for lack of use cases. Later, support for
> static linking [2] provided a use case, but this feature and later ones
> were restricted to native-endian usage.
>
> Add support for BTF.ext handling in either endianness. Convert BTF.ext da=
ta
> to native endianness when read into memory for further processing, and
> support raw data access that restores the original byte-order for output.
> Add internal header functions for byte-swapping func, line, and core info
> records.
>
> Add new API functions btf_ext__endianness() and btf_ext__set_endianness()
> for query and setting byte-order, as already exist for BTF data.
>
> [1] 3289959b97ca ("libbpf: Support BTF loading and raw data output in bot=
h endianness")
> [2] 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support"=
)
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/btf.c             | 280 +++++++++++++++++++++++++-------
>  tools/lib/bpf/btf.h             |   3 +
>  tools/lib/bpf/libbpf.map        |   2 +
>  tools/lib/bpf/libbpf_internal.h |  30 ++++
>  4 files changed, 258 insertions(+), 57 deletions(-)
>

[...]

>
> -       /* The record size needs to meet the minimum standard */
> -       record_size =3D *(__u32 *)info;
> +       /* The record size needs to meet either the minimum standard or, =
when
> +        * handling non-native endianness data, the exact standard so as
> +        * to allow safe byte-swapping.
> +        */
> +       record_size =3D is_native ? *(__u32 *)info : bswap_32(*(__u32 *)i=
nfo);
>         if (record_size < ext_sec->min_rec_size ||
> +           (!is_native && record_size !=3D ext_sec->rec_size) ||

ok, so the way you define min_rec_size and rec_size is actually
broken. bpf_func_info, bpf_line_info, and now also bpf_core_relo all
come from kernel UAPI header, and it could happen that libbpf is
compiled against newest definitions of them without actually
"knowing"/supporting those newer and bigger struct definitions. So
assuming that sizeof(struct bpf_line_info) is a correct expected
record size is wrong.

As it is right now, min_rec_size is *the* rec_size, so I removed that
part and updated this check to record_size !=3D ext_sec->min_rec_size.
If we ever extend .BTF.ext records, we'll need to add a bit more code
to accomodate for that.

>             record_size & 0x03) {
>                 pr_debug("%s section in .BTF.ext has invalid record size =
%u\n",
>                          ext_sec->desc, record_size);
> @@ -2956,7 +2968,7 @@ static int btf_ext_setup_info(struct btf_ext *btf_e=
xt,
>                         return -EINVAL;
>                 }
>
> -               num_records =3D sinfo->num_info;
> +               num_records =3D is_native ? sinfo->num_info : bswap_32(si=
nfo->num_info);
>                 if (num_records =3D=3D 0) {
>                         pr_debug("%s section has incorrect num_records in=
 .BTF.ext\n",
>                              ext_sec->desc);
> @@ -2984,64 +2996,160 @@ static int btf_ext_setup_info(struct btf_ext *bt=
f_ext,
>         return 0;
>  }
>
> -static int btf_ext_setup_func_info(struct btf_ext *btf_ext)
> +/* Parse all info secs in the BTF.ext info data */
> +static int btf_ext_parse_info(struct btf_ext *btf_ext, bool is_native)
>  {
> -       struct btf_ext_sec_setup_param param =3D {
> +       struct btf_ext_sec_info_param func_info =3D {
>                 .off =3D btf_ext->hdr->func_info_off,
>                 .len =3D btf_ext->hdr->func_info_len,
>                 .min_rec_size =3D sizeof(struct bpf_func_info_min),
> +               .rec_size =3D sizeof(struct bpf_func_info),
>                 .ext_info =3D &btf_ext->func_info,
>                 .desc =3D "func_info"
>         };
> -
> -       return btf_ext_setup_info(btf_ext, &param);
> -}
> -
> -static int btf_ext_setup_line_info(struct btf_ext *btf_ext)
> -{
> -       struct btf_ext_sec_setup_param param =3D {
> +       struct btf_ext_sec_info_param line_info =3D {
>                 .off =3D btf_ext->hdr->line_info_off,
>                 .len =3D btf_ext->hdr->line_info_len,
>                 .min_rec_size =3D sizeof(struct bpf_line_info_min),
> +               .rec_size =3D sizeof(struct bpf_line_info),
>                 .ext_info =3D &btf_ext->line_info,
>                 .desc =3D "line_info",
>         };
> -
> -       return btf_ext_setup_info(btf_ext, &param);
> -}
> -
> -static int btf_ext_setup_core_relos(struct btf_ext *btf_ext)
> -{
> -       struct btf_ext_sec_setup_param param =3D {
> +       struct btf_ext_sec_info_param core_relo =3D {
>                 .off =3D btf_ext->hdr->core_relo_off,
>                 .len =3D btf_ext->hdr->core_relo_len,
>                 .min_rec_size =3D sizeof(struct bpf_core_relo),
> +               .rec_size =3D sizeof(struct bpf_core_relo),
>                 .ext_info =3D &btf_ext->core_relo_info,
>                 .desc =3D "core_relo",
>         };

[...]

>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4e349ad79ee6..47ee8f6ac489 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -167,6 +167,9 @@ LIBBPF_API const char *btf__str_by_offset(const struc=
t btf *btf, __u32 offset);
>  LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
>  LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
>  LIBBPF_API const void *btf_ext__raw_data(const struct btf_ext *btf_ext, =
__u32 *size);
> +LIBBPF_API enum btf_endianness btf_ext__endianness(const struct btf_ext =
*btf_ext);
> +LIBBPF_API int btf_ext__set_endianness(struct btf_ext *btf_ext,
> +                                      enum btf_endianness endian);
>
>  LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
>  LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 0096e483f7eb..f40ccc2946e7 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -421,6 +421,8 @@ LIBBPF_1.5.0 {
>         global:
>                 btf__distill_base;
>                 btf__relocate;
> +               btf_ext__endianness;
> +               btf_ext__set_endianness;
>                 bpf_map__autoattach;
>                 bpf_map__set_autoattach;
>                 bpf_object__token_fd;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 8cda511a1982..1307753b49b3 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h

missing #include <byteswap.h> in libbpf_internal.h, you added too late
(in the next patch). I moved that include into this patch/commit to
not break bisectability, please be careful about things like that

> @@ -484,6 +484,8 @@ struct btf_ext {
>                 struct btf_ext_header *hdr;
>                 void *data;
>         };
> +       void *data_swapped;
> +       bool swapped_endian;
>         struct btf_ext_info func_info;
>         struct btf_ext_info line_info;
>         struct btf_ext_info core_relo_info;
> @@ -511,6 +513,34 @@ struct bpf_line_info_min {
>         __u32   line_col;
>  };
>
> +/* Functions to byte-swap info records */
> +
> +typedef void (*info_rec_bswap_fn)(void *);
> +
> +static inline void bpf_func_info_bswap(struct bpf_func_info *i)
> +{
> +       i->insn_off =3D bswap_32(i->insn_off);
> +       i->type_id =3D bswap_32(i->type_id);
> +}
> +
> +static inline void bpf_line_info_bswap(struct bpf_line_info *i)
> +{
> +       i->insn_off =3D bswap_32(i->insn_off);
> +       i->file_name_off =3D bswap_32(i->file_name_off);
> +       i->line_off =3D bswap_32(i->line_off);
> +       i->line_col =3D bswap_32(i->line_col);
> +}
> +
> +static inline void bpf_core_relo_bswap(struct bpf_core_relo *i)
> +{
> +       _Static_assert(sizeof(i->kind) =3D=3D sizeof(__u32),
> +                      "enum bpf_core_relo_kind is not 32-bit\n");

Do we need the endline in _Static_assert() messages? And generally I
think this is a bit too paranoid to check that that enum is backed by
u32, I just dropped the assertion. This is part of kernel UAPI, it
shouldn't change.


> +       i->insn_off =3D bswap_32(i->insn_off);
> +       i->type_id =3D bswap_32(i->type_id);
> +       i->access_str_off =3D bswap_32(i->access_str_off);
> +       i->kind =3D bswap_32(i->kind);
> +}
> +
>  enum btf_field_iter_kind {
>         BTF_FIELD_ITER_IDS,
>         BTF_FIELD_ITER_STRS,
> --
> 2.34.1
>

