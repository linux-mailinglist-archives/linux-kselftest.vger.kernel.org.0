Return-Path: <linux-kselftest+bounces-14927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEAC94AD68
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A07B31632
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE87139D0B;
	Wed,  7 Aug 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWTvUjTb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304813342F;
	Wed,  7 Aug 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045554; cv=none; b=IBgUJpV6cNE9xRff8uVAIFKNrrmROuxjQUHteYnHPGme+LHGjbb2dOZEUVM8spR6rS7BUzMZ9snU65TIZZAZtRWK3dif4MIF4oKHwzQBg8YKuGNKbAHtRAjeOcdmEkIyUCWEhvjuIU69A06OP462JrjrRhx9RD4IsvkKZc74xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045554; c=relaxed/simple;
	bh=TGgCTarWHim7y41+guYxROzBf55dQ+lrGKq+o7E6EAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2Kd2IvGKYvspdj2hwve+58xc24QOMjPAW2Y6goa9Mmvx9AmZ9KrbN4kYBChfLobPXRt6VaI/ouCvRUB9FuntEpT+XzryBg0k505rECroXEnc2swQ6EewBgyulhqU/LgRMJ987YJFLpCaKoQOSxzK8wVMiZITox3Zs/t+LvfD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWTvUjTb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772Mb3I030067;
	Wed, 7 Aug 2024 15:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=mFGvRsMn/8Ctp
	xoPcRUG03GB/isePjiHtCSWvAA8KJI=; b=AWTvUjTb4N0sol1nvqwIbBSROgmxL
	1CmYRQjVsZSOFRiU2bBsXa41Rd1RBZzIcyuf5SaEnAyQ+aJ0z4m4B6+9fUtNi4u/
	tkmnyLrE3leIgO9JFZRSUWwMnVz+UYIu7+iZRg8K6qYO+Gu4AzAhOK9cHwsN3Vt0
	hkSplq/xdlYCXMQPzPOSQr38YCj/kK0v04qa4wMAUsFsyztjMZpVBzMJQ1FMtmG4
	Dc5hLO9kauhckAvQ1UT6ha8IAJujYymscoOpkrclVxth4DW4gP6OpBEL6/eoRoPz
	rVpl0NaQx7BHUxS/p6Ikn6HQxwNl+rM95BvCioG+UZP2MzJayfzTE2BsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ucd248yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 477Fjhtx002767;
	Wed, 7 Aug 2024 15:45:43 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ucd248yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477CqJx2030242;
	Wed, 7 Aug 2024 15:45:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k39b3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477Fjbjb55706024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 15:45:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DE4F20063;
	Wed,  7 Aug 2024 15:45:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEC252005A;
	Wed,  7 Aug 2024 15:45:36 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.155.210.150])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 15:45:36 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 05/10] selftests: kvm: s390: Add debug print functions
Date: Wed,  7 Aug 2024 17:45:07 +0200
Message-ID: <20240807154512.316936-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807154512.316936-1-schlameuss@linux.ibm.com>
References: <20240807154512.316936-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 38tCE19vPPMX4LwSry3eASgHKgNlx3c5
X-Proofpoint-ORIG-GUID: TB0NktLlTHknyPOrd3OknhAbvGJYYyyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070105

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


