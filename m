Return-Path: <linux-kselftest+bounces-14444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525379409C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 09:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAA81F24B8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C3818FDC0;
	Tue, 30 Jul 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b39cs0oH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FF18FDA3;
	Tue, 30 Jul 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324277; cv=none; b=GKLfnUuvKtoXY/YgmjnW05ySk8X8YdfssBw/Mq0ZbptoS2yDKXjADoHFQAOMMrh72FpwlAkn252U6CI/+y4Dy2TMHvpKwi1020AkehpYuEAmbzLcHA2iQU7Y/ZQ2sTnUKNe8I5VkN4ytXChUzZSmgiuGLUnF5C5QrkXpUw7/ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324277; c=relaxed/simple;
	bh=b3pS9UEtGIqjwfQZL8M+R8tSAm1aoaRBY9iqbJsAK6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtGsqokorJCYnKILlx5szZGdpZapEW5ubROuIu2Vx138akWj3jGefWaPhznh9CQa4E1RhVchauGk0w2W4FRbhmcZJXiAqggDAg1bLWIZwKgUvSBuMZNyT3/GZuDjhmikQS6btndIIP2lXRpx0yE0AE3qvAagRbRIJNCEJWYQILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b39cs0oH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U6xHaB012669;
	Tue, 30 Jul 2024 07:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=qY03rms/4qTZ6
	DMxB28Bf2yiLcm04XDarA7BW1VxDAE=; b=b39cs0oH5SbOB43N2mG1ERAXKeDws
	r/jmO7yDevKO11J3U/mkvnZKd6MB0JTXJCyDs1JB5n/wJKtjUcfbKsie4qz7T4hH
	MolQuud5RcF0TvPiphTEHd/r1XFokBPl6qGyy0MoKPUS3yE2mQkV8fcXF6zsJiyy
	+Ue9zn6u2XGmcD2mOw2xIVlYWFablJHoWUDftCax3eOevM/30Swj6g0+Lg0NGr9/
	/vJNhAET5lErXzyRVGDX9ho/c8IYLZYZaIqaZexp+n8ZeH3+Zzc0Gkj9O6iccqsb
	r+kG3FrZr+sTNf96IKf63SgfLkZxoQRq0tBKkJDWoHpQ26N/W5SA3DrAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pucug29b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U7OUwg026176;
	Tue, 30 Jul 2024 07:24:30 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pucug296-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U6iVmI007467;
	Tue, 30 Jul 2024 07:24:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u3nq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U7OOg650332144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 07:24:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1261C2004D;
	Tue, 30 Jul 2024 07:24:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CED620040;
	Tue, 30 Jul 2024 07:24:23 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.13.169])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 07:24:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v3 05/10] selftests: kvm: s390: Add debug print functions
Date: Tue, 30 Jul 2024 09:24:08 +0200
Message-ID: <20240730072413.143556-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730072413.143556-1-schlameuss@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ARcxVyj1fn9eqKd6K2zP2TfC3MwuF9zF
X-Proofpoint-ORIG-GUID: aKSh5DTZY_w6WPSmLJ7K52EUWj1AyXIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300054

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
index d103a92e7495..029233374465 100644
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


