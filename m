Return-Path: <linux-kselftest+bounces-21018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F199B5564
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 22:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE51C21608
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8B20A5CC;
	Tue, 29 Oct 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhcMxmpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA3206E92;
	Tue, 29 Oct 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239126; cv=none; b=jrRFcKEyoYY4rOTadpg7F4nz3ViaPQeO2J1GFqPsaqOu+fz80/g65Vl6jnqDfjqrVZVt/WZxETAD7mf46tFgRMLUTlEW742wdjuUawMSVALLKbGTDCoazGBWqgRiNysh9afGI+PpFF1GI/a077LxnmL+I80PMCSQSR3cAl2PLjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239126; c=relaxed/simple;
	bh=SHX4q4Ga5BprPt4RG/OFAjhx9vgvS+LxJ7A9KN/isyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlQRmL1PN9dNMzGF7MW8yL83eivChK9iYJa3VCgQtWEiPAXnVgttajfNFiDvG0ACDyOvT7HK89Fqs9ErCfShECHGdGo/+XOxxb3uM679anGyzeeSv+7RCVhORCSP1asT79xPqohZeOnYtGL0wKSixVHudF+RnQVydxWixg8FY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhcMxmpy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72070d341e5so2602430b3a.1;
        Tue, 29 Oct 2024 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730239121; x=1730843921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxJfqMQuAFPXu4oNOb7SxCNwoM+CMOZywcRG4aHt4aU=;
        b=HhcMxmpyYjDpeVNqV3ZUZ2GQO1iUQbvPyh9mSarZX29v9kP94V1wEgIIZ5oOou44KE
         nmBaXUKygabhL/IptEKNERd+TRF5zaplABJPeXCWx+uRAg8aQZRcsbqpv1FUK7STCn5e
         z3WLk4SzpKwG5G5TTdKPPXpjGDz5knng+fA3SWGhUBePT6I5mBWb3fXHy3TLSy4vdKxp
         54IFneFOzRYqYR/20rRVIyor7D2askF0CushhoMjeY6xLOa/j8fMZ7CupSCaJAsrUQtq
         C9jpoVOPgJixJdgqdQLzPJ9g9XNbQjot7o+rcap1bKKjNg26Hk4ha8lPTeM4XRsPfw+N
         kEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730239121; x=1730843921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxJfqMQuAFPXu4oNOb7SxCNwoM+CMOZywcRG4aHt4aU=;
        b=nXB1rHWf1s5H70FtYnkSaeDeFyygtX6MTzc0hY2R8Lzm3ojWTWIsPmgjDJzWq1Ta7n
         0DxyHuFf+ULprWcAuJIebSCb/B6CSxMpnpsH5MbxC584ncexy7/AGDj9ll4Cyyn0FyaS
         hLXikFjZt3/tbODPKfabNHl2x+Y61px+Jabl/JjSZ3DIkA7L4IIQnuKJCM30uXH2iibJ
         jI+ceUA22xU254yxTGdw6LOKEWy7CFK1QYQHlnBizcmr2BayafPqWLQHwBffsUFO4eYp
         aXL8Dy6fx3ienEIhuV6WsqYBm6HLow0keM/iHnsqV/6LpJSn48O1CA52qBsJVlmZQsvM
         aQkg==
X-Forwarded-Encrypted: i=1; AJvYcCUAjxDcNmC0aLFQ65TxZPWD9FwTYJNsA73ykimfhzW4PrOREs88an2Df6cz2Ttd4tpAqpJyb7HTuBGwFGNo7gRz@vger.kernel.org, AJvYcCUUJd3RDAhYJqptYwmMNpnQF5kAOZlO0H6XF+YCvbsjVAWxGdiNwVFXXHBji2hnW3DniCjQSzaewVbdDVRC@vger.kernel.org, AJvYcCVwzieX65frq6Ni6x7z8miuRLzgUUhKSXpvlOWjBW710+pISiVm5kd5l7+kbKKBm4lyvCrRJzs3NcLjaRKFlD9ji89r@vger.kernel.org, AJvYcCX2tm0NU17Oxgau5RwKn5n/jmQ7oDwE9eNmhIN0n3tI84TPOuRhY67oEIryeBPF2BGu2AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjO/MCDrV9P3aAHKqw0x94bkQ46KjtuCr7YZfl9MaXv4yGLio
	Nh7Z6N/0JuoKgC7bhnyru3QJ187b0ZCZgju+BxfKjylpBVvfSqPA5Pk2/DuFT9AW4FCpySw15EQ
	Yx+uV5GOFuttsNeV2fS16O03LvGM=
