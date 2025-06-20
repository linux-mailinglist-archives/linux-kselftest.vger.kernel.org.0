Return-Path: <linux-kselftest+bounces-35424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C527AE1828
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CB117B618
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0E23AB8F;
	Fri, 20 Jun 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQGj8tAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1155283CBF
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412900; cv=none; b=evwcTFOdTQl9yiLpqEU/te9/4VD3aL9t0KQb1eU7K3g5Hj5eevEjzBQaC8PTB3tDpgOy3i755aRnD0OoX8Oj0Psbi8soa2Eh4Lw0v3F2NhMtmyee7Xel+5fXn4VguC9hjx2LOmHcx6eL036deeay+Lu5zXF8LnO1IGwHLmLx5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412900; c=relaxed/simple;
	bh=Bbso8bCjh7RtgzkWEQlzsshCsdHYhrcX59xFWKJY75Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwHKZ5pAdv/1loejd8+uSnB+szNE+Ta0zxADa7JKIkTh+1+pnplicx6EXmDeNaw1eQOrZat7g3g+JOU14DwlWLVywokkEtaG/VZ6uvjnUXMeQyqVg+tBnLrTfT2VgVPgfkNmWutoytWvZSqKbx6OfBooKschx6B6t+ypkrkCB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQGj8tAh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso15725826d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750412897; x=1751017697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdtliVMrvWjOY640zQUb15xiizbs6LAKFEDyfvmMGQc=;
        b=ZQGj8tAhS2bgpnC87ptX0q9vqz+5CcWaLNT4tJZLyeIKO/ruNrLqybGUVgW8bUHXo2
         1nMZnZM3gWMhTkQdCqZa0E4A1kYGiajx5i+GWEArZlN3m7fDw4NWOHqhuTdiM4J/OHN2
         xR0WOfsFSfYNq5zacIccEPQH1lI6GeafosQo25IDI3OfPjTZ11ovBW5hBPGxvttaJ2/g
         8x2mfp0KvSKf6QCI+SCQfjzA3LWhf1+r/NCMjF8AxnB2s7kSCVtj1zklEhRv7QCywGeX
         a9e8lfJO5va37+kX0d1TVNsROwKDOP/MpGdVuYFEKXKnun7/IBrGEkinr7pIdvavkPEf
         G9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412897; x=1751017697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdtliVMrvWjOY640zQUb15xiizbs6LAKFEDyfvmMGQc=;
        b=LpkfCbYKFRSB++Bjx4B3t0jTHHbWoPrDxSuikKs2q1nePT19DOH0LMVltoLoopBQ5A
         QzYLdX3/bmGIEkozQE5yB6aEKaqXK00k21mPSExK0nvvkyx1F9zvoL6AyjhIIjs68oBz
         RvxAo0zpRTAK9tuj/ql76/nehIMkeEI8H4s8Zyxnzp0koGvoqz+Z0aC0Dgr75t+RVHfy
         aMnNiZvg0TcMa5V2N6W3+JQW28OLkTndAeQjvopBK65VMBP/8GvffCZkX9LzDy6CjZ7J
         N4FpMFVGwtaI9u3yMutBu0pC2hG/3sCbIj2BqQ9mimFdCtSQ8j/KN62qh3Wi0U7Znby/
         /uzA==
X-Forwarded-Encrypted: i=1; AJvYcCX95vwzaqPYAKqD+YO4UZFYvfHDOAvqp+jJpTHeYc/np4my1TnwIVVvpsqJy7cN0tgx8FDAvOnw8kaloJ/W+Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTQ/222R7k/hxmtwTXZ6pVLKYKUONiP+MRKoLYnDf9AtO5pHn
	9k2Wv0FFXDk9gkMh2g57rpOHxUDCcZQclraZ6x65ooNTdvFyaNKKXWpM7NBDB1WWlKRH1tUxUlB
	HnXgFbB6cEy89IYm9LWKZQ4yR0g6BRwMZfa/Ij1A7
X-Gm-Gg: ASbGncuMExIryEPci2B5Wc5h4whWuwJLaKUQ51f4NVMQgszslRHsIDcbLVdGQ+hLBXz
	KnHkqU0jmmCdhaasp0Ci7t5H0dt/IUzkDpxMjzTaPHISNQS+SM2TnNhy+cFIMC1VxyfXXX55N2g
	yXMwHcRkliscXWuQLquuwR2D19TkEm2urZiVeDdbndoQg9PJ/kQ1Er0PQt9jZ9K4gbnEjYesN//
	hVdgA==
