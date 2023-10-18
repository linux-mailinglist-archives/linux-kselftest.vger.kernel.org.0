Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4465C7CD212
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 03:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjJRB7q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 21:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRB7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 21:59:45 -0400
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BCE4C6;
        Tue, 17 Oct 2023 18:59:25 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1652f3bf940a-0bcd8;
        Wed, 18 Oct 2023 09:59:24 +0800 (CST)
X-RM-TRANSID: 2ee1652f3bf940a-0bcd8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6652f3bf9f61-4301e;
        Wed, 18 Oct 2023 09:59:23 +0800 (CST)
X-RM-TRANSID: 2ee6652f3bf9f61-4301e
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/efivarfs: create-read: fix a resource leak
Date:   Tue, 17 Oct 2023 18:59:21 -0700
Message-Id: <20231018015921.16890-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2a96e3a8-48a5-46ae-9a0c-b5f2def0a257@linuxfoundation.org>
References: <2a96e3a8-48a5-46ae-9a0c-b5f2def0a257@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by code reading

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/efivarfs/create-read.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
index 9674a1939..7bc7af4eb 100644
--- a/tools/testing/selftests/efivarfs/create-read.c
+++ b/tools/testing/selftests/efivarfs/create-read.c
@@ -32,8 +32,10 @@ int main(int argc, char **argv)
 	rc = read(fd, buf, sizeof(buf));
 	if (rc != 0) {
 		fprintf(stderr, "Reading a new var should return EOF\n");
+		close(fd);
 		return EXIT_FAILURE;
 	}
 
+	close(fd);
 	return EXIT_SUCCESS;
 }
-- 
2.17.1



