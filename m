Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D413FE7C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 04:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbhIBCjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 22:39:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20166 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229679AbhIBCjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 22:39:45 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACnhFdqnc9qvsChO4108gGFt1/GDpDfLE3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV8sjzsiWE7Ar5OUtQ/uxoV5PhfZqxz/JICOoqTNKftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8kbFl9K1u50OT0EHMqyTMbFlt7eA3CCIV8Yn3MKc8L2lwcPX?=
 =?us-ascii?q?z3JWRwlsbK16hj0JczqzIwlnQhVcH5olGN657spDnTCpfnMadYCVHX8ANtKz3+?=
 =?us-ascii?q?Hjpdb3ZwIcHR475E2rhTOs0rTzFB+VxVM/flp0sNEfzVQ=3D?=
X-IronPort-AV: E=Sophos;i="5.84,371,1620662400"; 
   d="scan'208";a="113878573"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Sep 2021 10:38:46 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 548204D0D9DA;
        Thu,  2 Sep 2021 10:38:45 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Sep 2021 10:38:39 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Sep 2021 10:38:39 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <chris.hyser@oracle.com>, <peterz@infradead.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] kselftests/sched: cleanup the child processes
Date:   Thu, 2 Sep 2021 10:43:33 +0800
Message-ID: <20210902024333.75983-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 548204D0D9DA.AD129
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously, 'make -C sched run_tests' will block forever when it occurs
something wrong where the *selftests framework* is waiting for its child
processes to exit.

[root@iaas-rpma sched]# ./cs_prctl_test

 ## Create a thread/process/process group hiearchy
Not a core sched system
tid=74985, / tgid=74985 / pgid=74985: ffffffffffffffff
Not a core sched system
    tid=74986, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74988, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74989, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74990, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
    tid=74987, / tgid=74987 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74991, / tgid=74987 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74992, / tgid=74987 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74993, / tgid=74987 / pgid=74985: ffffffffffffffff

Not a core sched system
(268) FAILED: get_cs_cookie(0) == 0

 ## Set a cookie on entire process group
-1 = prctl(62, 1, 0, 2, 0)
core_sched create failed -- PGID: Invalid argument
(cs_prctl_test.c:272) -
[root@iaas-rpma sched]# ps
    PID TTY          TIME CMD
   4605 pts/2    00:00:00 bash
  74986 pts/2    00:00:00 cs_prctl_test
  74987 pts/2    00:00:00 cs_prctl_test
  74999 pts/2    00:00:00 ps

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 63fe6521c56d..1829383715c6 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -64,6 +64,17 @@ enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
 
 const int THREAD_CLONE_FLAGS = CLONE_THREAD | CLONE_SIGHAND | CLONE_FS | CLONE_VM | CLONE_FILES;
 
+struct child_args {
+	int num_threads;
+	int pfd[2];
+	int cpid;
+	int thr_tids[MAX_THREADS];
+};
+
+static struct child_args procs[MAX_PROCESSES];
+static int num_processes = 2;
+static int need_cleanup = 0;
+
 static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4,
 		  unsigned long arg5)
 {
@@ -80,8 +91,14 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
 #define handle_error(msg) __handle_error(__FILE__, __LINE__, msg)
 static void __handle_error(char *fn, int ln, char *msg)
 {
+	int pidx;
 	printf("(%s:%d) - ", fn, ln);
 	perror(msg);
+	if (need_cleanup) {
+		for (pidx = 0; pidx < num_processes; ++pidx)
+			kill(procs[pidx].cpid, 15);
+		need_cleanup = 0;
+	}
 	exit(EXIT_FAILURE);
 }
 
@@ -108,13 +125,6 @@ static unsigned long get_cs_cookie(int pid)
 	return cookie;
 }
 
-struct child_args {
-	int num_threads;
-	int pfd[2];
-	int cpid;
-	int thr_tids[MAX_THREADS];
-};
-
 static int child_func_thread(void __attribute__((unused))*arg)
 {
 	while (1)
@@ -214,10 +224,7 @@ void _validate(int line, int val, char *msg)
 
 int main(int argc, char *argv[])
 {
-	struct child_args procs[MAX_PROCESSES];
-
 	int keypress = 0;
-	int num_processes = 2;
 	int num_threads = 3;
 	int delay = 0;
 	int res = 0;
@@ -264,6 +271,7 @@ int main(int argc, char *argv[])
 
 	printf("\n## Create a thread/process/process group hiearchy\n");
 	create_processes(num_processes, num_threads, procs);
+	need_cleanup = 1;
 	disp_processes(num_processes, procs);
 	validate(get_cs_cookie(0) == 0);
 
-- 
2.31.1



