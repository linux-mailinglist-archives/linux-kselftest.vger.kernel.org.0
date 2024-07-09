Return-Path: <linux-kselftest+bounces-13375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D192BA1C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF91F22EB6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8215FA60;
	Tue,  9 Jul 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QxMi9tgu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124315D5A6;
	Tue,  9 Jul 2024 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529850; cv=none; b=G9wzjC7MQR62L4fD5gZx08J66HBy9nq3a4opeH5YRxVP7a4TPVTatrFvNykBZjiGt6VvsUsVtUqw4lixBGOA1p7iX36KupXDyYKPHadUpE8lVS9OMkxjY7McP7NLXGhHsMzGbzjsxgaKeFgfeqsAISqvgcdUJ4IK45RpgeFDj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529850; c=relaxed/simple;
	bh=0os+/mpiaq5n+0G9zPs/uqesRzNyHVwLplGdC1lFwRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfbFvmXaezeh2Mk8abHlMCMWb9VmfrMqF+eJEcN4bQc0mVCXe5TCntuY/fYh9oXkXeP4RHzTMR1AlPddY+jqqAMUfNTCEElcGa7ATmnPZ2exWn/rYtIIbo+r2ustBKMhb0MkOvvf4SE80HQhlXVi7dGXsMVKS2fLkIdfp+5Ykmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QxMi9tgu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469Cui7r016116;
	Tue, 9 Jul 2024 12:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=LnG0m9LAlZ3zK
	0OF3cQfWII2SGkGv2p9CQvCT9W+q9o=; b=QxMi9tguuyFZLHmdduWJsE5owNjqe
	UKkKiqW87E8xhE9sD6Qpd3Q9pBrHAnzO0FnCMIM3KSwmPPlCJyKCLRKrUyt+Bh9P
	bMyCIZt//O9xqXTLkL5OyxKqiXopO2ieXd4Zep3vhRwYRYjJQmXgbZCBHc+y/1Yy
	scamRn/SibgFy+8Pi4hvd88LxoVty/3LtI5JxVp88uNcBLPjpzeq/CriqAbWSLUl
	mkP6mnRzLxYij4W5+TCE6sR77Oz4Q+e67BBzauTbk+nVMh0rFoBqHHTyR3IukatG
	GIgjNsBYd+9AIcAVm95KgWsIkT6GQkVYsXCzhsX2yvoD+Md5pIB6pi/6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408v1yhbug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:25 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CvPX4017123;
	Tue, 9 Jul 2024 12:57:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 408v1yhbue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4699aEPM006896;
	Tue, 9 Jul 2024 12:57:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmc7v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvJ1d57278856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 019F720063;
	Tue,  9 Jul 2024 12:57:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67BCD20040;
	Tue,  9 Jul 2024 12:57:18 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 5/9] selftests: kvm: s390: Add debug print functions
Date: Tue,  9 Jul 2024 14:57:00 +0200
Message-ID: <20240709125704.61312-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709125704.61312-1-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K_pYlhNSxzkuLPW9aiVM7TAsfBe_WTga
X-Proofpoint-ORIG-GUID: ku-dJBX7bUHC6sHzqC0angz2v63zTy-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=948 clxscore=1015
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090082

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
 .../selftests/kvm/include/s390x/debug_print.h | 78 +++++++++++++++++++
 .../selftests/kvm/s390x/ucontrol_test.c       |  1 +
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/debug_print.h

diff --git a/tools/testing/selftests/kvm/include/s390x/debug_print.h b/tools/testing/selftests/kvm/include/s390x/debug_print.h
new file mode 100644
index 000000000000..7cc21596398e
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/s390x/debug_print.h
@@ -0,0 +1,78 @@
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
+#include "kvm_util.h"
+#include "sie.h"
+
+static inline void print_hex_bytes(const char *name, u64 page, size_t len)
+{
+	pr_debug("%s (%p)\t\t8-0x08  12-0x0c  16-0x10  20-0x14  24-0x18  28-0x1c",
+		 name, (void *)page);
+	for (u8 pp_row = 0; pp_row < (len / 32); pp_row++) {
+		pr_debug("\n %3d 0x%.3x ", pp_row * 32, pp_row * 32);
+		for (u8 pp_block = 0; pp_block < 8; pp_block++)
+			pr_debug(" %8x", *(((u32 *)page) + 8 * pp_row + pp_block));
+	}
+	pr_debug("\n");
+}
+
+static inline void print_hex(const char *name, u64 page)
+{
+	print_hex_bytes(name, page, 512);
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
+	print_hex("run", (u64)run);
+	print_hex("sie_block", (u64)sie_block);
+	print_psw(run, sie_block);
+}
+
+static inline void print_regs(int vcpu_fd)
+{
+	struct kvm_sregs sregs = {};
+	struct kvm_regs regs = {};
+	int i;
+
+	if (ioctl(vcpu_fd, KVM_GET_REGS, &regs) != 0)
+		TEST_FAIL("get regs failed, %s", strerror(errno));
+	pr_debug("gprs:\n");
+	for (i = 0; i < 16; i += 4)
+		pr_debug("0x%.16llx 0x%.16llx 0x%.16llx 0x%.16llx\n",
+			 regs.gprs[i], regs.gprs[i + 1],
+			 regs.gprs[i + 2], regs.gprs[i + 3]);
+	if (ioctl(vcpu_fd, KVM_GET_SREGS, &sregs) != 0)
+		TEST_FAIL("get sregs failed, %s", strerror(errno));
+	pr_debug("acrs:\n");
+	for (i = 0; i < 16; i += 4)
+		pr_debug("0x%.8x 0x%.8x 0x%.8x 0x%.8x\n",
+			 sregs.acrs[i], sregs.acrs[i + 1],
+			 sregs.acrs[i + 2], sregs.acrs[i + 3]);
+	pr_debug("crs:\n");
+	for (i = 0; i < 16; i += 4)
+		pr_debug("0x%.16llx 0x%.16llx 0x%.16llx 0x%.16llx\n",
+			 sregs.crs[i], sregs.crs[i + 1],
+			 sregs.crs[i + 2], sregs.crs[i + 3]);
+}
+
+#endif /* SELFTEST_KVM_DEBUG_PRINT_H */
diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 44945af6d47d..5c009ee27fd2 100644
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


