Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4D5A8BCB
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 05:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIADLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIADLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 23:11:43 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A010A632;
        Wed, 31 Aug 2022 20:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662001895; i=@fujitsu.com;
        bh=AHPZvJazFd1q87YaF+oOE/CDLh9RAqlmX9L7CcYBVwY=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=GQIS20UmeaAXxyXF+CLkPX0X1EDJme6AUEJL3UzB6/1GQw6Mv9+0ypYS6HZqXfujV
         cQYW6c4zHkQsffaDbO5YyTlk/FKAUCApXg6VDlD98Z9IVTXu/WNsXLtAS239/b52rY
         5yYRgo0MGhTAhafVDuaF1iCjPwIHxro5I+YHozVGz7Lm9W7hPa1eCsb30MZTGPTrxx
         SBLPsVtpt+Akst1NWrFimUF1a5JeT93JK9SAr8G9d4GHQDJKxs5zSkJaeXobJKr/tE
         9jZ5QRtbw/BVTu1qPx9JErNqlBSrtQb8+nkR4bcl4VcEQoNgBHBVcg5SGOMhsy2R7D
         ha/6/ZoZ8GxiA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsViZ8ORpPtMSSD
  ZYNJiCYvXhz8xWlzeNYfNYvqd92wWlw5dZLKY8nIduwOrx+I9L5k8Nq3qZPP4vEkugDmKNTMv
  Kb8igTVj9vbDjAXvRCr+TT7H2sDYLtjFyMUhJLCRUeLSh3csEM5SJomLs69AOUcZJfbs6GDtY
  uTkYBPQkLjXcpMRxBYRCJA4fOs4mM0skCWxs/kdkM3BISwQJHF8UzxImEVAReJn10k2EJtXwF
  Hiyt9v7CC2hICCxJSH75kh4oISJ2c+YYEYIyFx8MULZogaRYkjnX9ZIOxKidYPv6BsNYmr5zY
  xT2Dkn4WkfRaS9gWMTKsYbZOKMtMzSnITM3N0DQ0MdA0NTYG0sa6RoZleYpVuol5qqW5eflFJ
  hq6hXmJ5sV5qcbFecWVuck6KXl5qySZGYFCnFKff2MG4a98vvUOMkhxMSqK8FYv5k4X4kvJTK
  jMSizPii0pzUosPMcpwcChJ8DID40RIsCg1PbUiLTMHGGEwaQkOHiUR3ieKQGne4oLE3OLMdI
  jUKUZdjoO79u9lFmLJy89LlRLnzVUAKhIAKcoozYMbAYv2S4yyUsK8jAwMDEI8BalFuZklqPK
  vGMU5GJWEeRlALuHJzCuB2/QK6AgmoCOmz+QHOaIkESEl1cDEyPfy59q3j7bZ7ry/WuZY1EcF
  uyPe7SJ3NaX2HVq2/2xbWdKJKCbHXKct0/glfTqVsvv72xa8PeX6dD9PJtNdceaW4m832vUM4
  /YG/1d+6rJfxfq4cl7F5Tdf3p54rXq9VF8olmfH8h/hYrcnxkZ8WlvxUDBz7q9Pp9ZPMlvKHC
  rw8XPlZoPb9ouVVnPVxE09cH+Xb2i8pKSUh/m/LrlFdpwV0x3mB/wrqL3Ze9j13bnZe0IUV3H
  vvJN4/fgpvqCcO2FbnFZ+OxYqFv3rWvjmB+tc1di9DCq1b68o2GuZq3XVduXTpQ+5hWoLCgrC
  OI81fQl6MP1trfbKs5Vt9s+kfVfL63Q+Vrp/8P/e3DgOJZbijERDLeai4kQArxgR5HEDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-3.tower-728.messagelabs.com!1662001893!143285!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5747 invoked from network); 1 Sep 2022 03:11:34 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2022 03:11:34 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id BEF681AD;
        Thu,  1 Sep 2022 04:11:33 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id B35121AC;
        Thu,  1 Sep 2022 04:11:33 +0100 (BST)
Received: from fd75cb8233c6.g08.fujitsu.local (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 1 Sep 2022 04:11:30 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <brauner@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>,
        "Philip Li" <philip.li@intel.com>
Subject: [PATCH v3] ksefltests: pidfd: Fix wait_states: Test terminated by timeout
Date:   Thu, 1 Sep 2022 03:10:07 +0000
Message-ID: <1662001807-7-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

0Day/LKP observed that the kselftest blocks forever since one of the
pidfd_wait doesn't terminate in 1 of 30 runs. After digging into
the source, we found that it blocks at:
ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);

wait_states has below testing flow:
  CHILD                 PARENT
  ---------------+--------------
1 STOP itself
2                   WAIT for CHILD STOPPED
3                   SIGNAL CHILD to CONT
4 CONT
5 STOP itself
5'                  WAIT for CHILD CONT
6                   WAIT for CHILD STOPPED

The problem is that the kernel cannot ensure the order of 5 and 5', once
5 goes first, the test will fail.

we can reproduce it by:
$ while true; do make run_tests -C pidfd; done

Introduce a blocking read in child process to make sure the parent can
check its WCONTINUED.

CC: Philip Li <philip.li@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
I have almost forgotten this patch since the former version post over 6 months
ago. This time I just do a rebase and update the comments.
V3: fixes description and add review tag
V2: rewrite with pipe to avoid usleep
---
 tools/testing/selftests/pidfd/pidfd_wait.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 070c1c876df1..c3e2a3041f55 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -95,20 +95,28 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
 		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
 		.exit_signal = SIGCHLD,
 	};
+	int pfd[2];
 	pid_t pid;
 	siginfo_t info = {
 		.si_signo = 0,
 	};
 
+	ASSERT_EQ(pipe(pfd), 0);
 	pid = sys_clone3(&args);
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
+		char buf[2];
+
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
@@ -117,6 +125,8 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
 	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
 
 	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
+	ASSERT_EQ(write(pfd[1], "C", 1), 1);
+	close(pfd[1]);
 	ASSERT_EQ(info.si_signo, SIGCHLD);
 	ASSERT_EQ(info.si_code, CLD_CONTINUED);
 	ASSERT_EQ(info.si_pid, parent_tid);
-- 
1.8.3.1

