Return-Path: <linux-kselftest+bounces-20487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE39AD013
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C280282CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B11CFEA1;
	Wed, 23 Oct 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4lDUPBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41A1CEAAD;
	Wed, 23 Oct 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700449; cv=none; b=axL8WGm68EFutUn7bTBC+9NtWHRScVGk49I1pJkvDqYETajRnB9r0Ob58OJZkPu5PpAjPdeVBybDGu6d7Vt+5m22FVOUVR+FbhPSntcp0uFXEOT7rLTym+qcV8nbdecYXwDfD/YlYcHJTNylZC5i+jmxLqYFiTUcOQROuQgAUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700449; c=relaxed/simple;
	bh=f3a5263cep6TMWDKytJuxxu5LUUGOGKI9hEekwR+4dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHhbK16I+U5ua8/ZUTTOt5rFHTgdAufFUJ1cEQABZQGhSC5Jb99ff2fU1bzDaCDnDYs1E/jSYtjRVrBnhieyB/XO0hpDdGPkkXk0GBNK+p/i3BTSWXyEbqdUohDVkJei0FumNttkNHzCFrWWRzPGn4gJy4iIpn8d4LSAUXOKPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4lDUPBC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfcaN013899;
	Wed, 23 Oct 2024 16:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=DPkq/
	LKcaMxzmYyQwnKcUdgK/rCr0jNZ3OtFlccvxvg=; b=d4lDUPBCQT8EPTd92hkA1
	UrQdAF7pBBxTe3qmDBXQ+Nc91n0IKCpNFHj+Zzlmq2L6qFZpg8QeZI2octXQtPXf
	HHQptCcD45x3o7YztMuy22sRXoo57QUIbvX6tZvokff5OIm/6HOskJR+SjqAVYEk
	KE+DDeLBm6Q16sX0oKHSnE/Po/n38NoSejYppXLmu8VGljsEeTkybkkOfiSk5310
	Y+dNlPYU8tBdZoQEkz0Gsvc1BC6G3yZBDdM8RPz5saWOmnlW02TJ5nmDZkG/qLUl
	lv7ZEa5cpUglr4nyLVWClTBYnk+Lu8QYwKghDF4SHQJJxE1EcOECA3tt4Ux5pp5f
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v0hf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:20:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NGHsQU025233;
	Wed, 23 Oct 2024 16:20:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9r67x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:20:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49NGK80C012043;
	Wed, 23 Oct 2024 16:20:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42emh9r5x9-4;
	Wed, 23 Oct 2024 16:20:14 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, akpm@linux-foundation.org,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        johannes.berg@intel.com, mic@digikod.net, gnoack@google.com,
        jk@codeconstruct.com.au, kunit-dev@googlegroups.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next v6 3/3] connector/cn_proc: Selftest for threads
Date: Wed, 23 Oct 2024 09:20:06 -0700
Message-ID: <20241023162006.1725309-4-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023162006.1725309-1-anjali.k.kulkarni@oracle.com>
References: <20241023162006.1725309-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-GUID: qvvO9B7RzzkrnbDugTNLMdx5hJPLCKPw
X-Proofpoint-ORIG-GUID: qvvO9B7RzzkrnbDugTNLMdx5hJPLCKPw

Test to check if setting PROC_CN_MCAST_NOTIFY in proc connector API, allows
a thread's non-zero exit status to be returned to proc_filter.

The threads.c program creates 2 child threads. 1st thread handles signal
SIGSEGV, and 2nd thread needs to indicate some error condition (value 1)
to the kernel, instead of using pthread_exit() with 1.

In both cases, child sends notify_netlink_thread_exit(exit_code) to kernel,
to let kernel know it has exited abnormally with exit_code.

Compile:
    make thread
    make proc_filter
Run:
    ./threads

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 tools/testing/selftests/connector/Makefile    |  25 ++
 .../testing/selftests/connector/proc_filter.c |  63 +++--
 tools/testing/selftests/connector/thread.c    | 238 ++++++++++++++++++
 .../selftests/connector/thread_filter.c       |  96 +++++++
 4 files changed, 403 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