X-Google-Smtp-Source: AGHT+IFAeSNOIfy/2dbwdxOeBtdP326CYc8A99zX8dkPv/Xf8wLRrORzpLTjR1jyey9jI1kjM6zBRPIrF8/P5ZbO69w=
X-Received: by 2002:a05:6a00:4b52:b0:71e:4296:2e with SMTP id
 d2e1a72fcca58-72062fb87b7mr18253293b3a.11.1730239121111; Tue, 29 Oct 2024
 14:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com> <20241029002208.1947947-2-dolinux.peng@gmail.com>
In-Reply-To: <20241029002208.1947947-2-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 14:58:27 -0700
Message-ID: <CAEf4BzbVjkhtQPcsDOLX_aR_vvB1nCQj357EQ5xwey8486=Niw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] libbpf: Sort btf_types in ascending order by name
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> To enhance the searching performance of btf_find_by_name_kind, we
> can sort the btf_types in ascending order based on their names.
> This allows us to implement a binary search method.
>
> Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
> v4:
>  - Divide the patch into two parts: kernel and libbpf
>  - Use Eduard's code to sort btf_types in the btf__dedup function
>  - Correct some btf testcases due to modifications of the order of btf_ty=
pes.
> ---
>  tools/lib/bpf/btf.c                           | 115 +++++--
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 296 +++++++++---------
>  .../bpf/prog_tests/btf_dedup_split.c          |  64 ++--
>  3 files changed, 268 insertions(+), 207 deletions(-)
>

I don't think we should do any extra sorting by default. Maybe we need
some extra API to explicitly re-sort underlying types. But then again,
why just by type name? What if type names are equal, what do we use to
disambiguate. None of this is considered in this patch.

pw-bot: cr

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3c131039c523..5290e9d59997 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  /* Copyright (c) 2018 Facebook */
>
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <byteswap.h>
>  #include <endian.h>
>  #include <stdio.h>
> @@ -4902,6 +4905,49 @@ static int btf_dedup_resolve_fwds(struct btf_dedup=
 *d)
>         return err;
>  }
>
> +/* compare btf types by name, consider named < anonymous */
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)
> +{
> +       struct btf *btf =3D (struct btf *)priv;
> +       struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +       struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +       const char *na, *nb;
> +
> +       /* ta w/o name is greater than tb */
> +       if (!ta->name_off && tb->name_off)
> +               return 1;
> +       /* tb w/o name is smaller than ta */
> +       if (ta->name_off && !tb->name_off)
> +               return -1;
> +
> +       na =3D btf__str_by_offset(btf, ta->name_off);
> +       nb =3D btf__str_by_offset(btf, tb->name_off);
> +       return strcmp(na, nb);
> +}
> +
> +static __u32 *get_sorted_canon_types(struct btf_dedup *d, __u32 *cnt)
> +{
> +       int i, j, id, types_cnt =3D 0;
> +       __u32 *sorted_ids;
> +
> +       for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i++,=
 id++)
> +               if (d->map[id] =3D=3D id)
> +                       ++types_cnt;
> +
> +       sorted_ids =3D calloc(types_cnt, sizeof(*sorted_ids));
> +       if (!sorted_ids)
> +               return NULL;
> +
> +       for (j =3D 0, i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_ty=
pes; i++, id++)
> +               if (d->map[id] =3D=3D id)
> +                       sorted_ids[j++] =3D id;
> +       qsort_r(sorted_ids, types_cnt, sizeof(*sorted_ids),
> +               btf_compare_type_names, d->btf);
> +       *cnt =3D types_cnt;
> +
> +       return sorted_ids;
> +}
> +
>  /*
>   * Compact types.
>   *
> @@ -4915,11 +4961,11 @@ static int btf_dedup_resolve_fwds(struct btf_dedu=
p *d)
>   */
>  static int btf_dedup_compact_types(struct btf_dedup *d)
>  {
> -       __u32 *new_offs;
> -       __u32 next_type_id =3D d->btf->start_id;
> +       __u32 canon_types_cnt =3D 0, canon_types_len =3D 0;
> +       __u32 *new_offs =3D NULL, *canon_types =3D NULL;
>         const struct btf_type *t;
> -       void *p;
> -       int i, id, len;
> +       void *p, *new_types =3D NULL;
> +       int i, id, len, err;
>
>         /* we are going to reuse hypot_map to store compaction remapping =
*/
>         d->hypot_map[0] =3D 0;
> @@ -4929,36 +4975,61 @@ static int btf_dedup_compact_types(struct btf_ded=
up *d)
>         for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i++,=
 id++)
