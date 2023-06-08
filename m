Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C267281B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjFHNtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjFHNtK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 09:49:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5682C269F;
        Thu,  8 Jun 2023 06:49:07 -0700 (PDT)
X-QQ-mid: bizesmtp79t1686232141t0on9mbo
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Jun 2023 21:49:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: dKvkn8qoLrHX2kyqnrYho7cQbBc3aGmxlr88m80b30yXO7ydaIN30Hk6UCOwu
        8pWLVIoteFj+l4Yl+/kDBNG3taUKs8iJGnRQuqVmRb0YjALmUJOiwQOLdG7wlTCWRT1HFV4
        DMfGHyvUrkAoPFnLZec20GGYOmaRtg0CmNc5cQKPaipeQUPbqEaPe30phdt2F7/PdjCIqch
        BPSkKw48p10bXqY9TVX4qKHQ89cGTjimwv1kG1oXDxBEw0Fr0RA35N36VkhcILpAyGgRtym
        sqzYddNLz3Q7Xw98NrMYssRaEOVZ/N3z04nSouVFSEdRJKGWnVBbP2v6tjPTdPUFIHlXNB8
        req1FVCk5pKErNtF5SvLMf/58jUdSkp3JhNRE/zzKwKyhfR3Lo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16134034703996412553
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, paulmck@kernel.org,
        thomas@t-8ch.de
Subject: [PATCH 1/1] tools/nolibc: fix up typo _sycall_narg -> _syscall_narg
Date:   Thu,  8 Jun 2023 21:48:58 +0800
Message-Id: <64f663e9e024564a7baca6769394f1e7d5a0422c.1686230738.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686230738.git.falcon@tinylab.org>
References: <cover.1686230738.git.falcon@tinylab.org>
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

Fixes: 8e3ab529bef9 ("tools/nolibc/unistd: add syscall()")
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---

Hi, Willy

Since this may be ok for v6.5, so, directly based it on your
20230606-nolibc-rv32+stkp7a branch.

This may conflict with the reviewed series [1], if require, I can renew
that series too.

[1]: https://lore.kernel.org/linux-riscv/cover.1686135913.git.falcon@tinylab.org/

 tools/include/nolibc/unistd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index c20b2fbf065e..0e832e10a0b2 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -66,10 +66,10 @@ int tcsetpgrp(int fd, pid_t pid)
 	_ret;                                                                 \
 })
 
-#define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
+#define _syscall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
 #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
 #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
-#define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)
+#define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
 
 /* make sure to include all global symbols */
 #include "nolibc.h"
-- 
2.25.1

