Return-Path: <linux-kselftest+bounces-24531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F37A1142F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD5C3A0342
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAC2135A4;
	Tue, 14 Jan 2025 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5CqCeDa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CC1D5142;
	Tue, 14 Jan 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894129; cv=none; b=NkmOhxLljSfuQpPm9SnOv7twe4t2Q3GOK2o07DqYDk4DtsoZdPVTJAkRJcSwMMZopRI6QUq4Obrhzj2bEHYVbAxy10grSJM5Tk659+GyRiWLjRfZBEvzJhRTQGMjN1g/QLMIKFZkVSmd9AS4Tm7hsuSPpDeyl2vLYoh3bP2YIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894129; c=relaxed/simple;
	bh=ODVByDZfjM8USabGJb/xU999Gfxan787DvAUDQOlz8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYrMi6SA1vGUgWNwO7M8JxFhwe+BpdnPToXDMekCagmpqoGPQHI21GkMiUCET3/k56PQZ/mQ7MAnFqII7rbD3nQivVlfsPLTmSIR1jAVAEcyyGGiDFvwGIjj5F0te0WLU0m9V7g3UhKXlp4V2Qc1bQKIDWD4jgmxRXgoPlLOd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5CqCeDa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso7598250a91.2;
        Tue, 14 Jan 2025 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736894126; x=1737498926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyxQYencly8MaFhMrNwHMB/CxD0XASVAN06NZI/PhDo=;
        b=c5CqCeDaJscH5SuxnKBiLs+v/h6x5euTv5r2fpP5fmB+5fDgVvFjIN4LuQdo1jieMX
         j1bTKYyHnS3RjfIHQsNNqMCP5Qz7AJIVS9CtpHxOeki0SLLWx04386KDnQedHt2hv5gm
         cZSUDzSWZGxxeypr8qTdB98qMgWX18SCKl0cKKeu3P4F09lGJ9Wi1rHd8d4mFw+Vp8Nn
         G0vBqesk73b+D9QTpuoQUZTHBFg+cNvJwvsCwNoEgVYfQlQt56axUOTxH11zXsJGmqvJ
         grArNQJyfVTylKNxU5lMbUKTAhA3QeglMuv6p2OJ8BihlG8hhSLL2VEYq4OPYfwE/yG5
         nGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894126; x=1737498926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyxQYencly8MaFhMrNwHMB/CxD0XASVAN06NZI/PhDo=;
        b=jwJ762uPLa+PZlqZC8JdjW+uIfMG6woXe1DDPzxG/ZxPLKiYZo7u8fhD4XVNzt6VGL
         67YM7PQ5j4dnJLmUf33yxuAYUFIuqgKBmMQ0wlU7UcEExnwRhSnvs6z4EU69Nxi9jiKm
         XPXF3oDG7OvCBz52JJMZOEED77qs5JsaAi22BZsSC0l7SrCk7E8xWPvDq2zbn65FTc6Z
         yebhxUBW4sHH4sNkAL8IsnLKEyaBeBvQPofVThzfhjWv9jLjSDmvrCOsv3T6dqBJBycR
         1LzyRAA3XUMb1o4n2hZg3tTtL3xJCcXkgfhaJRTAj7kOkdXTIgk9wKUPjUIDxKNo3ihQ
         /CQw==
X-Forwarded-Encrypted: i=1; AJvYcCV5BRbym2plloNPpGUwgUEVj6mTM/nQ+MRQAlPeh5ygYuG7yOJvDd9beNtYOMwuKf2OqcHX8P/YNC0UygHB@vger.kernel.org, AJvYcCWWO2cc4fpd3VYD9hkpjp+QumfdKhBebxhtwQGYzJbTmPW5othZqEWm01ytRR+tjEQ0LZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RnjYkS8WJ4kFEJRnAhtNg+fekmvoZi2DyymbDJRA//eNNoiJ
	8TcLk6MOt7OsSCCtfWdqyR1jtwqopcpVUcI1CoZU5RaKaG7rfgDSB+MLzI146XUg1odCdR7ASAm
	YCs5n+X83xdDZlem87u1UD/4Cp3X4Gg==
