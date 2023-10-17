Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086CA7CB871
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 04:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjJQCdt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 22:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjJQCdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 22:33:49 -0400
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA2DE6;
        Mon, 16 Oct 2023 19:33:43 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9652df2866ea-04f45;
        Tue, 17 Oct 2023 10:33:42 +0800 (CST)
X-RM-TRANSID: 2ee9652df2866ea-04f45
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[223.108.79.101])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6652df284b30-35be4;
        Tue, 17 Oct 2023 10:33:41 +0800 (CST)
X-RM-TRANSID: 2ee6652df284b30-35be4
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/efivarfs: create-read: fix a resource leak
Date:   Mon, 16 Oct 2023 19:33:35 -0700
Message-Id: <20231017023335.7874-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The opened file should be closed in main(), otherwise resource
leak will occur

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/efivarfs/create-read.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
index 9674a1939..6812104a5 100644
--- a/tools/testing/selftests/efivarfs/create-read.c
+++ b/tools/testing/selftests/efivarfs/create-read.c
@@ -32,8 +32,11 @@ int main(int argc, char **argv)
 	rc = read(fd, buf, sizeof(buf));
 	if (rc != 0) {
 		fprintf(stderr, "Reading a new var should return EOF\n");
+		close(fd);
 		return EXIT_FAILURE;
 	}
 
+	close(fd);
+
 	return EXIT_SUCCESS;
 }
-- 
2.17.1



