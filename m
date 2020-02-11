Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B615886A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 03:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBKCuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 21:50:05 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34615 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbgBKCuF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 21:50:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GnLf1ph6z9sP7;
        Tue, 11 Feb 2020 13:50:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581389403;
        bh=8X60AtLN4V7FB/5Mq0L2zAq5HCYgpqp/UiCwagFf5PE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JTdJPJi/kjPOL3TzyFuXaInMZ2XKxoO4t4T+ia3oW5bA3Hhtjxmo5gfyRCTj30rrm
         AoLM8NK0nZdQnvpINWnCg/bJsx6Hq6yD8I8HbTSE4U4gebl/VMJP2JSMxhjohtBd2/
         L4oJz4EqHC/dyhRO6yvgCwCS/oQ808G0muHDikXxxkT8IfEP6OwPqwMQaBm1q13pCQ
         +o+e31+IsaWDJjNF06zZqntkYrdIJTunIimVR1xmBP6XU1caDJsjewrBx17/ZWuIML
         3wiRHtFV7h0NwFF6cQhupIL5ByooQzgjFwJXZY9QZ6Z+PE7cCeynB99eeEleHk9vzV
         V9+/vXPN34wHw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhiramat@kernel.org, aneesh.kumar@linux.ibm.com,
        kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] selftests: vm: Do not override definition of ARCH
In-Reply-To: <471a73600bf9f59a59484726f50f81d7f54f4b2f.1580367152.git.sandipan@linux.ibm.com>
References: <cover.1580367152.git.sandipan@linux.ibm.com> <471a73600bf9f59a59484726f50f81d7f54f4b2f.1580367152.git.sandipan@linux.ibm.com>
Date:   Tue, 11 Feb 2020 13:49:59 +1100
Message-ID: <87lfp9zvl4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sandipan Das <sandipan@linux.ibm.com> writes:
> Independent builds of the vm selftests is currently broken
> because commit 7549b3364201 overrides the value of ARCH with
> the machine name from uname. This does not always match the
> architecture names used for tasks like header installation.
>
> E.g. for building tests on powerpc64, we need ARCH=powerpc
> and not ARCH=ppc64 or ARCH=ppc64le. Otherwise, the build
> fails as shown below.
>
>   $ uname -m
>   ppc64le
>
>   $ make -C tools/testing/selftests/vm
>   make: Entering directory '/home/sandipan/linux/tools/testing/selftests/vm'
>   make --no-builtin-rules ARCH=ppc64le -C ../../../.. headers_install
>   make[1]: Entering directory '/home/sandipan/linux'
>   Makefile:653: arch/ppc64le/Makefile: No such file or directory
>   make[1]: *** No rule to make target 'arch/ppc64le/Makefile'.  Stop.
>   make[1]: Leaving directory '/home/sandipan/linux'
>   ../lib.mk:50: recipe for target 'khdr' failed
>   make: *** [khdr] Error 2
>   make: Leaving directory '/home/sandipan/linux/tools/testing/selftests/vm'
>
> Fixes: 7549b3364201 ("selftests: vm: Build/Run 64bit tests only on 64bit arch")
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 7f9a8a8c31da..3f2e2f0ccbc9 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for vm selftests
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
> -ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
> +MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
>  
>  CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
>  LDLIBS = -lrt
> @@ -19,7 +19,7 @@ TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
>  
> -ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
> +ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
>  TEST_GEN_FILES += va_128TBswitch
>  TEST_GEN_FILES += virtual_address_range
>  endif
> -- 
> 2.17.1
