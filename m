Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A103074B376
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjGGPA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 11:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGGPA0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 11:00:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241A1FE2;
        Fri,  7 Jul 2023 08:00:21 -0700 (PDT)
X-QQ-mid: bizesmtp66t1688742007tg949pqx
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 23:00:06 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: F7g8sXqc8jKUXva1LOQuC3l6Huh4naBPWG4uwtnPE08/V+nzmxJAVIlC+NW4t
        GJBwcqaJMlH3AHBqAX6F0hXsEzGUuQj2+Q74Sxs9xvMGzhsPQ8eXADWbmJu7pt7Lky2X+Dn
        rwIOhzzB6DGVdZwiOfFl5lZJ08gjw668dZcOO+UMASsBHylhSt++/1YjHCR3vYaC3Dn2Tzb
        KDzd/Nd7hf6waMdwYz/zlrhe8E0wZckFp/hFTCcxBjqi0gereXhOL1hY0gYQCPPqH03bkBG
        Q2laSXI34883bzQwno94VwwwNoAaTo+M3fnMzBk7X4MVaLuXhsDJRMxTxE7tfjoMeI169XX
        608IzYYMbWNlzFPOQYTjr4y2sxvNcIizzGf64Ldy+qNDqeSumMrewESt2diJw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1688201172120877824
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 08/15] tools/nolibc: clean up sbrk() routine
Date:   Fri,  7 Jul 2023 22:59:53 +0800
Message-Id: <ef8ebd7a5de89f9ac691c29412c6586cec1a413d.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix up the error reported by scripts/checkpatch.pl:

    ERROR: do not use assignment in if condition
    #95: FILE: tools/include/nolibc/sys.h:95:
    +	if ((ret = sys_brk(0)) && (sys_brk(ret + inc) == ret + inc))

Apply the new generic __sysret() to merge the SET_ERRNO() and return
lines.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 3d01a24e6f7a..61a3204b00d7 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -89,14 +89,13 @@ int brk(void *addr)
 static __attribute__((unused))
 void *sbrk(intptr_t inc)
 {
-	void *ret;
-
 	/* first call to find current end */
-	if ((ret = sys_brk(0)) && (sys_brk(ret + inc) == ret + inc))
+	void *ret = sys_brk(0);
+
+	if (ret && sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
 
-	SET_ERRNO(ENOMEM);
-	return (void *)-1;
+	return (void *)__sysret(-ENOMEM);
 }
 
 
-- 
2.25.1

