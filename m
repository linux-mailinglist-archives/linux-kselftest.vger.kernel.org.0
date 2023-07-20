Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CE175A8E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 10:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGTIQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 04:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGTIQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 04:16:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A5B2684
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 01:16:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-314172bac25so384288f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689840981; x=1690445781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNGJaYEpeCAI7drQ8W8ZV+PTc4Zy8Ohv1zP8hIu3TR8=;
        b=aZoe4sdItvYTIGvKmdBkwWvSm9XIortrvDEcFOv6U9T3bIJ8wJnc6+CdANOPnQrFGc
         b0efaIB7KWoqmRTL3zp9zVjPLbqwS7QZ9OcJvAiEtHKiNyasiXXEHCx01wZ8w7V52ooO
         VZOs8dgeSuhEJGHUnBfSMnTt2rJW17BNUCa9NOJL6VT5n8XjqhdAxgnCetbYFNQWPXHz
         X7ja3ACB0l+HqW62c75Hq8g4y36DXolIpV9WqT1ww8yPETw0kowXqC4Jn7UiXdaKsC8B
         140VXB7XUvRAbyNj5Wz6RlEpo38ImoCnfE2LhyY3zi5M+fexasEdd0sZlnkUE+60ARi4
         ON0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689840981; x=1690445781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNGJaYEpeCAI7drQ8W8ZV+PTc4Zy8Ohv1zP8hIu3TR8=;
        b=CLH2QeZG0rxHHZ1rkqyfApW+eQ9fMEQxnmp7EEf+eYCeSDMhU72aBuc9se1qMPZ/Gl
         HxXX2F5Qqr64BP5dLcwkRKIrseUecBPSE2QnOTo0SjdkoYOe6Ts2q3be0Ke+qAs6zhMM
         jJg2z/W5SrwujQQ1swlRYQiTUspX1GMlPMFHhWD7o1um8g91Ex+wN+MTMpzTqpIm+L0L
         bzYP5aUe41cbwRgC7bpQPcHPXrovQznLNnfff37Asc2zz68eim5rMfJtjEX+0NAY47XT
         qlfdicImiUtTDGsG5LrV0nu5OswxT4Z1oGZ0vDGOfUkGJwyR/Tyi2uUugiBIjFTrPp2k
         /O+w==
X-Gm-Message-State: ABy/qLaJ7jhplDIUl2FuWTJ4ZFfXFGWlOv04p0NeAVHUSF3fRj4woJH3
        vg3UwVfMj9Jldahpw0WxxWqA82AQJEP1sSvy9e0HtQ==
X-Google-Smtp-Source: APBJJlE4/ypBCkAS4fa3ft8sr4uiIljwWG9xBqWF4OQP1QHzs9vglehTimqhRn43tcQfSYUsfosvfe6DQAVs529DSZc=
X-Received: by 2002:a5d:456c:0:b0:316:f1a5:269f with SMTP id
 a12-20020a5d456c000000b00316f1a5269fmr1310004wrc.70.1689840981522; Thu, 20
 Jul 2023 01:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230714165508.94561-1-charlie@rivosinc.com> <20230714165508.94561-3-charlie@rivosinc.com>
