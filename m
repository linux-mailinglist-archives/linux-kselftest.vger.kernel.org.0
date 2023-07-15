Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047FF754AA2
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGOSW1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOSW1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:22:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD726AF;
        Sat, 15 Jul 2023 11:22:25 -0700 (PDT)
X-QQ-mid: bizesmtp85t1689445336th79xll2
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:22:15 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: 3M0okmaRx3gatoYt99Gz1/q2kqkvuelsEDwFaEoa/fIfIzbezdNVYl44zta39
        +9Mkt5CDuGi7yZ2m+8kVUsmZP8VMJ0/DmOyIYYpPxkVO9/aT+kX2HsKFBNC99J10jtCJveT
        gPL0WetTKuh/GQl32ai0hVWemT2PKcVdhPF2/jW7NWScK8L+h6JZc3GJqFnGkq2WfvTfKgT
        XEuEP8rxflfmz9NzLbWr76sGy8V5AOA5PvHr8ANLqFP7ASLvcFPe1hhfoX1CmC1t9uT3ygM
        bP+b3SLYe5CQjg718rL7Vns/jDSkHUl1JjpMkOIfvN7cY0pfYA4uw7jqbl8NtzWDPtxphJM
        SwqCVseIyJjVKIrX8W9yomICM+q7Yh+eNbzP/oL6YKGWhb6sDx8q8yJumfhXQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11069775468019924728
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 05/18] tools/nolibc: stackprotector.h: add empty __stack_chk_init for !_NOLIBC_STACKPROTECTOR
Date:   Sun, 16 Jul 2023 02:22:15 +0800
Message-Id: <dd9ac1e061084703d006f0e7dafc4d08ba8d8e52.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's define an empty __stack_chk_init for the !_NOLIBC_STACKPROTECTOR
branch.

This allows to remove #ifdef around every call of __stack_chk_init().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/stackprotector.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 88f7b2d098ff..b620f2b9578d 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -45,6 +45,8 @@ void __stack_chk_init(void)
 	if (__stack_chk_guard != (uintptr_t) &__stack_chk_guard)
 		__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
+#else /* !defined(_NOLIBC_STACKPROTECTOR) */
+__inline__ void __stack_chk_init(void) {}
 #endif /* defined(_NOLIBC_STACKPROTECTOR) */
 
 #endif /* _NOLIBC_STACKPROTECTOR_H */
-- 
2.25.1

