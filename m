Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B93738471
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjFUNIc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFUNIc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:08:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55EE57;
        Wed, 21 Jun 2023 06:08:30 -0700 (PDT)
X-QQ-mid: bizesmtp74t1687352900ty2iclwn
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:08:19 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: vLOCICHxEeC+4y1LTp+BiY9j8PpHb9Dt4Sg+2rc6l1HNUYeypb+ihBW6wVf8X
        m3rnjZGltsHYRsXmYIEH4Duj+y+zjsGILWk6dG3qMZSHnTR2MZBPXV/uK+QrWjw6JKn3c6e
        11uXzBQUetno3Oz5sOQOKjopaXxRuKdOJoJAZpcEi5jB2Ky11wn3+qmKmg0siaHFhdQLrwc
        kvsgbIYm9WAi2jb3JO6uKkXGfDl9rjnm6KDgT2rmWf15xPyiAeUoVbsdXb4Ct7CeLaD5gi9
        ZgyBeXosAzEXjz0dFjGsZowL/nBGYCVTdCmp4yb9c5oINcMKSbIO7XXIdM2rgY3A1lrhQ3s
        uSk2mU613pLEaVHuJwCBogk6fZv8twRDHJv8MXuaYOPIKziv07HAzterzG6vA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16746959025053847439
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 11/17] selftests/nolibc: prepare tmpfs and hugetlbfs
Date:   Wed, 21 Jun 2023 21:07:22 +0800
Message-Id: <604d011aab4b7ec3734685ce9f1a163771a2c9d4.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's make the /tmp and /hugetlb directories and mount tmpfs and
hugetlbfs respectively, they will be used to check the existing of tmpfs
and hugetlbfs.

We will also use tmpfs to let some test cases run without procfs.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 69f59a395746..8b587961e46a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -935,6 +935,18 @@ int prepare(void)
 		}
 	}
 
+	/* try to mount /tmp if not mounted. Silently fail otherwise */
+	if (stat("/tmp/.", &stat_buf) == 0 || mkdir("/tmp", 0755) == 0) {
+		if (mount("none", "/tmp", "tmpfs", 0, 0) != 0)
+			rmdir("/tmp");
+	}
+
+	/* try to mount /hugetlb if not mounted. Silently fail otherwise */
+	if (stat("/hugetlb/.", &stat_buf) == 0 || mkdir("/hugetlb", 0755) == 0) {
+		if (mount("none", "/hugetlb", "hugetlbfs", 0, 0) != 0)
+			rmdir("/hugetlb");
+	}
+
 	return 0;
 }
 
-- 
2.25.1

