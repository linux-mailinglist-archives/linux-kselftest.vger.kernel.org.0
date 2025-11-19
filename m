Return-Path: <linux-kselftest+bounces-46015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CF5C705C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AE7D42427D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3430BBA0;
	Wed, 19 Nov 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzcZXOwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58052E0901
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572432; cv=none; b=I+5ACJCu2EZ3XVGfXjnJUemGih/T4NcOP1jggkD6LEiQMRlOp57Zs6T4PpeWN11XBThYyCQy/7MvIlrEwG9V/nUbx6zv49w/YDyLW4aAZDjs2Di9juaM5gKRLqBoqjCx/d5/JxXRUtlQRx5aZU2wSUM4E2AixnltNNA+f9FMxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572432; c=relaxed/simple;
	bh=2jOa40fCWLJwO6x4wEQKu8utEBedo9IQRwAWkjeLou0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAC35t0v9ILcJSvYD81Pc4zFfYwdFT6vX0mIJDALmrdJNfJQFwZi7JqzG3+5f3a39hciBgDL/wsFg6AIEsVWv0cUUXRqBVyBuicgWzNz2q4qDmH1kda9QJstKYZT9PwG3eyEXf5wSjFm2lcs5XNR6i88KnuxM9V80nW5xeONoOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzcZXOwO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso12264212a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763572428; x=1764177228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ScLEPaDNKwNDHYN2M6HmBfbD1YaSDauJ2NXX4LmK1I=;
        b=VzcZXOwOIToIFXOkRAE4AU+nfJUMm+YLueQu/6M3QyORnwBuY+3/5S8zbPhtuJ6Jbz
         1E6ov4k6+ae8ZNYuPKso8mJAzyAPCClIS7tlTO+xtLfnwVl5PHA1idYH7H67ODF1mnVA
         AAAK6ipVX35VHSU6baQ7jb6fl9leuxoJQXFS45QEbKAu5PrrC1XkRlzyc4ER4LfkYE23
         rf/AK0IrIViSoXuMXrJrztGU9Nt5vXMdj3nCBxrPgWFunnLWsXe17Nj8jN9WYnkQN/KG
         R6vPIX7NzB37+ygGXA+0pcGu4YCPNVErS19gkIlII83Bej4W71SG6P6x7cbmxxBn4FCM
         +ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572428; x=1764177228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ScLEPaDNKwNDHYN2M6HmBfbD1YaSDauJ2NXX4LmK1I=;
        b=RT89L2a7X775UahhoP9fZm5r6Izqyj9gSPTvizppoTbJcB+hJw9HkAYe8NFyKt6gct
         JA88roM28x2KOcQ9Yqgu85cSBfrTzNi52jrlNp7wqg3S8Cbz6xYvkKg/xspJo4grnze+
         3jCEVvapPU76HznJYUlPXXEl5wqbqPIjCZ3d5O2GHR79xy0QAJ1iFJMJCR4Fqs8hZdHG
         tlJh/zh5gANGHWCLL/qgMLgJLW2h2KVtlMeKWi7bwE/sC4/5MRESus4envAo8Z9/WHnY
         82fdTSEDPft/Y8+2cjLnYL9eaO+3edlRVRPqqV33Ck7d15eCLGvHkPkMsswWvzI5rHfq
         B9rg==
X-Forwarded-Encrypted: i=1; AJvYcCW6g0em+AzFdyf6HEkuK/ufjZpO5IaMU3SeBx7oBMfoypzy0cKQ6pDcrJoUFxACxYbxnWcW4kv1nHw/uAdSgWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydgWJm+YFcl0dGQfNGLECuQNqR94Dtj6UVanyoOqMYe/KSkjG
	9vSE9nS/7rG8+BlOI/c7Y/N1LK/klJH60do4XX8fY0jRop8AqNqT2B5TsscGrAPU02omvyOLNO4
	+mddOQNG6CKlkaNhUJAwyxI5KDAqwsCQ=
X-Gm-Gg: ASbGncsM+lqVzBxpv1zXtQVMv0/SXgwhsFt2yw293YLJOjMbllymjg3wGy3qsPn1H/y
	NvjFSm+j5/a1bDLrtKIb8Uf27pqFgDoUMp5Tgc7Z4/7SvjBnx6DSMmEkZmpScJWFHgYvOJqmUzk
	GU1mTElR8bk/+hWr1Lw6nNLhZGi5j+p9oUKtxxElkH5te3AI7TaZIeEo44zZOzdG+sPdSXsu7K+
	zPVTOQYgv5EomdMCZ3PKVuiFfkrSrPkkAwgHqtf8T8DzdzspjSYY8IV+sKe9rLbTEHeqjFerx8q
	Kvz6SlOmB74W5Q==
X-Google-Smtp-Source: AGHT+IGPqudSHkAepFQ3b+rHTQnc4FElpTzu4SX+b8Uq9wDSKvNcGP8RyB4VJ8j96k9r9CqmCjCNXNverRt/OiFLdaU=
X-Received: by 2002:a17:907:d9e:b0:b73:9792:919b with SMTP id
 a640c23a62f3a-b739792959cmr1395383666b.13.1763572427760; Wed, 19 Nov 2025
 09:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108194207.1257866-1-geomatsi@gmail.com> <20251108194207.1257866-2-geomatsi@gmail.com>
