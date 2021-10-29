Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158DC43F509
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhJ2Csk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 22:48:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36610 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231348AbhJ2Csk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 22:48:40 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ABbYIda6dl5SnsBefJGzXIAxRtIXFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS3jFRyWsfXD3QPKncYjPze94kYdi28U1V78XUyd81SAQ5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+KmWLa?=
 =?us-ascii?q?fUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/h1ycdNtJ6xQ?=
 =?us-ascii?q?AEBMLDOmfgGTl9TFCQW0ahuoeaZfCbv4JLJp6HBWz62qxl0N2kyIJEf0u9yCGp?=
 =?us-ascii?q?H7f0EITRLaB2f78q9wKi6UfVtj8ILJtPiIYUSoDdhylnxDvsrWpvERKbi7t9C2?=
 =?us-ascii?q?zIxm8UIGuzRD+IGYDZHZxTaZBhOJ1JRD4gx9M+whnj7ciUerFO9pKwr7myVxwt?=
 =?us-ascii?q?0uJD2MMfcevSJSN9Tk0LeoXjJl0z9AxcHJJmcxCCD/3aEmODCh2X4VZgUGbn+8?=
 =?us-ascii?q?eRl6HWXx2oOGFgVTla/r+W0kVKWRd1SMQoX9zAooKx081akJuQR9TXQTGWs50Z?=
 =?us-ascii?q?aAoQPVbZhrlzl90Yd2C7BbkBsc9KLQIZOWBcKeAEX?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AL3fi0KPjkuFVAcBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="116568962"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Oct 2021 10:46:10 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 78C084D0D9D7;
        Fri, 29 Oct 2021 10:46:06 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 29 Oct 2021 10:46:06 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 29 Oct 2021 10:45:45 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Philip Li <philip.li@intel.com>,
        yang xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH 1/2] kselftest: signal all child processes
Date:   Fri, 29 Oct 2021 10:45:27 +0800
Message-ID: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-yoursite-MailScanner-ID: 78C084D0D9D7.A108C
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

CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Will Drewry <wad@chromium.org>
CC: Shuah Khan <shuah@kernel.org>
CC: Christian Brauner <christian@brauner.io>
CC: Philip Li <philip.li@intel.com>
Suggested-by: yang xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
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



