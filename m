Return-Path: <linux-kselftest+bounces-15763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1A957EBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668EAB21665
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52E12D766;
	Tue, 20 Aug 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bhu96PGq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379C18E36D;
	Tue, 20 Aug 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137026; cv=none; b=fMCV9iQGNPvQTdaT40nDd9IuISnwjgRLQH915bspyJWYuNqi+ju6rbDWQPpKH4q0j6FpXvwS+Z2c3yd+mNnchU8PfZjUdWR5fhjXoNd0DRVhGG8soCMCXNafEdqeh9tUSFSSG9bD5E4tadyAzx2df4fkukkOL0IGqQ5nMbBq/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137026; c=relaxed/simple;
	bh=c4hmkB38te+0SFTHoxizluc0J+5R9wmr0WjPHJ5jaM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibOQMloO5S/+WoQ+y0/+aj8aOD7Pp9UNSN8VfuqwPeipN1y3U/Y7SNguUIS5KdlqabRDNBTaP99Gd94nCev9dlLwblbimLWxvr6zyB8Sqp8teJ+HMsjY3jq8SoTojDoSVHi7WYMbzx0Vnu+dBd2HymGtUi5dVJQAgK/xsIbV+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bhu96PGq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K4Hhqp006794;
	Tue, 20 Aug 2024 06:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eIwWKCdBLe8RH
	X1llQmVTQFJ8HyVrO0cTrEx8OJEz4Q=; b=Bhu96PGqccxZdywbUXtTtgDp6YoqG
	7EXO7Sg+VYrGm/Rs5nCj4Ch1+Y4xba9gy5Uzb0gbls3zfziIlXCAm4IQSjsSYUO/
	KJu8eR9KKenlYzbOj128Kv7GKVv1BJEQQh7dpHy0H+aDffqrdis02NjokeY/NAMR
	9HGvEjJEzZsKpNP1NEqVzmpVr1qLPW6jgEFRCGEHsUXvrr3F7PZ2prY3zHCb1t/G
	V6XrDwbBSo2ZqEGqvJHC275to/JMy+A+qjS2ZImY2S8Elf0k8+HkaFaGcNI6oYmr
	TPXFrDo9FobGRsolkdvd2PSvMXc46oNLoC26hUgC6f8S/XliYB7gRfhRg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcybwb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6v0ZB015213;
	Tue, 20 Aug 2024 06:57:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcybwb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:57:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K40gJE017649;
	Tue, 20 Aug 2024 06:56:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w31bg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:56:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6usAK51839334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:56:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C16A2004B;
	Tue, 20 Aug 2024 06:56:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 271A720040;
	Tue, 20 Aug 2024 06:56:54 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 06:56:54 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v2 1/5] KVM: s390: selftests: Add regression tests for SORTL and DFLTCC CPU subfunctions
Date: Tue, 20 Aug 2024 08:48:33 +0200
Message-ID: <20240820065623.1140399-2-hari55@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820065623.1140399-1-hari55@linux.ibm.com>
References: <20240820065623.1140399-1-hari55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JBqLcJhtYYkEkRtFC9d357jgQE70oBZf
X-Proofpoint-GUID: QjBtyM1vA84yUuQNgRrTekMnCMorDmJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200048

Introduce new regression tests to verify the ASM inline block in the SORTL
and DFLTCC CPU subfunctions for the s390x architecture. These tests ensure
that future changes to the ASM code are properly validated.

The test procedure:

1. Create a VM and request the KVM_S390_VM_CPU_MACHINE_SUBFUNC attribute
   from the KVM_S390_VM_CPU_MODEL group for this VM. This SUBFUNC attribute
   contains the results of all CPU subfunction instructions.
2. For each tested subfunction (SORTL and DFLTCC), execute the
   corresponding ASM instruction and capture the result array.
3. Perform a memory comparison between the results stored in the SUBFUNC
   attribute (obtained in step 1) and the ASM instruction results (obtained
   in step 2) for each tested subfunction.

This process ensures that the KVM implementation accurately reflects the
behavior of the actual CPU instructions for the tested subfunctions.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Hariharan Mari <hari55@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/s390x/facility.h    |  50 ++++++++
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 115 ++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/facility.h
 create mode 100644 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ac280dcba996..9f418c594b55 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -183,6 +183,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += s390x/tprot
 TEST_GEN_PROGS_s390x += s390x/cmma_test
 TEST_GEN_PROGS_s390x += s390x/debug_test
+TEST_GEN_PROGS_s390x += s390x/cpumodel_subfuncs_test
 TEST_GEN_PROGS_s390x += s390x/shared_zeropage_test
 TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
