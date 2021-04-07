Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9987356375
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbhDGFuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 01:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244402AbhDGFuH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 01:50:07 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1375XNSU111947;
        Wed, 7 Apr 2021 01:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZoDWe1mpN7MQ+iHUv3uym53lUgglo1YTF76NRf/n8Q0=;
 b=FsnpT0b/WYqe/2Qct4NA582NPQnG57J26q0toXInzQbj2yOMZAxULBn3w2kXU08cGK3K
 d3fWP4NdeJz+j4dWYxASSXiPqotoCQ0Lc4tFTqmsVF4yE04KZ/3Qs1/LCEN7sAB6kqgd
 IxHhEBGFbq72S0NifBJFfPcJWd8v6+NlaN1Z8q0pPAqPn3fkHY8NIgSOjoPruOjXPTfw
 0hPzoQR1iX3EZoCt6nxo2cQB/Ng3ohbF89yl2vs1hJpxuqDZFE/1xqx+MKc5mTXh383L
 8VP8dQIZBxEYNru6VJylOfgXSWj6q/4VD3ZwuDa1dIo991DzuoLt1cd00ZPqoAwQxMVM bA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn05qsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 01:49:52 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1375mT2N020675;
        Wed, 7 Apr 2021 05:49:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 37rvmq86ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 05:49:50 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1375nR0Y33096022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 05:49:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E5FCA4051;
        Wed,  7 Apr 2021 05:49:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A721BA404D;
        Wed,  7 Apr 2021 05:49:46 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.44.100])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 05:49:46 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, shuah@kernel.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] powerpc/selftests/perf-hwbreak: Coalesce event creation code
Date:   Wed,  7 Apr 2021 11:19:36 +0530
Message-Id: <20210407054938.312857-3-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com>
References: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: st9yZgY6hxT4VIZ3CNYKvLH18yGgURue
X-Proofpoint-ORIG-GUID: st9yZgY6hxT4VIZ3CNYKvLH18yGgURue
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_03:2021-04-06,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070039
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
2.27.0

