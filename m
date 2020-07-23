Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37E722AC66
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgGWKWv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:22:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728418AbgGWKWt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:22:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA2Soh004345;
        Thu, 23 Jul 2020 06:22:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32f718k2w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:26 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NA2TfJ004477;
        Thu, 23 Jul 2020 06:22:25 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32f718k2vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAG3vQ014540;
        Thu, 23 Jul 2020 10:22:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7wfdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:23 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAMJgf65339898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:22:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2A1AA4060;
        Thu, 23 Jul 2020 10:22:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AED9AA4064;
        Thu, 23 Jul 2020 10:22:16 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:22:16 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 5/7] powerpc/selftests/perf-hwbreak: Coalesce event creation code
Date:   Thu, 23 Jul 2020 15:50:56 +0530
Message-Id: <20200723102058.312282-6-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=2 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230072
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

perf-hwbreak selftest opens hw-breakpoint event at multiple places for
which it has same code repeated. Coalesce that code into a function.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 78 +++++++++----------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
index c1f324afdbf3..bde475341c8a 100644
--- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
@@ -34,28 +34,46 @@
 
 #define DAWR_LENGTH_MAX ((0x3f + 1) * 8)
 
-static inline int sys_perf_event_open(struct perf_event_attr *attr, pid_t pid,
-				      int cpu, int group_fd,
-				      unsigned long flags)
+static void perf_event_attr_set(struct perf_event_attr *attr,
+				__u32 type, __u64 addr, __u64 len,
+				bool exclude_user)
 {
-	attr->size = sizeof(*attr);
-	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+	memset(attr, 0, sizeof(struct perf_event_attr));
+	attr->type           = PERF_TYPE_BREAKPOINT;
+	attr->size           = sizeof(struct perf_event_attr);
+	attr->bp_type        = type;
+	attr->bp_addr        = addr;
+	attr->bp_len         = len;
+	attr->exclude_kernel = 1;
+	attr->exclude_hv     = 1;
+	attr->exclude_guest  = 1;
+	attr->exclude_user   = exclude_user;
+	attr->disabled       = 1;
 }
 
-static inline bool breakpoint_test(int len)
+static int
+perf_process_event_open_exclude_user(__u32 type, __u64 addr, __u64 len, bool exclude_user)
 {
 	struct perf_event_attr attr;
+
+	perf_event_attr_set(&attr, type, addr, len, exclude_user);
+	return syscall(__NR_perf_event_open, &attr, getpid(), -1, -1, 0);
+}
+
+static int perf_process_event_open(__u32 type, __u64 addr, __u64 len)
+{
+	struct perf_event_attr attr;
+
+	perf_event_attr_set(&attr, type, addr, len, 0);
+	return syscall(__NR_perf_event_open, &attr, getpid(), -1, -1, 0);
+}
+
+static inline bool breakpoint_test(int len)
+{
 	int fd;
 
-	/* setup counters */
-	memset(&attr, 0, sizeof(attr));
-	attr.disabled = 1;
-	attr.type = PERF_TYPE_BREAKPOINT;
-	attr.bp_type = HW_BREAKPOINT_R;
 	/* bp_addr can point anywhere but needs to be aligned */
-	attr.bp_addr = (__u64)(&attr) & 0xfffffffffffff800;
-	attr.bp_len = len;
-	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	fd = perf_process_event_open(HW_BREAKPOINT_R, (__u64)(&fd) & 0xfffffffffffff800, len);
 	if (fd < 0)
 		return false;
 	close(fd);
@@ -75,7 +93,6 @@ static inline bool dawr_supported(void)
 static int runtestsingle(int readwriteflag, int exclude_user, int arraytest)
 {
 	int i,j;
-	struct perf_event_attr attr;
 	size_t res;
 	unsigned long long breaks, needed;
 	int readint;
@@ -94,19 +111,11 @@ static int runtestsingle(int readwriteflag, int exclude_user, int arraytest)
 	if (arraytest)
 		ptr = &readintalign[0];
 
-	/* setup counters */
-	memset(&attr, 0, sizeof(attr));
-	attr.disabled = 1;
-	attr.type = PERF_TYPE_BREAKPOINT;
-	attr.bp_type = readwriteflag;
-	attr.bp_addr = (__u64)ptr;
-	attr.bp_len = sizeof(int);
-	if (arraytest)
-		attr.bp_len = DAWR_LENGTH_MAX;
-	attr.exclude_user = exclude_user;
-	break_fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	break_fd = perf_process_event_open_exclude_user(readwriteflag, (__u64)ptr,
+				arraytest ? DAWR_LENGTH_MAX : sizeof(int),
+				exclude_user);
 	if (break_fd < 0) {
-		perror("sys_perf_event_open");
+		perror("perf_process_event_open_exclude_user");
 		exit(1);
 	}
 
@@ -153,7 +162,6 @@ static int runtest_dar_outside(void)
 	void *target;
 	volatile __u16 temp16;
 	volatile __u64 temp64;
-	struct perf_event_attr attr;
 	int break_fd;
 	unsigned long long breaks;
 	int fail = 0;
@@ -165,21 +173,11 @@ static int runtest_dar_outside(void)
 		exit(EXIT_FAILURE);
 	}
 
-	/* setup counters */
-	memset(&attr, 0, sizeof(attr));
-	attr.disabled = 1;
-	attr.type = PERF_TYPE_BREAKPOINT;
-	attr.exclude_kernel = 1;
-	attr.exclude_hv = 1;
-	attr.exclude_guest = 1;
-	attr.bp_type = HW_BREAKPOINT_RW;
 	/* watch middle half of target array */
-	attr.bp_addr = (__u64)(target + 2);
-	attr.bp_len = 4;
-	break_fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	break_fd = perf_process_event_open(HW_BREAKPOINT_RW, (__u64)(target + 2), 4);
 	if (break_fd < 0) {
 		free(target);
-		perror("sys_perf_event_open");
+		perror("perf_process_event_open");
 		exit(EXIT_FAILURE);
 	}
 
-- 
2.26.2