index 92188b9bac5c..675015bdf8ee 100644
--- a/tools/testing/selftests/connector/Makefile
+++ b/tools/testing/selftests/connector/Makefile
@@ -1,6 +1,31 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Enable if you want to use build kernel header files instead of installed
+# kernel files
+# KERNEL="../../../.."
+# CFLAGS += -Wall $(KHDR_INCLUDES) -I $(KERNEL)/include/uapi -I $(KERNEL)/include
+
 CFLAGS += -Wall $(KHDR_INCLUDES)
 
+proc_filter: proc_filter.o
+	cc proc_filter.o -o proc_filter
+
+proc_filter.o: proc_filter.c
+	cc -c proc_filter.c -o proc_filter.o $(CFLAGS)
+
+thread: thread.o thread_filter.o
+	cc thread.o thread_filter.o -o thread
+
+thread.o: thread.c $(DEPS)
+		cc -c thread.c -o thread.o $(CFLAGS)
+
+thread_filter.o: thread_filter.c
+		cc -c thread_filter.c -o thread_filter.o $(CFLAGS)
+
+define EXTRA_CLEAN
+	rm *.o thread
+endef
+
 TEST_GEN_PROGS = proc_filter
 
 include ../lib.mk
diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
index 4a825b997666..32a655f95c7f 100644
--- a/tools/testing/selftests/connector/proc_filter.c
+++ b/tools/testing/selftests/connector/proc_filter.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
 
 #include <sys/types.h>
 #include <sys/epoll.h>
@@ -28,6 +33,7 @@
 volatile static int interrupted;
 static int nl_sock, ret_errno, tcount;
 static struct epoll_event evn;
+FILE *file;
 
 static int filter;
 
@@ -37,6 +43,8 @@ static int filter;
 #define Printf ksft_print_msg
 #endif
 
