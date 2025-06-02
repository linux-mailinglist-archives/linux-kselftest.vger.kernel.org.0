Return-Path: <linux-kselftest+bounces-34143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFCACB863
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 17:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1181BC6DE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F381233D7C;
	Mon,  2 Jun 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I058ZpQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030D233727
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876754; cv=none; b=QCFwmN89tF9Bp8V2+QmGjwHU1CT1y8olK4/k6VbOzbVYkuUkYHl0VNytGuXQgLrJWZybvfXIvmZfHTSLFeSkpwbJsQRMAf1gAXSowDsBQ9bECSJC2+3mIDTyDhOcwOpxbSLGQQkv7Z1nwucsxbtUBPBeRUmuu601rjx6/AvwRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876754; c=relaxed/simple;
	bh=H5kHUSGNewKk+2DnnUpNcNHbHQNuSxBdvQMugCJHy+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cb5q3qx4+u6AgmLqaSrWx5R1ktVo/khB6ft9pU4GTXYZjFEVLBts2xbxKj+FYjKReoKQdl/0Y6qQcNIoJ0F+yDNE+gsBWLyvfybwwCq62y3FYt+rZkVje3NaaWn7YN6Zx0pd1ITr8VYphbYG+vUy3swa15+qNJ0W7Vm0FfwBTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I058ZpQw; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dd89a85414so518255ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748876752; x=1749481552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2dfgUrLyGgIpbCKR2W/UpAQPOS9BKojbb73ls2Lb5w=;
        b=I058ZpQwAv/fk0nUrLck2XyraBzgA5Ufvx4H86uSuGvBw0EiKWiQwTdOC+Tw0bEwHL
         GoXLv7SHcNJ41yrWXiC78j/WcqCU8j6oIobTJ52Cnv4gBjdrTznUt9PugImQkbgPiuj6
         qyNjR0tZcgu+Aa9ikjmWCwG1RQ0ZLW6E3AMFYeDeXdszOr60hFQ8qeHTjCylFEDvACby
         2aa9sw5pUp7a2fzzDAQCnbYztgKmv+e9mcl5JQ+e2NFhPqIU1vHCGcdpbOlNzeRrqNhB
         3IEQJyLAEW94n9PNyFDOSvx2FTFjHmSJ+asVDJiq9hdMvRsJtBYnRoxYDraBPCS1BSxv
         gZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748876752; x=1749481552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2dfgUrLyGgIpbCKR2W/UpAQPOS9BKojbb73ls2Lb5w=;
        b=E9n+yF7T0faVUwGRTscR6lGCBMGwbHqU4c6lVMQtOKI6FlGd3Bo0TyORIYlVRwlnO4
         egKvXGnOlajo6hTEldBnEpRGeDXCKi1n3CGQFcVDg4jtR1OlF/5PmUiTsVAwxwuTqWWP
         fSjgzlFSy54P2ufklalay/CI/1s9fotXdKIbpUng78H2pqTJIUUBfoI0k0wSxZdUbetd
         yKe5cTiAx5e9AK4Ah/mMojQonVRjnkg9B0ygO1rp3ZosSWRRyAssySRutAH3C1NtrBWd
         VPZVzdX7rJQmFXF788ODNDnV5G0RvdiX+noiUDdxdL6QVmDcc/B2952ejGuHRE4h4kti
         o05Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkWGmegH70CJUuOas36t1ci93Th4l4A+ML1Iqtvri4/cSk89wOqXhgndbbYa0tRQVF0o6+HtgIzL3mw81BC2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWkJhpFPocVo50ohsOlY2S9tHlqls8wLt65SoCs2CbqEkpOAo
	iDnMoMWOPZakY22wLWVBYSRn0ljrmPD4/el+KnuGnfr9S+3ixrXa86l+SLzifrzTAFVaJQg2WJN
	DoqP0AmT6jxpADZaWIGopCmlqjo4BxgJvuS7XTBhR
