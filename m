Return-Path: <linux-kselftest+bounces-42656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1BBBB1012
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502701C0691
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C2265CD0;
	Wed,  1 Oct 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6rEkY0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099F25DB1A
	for <linux-kselftest@vger.kernel.org>; Wed,  1 Oct 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331585; cv=none; b=U4fNAtqZjC2ZvhbiPsVAoGnJVenbuUgDfzTvAi9bvIBS8YJMTBjlM5BFjmjhvPP/MRwBLmMVDp7qNQpxcEbKMuIO8ElOaytQq4jjk9s6LACwi2Lp5/h7yY63RPBqU+k/BtpJmTK0gDBCmv5oPmNVaDRMJkIjPUcBdk10VBrL3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331585; c=relaxed/simple;
	bh=cBTQbubFHk/p43qF50UFte2bzCBJxRCCG61aIRtyjQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edChcr7kkbygyo3/u4LR93f1ajFzxqIkATmqPxZ3g2HK1pjl4IoNeVyXIviV8WZ2o7xjWBX4O0UTBAY3R4nwY+hvA7MU6LpUY2qUmuZ24/fhUc1vfk3cLt/gpcaUXqHcK0Qu4Tnx8hQAlMazfxxaBvVlebyvjsQJOlrSTW9dX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6rEkY0j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78ead12so1321851666b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Oct 2025 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759331582; x=1759936382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XjTjcbNYqZIHJp/Mr9lrDhDVC6yBEMk777WPg0hfC0=;
        b=l6rEkY0j5mh7DlK98huVb0VQSK8EH3jLW7v+vVlOd3g70ubEHW5bOfdoKVa++zcANr
         4M1smt99KC9U2uGoRS8zNMfUAwldOKfvYE+XMYJL+fvv3yiMWMIi0ElVdjtESPvOtCm3
         JrgcCxPmOXD5em56mxQVvt83IvXX8eOT2nFiSsMCe2U6cgVWoTSrm+hI3IRaCgu7wE3V
         gZfTHHfQ1gLK+qqSEnc8TaCISVdTnDCvytY0vNGPtlxgHfrb3IX7NvOBz6L5GjePOBP3
         KQQCvcRIuKkhYqtbr5KAVHpMDDtT20Pc60oxyfDNjFWMMAc39Kzk4BmBUik9CU+rYwb/
         ezAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331582; x=1759936382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XjTjcbNYqZIHJp/Mr9lrDhDVC6yBEMk777WPg0hfC0=;
        b=VV48tXGRA2k6/ffdDK4Z8FoioavHWZttGADdUNZH3z3S5DHXP9+V1ysKGoxsmrRggk
         jWNJansgD9s7QN6Sdq7fY5356MgQmfVvYsXWbNJMXpc3D2ebaFOs4mmR0Lq6HpR2NO2d
         ElmfYYXUye2tjocexk+o6mYGg2lQUwlMHyv7xn8OowrOW4+Zo/zZjFespWZ94mgGqyIJ
         lFzVVAMdbct/m1T1z9UuhNPA0HvVfRgHLfzoYrFhP5iVH9kh/1SKHj/C4hdyNpEuXYe/
         Sm6mB2Pnh4LP8QjJ1L60c9QNwp3lQTvPwdy4ztJi2UOqN97TINR9VUqbGghCtsqU0ic8
         Tf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0z6VvKRGu7532gsz+jAWCZ+iTx3XLdIhSumZgXp5Gdj8AGKQp1niZxo5aq+xvl9uwuce73uDR6MO4HW395Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Sozz1QpHVvTq2o5pxu3sNYmf/zYKTsfu0mwoB6TnJv53x9cd
	RhuQXkDnFmzpZ5nA27hunvx5ID58iEKgsijCqseVXnDiSaFKqYeI6EfOUdc2vvLL2z9WhZdjpHW
	S8TYhGQbMDnoVjvzlyA6a0jdmTV4+coU=
X-Gm-Gg: ASbGncvQok6esmz0G0n1fHnsj3Cp65a7+uLWLpZD71hex0EJ5/dvOqeMY6s/V7PIA3Z
	DWLtl9rs7avFP3+Qq8ZK06/bdZ9hYOrscC4eVfg2IXUbX4SLXGdT9GnZKKKbJ8pV7leyCRRybHl
	JARniMD8M0d40kMjNCYj+7y4TA3Hf8AZzbWU5kMC9Fo7UTGSliAYQ1iFqtHQbcOnpyMehVVc+C/
	ntoVeDOoLtZQL+4R8x8Dl5pvyD3
X-Google-Smtp-Source: AGHT+IE8+7qWD8qCg7JxkoAVb360Rlh0BtE7ebN6X53g+sayyjBBcfQBFOY6M5xodOoHyJcnTn40NdC7xl9uU1UxWNk=
X-Received: by 2002:a17:907:7291:b0:b2d:830a:8c0a with SMTP id
 a640c23a62f3a-b46e879fe65mr373156466b.35.1759331581406; Wed, 01 Oct 2025
 08:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001111451.299163-1-yongxuan.wang@sifive.com> <20251001111451.299163-3-yongxuan.wang@sifive.com>
In-Reply-To: <20251001111451.299163-3-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 1 Oct 2025 10:12:50 -0500
X-Gm-Features: AS18NWB48rhZKhYKYgQCtVpejlgXkcDO3ynhSUpp0Lt7TIl_P5VDkGkvEoTvjaI
Message-ID: <CAFTtA3MSxexbb8b063rfST1QDtj8Urhg9VCuDSCnpezW9_BAqQ@mail.gmail.com>
Subject: Re: [PATCH v 2/2] selftests: riscv: Add test for the Vector ptrace interface
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins <charlie@rivosinc.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yong-Xuan,

