Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74835C4F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbhDLLW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 07:22:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240287AbhDLLW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CB2ltO093086;
        Mon, 12 Apr 2021 07:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qusUhD3OUuz2Pd3hkbJRL9AL9v/JRYjVLj9LY5quo8s=;
 b=bo4ZMV0Q1j4bOfFGrjJd99t4xlmQLRZ/Q/AWSO8qSVbE6OorSc07khhQJjqK8NrRT3W7
 nFZ+15RpkqRglo9NYiIWVea60fOn17x1AQEXrpmL2MuKUBj4Q9tdYBMjZhQw8Nn4ATNt
 Os3sFVfkILjdCXyhuqCPjoyN2/WwixRktXN1O7gLyFvku8IJUr7u6YBkU5WZrhETMT+Q
 X1mcmp4GRuaPGaVrtLJ3opX8WW6kwyCO8f99rvNV+CZaF5vLLPv0KmLQxwLXzg+UGvrF
 w1QjlzDK9XDzDtu8MyQJwlLaMI3Xik5YsAIq2EXQx8x2F1lV+3Kd+UesegaJTyl8iJLb 3w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vk4h4ya9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 07:22:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CBHvFI017496;
        Mon, 12 Apr 2021 11:22:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n89rba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 11:22:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CBMRkD58720560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 11:22:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74B3BAE055;
        Mon, 12 Apr 2021 11:22:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71382AE04D;
        Mon, 12 Apr 2021 11:22:25 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.145])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 11:22:25 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, shuah@kernel.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        dja@axtens.net
Subject: [PATCH v3 2/4] powerpc/selftests/perf-hwbreak: Coalesce event creation code
Date:   Mon, 12 Apr 2021 16:52:16 +0530
Message-Id: <20210412112218.128183-3-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412112218.128183-1-ravi.bangoria@linux.ibm.com>
References: <20210412112218.128183-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PduaQqV4_ljbWwqE5z8zy6HWYAFtmw8B
X-Proofpoint-GUID: PduaQqV4_ljbWwqE5z8zy6HWYAFtmw8B
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

perf-hwbreak selftest opens hw-breakpoint event at multiple places for
which it has same code repeated. Coalesce that code into a function.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 79 +++++++++----------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
index c1f324afdbf3..b1d5a14d7722 100644
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
@@ -85,6 +102,7 @@ static int runtestsingle(int readwriteflag, int exclude_user, int arraytest)
 	int break_fd;
 	int loop_num = MAX_LOOPS - (rand() % 100); /* provide some variability */
 	volatile int *k;
+	__u64 len;
 
 	/* align to 0x400 boundary as required by DAWR */
 	readintalign = (int *)(((unsigned long)readintarraybig + 0x7ff) &
@@ -94,19 +112,11 @@ static int runtestsingle(int readwriteflag, int exclude_user, int arraytest)
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
+	len = arraytest ? DAWR_LENGTH_MAX : sizeof(int);
+	break_fd = perf_process_event_open_exclude_user(readwriteflag, (__u64)ptr,
+							len, exclude_user);
 	if (break_fd < 0) {
-		perror("sys_perf_event_open");
+		perror("perf_process_event_open_exclude_user");
 		exit(1);
 	}
 
@@ -153,7 +163,6 @@ static int runtest_dar_outside(void)
 	void *target;
 	volatile __u16 temp16;
 	volatile __u64 temp64;
-	struct perf_event_attr attr;
 	int break_fd;
 	unsigned long long breaks;
 	int fail = 0;
@@ -165,21 +174,11 @@ static int runtest_dar_outside(void)
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
2.27.0

