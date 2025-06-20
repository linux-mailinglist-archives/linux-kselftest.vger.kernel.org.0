Return-Path: <linux-kselftest+bounces-35421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87849AE181C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFDF1BC500C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C327FB2E;
	Fri, 20 Jun 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXOXzv8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1021BE86E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412877; cv=none; b=HiWHALvZyEC6GLTm6QyDmzfz9WRQ+gt3LRKG5na0WR5O/jJ6mceoAhfs12xSOe5/8hSE2r4SQcuVpCPWeIb78TcWq0cJ0WiEmMqjYT74vGezebDz9F6m9MST5sFzvCinVZ3BNgWsFs/lJZLXBG9LzIFoZHhiT4lli1GiM0auacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412877; c=relaxed/simple;
	bh=Fa5HxNTCOHqBpDTofBIC2j0pr/ssUiGewEFU+2V52eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goTr7/iIe2s5oPcHlKExw9RzaojAo0U8QjzfM1Ms+orpv0TpzG9KpbSuvhI2dNErzeRu6uN93otb7AthTZmFvFbDyQC+u36F1VYEBJez9xzQHkWySwPFnt3Ih8lkE6zSrHSG+trw2FObRtpZ/oABhLQ8sXD5YvJStix85mf+auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXOXzv8T; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so24302116d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750412873; x=1751017673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhHl0QzJFJnL7XbdUu9QiDwwfgv16BNM+J4m/9l+AS4=;
        b=OXOXzv8TjZLjkLuZrfbYMqS+yOakJ5b7jOqZO2fIlQCUdHqgWisdxfuThKqS+XWyJP
         uVcEnUW5Rl+BXTJeV03ulCQ14LVYugfE5XGDgjOH9PFOjpwGjxl/D8GIx8lrPOrqZ/4B
         qj3wOYWVgYBWotfSzW285+r5KLq4XEOlLmS/+Kzopb2JYHeJC5AAQImLlHXKOjmXUMj0
         hVSmqujjH3Ie8CTUpvAJCEStSlTmQkkQxZ6H84rSRM0UUskUlqWQlR4l0pxRHX7toWq7
         R7RAhMSFxBz8EYg22kjnf7bDUjR88Tn7KKb3/WV97o14eQf3mSt18Pnih9C9xZikDjE7
         XQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412873; x=1751017673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhHl0QzJFJnL7XbdUu9QiDwwfgv16BNM+J4m/9l+AS4=;
        b=u+pSF89QoZ36IPXfuoBvNDeUSk/W6J4f6TMl5lqdt9lw+fpBO2Ly7LL3Gm7tQ50nPa
         4m2hvE9PBwGsXb879hCcyOiIKgT3Utkta3oNkIdtJEDI9phyARbAMc68c5KzHssQoabA
         NNyNMt2P4V9Gs990YB/LnMijde1pno8cdkW5HWUlSwjfoA5LioFsymwVwJ6Je20fkMSK
         wOImQGD8btNbM61Brp1THMf+wB4FkUo2UqdC9p6vxVM2jlp+lmZIahJYIPlpDkvp2hpq
         JR7Wy8Lt6gcUZSsUch9/5kJcDAsQnO5hZSKd6sQvvYRZR74zzB1y2OMbO33KG8o+dyQe
         p+sg==
X-Forwarded-Encrypted: i=1; AJvYcCWhJBtjKHrYdgf2qq3/w0S+HN3c4HCV5dAF7XMLqdQqTMJJvH7EBRLjNF4wvoRhoS3yTpJ0OUgoIXJnmFjtTUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNR6zy7Z+oj1ScfdvqB/LFmQGFbMmHdxFKg1FZ50Y1VpDGFWsR
	0LYYQyFASzCVTfpbS03mXcVAXryJAwnrRrMA8omKGXcb5611gW3T8ehcojg4qCc0D+YjQx1sEJO
	Lg3TTf6Gu5W7s2LODYY29drKTXKhP61ZitGo9eot6
X-Gm-Gg: ASbGnctTUyA9dhSH/C3MQRWu5Dt1bQmFiq1meNbEhLaCAiZWFO094cbzOJSMdH9n0SV
	6j8zBOEkGgnNaFGYMQL8nyCxfE8JNrYD92wnBTs7JX3zGeFI3+bodqULog4f/r9ILNXs4VT1+4W
	O7TJFfJXQh2VQ2Y9uE2e1njFNwZ0nbjKwTj6FRfd/3aHz3i8tQU/Sp0jnAb9keCZjw+gcqmPEqd
	/9+Pw==
