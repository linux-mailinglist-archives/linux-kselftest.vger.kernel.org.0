Return-Path: <linux-kselftest+bounces-5620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509186C57C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3E8B26D83
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C9605D2;
	Thu, 29 Feb 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/A5BK18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CF605CA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199470; cv=none; b=n1+nnNGNq6dWkyDUDfXUHicwNT4BBBn2XxBovbooQUNGxmRRa2ne4/hDxfQUz5p/Q5+OTQmsi5I5qnGLWrMziLoZarw0kMebuRPQ5u2kMVTO6JNrq4gGqZXH3R9f87+t9vf5ttLPmPh3JaOAObAIXgXO8igxa/I4Ovniw/7gQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199470; c=relaxed/simple;
	bh=hQeKZOlDaGBGc6afp5T/+Y1BAda9Uo1CnZPBoZ1zhgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+o4PBqkqHokCYOxiA4WTm8tEDOaB5WopfwHKtFGRCUwK1eY07pnsjn9SuzHGAHAx6G+9BvFl6Wey4EPGHGliKqbtP7CYToDwKZdVJzP/mwAOSuUYy8nLA1WE5z2XJJpol5AHWZP82WoBHUNEwnjZ4sKHbIB1Lt+f1Hf3+7SnR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/A5BK18; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9WnEB006733;
	Thu, 29 Feb 2024 09:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xF/Jh+HYUZ374FWeLpWsIv90kysG6gsx0WncJ5q1Q/8=;
 b=R/A5BK183Ma2QH9uv+PJlyc+45RcSszxG+prsqbOr7C0eHSGa/t9hkLzBjfFl+Wt73zN
 O/Ot03Bhq2heL2zDVne7i/PnNWkJf/M26eSP3kphCgG1xLdZqZh2E4WzPJPYFotggtjj
 g1pgdHasTwQ6vtDW/Eqfhfq8/05O5MMBcXc1P+XP4gdlbGQ005vJcApXGyNTKz12VX8U
 iKq6wSZJ0VXETIf1++Q+q4GUH8yAq1kCdMLPcGhKowSIs0SS/k3YahbRjq5vZA8MVTVO
 Ekmzr9htsccNv9Yh1pcFMRLFPS8eQSgdFGNCmGMU9EydXRH0/20yLwqf+hkqF9dbLwGg aA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqcwr4ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:35 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T9XDge007906;
	Thu, 29 Feb 2024 09:37:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqcwr4f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T8iXi7021306;
	Thu, 29 Feb 2024 09:37:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfuspccbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T9bSrI20644500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:37:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C052004B;
	Thu, 29 Feb 2024 09:37:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FBDF20040;
	Thu, 29 Feb 2024 09:37:24 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.171.62.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 09:37:24 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 1/3] selftest/powerpc: Re-order *FLAGS to follow lib.mk
Date: Thu, 29 Feb 2024 15:07:09 +0530
Message-ID: <20240229093711.581230-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ScYIhtXtuKEkJSbTX9mRCbPcipizPbXC
X-Proofpoint-ORIG-GUID: rp8F1SgO_bWW6nKUGIibT3cZADc1sG0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402290072

In some powerpc/ sub-folder Makefiles, CFLAGS are
defined before lib.mk include. Clean it up by
re-ordering it to follow after the mk include.
This is needed to support sub-folders in powerpc/
buildable on its own.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 .../selftests/powerpc/benchmarks/Makefile     |  4 ++--
 .../selftests/powerpc/copyloops/Makefile      | 20 +++++++++----------
 .../selftests/powerpc/nx-gzip/Makefile        |  4 ++--
 .../selftests/powerpc/pmu/ebb/Makefile        | 20 +++++++++----------
 .../powerpc/pmu/event_code_tests/Makefile     |  4 ++--
 .../powerpc/pmu/sampling_tests/Makefile       |  4 ++--
 .../selftests/powerpc/primitives/Makefile     |  4 ++--
 .../selftests/powerpc/security/Makefile       |  4 ++--
 .../testing/selftests/powerpc/signal/Makefile |  3 ++-
 .../selftests/powerpc/stringloops/Makefile    | 10 +++++-----
 .../selftests/powerpc/switch_endian/Makefile  |  4 ++--
 .../selftests/powerpc/syscalls/Makefile       |  4 ++--
 tools/testing/selftests/powerpc/vphn/Makefile |  4 ++--
 13 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index a32a6ab89914..75f5232c3aec 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -4,11 +4,11 @@ TEST_GEN_FILES := exec_target
 
 TEST_FILES := settings
 
-CFLAGS += -O2
-
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+CFLAGS += -O2
+
 $(TEST_GEN_PROGS): ../harness.c
 
 $(OUTPUT)/context_switch: ../utils.c
diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index 77594e697f2f..72684ed589c0 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -1,14 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# The loops are all 64-bit code
-CFLAGS += -m64
-CFLAGS += -I$(CURDIR)
-CFLAGS += -D SELFTEST
-CFLAGS += -maltivec
-CFLAGS += -mcpu=power4
-
-# Use our CFLAGS for the implicit .S rule & set the asm machine type
-ASFLAGS = $(CFLAGS) -Wa,-mpower4
-
 TEST_GEN_PROGS := copyuser_64_t0 copyuser_64_t1 copyuser_64_t2 \
 		copyuser_p7_t0 copyuser_p7_t1 \
 		memcpy_64_t0 memcpy_64_t1 memcpy_64_t2 \
@@ -21,6 +11,16 @@ EXTRA_SOURCES := validate.c ../harness.c stubs.S
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+# The loops are all 64-bit code
+CFLAGS += -m64
+CFLAGS += -I$(CURDIR)
+CFLAGS += -D SELFTEST
+CFLAGS += -maltivec
+CFLAGS += -mcpu=power4
+
+# Use our CFLAGS for the implicit .S rule & set the asm machine type
+ASFLAGS = $(CFLAGS) -Wa,-mpower4
+
 $(OUTPUT)/copyuser_64_t%:	copyuser_64.S $(EXTRA_SOURCES)
 	$(CC) $(CPPFLAGS) $(CFLAGS) \
 		-D COPY_LOOP=test___copy_tofrom_user_base \
diff --git a/tools/testing/selftests/powerpc/nx-gzip/Makefile b/tools/testing/selftests/powerpc/nx-gzip/Makefile
index 0785c2e99d40..b40991f902b2 100644
--- a/tools/testing/selftests/powerpc/nx-gzip/Makefile
+++ b/tools/testing/selftests/powerpc/nx-gzip/Makefile
@@ -1,8 +1,8 @@
-CFLAGS = -O3 -m64 -I./include -I../include
-
 TEST_GEN_FILES := gzfht_test gunz_test
 TEST_PROGS := nx-gzip-test.sh
 
 include ../../lib.mk
 
+CFLAGS = -O3 -m64 -I./include -I../include
+
 $(TEST_GEN_FILES): gzip_vas.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 010160690227..b3946ce17e0c 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -4,16 +4,6 @@ include ../../../../../build/Build.include
 noarg:
 	$(MAKE) -C ../../
 
-# The EBB handler is 64-bit code and everything links against it
-CFLAGS += -m64
-
-TMPOUT = $(OUTPUT)/TMPDIR/
-# Toolchains may build PIE by default which breaks the assembly
-no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
-
-LDFLAGS += $(no-pie-option)
-
 TEST_GEN_PROGS := reg_access_test event_attributes_test cycles_test	\
 	 cycles_with_freeze_test pmc56_overflow_test		\
 	 ebb_vs_cpu_event_test cpu_event_vs_ebb_test		\
@@ -29,6 +19,16 @@ TEST_GEN_PROGS := reg_access_test event_attributes_test cycles_test	\
 top_srcdir = ../../../../../..
 include ../../../lib.mk
 
+# The EBB handler is 64-bit code and everything links against it
+CFLAGS += -m64
+
+TMPOUT = $(OUTPUT)/TMPDIR/
+# Toolchains may build PIE by default which breaks the assembly
+no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
+        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
+
+LDFLAGS += $(no-pie-option)
+
 $(TEST_GEN_PROGS): ../../harness.c ../../utils.c ../event.c ../lib.c \
 	       ebb.c ebb_handler.S trace.c busy_loop.S
 
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile b/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile
index 4e07d7046457..509d4b235b9e 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -m64
-
 TEST_GEN_PROGS := group_constraint_pmc56_test group_pmc56_exclude_constraints_test group_constraint_pmc_count_test \
 	group_constraint_repeat_test group_constraint_radix_scope_qual_test reserved_bits_mmcra_sample_elig_mode_test \
 	group_constraint_mmcra_sample_test invalid_event_code_test reserved_bits_mmcra_thresh_ctl_test \
@@ -12,4 +10,6 @@ TEST_GEN_PROGS := group_constraint_pmc56_test group_pmc56_exclude_constraints_te
 top_srcdir = ../../../../../..
 include ../../../lib.mk
 
+CFLAGS += -m64
+
 $(TEST_GEN_PROGS): ../../harness.c ../../utils.c ../event.c ../lib.c ../sampling_tests/misc.h ../sampling_tests/misc.c
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile b/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile
index 9e67351fb252..d45892151e05 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -m64
-
 TEST_GEN_PROGS := mmcr0_exceptionbits_test mmcr0_cc56run_test mmcr0_pmccext_test \
 		   mmcr0_pmcjce_test mmcr0_fc56_pmc1ce_test mmcr0_fc56_pmc56_test \
 		   mmcr1_comb_test mmcr2_l2l3_test mmcr2_fcs_fch_test \
