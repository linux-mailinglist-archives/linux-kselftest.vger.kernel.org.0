Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB029B175
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2019 15:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405737AbfHWN4T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Aug 2019 09:56:19 -0400
Received: from foss.arm.com ([217.140.110.172]:34904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388949AbfHWN4T (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Aug 2019 09:56:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE6B28;
        Fri, 23 Aug 2019 06:56:17 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 310B13F718;
        Fri, 23 Aug 2019 06:56:13 -0700 (PDT)
Subject: Re: [PATCH v18 15/15] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
To:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1561386715.git.andreyknvl@google.com>
 <0999c80cd639b78ae27c0674069d552833227564.1561386715.git.andreyknvl@google.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <6af3f619-4356-2f67-ed76-92beceb1e0a0@arm.com>
Date:   Fri, 23 Aug 2019 14:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0999c80cd639b78ae27c0674069d552833227564.1561386715.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrey

On 24/06/2019 15:33, Andrey Konovalov wrote:
> This patch is a part of a series that extends kernel ABI to allow to pass
> tagged user pointers (with the top byte set to something else other than
> 0x00) as syscall arguments.
> 
> This patch adds a simple test, that calls the uname syscall with a
> tagged user pointer as an argument. Without the kernel accepting tagged
> user pointers the test fails with EFAULT.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  tools/testing/selftests/arm64/.gitignore      |  1 +
>  tools/testing/selftests/arm64/Makefile        | 11 +++++++
>  .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++
>  tools/testing/selftests/arm64/tags_test.c     | 29 +++++++++++++++++++
>  4 files changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/arm64/.gitignore
>  create mode 100644 tools/testing/selftests/arm64/Makefile
>  create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
>  create mode 100644 tools/testing/selftests/arm64/tags_test.c

After building a fresh Kernel from arm64/for-next-core from scratch at:

commit 239ab658bea3b387424501e7c416640d6752dc0c 
Merge: 6bfa3134bd3a 42d038c4fb00 1243cb6a676f d55c5f28afaf d06fa5a118f1 34b5560db40d
Author: Will Deacon <will@kernel.org>
Date:   Thu Aug 22 18:23:53 2019 +0100

    Merge branches 'for-next/error-injection', 'for-next/tbi', 'for-next/psci-cpuidle', 'for-next/cpu-topology' and 'for-next/52-bit-kva' into for-next/core


KSFT arm64 tests build is broken for me, both setting or not KBUILD_OUTPUT=

13:30 $ make TARGETS=arm64 kselftest-clean                       
make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
rm -f -r /home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/arm64/tags_test
make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'

✔ ~/ARM/dev/src/pdsw/linux [arm64_for_next_core|…8⚑ 23]

13:30 $ make TARGETS=arm64 kselftest                  
make[1]: Entering directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
        ARCH=arm64 -C ../../.. headers_install             
  HOSTCC  scripts/basic/fixdep                     
  HOSTCC  scripts/unifdef                         
...
...
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/shmbuf.h
  INSTALL /home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/usr/include
/opt/toolchains/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc     tags_test.c  -o /home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/arm64/tags_test
tags_test.c: In function ‘main’:
tags_test.c:21:12: error: ‘PR_SET_TAGGED_ADDR_CTRL’ undeclared (first use in this function); did you mean ‘PR_GET_TID_ADDRESS’?
  if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
            ^~~~~~~~~~~~~~~~~~~~~~~
            PR_GET_TID_ADDRESS
tags_test.c:21:12: note: each undeclared identifier is reported only once for each function it appears in
tags_test.c:21:37: error: ‘PR_TAGGED_ADDR_ENABLE’ undeclared (first use in this function); did you mean ‘PR_GET_DUMPABLE’?
  if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
                                     ^~~~~~~~~~~~~~~~~~~~~
                                     PR_GET_DUMPABLE
../lib.mk:138: recipe for target '/home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/arm64/tags_test' failed
make[3]: *** [/home/crimar01/ARM/dev/src/pdsw/out_linux//kselftest/arm64/tags_test] Error 1
Makefile:136: recipe for target 'all' failed
make[2]: *** [all] Error 2
/home/crimar01/ARM/dev/src/pdsw/linux/Makefile:1237: recipe for target 'kselftest' failed
make[1]: *** [kselftest] Error 2
make[1]: Leaving directory '/home/crimar01/ARM/dev/src/pdsw/out_linux'
Makefile:179: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

Despite seeing KSFT installing Kernel Headers, they cannot be found.

Fixing this patch like this make it work for me:

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile                                                                                        
index a61b2e743e99..f9f79fb272f0 100644                             
--- a/tools/testing/selftests/arm64/Makefile   
+++ b/tools/testing/selftests/arm64/Makefile                                                     
@@ -4,6 +4,7 @@                                                                       
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)                                              
                                                       
 ifneq (,$(filter $(ARCH),aarch64 arm64))                                            
+CFLAGS += -I../../../../usr/include/                                                               
 TEST_GEN_PROGS := tags_test                                  
 TEST_PROGS := run_tags_test.sh                                    
 endif                                                             

but is not really a proper fix since it does NOT account for case in which you have
installed the Kernel Headers in a non standard location like when you use KBUILD_OUTPUT.

Am I missing something ?

Thanks

Cristian

> 
> diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
> new file mode 100644
> index 000000000000..e8fae8d61ed6
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/.gitignore
> @@ -0,0 +1 @@
> +tags_test
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> new file mode 100644
> index 000000000000..a61b2e743e99
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# ARCH can be overridden by the user for cross compiling
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +
> +ifneq (,$(filter $(ARCH),aarch64 arm64))
> +TEST_GEN_PROGS := tags_test
> +TEST_PROGS := run_tags_test.sh
> +endif
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
> new file mode 100755
> index 000000000000..745f11379930
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/run_tags_test.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +echo "--------------------"
> +echo "running tags test"
> +echo "--------------------"
> +./tags_test
> +if [ $? -ne 0 ]; then
> +	echo "[FAIL]"
> +else
> +	echo "[PASS]"
> +fi
> diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
> new file mode 100644
> index 000000000000..22a1b266e373
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/tags_test.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <sys/prctl.h>
> +#include <sys/utsname.h>
> +
> +#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
> +#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
> +					SHIFT_TAG(tag))
> +
> +int main(void)
> +{
> +	static int tbi_enabled = 0;
> +	struct utsname *ptr, *tagged_ptr;
> +	int err;
> +
> +	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
> +		tbi_enabled = 1;
> +	ptr = (struct utsname *)malloc(sizeof(*ptr));
> +	if (tbi_enabled)
> +		tagged_ptr = (struct utsname *)SET_TAG(ptr, 0x42);
> +	err = uname(tagged_ptr);
> +	free(ptr);
> +
> +	return err;
> +}
> 