X-Google-Smtp-Source: AGHT+IGYGP7SnLkzjM9/T5Xsy95Slyh2NxtweHTH1rWExcw2f5G76TAZn3tbXeICLUNovXsgPwORkl23aK2y+Ng0l78=
X-Received: by 2002:a05:6214:19cd:b0:6fa:a0af:7644 with SMTP id
 6a1803df08f44-6fd0a53189cmr39225806d6.27.1750412897416; Fri, 20 Jun 2025
 02:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-15-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-15-55e3d148cbc6@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 20 Jun 2025 17:48:03 +0800
X-Gm-Features: Ac12FXw0vvK0kNUL8PLM_I85MLksd3wdHePhrJe7vZL6QWot_OYNXjXBHL8Pg2A
Message-ID: <CABVgOSmr_0rDxC-K96o0RzfppXQiEjSWO-e8xj+0i1kUtVo8CQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] kunit: uapi: Introduce preinit executable
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fe2f9e0637fdc262"

--000000000000fe2f9e0637fdc262
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 at 15:38, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> UAPI selftests may expect a "normal" userspace environment.
> For example the normal kernel API pseudo-filesystems should be mounted.
> This could be done from kernel code but it is non-idiomatic.
>
> Add a preinit userspace executable which performs these setup steps
> before running the final test executable.
> This preinit executable is only ever run from the kernel.
> Give it access to autoconf.h and kconfig.h to adapt itself to the
> tested kernel.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Looks good and works here.

Reviewed-by: David Gow <davidgow@google.com>

(Although, personally, _I wish_ it were more idiomatic to mount things
from kernelspace.)

Cheers,
-- David