@@ -12,4 +10,6 @@ TEST_GEN_PROGS := mmcr0_exceptionbits_test mmcr0_cc56run_test mmcr0_pmccext_test
 top_srcdir = ../../../../../..
 include ../../../lib.mk
 
+CFLAGS += -m64
+
 $(TEST_GEN_PROGS): ../../harness.c ../../utils.c ../event.c ../lib.c misc.c misc.h ../loop.S ../branch_loops.S
diff --git a/tools/testing/selftests/powerpc/primitives/Makefile b/tools/testing/selftests/powerpc/primitives/Makefile
index 9b9491a63213..6dc5c5a42ca9 100644
--- a/tools/testing/selftests/powerpc/primitives/Makefile
+++ b/tools/testing/selftests/powerpc/primitives/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -I$(CURDIR)
-
 TEST_GEN_PROGS := load_unaligned_zeropad
 
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+CFLAGS += -I$(CURDIR)
+
 $(TEST_GEN_PROGS): ../harness.c
diff --git a/tools/testing/selftests/powerpc/security/Makefile b/tools/testing/selftests/powerpc/security/Makefile
index e0d979ab0204..0a08386be969 100644
--- a/tools/testing/selftests/powerpc/security/Makefile
+++ b/tools/testing/selftests/powerpc/security/Makefile
@@ -5,10 +5,10 @@ TEST_PROGS := mitigation-patching.sh
 
 top_srcdir = ../../../../..
 
-CFLAGS += $(KHDR_INCLUDES)
-
 include ../../lib.mk
 
+CFLAGS += $(KHDR_INCLUDES)
+
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
 
 $(OUTPUT)/spectre_v2: CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index f679d260afc8..b15d5dbccc24 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -3,7 +3,6 @@ TEST_GEN_PROGS := signal signal_tm sigfuz sigreturn_vdso sig_sc_double_restart
 TEST_GEN_PROGS += sigreturn_kernel
 TEST_GEN_PROGS += sigreturn_unaligned
 
-CFLAGS += -maltivec
 $(OUTPUT)/signal_tm: CFLAGS += -mhtm
 $(OUTPUT)/sigfuz: CFLAGS += -pthread -m64
 
@@ -12,4 +11,6 @@ TEST_FILES := settings
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+CFLAGS += -maltivec
+
 $(TEST_GEN_PROGS): ../harness.c ../utils.c signal.S
diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 9c39f55a58ff..87c8c8f238da 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# The loops are all 64-bit code
-CFLAGS += -I$(CURDIR)
-
 EXTRA_SOURCES := ../harness.c
 
 build_32bit = $(shell if ($(CC) $(CFLAGS) -m32 -o /dev/null memcmp.c >/dev/null 2>&1) then echo "1"; fi)
@@ -27,9 +24,12 @@ $(OUTPUT)/strlen_32: CFLAGS += -m32
 TEST_GEN_PROGS += strlen_32
 endif
 
-ASFLAGS = $(CFLAGS)
-
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+# The loops are all 64-bit code
+CFLAGS += -I$(CURDIR)
+
+ASFLAGS = $(CFLAGS)
+
 $(TEST_GEN_PROGS): $(EXTRA_SOURCES)
diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
index bdc081afedb0..8f0c2a1d3333 100644
--- a/tools/testing/selftests/powerpc/switch_endian/Makefile
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := switch_endian_test
 
-ASFLAGS += -O2 -Wall -g -nostdlib -m64
-
 EXTRA_CLEAN = $(OUTPUT)/*.o $(OUTPUT)/check-reversed.S
 
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+ASFLAGS += -O2 -Wall -g -nostdlib -m64
+
 $(OUTPUT)/switch_endian_test: ASFLAGS += -I $(OUTPUT)
 $(OUTPUT)/switch_endian_test: $(OUTPUT)/check-reversed.S
 
diff --git a/tools/testing/selftests/powerpc/syscalls/Makefile b/tools/testing/selftests/powerpc/syscalls/Makefile
index ee1740ddfb0c..83dc33500773 100644
--- a/tools/testing/selftests/powerpc/syscalls/Makefile
+++ b/tools/testing/selftests/powerpc/syscalls/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 TEST_GEN_PROGS := ipc_unmuxed rtas_filter
 
-CFLAGS += $(KHDR_INCLUDES)
-
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+CFLAGS += $(KHDR_INCLUDES)
+
 $(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/vphn/Makefile b/tools/testing/selftests/powerpc/vphn/Makefile
index cf65cbf33085..ddc09a20b80f 100644
--- a/tools/testing/selftests/powerpc/vphn/Makefile
+++ b/tools/testing/selftests/powerpc/vphn/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 TEST_GEN_PROGS := test-vphn
 
-CFLAGS += -m64 -I$(CURDIR)
-
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+CFLAGS += -m64 -I$(CURDIR)
+
 $(TEST_GEN_PROGS): ../harness.c
 
-- 
2.43.2


