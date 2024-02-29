Return-Path: <linux-kselftest+bounces-5622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F786C57E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E362927E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1960862;
	Thu, 29 Feb 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oHUYK17M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF178605DF
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199483; cv=none; b=hoTacXRputuGyFQSxjlFNnEw/RZRFEMgvCN8A7uI78d4Q4/ylO1T/8HwnSWLoj4nH7OhfFp8aoafzEiPNpayKdXzTlnaDuWJjQEpQSmS1vJZCvbDBU5+Ljbu5blimF6a4YBC6aR5mxKL16dbN5vwoDTyktvJjwamWr9CIbzkT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199483; c=relaxed/simple;
	bh=KOnoo1AcevtbVmSJ8w8A4w7ISkJ7W5VAaSUNJQz4bXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlABDPcGXcaji6j5EZBYo2LAr20dYy+ZhyI7R0LGBSyIl7AzZIfF+r/w4SnA7Cs0ZfhZjhf8S/9X1TLBkvgu0xK/SbSU9bSDhl8xgMKSIbvKnOgZvvSSEuFjJ3NiUvgABAtUfuIGOkj0wXqCdWNoYWow5hKzmhXJJxbpPE2pSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oHUYK17M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T8vePX017498;
	Thu, 29 Feb 2024 09:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/jbPxAgduvmxwTZObvDkbL9m70QDDFsQlAGyZSZ72u8=;
 b=oHUYK17MvuKnUrUzb+Y4VyJhBwxqdA9SEmFWT07Y2JPFqmNH+aHPHXKw7AIhPaqRD+iP
 BEjOJWvJ41IaSns2dPhXDSS1wC+VGz5yTLCVAz1D3usGkgiY3VOEDjaHkDGKG9FJ2zTi
 7L23Xt1Hm9CGy2sRqFHZz45YU9/I36ekBG0WbsvwKY8Rzg6XGF3QZ3XxO7Fm761BhIGU
 gFTijbeG8Xfh9SUmXdmKjc9772V1TUQvR8ej4CxJyY9p1gyKK822lR8tN6PDqI1bbFcH
 e3OF8R1UaE6tHCHGmbuA+mE2ej48e2gCTrg5t9iXIwl3mGHlBod+/qYXFUI8W6Zpx4Y9 Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpv5s7sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:50 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T9Wcx8011615;
	Thu, 29 Feb 2024 09:37:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpv5s7sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T7GhVD024144;
	Thu, 29 Feb 2024 09:37:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0km25s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T9bhlO65012162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:37:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF48420049;
	Thu, 29 Feb 2024 09:37:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F1520040;
	Thu, 29 Feb 2024 09:37:39 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.171.62.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 09:37:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 3/3] selftest/powerpc: make sub-folders buildable on it own 
Date: Thu, 29 Feb 2024 15:07:11 +0530
Message-ID: <20240229093711.581230-3-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229093711.581230-1-maddy@linux.ibm.com>
References: <20240229093711.581230-1-maddy@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bg6thlSAD10wahMeks3Uk4ZkMCMkrPo0
X-Proofpoint-ORIG-GUID: 7g34ufPShcfy3NITsujfrelcEtZCQmfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290072

Build breaks when executing make with run_tests for sub-folders
under powerpc. This is because, CFLAGS and GIT_VERSION macros are
defined in Makefile of toplevel powerpc folder.

make: Entering directory '/home/maddy/linux/tools/testing/selftests/powerpc/mm'
gcc     hugetlb_vs_thp_test.c ../harness.c ../utils.c  -o /home/maddy/selftest_output//hugetlb_vs_thp_test
hugetlb_vs_thp_test.c:6:10: fatal error: utils.h: No such file or directory
    6 | #include "utils.h"
      |          ^~~~~~~~~
compilation terminated.

Fix this by adding the flags.mk in each sub-folder Makefile.
Also remove the CFLAGS and GIT_VERSION macros from powerpc/
folder Makefile since the same is definied in flags.mk

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile                 | 7 +------
 tools/testing/selftests/powerpc/alignment/Makefile       | 1 +
 tools/testing/selftests/powerpc/benchmarks/Makefile      | 1 +
 tools/testing/selftests/powerpc/cache_shape/Makefile     | 1 +
 tools/testing/selftests/powerpc/copyloops/Makefile       | 1 +
 tools/testing/selftests/powerpc/dexcr/Makefile           | 1 +
 tools/testing/selftests/powerpc/dscr/Makefile            | 1 +
 tools/testing/selftests/powerpc/eeh/Makefile             | 1 +
 tools/testing/selftests/powerpc/math/Makefile            | 1 +
 tools/testing/selftests/powerpc/mce/Makefile             | 1 +
 tools/testing/selftests/powerpc/mm/Makefile              | 1 +
 tools/testing/selftests/powerpc/nx-gzip/Makefile         | 1 +
 tools/testing/selftests/powerpc/papr_attributes/Makefile | 3 ++-
 tools/testing/selftests/powerpc/papr_sysparm/Makefile    | 1 +
 tools/testing/selftests/powerpc/papr_vpd/Makefile        | 1 +
 tools/testing/selftests/powerpc/primitives/Makefile      | 1 +
 tools/testing/selftests/powerpc/ptrace/Makefile          | 1 +
 tools/testing/selftests/powerpc/security/Makefile        | 1 +
 tools/testing/selftests/powerpc/signal/Makefile          | 1 +
 tools/testing/selftests/powerpc/stringloops/Makefile     | 1 +
 tools/testing/selftests/powerpc/switch_endian/Makefile   | 1 +
 tools/testing/selftests/powerpc/syscalls/Makefile        | 1 +
 tools/testing/selftests/powerpc/tm/Makefile              | 1 +
 tools/testing/selftests/powerpc/vphn/Makefile            | 1 +
 24 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index c376151982c4..2f299fd04d2d 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -7,12 +7,6 @@ ARCH := $(shell echo $(ARCH) | sed -e s/ppc.*/powerpc/)
 
 ifeq ($(ARCH),powerpc)
 
-GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
-
-CFLAGS := -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR)/include $(CFLAGS)
-
-export CFLAGS
-
 SUB_DIRS = alignment		\
 	   benchmarks		\
 	   cache_shape		\
@@ -46,6 +40,7 @@ $(SUB_DIRS):
 	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
 
 include ../lib.mk
+include ./flags.mk
 
 override define RUN_TESTS
 	+@for TARGET in $(SUB_DIRS); do \
diff --git a/tools/testing/selftests/powerpc/alignment/Makefile b/tools/testing/selftests/powerpc/alignment/Makefile
index 93e9af37449d..66d5d7aaeb20 100644
--- a/tools/testing/selftests/powerpc/alignment/Makefile
+++ b/tools/testing/selftests/powerpc/alignment/Makefile
@@ -3,5 +3,6 @@ TEST_GEN_PROGS := copy_first_unaligned alignment_handler
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index 75f5232c3aec..1321922038d0 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -6,6 +6,7 @@ TEST_FILES := settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS += -O2
 
diff --git a/tools/testing/selftests/powerpc/cache_shape/Makefile b/tools/testing/selftests/powerpc/cache_shape/Makefile
index 689f6c8ebcd8..3a3ca956ac66 100644
--- a/tools/testing/selftests/powerpc/cache_shape/Makefile
+++ b/tools/testing/selftests/powerpc/cache_shape/Makefile
@@ -3,5 +3,6 @@ TEST_GEN_PROGS := cache_shape
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index 72684ed589c0..42940f92d832 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -10,6 +10,7 @@ EXTRA_SOURCES := validate.c ../harness.c stubs.S
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 # The loops are all 64-bit code
 CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/dexcr/Makefile b/tools/testing/selftests/powerpc/dexcr/Makefile
index 76210f2bcec3..523947a38d17 100644
--- a/tools/testing/selftests/powerpc/dexcr/Makefile
+++ b/tools/testing/selftests/powerpc/dexcr/Makefile
@@ -2,6 +2,7 @@ TEST_GEN_PROGS := hashchk_test
 TEST_GEN_FILES := lsdexcr
 
 include ../../lib.mk
+include ../flags.mk
 
 $(OUTPUT)/hashchk_test: CFLAGS += -fno-pie $(call cc-option,-mno-rop-protect)
 
diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index 9289d5febe1e..9fa9cb5bd989 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -5,6 +5,7 @@ TEST_GEN_PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(OUTPUT)/dscr_default_test: LDLIBS += -lpthread
 $(OUTPUT)/dscr_explicit_test: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/powerpc/eeh/Makefile b/tools/testing/selftests/powerpc/eeh/Makefile
index ae963eb2dc5b..70797716f2b5 100644
--- a/tools/testing/selftests/powerpc/eeh/Makefile
+++ b/tools/testing/selftests/powerpc/eeh/Makefile
@@ -7,3 +7,4 @@ TEST_FILES := eeh-functions.sh settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
index 3948f7c510aa..b14fd2e0c6a8 100644
--- a/tools/testing/selftests/powerpc/math/Makefile
+++ b/tools/testing/selftests/powerpc/math/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS := fpu_syscall fpu_preempt fpu_signal fpu_denormal vmx_syscall vm
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c
 $(TEST_GEN_PROGS): CFLAGS += -O2 -g -pthread -m64 -maltivec
diff --git a/tools/testing/selftests/powerpc/mce/Makefile b/tools/testing/selftests/powerpc/mce/Makefile
index 2424513982d9..ce4ed679aaaf 100644
--- a/tools/testing/selftests/powerpc/mce/Makefile
+++ b/tools/testing/selftests/powerpc/mce/Makefile
@@ -3,5 +3,6 @@
 TEST_GEN_PROGS := inject-ra-err
 
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 4a6608beef0e..aab058ecb352 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -13,6 +13,7 @@ TEST_GEN_FILES := tempfile
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
 