X-Gm-Gg: ASbGncvUFmQWyLrQ5cnjPj1UmkaQlLewvJoaoPCfcavxiYfZ/CC92j9zMKRIOeulYjc
	lddVDBkTa7u0tCbr8mD+Jh9D8C2H/mztJrdML
X-Google-Smtp-Source: AGHT+IH10Zre8XAVSDuocA1ShgW1xeZ4Flh6m1+yOFCdpkK1Cse2w3HpC0YCYZArWmUo/VGzm5JIkWfL6dOCXaHqk8k=
X-Received: by 2002:a17:90b:2b8e:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2f548eca2d0mr35579917a91.21.1736894125993; Tue, 14 Jan 2025
 14:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223083342.1172756-1-lizhijian@fujitsu.com>
In-Reply-To: <20241223083342.1172756-1-lizhijian@fujitsu.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 14:35:12 -0800
X-Gm-Features: AbW1kvZRX4xA0MK5Okk5_NbZ8x4QUWcjGb6m-KtLBH7GX8nh_wmUB1pa5QL1Pgw
Message-ID: <CAEf4BzYOOnR8k3WNKGKOUnfs_8VXk5Xh5J7Zrstix+bEciyCcg@mail.gmail.com>
Subject: Re: [PATCH for-next v2] selftests/Makefile: override the srctree for
 out-of-tree builds
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 12:33=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com>=
 wrote:
>
> Fixes an issue where out-of-tree kselftest builds fail when building
> the BPF and bpftools components. The failure occurs because the top-level
> Makefile passes a relative srctree path to its sub-Makefiles, which
> leads to errors in locating necessary files.
>
> For example, the following error is encountered:
>
> ```
> $ make V=3D1 O=3D$build/ TARGETS=3Dhid kselftest-all
> ...
> make -C ../tools/testing/selftests all
> make[4]: Entering directory '/path/to/linux/tools/testing/selftests/hid'
> make  -C /path/to/linux/tools/testing/selftests/../../../tools/lib/bpf OU=
TPUT=3D/path/to/linux/O/kselftest/hid/tools/build/libbpf/ \
>             EXTRA_CFLAGS=3D'-g -O0'                                      =
\
>             DESTDIR=3D/path/to/linux/O/kselftest/hid/tools prefix=3D all =
install_headers
> make[5]: Entering directory '/path/to/linux/tools/lib/bpf'
> ...
> make[5]: Entering directory '/path/to/linux/tools/bpf/bpftool'
> Makefile:127: ../tools/build/Makefile.feature: No such file or directory
> make[5]: *** No rule to make target '../tools/build/Makefile.feature'.  S=
top.
> ```
>
> To resolve this, override the srctree in the kselftests's top Makefile
> when performing an out-of-tree build. This ensures that all sub-Makefiles
> have the correct path to the source tree, preventing directory resolution
> errors.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Cc: Masahiro Yamada <masahiroy@kernel.org>
>
> V2:
>  - handle srctree in selftests itself rather than the linux' top Makefile=
 # Masahiro Yamada <masahiroy@kernel.org>
>
> V1: https://lore.kernel.org/lkml/20241217031052.69744-1-lizhijian@fujitsu=
.com/
> ---
>  tools/testing/selftests/Makefile | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Is this intended to go through the bpf-next tree? I don't see it in
our patchworks, so please rebase and resend (unless this was routed
through some other tree already)

> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 3d8a80abd4f0..ab82278353cf 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -154,15 +154,19 @@ override LDFLAGS =3D
>  override MAKEFLAGS =3D
>  endif
>
> +top_srcdir ?=3D ../../..
> +
>  # Append kselftest to KBUILD_OUTPUT and O to avoid cluttering
>  # KBUILD_OUTPUT with selftest objects and headers installed
>  # by selftests Makefile or lib.mk.
> +# Override the `srctree` variable to ensure it is correctly resolved in
> +# sub-Makefiles, such as those within `bpf`, when managing targets like
> +# `net` and `hid`.
>  ifdef building_out_of_srctree
>  override LDFLAGS =3D
> +override srctree :=3D $(top_srcdir)
>  endif
>
> -top_srcdir ?=3D ../../..
> -
>  ifeq ("$(origin O)", "command line")
>    KBUILD_OUTPUT :=3D $(O)
>  endif
> --
> 2.44.0
>
>

