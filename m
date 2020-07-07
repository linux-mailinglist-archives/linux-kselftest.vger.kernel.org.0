Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0D217A45
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 23:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGGVZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 17:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgGGVZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 17:25:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B03C061755
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jul 2020 14:25:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so51750234ljn.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jul 2020 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byLLzq0LjkgSPB3Nzx/DnpG7QMsVn0Qo/QLJ8A5e5/o=;
        b=YkTGTDhMc7BGmsriYJSIIJTUXlcfTX14cqV/dT5HOFlrfdR4iZVdJDHSFkKX16kYIG
         pLEIDgff5NW77IXMfl6QFJWfNRGIAMr46Ur2a9YwsRw9UvFZ55LSx5Czy3YJuC/qJpl8
         VaHHzbX9vTXdzBpOrwFDjsrt18BcyhC5sdlNzcz3faih3MhugRvnNYYRZDuHZwmHUHlH
         8tlNIHVn3ksXnBainnnyw9iLfFV7fJSdzSq1ZDd9PJYcMB3lteUEEM7u/zPttqaOrlWk
         +jjtxItgT9t+UiKgertDRBc0cQfS40fDfj5nnEarle5xNxXl9dLFSeIFCKfxZHcW+2bm
         bC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byLLzq0LjkgSPB3Nzx/DnpG7QMsVn0Qo/QLJ8A5e5/o=;
        b=O7Dpc9Hfo7dqsIwC/dQHMJqJt/k7DpN2sPCMHXuECAKAd9DT+z22yPMJuzsBz9BH5M
         PGqZzfkSQH1H45xq/wNDau3u1Crhkk0PxrC+dxttGSdteYQWOt/nWLqzq1V0/nXTCSyn
         B+VnJPbZfZnd/k9LNDSm/NKKH7KdYtXxhKeoG4EiPFvwo2AOXh/qZrAUsRgs1fq+4K9g
         1ip8ESMLZx3CSSjP1Hyga1Gm+eg1Kf67NKKV5eK/u6z2UA7JWx/z4/fZcI5VhIFuy2i7
         K3xgPnBF8kgWBgvdPKr/i5LWsg7jPSEoIZQy64SBACXNxxnlZMAn+4R32x2ScmaPm52H
         jD1w==
X-Gm-Message-State: AOAM533Ej4zWMIdyg8yEu0CdCckYi8OtcWuVopGMkBqSaQpRu8/WUUy4
        dX2LB6QxfE49fQTnC9ulom1MmWWz5ljEdryQTrgVDA==
X-Google-Smtp-Source: ABdhPJwvesbunu7ZKXI3FhOH9qfsHFeGuoCQg8ARahEjtQetp3lmvRoPkkUXFeS64Zw/2c5EBqu8HB5cS4nvQ5tQy5w=
X-Received: by 2002:a2e:8e97:: with SMTP id z23mr20504289ljk.288.1594157118642;
 Tue, 07 Jul 2020 14:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200707092117.963394-1-masahiroy@kernel.org>
In-Reply-To: <20200707092117.963394-1-masahiroy@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 7 Jul 2020 23:25:07 +0200
Message-ID: <CADYN=9K-CS2wUD-zpsUG9bp5SLFNFYb7BorDbTfcT6iw4y7SqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: introduce ccflags-remove-y and asflags-remove-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miroslav Benes <mbenes@suse.cz>,
        Paul Mackerras <paulus@samba.org>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Tal Gilboa <talgi@mellanox.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 7 Jul 2020 at 11:21, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CFLAGS_REMOVE_<file>.o filters out flags when compiling a particular
