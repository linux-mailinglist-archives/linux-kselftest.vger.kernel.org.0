Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF195A8BD2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 05:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiIADMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 23:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIADMt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 23:12:49 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23276E0FCF;
        Wed, 31 Aug 2022 20:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662001966; i=@fujitsu.com;
        bh=gRE098PkcHPISQhG0n3dSistvwz8mSiByFzFWDopfIA=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Wyc2fJ72tsCAe0zxi1C81w+dz7wwkj7vRES+2Ov0UEQHNvu8JECOs0j0wQ2CvP3GP
         XaHC1h4yXoMcKKPewZWqbyAR5D1Wnnd5q54krcZuWzXOOTaM1QFIeaWD/HVGP0ToNS
         0j+xXNIsjj0SeF0suA4w6gZBG2QZs8srApvAnUYMh+8ddJn7MO+37xyswMkKV81xcf
         vaafz1sq3xT6US6z3ngb1Lcb051ijSy7tHRMCBYfIFr8ILz6csWUXRGnN9yusQi0mh
         K7TfonwcuQm7k4GIqA+V5G1nLkO34MujY4/0DjZlil2bJ0AEgZwYbpKQv9Hn3pjUKG
         xu5uettmXLJag==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRWlGSWpSXmKPExsViZ8ORpKunLJB
  s8H8zh8Xrw58YLS7vmsNmMf3OezaLKS/XsTuweGxa1cnm8XmTXABTFGtmXlJ+RQJrxqOD+1gK
  lvNWLG95wNjA+JS7i5GTQ0hgI6NE39bYLkYuIHspk8TypV1sEM5RRonVk5cygVSxCWhI3Gu5y
  QhiiwgESBy+dRzMZhZwk9j0ZjY7iC0sYCGxfP5vZhCbRUBFYvu9VqA4BwevgKPE3AtgyyQEFC
  SmPHwPVsIrIChxcuYTFogxEhIHX7xghqhRlDjS+ZcFwq6UaP3wC8pWk7h6bhPzBEb+WUjaZyF
  pX8DItIrRKqkoMz2jJDcxM0fX0MBA19DQVNfYUtfCSC+xSjdRL7VUtzy1uEQXyC0v1kstLtYr
  rsxNzknRy0st2cQIDNyUYvWgHYzfVvzUO8QoycGkJMpbsZg/WYgvKT+lMiOxOCO+qDQntfgQo
  wwHh5IEL7OSQLKQYFFqempFWmYOMIpg0hIcPEoivE8UgdK8xQWJucWZ6RCpU4yKUuK8ziB9Ai
  CJjNI8uDZY5F5ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzLADKFJzOvBG76K6DFTECLp8/
  kB1lckoiQkmpg0n5YPO+gfGfi/o8VcS3fPv2PLdredtfi87zoW6LL9eZE8vB13WHcmxvKlfry
  WWhJ9IMG4y2OH9/2T74Y5Hhiwhzei2dsOnnOdMdb+AVP/7NNdqJWUfDflni/mbIPLm1v/9qqL
  1oV+Fv+QOB+JX+JgBV/WGJ0wpKzGk7wPz5U81i42m/iyluM+yS9dsbN/eLDFaSz17k5Y87OZy
  1Pc/KPXJLTOLpvcsz98uR5fqka02aF7dP1eXZeY57op4xXX3ynTFO+eCO6Nuzn+fNzzI5/uP8
  1ivXagbXrGCfGuZ9Q2alne9nk160ncz3nMnv5qzU4RCze2yDhF+1xvOFZaev8wxwLanvX++y6
  9EbL786jfUosxRmJhlrMRcWJAJDpob9XAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-16.tower-548.messagelabs.com!1662001965!19513!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7853 invoked from network); 1 Sep 2022 03:12:46 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-16.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2022 03:12:46 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id CF5B51AC;
        Thu,  1 Sep 2022 04:12:45 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id C32491AB;
        Thu,  1 Sep 2022 04:12:45 +0100 (BST)
Received: from c7a0de451e1c.g08.fujitsu.local (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 1 Sep 2022 04:12:43 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <brauner@kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] selftests: pidfd: Fix compling warnings
Date:   Thu, 1 Sep 2022 03:11:48 +0000
Message-ID: <1662001908-6-1-git-send-email-lizhijian@fujitsu.com>
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

Fix warnings and enable Wall

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
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
index c3e2a3041f55..2dee6223112c 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -148,7 +148,7 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
 
 TEST(wait_nonblock)
 {
-	int pidfd, status = 0;
+	int pidfd = 0;
 	unsigned int flags = 0;
 	pid_t parent_tid = -1;
 	struct clone_args args = {
-- 
1.8.3.1

