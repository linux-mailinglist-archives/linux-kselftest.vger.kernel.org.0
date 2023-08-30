Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96EB78D32E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbjH3GMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 02:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbjH3GMS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 02:12:18 -0400
X-Greylist: delayed 187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 23:12:12 PDT
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1EBBCCB;
        Tue, 29 Aug 2023 23:12:12 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee664eedcfb838-f1cb1;
        Wed, 30 Aug 2023 14:08:59 +0800 (CST)
X-RM-TRANSID: 2ee664eedcfb838-f1cb1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea64eedcfad0a-0607d;
        Wed, 30 Aug 2023 14:08:59 +0800 (CST)
X-RM-TRANSID: 2eea64eedcfad0a-0607d
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     shuah@kernel.org, mic@digikod.net
Cc:     linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/landlock: Fix a resource leak
Date:   Wed, 30 Aug 2023 14:08:58 +0800
Message-Id: <20230830060858.2841-1-dingxiang@cmss.chinamobile.com>
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
 tools/testing/selftests/landlock/fs_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 83d565569512..687a66ea9799 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -124,13 +124,17 @@ static bool supports_filesystem(const char *const filesystem)
 		return true;
 
 	/* filesystem can be null for bind mounts. */
-	if (!filesystem)
+	if (!filesystem) {
+		fclose(inf);
 		return true;
+	}
 
 	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
-	if (len >= sizeof(str))
+	if (len >= sizeof(str)) {
+		fclose(inf);
 		/* Ignores too-long filesystem names. */
 		return true;
+	}
 
 	res = fgrep(inf, str);
 	fclose(inf);
-- 
2.38.1



