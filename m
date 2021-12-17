Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD61E478712
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhLQJav convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 04:30:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42936 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230497AbhLQJav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 04:30:51 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ajw9E5a9ry87+gneBHn9gDrUDxH+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoi0GcDy2ZKDDiGO/uPYGr0c4x/a4S0ox8B7JLUzdM3QVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/jRHOOjULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfoe6ffCfm75b7I0ruNiGEL+9VJEUrIYow8+N+Cmh?=
 =?us-ascii?q?W9OARLHYLYwzrr+m22rOgVuhlgOwpNsD2Oo4F/HBnpRnaAPs9SpfEQI3B5cVf2?=
 =?us-ascii?q?TYtg4ZJB/m2T9UQZRJkbA7HZhxSPxEQEp1WtPyom3D/Wz5VslSYoeww+We75Ad?=
 =?us-ascii?q?xyrn2LNvcfJqAX8xImEuCjn/M4mLlH1cRM9n34T6E9G+8w+zChyX2XKoMG7Cis?=
 =?us-ascii?q?P1nmluewioUEhJ+fV+6p+Spz02lVtZRN0EP5gIwoqUosk+mVN/wW1u/unHsg/K?=
 =?us-ascii?q?2c7K8CMVjsEfUlPWSuF3fWwA5ovd6QIROnKcLqfYCijdlR+/UOAE=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMiVVXaMf1ElnF8BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="119057162"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Dec 2021 17:30:49 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8AB7C4D146D7;
        Fri, 17 Dec 2021 17:30:45 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 17 Dec 2021 17:30:44 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 17 Dec 2021 17:30:46 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <keescook@chromium.org>, <luto@amacapital.net>, <shuah@kernel.org>,
        <christian@brauner.io>
CC:     <wad@chromium.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "yang xu" <xuyang2018.jy@cn.fujitsu.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2] kselftest: signal all child processes
Date:   Fri, 17 Dec 2021 17:29:55 +0800
Message-ID: <20211217092955.9472-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-yoursite-MailScanner-ID: 8AB7C4D146D7.A1546
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have some many cases that will create child process as well, such as
pidfd_wait. Previously, we will signal/kill the parent process when it
is time out, but this signal will not be sent to its child process. In
such case, if child process doesn't terminate itself, ksefltest framework
will hang forever.

below ps tree show the situation when ksefltest is blocking:
root      1172  0.0  0.0   5996  2500 ?        S    07:03   0:00  \_ /bin/bash /lkp/lkp/src/tests/kernel-selftests
root      1216  0.0  0.0   4392  1976 ?        S    07:03   0:00      \_ make run_tests -C pidfd
root      1218  0.0  0.0   2396  1652 ?        S    07:03   0:00          \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x86_64-rhel-8.
root     12491  0.0  0.0   2396   132 ?        S    07:03   0:00              \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x86_64-rhe
root     12492  0.0  0.0   2396   132 ?        S    07:03   0:00                  \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x86_64
root     12493  0.0  0.0   2396   132 ?        S    07:03   0:00                      \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x8
root     12496  0.0  0.0   2396   132 ?        S    07:03   0:00                          \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftest
root     12498  0.0  0.0  10564  6116 ?        S    07:03   0:00                              \_ perl /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/prefix.pl
root     12503  0.0  0.0   2452   112 ?        T    07:03   0:00 ./pidfd_wait
root     12621  0.0  0.0   2372  1600 ?        SLs  07:04   0:00 /usr/sbin/watchdog
root     19438  0.0  0.0    992    60 ?        Ss   07:39   0:00 /lkp/lkp/src/bin/event/wakeup activate-monitor

Here we group all its child processes so that kill() can signal all of
them in timeout.

Suggested-by: yang xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
V2: add acked tag
---
 tools/testing/selftests/kselftest_harness.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ae0f0f33b2a6..c7251396e7ee 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -875,7 +875,8 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	}
 
 	t->timed_out = true;
-	kill(t->pid, SIGKILL);
+	// signal process group
+	kill(-(t->pid), SIGKILL);
 }
 
 void __wait_for_test(struct __test_metadata *t)
@@ -985,6 +986,7 @@ void __run_test(struct __fixture_metadata *f,
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
 	} else if (t->pid == 0) {
+		setpgrp();
 		t->fn(t, variant);
 		if (t->skip)
 			_exit(255);
-- 
2.33.0



