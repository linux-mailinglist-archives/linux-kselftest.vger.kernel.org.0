Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019127214E1
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 07:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjFDFmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 01:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDFmi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 01:42:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD412D2;
        Sat,  3 Jun 2023 22:42:36 -0700 (PDT)
X-QQ-mid: bizesmtp72t1685857346t5xr8sni
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Jun 2023 13:42:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: Z2qCHCq1/922HOu2rI3BNb7YZnwq6I3XqG+zETTdRX5VsVqTCcaEqWdJ/xe8Z
        nyxTVuLQd3K6s8lYS4Qgz4f0pv/WAO12sNEiy+9qWHlqo5jTMfgKcP3i63dAjba4Dysgloc
        Hm16xIq/C730s527UMkx8tR+oOeoz8YIinChVkV78frR33mszF+YhAzfvGGCSRQCtbSb+oX
        nTj+SzN5TCXcn7OkkJ7nFrXv8+dJu0PtIN+2aAgwVhP6Xbn9tAX2inmqu5dwvjx8K3jpeu7
        0p4Ag9EspgteAHAvgrqlXocbra5y+qJmTRonXAqsZ9yN9VUhbtHOxVgUYE+6tbxM7kaeCse
        8i67iyDZsITzvq1dype13lr1sYOAUfVG0VWOX3FbPOzygs8+PuFSEA//QvLKw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5104637929055565147
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 3/4] tools/nolibc: sys.h: apply __syscall_ret() helper
Date:   Sun,  4 Jun 2023 13:39:03 +0800
Message-Id: <b2a0ee856a62f2757e2d1c5c51b3c330be8a0df3.1685856497.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685856497.git.falcon@tinylab.org>
References: <cover.1685856497.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use __syscall_ret() helper to shrink the code lines of brk() and
getpagesize(), 10 lines removed.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 937a8578e3d4..976f23d1fdad 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -81,13 +81,9 @@ void *sys_brk(void *addr)
 static __attribute__((unused))
 int brk(void *addr)
 {
-	void *ret = sys_brk(addr);
+	int ret = sys_brk(addr) ? 0 : -ENOMEM;
 
-	if (!ret) {
-		SET_ERRNO(ENOMEM);
-		return -1;
-	}
-	return 0;
+	return __syscall_ret(ret);
 }
 
 static __attribute__((unused))
@@ -550,15 +546,9 @@ static unsigned long getauxval(unsigned long key);
 static __attribute__((unused))
 long getpagesize(void)
 {
-	long ret;
+	long ret = getauxval(AT_PAGESZ) ?: -ENOENT;
 
-	ret = getauxval(AT_PAGESZ);
-	if (!ret) {
-		SET_ERRNO(ENOENT);
-		return -1;
-	}
-
-	return ret;
+	return __syscall_ret(ret);
 }
 
 
-- 
2.25.1