>                 d->hypot_map[id] =3D BTF_UNPROCESSED_ID;
>
> -       p =3D d->btf->types_data;
> -
> -       for (i =3D 0, id =3D d->btf->start_id; i < d->btf->nr_types; i++,=
 id++) {
> -               if (d->map[id] !=3D id)
> -                       continue;
> +       canon_types =3D get_sorted_canon_types(d, &canon_types_cnt);
> +       if (!canon_types) {
> +               err =3D -ENOMEM;
> +               goto out_err;
> +       }
>
> +       for (i =3D 0; i < canon_types_cnt; i++) {
> +               id =3D canon_types[i];
>                 t =3D btf__type_by_id(d->btf, id);
>                 len =3D btf_type_size(t);
> -               if (len < 0)
> -                       return len;
> +               if (len < 0) {
> +                       err =3D len;
> +                       goto out_err;
> +               }
> +               canon_types_len +=3D len;
> +       }
> +
> +       new_offs =3D calloc(canon_types_cnt, sizeof(*new_offs));
> +       new_types =3D calloc(canon_types_len, 1);
> +       if (!new_types || !new_offs) {
> +               err =3D -ENOMEM;
> +               goto out_err;
> +       }
>
> -               memmove(p, t, len);
> -               d->hypot_map[id] =3D next_type_id;
> -               d->btf->type_offs[next_type_id - d->btf->start_id] =3D p =
- d->btf->types_data;
> +       p =3D new_types;
> +
> +       for (i =3D 0; i < canon_types_cnt; i++) {
> +               id =3D canon_types[i];
> +               t =3D btf__type_by_id(d->btf, id);
> +               len =3D btf_type_size(t);
> +               memcpy(p, t, len);
> +               d->hypot_map[id] =3D d->btf->start_id + i;
> +               new_offs[i] =3D p - new_types;
>                 p +=3D len;
> -               next_type_id++;
>         }
>
>         /* shrink struct btf's internal types index and update btf_header=
 */
> -       d->btf->nr_types =3D next_type_id - d->btf->start_id;
> -       d->btf->type_offs_cap =3D d->btf->nr_types;
> -       d->btf->hdr->type_len =3D p - d->btf->types_data;
> -       new_offs =3D libbpf_reallocarray(d->btf->type_offs, d->btf->type_=
offs_cap,
> -                                      sizeof(*new_offs));
> -       if (d->btf->type_offs_cap && !new_offs)
> -               return -ENOMEM;
> +       free(d->btf->types_data);
> +       free(d->btf->type_offs);
> +       d->btf->types_data =3D new_types;
>         d->btf->type_offs =3D new_offs;
> +       d->btf->types_data_cap =3D canon_types_len;
> +       d->btf->type_offs_cap =3D canon_types_cnt;
> +       d->btf->nr_types =3D canon_types_cnt;
> +       d->btf->hdr->type_len =3D canon_types_len;
>         d->btf->hdr->str_off =3D d->btf->hdr->type_len;
>         d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->type_len=
 + d->btf->hdr->str_len;
> +       free(canon_types);
>         return 0;
> +
> +out_err:
> +       free(canon_types);
> +       free(new_types);
> +       free(new_offs);
> +       return err;
>  }
>
>  /*
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index e63d74ce046f..4dc1e2bfacbb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -7025,26 +7025,26 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),              =
               /* [1] */
>                         /* int */
> -                       BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, =
32, 4),        /* [1] */
> -                       /* int[16] */
> -                       BTF_TYPE_ARRAY_ENC(1, 1, 16),                    =
               /* [2] */
> +                       BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, =
32, 4),        /* [2] */
>                         /* struct s { */
>                         BTF_STRUCT_ENC(NAME_NTH(8), 5, 88),              =
               /* [3] */
> -                               BTF_MEMBER_ENC(NAME_NTH(7), 4, 0),      /=
* struct s *next;      */
> -                               BTF_MEMBER_ENC(NAME_NTH(1), 5, 64),     /=
* const int *a;        */
> -                               BTF_MEMBER_ENC(NAME_NTH(2), 2, 128),    /=
* int b[16];           */
> -                               BTF_MEMBER_ENC(NAME_NTH(3), 1, 640),    /=
* int c;               */
> -                               BTF_MEMBER_ENC(NAME_NTH(4), 9, 672),    /=
* float d;             */
> +                               BTF_MEMBER_ENC(NAME_NTH(7), 7, 0),      /=
* struct s *next;      */
> +                               BTF_MEMBER_ENC(NAME_NTH(1), 8, 64),     /=
* const int *a;        */
> +                               BTF_MEMBER_ENC(NAME_NTH(2), 6, 128),    /=
* int b[16];           */
> +                               BTF_MEMBER_ENC(NAME_NTH(3), 2, 640),    /=
* int c;               */
> +                               BTF_MEMBER_ENC(NAME_NTH(4), 1, 672),    /=
* float d;             */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),            =
               /* [4] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),             =
               /* [5] */
