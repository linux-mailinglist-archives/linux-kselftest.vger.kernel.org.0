Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2403D8DCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhG1M3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:29:15 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53206 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234838AbhG1M3I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:29:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UhFXizk_1627475345;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UhFXizk_1627475345)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Jul 2021 20:29:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     shuah@kernel.org
Cc:     baolin.wang@linux.alibaba.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE flag
Date:   Wed, 28 Jul 2021 20:29:00 +0800
Message-Id: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running the openat2 test suite on ARM64 platform, we got below failure,
since the definition of the O_LARGEFILE is different on ARM64. So we can
set the correct O_LARGEFILE definition on ARM64 to fix this issue.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/openat2/openat2_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index d7ec1e7..1bddbe9 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -22,7 +22,11 @@
  * XXX: This is wrong on {mips, parisc, powerpc, sparc}.
  */
 #undef	O_LARGEFILE
+#ifdef __aarch64__
+#define	O_LARGEFILE 0x20000
+#else
 #define	O_LARGEFILE 0x8000
+#endif
 
 struct open_how_ext {
 	struct open_how inner;
-- 
1.8.3.1