> object, but there is no convenient way to do that for every object in
> a directory.
>
> Add ccflags-remove-y and asflags-remove-y to make it easily.
>
> Use ccflags-remove-y to clean up some Makefiles.
>
> The add/remove order works as follows:
>
>  [1] KBUILD_CFLAGS specifies compiler flags used globally
>
>  [2] ccflags-y adds compiler flags for all objects in the
>      current Makefile
>
>  [3] ccflags-remove-y removes compiler flags for all objects in the
>      current Makefile (New feature)
>
>  [4] CFLAGS_<file> adds compiler flags per file.
>
>  [5] CFLAGS_REMOVE_<file> removes compiler flags per file.
>
> Having [3] before [4] allows us to remove flags from most (but not all)
> objects in the current Makefile.
>
> For example, kernel/trace/Makefile removes $(CC_FLAGS_FTRACE)
> from all objects in the directory, then adds it back to
> trace_selftest_dynamic.o and CFLAGS_trace_kprobe_selftest.o
>
> Please note ccflags-remove-y has no effect to the sub-directories.
> In contrast, the previous notation got rid of compiler flags also from
> all the sub-directories.
>
>   arch/arm/boot/compressed/
>   arch/powerpc/xmon/
>   arch/sh/
>   kernel/trace/
>
> ... have no sub-directories.
>
>   lib/
>
> ... has several sub-directories.
>
> To keep the behavior, I added ccflags-remove-y to all Makefiles
> in subdirectories of lib/, except:
>
>   lib/vdso/Makefile        - Kbuild does not descend into this Makefile
>   lib/raid/test/Makefile   - This is not used for the kernel build
>
> I think commit 2464a609ded0 ("ftrace: do not trace library functions")
> excluded too much. In later commit, I will try to remove ccflags-remove-y
> from sub-directory Makefiles.
>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Tested-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>
> Changes in v2:
>   - Swap the order of [3] and [4] to keep the current behavior of
>     kernel/trace/Makefile.
>   - Add ccflags-remove-y to subdir Makefiles of lib/
>
>  Documentation/kbuild/makefiles.rst | 14 ++++++++++++++
>  arch/arm/boot/compressed/Makefile  |  6 +-----
>  arch/powerpc/xmon/Makefile         |  3 +--
>  arch/sh/boot/compressed/Makefile   |  5 +----
>  kernel/trace/Makefile              |  4 ++--
>  lib/842/Makefile                   |  3 +++
>  lib/Makefile                       |  5 +----
>  lib/crypto/Makefile                |  2 ++
>  lib/dim/Makefile                   |  2 ++
>  lib/fonts/Makefile                 |  2 ++
>  lib/kunit/Makefile                 |  3 +++
>  lib/livepatch/Makefile             |  2 ++
>  lib/lz4/Makefile                   |  1 +
>  lib/lzo/Makefile                   |  2 ++
>  lib/math/Makefile                  |  2 ++
>  lib/mpi/Makefile                   |  2 ++
>  lib/raid6/Makefile                 |  3 +++
>  lib/reed_solomon/Makefile          |  2 ++
>  lib/xz/Makefile                    |  3 +++
>  lib/zlib_deflate/Makefile          |  2 ++
>  lib/zlib_dfltcc/Makefile           |  2 ++
>  lib/zlib_inflate/Makefile          |  2 ++
>  lib/zstd/Makefile                  |  1 +
>  scripts/Makefile.lib               | 14 ++++++++------
>  24 files changed, 64 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 6515ebc12b6f..14d8e7d23c04 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -368,6 +368,14 @@ more details, with real examples.
>
>                 subdir-ccflags-y := -Werror
>
> +    ccflags-remove-y, asflags-remove-y
> +       These flags are used to remove particular flags for the compiler,
> +       assembler invocations.
> +
> +       Example::
> +
> +               ccflags-remove-$(CONFIG_MCOUNT) += -pg
> +
>      CFLAGS_$@, AFLAGS_$@
>         CFLAGS_$@ and AFLAGS_$@ only apply to commands in current
>         kbuild makefile.
> @@ -375,6 +383,9 @@ more details, with real examples.
>         $(CFLAGS_$@) specifies per-file options for $(CC).  The $@
>         part has a literal value which specifies the file that it is for.
>
> +       CFLAGS_$@ has the higher priority than ccflags-remove-y; CFLAGS_$@
> +       can re-add compiler flags that were removed by ccflags-remove-y.
> +
>         Example::
>
>                 # drivers/scsi/Makefile
> @@ -387,6 +398,9 @@ more details, with real examples.
>         $(AFLAGS_$@) is a similar feature for source files in assembly
>         languages.
>
> +       AFLAGS_$@ has the higher priority than asflags-remove-y; AFLAGS_$@
> +       can re-add assembler flags that were removed by asflags-remove-y.
> +
>         Example::
>
>                 # arch/arm/kernel/Makefile
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 00602a6fba04..3d5691b23951 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -103,13 +103,9 @@ clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
>
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>
> -ifeq ($(CONFIG_FUNCTION_TRACER),y)
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
> -endif
> -
>  ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
>              -I$(obj) $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
>  asflags-y := -DZIMAGE
>
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 89c76ca35640..eb25d7554ffd 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -7,8 +7,7 @@ UBSAN_SANITIZE := n
>  KASAN_SANITIZE := n
>
>  # Disable ftrace for the entire directory
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
>
>  ifdef CONFIG_CC_IS_CLANG
>  # clang stores addresses on the stack causing the frame size to blow
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> index ad0e2403e56f..589d2d8a573d 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -28,10 +28,7 @@ IMAGE_OFFSET := $(shell /bin/bash -c 'printf "0x%08x" \
>                         $(CONFIG_BOOT_LINK_OFFSET)]')
>  endif
>
> -ifeq ($(CONFIG_MCOUNT),y)
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
> -endif
> +ccflags-remove-$(CONFIG_MCOUNT) += -pg
>
>  LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
>                    -T $(obj)/../../kernel/vmlinux.lds
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 6575bb0a0434..7492844a8b1b 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -2,9 +2,9 @@
>
>  # Do not instrument the tracer itself:
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  ifdef CONFIG_FUNCTION_TRACER
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
>
>  # Avoid recursion due to instrumentation.
>  KCSAN_SANITIZE := n
> diff --git a/lib/842/Makefile b/lib/842/Makefile
> index 6f7aad269288..b815e824ae37 100644
> --- a/lib/842/Makefile
> +++ b/lib/842/Makefile
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_842_COMPRESS) += 842_compress.o
>  obj-$(CONFIG_842_DECOMPRESS) += 842_decompress.o
> diff --git a/lib/Makefile b/lib/Makefile
> index b1c42c10073b..b2ed4beddd68 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -3,10 +3,7 @@
>  # Makefile for some libs needed in the kernel.
>  #
>
> -ifdef CONFIG_FUNCTION_TRACER
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> -endif
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
>
>  # These files are disabled because they produce lots of non-interesting and/or
>  # flaky coverage that is not a function of syscall inputs. For example,
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 3a435629d9ce..b557ef0b07c2 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  # chacha is used by the /dev/random driver which is always builtin
>  obj-y                                          += chacha.o
>  obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)                += libchacha.o
> diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> index 1d6858a108cb..97fc3e89d34e 100644
> --- a/lib/dim/Makefile
> +++ b/lib/dim/Makefile
> @@ -2,6 +2,8 @@
>  # DIM Dynamic Interrupt Moderation library
>  #
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_DIMLIB) += dim.o
>
>  dim-y := dim.o net_dim.o rdma_dim.o
> diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
> index ed95070860de..f951750c179e 100644
> --- a/lib/fonts/Makefile
> +++ b/lib/fonts/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Font handling
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  font-objs := fonts.o
>
>  font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 724b94311ca3..8c847557ab24 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -1,3 +1,6 @@
> +
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_KUNIT) +=                 kunit.o
>
>  kunit-objs +=                          test.o \
> diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
> index 295b94bff370..9abdf615b088 100644
> --- a/lib/livepatch/Makefile
> +++ b/lib/livepatch/Makefile
> @@ -2,6 +2,8 @@
>  #
>  # Makefile for livepatch test code.
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
>                                 test_klp_callbacks_demo.o \
>                                 test_klp_callbacks_demo2.o \
> diff --git a/lib/lz4/Makefile b/lib/lz4/Makefile
> index 5b42242afaa2..53da4cab7015 100644
> --- a/lib/lz4/Makefile
> +++ b/lib/lz4/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  ccflags-y += -O3
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
>
>  obj-$(CONFIG_LZ4_COMPRESS) += lz4_compress.o
>  obj-$(CONFIG_LZ4HC_COMPRESS) += lz4hc_compress.o
> diff --git a/lib/lzo/Makefile b/lib/lzo/Makefile
> index 2f58fafbbddd..9565a555275b 100644
> --- a/lib/lzo/Makefile
> +++ b/lib/lzo/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  lzo_compress-objs := lzo1x_compress.o
>  lzo_decompress-objs := lzo1x_decompress_safe.o
>
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index be6909e943bd..49aa50e28185 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -1,4 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
>
>  obj-$(CONFIG_CORDIC)           += cordic.o
> diff --git a/lib/mpi/Makefile b/lib/mpi/Makefile
> index d5874a7f5ff9..df7883521619 100644
> --- a/lib/mpi/Makefile
> +++ b/lib/mpi/Makefile
> @@ -3,6 +3,8 @@
>  # MPI multiprecision maths library (from gpg)
>  #
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_MPILIB) = mpi.o
>
>  mpi-y = \
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index b4c0df6d706d..3482d6ae3f3b 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_RAID6_PQ) += raid6_pq.o
>
>  raid6_pq-y     += algos.o recov.o tables.o int1.o int2.o int4.o \
> diff --git a/lib/reed_solomon/Makefile b/lib/reed_solomon/Makefile
> index 5d4fa68f26cb..a5c9defdac7f 100644
> --- a/lib/reed_solomon/Makefile
> +++ b/lib/reed_solomon/Makefile
> @@ -3,5 +3,7 @@
>  # This is a modified version of reed solomon lib,
>  #
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_REED_SOLOMON) += reed_solomon.o
>  obj-$(CONFIG_REED_SOLOMON_TEST) += test_rslib.o
> diff --git a/lib/xz/Makefile b/lib/xz/Makefile
> index fa6af814a8d1..fae9b6c7c389 100644
> --- a/lib/xz/Makefile
> +++ b/lib/xz/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_XZ_DEC) += xz_dec.o
>  xz_dec-y := xz_dec_syms.o xz_dec_stream.o xz_dec_lzma2.o
>  xz_dec-$(CONFIG_XZ_DEC_BCJ) += xz_dec_bcj.o
> diff --git a/lib/zlib_deflate/Makefile b/lib/zlib_deflate/Makefile
> index 2622e03c0b94..1fcefe73536f 100644
> --- a/lib/zlib_deflate/Makefile
> +++ b/lib/zlib_deflate/Makefile
> @@ -7,6 +7,8 @@
>  # decompression code.
>  #
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate.o
>
>  zlib_deflate-objs := deflate.o deftree.o deflate_syms.o
> diff --git a/lib/zlib_dfltcc/Makefile b/lib/zlib_dfltcc/Makefile
> index 8e4d5afbbb10..7a8067f6e772 100644
> --- a/lib/zlib_dfltcc/Makefile
> +++ b/lib/zlib_dfltcc/Makefile
> @@ -6,6 +6,8 @@
>  # This is the code for s390 zlib hardware support.
>  #
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc.o
>
>  zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_inflate.o dfltcc_syms.o
> diff --git a/lib/zlib_inflate/Makefile b/lib/zlib_inflate/Makefile
> index 27327d3e9f54..a451e96f9845 100644
> --- a/lib/zlib_inflate/Makefile
> +++ b/lib/zlib_inflate/Makefile
> @@ -14,6 +14,8 @@
>  # uncompression can be done without blocking on allocation).
>  #
>
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate.o
>
>  zlib_inflate-objs := inffast.o inflate.o infutil.o \
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index f5d778e7e5c7..01be908a2d94 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>  obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>
>  ccflags-y += -O3
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
>
>  zstd_compress-y := fse_compress.o huf_compress.o compress.o \
>                    entropy_common.o fse_decompress.o zstd_common.o
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 916b2f7f7098..3629f66646d7 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -111,12 +111,14 @@ basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
>  modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
>  modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
>
> -orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
> -                 $(ccflags-y) $(CFLAGS_$(target-stem).o)
> -_c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), $(orig_c_flags))
> -orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) \
> -                 $(asflags-y) $(AFLAGS_$(target-stem).o)
> -_a_flags       = $(filter-out $(AFLAGS_REMOVE_$(target-stem).o), $(orig_a_flags))
> +_c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
> +                     $(filter-out $(ccflags-remove-y), \
> +                         $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(ccflags-y)) \
> +                     $(CFLAGS_$(target-stem).o))
> +_a_flags       = $(filter-out $(AFLAGS_REMOVE_$(target-stem).o), \
> +                     $(filter-out $(asflags-remove-y), \
> +                         $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(asflags-y)) \
> +                     $(AFLAGS_$(target-stem).o))
>  _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(target-stem).lds)
>
>  #
> --
> 2.25.1
>
