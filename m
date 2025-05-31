Return-Path: <linux-kselftest+bounces-34110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C96AC9C3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D9C189DF6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00619994F;
	Sat, 31 May 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+Krn0nL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715C18A6AB;
	Sat, 31 May 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748715659; cv=none; b=W0ETPb3YnvFsVsmZc4SugYpI76EvsarXWybOt+vOCC0As9FVcYlG/MhYVH6TiUOf9AbEWGMT0+ifECCck7HXY03Y6hsVxmZGnyOggXdxoF+rVeqJqkSbLm7If+X77NiUExWGBQphfldrux/ZccLZqAO9hcgliHBpRui2HxLLjkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748715659; c=relaxed/simple;
	bh=yTB6ILh//9sUZheSjS8C50WfSbZJwBQivokHXQ+fG8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiX4n5ixyNOmO4cqSVBT862kjeHSNlj8Hi7sXviA4C8rvlzC+K6aedKyHZZgQepldQ4sckPgxpprjYYs8LLSCz6FOhLhn2Qn5mmCkZCoOJsoAXDNlCDQtmDxNtCCpGP4GbOKUKVl0DcV+l3X7tcZqoWf2w89PDw2uyqDO8iYNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+Krn0nL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a37a243388so2601395f8f.1;
        Sat, 31 May 2025 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748715656; x=1749320456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=893//7LDv+YpPFUWMC5jDuhaOQv7eaFVPiT/txoSWcQ=;
        b=b+Krn0nL2/8ar2ZLDb0pDvKs+P599VQCvR8c9NEIvFetS1Qo+MRF0GF/ZZhdROJEK2
         mIO6478l4mdgpqRoMKd6XoGeJ9vJCrB5fz+YItG652ot8WAXEEfNGrmuLrnU4loNulsf
         65V25AOby/vfHWNe5gXu65BU//TXFLN17YZ2ips9MXZpjt94Gro1R3nS2kc6FqzZZ7ME
         gVwoA1sIX8+nUHvgiSJW4WJmmXC8oDaQSLJC10BTkjZl53hXSGycNzu4HATj2xU7NBfi
         4wPr0A0eDEdts+eufPNjlta6/XZsggy/bQc2tFhWXJXkVGnuWTvz4hXUfn1Lh38UJQCJ
         K+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748715656; x=1749320456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=893//7LDv+YpPFUWMC5jDuhaOQv7eaFVPiT/txoSWcQ=;
        b=mf8enLs0mOLEnmjxanfBxuzmNgyg939H1ka2SGEt+oKjzweppSL2qVkUkdnhukJTac
         KFDgqBJQEq6lvY2BKKIKMop7PmcvbBU16DvxOKMrkDzKSPCPKufmItRDCNii1dqC/3Ej
         w849flgpOUAUX6SqsW46gR1AiIs71lk+tzttCQ8Imuft4bLBTd91HB7HwyJWPQDYkmD5
         63+zsjYUfZv+DgHIrf4OJiVYVkDy1M95EJiWcFL97Uh1O56uss8IfXaU7v/cd2qdRETl
         oI5QaRONVJ/BzjHnOm8Atd7pXbUoqTflpsIPZzp9rpGC8Dpa1afyMUiv5h8CFFHPYDm3
         NJIw==
X-Forwarded-Encrypted: i=1; AJvYcCUTMMjFUqQu8iiJnSht6R/9e/ol/JWAjjN9aSw9EBUiw1tALQRl0GP+rnXcPh2A/lyHMbfv4WmMwN/e+36EpoY8@vger.kernel.org, AJvYcCUxqDCpQTpsbb8V4SmcgtOoFwc6V1uOfd9BUTYLmFqpAsOS5PQ6+tbcLKSjDKxv/9JVxXtXxjyXI5q8j58L@vger.kernel.org, AJvYcCVhFdJfLmyv93hdJn3bKdCIQcORaNJ43AB1eAhwM+5i7tqQYheqYLzcqMdTeitIYM5G1so=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUFxb7WbJG8P3JwkH9sl4tF7QWI3RARArPkbrUMo/2lAUYHLe
	IWgUus83w8saKlWxpJ6oh+o9B1LxOVNzSSn8synOFQCKZhqvy6/nvW84v/0ckt01NgSQBTGuQHX
	GzrCMvZLOZlDYa/PVcB5hCV0w+TjvdcA=
X-Gm-Gg: ASbGncvosOM2Wcub56MHRTN/4h14YTgZVdivbD5yFlbEmlzTx4EerS5vOGjWhs/0QDR
	Cn02uFVWcf9cy0qg0kAkblVmIYRVAQr6YYkIX7BlxL8qZKriVuwtbVgbyLJ0f88zwtOA9zSeBqK
	jdYgkb4Ad28/eXfLlIcyq6cH+69qNM6JBtF6nVNm4ZarnEltXHx9e6F7Zhqrl+QRo7zWRRfqwZ
