Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3594738433
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjFUM7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFUM7l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:59:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F326FAC;
        Wed, 21 Jun 2023 05:59:38 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687352369te3lj68z
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 20:59:28 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: xwvWJGGFd7Pp39HRCTQYRbgJy3bbvGHQ7WlZR48+2RLviBp/41ZiQ96oKRZr/
        SilZzV0NenGnJQOAoEBB0FsmiBH7+SiFV9oelPczpDc5Rv6vON7sAY8uZqZwSd+t40quVga
        UlD5ndGNbGYHcYN65235Szzzn+W3uQJbRs+cM5+xVrvNtkhz8C96FkkUB4g30N+3iiIrT18
        IQ6Ef+55Bvl/Wb4QA6h+fvhx0tjuE67lIQ90/3id1+HCtIisliMmEsk8Ug9bqvYo0ghVbrP
        B7xN3wcVi695bHsw5s8IapJuwl+GKCEXCNiaucghBROurHs1Z2GS5Y9guTFLTImqjkXOMkJ
        m22jHKU242jcgYr6CLmUguUae2HlOWvJPWimeF9ZtAi9dq0bot3TJaA2a7Ar64D7EGcWIyU
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18004566144104333474
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 05/17] selftests/nolibc: stat_timestamps: remove procfs dependency
Date:   Wed, 21 Jun 2023 20:58:58 +0800
Message-Id: <5f80f3dae60f77c6b746578113e56c8fa6454143.1687344643.git.falcon@tinylab.org>
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

Since it is not really necessary to use /proc/self here, instead of
adding a condition check, we use the always existing '/' path instead of
/proc/self, this eventually let it work without procfs.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index ebec948ec808..2ef44176f7a9 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -520,7 +520,7 @@ static int test_stat_timestamps(void)
 	if (sizeof(st.st_atim.tv_sec) != sizeof(st.st_atime))
 		return 1;
 
-	if (stat("/proc/self/", &st))
+	if (stat("/", &st))
 		return 1;
 
 	if (st.st_atim.tv_sec != st.st_atime || st.st_atim.tv_nsec > 1000000000)
-- 
2.25.1


