Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFEE22AC6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgGWKXC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:23:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbgGWKXB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:23:01 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA2lGg039277;
        Thu, 23 Jul 2020 06:22:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqxgwr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:36 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NA3Ncb040852;
        Thu, 23 Jul 2020 06:22:35 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqxgwp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:35 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAGegh014631;
        Thu, 23 Jul 2020 10:22:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7wfdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAMQPX66650388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:22:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86D25A4065;
        Thu, 23 Jul 2020 10:22:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74090A4069;
        Thu, 23 Jul 2020 10:22:23 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:22:23 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 7/7] powerpc/selftests: Add selftest to test concurrent perf/ptrace events
Date:   Thu, 23 Jul 2020 15:50:58 +0530
Message-Id: <20200723102058.312282-8-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230076
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ptrace and perf watchpoints can't co-exists if their address range
overlaps. See commit 29da4f91c0c1 ("powerpc/watchpoint: Don't allow
concurrent perf and ptrace events") for more detail. Add selftest
for the same.

Sample o/p:
  # ./ptrace-perf-hwbreak
  test: ptrace-perf-hwbreak
  tags: git_version:powerpc-5.8-7-118-g937fa174a15d-dirty
  perf cpu event -> ptrace thread event (Overlapping): Ok
  perf cpu event -> ptrace thread event (Non-overlapping): Ok
  perf thread event -> ptrace same thread event (Overlapping): Ok
  perf thread event -> ptrace same thread event (Non-overlapping): Ok
  perf thread event -> ptrace other thread event: Ok
  ptrace thread event -> perf kernel event: Ok
  ptrace thread event -> perf same thread event (Overlapping): Ok
  ptrace thread event -> perf same thread event (Non-overlapping): Ok
  ptrace thread event -> perf other thread event: Ok
  ptrace thread event -> perf cpu event (Overlapping): Ok
  ptrace thread event -> perf cpu event (Non-overlapping): Ok
  ptrace thread event -> perf same thread & cpu event (Overlapping): Ok
  ptrace thread event -> perf same thread & cpu event (Non-overlapping): Ok
  ptrace thread event -> perf other thread & cpu event: Ok
  success: ptrace-perf-hwbreak

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/.gitignore       |   1 +
 .../testing/selftests/powerpc/ptrace/Makefile |   2 +-
 .../powerpc/ptrace/ptrace-perf-hwbreak.c      | 659 ++++++++++++++++++
 3 files changed, 661 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-perf-hwbreak.c

diff --git a/tools/testing/selftests/powerpc/ptrace/.gitignore b/tools/testing/selftests/powerpc/ptrace/.gitignore
index 0e96150b7c7e..eb75e5360e31 100644
--- a/tools/testing/selftests/powerpc/ptrace/.gitignore
+++ b/tools/testing/selftests/powerpc/ptrace/.gitignore
@@ -14,3 +14,4 @@ perf-hwbreak
 core-pkey
 ptrace-pkey
 ptrace-syscall
+ptrace-perf-hwbreak
diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 8d3f006c98cc..a500639da97a 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -2,7 +2,7 @@
 TEST_GEN_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
               ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
               ptrace-tm-spd-vsx ptrace-tm-spr ptrace-hwbreak ptrace-pkey core-pkey \
-              perf-hwbreak ptrace-syscall
+              perf-hwbreak ptrace-syscall ptrace-perf-hwbreak
 
 top_srcdir = ../../../../..
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-perf-hwbreak.c
new file mode 100644
index 000000000000..6b8804a4942e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-perf-hwbreak.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <asm/unistd.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
+#include "ptrace.h"
+
+char data[16];
+
+/* Overlapping address range */
+volatile __u64 *ptrace_data1 = (__u64 *)&data[0];
+volatile __u64 *perf_data1 = (__u64 *)&data[4];
+
+/* Non-overlapping address range */
+volatile __u64 *ptrace_data2 = (__u64 *)&data[0];
+volatile __u64 *perf_data2 = (__u64 *)&data[8];
+
+static unsigned long pid_max_addr(void)
+{
+	FILE *fp;
+	char *line, *c;
+	char addr[100];
+	size_t len = 0;
+
+	fp = fopen("/proc/kallsyms", "r");
+	if (!fp) {
+		printf("Failed to read /proc/kallsyms. Exiting..\n");
+		exit(EXIT_FAILURE);
+	}
+
+	while (getline(&line, &len, fp) != -1) {
+		if (!strstr(line, "pid_max") || strstr(line, "pid_max_max") ||
+		    strstr(line, "pid_max_min"))
+			continue;
+
+		strncpy(addr, line, len < 100 ? len : 100);
+		c = strchr(addr, ' ');
+		*c = '\0';
+		return strtoul(addr, &c, 16);
+	}
+	fclose(fp);
+	printf("Could not find pix_max. Exiting..\n");
+	exit(EXIT_FAILURE);
+	return -1;
+}
+
+static void perf_user_event_attr_set(struct perf_event_attr *attr, __u64 addr, __u64 len)
+{
+	memset(attr, 0, sizeof(struct perf_event_attr));
+	attr->type           = PERF_TYPE_BREAKPOINT;
+	attr->size           = sizeof(struct perf_event_attr);
+	attr->bp_type        = HW_BREAKPOINT_R;
+	attr->bp_addr        = addr;
+	attr->bp_len         = len;
+	attr->exclude_kernel = 1;
+	attr->exclude_hv     = 1;
+}
+
+static void perf_kernel_event_attr_set(struct perf_event_attr *attr)
+{
+	memset(attr, 0, sizeof(struct perf_event_attr));
+	attr->type           = PERF_TYPE_BREAKPOINT;
+	attr->size           = sizeof(struct perf_event_attr);
+	attr->bp_type        = HW_BREAKPOINT_R;
+	attr->bp_addr        = pid_max_addr();
+	attr->bp_len         = sizeof(unsigned long);
+	attr->exclude_user   = 1;
+	attr->exclude_hv     = 1;
+}
+
+static int perf_cpu_event_open(int cpu, __u64 addr, __u64 len)
+{
+	struct perf_event_attr attr;
+
+	perf_user_event_attr_set(&attr, addr, len);
+	return syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
+}
+
+static int perf_thread_event_open(pid_t child_pid, __u64 addr, __u64 len)
+{
+	struct perf_event_attr attr;
+
+	perf_user_event_attr_set(&attr, addr, len);
+	return syscall(__NR_perf_event_open, &attr, child_pid, -1, -1, 0);
+}
+
+static int perf_thread_cpu_event_open(pid_t child_pid, int cpu, __u64 addr, __u64 len)
+{
+	struct perf_event_attr attr;
+
+	perf_user_event_attr_set(&attr, addr, len);
+	return syscall(__NR_perf_event_open, &attr, child_pid, cpu, -1, 0);
+}
+
+static int perf_thread_kernel_event_open(pid_t child_pid)
+{
+	struct perf_event_attr attr;
+
+	perf_kernel_event_attr_set(&attr);
+	return syscall(__NR_perf_event_open, &attr, child_pid, -1, -1, 0);
+}
+
+static int perf_cpu_kernel_event_open(int cpu)
+{
+	struct perf_event_attr attr;
+
+	perf_kernel_event_attr_set(&attr);
+	return syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
+}
+
+static int child(void)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_TRACEME, 0, NULL, 0);
+	if (ret) {
+		printf("Error: PTRACE_TRACEME failed\n");
+		return 0;
+	}
+	kill(getpid(), SIGUSR1); /* --> parent (SIGUSR1) */
+
+	return 0;
+}
+
+static void ptrace_ppc_hw_breakpoint(struct ppc_hw_breakpoint *info, int type,
+				     __u64 addr, int len)
+{
+	info->version = 1;
+	info->trigger_type = type;
+	info->condition_mode = PPC_BREAKPOINT_CONDITION_NONE;
+	info->addr = addr;
+	info->addr2 = addr + len;
+	info->condition_value = 0;
+	if (!len)
+		info->addr_mode = PPC_BREAKPOINT_MODE_EXACT;
+	else
+		info->addr_mode = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
+}
+
+static int ptrace_open(pid_t child_pid, __u64 wp_addr, int len)
+{
+	struct ppc_hw_breakpoint info;
+
+	ptrace_ppc_hw_breakpoint(&info, PPC_BREAKPOINT_TRIGGER_RW, wp_addr, len);
+	return ptrace(PPC_PTRACE_SETHWDEBUG, child_pid, 0, &info);
+}
+
+static int test1(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by ptrace)
+	 *	if (existing cpu event by perf)
+	 *		if (addr range overlaps)
+	 *			fail;
+	 */
+
+	perf_fd = perf_cpu_event_open(0, (__u64)perf_data1, sizeof(*perf_data1));
+	if (perf_fd < 0)
+		return -1;
+
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd > 0 || errno != ENOSPC)
+		ret = -1;
+
+	close(perf_fd);
+	return ret;
+}
+
+static int test2(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by ptrace)
+	 *	if (existing cpu event by perf)
+	 *		if (addr range does not overlaps)
+	 *			allow;
+	 */
+
+	perf_fd = perf_cpu_event_open(0, (__u64)perf_data2, sizeof(*perf_data2));
+	if (perf_fd < 0)
+		return -1;
+
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data2, sizeof(*ptrace_data2));
+	if (ptrace_fd < 0) {
+		ret = -1;
+		goto perf_close;
+	}
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+
+perf_close:
+	close(perf_fd);
+	return ret;
+}
+
+static int test3(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by ptrace)
+	 *	if (existing thread event by perf on the same thread)
+	 *		if (addr range overlaps)
+	 *			fail;
+	 */
+	perf_fd = perf_thread_event_open(child_pid, (__u64)perf_data1,
+					 sizeof(*perf_data1));
+	if (perf_fd < 0)
+		return -1;
+
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd > 0 || errno != ENOSPC)
+		ret = -1;
+
+	close(perf_fd);
+	return ret;
+}
+
+static int test4(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by ptrace)
+	 *	if (existing thread event by perf on the same thread)
+	 *		if (addr range does not overlaps)
+	 *			fail;
+	 */
+	perf_fd = perf_thread_event_open(child_pid, (__u64)perf_data2,
+					 sizeof(*perf_data2));
+	if (perf_fd < 0)
+		return -1;
+
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data2, sizeof(*ptrace_data2));
+	if (ptrace_fd < 0) {
+		ret = -1;
+		goto perf_close;
+	}
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+
+perf_close:
+	close(perf_fd);
+	return ret;
+}
+
+static int test5(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int cpid;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by ptrace)
+	 *	if (existing thread event by perf on the different thread)
+	 *		allow;
+	 */
+	cpid = fork();
+	if (!cpid) {
+		/* Temporary Child */
+		pause();
+		exit(EXIT_SUCCESS);
+	}
+
+	perf_fd = perf_thread_event_open(cpid, (__u64)perf_data1, sizeof(*perf_data1));
+	if (perf_fd < 0) {
+		ret = -1;
+		goto kill_child;
+	}
+
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0) {
+		ret = -1;
+		goto perf_close;
+	}
+
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+perf_close:
+	close(perf_fd);
+kill_child:
+	kill(cpid, SIGINT);
+	return ret;
+}
+
+static int test6(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread kernel event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		allow;
+	 * -- OR --
+	 * if (new per cpu kernel event by perf)
+	 *	if (existing thread event by ptrace)
+	 *		allow;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_thread_kernel_event_open(child_pid);
+	if (perf_fd < 0) {
+		ret = -1;
+		goto ptrace_close;
+	}
+	close(perf_fd);
+
+	perf_fd = perf_cpu_kernel_event_open(0);
+	if (perf_fd < 0) {
+		ret = -1;
+		goto ptrace_close;
+	}
+	close(perf_fd);
+
+ptrace_close:
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test7(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		if (addr range overlaps)
+	 *			fail;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_thread_event_open(child_pid, (__u64)perf_data1,
+					 sizeof(*perf_data1));
+	if (perf_fd > 0 || errno != ENOSPC)
+		ret = -1;
+
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test8(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		if (addr range does not overlaps)
+	 *			allow;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data2, sizeof(*ptrace_data2));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_thread_event_open(child_pid, (__u64)perf_data2,
+					 sizeof(*perf_data2));
+	if (perf_fd < 0) {
+		ret = -1;
+		goto ptrace_close;
+	}
+	close(perf_fd);
+
+ptrace_close:
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test9(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int cpid;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread event by perf)
+	 *	if (existing thread event by ptrace on the other thread)
+	 *		allow;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0)
+		return -1;
+
+	cpid = fork();
+	if (!cpid) {
+		/* Temporary Child */
+		pause();
+		exit(EXIT_SUCCESS);
+	}
+
+	perf_fd = perf_thread_event_open(cpid, (__u64)perf_data1, sizeof(*perf_data1));
+	if (perf_fd < 0) {
+		ret = -1;
+		goto kill_child;
+	}
+	close(perf_fd);
+
+kill_child:
+	kill(cpid, SIGINT);
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test10(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per cpu event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		if (addr range overlaps)
+	 *			fail;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_cpu_event_open(0, (__u64)perf_data1, sizeof(*perf_data1));
+	if (perf_fd > 0 || errno != ENOSPC)
+		ret = -1;
+
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test11(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per cpu event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		if (addr range does not overlap)
+	 *			allow;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data2, sizeof(*ptrace_data2));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_cpu_event_open(0, (__u64)perf_data2, sizeof(*perf_data2));
+	if (perf_fd < 0) {
+		ret = -1;
+		goto ptrace_close;
+	}
+	close(perf_fd);
+
+ptrace_close:
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test12(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread and per cpu event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		if (addr range overlaps)
+	 *			fail;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_thread_cpu_event_open(child_pid, 0, (__u64)perf_data1,
+						sizeof(*perf_data1));
+	if (perf_fd > 0 || errno != ENOSPC)
+		ret = -1;
+
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test13(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread and per cpu event by perf)
+	 *	if (existing thread event by ptrace on the same thread)
+	 *		if (addr range does not overlap)
+	 *			allow;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data2, sizeof(*ptrace_data2));
+	if (ptrace_fd < 0)
+		return -1;
+
+	perf_fd = perf_thread_cpu_event_open(child_pid, 0, (__u64)perf_data2,
+						sizeof(*perf_data2));
+	if (perf_fd < 0) {
+		ret = -1;
+		goto ptrace_close;
+	}
+	close(perf_fd);
+
+ptrace_close:
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+static int test14(pid_t child_pid)
+{
+	int perf_fd;
+	int ptrace_fd;
+	int cpid;
+	int ret = 0;
+
+	/* Test:
+	 * if (new per thread and per cpu event by perf)
+	 *	if (existing thread event by ptrace on the other thread)
+	 *		allow;
+	 */
+	ptrace_fd = ptrace_open(child_pid, (__u64)ptrace_data1, sizeof(*ptrace_data1));
+	if (ptrace_fd < 0)
+		return -1;
+
+	cpid = fork();
+	if (!cpid) {
+		/* Temporary Child */
+		pause();
+		exit(EXIT_SUCCESS);
+	}
+
+	perf_fd = perf_thread_cpu_event_open(cpid, 0, (__u64)perf_data1,
+					     sizeof(*perf_data1));
+	if (perf_fd < 0) {
+		ret = -1;
+		goto kill_child;
+	}
+	close(perf_fd);
+
+kill_child:
+	kill(cpid, SIGINT);
+	ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, ptrace_fd);
+	return ret;
+}
+
+#define TEST(msg, fun, arg, ret) {		\
+	int r;					\
+	r = fun(arg);				\
+	if (r)					\
+		printf("%s: Error\n", msg);	\
+	else					\
+		printf("%s: Ok\n", msg);	\
+	ret |= r;				\
+}
+
+char *desc[14] = {
+	"perf cpu event -> ptrace thread event (Overlapping)",
+	"perf cpu event -> ptrace thread event (Non-overlapping)",
+	"perf thread event -> ptrace same thread event (Overlapping)",
+	"perf thread event -> ptrace same thread event (Non-overlapping)",
+	"perf thread event -> ptrace other thread event",
+	"ptrace thread event -> perf kernel event",
+	"ptrace thread event -> perf same thread event (Overlapping)",
+	"ptrace thread event -> perf same thread event (Non-overlapping)",
+	"ptrace thread event -> perf other thread event",
+	"ptrace thread event -> perf cpu event (Overlapping)",
+	"ptrace thread event -> perf cpu event (Non-overlapping)",
+	"ptrace thread event -> perf same thread & cpu event (Overlapping)",
+	"ptrace thread event -> perf same thread & cpu event (Non-overlapping)",
+	"ptrace thread event -> perf other thread & cpu event",
+};
+
+static int test(pid_t child_pid)
+{
+	int ret = TEST_PASS;
+
+	TEST(desc[0], test1, child_pid, ret);
+	TEST(desc[1], test2, child_pid, ret);
+	TEST(desc[2], test3, child_pid, ret);
+	TEST(desc[3], test4, child_pid, ret);
+	TEST(desc[4], test5, child_pid, ret);
+	TEST(desc[5], test6, child_pid, ret);
+	TEST(desc[6], test7, child_pid, ret);
+	TEST(desc[7], test8, child_pid, ret);
+	TEST(desc[8], test9, child_pid, ret);
+	TEST(desc[9], test10, child_pid, ret);
+	TEST(desc[10], test11, child_pid, ret);
+	TEST(desc[11], test12, child_pid, ret);
+	TEST(desc[12], test13, child_pid, ret);
+	TEST(desc[13], test14, child_pid, ret);
+
+	return ret;
+}
+
+static void get_dbginfo(pid_t child_pid, struct ppc_debug_info *dbginfo)
+{
+	if (ptrace(PPC_PTRACE_GETHWDBGINFO, child_pid, NULL, dbginfo)) {
+		perror("Can't get breakpoint info");
+		exit(-1);
+	}
+}
+
+static int ptrace_perf_hwbreak(void)
+{
+	int ret;
+	pid_t child_pid;
+	struct ppc_debug_info dbginfo;
+
+	child_pid = fork();
+	if (!child_pid)
+		return child();
+
+	/* parent */
+	wait(NULL); /* <-- child (SIGUSR1) */
+
+	get_dbginfo(child_pid, &dbginfo);
+	SKIP_IF(dbginfo.num_data_bps <= 1);
+
+	ret = perf_cpu_event_open(0, (__u64)perf_data1, sizeof(*perf_data1));
+	SKIP_IF(ret < 0);
+	close(ret);
+
+	ret = test(child_pid);
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(ptrace_perf_hwbreak, "ptrace-perf-hwbreak");
+}
-- 
2.26.2

