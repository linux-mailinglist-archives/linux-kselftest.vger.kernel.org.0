Return-Path: <linux-kselftest+bounces-14718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BDA946130
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39A5B2442E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709E1A34B2;
	Fri,  2 Aug 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJyWyVbo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21AC1A34A4;
	Fri,  2 Aug 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614395; cv=none; b=FYKCIHCRBjMG3+j7XjYGlofVBObAyBZTwukPo5dhjvju5Lkq3mxaYVqs3xyYQ5qeA5+auqXUHLB4RIGMcD/A07H8Hk+k+0dJxJy/IVt+tLu7ZYpYxuRtvBg/xkdts7Qh2ZrXi6m0wL/+9BHHCY0DyCntxk5qgY+ktYOhaekQ9aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614395; c=relaxed/simple;
	bh=TGgCTarWHim7y41+guYxROzBf55dQ+lrGKq+o7E6EAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS36OJ+QWoXQ51d0OLWztF4f4Q8CaVmXNnBX5CHDxt3+poVCgCDx1jaEZw8c2YJZ4afxHcCuZwzDD///49ZHdsYARkFfuTzsfpYjWrQQmZcoxOToBdxsp0BW03OD7z2nmy+W1od31cFKE1hN1jeni8wZ/e1Qbp6UZsKJT735Jr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJyWyVbo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472FeiWj015665;
	Fri, 2 Aug 2024 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=mFGvRsMn/8Ctp
	xoPcRUG03GB/isePjiHtCSWvAA8KJI=; b=KJyWyVbolYIQAqG8lLdPJxEJ5OBWx
	c2jh0MALhCZg7Jgg6Wr3OpWHBJ4PJagnXZ9bDs4b2EtQyPy8eZnvljs/emRvDrnZ
	gm6DUCDSqRkpxw/b0hqlS6WsvYencqRy++MBuZW+xJcnyt6McR3TxTol0E+R8TF/
	iSbmaj5CaMVXQCA+Iemsl6NHVj+ms35lS7LL9d51Vgavczo/MKFHhfRi07yWMdvv
	toI3zrhDUIgIw7xQapAtuvY1PHH6vPguKDJnDRijL69QSvEKDHPwBYtMqfNBUHTe
	tql65XxWAA8EbEHGBl5RQJqn3edrQ4tGvUVH2vKUrGw9HSfaNf90f5nYQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s0cpgb1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:49 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472FvaJm012355;
	Fri, 2 Aug 2024 15:59:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s0cpgb1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472FqwM5003748;
	Fri, 2 Aug 2024 15:59:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemypns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472FxgMZ36569598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 15:59:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 603132004B;
	Fri,  2 Aug 2024 15:59:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C348C20040;
	Fri,  2 Aug 2024 15:59:41 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.84.102])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 15:59:41 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 05/10] selftests: kvm: s390: Add debug print functions
Date: Fri,  2 Aug 2024 17:59:08 +0200
Message-ID: <20240802155913.261891-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802155913.261891-1-schlameuss@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wkqr9UQKidmjBwK1naO8Ma3UUZy5OYyH
X-Proofpoint-ORIG-GUID: FusJD-3iOWoe1JXhvs8KM0QcgIlADaGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020110

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
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../selftests/kvm/include/s390x/debug_print.h | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
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
-- 
2.45.2