+#define EXIT_LOG
+
 int send_message(void *pinp)
 {
 	char buff[NL_MESSAGE_SIZE];
@@ -146,58 +154,65 @@ int handle_packet(char *buff, int fd, struct proc_event *event)
 		tcount++;
 		switch (event->what) {
 		case PROC_EVENT_EXIT:
-			Printf("Exit process %d (tgid %d) with code %d, signal %d\n",
+#ifdef EXIT_LOG
+			fprintf(file, "pid %d tgid %d code %d\n",
+				event->event_data.exit.process_pid,
+				event->event_data.exit.process_tgid,
+				event->event_data.exit.exit_code);
+#else
+			Printf("Exit pid %d (tgid %d) exitcode %d, signal %d\n",
 			       event->event_data.exit.process_pid,
 			       event->event_data.exit.process_tgid,
 			       event->event_data.exit.exit_code,
 			       event->event_data.exit.exit_signal);
+#endif
 			break;
 		case PROC_EVENT_FORK:
-			Printf("Fork process %d (tgid %d), parent %d (tgid %d)\n",
+			Printf("Fork pid %d (tgid %d), parent %d (tgid %d)\n",
 			       event->event_data.fork.child_pid,
 			       event->event_data.fork.child_tgid,
 			       event->event_data.fork.parent_pid,
 			       event->event_data.fork.parent_tgid);
 			break;
 		case PROC_EVENT_EXEC:
-			Printf("Exec process %d (tgid %d)\n",
+			Printf("Exec pid %d (tgid %d)\n",
 			       event->event_data.exec.process_pid,
 			       event->event_data.exec.process_tgid);
 			break;
 		case PROC_EVENT_UID:
-			Printf("UID process %d (tgid %d) uid %d euid %d\n",
+			Printf("UID pid %d (tgid %d) uid %d euid %d\n",
 			       event->event_data.id.process_pid,
 			       event->event_data.id.process_tgid,
 			       event->event_data.id.r.ruid,
 			       event->event_data.id.e.euid);
 			break;
 		case PROC_EVENT_GID:
-			Printf("GID process %d (tgid %d) gid %d egid %d\n",
+			Printf("GID pid %d (tgid %d) gid %d egid %d\n",
 			       event->event_data.id.process_pid,
 			       event->event_data.id.process_tgid,
 			       event->event_data.id.r.rgid,
 			       event->event_data.id.e.egid);
 			break;
 		case PROC_EVENT_SID:
-			Printf("SID process %d (tgid %d)\n",
+			Printf("SID pid %d (tgid %d)\n",
 			       event->event_data.sid.process_pid,
 			       event->event_data.sid.process_tgid);
 			break;
 		case PROC_EVENT_PTRACE:
-			Printf("Ptrace process %d (tgid %d), Tracer %d (tgid %d)\n",
+			Printf("Ptrace pid %d (tgid %d), Tracer %d (tgid %d)\n",
 			       event->event_data.ptrace.process_pid,
 			       event->event_data.ptrace.process_tgid,
 			       event->event_data.ptrace.tracer_pid,
 			       event->event_data.ptrace.tracer_tgid);
 			break;
 		case PROC_EVENT_COMM:
-			Printf("Comm process %d (tgid %d) comm %s\n",
+			Printf("Comm pid %d (tgid %d) comm %s\n",
 			       event->event_data.comm.process_pid,
 			       event->event_data.comm.process_tgid,
 			       event->event_data.comm.comm);
 			break;
 		case PROC_EVENT_COREDUMP:
-			Printf("Coredump process %d (tgid %d) parent %d, (tgid %d)\n",
+			Printf("Coredump pid %d (tgid %d) parent %d, (tgid %d)\n",
 			       event->event_data.coredump.process_pid,
 			       event->event_data.coredump.process_tgid,
 			       event->event_data.coredump.parent_pid,
@@ -263,10 +278,11 @@ int main(int argc, char *argv[])
 	if (filter) {
 		input.event_type = PROC_EVENT_NONZERO_EXIT;
 		input.mcast_op = PROC_CN_MCAST_LISTEN;
-		err = register_proc_netlink(&epoll_fd, (void*)&input);
+		err = register_proc_netlink(&epoll_fd, (void *)&input);
 	} else {
 		enum proc_cn_mcast_op op = PROC_CN_MCAST_LISTEN;
-		err = register_proc_netlink(&epoll_fd, (void*)&op);
+
+		err = register_proc_netlink(&epoll_fd, (void *)&op);
 	}
 
 	if (err < 0) {
@@ -279,31 +295,40 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+#ifdef EXIT_LOG
+	file = fopen("exit.log", "w");
+	if (!file) {
+		perror("Error opening file exit.log");
+		close(nl_sock);
+		close(epoll_fd);
+		exit(1);
+	}
+#endif
+
 	while (!interrupted) {
 		err = handle_events(epoll_fd, &proc_ev);
 		if (err < 0) {
 			if (ret_errno == EINTR)
 				continue;
-			if (err == -2)
-				close(nl_sock);
-			if (err == -3) {
-				close(nl_sock);
-				close(epoll_fd);
-			}
+			close(nl_sock);
+			close(epoll_fd);
+			fclose(file);
 			exit(1);
 		}
 	}
 
 	if (filter) {
 		input.mcast_op = PROC_CN_MCAST_IGNORE;
-		send_message((void*)&input);
+		send_message((void *)&input);
 	} else {
 		enum proc_cn_mcast_op op = PROC_CN_MCAST_IGNORE;
-		send_message((void*)&op);
+
+		send_message((void *)&op);
 	}
 
 	close(epoll_fd);
 	close(nl_sock);
+	fclose(file);
 
 	printf("Done total count: %d\n", tcount);
 	exit(0);
diff --git a/tools/testing/selftests/connector/thread.c b/tools/testing/selftests/connector/thread.c
new file mode 100644
index 000000000000..0c12f8e9f1e1
--- /dev/null
+++ b/tools/testing/selftests/connector/thread.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
+
+#include <pthread.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+
+/*
+ * This code tests a thread exit notification when thread exits abnormally.
+ * Normally, when a thread exits abnormally, the kernel is not aware of the
+ * exit code. This is usually only conveyed from child to parent via the
+ * pthread_exit() and pthread_join() calls. Sometimes, however, a parent
+ * process cannot monitor all child processes via pthread_join(), particularly
+ * when there is a huge amount of child processes. In this case, the parent
+ * has created the child with PTHREAD_CREATE_DETACHED attribute.
+ * To fix this problem, either when child wants to convey non-zero exit via
+ * pthread_exit() or in a signal handler, the child can notify the kernel's
+ * connector module it's exit status via a netlink call with new type
+ * PROC_CN_MCAST_NOTIFY. (Implemented in the thread_filter.c file).
+ * This will send the exit code from the child to the kernel, which the kernel
+ * can later return to proc_filter program when the child actually exits.
+ * Compile:
+ *	make thread
+ *	make proc_filter
+ * Run:
+ *	./threads
+ */
+
+extern int notify_netlink_thread_exit(unsigned int exit_code);
+
+static void sigsegvh(int sig)
+{
+	unsigned int exit_code = (unsigned int)sig;
+	/*
+	 * Send any non-zero value to get a notification. Here we are
+	 * sending the signal number for SIGSEGV which is 11
+	 */
+	notify_netlink_thread_exit(exit_code);
+}
+
+void *threadc1(void *ptr)
+{
+	signal(SIGSEGV, sigsegvh);
+
+	*(int *)ptr = gettid();
+
+	printf("Child 1 thread id %d, handling SIGSEGV\n", gettid());
+	sleep(10);
+	pthread_exit(NULL);
+}
+
+void *threadc2(void *ptr)
+{
+	int exit_val = 1;
+
+	*(int *)ptr = gettid();
+
+	printf("Child 2 thread id %d, wants to exit with value %d\n",
+	       gettid(), exit_val);
+	sleep(2);
+	notify_netlink_thread_exit(exit_val);
+	pthread_exit(NULL);
+}
+
+static void verify_exit_status(int tid1, int tid2)
+{
+	int found1 = 0, found2 = 0;
+	int pid, tgid, exit_code;
+	size_t size = 1024;
+	FILE *file;
+	char *data;
+	int ret;
+
+	data = malloc(size * sizeof(char));
+	if (!data) {
+		perror("malloc for data failed");
+		exit(1);
+	}
+
+	file = fopen("exit.log", "r");
+	if (!file) {
+		perror("fopen of exit.log failed");
+		free(data);
+		exit(1);
+	}
+
+	while (getline(&data, &size, file) != -1) {
+		ret = sscanf(data, "pid %d tgid %d code %d",
+			     &pid, &tgid, &exit_code);
+		if (ret != 3) {
+			perror("sscanf error in exit.log");
+			free(data);
+			fclose(file);
+			exit(1);
+		}
+
+		if (tgid != getpid())
+			continue;
+
+		if (pid == tid1) {
+			if (exit_code == 11) {
+				printf("Success: notify of SIGSEGV, tid %d\n",
+				       pid);
+			} else {
+				printf("Failure SIGSEGV tid %d, exit code %d\n",
+				       pid, exit_code);
+			}
+			found1 = 1;
+		} else if (pid == tid2) {
+			if (exit_code == 1) {
+				printf("Success: notify thread exit tid %d\n",
+				       pid);
+			} else {
+				printf("Failure thread exit tid %d, exit code %d\n",
+				       pid, exit_code);
+			}
+			found2 = 1;
+		}
+	}
+
+	if (!found1)
+		printf("tid %d not present in exit.log file\n", tid1);
+
+	if (!found2)
+		printf("tid %d not present in exit.log file\n", tid2);
+
+	fclose(file);
+	free(data);
+}
+
+static void init_threads(pthread_attr_t *attr)
+{
+	int ret;
+
+	ret = pthread_attr_init(attr);
+	if (ret != 0) {
+		perror("pthread_attr_init failed");
+		exit(1);
+	}
+
+	ret = pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED);
+	if (ret != 0) {
+		perror("pthread_attr_setdetachstate failed");
+		exit(1);
+	}
+}
+
+static void destroy_thread_attr(pthread_attr_t *attr)
+{
+	int ret;
+
+	ret = pthread_attr_destroy(attr);
+	if (ret != 0)
+		perror("pthread_attr_destroy failed");
+}
+
+static pid_t start_proc_filter(void)
+{
+	pid_t proc_filter = 0;
+
+	proc_filter = fork();
+	if (proc_filter == -1) {
+		perror("fork() failed");
+		exit(1);
+	}
+
+	if (proc_filter == 0) {
+		static char * const arr[] = {"proc_filter", "-f", NULL};
+		int ret = execv("./proc_filter", arr);
+
+		if (ret == -1) {
+			perror("execv() of proc_filter failed");
+			exit(1);
+		}
+	}
+	sleep(1);
+	return proc_filter;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t thread1, thread2;
+	pthread_attr_t attr1, attr2;
+	int tid1, tid2, ret;
+	pid_t proc_filter_pid;
+
+	proc_filter_pid = start_proc_filter();
+
+	init_threads(&attr1);
+	ret = pthread_create(&thread1, &attr1, *threadc1, &tid1);
+	if (ret != 0) {
+		perror("pthread_create failed");
+		exit(1);
+	}
+
+	init_threads(&attr2);
+	ret = pthread_create(&thread2, &attr2, *threadc2, &tid2);
+	if (ret != 0) {
+		perror("pthread_create failed");
+		exit(1);
+	}
+
+	sleep(1);
+
+	/* Send SIGSEGV to tid1 */
+	ret = kill(tid1, SIGSEGV);
+	if (ret == -1)
+		perror("kill SIGSEGV failed");
+
+	/*
+	 * Wait for children to exit or be killed and for exit.log to
+	 * be generated by ./proc_filter
+	 */
+	sleep(2);
+
+	/*
+	 * Kill proc_filter to get exit.log
+	 */
+	ret = kill(proc_filter_pid, SIGINT);
+	if (ret == -1)
+		perror("kill to proc_filter failed");
+
+	/* Required to allow kill to be processed */
+	sleep(1);
+
+	verify_exit_status(tid1, tid2);
+
+	destroy_thread_attr(&attr1);
+	destroy_thread_attr(&attr2);
+
+	exit(0);
+}
diff --git a/tools/testing/selftests/connector/thread_filter.c b/tools/testing/selftests/connector/thread_filter.c
new file mode 100644
index 000000000000..3da740aa7537
--- /dev/null
+++ b/tools/testing/selftests/connector/thread_filter.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
+
+#include <sys/types.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/connector.h>
+#include <linux/cn_proc.h>
+
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <strings.h>
+#include <errno.h>
+#include <signal.h>
+#include <string.h>
+
+#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
+			sizeof(struct proc_input))
+
+/*
+ * Send PROC_CN_MCAST_NOTIFY type notification to the connector code in kernel.
+ * This will send the exit_code specified by user to the connector layer, so
+ * it can send a notification for that event to any listening process
+ */
+int send_message(int nl_sock, unsigned int exit_code)
+{
+	char buff[NL_MESSAGE_SIZE];
+	struct nlmsghdr *hdr;
+	struct cn_msg *msg;
+
+	hdr = (struct nlmsghdr *)buff;
+	hdr->nlmsg_len = NL_MESSAGE_SIZE;
+	hdr->nlmsg_type = NLMSG_DONE;
+	hdr->nlmsg_flags = 0;
+	hdr->nlmsg_seq = 0;
+	hdr->nlmsg_pid = getpid();
+
+	msg = (struct cn_msg *)NLMSG_DATA(hdr);
+	msg->id.idx = CN_IDX_PROC;
+	msg->id.val = CN_VAL_PROC;
+	msg->seq = 0;
+	msg->ack = 0;
+	msg->flags = 0;
+
+	msg->len = sizeof(struct proc_input);
+	((struct proc_input *)msg->data)->mcast_op =
+		PROC_CN_MCAST_NOTIFY;
+	((struct proc_input *)msg->data)->uexit_code = exit_code;
+
+	if (send(nl_sock, hdr, hdr->nlmsg_len, 0) == -1) {
+		perror("send failed");
+		return -errno;
+	}
+	return 0;
+}
+
+int notify_netlink_thread_exit(unsigned int exit_code)
+{
+	struct sockaddr_nl sa_nl;
+	int err = 0;
+	int nl_sock;
+
+	nl_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
+
+	if (nl_sock == -1) {
+		perror("socket failed");
+		return -errno;
+	}
+
+	bzero(&sa_nl, sizeof(sa_nl));
+	sa_nl.nl_family = AF_NETLINK;
+	sa_nl.nl_groups = CN_IDX_PROC;
+	sa_nl.nl_pid    = gettid();
+
+	if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) == -1) {
+		perror("bind failed");
+		close(nl_sock);
+		return -errno;
+	}
+
+	err = send_message(nl_sock, exit_code);
+
+	close(nl_sock);
+
+	if (err < 0)
+		return err;
+
+	return 0;
+}
-- 
2.46.0


