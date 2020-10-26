Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E492986F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770542AbgJZGlC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 02:41:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11571 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421151AbgJZGlB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 02:41:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f966f850001>; Sun, 25 Oct 2020 23:41:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:41:01 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 06:41:01 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 4/9] selftests/vm: minor cleanup: Makefile and gup_test.c
Date:   Sun, 25 Oct 2020 23:40:16 -0700
Message-ID: <20201026064021.3545418-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026064021.3545418-1-jhubbard@nvidia.com>
References: <20201026064021.3545418-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603694469; bh=jAW2erca/lPvgmMlDMit8iJH5aT9dbYtQAb9k632O5c=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type:X-NVConfidentiality:
         Content-Transfer-Encoding;
        b=JOM3HoghbwrG4qmTdEetO5ICoWlp4i1qJn5KRBp893KjGiuvdRVpHfA7zconnAy8V
         illzyyz//jCHDRuV8OYnS9JiDBJ0DhObDtTOwo2x5nv5SQpY9nRhNMPGEqKBYNtKkO
         C4SDTizWZfU0j1oKOU/9k3QN56rKclQUGwvWi6gehm+e/uxiRGa5lcz1YPxyB0tXg3
         aRo1zcQhGVnEL1CvWqR11c8oHTFn6PkG2SAeKRmfLM+iXRmS2U9ovJoG0vnn38tzEu
         cKRjefMx2rL8i1A6nf31nksASFgz9LaHgy7PmBNxsgbJgipBMysLpIjaWr+ACJce2s
         HxOKi+QI4rkew==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few cleanups that don't deserve separate patches, but that also should
not clutter up other functional changes:

1. Remove an unnecessary #include <prctl.h>

2. Restore the sorted order of TEST_GEN_FILES.

3. Add -lpthread to the common LDLIBS, as it is harmless and several
   tests use it. This gets rid of one special rule already.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/Makefile   | 10 ++++------
 tools/testing/selftests/vm/gup_test.c |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/=
vm/Makefile
index 5a3bd0c497b6..2579242386ac 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -21,14 +21,15 @@ MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch6=
4.*/arm64/')
 MAKEFLAGS +=3D --no-builtin-rules
=20
 CFLAGS =3D -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
-LDLIBS =3D -lrt
+LDLIBS =3D -lrt -lpthread
 TEST_GEN_FILES =3D compaction_test
 TEST_GEN_FILES +=3D gup_test
 TEST_GEN_FILES +=3D hmm-tests
 TEST_GEN_FILES +=3D hugepage-mmap
 TEST_GEN_FILES +=3D hugepage-shm
-TEST_GEN_FILES +=3D map_hugetlb
+TEST_GEN_FILES +=3D khugepaged
 TEST_GEN_FILES +=3D map_fixed_noreplace
+TEST_GEN_FILES +=3D map_hugetlb
 TEST_GEN_FILES +=3D map_populate
 TEST_GEN_FILES +=3D mlock-random-test
 TEST_GEN_FILES +=3D mlock2-tests
@@ -37,7 +38,6 @@ TEST_GEN_FILES +=3D on-fault-limit
 TEST_GEN_FILES +=3D thuge-gen
 TEST_GEN_FILES +=3D transhuge-stress
 TEST_GEN_FILES +=3D userfaultfd
-TEST_GEN_FILES +=3D khugepaged
=20
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 :=3D $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bi=
t_program.c -m32)
@@ -76,7 +76,7 @@ TEST_FILES :=3D test_vmalloc.sh
 KSFT_KHDR_INSTALL :=3D 1
 include ../lib.mk
=20
-$(OUTPUT)/hmm-tests: LDLIBS +=3D -lhugetlbfs -lpthread
+$(OUTPUT)/hmm-tests: LDLIBS +=3D -lhugetlbfs
=20
 ifeq ($(ARCH),x86_64)
 BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
@@ -127,8 +127,6 @@ warn_32bit_failure:
 endif
 endif
=20
-$(OUTPUT)/userfaultfd: LDLIBS +=3D -lpthread
-
 $(OUTPUT)/mlock-random-test: LDLIBS +=3D -lcap
=20
 $(OUTPUT)/gup_test: ../../../../mm/gup_test.h
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftest=
s/vm/gup_test.c
index 03f7c4f1beaf..1a54771ad97e 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -4,7 +4,6 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include "../../../../mm/gup_test.h"
--=20
2.29.0

