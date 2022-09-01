Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29295A8BDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 05:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiIADSs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIADSq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 23:18:46 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9410F968;
        Wed, 31 Aug 2022 20:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662002323; i=@fujitsu.com;
        bh=gXAleU1Y+7t4AQ3brMFh6K3hJ+fMT8YWkykGgaWNG8k=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=vDmyUwJf5O88jtcOVgvbbWZVtZNSRjp+3Ei3GZz294bsovfUgrMhMwxxug1Icc8qu
         FMohx5/FQhXuqckBVuDJ4mVqoixPxWdSDDs8ps9TL3utzdOWO9+PZeEFav8KcBoomW
         BdHhnxmjVV0Wr0sXn1fglY/43e77x0y89rylx3B7alIX19GuTxxSZ8y8bZOlmSXJwV
         gckX3WJkjXTuY28kgrFb5SB42nF7vg5C97gYXCAp4Ir+tzbGhSL63PDVkpQUAxAKO4
         b/C6b2/jTQMWeKZ6qf4eZ92kisZusgePL0/snM1jhURw37ap243LnKheOqBf76voKA
         +9UMD3wTiNMew==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRWlGSWpSXmKPExsViZ8ORqDtJRSD
  Z4NkZXYvXhz8xWlzeNYfNYvqd92wWU16uY3dg8di0qpPN4/MmuQCmKNbMvKT8igTWjPe9m5kL
  NghULL2zgamBcSlfFyMXh5DAFkaJtuVnWCCcFUwSSyc3M3UxcgI5RxkldjbVgthsAhoS91puM
  oLYIgIBEodvHQezmQXcJDa9mc0OYgsLWEv0zX8F1ssioCLRe2s9axcjBwevgKPEvDkSIGEJAQ
  WJKQ/fM4PYvAKCEidnPmGBGKMp0br9NzuELS/RvHU2M0S9osSRzr8sEHalROuHX1C2msTVc5u
  YJzAKzEIyahaSUbOQjFrAyLyK0TapKDM9oyQ3MTNH19DAQNfQ0BRIG+saGZrpJVbpJuqllurm
  5ReVZOga6iWWF+ulFhfrFVfmJuek6OWllmxiBIZ7SnH6jR2Mu/b90jvEKMnBpCTKW7GYP1mIL
  yk/pTIjsTgjvqg0J7X4EKMMB4eSBC+zkkCykGBRanpqRVpmDjD2YNISHDxKIrxPFIHSvMUFib
  nFmekQqVOMilLivM4gfQIgiYzSPLg2WLxfYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMywA
  yhSczrwRu+iugxUxAi6fP5AdZXJKIkJJqYOJ/vFVILGKywr+8D+abz65Z1Trjx49Llqw6p82u
  XpmdKvV7x9r6Rep7bx02rjkRYjildk1+ZdvthDDN6YEhO08mLy784n7kydlH+7Un30mWeV9+8
  KyFvcHfvytuXUvc8ujmvQeHH7O9es54uVvxXJ/JtG1mFt2pOX+mS5yd9GtqY+cW3h2z9/a2Wd
  ukPuw9YXCkX71l7bU1y7imn661jp7gtaNlx84fl3OnrFM5rLDDJJjn+87Xumb5G4t6nKvfXs3
  +oWlbw614S2rOJG+rA1UvGY66TKzcbPc1tlHV7VLI+/wbk7RnXp7pmn7++Fkl1amdp6w8Jm3M
  ZZj7/Wb23YLqZsnM7UzV9wpWmRyO++C0RomlOCPRUIu5qDgRAAQYtRpyAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-4.tower-745.messagelabs.com!1662002322!124070!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9392 invoked from network); 1 Sep 2022 03:18:42 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-4.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2022 03:18:42 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 232FD10018D;
        Thu,  1 Sep 2022 04:18:42 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 154A5100043;
        Thu,  1 Sep 2022 04:18:42 +0100 (BST)
Received: from 127ce6f590cf.g08.fujitsu.local (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 1 Sep 2022 04:18:39 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <brauner@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] selftests: pidfd: Fix compling warnings
Date:   Thu, 1 Sep 2022 03:17:34 +0000
Message-ID: <1662002254-7-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Fix warnings and enable Wall.

pidfd_wait.c: In function ‘wait_nonblock’:
pidfd_wait.c:150:13: warning: unused variable ‘status’ [-Wunused-variable]
  150 |  int pidfd, status = 0;
      |             ^~~~~~
...
pidfd_test.c: In function ‘child_poll_exec_test’:
pidfd_test.c:438:1: warning: no return statement in function returning non-void [-Wreturn-type]
  438 | }
      | ^

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
v2: fix mistake assignment to pidfd
---
 tools/testing/selftests/pidfd/Makefile     | 2 +-
 tools/testing/selftests/pidfd/pidfd_test.c | 2 ++
 tools/testing/selftests/pidfd/pidfd_wait.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index f4a2f28f926b..778b6cdc8aed 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g -I../../../../usr/include/ -pthread
+CFLAGS += -g -I../../../../usr/include/ -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9a2d64901d59..d36654265b7a 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -435,6 +435,8 @@ static int child_poll_exec_test(void *args)
 	 */
 	while (1)
 		sleep(1);
+
+	return 0;
 }
 
 static void test_pidfd_poll_exec(int use_waitpid)
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index c3e2a3041f55..0dcb8365ddc3 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -148,7 +148,7 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
 
 TEST(wait_nonblock)
 {
-	int pidfd, status = 0;
+	int pidfd;
 	unsigned int flags = 0;
 	pid_t parent_tid = -1;
 	struct clone_args args = {
-- 
1.8.3.1

