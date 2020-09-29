Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9AD27DA02
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 23:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgI2V1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 17:27:51 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9200 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgI2V1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 17:27:50 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73a6ca0000>; Tue, 29 Sep 2020 14:27:38 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 21:27:50 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 29 Sep 2020 21:27:50 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 4/8] selftests/vm: minor cleanup: Makefile and gup_test.c
Date:   Tue, 29 Sep 2020 14:27:43 -0700
Message-ID: <20200929212747.251804-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929212747.251804-1-jhubbard@nvidia.com>
References: <20200929212747.251804-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601414858; bh=Zni9lsR5e1NjfmaK4G4iADG4DW7oG777ffq2baIKbVA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=MVLqPfh2hox+vkU1QYnvn6Hc8neNua+34WXDYESz+8Qk72x3TO4mNLySc7KlOgQIg
         0dTOIC6v9EyywdhlAs9w7K95g/Kgz6nC07cp6oYlvmHBYSwR1Vud2HHWq0Va+L8Gdo
         dPrK7A3wCcNSVt5Z8JbqzVKhNwMKRhW1IU7sKi9Vu7jp7Rd9g1uWtZ3SW+yvHB+IR6
         mFppCRaDP8Tcy6cleNK7FHo52YJBjeGrgmsT92MO++0SbuMsWOuoTYaMZGKXeKrOKz
         JvKDdnV92YtN68Gv+IX9G1RTl5YerB39KFobY3sTbo7euYVwn9KeQgZci1htWqjDvA
         KID6qSeUfznew==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few cleanups that don't deserve separate patches, but that
also should not clutter up other functional changes:

1. Remove an unnecessary #include <prctl.h>

2. Restore the sorted order of TEST_GEN_FILES.

3. Add -lpthread to the common LDLIBS, as it is harmless and several
   tests use it. This gets rid of one special rule already.

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

