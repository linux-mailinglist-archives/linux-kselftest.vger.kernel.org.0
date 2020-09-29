Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8442127DA18
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 23:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgI2V2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 17:28:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9213 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgI2V1w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 17:27:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73a6cb0000>; Tue, 29 Sep 2020 14:27:39 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 21:27:51 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 29 Sep 2020 21:27:51 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 8/8] selftests/vm: hmm-tests: remove the libhugetlbfs dependency
Date:   Tue, 29 Sep 2020 14:27:47 -0700
Message-ID: <20200929212747.251804-9-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929212747.251804-1-jhubbard@nvidia.com>
References: <20200929212747.251804-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601414859; bh=AVSdxVZXFvWRMunNETbWmE7BTClvZyiw51tTHsvnJC4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=CQN0D6jsPVRtQOJQkCS/LpMj+RtA5otEr4gJYWQsqS42nG+U+C5XfwBIlyfBU9PlC
         JI9tD4UrzKZSzO3GaiIIFxXspMY0uxPixDhe7O6AgJOwFdtZjQA4H52YPEfq63gSkF
         Y32Ia09Qs5WIHtpFI/2MRYx3/yVaSRo8OGqgQnl64BE2AqguJVgXdaGbo+DlWQ6u1W
         xwn9RAJmPxes3lTVurai5mCLRAL3l49DVuLM2sKcrC0AXmoVBxLsT+UiWrcQuu7TzA
         rhHhqv4hBxhR1LgpUaqcbYooL9QipAwq0FfVpMwAUO1o6og8OagxU30B2tqifaPAmf
         YUD1hcQcCKW0A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

HMM selftests are incredibly useful, but they are only effective if
people actually build and run them. All the other tests in selftests/vm
can be built with very standard, always-available libraries: libpthread,
librt. The hmm-tests.c program, on the other hand, requires something
that is (much) less readily available: libhugetlbfs. And so the build
will typically fail for many developers.