> +                       /* int[16] */
> +                       BTF_TYPE_ARRAY_ENC(1, 2, 16),                    =
               /* [6] */
>                         /* ptr -> [3] struct s */
> -                       BTF_PTR_ENC(3),                                  =
               /* [4] */
> +                       BTF_PTR_ENC(3),                                  =
               /* [7] */
>                         /* ptr -> [6] const int */
> -                       BTF_PTR_ENC(6),                                  =
               /* [5] */
> +                       BTF_PTR_ENC(9),                                  =
               /* [8] */
>                         /* const -> [1] int */
> -                       BTF_CONST_ENC(1),                                =
               /* [6] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),            =
               /* [7] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(2), 3, 1),             =
               /* [8] */
> -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),              =
               /* [9] */
> +                       BTF_CONST_ENC(2),                                =
               /* [9] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0a\0b\0c\0d\0int\0float\0next\0s"),
> @@ -7082,10 +7082,10 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       BTF_PTR_ENC(3),                                 /=
* [1] ptr -> [3] */
> -                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                 /=
* [2] struct s   */
> -                               BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> -                       BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),              /=
* [3] struct x   */
> +                       BTF_STRUCT_ENC(NAME_TBD, 1, 8),                 /=
* [1] struct s   */
> +                               BTF_MEMBER_ENC(NAME_TBD, 3, 0),
> +                       BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),              /=
* [2] struct x   */
> +                       BTF_PTR_ENC(2),                                 /=
* [3] ptr -> [3] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0s\0x"),
> @@ -7123,15 +7123,13 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       /* CU 1 */
> -                       BTF_STRUCT_ENC(0, 0, 1),                         =
       /* [1] struct {}  */
> -                       BTF_PTR_ENC(1),                                  =
       /* [2] ptr -> [1] */
> -                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),               =
       /* [3] struct s   */
> -                               BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> -                       /* CU 2 */
> -                       BTF_PTR_ENC(0),                                  =
       /* [4] ptr -> void */
> -                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),               =
       /* [5] struct s   */
> +                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),               =
       /* [1] struct s   */
>                                 BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
> +                       BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),               =
       /* [2] struct s   */
> +                               BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
> +                       BTF_STRUCT_ENC(0, 0, 1),                         =
       /* [3] struct {}  */
> +                       BTF_PTR_ENC(3),                                  =
       /* [5] ptr -> [1] */
> +                       BTF_PTR_ENC(0),                                  =
       /* [4] ptr -> void */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0s\0x"),
> @@ -7182,28 +7180,28 @@ static struct btf_dedup_test dedup_tests[] =3D {
>                                 BTF_ENUM_ENC(NAME_TBD, 0),
>                                 BTF_ENUM_ENC(NAME_TBD, 1),
>                         BTF_FWD_ENC(NAME_TBD, 1 /* union kind_flag */),  =
               /* [3] fwd */
> -                       BTF_TYPE_ARRAY_ENC(2, 1, 7),                     =
               /* [4] array */
> -                       BTF_STRUCT_ENC(NAME_TBD, 1, 4),                  =
               /* [5] struct */
> +                       BTF_STRUCT_ENC(NAME_TBD, 1, 4),                  =
               /* [4] struct */
>                                 BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> -                       BTF_UNION_ENC(NAME_TBD, 1, 4),                   =
               /* [6] union */
> +                       BTF_UNION_ENC(NAME_TBD, 1, 4),                   =
               /* [5] union */
>                                 BTF_MEMBER_ENC(NAME_TBD, 1, 0),
> -                       BTF_TYPEDEF_ENC(NAME_TBD, 1),                    =
               /* [7] typedef */
> -                       BTF_PTR_ENC(0),                                  =
               /* [8] ptr */
> -                       BTF_CONST_ENC(8),                                =
               /* [9] const */
> -                       BTF_VOLATILE_ENC(8),                             =
               /* [10] volatile */
> -                       BTF_RESTRICT_ENC(8),                             =
               /* [11] restrict */
> -                       BTF_FUNC_PROTO_ENC(1, 2),                        =
               /* [12] func_proto */
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
> -                       BTF_FUNC_ENC(NAME_TBD, 12),                      =
               /* [13] func */
> -                       BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                 =
               /* [14] float */
> -                       BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),              =
               /* [15] decl_tag */
> -                       BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),               =
               /* [16] decl_tag */
> -                       BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),               =
               /* [17] decl_tag */
> -                       BTF_TYPE_TAG_ENC(NAME_TBD, 8),                   =
               /* [18] type_tag */
