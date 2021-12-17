Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF6478714
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhLQJb2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 04:31:28 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41526 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232622AbhLQJb2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 04:31:28 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AGuB+5a+thdXOz+H1qMPzDrUDDHyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUok1GZWzDYZDWHUPv+MazOhLtskaYq+pkNV6sCGzNE3TFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/jRHOOjULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfoe6ffCfm4JD7I0ruNiGEL+9VJEo2J4wD5ud+B0l?=
 =?us-ascii?q?E7/UFLj0XKBGE78qyw6qTS+9wi8BlJ87uVKsHunBkzCmfCfcOQJbfTqGM7thdt?=
 =?us-ascii?q?B8rht1HHd7datAfZD4paw7PCzVLO1EKGNc9kf2ui33XbTJVshSWqLAx7myVyxZ?=
 =?us-ascii?q?+uJDpMdzIapmJXshRkFqVvX7u4Wv0GFcZOcaZxD7D9Wij7tIjNwuTtJk6TeX+r?=
 =?us-ascii?q?6A1xgbIgDF7NfHfbnPjydHRt6J0c4k3x5QoxxcT?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AasQOnaMyx+bo88BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="119057194"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Dec 2021 17:31:25 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 328484D13BDD;
        Fri, 17 Dec 2021 17:31:21 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 17 Dec 2021 17:31:22 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 17 Dec 2021 17:31:21 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <christian@brauner.io>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        "Li Zhijian" <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH v2] ksefltest: pidfd: Fix wait_states: Test terminated by timeout
Date:   Fri, 17 Dec 2021 17:30:40 +0800
Message-ID: <20211217093040.9530-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 328484D13BDD.AD311
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

0Day/LKP observed that the kselftest blocks foever since one of the
pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
the source, we found that it blocks at:
ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);

we can reproduce it by:
$ while true; do make run_tests -C pidfd; done

Introduce a blocking read in child process to make sure the parent can
check its WCONTINUED.

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: rewrite with pipe to avoid usleep
---
 tools/testing/selftests/pidfd/pidfd_wait.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index be2943f072f6..d5c0ffa26c32 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -96,21 +96,26 @@ TEST(wait_states)
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
 		.exit_signal = SIGCHLD,
 	};
-	int ret;
+	int ret, pfd[2];
 	pid_t pid;
 	siginfo_t info = {
 		.si_signo = 0,
 	};
-
+	ASSERT_EQ(pipe(pfd), 0);
 	pid = sys_clone3(&args);
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
+		char buf[2];
+		close(pfd[1]);
 		kill(getpid(), SIGSTOP);
+		ASSERT_EQ(read(pfd[0], buf, 1), 1);
+		close(pfd[0]);
 		kill(getpid(), SIGSTOP);
 		exit(EXIT_SUCCESS);
 	}
 
+	close(pfd[0]);
 	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_STOPPED);
@@ -119,6 +124,8 @@ TEST(wait_states)
 	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
 
 	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
+	ASSERT_EQ(write(pfd[1], "C", 1), 1);
+	close(pfd[1]);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_CONTINUED);
 	ASSERT_EQ(info.si_pid, parent_tid);
-- 
2.33.0



