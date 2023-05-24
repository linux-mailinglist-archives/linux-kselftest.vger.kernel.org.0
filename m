Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA570FD56
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjEXR6y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXR6y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:58:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613098;
        Wed, 24 May 2023 10:58:52 -0700 (PDT)
X-QQ-mid: bizesmtp74t1684951127tibius57
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:58:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3j5XLeAsUaE/DkfZWFl5CmfKZrVp7OoqgrEw0wk0brdmyrXBI5zN
        NpWpiQQzR4ct/fvme1WqRNqVlEyVp0V3y4gZ4FVeqTORPQSaNUNIVU8zXT0xSs7UvR82pAU
        piv68CfZe0vXIJ/2ZF6hgetaWwXz2z51mbzLshvXJcW7SEUTAlpAm6OUnZxrq622N8BIfRE
        rDg0PT1ere6yY0p/7uVW7DoOggF8vXvKxIkzNa5uthRTIAHlaGXdikv0yyDo/nKhqjaY8wB
        xM8nuDYA1NVSgtnqjG5mLKnJKA5+CugBcPb4GxOb/Cf9R0iXc0GBZQyP2drBsZnEkynxhd2
        FNSa53ww7eKmKY/+W9ATQKkdLd8ZWHT7fLYAKgSZ0Xfzj1+35PgLCcy6Q4s3Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4532114979322601860
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 10/13] tools/nolibc: ppoll/ppoll_time64: add a missing argument
Date:   Thu, 25 May 2023 01:58:39 +0800
Message-Id: <cbcc4afca5f80aff6533ca4536cb12093cb65cb5.1684949268.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
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

The ppoll and ppoll_time64 syscalls have 5 arguments, but we only
provide 4, align with kernel and add the missing sigsetsize argument.

Because the sigmask is NULL, the last sigsetsize argument is ignored,
keep it as 0 here is safe enough.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 08d38175bd7b..c0335a84f880 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -935,7 +935,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_sec  = timeout / 1000;
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
-	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
+	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else
-- 
2.25.1