In-Reply-To: <20251108194207.1257866-2-geomatsi@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 19 Nov 2025 11:13:36 -0600
X-Gm-Features: AWmQ_bmYPTA3o-mmhZqHQ7F4r325dcAcnrVFdesuISHWwObV6P-SoMU0wqhgGqg
Message-ID: <CAFTtA3PK8kU6dsHdOT8Gj=ov9UbguSWv8+aQjtnvkx6hFWZGkg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] selftests: riscv: test ptrace vector interface
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Joel Granados <joel.granados@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 1:42=E2=80=AFPM Sergey Matyukevich <geomatsi@gmail.c=
om> wrote:
>
> Add a test case to check ptrace behavior in the case when vector
> extension is supported by the system, but vector context is not
> yet enabled for the traced process.
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  .../testing/selftests/riscv/vector/.gitignore |  1 +
>  tools/testing/selftests/riscv/vector/Makefile |  5 +-
>  .../testing/selftests/riscv/vector/v_ptrace.c | 85 +++++++++++++++++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c
>
> diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/test=
ing/selftests/riscv/vector/.gitignore
> index 7d9c87cd0649..d21c03c3ee0e 100644
> --- a/tools/testing/selftests/riscv/vector/.gitignore
> +++ b/tools/testing/selftests/riscv/vector/.gitignore
> @@ -2,3 +2,4 @@ vstate_exec_nolibc
>  vstate_prctl
>  v_initval
>  v_exec_initval_nolibc
> +v_ptrace
> diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testin=
g/selftests/riscv/vector/Makefile
> index 6f7497f4e7b3..c14ad127e7fb 100644
> --- a/tools/testing/selftests/riscv/vector/Makefile
> +++ b/tools/testing/selftests/riscv/vector/Makefile
> @@ -2,7 +2,7 @@
>  # Copyright (C) 2021 ARM Limited
>  # Originally tools/testing/arm64/abi/Makefile
>
> -TEST_GEN_PROGS :=3D v_initval vstate_prctl
> +TEST_GEN_PROGS :=3D v_initval vstate_prctl v_ptrace
>  TEST_GEN_PROGS_EXTENDED :=3D vstate_exec_nolibc v_exec_initval_nolibc
>
>  include ../../lib.mk
> @@ -26,3 +26,6 @@ $(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.=
o $(OUTPUT)/v_helpers.o
>  $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
>         $(CC) -nostdlib -static -include ../../../../include/nolibc/nolib=
c.h \
>                 -Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
> +
> +$(OUTPUT)/v_ptrace: v_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpe=
rs.o
> +       $(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/test=
ing/selftests/riscv/vector/v_ptrace.c
> new file mode 100644
> index 000000000000..6a4b5a2ab4a2
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <sys/ptrace.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/wait.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +
> +#include <linux/ptrace.h>
> +#include <linux/elf.h>
> +
> +#include "../../kselftest_harness.h"
> +#include "v_helpers.h"
> +
> +volatile unsigned long chld_lock;
> +
> +TEST(ptrace_v_not_enabled)
> +{
> +       pid_t pid;
> +
> +       if (!is_vector_supported())
> +               SKIP(return, "Vector not supported");
> +
> +       chld_lock =3D 1;
> +       pid =3D fork();
> +       ASSERT_LE(0, pid)
> +               TH_LOG("fork: %m");
> +
> +       if (pid =3D=3D 0) {
> +               while (chld_lock =3D=3D 1)
> +                       asm volatile("" : : "g"(chld_lock) : "memory");
> +
> +               asm volatile ("ebreak" : : : );
> +       } else {
> +               struct __riscv_v_regset_state *regset_data;
> +               unsigned long vlenb;
> +               size_t regset_size;
> +               struct iovec iov;
> +               int status;
> +               int ret;
> +
> +               asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=3Dr"(vlen=
b));
> +
> +               ASSERT_GT(vlenb, 0)
> +                       TH_LOG("vlenb is not valid: %lu\n", vlenb);
> +
> +               /* attach */
> +
> +               ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
> +               ASSERT_EQ(pid, waitpid(pid, &status, 0));
> +               ASSERT_TRUE(WIFSTOPPED(status));
> +
> +               /* unlock */
> +
> +               ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &chld_lock, 0))=
;
> +
> +               /* resume and wait for ebreak */
> +
> +               ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
> +               ASSERT_EQ(pid, waitpid(pid, &status, 0));
> +               ASSERT_TRUE(WIFSTOPPED(status));
> +
> +               /* try to read vector registers from the tracee */
> +
> +               regset_size =3D sizeof(*regset_data) + vlenb * 32;
> +               regset_data =3D calloc(1, regset_size);
> +
> +               iov.iov_base =3D regset_data;
> +               iov.iov_len =3D regset_size;
> +
> +               /* V extension is available, but not yet enabled for the =
tracee */
> +
> +               errno =3D 0;
> +               ret =3D ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &i=
ov);
> +               ASSERT_EQ(ENODATA, errno);
> +               ASSERT_EQ(-1, ret);
> +
> +               /* cleanup */
> +
> +               ASSERT_EQ(0, kill(pid, SIGKILL));
> +       }
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.51.0
>

