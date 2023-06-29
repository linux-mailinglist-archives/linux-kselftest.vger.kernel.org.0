Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652D574315A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjF2Xxo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjF2Xxo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:53:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85236C3;
        Thu, 29 Jun 2023 16:53:42 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688082813tkl23r8i
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:53:32 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: SdugMSrl+IPAzXWq+rfJBOyleIPNwAJP1BnWuXjvrOgozUJpjkblZ040nbM0V
        4nYGY8mJHgC1InPwQxd66pwy39Ncw2l3U1VAq3Exy6G8vo5XDg/2ht6XP8d2wYbESG8lrA6
        uSJqxqrWSrWxsAY9JcffJxCcyO/dpYdQlb2N693wOs2t5z86w3JMJ8vj+nz0kd9q//1DQ8J
        hb5IppBq9Qot4Koo5KkS9x/7oaCb7FcZSgJWBZgfggO/5UtJe4z7N1DEwSHWJRlQH3Pnp66
        xuXtRV+1rRqBOREkItMdGFJck4pnjXpgCWm16Kf4OnQKi4lWcuXEFWuZCnvYnlrKCI2nEwz
        rOVbx8w+ne0rx0ByPHIAwpoVVvs5XdhaNvbMK5Phj+Itt1nE1g1sv9pbnY75g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11952200826971950609
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 11/15] selftests/nolibc: prepare /tmp for tmpfs or ramfs
Date:   Fri, 30 Jun 2023 07:52:03 +0800
Message-Id: <9dc032064dde254a03e2111da1e58344deca6522.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's create a /tmp directory and mount tmpfs there, if tmpfs is not
mountable, use ramfs as tmpfs.

tmpfs will be used instead of procfs for some tests.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c0f5302ada5d..8e3e2792f5e3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1054,6 +1054,10 @@ int prepare(void)
 		}
 	}
 
+	/* try to mount /tmp if not mounted, if not mountable, use ramfs as tmpfs */
+	if (stat("/tmp/.", &stat_buf) == 0 || mkdir("/tmp", 0755) == 0)
+		mount("none", "/tmp", "tmpfs", 0, 0);
+
 	return 0;
 }
 
-- 
2.25.1