X-Google-Smtp-Source: AGHT+IHJxIu9TBQmNHqViak7fsIR4nbbBhAZKgeip16A6BdM4LVd2e78MLa6R2/OBco09mDrw4CHu1bn66HkgGSmoEs=
X-Received: by 2002:a05:6000:220b:b0:3a4:ef00:a7bb with SMTP id
 ffacd0b85a97d-3a4f7a4d637mr6114187f8f.18.1748715655714; Sat, 31 May 2025
 11:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com>
In-Reply-To: <20250531072031.2263491-1-blakejones@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 31 May 2025 11:20:44 -0700
X-Gm-Features: AX0GCFvltGjmsI8OGe-VYG8Sc2oEh7-lCIwcagbY18dyLq8FvOpjNdxoRO8kCDc
Message-ID: <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 12:20=E2=80=AFAM Blake Jones <blakejones@google.com=
> wrote:
>
> The BTF dumper code currently displays arrays of characters as just that =
-
> arrays, with each character formatted individually. Sometimes this is wha=
t
> makes sense, but it's nice to be able to treat that array as a string.
>
> This change adds a special case to the btf_dump functionality to allow
> arrays of single-byte integer values to be printed as character strings.
> Characters for which isprint() returns false are printed as hex-escaped
> values. This is enabled when the new ".print_strings" is set to 1 in the
> btf_dump_type_data_opts structure.
>
> As an example, here's what it looks like to dump the string "hello" using
> a few different field values for btf_dump_type_data_opts (.compact =3D 1)=
:
>
> - .print_strings =3D 0, .skip_names =3D 0:  (char[6])['h','e','l','l','o'=
,]
> - .print_strings =3D 0, .skip_names =3D 1:  ['h','e','l','l','o',]
> - .print_strings =3D 1, .skip_names =3D 0:  (char[6])"hello"
> - .print_strings =3D 1, .skip_names =3D 1:  "hello"
>
> Here's the string "h\xff", dumped with .compact =3D 1 and .skip_names =3D=
 1:
>
> - .print_strings =3D 0:  ['h',-1,]
> - .print_strings =3D 1:  "h\xff"
>
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/lib/bpf/btf.h                           |   3 +-
>  tools/lib/bpf/btf_dump.c                      |  51 ++++++++-
>  .../selftests/bpf/prog_tests/btf_dump.c       | 102 ++++++++++++++++++
>  3 files changed, 154 insertions(+), 2 deletions(-)