On Wed, Oct 1, 2025 at 6:15=E2=80=AFAM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> Add a test case that does some basic verification of the Vector ptrace
> interface. This forks a child process then using ptrace to inspect and
> manipulate the v31 register of the child.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  tools/testing/selftests/riscv/vector/Makefile |   5 +-
>  .../selftests/riscv/vector/vstate_ptrace.c    | 132 ++++++++++++++++++
>  2 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c
>
> diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testin=
g/selftests/riscv/vector/Makefile
> index 6f7497f4e7b3..45f25e9dd264 100644
> --- a/tools/testing/selftests/riscv/vector/Makefile
> +++ b/tools/testing/selftests/riscv/vector/Makefile
> @@ -2,7 +2,7 @@
>  # Copyright (C) 2021 ARM Limited
>  # Originally tools/testing/arm64/abi/Makefile
>
> -TEST_GEN_PROGS :=3D v_initval vstate_prctl
> +TEST_GEN_PROGS :=3D v_initval vstate_prctl vsate_ptrace
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
> +$(OUTPUT)/vstate_ptrace: vstate_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPU=
T)/v_helpers.o
> +       $(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/vector/vstate_ptrace.c b/tools=
/testing/selftests/riscv/vector/vstate_ptrace.c
> new file mode 100644
> index 000000000000..8a7bcf318e59
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <asm/ptrace.h>
> +#include <linux/elf.h>
> +#include <sys/ptrace.h>
> +#include <sys/uio.h>
> +#include <sys/wait.h>
> +#include "../../kselftest.h"
> +#include "v_helpers.h"
> +
> +int parent_set_val, child_set_val;
> +
> +static long do_ptrace(enum __ptrace_request op, pid_t pid, long type, si=
ze_t size, void *data)
> +{
> +       struct iovec v_iovec =3D {
> +               .iov_len =3D size,
> +               .iov_base =3D data
> +       };
> +
> +       return ptrace(op, pid, type, &v_iovec);
> +}
> +
> +static int do_child(void)
> +{
> +       int out;
> +
> +       if (ptrace(PTRACE_TRACEME, -1, NULL, NULL)) {
> +               ksft_perror("PTRACE_TRACEME failed\n");
> +               return EXIT_FAILURE;
> +       }
> +
> +       asm volatile (".option push\n\t"
> +               ".option        arch, +v\n\t"
> +               "vsetivli       x0, 1, e32, m1, ta, ma\n\t"
> +               "vmv.s.x        v31, %[in]\n\t"
> +               "ebreak\n\t"
> +               "vmv.x.s        %[out], v31\n\t"
> +               ".option pop\n\t"
> +               : [out] "=3Dr" (out)
> +               : [in] "r" (child_set_val));
> +
> +       if (out !=3D parent_set_val)
> +               return EXIT_FAILURE;
> +
> +       return EXIT_SUCCESS;
> +}
> +
> +static void do_parent(pid_t child)
> +{
> +       int status;
> +       void *data =3D NULL;
> +
> +       /* Attach to the child */
> +       while (waitpid(child, &status, 0)) {
> +               if (WIFEXITED(status)) {
> +                       ksft_test_result(WEXITSTATUS(status) =3D=3D 0, "S=
ETREGSET vector\n");
> +                       goto out;
> +               } else if (WIFSTOPPED(status) && (WSTOPSIG(status) =3D=3D=
 SIGTRAP)) {
> +                       size_t size, t;
> +                       void *data, *v31;
> +                       struct __riscv_v_regset_state *v_regset_hdr;
> +                       struct user_regs_struct *gpreg;
> +
> +                       size =3D sizeof(*v_regset_hdr);
> +                       data =3D malloc(size);
> +                       if (!data)
> +                               goto out;
> +                       v_regset_hdr =3D (struct __riscv_v_regset_state *=
)data;
> +
> +                       if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_V=
ECTOR, size, data))
> +                               goto out;
> +
> +                       ksft_print_msg("vlenb %ld\n", v_regset_hdr->vlenb=
);
> +                       data =3D realloc(data, size + v_regset_hdr->vlenb=
 * 32);
> +                       if (!data)
> +                               goto out;
> +                       v31 =3D (void *)(data + size + v_regset_hdr->vlen=
b * 31);
> +                       size +=3D v_regset_hdr->vlenb * 32;
> +
> +                       if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_V=
ECTOR, size, data))
> +                               goto out;
> +
> +                       ksft_test_result(*(int *)v31 =3D=3D child_set_val=
, "GETREGSET vector\n");
> +
> +                       *(int *)v31 =3D parent_set_val;
> +                       if (do_ptrace(PTRACE_SETREGSET, child, NT_RISCV_V=
ECTOR, size, data))
> +                               goto out;
> +
> +                       /* move the pc forward */
> +                       size =3D sizeof(*gpreg);
> +                       data =3D realloc(data, size);
> +                       gpreg =3D (struct user_regs_struct *)data;
> +
> +                       if (do_ptrace(PTRACE_GETREGSET, child, NT_PRSTATU=
S, size, data))
> +                               goto out;
> +
> +                       gpreg->pc +=3D 2;

Just nitpicking here, simply adding 2 may fail if the program is not
compiled with C. You may either +=3D4 and use ".option norvc" in the asm
or determine the size of ebreak by decoding it.

with or without the fix,

Reviewed-by: Andy Chiu <andybnac@gmail.com>

