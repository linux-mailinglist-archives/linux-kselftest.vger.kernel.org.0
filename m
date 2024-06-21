Return-Path: <linux-kselftest+bounces-12480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00057912F28
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A291C21047
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4B17A93E;
	Fri, 21 Jun 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nm1YQUsx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87416D311
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004053; cv=none; b=miJ3pHlHoD5qAEUAS92lb+Y/eDsUX9ngKPZR0iFoC0iS//JXHvGkGjXoTwOGdO5d5EszZexUixRNAXWFU1I/lMwLO3wpa9dmHzZ73ilubMyi7isp8IXFSu8ZCSaSZUm/AQAuanRMvj6gTudslU5+9kcafB29pUHxgGSNxfb2FD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004053; c=relaxed/simple;
	bh=XgUW3LEfhTj5B4QUg7GGCfpg3FEyOByCAvwb+evNrco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHYCu/99zMAKOYTRNpzHQLnhp1FJuiCMA9mTkAi1o7CdMqsf/LNWbuOJRoxBx8CbZxZeOEqKqUlOO3wCP7/0p7aH9yhLYhJeTQwE6g9/9t+4Zt4ES+hkBjRq9Al6mkHPBP8kuin/MTwapH+60TzQuruNNqLH23iK3k1B/gnwSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nm1YQUsx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so148675e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719004050; x=1719608850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eryb272LK3HBx2dJfWKCg561fdhVAi5B8rKxZdt2Nn0=;
        b=nm1YQUsxhfJovk0hzQP6L+ahm2lwzkKnimHFgX3ifCP+yxs3zdAdr+XcNdmlxh+qbl
         FjYr1o7iNJxqZDlkFEXwTP/jt0em2nMnAyrnEmKMQlnRHjy5F7Nq+J4iRqhIE+v4zqW2
         RNy2TC5A8mYLI013OY/ugVnGYPa7FQDHCojkIHXlJdGYU+1oQ4nE0RO3IF6HLlicMBWG
         5qPH0bIeTZHyZG4BHnfqRrxWdKeIAkpb/3AlAZi8oKFYg5gn7dP2GO7y2wfMmg13hDd6
         z31lNEcrlOKFNo3fa1DDwVQRhqNjysYQuHAr66T57YQSlwMHIoab9oJdOBMOTGZBSU1o
         COoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004050; x=1719608850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eryb272LK3HBx2dJfWKCg561fdhVAi5B8rKxZdt2Nn0=;
        b=NivMgeETJU3zNQXnwvyDu2uh/51NFPaTsru7j4eZsyoMC4LfsSgIWjmRTVmGxnx7+3
         hIwI7wui8SqWPG0E7ZP4XEfBNqRix9kuJsoqJse/yXPYHDVH44hZTfCa84tx8CoNiY84
         9mEfdiuFuzhhRnKqvNauN/sYjgm3blYDQgYweVjqXEq5RIXvf87/O1jt4zOdUe+QXJ+m
         xH15Sm2+M4HBt2ps+kflqO0V4HF+NcGg/XT3FLskTfpfSIdnbvYUY/hrpAtHHQgI0Ysj
         uiE+g/1Y0yIDH+acMk0EsrOwyECz/vkmXS8a40OV6MNm19/xz/M7QW1khL+KZCuZMuSj
         j5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXgvrIzLV7xNBgAJRipiy0Jhp4wY8hcFDAM5Gfwe+KgQ+4Vmh98kUvZxdoN8v5GGUw/2rKaACG1w5AQhp51UFJSdOUkRyg/nxeTP3sS63d3
X-Gm-Message-State: AOJu0Yz00N6QPoRIVw0qrJqtR1HEpF2/SrzGiAOgd6+mKj1kf8Xhn6IP
	zOjzgu7a1LYko93G38bT4m3ELbuMXmGpTMlSq/EpsE/lHEtalAfZkrPKaHdVnuvNqJBddDNn+2l
	HEU0wUGQnE17flnpR/xxFBU6TK2KMX0InZ2YB
X-Google-Smtp-Source: AGHT+IF1oDts+tFhSy3UVBEjSE4kr8DrRad9k16c46fxu2g9qG/cEQL5Wd7UmfDCaVHtbD+x5Y0B0xlMa03ILQZ6o+4=
X-Received: by 2002:a05:600c:5014:b0:421:6c54:3a8 with SMTP id
 5b1f17b1804b1-424876e0088mr230965e9.7.1719004049667; Fri, 21 Jun 2024
 14:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-4-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-4-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:07:16 -0400
Message-ID: <CA+GJov6NBkPUmPSW6ir1Z0Gc9gFXP6dP-GhnoQU7nCRW0yXTLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kunit: string-stream-test: Make it a separate module
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Currently, the only way to build string-stream-test is by setting
> CONFIG_KUNIT_TEST=3Dy. However, CONFIG_KUNIT_TEST is a config option for
> a different test (`kunit-test.c`).
>
> Introduce a new Kconfig entry in order to be able to build the
> string-stream-test test as a separate module. Import the KUnit namespace
> in the test so we could have string-stream functions accessible.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This is looking good to me other than the module description as noted
by Jeff. That could be a separate patch since the rest of the series
is looking good.

There is the checkpatch warning on the module description. But as
David mentioned, the description looks ok to me. If there is a new
version of this patch, it may be worth trying to get rid of the
warning by lengthening the description.

But I am happy with this patch as is.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> V1 -> V2:
> - No changes
>
>  lib/kunit/Kconfig              | 8 ++++++++
>  lib/kunit/Makefile             | 2 +-
>  lib/kunit/string-stream-test.c | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 34d7242d526d..b0713c0f9265 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -45,6 +45,14 @@ config KUNIT_TEST
>           purposes by developers interested in testing that KUnit works a=
s
>           expected.
>
> +config KUNIT_STRING_STREAM_TEST
> +       tristate "KUnit test for string-stream" if !KUNIT_ALL_TESTS
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enables the KUnit test for the string-stream (C++ stream style =
string
> +         builder used in KUnit for building messages). For the string-st=
ream
> +         implementation, see lib/kunit/string-stream.c.
> +
>  config KUNIT_EXAMPLE_TEST
>         tristate "Example test for KUnit" if !KUNIT_ALL_TESTS
>         default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 30f6bbf04a4a..478beb536dc9 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -19,10 +19,10 @@ endif
>  obj-y +=3D                               hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
> +obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) +=3D string-stream-test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> -obj-$(CONFIG_KUNIT_TEST) +=3D            string-stream-test.o
>  obj-$(CONFIG_KUNIT_TEST) +=3D            assert_test.o
>  endif
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 7511442ea98f..d03cac934e04 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -534,3 +534,5 @@ static struct kunit_suite string_stream_test_suite =
=3D {
>         .init =3D string_stream_test_init,
>  };
>  kunit_test_suites(&string_stream_test_suite);
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

