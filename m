Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72922AC6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 12:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGWKW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 06:22:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728468AbgGWKW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 06:22:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NA3CkS151343;
        Thu, 23 Jul 2020 06:22:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e11p90ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:31 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NAIepN014039;
        Thu, 23 Jul 2020 06:22:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e11p90ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 06:22:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NAEgff031527;
        Thu, 23 Jul 2020 10:22:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn1wbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 10:22:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NAMNSu29491648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 10:22:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2076DA4054;
        Thu, 23 Jul 2020 10:22:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17FD3A4060;
        Thu, 23 Jul 2020 10:22:20 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 10:22:19 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, paulus@samba.org
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 6/7] powerpc/selftests/perf-hwbreak: Add testcases for 2nd DAWR
Date:   Thu, 23 Jul 2020 15:50:57 +0530
Message-Id: <20200723102058.312282-7-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2
 impostorscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230076
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend perf-hwbreak.c selftest to test multiple DAWRs. Also add
testcase for testing 512 byte boundary removal.

Sample o/p:
  # ./perf-hwbreak
  ...
  TESTED: Process specific, Two events, diff addr
  TESTED: Process specific, Two events, same addr
  TESTED: Process specific, Two events, diff addr, one is RO, other is WO
  TESTED: Process specific, Two events, same addr, one is RO, other is WO
  TESTED: Systemwide, Two events, diff addr
  TESTED: Systemwide, Two events, same addr
  TESTED: Systemwide, Two events, diff addr, one is RO, other is WO
  TESTED: Systemwide, Two events, same addr, one is RO, other is WO
  TESTED: Process specific, 512 bytes, unaligned
  success: perf_hwbreak

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/perf-hwbreak.c   | 568 +++++++++++++++++-
 1 file changed, 567 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
index bde475341c8a..5df08738884d 100644
--- a/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/perf-hwbreak.c
@@ -21,8 +21,13 @@
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <signal.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/wait.h>
+#include <sys/ptrace.h>
+#include <sys/sysinfo.h>
+#include <asm/ptrace.h>
 #include <elf.h>
 #include <pthread.h>
 #include <sys/syscall.h>
@@ -34,6 +39,12 @@
 
 #define DAWR_LENGTH_MAX ((0x3f + 1) * 8)
 
+int nprocs;
+
+static volatile int a = 10;
+static volatile int b = 10;
+static volatile char c[512 + 8] __attribute__((aligned(512)));
+
 static void perf_event_attr_set(struct perf_event_attr *attr,
 				__u32 type, __u64 addr, __u64 len,
 				bool exclude_user)
@@ -68,6 +79,76 @@ static int perf_process_event_open(__u32 type, __u64 addr, __u64 len)
 	return syscall(__NR_perf_event_open, &attr, getpid(), -1, -1, 0);
 }
 
+static int perf_cpu_event_open(long cpu, __u32 type, __u64 addr, __u64 len)
+{
+	struct perf_event_attr attr;
+
+	perf_event_attr_set(&attr, type, addr, len, 0);
+	return syscall(__NR_perf_event_open, &attr, -1, cpu, -1, 0);
+}
+
+static void close_fds(int *fd, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		close(fd[i]);
+}
+
+static unsigned long read_fds(int *fd, int n)
+{
+	int i;
+	unsigned long c = 0;
+	unsigned long count = 0;
+	size_t res;
+
+	for (i = 0; i < n; i++) {
+		res = read(fd[i], &c, sizeof(c));
+		assert(res == sizeof(unsigned long long));
+		count += c;
+	}
+	return count;
+}
+
+static void reset_fds(int *fd, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		ioctl(fd[i], PERF_EVENT_IOC_RESET);
+}
+
+static void enable_fds(int *fd, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		ioctl(fd[i], PERF_EVENT_IOC_ENABLE);
+}
+
+static void disable_fds(int *fd, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		ioctl(fd[i], PERF_EVENT_IOC_DISABLE);
+}
+
+static int perf_systemwide_event_open(int *fd, __u32 type, __u64 addr, __u64 len)
+{
+	int i = 0;
+
+	/* Assume online processors are 0 to nprocs for simplisity */
+	for (i = 0; i < nprocs; i++) {
+		fd[i] = perf_cpu_event_open(i, type, addr, len);
+		if (fd[i] < 0) {
+			close_fds(fd, i);
+			return fd[i];
+		}
+	}
+	return 0;
+}
+
 static inline bool breakpoint_test(int len)
 {
 	int fd;
@@ -261,11 +342,483 @@ static int runtest_dar_outside(void)
 	return fail;
 }
 
