Return-Path: <linux-kselftest+bounces-22718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF69E0F51
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 00:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D46B2408F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3C1DFE1E;
	Mon,  2 Dec 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk6vMjzD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145991DFE0A
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182181; cv=none; b=fs2iII8UPcWXFsw6ZHD2mE0THZva3Ym5zMNx6xKLvZn1/rkLIYmfpTJbQTehn54Nqv85cjeUe47MnWvDFzMOh+olSrzl57N5hp8QGk0loaNdhorjDnjtToHmfzIWzz0zKJfPi9phFY6JA6iNKtFRN3U+s347uIXY/c+z+abLkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182181; c=relaxed/simple;
	bh=WK50cpXZH4dQMiLFN8OiZnR2eSxyi+RTBUsGg1QksxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fnch6tJKhOzxD6atiTwQUf0POovRaiu0AnRpUr99SSsC+pSkmAM3JpCBbW3OBvBvHSBF92yx3M2wX4CmCCIusHWHkzh8mpph6Yu3J7T39RuBY/Lx6iOrxoYIf7H9nf8hiEzNorFR1Vcd8fuY0snVJUwW2B70eKE9dOY9a06J90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wk6vMjzD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7256a7a3d98so1867384b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2024 15:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733182179; x=1733786979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LReTg15v0ZtTlAbFyfXtnh3wL3KeT354X2oVVMEIzE=;
        b=Wk6vMjzDdhz5o7bkuXt1+VffC+236XKPxYbXT/qjGN+uC9axRRYKDCUrlAFnbPuwPz
         pHSIO2hMY0D/7Rp3XDa/81nO+AW9Tld9oCc59YfvMqrIX8MH3O2hSWuVAVDNkv4SAhIn
         Yt6ic4XMQz/0AN8ysyXGutQ3ckIBt2KjvNuxySq29rlxXkS3msFLLQWIE2zGK1XE9o+W
         XVCeBIRUmLam0aZYm4LgGuaAi2DCwPFvGI7ijrT5dfziNJXMTTBLOj7GfvsEUrJsgzd9
         dutDJqF9f3IvMN2753WPdkXIy6KIZfDV+ZKy2MHRBCaHzDSnacsoE/4cno8CMXypqH1r
         O2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182179; x=1733786979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LReTg15v0ZtTlAbFyfXtnh3wL3KeT354X2oVVMEIzE=;
        b=QpGxIMN2toW/VdVsKKWpy/FwNVN6tWa0Kfqf79I4lT6RDkYMuNKCmkKXAzseSngFFk
         oR4HYhVzjUxy9UpwTyY1SKxZ4J/BHTNxWYWBe/1bqYtewWgOaZhslEj/eRwwVPSAxz8c
         dFowWNihn3j7Pq93wqtuoQlTdp0aqeDkL3uJxy2qF/qQJbszpsh7u4W9AqPQTU9CZ+Ut
         OmpJ6R2jAv3mkefpCI81DMh3EztSxZ8f8EAYJ+KNg3kz8k5TrnJEePNpMj1ILFbbAI5l
         /1VTgkLBLbTALInTLzSbU9gA/ssWq6HMZzd9IY2faNAx2F1BorKM8XbEkED3rjGZbmS+
         Y6pg==
X-Forwarded-Encrypted: i=1; AJvYcCViN4JsRT3lv1AM6y6cmOTS66+MourDuHrzfDtPdaEUJTEFNHccCcSkH0btvNqKyZQ4VMSNhxH0yHvBoPflfqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjOkFmkezpZPQr2vu4ylxK37hn+M7+DpIR2XHkXFsVmKeK4Xx
	/QFzcNCjuf6wBqf2lkgm+IEnmSuW9+rfT3oGssvi/AAhJDPlEZjkZr4UnoRKvBJ1Uo/T6JT7YvR
	u5EYA1ifITcgkae6vgBByw2Itmieu0FTu8NZm
X-Gm-Gg: ASbGncsdoEv04PIE676uFVe5qCbG+KebLP4XetFFi1L8Kf0MVC12N4O//gnkfu3Kbjw
	eU1Rvl+dG3sPO/bp30hUnh/t/UUfNz5my
X-Google-Smtp-Source: AGHT+IGG9gvQtdzRrY4jpTCXLk7VsAXT/IdOENrmFiS2raqmC78L2FrgNr63mNCKpMrl8spRQNKoahTkYuD/c/1Ghrc=
X-Received: by 2002:a17:90b:33cd:b0:2ee:f80c:687c with SMTP id
 98e67ed59e1d1-2ef01274889mr506311a91.31.1733182179063; Mon, 02 Dec 2024
 15:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202075545.3648096-1-davidgow@google.com>
In-Reply-To: <20241202075545.3648096-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 2 Dec 2024 18:29:26 -0500
Message-ID: <CA+GJov6-p4u47B3TGYphdFTqFW+Vx94fu8v4URe1mF61p7koYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] [PATCH 0/6] KUnit test moves / renames
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 2:55=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> As discussed in [1], the KUnit test naming scheme has changed to avoid
> name conflicts (and tab-completion woes) with the files being tested.
> These renames and moves have caused a nasty set of merge conflicts, so
> this series collates and rebases them all on top of v6.13-rc1, to be
> applied minimising any further conflicts. [2,3]
>
> Thanks to everyone whose patches appear here, and everyone who reviewed
> on the original series. I hope I didn't break them too much during the
> rebase!
>

Hello!

This series looks good to me. Tests are passed both built-in and as modules=
.

