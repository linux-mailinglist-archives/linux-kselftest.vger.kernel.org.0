Return-Path: <linux-kselftest+bounces-42666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B7BB290D
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 07:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F5E4A2FFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEA3283C9D;
	Thu,  2 Oct 2025 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMQ+hEf/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF471482F2
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Oct 2025 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384409; cv=none; b=PsftQDRw/bkD8ZRXoYeXS7taBRNwRy5WZ+jykJikU6Rw7bH59cbARln0E1pbI4ikCx+A5xSd7sdO5eNrv/5mnR8vTiqVfO4LOqtvP+RjUu7Y+wo2CID/01n7GGoQy+2LJKbPqt9RkeCoyi/NeQ1yr83zXOHRUTcAEut17pEmHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384409; c=relaxed/simple;
	bh=bDK0BKszzkg08kpRulnBhwtMG4WgCeKIHAxehuORN/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB77yIx0eazbvsTEVXUmRhdZ49EZMzBiH9aKhOfD1GA0n7EX2cjFO2oBepX2h0hm9YihPcfDEWBI5U9tCNro2gCvb2v5DIAIucnsgy8yPjo+TxubVBwlwZvHUhl33agIO8JtqEGpNcjkGSM4sEx7aTXg2zcLYyf2lVVatfOAfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMQ+hEf/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3da3b34950so110561066b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Oct 2025 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759384405; x=1759989205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnIr4GHzTI6LNn4Jxf6A7mZnpuljV+oGxw67DQVrxLU=;
        b=CMQ+hEf/j5opjUIZDiUy0ux1G/OM0RKBUHQE09xPQdWgYQSPDDodeCfZWyDgU5l30G
         ByEFRNMJYHl9oTrDLKWwbk0ZUvNRon+Ww2yal8fBHlMh4cQDR0LpsBeEUz8jDb8wFjkA
         vsPSVyY0OXR7RRQFsJqGSPgVGuli1r4crpgM5L3alvEiKeNJvJkm0lc5xPqOQP3J7EBk
         hOL4QlJzqPMyvXMntSeOg25Ah9qTTnyjeKU8xAyksR0X5k2lAQpTENwD8vzSNIADQPN9
         LTTgI4zJiv99eqSDzt/e1Qjx6khFvEnai62N+hjBsvRbJ5NlEcYHNBdM4NU54GEqla4r
         3mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759384405; x=1759989205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnIr4GHzTI6LNn4Jxf6A7mZnpuljV+oGxw67DQVrxLU=;
        b=AAujKwwRf1qYlfGKurvDY6rfT6GE/PR39IvXOm+ANDl96hylqK5uqJ5hzGFKC2DKk/
         9dx4HYqbZWgP5SqZxGcXUo4/kYjvOPI/zGHGPSCSaSeAOJ2QwlU/RYBShXw3YjGZ7hrK
         9gf8ZjljHXdXUeQ1j0eSQOFR3w+i3KdfS1Hc4hrlU/H4+DNYYXsDhJ1EBjpJNkl/Obai
         ijtcO2Tywf3iMxxkqenJR8KE/s3yjwLtPGNX576/65NMm/OrDgx6KcBqm2a2h1hnG9Uo
         v+UU5zTckMsg+68sSik0icHOND5QAmhBwyzGu/SgTKkCXAeXlA8d6sPQbUNYTioJT8R6
         NdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+GaJTpIzvYXXQht8mjXLGqdqqkxv3iWXPejO10YnlB8gRj54uA2Xd0DngfNl4YGP/spoU7JjUpov+uzpnwTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfV1DoKgInXAy+GrHZV21mureAI/wB5kXfSf7laqN2z+EJUia
	zbQ7rCbxACnLAKgvKiNNJtSp94/03RYObfeKnJoq9KyshpgzzKKavfrbRZ0gHwUjHLXdRJk8ZRu
	4wP7XWd/nK5iFipMxrblzRQMlsLAK1b4=
X-Gm-Gg: ASbGncv14xKQqqPo1xLDE0e3mYMc4ThQ+PKDFcANGvyl2tJ7xZdqnOZoWEq0T0FyPM6
	bK9OaQs9QJ87mCP5gb1jYz28pBVgtPCIMKfaRc/KSihyPTSqmsSGNijlF24ObjCo//0A2rp4sxI
	c2+ugoBy9GSJS04iH5e29+a7DWkFcLOmSfWhSCnm+Xg5UICbN8WBdzCR+CILKWweIvLGSSFw/O/
	MDmTKGKZgzWgvyioYTx7Iv00SOdWy+gMQhw0BE=
X-Google-Smtp-Source: AGHT+IFkZKlYi47ykcRbgLwThh1IjKucMbfY/9FgRLta22wdRQ9Vr9Z1efF1b92CRz4T2aG4ce8yQwmW9h+2mYBJ4AI=
X-Received: by 2002:a17:907:d18:b0:b40:9dbe:5b57 with SMTP id
 a640c23a62f3a-b46e839bfe9mr818832666b.62.1759384404702; Wed, 01 Oct 2025
 22:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001111451.299163-1-yongxuan.wang@sifive.com> <20251001111451.299163-3-yongxuan.wang@sifive.com>
In-Reply-To: <20251001111451.299163-3-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 2 Oct 2025 00:53:13 -0500
X-Gm-Features: AS18NWAZQYng18g_g5Us12uur8Cnt5qYB0T36pxKkKIeySPGBry4GZZ7mTfz4Gw
Message-ID: <CAFTtA3MB0Oxe5Wy_Bq-uhijz2h6o0ZWezvoJPiXdjEmcGd6S4A@mail.gmail.com>
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

I found some issues which deserve a re-roll:

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

Please s/vsate_ptrace/vstate_ptrace

Otherwise we will not get the program compiled

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

As mentioned before, please use ".option arch, +v,-c\n\t" or ".option
norvc\n\t" and +=3D4 when advancing the pc

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

unused variable t

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

realloc may give a new pointer so v_regset_hdr has to be updated here
before the next use

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
> +                       if (do_ptrace(PTRACE_SETREGSET, child, NT_PRSTATU=
S, size, data))
> +                               goto out;
> +               }
> +
> +               ptrace(PTRACE_CONT, child, NULL, NULL);
> +       }
> +
> +out:
> +       free(data);
> +}
> +
> +int main(void)
> +{
> +       pid_t child;
> +
> +       ksft_set_plan(2);
> +       if (!is_vector_supported() && !is_xtheadvector_supported())
> +               ksft_exit_skip("Vector not supported\n");
> +
> +       srandom(getpid());
> +       parent_set_val =3D rand();
> +       child_set_val =3D rand();
> +
> +       child =3D fork();
> +       if (child < 0)
> +               ksft_exit_fail_msg("Fork failed %d\n", child);
> +
> +       if (!child)
> +               return do_child();
> +
> +       do_parent(child);
> +
> +       ksft_finished();
> +}
> --
> 2.43.0
>

Thanks,
Andy