+static void multi_dawr_workload(void)
+{
+	a += 10;
+	b += 10;
+	c[512 + 1] += 'a';
+}
+
+static int test_process_multi_diff_addr(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int fd1, fd2;
+	char *desc = "Process specific, Two events, diff addr";
+	size_t res;
+
+	fd1 = perf_process_event_open(HW_BREAKPOINT_RW, (__u64)&a, (__u64)sizeof(a));
+	if (fd1 < 0) {
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	fd2 = perf_process_event_open(HW_BREAKPOINT_RW, (__u64)&b, (__u64)sizeof(b));
+	if (fd2 < 0) {
+		close(fd1);
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(fd1, PERF_EVENT_IOC_RESET);
+	ioctl(fd2, PERF_EVENT_IOC_RESET);
+	ioctl(fd1, PERF_EVENT_IOC_ENABLE);
+	ioctl(fd2, PERF_EVENT_IOC_ENABLE);
+	multi_dawr_workload();
+	ioctl(fd1, PERF_EVENT_IOC_DISABLE);
+	ioctl(fd2, PERF_EVENT_IOC_DISABLE);
+
+	res = read(fd1, &breaks1, sizeof(breaks1));
+	assert(res == sizeof(unsigned long long));
+	res = read(fd2, &breaks2, sizeof(breaks2));
+	assert(res == sizeof(unsigned long long));
+
+	close(fd1);
+	close(fd2);
+
+	if (breaks1 != 2 || breaks2 != 2) {
+		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_process_multi_same_addr(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int fd1, fd2;
+	char *desc = "Process specific, Two events, same addr";
+	size_t res;
+
+	fd1 = perf_process_event_open(HW_BREAKPOINT_RW, (__u64)&a, (__u64)sizeof(a));
+	if (fd1 < 0) {
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	fd2 = perf_process_event_open(HW_BREAKPOINT_RW, (__u64)&a, (__u64)sizeof(a));
+	if (fd2 < 0) {
+		close(fd1);
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(fd1, PERF_EVENT_IOC_RESET);
+	ioctl(fd2, PERF_EVENT_IOC_RESET);
+	ioctl(fd1, PERF_EVENT_IOC_ENABLE);
+	ioctl(fd2, PERF_EVENT_IOC_ENABLE);
+	multi_dawr_workload();
+	ioctl(fd1, PERF_EVENT_IOC_DISABLE);
+	ioctl(fd2, PERF_EVENT_IOC_DISABLE);
+
+	res = read(fd1, &breaks1, sizeof(breaks1));
+	assert(res == sizeof(unsigned long long));
+	res = read(fd2, &breaks2, sizeof(breaks2));
+	assert(res == sizeof(unsigned long long));
+
+	close(fd1);
+	close(fd2);
+
+	if (breaks1 != 2 || breaks2 != 2) {
+		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_process_multi_diff_addr_ro_wo(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int fd1, fd2;
+	char *desc = "Process specific, Two events, diff addr, one is RO, other is WO";
+	size_t res;
+
+	fd1 = perf_process_event_open(HW_BREAKPOINT_W, (__u64)&a, (__u64)sizeof(a));
+	if (fd1 < 0) {
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	fd2 = perf_process_event_open(HW_BREAKPOINT_R, (__u64)&b, (__u64)sizeof(b));
+	if (fd2 < 0) {
+		close(fd1);
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(fd1, PERF_EVENT_IOC_RESET);
+	ioctl(fd2, PERF_EVENT_IOC_RESET);
+	ioctl(fd1, PERF_EVENT_IOC_ENABLE);
+	ioctl(fd2, PERF_EVENT_IOC_ENABLE);
+	multi_dawr_workload();
+	ioctl(fd1, PERF_EVENT_IOC_DISABLE);
+	ioctl(fd2, PERF_EVENT_IOC_DISABLE);
+
+	res = read(fd1, &breaks1, sizeof(breaks1));
+	assert(res == sizeof(unsigned long long));
+	res = read(fd2, &breaks2, sizeof(breaks2));
+	assert(res == sizeof(unsigned long long));
+
+	close(fd1);
+	close(fd2);
+
+	if (breaks1 != 1 || breaks2 != 1) {
+		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_process_multi_same_addr_ro_wo(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int fd1, fd2;
+	char *desc = "Process specific, Two events, same addr, one is RO, other is WO";
+	size_t res;
+
+	fd1 = perf_process_event_open(HW_BREAKPOINT_R, (__u64)&a, (__u64)sizeof(a));
+	if (fd1 < 0) {
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	fd2 = perf_process_event_open(HW_BREAKPOINT_W, (__u64)&a, (__u64)sizeof(a));
+	if (fd2 < 0) {
+		close(fd1);
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(fd1, PERF_EVENT_IOC_RESET);
+	ioctl(fd2, PERF_EVENT_IOC_RESET);
+	ioctl(fd1, PERF_EVENT_IOC_ENABLE);
+	ioctl(fd2, PERF_EVENT_IOC_ENABLE);
+	multi_dawr_workload();
+	ioctl(fd1, PERF_EVENT_IOC_DISABLE);
+	ioctl(fd2, PERF_EVENT_IOC_DISABLE);
+
+	res = read(fd1, &breaks1, sizeof(breaks1));
+	assert(res == sizeof(unsigned long long));
+	res = read(fd2, &breaks2, sizeof(breaks2));
+	assert(res == sizeof(unsigned long long));
+
+	close(fd1);
+	close(fd2);
+
+	if (breaks1 != 1 || breaks2 != 1) {
+		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_syswide_multi_diff_addr(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int *fd1 = malloc(nprocs * sizeof(int));
+	int *fd2 = malloc(nprocs * sizeof(int));
+	char *desc = "Systemwide, Two events, diff addr";
+	int ret;
+
+	ret = perf_systemwide_event_open(fd1, HW_BREAKPOINT_RW, (__u64)&a,
+					(__u64)sizeof(a));
+	if (ret) {
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = perf_systemwide_event_open(fd2, HW_BREAKPOINT_RW, (__u64)&b,
+					(__u64)sizeof(b));
+	if (ret) {
+		close_fds(fd1, nprocs);
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	reset_fds(fd1, nprocs);
+	reset_fds(fd2, nprocs);
+	enable_fds(fd1, nprocs);
+	enable_fds(fd2, nprocs);
+	multi_dawr_workload();
+	disable_fds(fd1, nprocs);
+	disable_fds(fd2, nprocs);
+
+	breaks1 = read_fds(fd1, nprocs);
+	breaks2 = read_fds(fd2, nprocs);
+
+	close_fds(fd1, nprocs);
+	close_fds(fd2, nprocs);
+
+	free(fd1);
+	free(fd2);
+
+	if (breaks1 != 2 || breaks2 != 2) {
+		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_syswide_multi_same_addr(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int *fd1 = malloc(nprocs * sizeof(int));
+	int *fd2 = malloc(nprocs * sizeof(int));
+	char *desc = "Systemwide, Two events, same addr";
+	int ret;
+
+	ret = perf_systemwide_event_open(fd1, HW_BREAKPOINT_RW, (__u64)&a,
+					(__u64)sizeof(a));
+	if (ret) {
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = perf_systemwide_event_open(fd2, HW_BREAKPOINT_RW, (__u64)&a,
+					(__u64)sizeof(a));
+	if (ret) {
+		close_fds(fd1, nprocs);
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	reset_fds(fd1, nprocs);
+	reset_fds(fd2, nprocs);
+	enable_fds(fd1, nprocs);
+	enable_fds(fd2, nprocs);
+	multi_dawr_workload();
+	disable_fds(fd1, nprocs);
+	disable_fds(fd2, nprocs);
+
+	breaks1 = read_fds(fd1, nprocs);
+	breaks2 = read_fds(fd2, nprocs);
+
+	close_fds(fd1, nprocs);
+	close_fds(fd2, nprocs);
+
+	free(fd1);
+	free(fd2);
+
+	if (breaks1 != 2 || breaks2 != 2) {
+		printf("FAILED: %s: %lld != 2 || %lld != 2\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_syswide_multi_diff_addr_ro_wo(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int *fd1 = malloc(nprocs * sizeof(int));
+	int *fd2 = malloc(nprocs * sizeof(int));
+	char *desc = "Systemwide, Two events, diff addr, one is RO, other is WO";
+	int ret;
+
+	ret = perf_systemwide_event_open(fd1, HW_BREAKPOINT_W, (__u64)&a,
+					(__u64)sizeof(a));
+	if (ret) {
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = perf_systemwide_event_open(fd2, HW_BREAKPOINT_R, (__u64)&b,
+					(__u64)sizeof(b));
+	if (ret) {
+		close_fds(fd1, nprocs);
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	reset_fds(fd1, nprocs);
+	reset_fds(fd2, nprocs);
+	enable_fds(fd1, nprocs);
+	enable_fds(fd2, nprocs);
+	multi_dawr_workload();
+	disable_fds(fd1, nprocs);
+	disable_fds(fd2, nprocs);
+
+	breaks1 = read_fds(fd1, nprocs);
+	breaks2 = read_fds(fd2, nprocs);
+
+	close_fds(fd1, nprocs);
+	close_fds(fd2, nprocs);
+
+	free(fd1);
+	free(fd2);
+
+	if (breaks1 != 1 || breaks2 != 1) {
+		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int test_syswide_multi_same_addr_ro_wo(void)
+{
+	unsigned long long breaks1 = 0, breaks2 = 0;
+	int *fd1 = malloc(nprocs * sizeof(int));
+	int *fd2 = malloc(nprocs * sizeof(int));
+	char *desc = "Systemwide, Two events, same addr, one is RO, other is WO";
+	int ret;
+
+	ret = perf_systemwide_event_open(fd1, HW_BREAKPOINT_W, (__u64)&a,
+					(__u64)sizeof(a));
+	if (ret) {
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = perf_systemwide_event_open(fd2, HW_BREAKPOINT_R, (__u64)&a,
+					(__u64)sizeof(a));
+	if (ret) {
+		close_fds(fd1, nprocs);
+		perror("perf_systemwide_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	reset_fds(fd1, nprocs);
+	reset_fds(fd2, nprocs);
+	enable_fds(fd1, nprocs);
+	enable_fds(fd2, nprocs);
+	multi_dawr_workload();
+	disable_fds(fd1, nprocs);
+	disable_fds(fd2, nprocs);
+
+	breaks1 = read_fds(fd1, nprocs);
+	breaks2 = read_fds(fd2, nprocs);
+
+	close_fds(fd1, nprocs);
+	close_fds(fd2, nprocs);
+
+	free(fd1);
+	free(fd2);
+
+	if (breaks1 != 1 || breaks2 != 1) {
+		printf("FAILED: %s: %lld != 1 || %lld != 1\n", desc,
+			breaks1, breaks2);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+static int runtest_multi_dawr(void)
+{
+	int ret = 0;
+
+	ret |= test_process_multi_diff_addr();
+	ret |= test_process_multi_same_addr();
+	ret |= test_process_multi_diff_addr_ro_wo();
+	ret |= test_process_multi_same_addr_ro_wo();
+	ret |= test_syswide_multi_diff_addr();
+	ret |= test_syswide_multi_same_addr();
+	ret |= test_syswide_multi_diff_addr_ro_wo();
+	ret |= test_syswide_multi_same_addr_ro_wo();
+
+	return ret;
+}
+
+static int runtest_unaligned_512bytes(void)
+{
+	unsigned long long breaks = 0;
+	int fd;
+	char *desc = "Process specific, 512 bytes, unaligned";
+	__u64 addr = (__u64)&c + 8;
+	size_t res;
+
+	fd = perf_process_event_open(HW_BREAKPOINT_RW, addr, 512);
+	if (fd < 0) {
+		perror("perf_process_event_open");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(fd, PERF_EVENT_IOC_RESET);
+	ioctl(fd, PERF_EVENT_IOC_ENABLE);
+	multi_dawr_workload();
+	ioctl(fd, PERF_EVENT_IOC_DISABLE);
+
+	res = read(fd, &breaks, sizeof(breaks));
+	assert(res == sizeof(unsigned long long));
+
+	close(fd);
+
+	if (breaks != 2) {
+		printf("FAILED: %s: %lld != 2\n", desc, breaks);
+		return 1;
+	}
+
+	printf("TESTED: %s\n", desc);
+	return 0;
+}
+
+/* There is no perf api to find number of available watchpoints. Use ptrace. */
+static int get_nr_wps(bool *arch_31)
+{
+	struct ppc_debug_info dbginfo;
+	int child_pid;
+
+	child_pid = fork();
+	if (!child_pid) {
+		int ret = ptrace(PTRACE_TRACEME, 0, NULL, 0);
+		if (ret) {
+			perror("PTRACE_TRACEME failed\n");
+			exit(EXIT_FAILURE);
+		}
+		kill(getpid(), SIGUSR1);
+
+		sleep(1);
+		exit(EXIT_SUCCESS);
+	}
+
+	wait(NULL);
+	if (ptrace(PPC_PTRACE_GETHWDBGINFO, child_pid, NULL, &dbginfo)) {
+		perror("Can't get breakpoint info");
+		exit(EXIT_FAILURE);
+	}
+
+	*arch_31 = !!(dbginfo.features & PPC_DEBUG_FEATURE_DATA_BP_DAWR_ARCH_31);
+	return dbginfo.num_data_bps;
+}
+
 static int runtest(void)
 {
 	int rwflag;
 	int exclude_user;
 	int ret;
+	bool dawr = dawr_supported();
+	bool arch_31 = false;
+	int nr_wps = get_nr_wps(&arch_31);
 
 	/*
 	 * perf defines rwflag as two bits read and write and at least
@@ -278,7 +831,7 @@ static int runtest(void)
 				return ret;
 
 			/* if we have the dawr, we can do an array test */
-			if (!dawr_supported())
+			if (!dawr)
 				continue;
 			ret = runtestsingle(rwflag, exclude_user, 1);
 			if (ret)
@@ -287,6 +840,19 @@ static int runtest(void)
 	}
 
 	ret = runtest_dar_outside();
+	if (ret)
+		return ret;
+
+	if (dawr && nr_wps > 1) {
+		nprocs = get_nprocs();
+		ret = runtest_multi_dawr();
+		if (ret)
+			return ret;
+	}
+
+	if (dawr && arch_31)
+		ret = runtest_unaligned_512bytes();
+
 	return ret;
 }
 
-- 
2.26.2