> -                       BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM=
64, 0, 2), 8), /* [19] enum64 */
> +                       BTF_TYPEDEF_ENC(NAME_TBD, 1),                    =
               /* [6] typedef */
> +                       BTF_FUNC_ENC(NAME_TBD, 19),                      =
               /* [7] func */
> +                       BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                 =
               /* [8] float */
> +                       BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),               =
               /* [9] decl_tag */
> +                       BTF_DECL_TAG_ENC(NAME_TBD, 7, 1),                =
               /* [10] decl_tag */
> +                       BTF_DECL_TAG_ENC(NAME_TBD, 6, -1),               =
               /* [11] decl_tag */
> +                       BTF_TYPE_TAG_ENC(NAME_TBD, 15),                  =
               /* [12] type_tag */
> +                       BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM=
64, 0, 2), 8), /* [13] enum64 */
>                                 BTF_ENUM64_ENC(NAME_TBD, 0, 0),
>                                 BTF_ENUM64_ENC(NAME_TBD, 1, 1),
> +                       BTF_TYPE_ARRAY_ENC(2, 2, 7),                     =
               /* [14] array */
> +                       BTF_PTR_ENC(0),                                  =
               /* [15] ptr */
> +                       BTF_CONST_ENC(15),                               =
               /* [16] const */
> +                       BTF_VOLATILE_ENC(15),                            =
               /* [17] volatile */
> +                       BTF_RESTRICT_ENC(15),                            =
               /* [18] restrict */
