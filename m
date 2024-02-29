Return-Path: <linux-kselftest+bounces-5621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0A86C57D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C891C211AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CF5605D6;
	Thu, 29 Feb 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XEX7amAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726E605CA
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199477; cv=none; b=h8UCnF9TqcFVOSatsdUrtFGbqdUHTDE/CIvVWLU4Iwj/c50GqYF+dFel8cDKMKAJ1K5XL23HWNL6uuQDtJ/vdTmPG0yQlysYrKTWpss9p5qzkaVQn+1BWKyZkzcgqi+dBgJErfA+17nJ4ec+sWHag0iT5OV3WYP5DtC9+gMlxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199477; c=relaxed/simple;
	bh=xCU7CH8ePreiaK4Wh9l94FXPH7zjiZvi6mdH0Fe/Hl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5wxILR0+hN4di9up8bpdw6b8WLBVoKsOkWvNzYb03ZblAe1t+lJtLWj1UQD59rSHweVY+T8POe5U9t9//761d2PVf73nS1BFeXbekNJUx61xMSNMRkVxeFl5R1B4A3bEGO5Rep2VMU7TMNGhQpuK1ff8yr5wM+J6TVYy+u0Bkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XEX7amAJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9BPwV011400;
	Thu, 29 Feb 2024 09:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=bQYEGg4BSG0fVHOhIF1UXJr4cERBP6o9JirBT7VNhwA=;
 b=XEX7amAJ0+PemvabDOC/g3Dod9tUCYyvIprwMdQp+baNpdiDWeljKFSSNSWa1yrNY3BO
 Ry1ORpV68h1H3ZigC+sWmfSmbtIaBl6mLIuqkB//13rZizaMAREg8pV1m5uRtiHlxj9N
 w8ylzlZNy7RGBhfg+xISoLzVxe+i4HrHkNNHQ2F8WV4YjR20huCqLKZG29ka+Dn2tPWY
 2Q2NoAx4TfAZ+u6UA84oymm735r4iQj4yBIuTZgbM4uSyMBE7br18wDXV2kjAnpaRmwV
 NhDCx0QyTiPd2yaa5Tno09kOiDMMZldOprWkbgiyrzHDKcrfuxp7Nkeh0vlx5y5QYWRr rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpxg0wx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:44 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T9V3J5016832;
	Thu, 29 Feb 2024 09:37:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjpxg0wwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T8KGmh008154;
	Thu, 29 Feb 2024 09:37:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mm7mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:37:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T9bbri20513406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:37:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6CF20049;
	Thu, 29 Feb 2024 09:37:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B58420040;
	Thu, 29 Feb 2024 09:37:33 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.171.62.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 09:37:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH 2/3] selftest/powerpc: Add flags.mk to support pmu buildable   
Date: Thu, 29 Feb 2024 15:07:10 +0530
Message-ID: <20240229093711.581230-2-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229093711.581230-1-maddy@linux.ibm.com>
References: <20240229093711.581230-1-maddy@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O-m48-A08bYtultpa9sObrbqQ88L5ES9
X-Proofpoint-ORIG-GUID: 682EoOb3zdUY5nZtDHuQrmcFBhnkv_Sm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290072

When running `make -C powerpc/pmu run_tests` from top level selftests
directory, currently this error is being reported

make: Entering directory '/home/maddy/linux/tools/testing/selftests/powerpc/pmu'
Makefile:40: warning: overriding recipe for target 'emit_tests'
../../lib.mk:111: warning: ignoring old recipe for target 'emit_tests'
gcc -m64    count_instructions.c ../harness.c event.c lib.c ../utils.c loop.S  -o /home/maddy/selftest_output//count_instructions
In file included from count_instructions.c:13:
event.h:12:10: fatal error: utils.h: No such file or directory
12 | #include "utils.h"
  |          ^~~~~~~~~
compilation terminated.

This is due to missing of include path in CFLAGS. That is, CFLAGS and
GIT_VERSION macros are defined in the powerpc/ folder Makefile which
in this case not involved.

To address the failure incase of executing specific sub-folder test directly,
a new rule file has been addded by the patch called "flags.mk" under
selftest/powerpc/ folder and is linked to all the Makefile of powerpc/pmu
sub-folders.

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog RFC:
- Rename the rule file as flags.mk
- Added additional patches to support other sub-folders
  under powerpc/ to be buildable on it own.
link to RFC:
  https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240225163926.264286-1-maddy@linux.ibm.com/
  
 tools/testing/selftests/powerpc/flags.mk             | 12 ++++++++++++
 tools/testing/selftests/powerpc/pmu/Makefile         |  1 +
 tools/testing/selftests/powerpc/pmu/ebb/Makefile     |  1 +
 .../selftests/powerpc/pmu/event_code_tests/Makefile  |  1 +
 .../selftests/powerpc/pmu/sampling_tests/Makefile    |  1 +
 5 files changed, 16 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/flags.mk

diff --git a/tools/testing/selftests/powerpc/flags.mk b/tools/testing/selftests/powerpc/flags.mk
new file mode 100644
index 000000000000..28374f470126
--- /dev/null
+++ b/tools/testing/selftests/powerpc/flags.mk
@@ -0,0 +1,12 @@
+#This checks for any ENV variables and add those.
+
+#ifeq ($(GIT_VERSION),)
+GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
+export GIT_VERSION
+#endif
+
+#ifeq ($(CFLAGS),)
+CFLAGS := -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(selfdir)/powerpc/include $(CFLAGS)
+export CFLAGS
+#endif
+
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index a284fa874a9f..1fcacae1b188 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -7,6 +7,7 @@ EXTRA_SOURCES := ../harness.c event.c lib.c ../utils.c
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include ../flags.mk
 
 all: $(TEST_GEN_PROGS) ebb sampling_tests event_code_tests
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index b3946ce17e0c..1b39af7c10db 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_PROGS := reg_access_test event_attributes_test cycles_test	\
 
 top_srcdir = ../../../../../..
 include ../../../lib.mk
+include ../../flags.mk
 
 # The EBB handler is 64-bit code and everything links against it
 CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile b/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile
index 509d4b235b9e..fdb080b3fa65 100644
--- a/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/event_code_tests/Makefile
@@ -9,6 +9,7 @@ TEST_GEN_PROGS := group_constraint_pmc56_test group_pmc56_exclude_constraints_te
 
 top_srcdir = ../../../../../..
 include ../../../lib.mk
+include ../../flags.mk
 
 CFLAGS += -m64
 
diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile b/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile
index d45892151e05..9f79bec5fce7 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/Makefile
@@ -9,6 +9,7 @@ TEST_GEN_PROGS := mmcr0_exceptionbits_test mmcr0_cc56run_test mmcr0_pmccext_test
 
 top_srcdir = ../../../../../..
 include ../../../lib.mk
+include ../../flags.mk
 
 CFLAGS += -m64
 
-- 
2.43.2


