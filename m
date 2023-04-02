Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51866D39AF
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDBSEq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjDBSEq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:04:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623EF4EFD;
        Sun,  2 Apr 2023 11:04:45 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680458683;
        bh=WpL7AHZ/RVZDepQeqXUZNCLzamt9+Jfw6eToN9dbdkk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=t29kOegeu0yrjhaRhphXka1AJv8dp1R6T2UEglYfOBN5JIXWo3Q9SJmFcsDsQDEuF
         ooA+XcAvMvDprzbZF2KpELe5PRjtm3CXdd5KEvRW7A5cA7YGmbXm7Zabfr/Q7DeTSE
         PtrRZlfDJhJVKYc1GLhbgqLHm44AkBndUkXM/ots=
Date:   Sun, 02 Apr 2023 18:04:35 +0000
Subject: [PATCH v3 2/4] tools/nolibc: add wrapper for memfd_create
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v3-2-ddc79f92efd5@weissschuh.net>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680458682; l=1058;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WpL7AHZ/RVZDepQeqXUZNCLzamt9+Jfw6eToN9dbdkk=;
 b=SWX0F2lLJt4IidEUS718+TFzjJz9Pt8aypgXLOk79aZ2l1abVew2uqgb+bV2rFVC2NcVhXha6
 dIhXOgzygv9DKZ6qqz/3ByATgmcR1k5WdkEEHId4zEFV6yOHIK3/v3H
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is useful for users and will also be used by a future testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5d624dc63a42..bea9760dbd16 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1365,6 +1365,29 @@ ssize_t write(int fd, const void *buf, size_t count)
 	return ret;
 }
 
+
+/*
+ * int memfd_create(const char *name, unsigned int flags);
+ */
+
+static __attribute__((unused))
+int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return my_syscall2(__NR_memfd_create, name, flags);
+}
+
+static __attribute__((unused))
+int memfd_create(const char *name, unsigned int flags)
+{
+	ssize_t ret = sys_memfd_create(name, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 

-- 
2.40.0