In-Reply-To: <20230714165508.94561-3-charlie@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 20 Jul 2023 10:16:10 +0200
Message-ID: <CAHVXubhT1ixqw03r+6XtPO-0V5ff7a4r4xf2zOqTMDg8xtY0UA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] RISC-V: mm: Add tests for RISC-V mm
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 14, 2023 at 6:55=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Add tests that enforce mmap hint address behavior. mmap should default
> to sv48. mmap will provide an address at the highest address space that
> can fit into the hint address, unless the hint address is less than sv39
> and not 0, then it will return a sv39 address. In addition, ensure that
> rlimit changes do not cause mmap to fail.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/mm/.gitignore   |   1 +
>  tools/testing/selftests/riscv/mm/Makefile     |  21 +++
>  .../selftests/riscv/mm/testcases/mmap.c       | 133 ++++++++++++++++++
>  4 files changed, 156 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/mm/Makefile
>  create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
>
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selft=
ests/riscv/Makefile
> index 9dd629cc86aa..1b79da90396e 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?=3D $(shell uname -m 2>/dev/null || echo not)
>
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?=3D hwprobe vector
> +RISCV_SUBTARGETS ?=3D hwprobe vector mm
>  else
>  RISCV_SUBTARGETS :=3D
>  endif
> diff --git a/tools/testing/selftests/riscv/mm/.gitignore b/tools/testing/=
selftests/riscv/mm/.gitignore
> new file mode 100644
> index 000000000000..9a6f303edcd3
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/.gitignore
> @@ -0,0 +1 @@
> +mmap
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/se=
lftests/riscv/mm/Makefile
> new file mode 100644
> index 000000000000..cf68e63e7495
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Originally tools/testing/selftests/arm64/signal
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS +=3D -D_GNU_SOURCE -std=3Dgnu99 -I.
> +
> +SRCS :=3D $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
> +PROGS :=3D $(patsubst %.c,%,$(SRCS))
> +
> +# Generated binaries to be installed by top KSFT script
> +TEST_GEN_PROGS :=3D $(notdir $(PROGS))
> +
> +# Get Kernel headers installed and use them.
> +
> +# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
> +# to account for any OUTPUT target-dirs optionally provided by
> +# the toplevel makefile
> +include ../../lib.mk
> +
> +$(TEST_GEN_PROGS): $(PROGS)
> +       cp $(PROGS) $(OUTPUT)/
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap.c b/tools/te=
sting/selftests/riscv/mm/testcases/mmap.c
> new file mode 100644
> index 000000000000..d8e751f7b8c9
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/testcases/mmap.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <sys/mman.h>
> +#include <sys/resource.h>
> +#include <sys/time.h>
> +
> +#include "../../kselftest_harness.h"
> +struct addresses {
> +       int *no_hint;
> +       int *on_37_addr;
> +       int *on_38_addr;
> +       int *on_46_addr;
> +       int *on_47_addr;
> +       int *on_55_addr;
> +       int *on_56_addr;
> +};
> +
> +void do_mmaps(struct addresses *mmap_addresses)
> +{
> +       // Place all of the hint addresses on the boundaries of mmap
> +       // sv39, sv48, sv57
> +       // User addresses end at 1<<38, 1<<47, 1<<56 respectively

Doesn't checkpatch complain about those comments? Shouldn't you use /*
*/ instead?

> +       void *on_37_bits =3D (void *)(1UL << 37);
> +       void *on_38_bits =3D (void *)(1UL << 38);
> +       void *on_46_bits =3D (void *)(1UL << 46);
> +       void *on_47_bits =3D (void *)(1UL << 47);
> +       void *on_55_bits =3D (void *)(1UL << 55);
> +       void *on_56_bits =3D (void *)(1UL << 56);
> +
> +       int prot =3D PROT_READ | PROT_WRITE;
> +       int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
> +
> +       mmap_addresses->no_hint =3D
> +               mmap(NULL, 5 * sizeof(int), prot, flags, 0, 0);
> +       mmap_addresses->on_37_addr =3D
> +               mmap(on_37_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +       mmap_addresses->on_38_addr =3D
> +               mmap(on_38_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +       mmap_addresses->on_46_addr =3D
> +               mmap(on_46_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +       mmap_addresses->on_47_addr =3D
> +               mmap(on_47_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +       mmap_addresses->on_55_addr =3D
> +               mmap(on_55_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +       mmap_addresses->on_56_addr =3D
> +               mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +}
> +
> +TEST(default_rlimit)
> +{
> +// Only works on 64 bit
> +#if __riscv_xlen =3D=3D 64
> +       struct addresses mmap_addresses;
> +
> +       do_mmaps(&mmap_addresses);
> +
> +       EXPECT_NE(mmap_addresses.no_hint, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_37_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_38_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_46_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_47_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_55_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_56_addr, MAP_FAILED);
> +
> +       EXPECT_LT((unsigned long)mmap_addresses.no_hint, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_37_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_38_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_46_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_47_addr, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_55_addr, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_56_addr, 1UL << 56);
> +#endif
> +}
> +
> +TEST(zero_rlimit)
> +{
> +// Only works on 64 bit
> +#if __riscv_xlen =3D=3D 64
> +       struct addresses mmap_addresses;
> +       struct rlimit rlim_new =3D { .rlim_cur =3D 0, .rlim_max =3D RLIM_=
INFINITY };
> +
> +       setrlimit(RLIMIT_STACK, &rlim_new);
> +
> +       do_mmaps(&mmap_addresses);
> +
> +       EXPECT_NE(mmap_addresses.no_hint, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_37_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_38_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_46_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_47_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_55_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_56_addr, MAP_FAILED);
> +
> +       EXPECT_LT((unsigned long)mmap_addresses.no_hint, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_37_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_38_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_46_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_47_addr, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_55_addr, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_56_addr, 1UL << 56);
> +#endif
> +}
> +
> +TEST(infinite_rlimit)
> +{
> +// Only works on 64 bit
> +#if __riscv_xlen =3D=3D 64
> +       struct addresses mmap_addresses;
> +       struct rlimit rlim_new =3D { .rlim_cur =3D RLIM_INFINITY,
> +                                  .rlim_max =3D RLIM_INFINITY };
> +
> +       setrlimit(RLIMIT_STACK, &rlim_new);
> +
> +       do_mmaps(&mmap_addresses);
> +
> +       EXPECT_NE(mmap_addresses.no_hint, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_37_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_38_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_46_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_47_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_55_addr, MAP_FAILED);
> +       EXPECT_NE(mmap_addresses.on_56_addr, MAP_FAILED);
> +
> +       EXPECT_LT((unsigned long)mmap_addresses.no_hint, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_37_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_38_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_46_addr, 1UL << 38);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_47_addr, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_55_addr, 1UL << 47);
> +       EXPECT_LT((unsigned long)mmap_addresses.on_56_addr, 1UL << 56);
> +#endif
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.41.0
>
