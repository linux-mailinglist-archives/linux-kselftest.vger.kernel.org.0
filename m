Return-Path: <linux-kselftest+bounces-34189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C0ACBDDE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 02:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37BE3A3AFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782BA47;
	Tue,  3 Jun 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZkP5QJ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BB4A11;
	Tue,  3 Jun 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748909193; cv=none; b=o17xxcZsRPx90gBV0/FEg2kiSeoptUbexEoWBUkQFyTQtV+Eq17pBRH7y6Sv5tYdIpGnHuRkTDpF0HcJSA8VS9HlmwQ8MwS5Wab0xJfkhIRDrjRc1cyfuhNJkNQFtXJ1IhH6mT0rxIFmP0IAwFbBXhn//te8aSKpzqYGO4AZUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748909193; c=relaxed/simple;
	bh=+8qoe+weKX+bkyz/NlPnMh9Snq47toVITPDJ43AzyWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIm7AV2Jd+FtSTwIKozws64dFScfEdv8VnI8/ZpMHXBXMoE6lomrMlYnymb5ecD3jCxGDF+9DngNHLWUoCdg1nf2apXIE2jCV/QJ7LJKbphJXD5lV1DhlowG11VD10DAqdhNMU7swThOYjKPnMQBF4//s4ws3oeAnP9qu4mv0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZkP5QJ6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3462653a12.3;
        Mon, 02 Jun 2025 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748909190; x=1749513990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FxgkSQZ29aWrPIFEU7qhlxI1FSMTiqnVhVpudfAsaM=;
        b=dZkP5QJ6NFIBlRrr3LXlfP3KsjLu3e97Kclkg2NZB/CvG7i00/e4328/vQ32OmL3aA
         TPy2ESUIBMY3sEeakQhnCqBTPRc1yv4FLMq04M1v9UGkOXiHDXdnNj775LHLs9beq+S7
         1wqq7GvoAVrqySB0Nu745vHSADMVeEPkZtjPkq7jwZ0/Ezx++BojWWli+ReMR7J8Hi6R
         sBiF7+KTl9vNkSIQ1tqBBy/RTdYL1VY3lS0zJHpaPq5+U+dtG1IBLoiFfZbPausmd07Q
         6srkozVwhYmL76Z5ZY5TGs9OpFf5Csrd9RclTgjAa+oxmzUzPRH/b9LhsTbPUSORiVp5
         zJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748909190; x=1749513990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FxgkSQZ29aWrPIFEU7qhlxI1FSMTiqnVhVpudfAsaM=;
        b=YcpO+ObyNknZ2/gRzm2PAKlrqbsL+lZw/NFIs4LXuQCJoYYKhyelyMWxFqHnEKO16k
         FJ9DYkP7/61JLuInoGzkBl10lJ2vLZYYc2eh5ReupDwlyxAraUCg5Culo3DBEkGDfHPs
         xVaZSV4wryPU2L9cnEwnXNih/Jd1NwePfzX6dOZoL0kBd08UuSIYl4MCmfEYw52ZEv4D
         eGH+twwe8gLubt6cF7RawMZYrNwRvpffv2+a7Fn+GQ86sE3x3PUBBI/eA15bSS4eVPV9
         wor3YR522uQWNKtMIP2B9EX068vazRaBSMp5RkABXHIkdp3j6Ob7QUvNapfGbdP+2nO0
         KXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv4C2/YSYkrq99+NyFL4iCbsuuMG/fAQbiwbq62jFXG2knZ7Wkef0+FQ+zgm7GeLVHzhLW3rtDYWgJ6Yay3hbx@vger.kernel.org, AJvYcCXERQfhC+VQCpGlIw7wD73t1ypz0isfrQuFhr22sG27brbyToJrerKfTyBOVbe7nB6MtfM=@vger.kernel.org, AJvYcCXvRq36Y2wBAU+0QlDHCNfrxcrdfR9JU0JZyKjiitJMuLmK9dFLV5p1EEKhSNBRn/5faucnk2yKlwHEGgSe@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUPEAabYYQdtnWYUPvwS7r7GqhxbXcnUHl55aVH0qrQQlJJlc
	B3uGL8qSJMJjO5n2IcuXSJVxndJ8WuspRYI3FH+yyF5X1/7YKrBgCry5IUmNpWNOCTmmg2T7gMT
	7lncvkGylmmdI9avJtUVzbzp8SmxPSe3qY1CfjIE=
X-Gm-Gg: ASbGncsWrSSYZnLj3qShmEQSZy9iU3IU31SLxhHy8BWShSKB/l/ypqDYWUZfs4hsU9K
	q/nbso5fAmaoTusd/HjmF9qbugDbqC/VCk20B2vlkaW5eNyGjepQh3cnY5VdUxK0PHMUuaOSfk7
	v2/iCagpPTOO9I8H33p4koKk48tVuXGNVAxNDjMbezP2aC28B+
X-Google-Smtp-Source: AGHT+IE76GudeHA/69roVzZCsrZjv+gjF6EYPefioHnvtRciyHLSrMEjX/3AlB7uK3UvDAl+0S8Diy0eG5zh6cUJd9g=
X-Received: by 2002:a17:90b:5344:b0:301:9f62:a944 with SMTP id
 98e67ed59e1d1-31241e9846dmr23790085a91.33.1748909190562; Mon, 02 Jun 2025
 17:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com>
In-Reply-To: <20250531072031.2263491-1-blakejones@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Jun 2025 17:06:18 -0700
X-Gm-Features: AX0GCFtxAzhlhjQYcq6JlRFpvPGAPA074cHSklHNJIGtjxxPZjvFhsCNSbS2Pa0
Message-ID: <CAEf4BzapWKWVzPFeZN5Ms6tOMhrtfpd8aiKenHgf4K4_1fhqMg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
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
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4392451d634b..be8e8e26d245 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
>         bool compact;           /* no newlines/indentation */
>         bool skip_names;        /* skip member/type names */
>         bool emit_zeroes;       /* show 0-valued fields */
> +       bool print_strings;     /* print char arrays as strings */

let's use "emit_strings" naming, so it's consistent with emit_zeroes?

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

ditto, emit_strings (and maybe put it next to emit_zeroes then)

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

IMO, a bit too defensive. You literally checked that we have char[] in
the caller, I think it's fine not to double-check that here, let's
drop this

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
> +                       break;

what if there are non-zero characters after the terminating zero?
should we keep going and if there is any non-zero one, still emit
them? or maybe that should be an extra option?... When capturing some
data and dumping, it might be important to know all the contents (it
might be garbage or not, but you'll still see non-garbage values
before \0, so maybe it's fine to always do it?)

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

[...]

> +/*
> + * String-like types are generally not named, so they need to be
> + * found this way rather than via btf__find_by_name().
> + */
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

btf_is_array()

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

instead of trying to find a suitable type in kernel BTF, just generate
a tiny custom BTF with necessary char[N] types? see btf__add_xxx()
usage for an example.

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

[...]

