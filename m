Return-Path: <linux-kselftest+bounces-14067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE44939DE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8FA1F23115
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FFF22EE8;
	Tue, 23 Jul 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qlh9m2u0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372E208B6;
	Tue, 23 Jul 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727131; cv=none; b=RgwG7ws8VhMNNlUawjz0RZQQ53TWNtYj0zFsFcQ058nq3Z3z+g+rGwJG+4p/D2lMzQuPf5bq+jQPvdJXsT/IE7uPi/aVKAA9EPIcVUY3XlzjOv1zfHhQ6ulsfKq1lyprAthWMi2zvZRXdB7WdQd6VU8y1E3slO/btecFa5+g0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727131; c=relaxed/simple;
	bh=0ml/6nnZnYKyWWSZ1PYJnUF/PyqU0QoU0j69Z2E55Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0q/Q8H2G5SlhwDK5anS5HbcVAn+4cUu3oUNnQJqu2ITQ9JwAWQbUWH85KY2moa6eVVYqecXjgsjLec/7XXpu9rShjzmuGnm7ngmX9SMdLOu1M13UP6Z25ooocuvM64vImwH0mPKdiN/SvlTKmR3QqsmqepkKtBtJ4ZPn/cNLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qlh9m2u0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9QXpA018505;
	Tue, 23 Jul 2024 09:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=aRPbAeOe7H2NW
	8vfuQmUs6PIQDMhMq29nzpOSndavmw=; b=qlh9m2u0mYqqFjmxPaYMEzlHkSmlT
	Hkp9xrE5fyMrZcXzsWASa7L7U5zhdDiDoMTgocwiy5ZanFHehUqT87Y0n0/jtMPx
	369sRhhK3jlYtZNVTWnRFw0c/o/LKZLm7Ks/SibBcS1/QTIgNMoDoEoYLVmTUajw
	IwFBDV8DdKndHGhE0qX1IJ6ALMo0WMmD5hUb02AyxlWPXesIrmNFWlUmSr37jj5T
	NEqAn7G29juWe4BevtqliJT/2eC16V8SH2OOoMpLQyvgDcoxCWt3XBaWHeNJMJ2W
	oqRoisD1pKrN/a0ovptsX8TIrHiwOPhf6Oe6HJcZCqT4QxxHhnk4ryDIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rvrrm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:06 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9W6ml027826;
	Tue, 23 Jul 2024 09:32:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rvrrm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N6dLg4006227;
	Tue, 23 Jul 2024 09:32:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gqjub7c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9W0PG37748996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:32:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B4682004B;
	Tue, 23 Jul 2024 09:32:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7736820040;
	Tue, 23 Jul 2024 09:31:59 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.28.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:31:59 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 05/10] selftests: kvm: s390: Add debug print functions
Date: Tue, 23 Jul 2024 11:31:21 +0200
Message-ID: <20240723093126.285319-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723093126.285319-1-schlameuss@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vlfqa0sZk5ppTMm0lGxC9LUPzaoFhR8g
X-Proofpoint-GUID: 4OUhinfwRcgM2C2bM1Ejh_nzLGdoMQvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230069

Add functions to simply print some basic state information in selftests.

The output can be enabled by setting:

    #define TH_LOG_ENABLED 1
    #define DEBUG 1

* print_psw: current SIE state description and VM run state
* print_hex_bytes: print memory with some counting markers
* print_hex: PRINT_HEX with 512 bytes
* print_run: use print_psw and print_hex to print contents of VM run
  state and SIE state description
* print_regs: print content of general and control registers

All prints use pr_debug for the output and can be configured using
DEBUG.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/include/s390x/debug_print.h | 69 +++++++++++++++++++
 .../selftests/kvm/s390x/ucontrol_test.c       |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/debug_print.h

diff --git a/tools/testing/selftests/kvm/include/s390x/debug_print.h b/tools/testing/selftests/kvm/include/s390x/debug_print.h
new file mode 100644
index 000000000000..1bf275631cc6
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/s390x/debug_print.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Definition for kernel virtual machines on s390x
+ *
+ * Copyright IBM Corp. 2024
+ *
+ * Authors:
+ *  Christoph Schlameuss <schlameuss@linux.ibm.com>
+ */
+
+#ifndef SELFTEST_KVM_DEBUG_PRINT_H
+#define SELFTEST_KVM_DEBUG_PRINT_H
+
+#include "asm/ptrace.h"
+#include "kvm_util.h"
+#include "sie.h"
+
+static inline void print_hex_bytes(const char *name, u64 addr, size_t len)
+{
+	u64 pos;
+
+	pr_debug("%s (%p)\n", name, (void *)addr);
+	pr_debug("            0/0x00---------|");
+	if (len > 8)
+		pr_debug(" 8/0x08---------|");
+	if (len > 16)
+		pr_debug(" 16/0x10--------|");
+	if (len > 24)
+		pr_debug(" 24/0x18--------|");
+	for (pos = 0; pos < len; pos += 8) {
+		if ((pos % 32) == 0)
+			pr_debug("\n %3lu 0x%.3lx ", pos, pos);
+		pr_debug(" %16lx", *((u64 *)(addr + pos)));
+	}
+	pr_debug("\n");
+}
+
+static inline void print_hex(const char *name, u64 addr)
+{
+	print_hex_bytes(name, addr, 512);
+}
+
+static inline void print_psw(struct kvm_run *run, struct kvm_s390_sie_block *sie_block)
+{
+	pr_debug("flags:0x%x psw:0x%.16llx:0x%.16llx exit:%u %s\n",
+		 run->flags,
+		 run->psw_mask, run->psw_addr,
+		 run->exit_reason, exit_reason_str(run->exit_reason));
+	pr_debug("sie_block psw:0x%.16llx:0x%.16llx\n",
+		 sie_block->psw_mask, sie_block->psw_addr);
+}
+
+static inline void print_run(struct kvm_run *run, struct kvm_s390_sie_block *sie_block)
+{
+	print_hex_bytes("run", (u64)run, 0x150);
+	print_hex("sie_block", (u64)sie_block);
+	print_psw(run, sie_block);
+}
+
+static inline void print_regs(struct kvm_run *run)
+{
+	struct kvm_sync_regs *sync_regs = &run->s.regs;
+
+	print_hex_bytes("GPRS", (u64)sync_regs->gprs, 8 * NUM_GPRS);
+	print_hex_bytes("ACRS", (u64)sync_regs->acrs, 4 * NUM_ACRS);
+	print_hex_bytes("CRS", (u64)sync_regs->crs, 8 * NUM_CRS);
+}
+
+#endif /* SELFTEST_KVM_DEBUG_PRINT_H */
diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index d8a81b407467..527c431a9758 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -7,6 +7,7 @@
  * Authors:
  *  Christoph Schlameuss <schlameuss@linux.ibm.com>
  */
+#include "debug_print.h"
 #include "kselftest_harness.h"
 #include "kvm_util.h"
 #include "processor.h"
-- 
2.45.2


