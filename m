Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53036723B1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjFFIQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjFFIQm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:16:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B6C7;
        Tue,  6 Jun 2023 01:16:40 -0700 (PDT)
X-QQ-mid: bizesmtp79t1686039390t3zfjj1g
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 16:16:29 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: fs34Pe/+C2RtSKmKHJC+wIdHChvPdDuUHsW0Y/Oc0Nqkrgol9/YGblT2gCBGq
        cvnFZ34Cj87k/IclwMobyHylf5h+9fQkW9ILGGrAdoTKg0xnOYEGdZTtIiQcKOkVrx0jmAW
        JY4DnauTC17PygPFGcUxAME9czb9I8yE/6Wi/RpF+fIioznqAMNklXe4n/XNMPvwtBZKLsK
        HzdqGH1uJ98z7dPX4MSq8KVirLCEXk/O6EymZycq6APbFhLTe8UpChE8PlruhQIr6z4joi7
        6L5DhdOHvTng5Ie0eOs6uxPs3durFfFDDHs9nZ7BbNDrXrjSylG6VdHuvnnaAv8JLU6EW8j
        Jdv+XKibESyIOVUM2iaxHOmMGHW7CDYGQu68zuWQxmkQJlFiWVlD0YaJJQT2w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14987419174521382926
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/4] tools/nolibc: sys.h: apply __sysret() helper
Date:   Tue,  6 Jun 2023 16:16:12 +0800
Message-Id: <20039f63dbbb54889c310196e909469ace5e503e.1686036862.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686036862.git.falcon@tinylab.org>
References: <cover.1686036862.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use __sysret() to shrink both brk() and getpagesize() to oneline code.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index c12c14db056e..f6e3168b3e50 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -78,13 +78,7 @@ void *sys_brk(void *addr)
 static __attribute__((unused))
 int brk(void *addr)
 {
-	void *ret = sys_brk(addr);
-
-	if (!ret) {
-		SET_ERRNO(ENOMEM);
-		return -1;
-	}
-	return 0;
+	return __sysret(sys_brk(addr) ? 0 : -ENOMEM);
 }
 
 static __attribute__((unused))
@@ -547,15 +541,7 @@ static unsigned long getauxval(unsigned long key);
 static __attribute__((unused))
 long getpagesize(void)
 {
-	long ret;
-
-	ret = getauxval(AT_PAGESZ);
-	if (!ret) {
-		SET_ERRNO(ENOENT);
-		return -1;
-	}
-
-	return ret;
+	return __sysret(getauxval(AT_PAGESZ) ?: -ENOENT);
 }
 
 
-- 
2.25.1

