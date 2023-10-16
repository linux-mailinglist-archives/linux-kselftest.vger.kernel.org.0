Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE427C9F93
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 08:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjJPGcZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjJPGcY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 02:32:24 -0400
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161ACDC;
        Sun, 15 Oct 2023 23:30:46 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7652cd892b73-ff3af;
        Mon, 16 Oct 2023 14:30:42 +0800 (CST)
X-RM-TRANSID: 2ee7652cd892b73-ff3af
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8652cd890ddd-29fd1;
        Mon, 16 Oct 2023 14:30:41 +0800 (CST)
X-RM-TRANSID: 2ee8652cd890ddd-29fd1
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests: net: remove unused variables
Date:   Sun, 15 Oct 2023 23:30:39 -0700
Message-Id: <20231016063039.3771-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These variables are never referenced in the code, just remove them

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c     | 1 -
 tools/testing/selftests/net/af_unix/test_unix_oob.c | 2 --
 tools/testing/selftests/net/nettest.c               | 5 +++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index a86222143..7e5345941 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -294,7 +294,6 @@ static void fill_sockaddr(struct sock_addr *addr, bool abstract)
 static void client(FIXTURE_DATA(scm_pidfd) *self,
 		   const FIXTURE_VARIANT(scm_pidfd) *variant)
 {
-	int err;
 	int cfd;
 	socklen_t len;
 	struct ucred peer_cred;
diff --git a/tools/testing/selftests/net/af_unix/test_unix_oob.c b/tools/testing/selftests/net/af_unix/test_unix_oob.c
index 532459a15..a7c51889a 100644
--- a/tools/testing/selftests/net/af_unix/test_unix_oob.c
+++ b/tools/testing/selftests/net/af_unix/test_unix_oob.c
@@ -180,9 +180,7 @@ main(int argc, char **argv)
 	char buf[1024];
 	int on = 0;
 	char oob;
-	int flags;
 	int atmark;
-	char *tmp_file;
 
 	lfd = socket(AF_UNIX, SOCK_STREAM, 0);
 	memset(&consumer_addr, 0, sizeof(consumer_addr));
diff --git a/tools/testing/selftests/net/nettest.c b/tools/testing/selftests/net/nettest.c
index 39a0e01f8..cd8a58097 100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -1864,8 +1864,9 @@ static char *random_msg(int len)
 		n += i;
 		len -= i;
 	}
-	i = snprintf(m + n, olen - n, "%.*s", len,
-		     "abcdefghijklmnopqrstuvwxyz");
+
+	snprintf(m + n, olen - n, "%.*s", len,
+	     "abcdefghijklmnopqrstuvwxyz");
 	return m;
 }
 
-- 
2.17.1



