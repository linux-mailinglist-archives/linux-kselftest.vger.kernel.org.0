Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813378DBB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjH3ShY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbjH3KMJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 06:12:09 -0400
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 430AA1B0;
        Wed, 30 Aug 2023 03:12:02 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee864ef15e544e-f48f4;
        Wed, 30 Aug 2023 18:11:49 +0800 (CST)
X-RM-TRANSID: 2ee864ef15e544e-f48f4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee764ef15e4dc8-0b662;
        Wed, 30 Aug 2023 18:11:49 +0800 (CST)
X-RM-TRANSID: 2ee764ef15e4dc8-0b662
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     shuah@kernel.org, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] selftests/landlock: Fix a resource leak
Date:   Wed, 30 Aug 2023 18:11:48 +0800
Message-Id: <20230830101148.3738-1-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The opened file should be closed before return,
otherwise resource leak will occur

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 tools/testing/selftests/landlock/fs_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 83d565569512..251594306d40 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -113,7 +113,7 @@ static bool supports_filesystem(const char *const filesystem)
 {
 	char str[32];
 	int len;
-	bool res;
+	bool res = true;
 	FILE *const inf = fopen("/proc/filesystems", "r");
 
 	/*
@@ -125,14 +125,16 @@ static bool supports_filesystem(const char *const filesystem)
 
 	/* filesystem can be null for bind mounts. */
 	if (!filesystem)
-		return true;
+		goto out;
 
 	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
 	if (len >= sizeof(str))
 		/* Ignores too-long filesystem names. */
-		return true;
+		goto out;
 
 	res = fgrep(inf, str);
+
+out:
 	fclose(inf);
 	return res;
 }
-- 
2.38.1