X-Google-Smtp-Source: AGHT+IHCGzQiP9CoGn78oFXm7GG9cJ2j2G+bhX3F++LMsSLfCrbMShIHuTWLQHphIpCfEmf02xMc7nJ8bWdmwSrhFzc=
X-Received: by 2002:a05:6214:e8c:b0:6fa:9a6a:7d03 with SMTP id
 6a1803df08f44-6fd0a46a25cmr38800396d6.7.1750412872214; Fri, 20 Jun 2025
 02:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-13-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-13-55e3d148cbc6@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 20 Jun 2025 17:47:39 +0800
X-Gm-Features: Ac12FXx_BlS7BHHL9NkeffPaXzgrAycoeiIR7KaWT2kxyBUQ0Md-rQdk8rWlmgs
Message-ID: <CABVgOSmdcOZ0+-k=SM4LibOVMKtcbF27p6N40kuDX_axTPZ=QQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] kunit: Introduce UAPI testing framework
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
	boundary="00000000000082447c0637fdc1b0"

--00000000000082447c0637fdc1b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 at 15:38, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Enable running UAPI tests as part of kunit.
> The selftests are embedded into the kernel image and their output is
> forwarded to kunit for unified reporting.
>
> The implementation reuses parts of usermode drivers and usermode
> helpers. However these frameworks are not used directly as they make it
> impossible to retrieve a thread's exit code.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>
> ---

It feels to me like there are three features hidden in here:
- KUnit helpers for manipulating vfs files
- A way of having KUnit tests run userspace helpers
- The full framework for writing/running whole tests in userspace.

It's really the first two which excite me personally most -- as they
give us a sort-of inverse to the kselftest "helper module" paradigm --
so we can test things which are impossible to test from within
kernelspace. So maybe those APIs should be exposed separately (so a
test can be written mostly in kernel-space using the KUnit framework
APIs, and just call out to a helper where needed). But I'm happy for
them to stay private functions until we have a test which actually
needs them.


> Currently this depends on CONFIG_KUNIT=3Dy as it uses some non-exported
> symbols around process management.

That's fine for now, IMHO, but will make it difficult to use this on,
e.g., Red Hat setups, where CONFIG_KUNIT=3Dm. Hopefully we can resolve
this by exporting some of the symbols?


In general, I'm happy with the implementation here. The fs stuff
probably needs a closer look from someone who knows the vfs better
than me, though.

Nevertheless,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> ---
>  Documentation/dev-tools/kunit/api/index.rst |   5 +
>  Documentation/dev-tools/kunit/api/uapi.rst  |  12 ++
>  include/kunit/uapi.h                        |  24 +++
>  lib/kunit/Kconfig                           |  10 +
>  lib/kunit/Makefile                          |   2 +
>  lib/kunit/uapi.c                            | 287 ++++++++++++++++++++++=
++++++
>  6 files changed, 340 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/=
dev-tools/kunit/api/index.rst
> index 5cdb552a0808f25baeff5e47a9227b7b62c69e40..34d8fee9a97059d6da919a6fb=
1a7e359b5e0beef 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -9,6 +9,7 @@ API Reference
>         test
>         resource
>         functionredirection
> +       uapi
>         clk
>         of
>         platformdevice
> @@ -32,6 +33,10 @@ Documentation/dev-tools/kunit/api/functionredirection.=
rst
>
>   - Documents the KUnit Function Redirection API
>
> +Documentation/dev-tools/kunit/api/uapi.rst
> +
> + - Documents the KUnit Userspace testing API
> +
>  Driver KUnit API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/Documentation/dev-tools/kunit/api/uapi.rst b/Documentation/d=
ev-tools/kunit/api/uapi.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..b4764424c629bf69194cf2786=
f52aef154b02bf8
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/api/uapi.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Userspace Test API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This file documents all of the userspace testing API.
> +Userspace tests should be built as :ref:`userprogs <kbuild_userprogs>` a=
nd included into the test
> +module or kernel as :ref:`blobs <kbuild_blobs>`.
> +
> +.. kernel-doc:: include/kunit/uapi.h
> +   :internal:
> diff --git a/include/kunit/uapi.h b/include/kunit/uapi.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a6181790c96a42df058390979=
91c1fbfd889cdbe
> --- /dev/null
> +++ b/include/kunit/uapi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit Userspace testing API.
> + *
> + * Copyright (C) 2025, Linutronix GmbH.
> + * Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> + */
> +
> +#ifndef _KUNIT_UAPI_H
> +#define _KUNIT_UAPI_H
> +
> +struct blob;
> +struct kunit;
> +
> +/**
> + * kunit_uapi_run_kselftest() - Run a userspace kselftest as part of kun=
it
> + * @test: The test context object.
> + * @executable: kselftest executable to run
> + *
> + * Runs the kselftest and forwards its TAP output and exit status to kun=
it.
> + */
> +void kunit_uapi_run_kselftest(struct kunit *test, const struct blob *exe=
cutable);
> +
> +#endif /* _KUNIT_UAPI_H */
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..1f2f5f2213a7d8438cd268395=
5f22e34f3a036dd 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -93,4 +93,14 @@ config KUNIT_AUTORUN_ENABLED
>           In most cases this should be left as Y. Only if additional opt-=
in
>           behavior is needed should this be set to N.
>
> +config KUNIT_UAPI
> +       def_bool y