Please split selftests vs main libbpf parts.

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4392451d634b..be8e8e26d245 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
>         bool compact;           /* no newlines/indentation */
>         bool skip_names;        /* skip member/type names */
>         bool emit_zeroes;       /* show 0-valued fields */
> +       bool print_strings;     /* print char arrays as strings */
>         size_t :0;
>  };
> -#define btf_dump_type_data_opts__last_field emit_zeroes
> +#define btf_dump_type_data_opts__last_field print_strings
>
>  LIBBPF_API int
>  btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 460c3e57fadb..a07dd5accdd8 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -75,6 +75,7 @@ struct btf_dump_data {
>         bool is_array_member;
>         bool is_array_terminated;
>         bool is_array_char;
> +       bool print_strings;

Looks useful, but make sure to add a feature detection
to perf, since it has to work with old and new libbpf.

>  };
>
>  struct btf_dump {
> @@ -2028,6 +2029,50 @@ static int btf_dump_var_data(struct btf_dump *d,
>         return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>  }
>
> +static int btf_dump_string_data(struct btf_dump *d,
> +                               const struct btf_type *t,
> +                               __u32 id,
> +                               const void *data)
> +{
> +       const struct btf_array *array =3D btf_array(t);
> +       __u32 i;
> +
> +       if (!btf_is_int(skip_mods_and_typedefs(d->btf, array->type, NULL)=
) ||
> +           btf__resolve_size(d->btf, array->type) !=3D 1 ||
> +           !d->typed_dump->print_strings) {
> +               pr_warn("unexpected %s() call for array type %u\n",
> +                       __func__, array->type);
> +               return -EINVAL;
> +       }
> +
> +       btf_dump_data_pfx(d);
> +       btf_dump_printf(d, "\"");
> +
> +       for (i =3D 0; i < array->nelems; i++, data++) {
> +               char c;
> +
> +               if (data >=3D d->typed_dump->data_end)
> +                       return -E2BIG;
> +
> +               c =3D *(char *)data;
> +               if (c =3D=3D '\0') {
> +                       /* When printing character arrays as strings, NUL=
 bytes
> +                        * are always treated as string terminators; they=
 are
> +                        * never printed.
> +                        */

Please use normal kernel style comments.
We're gradually getting away from networking style.

> +                       break;
> +               }
> +               if (isprint(c))
> +                       btf_dump_printf(d, "%c", c);
> +               else
> +                       btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
> +       }
> +
> +       btf_dump_printf(d, "\"");
> +
> +       return 0;
> +}
> +
>  static int btf_dump_array_data(struct btf_dump *d,
>                                const struct btf_type *t,
>                                __u32 id,
> @@ -2055,8 +2100,11 @@ static int btf_dump_array_data(struct btf_dump *d,
>                  * char arrays, so if size is 1 and element is
>                  * printable as a char, we'll do that.
>                  */
> -               if (elem_size =3D=3D 1)
> +               if (elem_size =3D=3D 1) {
> +                       if (d->typed_dump->print_strings)
> +                               return btf_dump_string_data(d, t, id, dat=
a);
>                         d->typed_dump->is_array_char =3D true;
> +               }
>         }
>
>         /* note that we increment depth before calling btf_dump_print() b=
elow;
> @@ -2544,6 +2592,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __=
u32 id,
>         d->typed_dump->compact =3D OPTS_GET(opts, compact, false);
>         d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, false);
>         d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes, false)=
;
> +       d->typed_dump->print_strings =3D OPTS_GET(opts, print_strings, fa=
lse);
>
>         ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index c0a776feec23..70e51943f148 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -879,6 +879,106 @@ static void test_btf_dump_var_data(struct btf *btf,=
 struct btf_dump *d,
>                           "static int bpf_cgrp_storage_busy =3D (int)2", =
2);
>  }
>
> +/*
> + * String-like types are generally not named, so they need to be
> + * found this way rather than via btf__find_by_name().
> + */

This is the correct style of comments.

> +static int find_char_array_type(struct btf *btf, int nelems)
> +{
> +       const int nr_types =3D btf__type_cnt(btf);
> +       const int char_type =3D btf__find_by_name(btf, "char");
> +
> +       for (int i =3D 1; i < nr_types; i++) {
> +               const struct btf_type *t;
> +               const struct btf_array *at;
> +
> +               t =3D btf__type_by_id(btf, i);
> +               if (btf_kind(t) !=3D BTF_KIND_ARRAY)
> +                       continue;
> +
> +               at =3D btf_array(t);
> +               if (at->nelems =3D=3D nelems && at->type =3D=3D char_type=
)
> +                       return i;
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +static int btf_dump_string_data(struct btf *btf, struct btf_dump *d,
> +                               char *str, struct btf_dump_type_data_opts=
 *opts,
> +                               char *ptr, size_t ptr_sz,
> +                               const char *expected_val)
> +{
> +       char name[64];
> +       size_t type_sz;
> +       int type_id;
> +       int ret =3D 0;
> +
> +       snprintf(name, sizeof(name), "char[%zu]", ptr_sz);
> +       type_id =3D find_char_array_type(btf, ptr_sz);
> +       if (!ASSERT_GE(type_id, 0, "find type id"))
> +               return -ENOENT;
> +       type_sz =3D btf__resolve_size(btf, type_id);
> +       str[0] =3D '\0';
> +       ret =3D btf_dump__dump_type_data(d, type_id, ptr, ptr_sz, opts);
> +       if (type_sz <=3D ptr_sz) {
> +               if (!ASSERT_EQ(ret, type_sz, "failed/unexpected type_sz")=
)
> +                       return -EINVAL;
> +       } else {
> +               if (!ASSERT_EQ(ret, -E2BIG, "failed to return -E2BIG"))
> +                       return -EINVAL;
> +       }
> +       if (!ASSERT_STREQ(str, expected_val, "ensure expected/actual matc=
h"))
> +               return -EFAULT;
> +       return 0;
> +}
> +
> +static void test_btf_dump_string_data(struct btf *btf, struct btf_dump *=
d,
> +                                     char *str)
> +{
> +       DECLARE_LIBBPF_OPTS(btf_dump_type_data_opts, opts);
> +
> +       opts.compact =3D true;
> +       opts.emit_zeroes =3D false;
> +       opts.print_strings =3D true;
> +
> +       opts.skip_names =3D false;
> +       btf_dump_string_data(btf, d, str, &opts, "foo", 4,
> +               "(char[4])\"foo\"");

we allow up to 100 char per line.
Don't split it that short.

pw-bot: cr