X-Gm-Gg: ASbGncstDonddm0OxzsIiMf7+d6HvL+QUCUTsqUza4KSFvj8fCIkKrGnSwi92e0sysi
	jMEYfNxESCnuI5szkf0n4sA01XIXghegTlPw1NE0Ky/ySU0DFNSdtTUImzUKZurD4mu5Qd2/RCS
	aw4FbUbrgQrizaQNyVV5F/616egKfOSON+yiqTreE1IM5vLne9/60Q9Pk0gKSk7sboAymYCw7wH
	FaHqYJTKzQ=
X-Google-Smtp-Source: AGHT+IF6m7o0fdDRx3Vbhw/MpD28hZ96bYJtWMuRMvo6m8wCfHK7XogY8w4GxWbIA7d+1VodLKqlSwUOffaJcO0Ko7U=
X-Received: by 2002:a05:6e02:180b:b0:3dd:a7a1:9ee8 with SMTP id
 e9e14a558f8ab-3dda7a1a195mr3484305ab.24.1748876751219; Mon, 02 Jun 2025
 08:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com> <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
In-Reply-To: <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Jun 2025 08:05:38 -0700
X-Gm-Features: AX0GCFss5TTU-FIMe9bH8z4GTz9-CpAC3L2v9sZZ6MQmhvIXr3LieJYQucQLd8w
Message-ID: <CAP-5=fWADfh9WNXgUOhXYW5hZWk-FZL1oJTdaDgq8Hqr8_Fd0g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Blake Jones <blakejones@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 11:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, May 31, 2025 at 12:20=E2=80=AFAM Blake Jones <blakejones@google.c=
om> wrote:
> >
> > The BTF dumper code currently displays arrays of characters as just tha=
t -
> > arrays, with each character formatted individually. Sometimes this is w=
hat
> > makes sense, but it's nice to be able to treat that array as a string.
> >
> > This change adds a special case to the btf_dump functionality to allow
> > arrays of single-byte integer values to be printed as character strings=
.
> > Characters for which isprint() returns false are printed as hex-escaped
> > values. This is enabled when the new ".print_strings" is set to 1 in th=
e
> > btf_dump_type_data_opts structure.
> >
> > As an example, here's what it looks like to dump the string "hello" usi=
ng
> > a few different field values for btf_dump_type_data_opts (.compact =3D =
1):
> >
> > - .print_strings =3D 0, .skip_names =3D 0:  (char[6])['h','e','l','l','=
o',]
> > - .print_strings =3D 0, .skip_names =3D 1:  ['h','e','l','l','o',]
> > - .print_strings =3D 1, .skip_names =3D 0:  (char[6])"hello"
> > - .print_strings =3D 1, .skip_names =3D 1:  "hello"
> >
> > Here's the string "h\xff", dumped with .compact =3D 1 and .skip_names =
=3D 1:
> >
> > - .print_strings =3D 0:  ['h',-1,]
> > - .print_strings =3D 1:  "h\xff"
> >
> > Signed-off-by: Blake Jones <blakejones@google.com>
> > ---
> >  tools/lib/bpf/btf.h                           |   3 +-
> >  tools/lib/bpf/btf_dump.c                      |  51 ++++++++-
> >  .../selftests/bpf/prog_tests/btf_dump.c       | 102 ++++++++++++++++++
> >  3 files changed, 154 insertions(+), 2 deletions(-)
>
> Please split selftests vs main libbpf parts.
>
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 4392451d634b..be8e8e26d245 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
> >         bool compact;           /* no newlines/indentation */
> >         bool skip_names;        /* skip member/type names */
> >         bool emit_zeroes;       /* show 0-valued fields */
> > +       bool print_strings;     /* print char arrays as strings */
> >         size_t :0;
> >  };
> > -#define btf_dump_type_data_opts__last_field emit_zeroes
> > +#define btf_dump_type_data_opts__last_field print_strings
> >
> >  LIBBPF_API int
> >  btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index 460c3e57fadb..a07dd5accdd8 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -75,6 +75,7 @@ struct btf_dump_data {
> >         bool is_array_member;
> >         bool is_array_terminated;
> >         bool is_array_char;
> > +       bool print_strings;
>
> Looks useful, but make sure to add a feature detection
> to perf, since it has to work with old and new libbpf.

Just for clarity on this. We'll need a "libbpf-strings" feature like
the existing "libbpf" one:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/feature/test-libbpf.c?h=3Dperf-tools-next

Currently these features are only used if perf is built with
LIBBPF_DYNAMIC=3D1 as part of the build arguments (ie its not the
default):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.config?h=3Dperf-tools-next#n580

If no suitable libbpf is detected then the build will error out. I
guess if feature-libbpf is present but not feature-libbpf-strings then
we'll need a perf #define so that the string feature won't cause
perf's build to fail. We could make it so that perf's build fails if
feature-libbpf and feature-libbpf-strings are missing, but that's
likely too much for people using LIBBPF_DYNAMIC=3D1 today.

Thanks,
Ian

> >  };
> >
> >  struct btf_dump {
> > @@ -2028,6 +2029,50 @@ static int btf_dump_var_data(struct btf_dump *d,
> >         return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0)=
;
> >  }
> >
> > +static int btf_dump_string_data(struct btf_dump *d,
> > +                               const struct btf_type *t,
> > +                               __u32 id,
> > +                               const void *data)
> > +{
> > +       const struct btf_array *array =3D btf_array(t);
> > +       __u32 i;
> > +
> > +       if (!btf_is_int(skip_mods_and_typedefs(d->btf, array->type, NUL=
L)) ||
> > +           btf__resolve_size(d->btf, array->type) !=3D 1 ||
> > +           !d->typed_dump->print_strings) {
> > +               pr_warn("unexpected %s() call for array type %u\n",
> > +                       __func__, array->type);
> > +               return -EINVAL;
> > +       }
> > +
> > +       btf_dump_data_pfx(d);
> > +       btf_dump_printf(d, "\"");
> > +
> > +       for (i =3D 0; i < array->nelems; i++, data++) {
> > +               char c;
> > +
> > +               if (data >=3D d->typed_dump->data_end)
> > +                       return -E2BIG;
> > +
> > +               c =3D *(char *)data;
> > +               if (c =3D=3D '\0') {
> > +                       /* When printing character arrays as strings, N=
UL bytes
> > +                        * are always treated as string terminators; th=
ey are
> > +                        * never printed.
> > +                        */
>
> Please use normal kernel style comments.
> We're gradually getting away from networking style.
>
> > +                       break;
> > +               }
> > +               if (isprint(c))
> > +                       btf_dump_printf(d, "%c", c);
> > +               else
> > +                       btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
> > +       }
> > +
> > +       btf_dump_printf(d, "\"");
> > +
> > +       return 0;
> > +}
> > +
> >  static int btf_dump_array_data(struct btf_dump *d,
> >                                const struct btf_type *t,
> >                                __u32 id,
> > @@ -2055,8 +2100,11 @@ static int btf_dump_array_data(struct btf_dump *=
d,
> >                  * char arrays, so if size is 1 and element is
> >                  * printable as a char, we'll do that.
> >                  */
> > -               if (elem_size =3D=3D 1)
> > +               if (elem_size =3D=3D 1) {
> > +                       if (d->typed_dump->print_strings)
> > +                               return btf_dump_string_data(d, t, id, d=
ata);
> >                         d->typed_dump->is_array_char =3D true;
> > +               }
> >         }
> >
> >         /* note that we increment depth before calling btf_dump_print()=
 below;
> > @@ -2544,6 +2592,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, =
__u32 id,
> >         d->typed_dump->compact =3D OPTS_GET(opts, compact, false);
> >         d->typed_dump->skip_names =3D OPTS_GET(opts, skip_names, false)=
;
> >         d->typed_dump->emit_zeroes =3D OPTS_GET(opts, emit_zeroes, fals=
e);
> > +       d->typed_dump->print_strings =3D OPTS_GET(opts, print_strings, =
false);
> >
> >         ret =3D btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/=
testing/selftests/bpf/prog_tests/btf_dump.c
> > index c0a776feec23..70e51943f148 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> > @@ -879,6 +879,106 @@ static void test_btf_dump_var_data(struct btf *bt=
f, struct btf_dump *d,
> >                           "static int bpf_cgrp_storage_busy =3D (int)2"=
, 2);
> >  }
> >
> > +/*
> > + * String-like types are generally not named, so they need to be
> > + * found this way rather than via btf__find_by_name().
> > + */
>
> This is the correct style of comments.
>
> > +static int find_char_array_type(struct btf *btf, int nelems)
> > +{
> > +       const int nr_types =3D btf__type_cnt(btf);
> > +       const int char_type =3D btf__find_by_name(btf, "char");
> > +
> > +       for (int i =3D 1; i < nr_types; i++) {
> > +               const struct btf_type *t;
> > +               const struct btf_array *at;
> > +
> > +               t =3D btf__type_by_id(btf, i);
> > +               if (btf_kind(t) !=3D BTF_KIND_ARRAY)
> > +                       continue;
> > +
> > +               at =3D btf_array(t);
> > +               if (at->nelems =3D=3D nelems && at->type =3D=3D char_ty=
pe)
> > +                       return i;
> > +       }
> > +
> > +       return -ENOENT;
> > +}
> > +
> > +static int btf_dump_string_data(struct btf *btf, struct btf_dump *d,
> > +                               char *str, struct btf_dump_type_data_op=
ts *opts,
> > +                               char *ptr, size_t ptr_sz,
> > +                               const char *expected_val)
> > +{
> > +       char name[64];
> > +       size_t type_sz;
> > +       int type_id;
> > +       int ret =3D 0;
> > +
> > +       snprintf(name, sizeof(name), "char[%zu]", ptr_sz);
> > +       type_id =3D find_char_array_type(btf, ptr_sz);
> > +       if (!ASSERT_GE(type_id, 0, "find type id"))
> > +               return -ENOENT;
> > +       type_sz =3D btf__resolve_size(btf, type_id);
> > +       str[0] =3D '\0';
> > +       ret =3D btf_dump__dump_type_data(d, type_id, ptr, ptr_sz, opts)=
;
> > +       if (type_sz <=3D ptr_sz) {
> > +               if (!ASSERT_EQ(ret, type_sz, "failed/unexpected type_sz=
"))
> > +                       return -EINVAL;
> > +       } else {
> > +               if (!ASSERT_EQ(ret, -E2BIG, "failed to return -E2BIG"))
> > +                       return -EINVAL;
> > +       }
> > +       if (!ASSERT_STREQ(str, expected_val, "ensure expected/actual ma=
tch"))
> > +               return -EFAULT;
> > +       return 0;
> > +}
> > +
> > +static void test_btf_dump_string_data(struct btf *btf, struct btf_dump=
 *d,
> > +                                     char *str)
> > +{
> > +       DECLARE_LIBBPF_OPTS(btf_dump_type_data_opts, opts);
> > +
> > +       opts.compact =3D true;
> > +       opts.emit_zeroes =3D false;
> > +       opts.print_strings =3D true;
> > +
> > +       opts.skip_names =3D false;
> > +       btf_dump_string_data(btf, d, str, &opts, "foo", 4,
> > +               "(char[4])\"foo\"");
>
> we allow up to 100 char per line.
> Don't split it that short.
>
> pw-bot: cr

