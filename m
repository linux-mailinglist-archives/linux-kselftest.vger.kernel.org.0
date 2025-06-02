Return-Path: <linux-kselftest+bounces-34152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45BACBB21
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CE0172D43
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F11B0F0A;
	Mon,  2 Jun 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7KQriAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A983EA98;
	Mon,  2 Jun 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889563; cv=none; b=X9YSFRpLyAsa7xVGwQhXj6k9Khc+0Y1wnNfrmXYnOGrT+GO/uzZk6t2XNFmM0W9ngkzKY9vK/+ju3P9TDUQGoUxi9CVWCdirkftFZrnTFpvyh1xms8AlOoTMzFrkk4/zXqFjwR0eFNXLSHSc3NXJKPBmGYWMZCTSydfnJcGTwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889563; c=relaxed/simple;
	bh=bGGkzeql+kLBnwAhHz5NwSXdhWSCN087guRy3TwIvTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlEvW+XAOGDYMHpax6eNERQq9bUF0hMdMEgCz3E4z4uCR7LO5JTEvtsbp0r1C+AMjyBIuB9JI6H1EQ5Dwp5eWNzRAtvdfplWZin4yWJfdGX5oWZHQrovCsqDENa2K3iT6LaoK2Q+7cwYaCYdm9TptaTx95eijR5g6d6wb8TQlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7KQriAP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so4169820f8f.0;
        Mon, 02 Jun 2025 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748889559; x=1749494359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4EJ/bNdkxlN82qnQqNLj+AZOld+xZ2/fvExor8dpnA=;
        b=B7KQriAPfJc/bCpO2Y0q5W7M6ABYLfIKKYmLnIPBqGqVqTp4B4gV073J5XRWLxVr5g
         Ur6GTbO1OOPtW3wDwzn7HTQ8RK82wfXC8AYqZ85bBPtofP+1AFg8tGyK7XxDiIqMzX4x
         GCYThM0LCtP7AJ0X4BnksMWOFpECeShYba/eN2goEVtbXTWTmDyAfK/kBsOyBkFuQ8OT
         cTP4Ng+NwLacgAx7z+MKqxOKyTsixIqbrndCnptI65tz5eI+NueNe8YDijWix0HYCZ5y
         yGeGTZEhstoWJ5orJ/OEW7elP2kX8JBOMpK3NnNhd5FqOFG5gxoY2x/zHltcFxiPVBpg
         AMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748889559; x=1749494359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4EJ/bNdkxlN82qnQqNLj+AZOld+xZ2/fvExor8dpnA=;
        b=rZPmejEBxaGZ/WZh6fvlBHbOMHrPSGUYRcnjB24RdZfAv7XRW2JoFM+KSwIYMFhaNt
         hloS6FnDd0x7HWohFwmsUoMtaX17GvgNsMy7JH6iIqCw5N4lmV447PHncm+tK/LWO0Gu
         WnJH1Jhx7GNs006u02KpHXh0YxJAO1bPGkxr+OsXxrgs8SCmVBiviWacEZVVgJC58VR4
         DQ4/cOIQBV59UOrD+OpLVURVOyx7gi/GIm6n2+jXshZsXiedLHYPRk1z0L0q4PRjIlv+
         2oKDQ3NUOeR6ldnTzMi9zRS6pnmp0Dx0UXOT68DudYLsLaVTtctN8c4xZsfKQ9ap5e/9
         DwAw==
X-Forwarded-Encrypted: i=1; AJvYcCUzN2CkoSTzVybjVNOENNA8N0d9OeWm/S4Fi7oBZ6fKVO6+Qpdt+GP2nGiIjtEkGkwX6G0=@vger.kernel.org, AJvYcCVlUF3kzAsny5M6BUXtMPmGv7ImeDUOmvYJiCSUDJwiT4eO8gsSu/G5d72VCf31AXyeJlRtEnzPJeD2956Mfl/w@vger.kernel.org, AJvYcCXsOmy+S76kcEn9Sfo+I2iX1Z+eGHflwpxejn170EsxPLsNciga/WhMI+NnKZGZUewOciaynxNo3BjXdP3n@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++2myKrZ4bFNfqj5yXDm/wzUztIqkbp8m81sHvsCBBDyssGgW
	IBB5vYLxN6QF4lK1cW6jkJ4cwbuIRmV3y1RTH7M/K+VAG4mMUo4rmAtkXvHXQ3PUrLirrIbTtdO
	nVk552JpnWIO/HD7C8gOqH2TtTiaFguM=
X-Gm-Gg: ASbGncs2KObI/28uN1ITVsPUcs3vsBkGydjWUxNPE+sGHVkHaJiZZ+WPVFkHCO/tkc6
	7zTqJkq0qBXdcFl/fC1WjjItZWWF5Qkdg+WySJkWDcY6HN6NUWTwmVs4NJt6GYh9SkEB1MbwgTG
	xerYarZcuKAWlyIZdJEKFgiBrO7VztqnNpq0D1EfiGfDYmQI9oTnhcWD6WO3lCteTWGedyGg==
