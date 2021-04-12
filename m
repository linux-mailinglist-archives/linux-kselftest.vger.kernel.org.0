Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CBC35C4F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 13:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhDLLW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 07:22:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240287AbhDLLW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CB2mxX093110;
        Mon, 12 Apr 2021 07:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Us77yEoFR83nh4vReMVfYBRxktEB7aUku3YkhV+i7jY=;
 b=ReP9OfQvEz+p8DVjvL+ELRnxFSby9cdwntIAlMirpxx8skXOz9ma+rg6UMq+pIKaj4nF
 /6XVvi3UybMG3bbxdbISEeFa23GNpYZ0d7NqKCtjqP7tHZPz8TJxKUiO/lWAEHyvPBiU
 y9aglIQ4yMDvmFUPuAtn5bd8sFVaUEE3BvKm7i7B+LTPw8/KzZNtbwzR+TUKuOh8sxBb
 5N0S3f4by1CgBDwxhE2rBylf/XyahLx8oRAK2wkSvNywDSoCwcCv/L/Tp2xtu0H3sOdZ
 GrNCuoXN4jiyElIz/IxfB2nWdU9O9OLCIeZjkJhjOWVQPPKkvApOGWd3GIXSVgc+lVkF tg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vk4h4y91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 07:22:29 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CBI5ZS007468;
        Mon, 12 Apr 2021 11:22:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 37u3n8gwk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 11:22:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CBMPSx31785256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 11:22:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E155BAE045;
        Mon, 12 Apr 2021 11:22:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB62BAE056;
        Mon, 12 Apr 2021 11:22:22 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.145])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 11:22:22 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, shuah@kernel.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        dja@axtens.net
Subject: [PATCH v3 1/4] powerpc/selftests/ptrace-hwbreak: Add testcases for 2nd DAWR
Date:   Mon, 12 Apr 2021 16:52:15 +0530
Message-Id: <20210412112218.128183-2-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412112218.128183-1-ravi.bangoria@linux.ibm.com>
References: <20210412112218.128183-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Op0MkrcXKYN6humZCXn1lNTv3bJx4yae
X-Proofpoint-GUID: Op0MkrcXKYN6humZCXn1lNTv3bJx4yae
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_09:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120074
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
Reviewed-by: Daniel Axtens <dja@axtens.net>
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