> +                       BTF_FUNC_PROTO_ENC(1, 2),                        =
               /* [19] func_proto */
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 12),
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0=
O\0P\0Q\0R\0S\0T\0U"),
> @@ -7237,9 +7235,14 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> +                       /* all allowed sizes */
> +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
> +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
> +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
> +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
> +                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
> +
>                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 8),
> -                       /* different name */
> -                       BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, =
32, 8),
>                         /* different encoding */
>                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_CHAR, 0, 32=
, 8),
>                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_BOOL, 0, 32=
, 8),
> @@ -7249,12 +7252,8 @@ static struct btf_dedup_test dedup_tests[] =3D {
>                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
27, 8),
>                         /* different byte size */
>                         BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4),
> -                       /* all allowed sizes */
> -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
> -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
> -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
> -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
> -                       BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
> +                       /* different name */
> +                       BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, =
32, 8),
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0int\0some other int\0float"),
> @@ -7323,18 +7322,18 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       /* int */
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       /* static int t */
> -                       BTF_VAR_ENC(NAME_NTH(2), 1, 0),                 /=
* [2] */
> -                       /* .bss section */                              /=
* [3] */
> +                       /* .bss section */                              /=
* [1] */
>                         BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_D=
ATASEC, 0, 1), 4),
> -                       BTF_VAR_SECINFO_ENC(2, 0, 4),
> -                       /* another static int t */
> -                       BTF_VAR_ENC(NAME_NTH(2), 1, 0),                 /=
* [4] */
> -                       /* another .bss section */                      /=
* [5] */
> +                       BTF_VAR_SECINFO_ENC(3, 0, 4),
> +                       /* another .bss section */                      /=
* [2] */
>                         BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_D=
ATASEC, 0, 1), 4),
>                         BTF_VAR_SECINFO_ENC(4, 0, 4),
> +                       /* static int t */
> +                       BTF_VAR_ENC(NAME_NTH(2), 5, 0),                 /=
* [3] */
> +                       /* another static int t */
> +                       BTF_VAR_ENC(NAME_NTH(2), 5, 0),                 /=
* [4] */
> +                       /* int */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [5] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0.bss\0t"),
> @@ -7371,15 +7370,15 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_VAR_ENC(NAME_NTH(1), 1, 0),                 /=
* [2] */
> -                       BTF_FUNC_PROTO_ENC(0, 2),                       /=
* [3] */
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
> -                       BTF_FUNC_ENC(NAME_NTH(4), 3),                   /=
* [4] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),           /=
* [5] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 4, -1),           /=
* [6] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 4, 1),            /=
* [7] */
> +                       BTF_FUNC_ENC(NAME_NTH(4), 7),                   /=
* [1] */
> +                       BTF_VAR_ENC(NAME_NTH(1), 6, 0),                 /=
* [2] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),           /=
* [3] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),           /=
* [4] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),            /=
* [5] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [6] */
> +                       BTF_FUNC_PROTO_ENC(0, 2),                       /=
* [7] */
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 6),
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 6),
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
> @@ -7419,17 +7418,17 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_FUNC_PROTO_ENC(0, 2),                       /=
* [2] */
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
> -                       BTF_FUNC_ENC(NAME_NTH(3), 2),                   /=
* [3] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),           /=
* [4] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 3, -1),           /=
* [5] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 3, -1),           /=
* [6] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 3, 1),            /=
* [7] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 3, 1),            /=
* [8] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 3, 1),            /=
* [9] */
> +                       BTF_FUNC_ENC(NAME_NTH(3), 9),                   /=
* [1] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),           /=
* [2] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),            /=
* [3] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),           /=
* [4] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),            /=
* [5] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),           /=
* [6] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),            /=
* [7] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [8] */
> +                       BTF_FUNC_PROTO_ENC(0, 2),                       /=
* [9] */
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 8),
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 8),
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
> @@ -7465,16 +7464,16 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),              /=
* [2] */
> -                               BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
> -                               BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
> -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),           /=
* [3] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, -1),           /=
* [4] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 2, -1),           /=
* [5] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 2, 1),            /=
* [6] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(5), 2, 1),            /=
* [7] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(6), 2, 1),            /=
* [8] */
> +                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),              /=
* [1] */
> +                               BTF_MEMBER_ENC(NAME_NTH(2), 8, 0),
> +                               BTF_MEMBER_ENC(NAME_NTH(3), 8, 32),
> +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),           /=
* [2] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, 1),            /=
* [3] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, -1),           /=
* [4] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(5), 1, 1),            /=
* [5] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, -1),           /=
* [6] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(6), 1, 1),            /=
* [7] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [8] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> @@ -7500,11 +7499,11 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_TYPEDEF_ENC(NAME_NTH(1), 1),                /=
* [2] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(2), 2, -1),           /=
* [3] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(3), 2, -1),           /=
* [4] */
> -                       BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),           /=
* [5] */
> +                       BTF_TYPEDEF_ENC(NAME_NTH(1), 5),                /=
* [1] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(2), 1, -1),           /=
* [2] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(3), 1, -1),           /=
* [3] */
> +                       BTF_DECL_TAG_ENC(NAME_NTH(4), 1, -1),           /=
* [4] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [5] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
> @@ -7533,12 +7532,12 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         .expect =3D {
>                 .raw_types =3D {
>                         /* ptr -> tag2 -> tag1 -> int */
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /=
* [2] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /=
* [3] */
> -                       BTF_PTR_ENC(3),                                 /=
* [4] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),               /=
* [1] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),               /=
* [2] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [3] */
> +                       BTF_PTR_ENC(2),                                 /=
* [4] */
>                         /* ptr -> tag1 -> int */
> -                       BTF_PTR_ENC(2),                                 /=
* [5] */
> +                       BTF_PTR_ENC(1),                                 /=
* [5] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0tag1\0tag2"),
> @@ -7563,13 +7562,13 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         .expect =3D {
>                 .raw_types =3D {
>                         /* ptr -> tag2 -> tag1 -> int */
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /=
* [2] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /=
* [3] */
> -                       BTF_PTR_ENC(3),                                 /=
* [4] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),               /=
* [1] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),               /=
* [2] */
>                         /* ptr -> tag2 -> int */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),               /=
* [5] */
> -                       BTF_PTR_ENC(5),                                 /=
* [6] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 4),               /=
* [3] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [4] */
> +                       BTF_PTR_ENC(2),                                 /=
* [5] */
> +                       BTF_PTR_ENC(3),                                 /=
* [6] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0tag1\0tag2"),
> @@ -7594,15 +7593,13 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       /* ptr -> tag2 -> tag1 -> int */
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /=
* [2] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /=
* [3] */
> -                       BTF_PTR_ENC(3),                                 /=
* [4] */
> -                       /* ptr -> tag1 -> tag2 -> int */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),               /=
* [5] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),               /=
* [6] */
> -                       BTF_PTR_ENC(6),                                 /=
* [7] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),               /=
* [1] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),               /=
* [2] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),               /=
* [3] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),               /=
* [4] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [5] */
> +                       BTF_PTR_ENC(3),                                 /=
* [6] */
> +                       BTF_PTR_ENC(2),                                 /=
* [7] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0tag1\0tag2"),
> @@ -7626,14 +7623,12 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       /* ptr -> tag1 -> int */
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [1] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /=
* [2] */
> -                       BTF_PTR_ENC(2),                                 /=
* [3] */
> -                       /* ptr -> tag1 -> long */
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /=
* [4] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),               /=
* [5] */
> -                       BTF_PTR_ENC(5),                                 /=
* [6] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),               /=
* [1] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),               /=
* [2] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /=
* [3] */
> +                       BTF_PTR_ENC(1),                                 /=
* [4] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /=
* [5] */
> +                       BTF_PTR_ENC(2),                                 /=
* [6] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0tag1"),
> @@ -7656,10 +7651,10 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),   =
                       /* [1] */