Maybe it's worth making this configurable separately? I could imagine
people wanting an easy way to build a kernel without all of the test
blobs built-in.

> +       depends on KUNIT=3Dy
> +       depends on CC_CAN_LINK_STATIC || ARCH_HAS_NOLIBC
> +       select HEADERS_INSTALL
> +       help
> +         Enables support for building and running userspace selftests as=
 part of kunit.
> +         These tests should be statically linked and use kselftest.h or =
kselftest_harness.h
> +         for status reporting.
> +
>  endif # KUNIT
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 656f1fa35abcc635e67d5b4cb1bc586b48415ac5..dafa09bd4241c24d31c4c19ed=
ecb67bf724127d7 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -12,6 +12,8 @@ kunit-objs +=3D                         test.o \
>                                         device.o \
>                                         platform.o
>
> +kunit-$(CONFIG_KUNIT_UAPI) +=3D          uapi.o
> +
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=3D                          debugfs.o
>  endif
> diff --git a/lib/kunit/uapi.c b/lib/kunit/uapi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..121146dda533b3f90aca37c20=
bd0e7a1d20cb3b5
> --- /dev/null
> +++ b/lib/kunit/uapi.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit Userspace testing API.
> + *
> + * Copyright (C) 2025, Linutronix GmbH.
> + * Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> + */
> +
> +#include <linux/binfmts.h>
> +#include <linux/blob.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/fs_struct.h>
> +#include <linux/pid.h>
> +#include <linux/pipe_fs_i.h>
> +#include <linux/sched/task.h>
> +#include <linux/types.h>
> +
> +#include <kunit/test.h>
> +#include <kunit/uapi.h>
> +
> +#define KSFT_PASS      0
> +#define KSFT_FAIL      1
> +#define KSFT_XFAIL     2
> +#define KSFT_XPASS     3
> +#define KSFT_SKIP      4
> +
> +static struct vfsmount *kunit_uapi_mount_ramfs(void)
> +{
> +       struct file_system_type *type;
> +       struct vfsmount *mnt;
> +
> +       type =3D get_fs_type("ramfs");
> +       if (!type)
> +               return ERR_PTR(-ENODEV);
> +
> +       /* FIXME
> +        * The mount setup is supposed to look like this:
> +        * kunit_uapi_mount_ramfs() sets up a private mount,
> +        * with nothing visible except the new tmpfs.
> +        * Then each executable execution gets a new namespace on top of =
that
> +        * on which it can mount whatever it needs.
> +        * However I didn't manage to set this up, so keep everything sim=
ple
> +        * for now and let somebody familiar with the VFS figure this out=
.
> +        */
> +
> +       mnt =3D kern_mount(type);
> +       put_filesystem(type);
> +
> +       return mnt;
> +}
> +
> +static int kunit_uapi_write_file(struct vfsmount *mnt, const char *name,=
 mode_t mode,
> +                                const u8 *data, size_t size)
> +{
> +       struct file *file;
> +       ssize_t written;
> +
> +       file =3D file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, mode);
> +       if (IS_ERR(file))
> +               return PTR_ERR(file);
> +
> +       written =3D kernel_write(file, data, size, NULL);
> +       filp_close(file, NULL);
> +       if (written !=3D size) {
> +               if (written >=3D 0)
> +                       return -ENOMEM;
> +               return written;
> +       }
> +
> +       /* Flush delayed fput so exec can open the file read-only */
> +       flush_delayed_fput();
> +
> +       return 0;
> +}
> +
> +struct kunit_uapi_user_mode_thread_ctx {
> +       const char *executable;
> +
> +       /* Signals mnt, out, pwd and tgid */
> +       struct completion setup_done;
> +       struct vfsmount *mnt;
> +       struct file *out;
> +       struct path pwd;
> +       pid_t tgid;
> +
> +       /* Valid after wait(tgid) */
> +       int exec_err;
> +};
> +
> +static int kunit_uapi_user_mode_thread_init(void *data)
> +{
> +       struct kunit_uapi_user_mode_thread_ctx *ctx =3D data;
> +       const char *const argv[] =3D {
> +               ctx->executable,
> +               NULL
> +       };
> +       struct file *out[2];
> +       int err;
> +
> +       err =3D create_pipe_files(out, 0);
> +       if (err)
> +               return err;
> +
> +       /* stdin, use the *write* end to the pipe to have an unreadable i=
nput */
> +       err =3D replace_fd(0, out[1], 0);
> +       if (err < 0) {
> +               fput(out[0]);
> +               fput(out[1]);
> +               return err;
> +       }
> +
> +       /* stdout */
> +       err =3D replace_fd(1, out[1], 0);
> +       if (err < 0) {
> +               replace_fd(0, NULL, 0);
> +               fput(out[0]);
> +               fput(out[1]);
> +               return err;
> +       }
> +
> +       /* stderr */
> +       err =3D replace_fd(2, out[1], 0);
> +       if (err < 0) {
> +               replace_fd(0, NULL, 0);
> +               replace_fd(1, NULL, 0);
> +               fput(out[0]);
> +               fput(out[1]);
> +               return err;
> +       }
> +
> +       fput(out[1]);
> +
> +       ctx->out =3D out[0];
> +       ctx->tgid =3D current->tgid;
> +
> +       set_fs_pwd(current->fs, &ctx->pwd);
> +       kernel_sigaction(SIGKILL, SIG_DFL);
> +       kernel_sigaction(SIGABRT, SIG_DFL);
> +
> +       complete(&ctx->setup_done);
> +       ctx->exec_err =3D kernel_execve(ctx->executable, argv, NULL);
> +       if (!ctx->exec_err)
> +               return 0;
> +       do_exit(0);
> +}
> +
> +static size_t kunit_uapi_printk_subtest_lines(struct kunit *test, char *=
buf, size_t s)
> +{
> +       const char *ptr =3D buf, *newline;
> +       size_t n;
> +
> +       while (s) {
> +               newline =3D strnchr(ptr, s, '\n');
> +               if (!newline)
> +                       break;
> +
> +               n =3D newline - ptr + 1;
> +
> +               kunit_log(KERN_INFO, test, KUNIT_SUBSUBTEST_INDENT "%.*s"=
, (int)n, ptr);
> +               ptr +=3D n;
> +               s -=3D n;
> +       }
> +
> +       memmove(buf, ptr, s);
> +
> +       return s;
> +}
> +
> +static int kunit_uapi_forward_to_printk(struct kunit *test, struct file =
*output)
> +{
> +       /*
> +        * printk() automatically adds a newline after each message.
> +        * Therefore only fully accumulated lines can be forwarded.
> +        * Each line needs to fit into the buffer below.
> +        */
> +       char buf[512];
> +       size_t s =3D 0;
> +       ssize_t n;
> +
> +       while (1) {
> +               n =3D kernel_read(output, buf + s, sizeof(buf) - s, NULL)=
;
> +               if (n <=3D 0)
> +                       return n;
> +               s =3D kunit_uapi_printk_subtest_lines(test, buf, s + n);
> +       }
> +}
> +
> +static void kunit_uapi_kill_pid(pid_t pid)
> +{
> +       struct pid *p;
> +
> +       p =3D find_get_pid(pid);
> +       kill_pid(p, SIGKILL, 1);
> +       put_pid(p);
> +}
> +
> +static int kunit_uapi_run_executable_in_mount(struct kunit *test, const =
char *executable,
> +                                                  struct vfsmount *mnt)
> +{
> +       struct kunit_uapi_user_mode_thread_ctx ctx =3D {
> +               .setup_done     =3D COMPLETION_INITIALIZER_ONSTACK(ctx.se=
tup_done),
> +               .executable     =3D executable,
> +               .pwd            =3D {
> +                       .mnt    =3D mnt,
> +                       .dentry =3D mnt->mnt_root,
> +               },
> +       };
> +       int forward_err, wait_err, ret;
> +       pid_t pid;
> +
> +       /* If SIGCHLD is ignored do_wait won't populate the status. */
> +       kernel_sigaction(SIGCHLD, SIG_DFL);
> +       pid =3D user_mode_thread(kunit_uapi_user_mode_thread_init, &ctx, =
SIGCHLD);
> +       if (pid < 0) {
> +               kernel_sigaction(SIGCHLD, SIG_IGN);
> +               return pid;
> +       }
> +
> +       wait_for_completion(&ctx.setup_done);
> +
> +       forward_err =3D kunit_uapi_forward_to_printk(test, ctx.out);
> +       if (forward_err)
> +               kunit_uapi_kill_pid(ctx.tgid);
> +
> +       wait_err =3D kernel_wait(ctx.tgid, &ret);
> +
> +       /* Restore default kernel sig handler */
> +       kernel_sigaction(SIGCHLD, SIG_IGN);
> +
> +       if (ctx.exec_err)
> +               return ctx.exec_err;
> +       if (forward_err)
> +               return forward_err;
> +       if (wait_err < 0)
> +               return wait_err;
> +       return ret;
> +}
> +
> +static int kunit_uapi_run_executable(struct kunit *test, const struct bl=
ob *executable)
> +{
> +       const char *exe_name =3D kbasename(executable->path);
> +       struct vfsmount *mnt;
> +       int err;
> +
> +       mnt =3D kunit_uapi_mount_ramfs();
> +       if (IS_ERR(mnt))
> +               return PTR_ERR(mnt);
> +
> +       err =3D kunit_uapi_write_file(mnt, exe_name, 0755, executable->da=
ta, blob_size(executable));
> +
> +       if (!err)
> +               err =3D kunit_uapi_run_executable_in_mount(test, exe_name=
, mnt);
> +
> +       kern_unmount(mnt);
> +
> +       return err;
> +}
> +
> +void kunit_uapi_run_kselftest(struct kunit *test, const struct blob *exe=
cutable)
> +{
> +       u8 exit_code, exit_signal;
> +       int err;
> +
> +       err =3D kunit_uapi_run_executable(test, executable);
> +       if (err < 0)
> +               KUNIT_FAIL(test, "Could not run test executable: %pe\n", =
ERR_PTR(err));
> +
> +       exit_code =3D err >> 8;
> +       exit_signal =3D err & 0xff;
> +
> +       if (exit_signal)
> +               KUNIT_FAIL(test, "kselftest exited with signal: %d\n", ex=
it_signal);
> +       else if (exit_code =3D=3D KSFT_PASS)
> +               ; /* Noop */
> +       else if (exit_code =3D=3D KSFT_FAIL)
> +               KUNIT_FAIL(test, "kselftest exited with code KSFT_FAIL\n"=
);
> +       else if (exit_code =3D=3D KSFT_XPASS)
> +               KUNIT_FAIL(test, "kselftest exited with code KSFT_XPASS\n=
");
> +       else if (exit_code =3D=3D KSFT_XFAIL)
> +               ; /* Noop */
> +       else if (exit_code =3D=3D KSFT_SKIP)
> +               kunit_mark_skipped(test, "kselftest exited with code KSFT=
_SKIP\n");
> +       else
> +               KUNIT_FAIL(test, "kselftest exited with unknown exit code=
: %d\n", exit_code);
> +}
> +EXPORT_SYMBOL_GPL(kunit_uapi_run_kselftest);
>
> --
> 2.49.0
>

--00000000000082447c0637fdc1b0
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
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
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgcutP6NJCb85IQJuV/sWPoU7YzxlE
AsYqhdc29JKnRmcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NjIwMDk0NzUzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAD0uesPC9YgYyLjPcmYIB7XAhHa9mssGZwEWobWXJVpOj53JgdxYx/8HIAB0eZ+GX
ITD2wXpjULzEgrD4MsXRf7kfqMGhKysOB6NqTbaKecSLBtoJxoy6/7aPfwGln+pnMPy3j++jOy5G
Ne4t6BZmDEei6nXcZ9Bg7zDGBnUuWR0XttIre9QzdR/bI65pXwuBVmcv/KHqYjYwTm1RjcbwOp9l
rJa3uPqUWjroTIdUNeKUoOSe16WZ62G5RT+iyVBMbMH1a2Y/CUdSFWb8ln5AhK5q1Gl+ekHotc8D
obe9/W6jk9IWBQIDfDnrnmpw5CXT4bujBSP+/ZTixfSb5Tw3DQ==
--00000000000082447c0637fdc1b0--

