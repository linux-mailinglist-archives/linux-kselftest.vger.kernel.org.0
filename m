Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0E57A933
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiGSVpj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiGSVp0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:26 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C0B3F58B;
        Tue, 19 Jul 2022 14:45:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj4NQ002582;
        Tue, 19 Jul 2022 23:45:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 02/17] tools/nolibc: fix build warning in sys_mmap() when my_syscall6 is not defined
Date:   Tue, 19 Jul 2022 23:44:33 +0200
Message-Id: <20220719214449.2520-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We return -ENOSYS when there's no syscall6() operation, but we must cast
it to void* to avoid a warning.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 08491070387b..b8c96878c9ce 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -692,7 +692,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 {
 #ifndef my_syscall6
 	/* Function not implemented. */
-	return -ENOSYS;
+	return (void *)-ENOSYS;
 #else
 
 	int n;
-- 
2.17.5

