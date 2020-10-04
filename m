Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8581D282977
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Oct 2020 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgJDHzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Oct 2020 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgJDHzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Oct 2020 03:55:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909ACC0613CE;
        Sun,  4 Oct 2020 00:55:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 33so6168878edq.13;
        Sun, 04 Oct 2020 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XIXZHrjfnaYcO1ejRkazt6fevmZ47NI6sElWKm1dPTA=;
        b=jRc4s/FQWYwEtVklMT1rcj4WHLc2ni+WA56qrrjxyzPUUvaH6P3fsYRDj2qcb4Lzhd
         DxgdhG3xQSH2FcgUAflSA7SEWdYZ8N6/84wjL51AP77xT1Jj8pqJO332e+LBLyCXnOwH
         FsOeJBMNb0BYhTqPz2A5F2xXSZNqBP6Mx7ZEu7+EucFQXk0oU/2eqcbeDsiqFAjNF9Da
         ReOcc7jVU5uWKKPv/ISM6gswhdrBtoZXUfDNm0S+hHDZyRmTnag0lj1hfta40anlaLKZ
         0OqRBJLs7cymrNn7v7y4SoIRV78qoXuPLW3NNf70riduOACSpmy6PUhuUSZb35pgHnSZ
         AYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XIXZHrjfnaYcO1ejRkazt6fevmZ47NI6sElWKm1dPTA=;
        b=kq0dcDPpgX0HSujli0ePFen+j4Q8BUHmqlqbC3VzySRssBfL7stW0vxNFWIqz9rWkI
         rQ0YHcJGCx4pbR8G0rRtYBvMzdxa8B98XbxEPxyQJOLXT1VXVllHWa6Il1IQcMuZrnwr
         ql+rQqIecqkOP4ypLEEmnAsup9ef0T1id2r3S4WiyJwmBE5tmIfNs3F/rYed3FZhs4um
         ak2U26EkL75fVOkfefwvAxBhdTCxtV2hujrqlrYkRPFYdNNwfYeyPUR+ELUXQUuuyu6s
         zJuFu7xAntoBltwynfs/UxTeL9ORs7pV8nG4OWNQVQB9qySj+O9Sd6TJiGJL3lqCwbv0
         s2kg==
X-Gm-Message-State: AOAM532qQIo0UsTjZ/pWQaBMRx5sjAULBKpo4bc6p9utHvjW5U0TByCp
        S3+OgcqfFlqqH7Qi8MvmNAo=
X-Google-Smtp-Source: ABdhPJxdf5Tkx0nUi6VI9lITlkr6iMgXAUa5jl8skIoR+lH0HjOgPGT3Bs4B3cD2Dm70rePDDpGxZQ==
X-Received: by 2002:a05:6402:74e:: with SMTP id p14mr10998152edy.352.1601798127487;
        Sun, 04 Oct 2020 00:55:27 -0700 (PDT)
Received: from felia ([2001:16b8:2d26:f700:8d52:b46b:d125:e62a])
        by smtp.gmail.com with ESMTPSA id f17sm5886111edy.66.2020.10.04.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 00:55:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sun, 4 Oct 2020 09:55:13 +0200 (CEST)
X-X-Sender: lukas@felia
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 8/8] selftests/vm: hmm-tests: remove the libhugetlbfs
 dependency
In-Reply-To: <20200929212747.251804-9-jhubbard@nvidia.com>
Message-ID: <alpine.DEB.2.21.2010040948370.19434@felia>
References: <20200929212747.251804-1-jhubbard@nvidia.com> <20200929212747.251804-9-jhubbard@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On Tue, 29 Sep 2020, John Hubbard wrote:

> HMM selftests are incredibly useful, but they are only effective if
> people actually build and run them. All the other tests in selftests/vm
> can be built with very standard, always-available libraries: libpthread,
> librt. The hmm-tests.c program, on the other hand, requires something
> that is (much) less readily available: libhugetlbfs. And so the build
> will typically fail for many developers.
> 
> A simple attempt to install libhugetlbfs will also run into
> complications on some common distros these days: Fedora and Arch Linux
> (yes, Arch AUR has it, but that's fragile, as always with AUR). The
> library is not maintained actively enough at the moment, for distros to
> deal with it. I had to build it from source, for Fedora, and that didn't
> go too smoothly either.
> 
> It turns out that, out of 21 tests in hmm-tests.c, only 2 actually
> require functionality from libhugetlbfs. Therefore, if libhugetlbfs is
> missing, simply ifdef those two tests out and allow the developer to at
> least have the other 19 tests, if they don't want to pause to work
> through the above issues. Also issue a warning, so that it's clear that
> there is an imperfection in the build.
> 
> In order to do that, a tiny shell script (check_config.sh) runs a quick
> compile (not link, that's too prone to false failures with library
> paths), and basically, if the compiler doesn't find hugetlbfs.h in its
> standard locations, then the script concludes that libhugetlbfs is not
> available. The output is in two files, one for inclusion in hmm-test.c
> (local_config.h), and one for inclusion in the Makefile
> (local_config.mk).
> 
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/vm/.gitignore      |  1 +
>  tools/testing/selftests/vm/Makefile        | 24 +++++++++++++++--
>  tools/testing/selftests/vm/check_config.sh | 31 ++++++++++++++++++++++
>  tools/testing/selftests/vm/hmm-tests.c     | 10 ++++++-
>  4 files changed, 63 insertions(+), 3 deletions(-)
>  create mode 100755 tools/testing/selftests/vm/check_config.sh
> 
> diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
> index 2c8ddcf41c0e..e90d28bcd518 100644
> --- a/tools/testing/selftests/vm/.gitignore
> +++ b/tools/testing/selftests/vm/.gitignore
> @@ -20,3 +20,4 @@ va_128TBswitch
>  map_fixed_noreplace
>  write_to_hugetlbfs
>  hmm-tests
> +local_config.*
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 2579242386ac..019cbb7f3cf8 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for vm selftests
> +
> +include local_config.mk
> +

John, your change makes:

tools/testing/selftests$ make clean

fail with:

make[1]: Entering directory 
'/home/lukas/repositories/kernel.org/pub/scm/linux/kernel/git/next/linux-next/tools/testing/selftests/vm'
Makefile:4: local_config.mk: No such file or directory
./check_config.sh gcc
make[1]: execvp: ./check_config.sh: Permission denied
Makefile:141: recipe for target 'local_config.mk' failed
make[1]: *** [local_config.mk] Error 127

when make clean is called without building the vm selftests before, e.g., 
when someone just cleans everything in the repository to just be sure that 
everything is clean.

Lukas

>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
>  
> @@ -76,8 +79,6 @@ TEST_FILES := test_vmalloc.sh
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
> -$(OUTPUT)/hmm-tests: LDLIBS += -lhugetlbfs
> -
>  ifeq ($(ARCH),x86_64)
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
> @@ -130,3 +131,22 @@ endif
>  $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
>  
>  $(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> +
> +$(OUTPUT)/hmm-tests: local_config.h
> +
> +# HMM_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
> +$(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)
> +
> +local_config.mk local_config.h: check_config.sh
> +	./check_config.sh $(CC)
> +
> +EXTRA_CLEAN += local_config.mk local_config.h
> +
> +ifeq ($(HMM_EXTRA_LIBS),)
> +all: warn_missing_hugelibs
> +
> +warn_missing_hugelibs:
> +	@echo ; \
> +	echo "Warning: missing libhugetlbfs support. Some HMM tests will be skipped." ; \
> +	echo
> +endif
> diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/vm/check_config.sh
> new file mode 100755
> index 000000000000..079c8a40b85d
> --- /dev/null
> +++ b/tools/testing/selftests/vm/check_config.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Probe for libraries and create header files to record the results. Both C
> +# header files and Makefile include fragments are created.
> +
> +OUTPUT_H_FILE=local_config.h
> +OUTPUT_MKFILE=local_config.mk
> +
> +# libhugetlbfs
> +tmpname=$(mktemp)
> +tmpfile_c=${tmpname}.c
> +tmpfile_o=${tmpname}.o
> +
> +echo "#include <sys/types.h>"        > $tmpfile_c
> +echo "#include <hugetlbfs.h>"       >> $tmpfile_c
> +echo "int func(void) { return 0; }" >> $tmpfile_c
> +
> +CC=${1:?"Usage: $0 <compiler> # example compiler: gcc"}
> +$CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
> +
> +if [ -f $tmpfile_o ]; then
> +    echo "#define LOCAL_CONFIG_HAVE_LIBHUGETLBFS 1" > $OUTPUT_H_FILE
> +    echo "HMM_EXTRA_LIBS = -lhugetlbfs"             > $OUTPUT_MKFILE
> +else
> +    echo "// No libhugetlbfs support found"      > $OUTPUT_H_FILE
> +    echo "# No libhugetlbfs support found, so:"  > $OUTPUT_MKFILE
> +    echo "HMM_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
> +fi
> +
> +rm ${tmpname}.*
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
> index 0a28a6a29581..6b79723d7dc6 100644
> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -21,12 +21,16 @@
>  #include <strings.h>
>  #include <time.h>
>  #include <pthread.h>
> -#include <hugetlbfs.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>  
> +#include "./local_config.h"
> +#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
> +#include <hugetlbfs.h>
> +#endif
> +
>  /*
>   * This is a private UAPI to the kernel test module so it isn't exported
>   * in the usual include/uapi/... directory.
> @@ -662,6 +666,7 @@ TEST_F(hmm, anon_write_huge)
>  	hmm_buffer_free(buffer);
>  }
>  
> +#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
>  /*
>   * Write huge TLBFS page.
>   */
> @@ -720,6 +725,7 @@ TEST_F(hmm, anon_write_hugetlbfs)
>  	buffer->ptr = NULL;
>  	hmm_buffer_free(buffer);
>  }
> +#endif /* LOCAL_CONFIG_HAVE_LIBHUGETLBFS */
>  
>  /*
>   * Read mmap'ed file memory.
> @@ -1336,6 +1342,7 @@ TEST_F(hmm2, snapshot)
>  	hmm_buffer_free(buffer);
>  }
>  
> +#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
>  /*
>   * Test the hmm_range_fault() HMM_PFN_PMD flag for large pages that
>   * should be mapped by a large page table entry.
> @@ -1411,6 +1418,7 @@ TEST_F(hmm, compound)
>  	buffer->ptr = NULL;
>  	hmm_buffer_free(buffer);
>  }
> +#endif /* LOCAL_CONFIG_HAVE_LIBHUGETLBFS */
>  
>  /*
>   * Test two devices reading the same memory (double mapped).
> -- 
> 2.28.0
> 
> 