A simple attempt to install libhugetlbfs will also run into
complications on some common distros these days: Fedora and Arch Linux
(yes, Arch AUR has it, but that's fragile, as always with AUR). The
library is not maintained actively enough at the moment, for distros to
deal with it. I had to build it from source, for Fedora, and that didn't
go too smoothly either.

It turns out that, out of 21 tests in hmm-tests.c, only 2 actually
require functionality from libhugetlbfs. Therefore, if libhugetlbfs is
missing, simply ifdef those two tests out and allow the developer to at
least have the other 19 tests, if they don't want to pause to work
through the above issues. Also issue a warning, so that it's clear that
there is an imperfection in the build.

In order to do that, a tiny shell script (check_config.sh) runs a quick
compile (not link, that's too prone to false failures with library
paths), and basically, if the compiler doesn't find hugetlbfs.h in its
standard locations, then the script concludes that libhugetlbfs is not
available. The output is in two files, one for inclusion in hmm-test.c
(local_config.h), and one for inclusion in the Makefile
(local_config.mk).

Cc: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/.gitignore      |  1 +
 tools/testing/selftests/vm/Makefile        | 24 +++++++++++++++--
 tools/testing/selftests/vm/check_config.sh | 31 ++++++++++++++++++++++
 tools/testing/selftests/vm/hmm-tests.c     | 10 ++++++-
 4 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/vm/check_config.sh

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index 2c8ddcf41c0e..e90d28bcd518 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -20,3 +20,4 @@ va_128TBswitch
 map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
+local_config.*
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 2579242386ac..019cbb7f3cf8 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
+
+include local_config.mk
+
 uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
 MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
=20
@@ -76,8 +79,6 @@ TEST_FILES :=3D test_vmalloc.sh
 KSFT_KHDR_INSTALL :=3D 1
 include ../lib.mk
=20
-$(OUTPUT)/hmm-tests: LDLIBS +=3D -lhugetlbfs
-
 ifeq ($(ARCH),x86_64)
 BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
@@ -130,3 +131,22 @@ endif
 $(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap
=20
 $(OUTPUT)/gup_test: ../../../../mm/gup_test.h
+
+$(OUTPUT)/hmm-tests: local_config.h
+
+# HMM_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
+$(OUTPUT)/hmm-tests: LDLIBS +=3D $(HMM_EXTRA_LIBS)
+
+local_config.mk local_config.h: check_config.sh
+	./check_config.sh $(CC)
+
+EXTRA_CLEAN +=3D local_config.mk local_config.h
+
+ifeq ($(HMM_EXTRA_LIBS),)
+all: warn_missing_hugelibs
+
+warn_missing_hugelibs:
+	@echo ; \
+	echo "Warning: missing libhugetlbfs support. Some HMM tests will be skipp=
ed." ; \
+	echo
+endif
diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/sel=
ftests/vm/check_config.sh
new file mode 100755
index 000000000000..079c8a40b85d
--- /dev/null
+++ b/tools/testing/selftests/vm/check_config.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Probe for libraries and create header files to record the results. Both =
C
+# header files and Makefile include fragments are created.
+
+OUTPUT_H_FILE=3Dlocal_config.h
+OUTPUT_MKFILE=3Dlocal_config.mk
+
+# libhugetlbfs
+tmpname=3D$(mktemp)
+tmpfile_c=3D${tmpname}.c
+tmpfile_o=3D${tmpname}.o
+
+echo "#include <sys/types.h>"        > $tmpfile_c
+echo "#include <hugetlbfs.h>"       >> $tmpfile_c
+echo "int func(void) { return 0; }" >> $tmpfile_c
+
+CC=3D${1:?"Usage: $0 <compiler> # example compiler: gcc"}
+$CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
+
+if [ -f $tmpfile_o ]; then
+    echo "#define LOCAL_CONFIG_HAVE_LIBHUGETLBFS 1" > $OUTPUT_H_FILE
+    echo "HMM_EXTRA_LIBS =3D -lhugetlbfs"             > $OUTPUT_MKFILE
+else
+    echo "// No libhugetlbfs support found"      > $OUTPUT_H_FILE
+    echo "# No libhugetlbfs support found, so:"  > $OUTPUT_MKFILE
+    echo "HMM_EXTRA_LIBS =3D "                    >> $OUTPUT_MKFILE
+fi
+
+rm ${tmpname}.*
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index 0a28a6a29581..6b79723d7dc6 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -21,12 +21,16 @@
 #include <strings.h>
 #include <time.h>
 #include <pthread.h>
-#include <hugetlbfs.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
=20
+#include "./local_config.h"
+#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
+#include <hugetlbfs.h>
+#endif
+
 /*
  * This is a private UAPI to the kernel test module so it isn't exported
  * in the usual include/uapi/... directory.
@@ -662,6 +666,7 @@ TEST_F(hmm, anon_write_huge)
 	hmm_buffer_free(buffer);
 }
=20
+#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
 /*
  * Write huge TLBFS page.
  */
@@ -720,6 +725,7 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	buffer->ptr =3D NULL;
 	hmm_buffer_free(buffer);
 }
+#endif /* LOCAL_CONFIG_HAVE_LIBHUGETLBFS */
=20
 /*
  * Read mmap'ed file memory.
@@ -1336,6 +1342,7 @@ TEST_F(hmm2, snapshot)
 	hmm_buffer_free(buffer);
 }
=20
+#ifdef LOCAL_CONFIG_HAVE_LIBHUGETLBFS
 /*
  * Test the hmm_range_fault() HMM_PFN_PMD flag for large pages that
  * should be mapped by a large page table entry.
@@ -1411,6 +1418,7 @@ TEST_F(hmm, compound)
 	buffer->ptr =3D NULL;
 	hmm_buffer_free(buffer);
 }
+#endif /* LOCAL_CONFIG_HAVE_LIBHUGETLBFS */
=20
 /*
  * Test two devices reading the same memory (double mapped).
--=20
2.28.0