> -                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),                =
                       /* [2] */
> -                       BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_S=
TRUCT, 1, 1), 4),      /* [3] */
> +                       BTF_TYPE_ENC(NAME_NTH(2), BTF_INFO_ENC(BTF_KIND_S=
TRUCT, 1, 1), 4),      /* [1] */
>                         BTF_MEMBER_ENC(NAME_NTH(3), 2, BTF_MEMBER_OFFSET(=
0, 0)),
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 3),                =
                       /* [2] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),   =
                       /* [3] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0tag1\0t\0m"),
> @@ -7861,10 +7856,10 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         .expect =3D {
>                 .raw_types =3D {
>                         BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /*=
 [1] */
> -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [2] */
> -                       BTF_PTR_ENC(1),                                /*=
 [3] */
> -                       BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               /*=
 [4] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 3, 0),
> +                       BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /*=
 [2] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [3] */
> +                       BTF_PTR_ENC(1),                                /*=
 [4] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0foo\0x\0foo_ptr"),
> @@ -7901,10 +7896,10 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         .expect =3D {
>                 .raw_types =3D {
>                         BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /*=
 [1] */
> -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [2] */
> -                       BTF_PTR_ENC(1),                                /*=
 [3] */
> -                       BTF_TYPEDEF_ENC(NAME_NTH(3), 3),               /*=
 [4] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 3, 0),
> +                       BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /*=
 [2] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [3] */
> +                       BTF_PTR_ENC(1),                                /*=
 [4] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0foo\0x\0foo_ptr"),
> @@ -7940,14 +7935,12 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       /* CU 1 */
>                         BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /*=
 [1] */
> -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [2] */
> -                       /* CU 2 */
> -                       BTF_FWD_ENC(NAME_NTH(3), 1),                   /*=
 [3] */
> -                       BTF_PTR_ENC(3),                                /*=
 [4] */
> -                       BTF_TYPEDEF_ENC(NAME_NTH(3), 4),               /*=
 [5] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
> +                       BTF_FWD_ENC(NAME_NTH(3), 1),                   /*=
 [2] */
> +                       BTF_TYPEDEF_ENC(NAME_NTH(3), 5),               /*=
 [3] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [4] */
> +                       BTF_PTR_ENC(2),                                /*=
 [5] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0foo\0x\0foo_ptr"),
> @@ -7990,18 +7983,15 @@ static struct btf_dedup_test dedup_tests[] =3D {
>         },
>         .expect =3D {
>                 .raw_types =3D {
> -                       /* CU 1 */
>                         BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /*=
 [1] */
> -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> -                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [2] */
> -                       /* CU 2 */
> -                       BTF_FWD_ENC(NAME_NTH(1), 0),                   /*=
 [3] */
> -                       BTF_PTR_ENC(3),                                /*=
 [4] */
> -                       BTF_TYPEDEF_ENC(NAME_NTH(4), 4),               /*=
 [5] */
> -                       /* CU 3 */
> -                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /*=
 [6] */
> -                       BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> -                       BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
> +                       BTF_FWD_ENC(NAME_NTH(1), 0),                   /*=
 [2] */
> +                       BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /*=
 [3] */
> +                       BTF_MEMBER_ENC(NAME_NTH(2), 5, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(3), 5, 0),
> +                       BTF_TYPEDEF_ENC(NAME_NTH(4), 6),               /*=
 [4] */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /*=
 [5] */
> +                       BTF_PTR_ENC(2),                                /*=
 [6] */