>  lib/kunit/Makefile       |  9 ++++++-
>  lib/kunit/uapi-preinit.c | 63 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  lib/kunit/uapi.c         | 11 +++++++--
>  3 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index e406a31df1df834a87961663de0b7921b59481c2..19493ec320c61e2ccbb58e8b2=
e943e9a4ec447e2 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -12,7 +12,14 @@ kunit-objs +=3D                                test.o =
\
>                                         device.o \
>                                         platform.o
>
> -kunit-$(CONFIG_KUNIT_UAPI) +=3D          uapi.o
> +userprogs +=3D                           uapi-preinit
> +uapi-preinit-nolibc :=3D                 $(CONFIG_ARCH_HAS_NOLIBC)
> +uapi-preinit-userccflags +=3D            -static \
> +                                       -include include/generated/autoco=
nf.h \
> +                                       -include $(srctree)/tools/include=
/linux/kconfig.h
> +blobs +=3D                               uapi-preinit.blob.o
> +uapi-preinit.blob-symbol :=3D            kunit_uapi_preinit
> +kunit-$(CONFIG_KUNIT_UAPI) +=3D          uapi.o uapi-preinit.blob.o
>
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=3D                          debugfs.o
> diff --git a/lib/kunit/uapi-preinit.c b/lib/kunit/uapi-preinit.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..81182039965a8c93aebb2d5d7=
6f4113bfef277a6
> --- /dev/null
> +++ b/lib/kunit/uapi-preinit.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit Userspace environment setup.
> + *
> + * Copyright (C) 2025, Linutronix GmbH.
> + * Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> + *
> + * This is *userspace* code.
> + */
> +
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +
> +#include "../../tools/testing/selftests/kselftest.h"
> +
> +static int setup_api_mount(const char *target, const char *fstype)
> +{
> +       int ret;
> +
> +       ret =3D mkdir(target, 0755);
> +       if (ret && errno !=3D EEXIST)
> +               return -errno;
> +
> +       ret =3D mount("none", target, fstype, 0, NULL);
> +       if (ret && errno !=3D EBUSY)
> +               return -errno;
> +
> +       return 0;
> +}
> +
> +static void exit_failure(const char *stage, int err)
> +{
> +       /* If preinit fails synthesize a failed test report. */
> +       ksft_print_header();
> +       ksft_set_plan(1);
> +       ksft_test_result_fail("Failed during test setup: %s: %s\n", stage=
, strerror(-err));
> +       ksft_finished();
> +}
> +
> +int main(int argc, char **argv, char **envp)
> +{
> +       int ret;
> +
> +       ret =3D setup_api_mount("/proc", "proc");
> +       if (ret)
> +               exit_failure("mount /proc", ret);
> +
> +       ret =3D setup_api_mount("/sys", "sysfs");
> +       if (ret)
> +               exit_failure("mount /sys", ret);
> +
> +       if (IS_ENABLED(CONFIG_DEVTMPFS)) {
> +               ret =3D setup_api_mount("/dev", "devtmpfs");
> +               if (ret)
> +                       exit_failure("mount /dev", ret);
> +       }
> +
> +       ret =3D execve(argv[0], argv, envp);
> +       if (ret)
> +               exit_failure("execve", ret);
> +
> +       return 0;
> +}
> diff --git a/lib/kunit/uapi.c b/lib/kunit/uapi.c
> index 121146dda533b3f90aca37c20bd0e7a1d20cb3b5..bccc081a6538507724c1ef340=
203cfd147170dc4 100644
> --- a/lib/kunit/uapi.c
> +++ b/lib/kunit/uapi.c
> @@ -139,7 +139,7 @@ static int kunit_uapi_user_mode_thread_init(void *dat=
a)
>         kernel_sigaction(SIGABRT, SIG_DFL);
>
>         complete(&ctx->setup_done);
> -       ctx->exec_err =3D kernel_execve(ctx->executable, argv, NULL);
> +       ctx->exec_err =3D kernel_execve(kbasename(BLOB(kunit_uapi_preinit=
)->path), argv, NULL);
>         if (!ctx->exec_err)
>                 return 0;
>         do_exit(0);
> @@ -239,6 +239,7 @@ static int kunit_uapi_run_executable_in_mount(struct =
kunit *test, const char *ex
>
>  static int kunit_uapi_run_executable(struct kunit *test, const struct bl=
ob *executable)
>  {
> +       const struct blob *preinit =3D BLOB(kunit_uapi_preinit);
>         const char *exe_name =3D kbasename(executable->path);
>         struct vfsmount *mnt;
>         int err;
> @@ -247,7 +248,13 @@ static int kunit_uapi_run_executable(struct kunit *t=
est, const struct blob *exec
>         if (IS_ERR(mnt))
>                 return PTR_ERR(mnt);
>
> -       err =3D kunit_uapi_write_file(mnt, exe_name, 0755, executable->da=
ta, blob_size(executable));
> +       err =3D kunit_uapi_write_file(mnt, kbasename(preinit->path), 0755=
,
> +                                   preinit->data,
> +                                   blob_size(preinit));
> +
> +       if (!err)
> +               err =3D kunit_uapi_write_file(mnt, exe_name, 0755,
> +                                           executable->data, blob_size(e=
xecutable));
>
>         if (!err)
>                 err =3D kunit_uapi_run_executable_in_mount(test, exe_name=
, mnt);
>
> --
> 2.49.0
>

--000000000000fe2f9e0637fdc262
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAFFwOy5zrkc9g75Fk3jHNEw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTA2MDEwODEx
MTdaFw0yNTExMjgwODExMTdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqxNhYGgWa19wqmZKM9x36vX1Yeody+Yaf
r0MV27/mVFHsaMmnN5CpyyGgxplvPa4qPwrBj+5kp3o7syLcqCX0s8cUb24uZ/k1hPhDdkkLbb9+
2Tplkji3loSQxuBhbxlMC75AhqT+sDo8iEX7F4BZW76cQBvDLyRr/7VG5BrviT5zFsfi0N62WlXj
XMaUjt0G6uloszFPOWkl6GBRRVOwgLAcggqUjKiLjFGcQB5GuyDPFPyTR0uQvg8zwSOph7TNTb/F
jyics8WBCAj6iSmMX96uJ3Q7sdtW3TWUVDkHXB3Mk+9E2P2mRw3mS5q0VhNLQpFrox4/gXbgvsji
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgs4VcxKYjtKh6NTZuUwJLHTBnO1Um
GVIEtaLUncX1XocwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NjIwMDk0ODE3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAIWzJZQOQEcyCknyZ2DOVAfbXx3LURsX9h4sbV2IiAUN5cW8NWUMo/jl/i/zX592l
z74sta1itA8W5zi2vC9HSjVVZFnyVtrs8ISB8p/J14zLSS1RSc1Mp1tlt03MLaJF5i/xl/1UKb2W
RrmxuH+p1h1gHnzCuZqwM29rnYWuhfKMf/YcKeQKzuKuzTGF4Iqlr6/BMfIIwrW4sUI0qlpNKP8f
2i70xkgvrWv3XtKxniHudv8d9EEdIiVldfg7qRQVrFhu+YsTp377WL+b0eaXeG7E+BgSPqE2e+Bw
uC/lxKmmyH/MnlFz+7seKkqinivq2t0uPurADJwllM4wz7d8VQ==
--000000000000fe2f9e0637fdc262--