diff --git a/tools/testing/selftests/powerpc/nx-gzip/Makefile b/tools/testing/selftests/powerpc/nx-gzip/Makefile
index b40991f902b2..480d8ba94cf7 100644
--- a/tools/testing/selftests/powerpc/nx-gzip/Makefile
+++ b/tools/testing/selftests/powerpc/nx-gzip/Makefile
@@ -2,6 +2,7 @@ TEST_GEN_FILES := gzfht_test gunz_test
 TEST_PROGS := nx-gzip-test.sh
 
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS = -O3 -m64 -I./include -I../include
 
diff --git a/tools/testing/selftests/powerpc/papr_attributes/Makefile b/tools/testing/selftests/powerpc/papr_attributes/Makefile
index e899712d49db..406429499022 100644
--- a/tools/testing/selftests/powerpc/papr_attributes/Makefile
+++ b/tools/testing/selftests/powerpc/papr_attributes/Makefile
@@ -3,5 +3,6 @@ TEST_GEN_PROGS := attr_test
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
-$(TEST_GEN_PROGS): ../harness.c ../utils.c
\ No newline at end of file
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/papr_sysparm/Makefile b/tools/testing/selftests/powerpc/papr_sysparm/Makefile
index 7f79e437634a..fed4f2414dbf 100644
--- a/tools/testing/selftests/powerpc/papr_sysparm/Makefile
+++ b/tools/testing/selftests/powerpc/papr_sysparm/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_PROGS := papr_sysparm
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
 
diff --git a/tools/testing/selftests/powerpc/papr_vpd/Makefile b/tools/testing/selftests/powerpc/papr_vpd/Makefile
index 06b719703bfd..b09852e40882 100644
--- a/tools/testing/selftests/powerpc/papr_vpd/Makefile
+++ b/tools/testing/selftests/powerpc/papr_vpd/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_PROGS := papr_vpd
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
 
diff --git a/tools/testing/selftests/powerpc/primitives/Makefile b/tools/testing/selftests/powerpc/primitives/Makefile
index 6dc5c5a42ca9..23bd9a7590dd 100644
--- a/tools/testing/selftests/powerpc/primitives/Makefile
+++ b/tools/testing/selftests/powerpc/primitives/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS := load_unaligned_zeropad
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS += -I$(CURDIR)
 
diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 1b39b86849da..59ca01d8567e 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -26,6 +26,7 @@ LOCAL_HDRS += $(patsubst %,$(selfdir)/powerpc/ptrace/%,$(wildcard *.h))
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 TM_TESTS := $(patsubst %,$(OUTPUT)/%,$(TM_TESTS))
 TESTS_64 := $(patsubst %,$(OUTPUT)/%,$(TESTS_64))
diff --git a/tools/testing/selftests/powerpc/security/Makefile b/tools/testing/selftests/powerpc/security/Makefile
index 0a08386be969..33286039724a 100644
--- a/tools/testing/selftests/powerpc/security/Makefile
+++ b/tools/testing/selftests/powerpc/security/Makefile
@@ -6,6 +6,7 @@ TEST_PROGS := mitigation-patching.sh
 top_srcdir = ../../../../..
 
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS += $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index b15d5dbccc24..ece95bd52be9 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -10,6 +10,7 @@ TEST_FILES := settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS += -maltivec
 
diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 87c8c8f238da..4c9d9a58c9d1 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -26,6 +26,7 @@ endif
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 # The loops are all 64-bit code
 CFLAGS += -I$(CURDIR)
diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
index 8f0c2a1d3333..0da2e0a74264 100644
--- a/tools/testing/selftests/powerpc/switch_endian/Makefile
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -5,6 +5,7 @@ EXTRA_CLEAN = $(OUTPUT)/*.o $(OUTPUT)/check-reversed.S
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 ASFLAGS += -O2 -Wall -g -nostdlib -m64
 
diff --git a/tools/testing/selftests/powerpc/syscalls/Makefile b/tools/testing/selftests/powerpc/syscalls/Makefile
index 83dc33500773..3bc07af88f0e 100644
--- a/tools/testing/selftests/powerpc/syscalls/Makefile
+++ b/tools/testing/selftests/powerpc/syscalls/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS := ipc_unmuxed rtas_filter
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS += $(KHDR_INCLUDES)
 
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 3876805c2f31..f13f0ab36007 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -11,6 +11,7 @@ TEST_FILES := settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
 
diff --git a/tools/testing/selftests/powerpc/vphn/Makefile b/tools/testing/selftests/powerpc/vphn/Makefile
index ddc09a20b80f..61d519a076c6 100644
--- a/tools/testing/selftests/powerpc/vphn/Makefile
+++ b/tools/testing/selftests/powerpc/vphn/Makefile
@@ -3,6 +3,7 @@ TEST_GEN_PROGS := test-vphn
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 CFLAGS += -m64 -I$(CURDIR)
 
-- 
2.43.2