diff --git a/tools/testing/selftests/kvm/include/s390x/facility.h b/tools/testing/selftests/kvm/include/s390x/facility.h
new file mode 100644
index 000000000000..65eef9a722ba
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/s390x/facility.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright IBM Corp. 2024
+ *
+ * Authors:
+ *  Hariharan Mari <hari55@linux.ibm.com>
+ *
+ *  Get the facility bits with the STFLE instruction
+ */
+
+#ifndef SELFTEST_KVM_FACILITY_H
+#define SELFTEST_KVM_FACILITY_H
+
+#include <linux/bitops.h>
+
+#define NB_STFL_DOUBLEWORDS 32 /* alt_stfle_fac_list[16] + stfle_fac_list[16] */
+
+uint64_t stfl_doublewords[NB_STFL_DOUBLEWORDS];
+bool stfle_flag;
+
+static inline bool test_bit_inv(unsigned long nr,
+				const unsigned long *ptr)
+{
+	return test_bit(nr ^ (BITS_PER_LONG - 1), ptr);
+}
+
+static inline void stfle(uint64_t *fac, unsigned int nb_doublewords)
+{
+	register unsigned long r0 asm("0") = nb_doublewords - 1;
+
+	asm volatile("	.insn	s,0xb2b00000,0(%1)\n"
+			: "+d" (r0)
+			: "a" (fac)
+			: "memory", "cc");
+}
+
+static inline void setup_facilities(void)
+{
+	stfle(stfl_doublewords, NB_STFL_DOUBLEWORDS);
+	stfle_flag = true;
+}
+
+static inline bool test_facility(int nr)
+{
+	if (!stfle_flag)
+		setup_facilities();
+	return test_bit_inv(nr, stfl_doublewords);
+}
+
+#endif
diff --git a/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
new file mode 100644
index 000000000000..ea03ce2010bb
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright IBM Corp. 2024
+ *
+ * Authors:
+ *  Hariharan Mari <hari55@linux.ibm.com>
+ *
+ * The tests compare the result of the KVM ioctl for obtaining CPU subfunction
+ * data with those from an ASM block performing the same CPU subfunction.
+ * Currently KVM doesn't mask instruction query data reported via the CPU Model,
+ * allowing us to directly compare it with the data acquired through executing
+ * the queries in the test.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include "facility.h"
+
+#include "kvm_util.h"
+
+/**
+ * Query available CPU subfunctions
+ */
+struct kvm_s390_vm_cpu_subfunc cpu_subfunc;
+
+static void get_cpu_machine_subfuntions(struct kvm_vm *vm,
+					struct kvm_s390_vm_cpu_subfunc
+					*cpu_subfunc)
+{
+	int r;
+
+	r = __kvm_device_attr_get(vm->fd, KVM_S390_VM_CPU_MODEL,
+				  KVM_S390_VM_CPU_MACHINE_SUBFUNC, cpu_subfunc);
+
+	TEST_ASSERT(!r, "Get cpu subfunctions failed r=%d errno=%d", r, errno);
+}
+
+/*
+ * Testing Sort Lists (SORTL) CPU subfunction's ASM block
+ */
+static void test_sortl_asm_block(u8 (*query)[32])
+{
+	asm volatile("	lghi	0,0\n"
+			"	la	1,%[query]\n"
+			"	.insn	rre,0xb9380000,2,4\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "0", "1");
+}
+
+/*
+ * Testing Deflate Conversion Call (DFLTCC) CPU subfunction's ASM block
+ */
+static void test_dfltcc_asm_block(u8 (*query)[32])
+{
+	asm volatile("	lghi	0,0\n"
+			"	la	1,%[query]\n"
+			"	.insn	rrf,0xb9390000,2,4,6,0\n"
+			: [query] "=R" (*query)
+			:
+			: "cc", "0", "1");
+}
+
+typedef void (*testfunc_t)(u8 (*array)[]);
+
+struct testdef {
+	const char *subfunc_name;
+	u8 *subfunc_array;
+	size_t array_size;
+	testfunc_t test;
+	int facility_bit;
+} testlist[] = {
+	/* SORTL - Facility bit 150 */
+	{ "SORTL", cpu_subfunc.sortl, sizeof(cpu_subfunc.sortl),
+		test_sortl_asm_block, 150 },
+	/* DFLTCC - Facility bit 151 */
+	{ "DFLTCC", cpu_subfunc.dfltcc, sizeof(cpu_subfunc.dfltcc),
+		test_dfltcc_asm_block, 151 },
+};
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	int idx;
+
+	ksft_print_header();
+
+	vm = vm_create(1);
+
+	memset(&cpu_subfunc, 0, sizeof(cpu_subfunc));
+	get_cpu_machine_subfuntions(vm, &cpu_subfunc);
+
+	ksft_set_plan(ARRAY_SIZE(testlist));
+	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
+		if (test_facility(testlist[idx].facility_bit)) {
+			u8 *array = malloc(testlist[idx].array_size);
+
+			testlist[idx].test((u8 (*)[testlist[idx].array_size])array);
+
+			TEST_ASSERT_EQ(memcmp(testlist[idx].subfunc_array,
+					      array, testlist[idx].array_size), 0);
+
+			ksft_test_result_pass("%s\n", testlist[idx].subfunc_name);
+			free(array);
+		} else {
+			ksft_test_result_skip("%s feature is not avaialable\n",
+					      testlist[idx].subfunc_name);
+		}
+	}
+
+	kvm_vm_free(vm);
+	ksft_finished();
+}
-- 
2.45.2