>                         BTF_END_RAW,
>                 },
>                 BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/t=
ools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> index d9024c7a892a..e50c290b2d8c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> @@ -311,18 +311,18 @@ static void test_split_struct_duped() {
>                 "[5] STRUCT 's1' size=3D16 vlen=3D2\n"
>                 "\t'f1' type_id=3D2 bits_offset=3D0\n"
>                 "\t'f2' type_id=3D4 bits_offset=3D64",
> -               "[6] PTR '(anon)' type_id=3D8",
> -               "[7] PTR '(anon)' type_id=3D9",
> -               "[8] STRUCT 's1' size=3D16 vlen=3D2\n"
> -               "\t'f1' type_id=3D6 bits_offset=3D0\n"
> -               "\t'f2' type_id=3D7 bits_offset=3D64",
> -               "[9] STRUCT 's2' size=3D40 vlen=3D4\n"
> -               "\t'f1' type_id=3D6 bits_offset=3D0\n"
> -               "\t'f2' type_id=3D7 bits_offset=3D64\n"
> +               "[6] STRUCT 's1' size=3D16 vlen=3D2\n"
> +               "\t'f1' type_id=3D9 bits_offset=3D0\n"
> +               "\t'f2' type_id=3D10 bits_offset=3D64",
> +               "[7] STRUCT 's2' size=3D40 vlen=3D4\n"
> +               "\t'f1' type_id=3D9 bits_offset=3D0\n"
> +               "\t'f2' type_id=3D10 bits_offset=3D64\n"
>                 "\t'f3' type_id=3D1 bits_offset=3D128\n"
> -               "\t'f4' type_id=3D8 bits_offset=3D192",
> -               "[10] STRUCT 's3' size=3D8 vlen=3D1\n"
> -               "\t'f1' type_id=3D7 bits_offset=3D0");
> +               "\t'f4' type_id=3D6 bits_offset=3D192",
> +               "[8] STRUCT 's3' size=3D8 vlen=3D1\n"
> +               "\t'f1' type_id=3D10 bits_offset=3D0",
> +               "[9] PTR '(anon)' type_id=3D6",
> +               "[10] PTR '(anon)' type_id=3D7");
>
>  cleanup:
>         btf__free(btf2);
> @@ -385,13 +385,13 @@ static void test_split_dup_struct_in_cu()
>
>         VALIDATE_RAW_BTF(
>                         btf1,
> -                       "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> -                       "[2] STRUCT 's' size=3D8 vlen=3D2\n"
> -                       "\t'a' type_id=3D3 bits_offset=3D0\n"
> -                       "\t'b' type_id=3D3 bits_offset=3D0",
> -                       "[3] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> -                       "\t'f1' type_id=3D1 bits_offset=3D0\n"
> -                       "\t'f2' type_id=3D1 bits_offset=3D32");
> +                       "[1] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> +                       "\t'f1' type_id=3D2 bits_offset=3D0\n"
> +                       "\t'f2' type_id=3D2 bits_offset=3D32",
> +                       "[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> +                       "[3] STRUCT 's' size=3D8 vlen=3D2\n"
> +                       "\t'a' type_id=3D1 bits_offset=3D0\n"
> +                       "\t'b' type_id=3D1 bits_offset=3D0");
>
>         /* and add the same data on top of it */
>         btf2 =3D btf__new_empty_split(btf1);
> @@ -402,13 +402,13 @@ static void test_split_dup_struct_in_cu()
>
>         VALIDATE_RAW_BTF(
>                         btf2,
> -                       "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> -                       "[2] STRUCT 's' size=3D8 vlen=3D2\n"
> -                       "\t'a' type_id=3D3 bits_offset=3D0\n"
> -                       "\t'b' type_id=3D3 bits_offset=3D0",
> -                       "[3] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> -                       "\t'f1' type_id=3D1 bits_offset=3D0\n"
> -                       "\t'f2' type_id=3D1 bits_offset=3D32",
> +                       "[1] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> +                       "\t'f1' type_id=3D2 bits_offset=3D0\n"
> +                       "\t'f2' type_id=3D2 bits_offset=3D32",
> +                       "[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> +                       "[3] STRUCT 's' size=3D8 vlen=3D2\n"
> +                       "\t'a' type_id=3D1 bits_offset=3D0\n"
> +                       "\t'b' type_id=3D1 bits_offset=3D0",
>                         "[4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
>                         "[5] STRUCT 's' size=3D8 vlen=3D2\n"
>                         "\t'a' type_id=3D6 bits_offset=3D0\n"
> @@ -427,13 +427,13 @@ static void test_split_dup_struct_in_cu()
>         /* after dedup it should match the original data */
>         VALIDATE_RAW_BTF(
>                         btf2,
> -                       "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> -                       "[2] STRUCT 's' size=3D8 vlen=3D2\n"
> -                       "\t'a' type_id=3D3 bits_offset=3D0\n"
> -                       "\t'b' type_id=3D3 bits_offset=3D0",
> -                       "[3] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> -                       "\t'f1' type_id=3D1 bits_offset=3D0\n"
> -                       "\t'f2' type_id=3D1 bits_offset=3D32");
> +                       "[1] STRUCT '(anon)' size=3D8 vlen=3D2\n"
> +                       "\t'f1' type_id=3D2 bits_offset=3D0\n"
> +                       "\t'f2' type_id=3D2 bits_offset=3D32",
> +                       "[2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=
=3D32 encoding=3DSIGNED",
> +                       "[3] STRUCT 's' size=3D8 vlen=3D2\n"
> +                       "\t'a' type_id=3D1 bits_offset=3D0\n"
> +                       "\t'b' type_id=3D1 bits_offset=3D0");
>
>  cleanup:
>         btf__free(btf2);
> --
> 2.34.1
>

