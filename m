Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5622AC71
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgGWKWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:22:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbgGWKWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:22:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA48b2165709;
        Thu, 23 Jul 2020 06:22:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1yc1s7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:23 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NA5FOS178748;
        Thu, 23 Jul 2020 06:22:23 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1yc1s6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:23 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NALr47008770;
        Thu, 23 Jul 2020 10:22:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh5xsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAMGOH8257902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:22:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6506EA405F;
        Thu, 23 Jul 2020 10:22:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65E1DA4062;
        Thu, 23 Jul 2020 10:22:13 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:22:13 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 4/7] powerpc/selftests/ptrace-hwbreak: Add testcases for 2nd DAWR
Date:   Thu, 23 Jul 2020 15:50:55 +0530
Message-Id: <20200723102058.312282-5-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230076
Sender: linux-kselftest-owner@vger.kernel.org
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
index fc477dfe86a2..65781f4035c1 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -185,6 +185,18 @@ static void test_workload(void)
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
@@ -374,6 +386,69 @@ static void test_sethwdebug_range_aligned(pid_t child_pid)
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
@@ -460,6 +535,10 @@ run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
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
2.26.2

