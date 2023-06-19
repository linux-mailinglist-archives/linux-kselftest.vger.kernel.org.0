Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1D735B74
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjFSPqZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFSPqY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:46:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBF183;
        Mon, 19 Jun 2023 08:46:23 -0700 (PDT)
X-QQ-mid: bizesmtp74t1687189569t7m7jpj5
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:46:08 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 6/K5pWSRdGohZNUvm+E+aBmN22HnnFyRXuRHvnGIbTDVz3MMHAcfAkZHut/22
        oBZEiw0bdSq3fdy8TZ1wLcWNbBv6BS5Qkib2Uf/E07s/XKnsvEdfPyIeyfdcmGQ6iaEekGP
        wdGVwIuoFAS/GmCNoaZGs0BE23z2/9ssANxofiDOaUMK8Q7LUyJZt3nZLNQ0BTE+xWG91mO
        1CqBoQCuXORCxllYiYYSKCPE9I3aJbD3ryi9WUUHv34iJKJthT6220tPZBmICcgArJqXJZb
        JaMq/mVg+AInXb433YehYBPwUtAehkvYfqnYiWAMbukF2h8Ph9i9NRvCK3jVSr7od41o5YK
        kjrCWk+7LIYzRIw/YRYGUaX+gcdvt1WqvCfNx7SdcYexpWQ7yYQ3liuAHlGfg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6480484968202464133
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 04/10] tools/nolibc: unistd.h: reorder the syscall macros
Date:   Mon, 19 Jun 2023 23:45:56 +0800
Message-Id: <1bd84b8adfa209f89a04e6beadb412385af7859b.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tune the macros in the using order and align most of them.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index fabc846f797b..e38f3660c051 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -56,9 +56,9 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
-#define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
-#define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
 #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
+#define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
+#define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
 #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
 #define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
 
-- 
2.25.1


