Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F386356376
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhDGFuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 01:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243610AbhDGFuH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 01:50:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1375XMPT149046;
        Wed, 7 Apr 2021 01:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ayh2LqRk/4w+LeZhGHA8zGnXcCMLoo/GkATHEyBk5yE=;
 b=j33zEq4rDAoCNTfJvWJZU85Q7NzYncHtc/C3eQbIdhb9czVSIZsdhYSjUe/eetVr/c9Y
 ai1FCSerhflQo3DtaCHKkfIsFISq7t4y4Xsy62kWNvo4yeBYh58GWY4rQgQn1LUrVrKm
 x9zrDMULdn/VDcOt1ocRBYMqVYv8Lf8FDXKh1i5OtnaNZXb8/m2PI+nWQ86QCWr9XDAN
 gtjNgNG6n0PMvl4BSFwzlRnNlxqpnuOVZDkbMdy5lm8cDeKafvaTjrDIovjQqISoo4s4
 fslazcM/EJhMGFnlj1/GOL4fjJgShbIfDyKqFXA6qRLZnaVFrGPZkv6CV5v9xKhJ7pq+ Yg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw6jwmuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 01:49:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1375lDoH025812;
        Wed, 7 Apr 2021 05:49:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbw8cba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 05:49:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1375nkvL38666676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 05:49:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354B3A404D;
        Wed,  7 Apr 2021 05:49:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE4CFA4040;
        Wed,  7 Apr 2021 05:49:43 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.44.100])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 05:49:43 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, shuah@kernel.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/4] powerpc/selftests/ptrace-hwbreak: Add testcases for 2nd DAWR
Date:   Wed,  7 Apr 2021 11:19:35 +0530
Message-Id: <20210407054938.312857-2-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com>
References: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SKfVz43So34kkN1CMpb7iQioRi88gXdz
X-Proofpoint-ORIG-GUID: SKfVz43So34kkN1CMpb7iQioRi88gXdz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070039
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftests to test multiple active DAWRs with ptrace interface.

Sample o/p:
  $ ./ptrace-hwbreak
  ...
  PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
  PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED, RO, len: 6: Ok
  PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, WO, len: 6: Ok
  PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, RO, len: 6: Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
index 2e0d86e0687e..a0635a3819aa 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -194,6 +194,18 @@ static void test_workload(void)
 		big_var[rand() % DAWR_MAX_LEN] = 'a';
 	else
 		cvar = big_var[rand() % DAWR_MAX_LEN];
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED, WO test */
+	gstruct.a[rand() % A_LEN] = 'a';
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED, RO test */
+	cvar = gstruct.b[rand() % B_LEN];
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, WO test */
+	gstruct.a[rand() % A_LEN] = 'a';
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, RO test */
+	cvar = gstruct.a[rand() % A_LEN];
 }
 
 static void check_success(pid_t child_pid, const char *name, const char *type,
@@ -417,6 +429,69 @@ static void test_sethwdebug_range_aligned(pid_t child_pid)
 	ptrace_delhwdebug(child_pid, wh);
 }
 
+static void test_multi_sethwdebug_range(pid_t child_pid)
+{
+	struct ppc_hw_breakpoint info1, info2;
+	unsigned long wp_addr1, wp_addr2;
+	char *name1 = "PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED";
+	char *name2 = "PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED";
+	int len1, len2;
+	int wh1, wh2;
+
+	wp_addr1 = (unsigned long)&gstruct.a;
+	wp_addr2 = (unsigned long)&gstruct.b;
+	len1 = A_LEN;
+	len2 = B_LEN;
+	get_ppc_hw_breakpoint(&info1, PPC_BREAKPOINT_TRIGGER_WRITE, wp_addr1, len1);
+	get_ppc_hw_breakpoint(&info2, PPC_BREAKPOINT_TRIGGER_READ, wp_addr2, len2);
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED, WO test */
+	wh1 = ptrace_sethwdebug(child_pid, &info1);
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED, RO test */
+	wh2 = ptrace_sethwdebug(child_pid, &info2);
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name1, "WO", wp_addr1, len1);
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name2, "RO", wp_addr2, len2);
+
+	ptrace_delhwdebug(child_pid, wh1);
+	ptrace_delhwdebug(child_pid, wh2);
+}
+
+static void test_multi_sethwdebug_range_dawr_overlap(pid_t child_pid)
+{
+	struct ppc_hw_breakpoint info1, info2;
+	unsigned long wp_addr1, wp_addr2;
+	char *name = "PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap";
+	int len1, len2;
+	int wh1, wh2;
+
+	wp_addr1 = (unsigned long)&gstruct.a;
+	wp_addr2 = (unsigned long)&gstruct.a;
+	len1 = A_LEN;
+	len2 = A_LEN;
+	get_ppc_hw_breakpoint(&info1, PPC_BREAKPOINT_TRIGGER_WRITE, wp_addr1, len1);
+	get_ppc_hw_breakpoint(&info2, PPC_BREAKPOINT_TRIGGER_READ, wp_addr2, len2);
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, WO test */
+	wh1 = ptrace_sethwdebug(child_pid, &info1);
+
+	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, RO test */
+	wh2 = ptrace_sethwdebug(child_pid, &info2);
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name, "WO", wp_addr1, len1);
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name, "RO", wp_addr2, len2);
+
+	ptrace_delhwdebug(child_pid, wh1);
+	ptrace_delhwdebug(child_pid, wh2);
+}
+
 static void test_sethwdebug_range_unaligned(pid_t child_pid)
 {
 	struct ppc_hw_breakpoint info;
@@ -504,6 +579,10 @@ run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
 			test_sethwdebug_range_unaligned(child_pid);
 			test_sethwdebug_range_unaligned_dar(child_pid);
 			test_sethwdebug_dawr_max_range(child_pid);
+			if (dbginfo->num_data_bps > 1) {
+				test_multi_sethwdebug_range(child_pid);
+				test_multi_sethwdebug_range_dawr_overlap(child_pid);
+			}
 		}
 	}
 }
-- 
2.27.0

