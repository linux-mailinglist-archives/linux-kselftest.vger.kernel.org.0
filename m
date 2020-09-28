Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035CE27A771
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 08:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1GWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 02:22:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2548 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgI1GWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 02:22:02 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7180d80000>; Sun, 27 Sep 2020 23:21:12 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 06:22:01 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 28 Sep 2020 06:22:01 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/8] selftests/vm: minor cleanup: Makefile and gup_test.c
Date:   Sun, 27 Sep 2020 23:21:55 -0700
Message-ID: <20200928062159.923212-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928062159.923212-1-jhubbard@nvidia.com>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601274072; bh=cvfUQXS5i3gjS2Lj/vW+CXa7JmDZMTtVpc3vMQ+mh1o=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=kPZ4KH9vt5Jl2TO+17SGLN6/uIc8df/Na7QQ0Ij10Ho98g9XsgliYB8yUAcQfG8ft
         XwtmAhVBA1g7TElNsJz2FEInkvwjSSeotoVCMs+0bmzOEbaU8+MGcM9N3iYLFjlIs9
         eZeoxEW3JJqsJwr7md24Uycty1sucjLKpicUFFNeF60QBvdBQdKxMeVq/qlQcrb67W
         JRxhesV68cS/iF1yIRK1ETJpaGD3bxH3mJnvv/zHsOZ0Jd7OG+jc/HHccQIuSg2FN7
         jfOV0QP+j3Bh3zuL6SpOvRlXiasWJ6JmaaWwNH53ZZFwEvmzpRmVR7V6RrqYIKZH1T
         WdW+LwqH7EzcA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few cleanups that don't deserve separate patches, but that
also should not clutter up other functional changes:

1. Remove an unnecessary #include <prctl.h>

2. Restore the sorted order of TEST_GEN_FILES.

3. Add -lpthread to the common LDLIBS, as it is harmless and several
   tests use it. Including, soon, gup_test.c. This gets rid of one
   special rule already.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
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
index 70db259582c3..4e9f5d0ed0fc 100644
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
2.28.0