One comment: The second patch in the series "[PATCH v2 2/6] lib/math:
Add int_log test suite" applies with a warning of an extra EOF blank
line.

Other than that small nit,

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae


> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/=
 [1]
> Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=3DE4piSojh3A4_0GjE0fAY=
bqKjtYGbE9beYRQ@mail.gmail.com/ [2]
> Link: https://lore.kernel.org/linux-kselftest/CABVgOSkhD6=3D5K72oL_n35CUe=
MhbsiQjZ6ds+EuQmJggBtVTFVg@mail.gmail.com/ [3]
>
> Bruno Sobreira Fran=C3=A7a (1):
>   lib/math: Add int_log test suite
>
> Diego Vieira (1):
>   lib/tests/kfifo_kunit.c: add tests for the kfifo structure
>
> Gabriela Bittencourt (2):
>   unicode: kunit: refactor selftest to kunit tests
>   unicode: kunit: change tests filename and path
>
> Kees Cook (1):
>   lib: Move KUnit tests into tests/ subdirectory
>
> Luis Felipe Hernandez (1):
>   lib: math: Move kunit tests into tests/ subdir
>
>  MAINTAINERS                                   |  19 +-
>  fs/unicode/Kconfig                            |   5 +-
>  fs/unicode/Makefile                           |   2 +-
>  fs/unicode/tests/.kunitconfig                 |   3 +
>  .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 149 ++++++------
>  fs/unicode/utf8-norm.c                        |   2 +-
>  lib/Kconfig.debug                             |  27 ++-
>  lib/Makefile                                  |  39 +--
>  lib/math/Makefile                             |   4 +-
>  lib/math/tests/Makefile                       |   4 +-
>  lib/math/tests/int_log_kunit.c                |  75 ++++++
>  .../rational_kunit.c}                         |   0
>  lib/tests/Makefile                            |  41 ++++
>  lib/{ =3D> tests}/bitfield_kunit.c              |   0
>  lib/{ =3D> tests}/checksum_kunit.c              |   0
>  lib/{ =3D> tests}/cmdline_kunit.c               |   0
>  lib/{ =3D> tests}/cpumask_kunit.c               |   0
>  lib/{ =3D> tests}/crc16_kunit.c                 |   0
>  lib/{ =3D> tests}/fortify_kunit.c               |   0
>  lib/{ =3D> tests}/hashtable_test.c              |   0
>  lib/{ =3D> tests}/is_signed_type_kunit.c        |   0
>  lib/tests/kfifo_kunit.c                       | 224 ++++++++++++++++++
>  lib/{ =3D> tests}/kunit_iov_iter.c              |   0
>  lib/{ =3D> tests}/list-test.c                   |   0
>  lib/{ =3D> tests}/memcpy_kunit.c                |   0
>  lib/{ =3D> tests}/overflow_kunit.c              |   0
>  lib/{ =3D> tests}/siphash_kunit.c               |   0
>  lib/{ =3D> tests}/slub_kunit.c                  |   0
>  lib/{ =3D> tests}/stackinit_kunit.c             |   0
>  lib/{ =3D> tests}/string_helpers_kunit.c        |   0
>  lib/{ =3D> tests}/string_kunit.c                |   0
>  lib/{ =3D> tests}/test_bits.c                   |   0
>  lib/{ =3D> tests}/test_fprobe.c                 |   0
>  lib/{ =3D> tests}/test_hash.c                   |   0
>  lib/{ =3D> tests}/test_kprobes.c                |   0
>  lib/{ =3D> tests}/test_linear_ranges.c          |   0
>  lib/{ =3D> tests}/test_list_sort.c              |   0
>  lib/{ =3D> tests}/test_sort.c                   |   0
>  lib/{ =3D> tests}/usercopy_kunit.c              |   0
>  lib/{ =3D> tests}/util_macros_kunit.c           |   0
>  40 files changed, 459 insertions(+), 135 deletions(-)
>  create mode 100644 fs/unicode/tests/.kunitconfig
>  rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (64%)
>  create mode 100644 lib/math/tests/int_log_kunit.c
>  rename lib/math/{rational-test.c =3D> tests/rational_kunit.c} (100%)
>  rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
>  rename lib/{ =3D> tests}/checksum_kunit.c (100%)
>  rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
>  rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
>  rename lib/{ =3D> tests}/crc16_kunit.c (100%)
>  rename lib/{ =3D> tests}/fortify_kunit.c (100%)
>  rename lib/{ =3D> tests}/hashtable_test.c (100%)
>  rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
>  create mode 100644 lib/tests/kfifo_kunit.c
>  rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
>  rename lib/{ =3D> tests}/list-test.c (100%)
>  rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
>  rename lib/{ =3D> tests}/overflow_kunit.c (100%)
>  rename lib/{ =3D> tests}/siphash_kunit.c (100%)
>  rename lib/{ =3D> tests}/slub_kunit.c (100%)
>  rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
>  rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
>  rename lib/{ =3D> tests}/string_kunit.c (100%)
>  rename lib/{ =3D> tests}/test_bits.c (100%)
>  rename lib/{ =3D> tests}/test_fprobe.c (100%)
>  rename lib/{ =3D> tests}/test_hash.c (100%)
>  rename lib/{ =3D> tests}/test_kprobes.c (100%)
>  rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
>  rename lib/{ =3D> tests}/test_list_sort.c (100%)
>  rename lib/{ =3D> tests}/test_sort.c (100%)
>  rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
>  rename lib/{ =3D> tests}/util_macros_kunit.c (100%)
>
> --
> 2.47.0.338.g60cca15819-goog
>