X-Google-Smtp-Source: AGHT+IHUqx+mgL8hi72589JB27VJBUMwBIp9UzNzlH5b5s1OhLB/pURvh6gvJXZGV2bvvKk9RnNCYMD8HuP9sRI3DPU=
X-Received: by 2002:a05:6000:3112:b0:3a0:7f9c:189a with SMTP id
 ffacd0b85a97d-3a4f799acd4mr11273853f8f.0.1748889559007; Mon, 02 Jun 2025
 11:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531072031.2263491-1-blakejones@google.com>
 <CAADnVQJv_FVciT9LC+W=sVtWAt9oXeAACzmTHzyqY-2svi4ugA@mail.gmail.com> <CAP-5=fWADfh9WNXgUOhXYW5hZWk-FZL1oJTdaDgq8Hqr8_Fd0g@mail.gmail.com>
In-Reply-To: <CAP-5=fWADfh9WNXgUOhXYW5hZWk-FZL1oJTdaDgq8Hqr8_Fd0g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 11:39:07 -0700
X-Gm-Features: AX0GCFtiw9IZLAsO114ncb1PisrfRk2ajYyxEUOp4PqScN6vm6DijNlIQ-pyHHA
Message-ID: <CAADnVQKeJUdvJ7tKhpdatL-A5zDi9DXKFun8fwM2e7Bynd5FDg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add support for printing BTF character arrays as strings
To: Ian Rogers <irogers@google.com>
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

On Mon, Jun 2, 2025 at 8:05=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Sat, May 31, 2025 at 11:20=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, May 31, 2025 at 12:20=E2=80=AFAM Blake Jones <blakejones@google=
.com> wrote:
> > >
> > > The BTF dumper code currently displays arrays of characters as just t=
hat -
> > > arrays, with each character formatted individually. Sometimes this is=
 what
> > > makes sense, but it's nice to be able to treat that array as a string=
.
> > >
> > > This change adds a special case to the btf_dump functionality to allo=
w
> > > arrays of single-byte integer values to be printed as character strin=
gs.
> > > Characters for which isprint() returns false are printed as hex-escap=
ed
> > > values. This is enabled when the new ".print_strings" is set to 1 in =
the
> > > btf_dump_type_data_opts structure.
> > >
> > > As an example, here's what it looks like to dump the string "hello" u=
sing
> > > a few different field values for btf_dump_type_data_opts (.compact =
=3D 1):
> > >
> > > - .print_strings =3D 0, .skip_names =3D 0:  (char[6])['h','e','l','l'=
,'o',]
> > > - .print_strings =3D 0, .skip_names =3D 1:  ['h','e','l','l','o',]
> > > - .print_strings =3D 1, .skip_names =3D 0:  (char[6])"hello"
> > > - .print_strings =3D 1, .skip_names =3D 1:  "hello"
> > >
> > > Here's the string "h\xff", dumped with .compact =3D 1 and .skip_names=
 =3D 1:
> > >
> > > - .print_strings =3D 0:  ['h',-1,]
> > > - .print_strings =3D 1:  "h\xff"
> > >
> > > Signed-off-by: Blake Jones <blakejones@google.com>
> > > ---
> > >  tools/lib/bpf/btf.h                           |   3 +-
> > >  tools/lib/bpf/btf_dump.c                      |  51 ++++++++-
> > >  .../selftests/bpf/prog_tests/btf_dump.c       | 102 ++++++++++++++++=
++
> > >  3 files changed, 154 insertions(+), 2 deletions(-)
> >
> > Please split selftests vs main libbpf parts.
> >
> > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > index 4392451d634b..be8e8e26d245 100644
> > > --- a/tools/lib/bpf/btf.h
> > > +++ b/tools/lib/bpf/btf.h
> > > @@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
> > >         bool compact;           /* no newlines/indentation */
> > >         bool skip_names;        /* skip member/type names */
> > >         bool emit_zeroes;       /* show 0-valued fields */
> > > +       bool print_strings;     /* print char arrays as strings */
> > >         size_t :0;
> > >  };
> > > -#define btf_dump_type_data_opts__last_field emit_zeroes
> > > +#define btf_dump_type_data_opts__last_field print_strings
> > >
> > >  LIBBPF_API int
> > >  btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > index 460c3e57fadb..a07dd5accdd8 100644
> > > --- a/tools/lib/bpf/btf_dump.c
> > > +++ b/tools/lib/bpf/btf_dump.c
> > > @@ -75,6 +75,7 @@ struct btf_dump_data {
> > >         bool is_array_member;
> > >         bool is_array_terminated;
> > >         bool is_array_char;
> > > +       bool print_strings;
> >
> > Looks useful, but make sure to add a feature detection
> > to perf, since it has to work with old and new libbpf.
>
> Just for clarity on this. We'll need a "libbpf-strings" feature like
> the existing "libbpf" one:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/build/feature/test-libbpf.c?h=3Dperf-tools-next
>
> Currently these features are only used if perf is built with
> LIBBPF_DYNAMIC=3D1 as part of the build arguments (ie its not the
> default):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/Makefile.config?h=3Dperf-tools-next#n580
>
> If no suitable libbpf is detected then the build will error out. I
> guess if feature-libbpf is present but not feature-libbpf-strings then
> we'll need a perf #define so that the string feature won't cause
> perf's build to fail.

Yes. Something like this.
It will also allow libbpf and perf patches to land in parallel.

