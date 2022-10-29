Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666366121F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ2JnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2JnN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 05:43:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109D6B66C;
        Sat, 29 Oct 2022 02:43:11 -0700 (PDT)
X-QQ-mid: bizesmtp66t1667036587tg7cbmf7
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Oct 2022 17:41:15 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: sGFX8uE0VW66RDIgYMwQFdW4kZha3S8decUxcsX3rWpl96dd+VsEL0WNRN8us
        MYqDrM2nAlPqfkfe5fbS218Zk8h06cJrmgDqjT+j0lgpMsdCneRYpDQXA8zSQN9cqrv4wCV
        amUku0tnXuxgYkCr070bM/lf0HtR+4L7Wt4RB4yS2YA4k1MtNkJzJVpqKrxVpUWqPDDI9DF
        Z14lqkyk4IrIg+DaLChyzK9EaoSciYlgRDQIqHnBBBPFsTh8tlI+39ns1wyD/0MZChWZXZn
        94gwyNCf+wzCRbYs383tozcdubZlcLqNwodwgsvDNBuJIsfQrxk03EdLRmX59DLlY6mSA4f
        hyJMjqBjc/E0jBXX7Jjc8HSZ3e8npDJlXsa79fZ
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] selftests/core: Fix double word in close_range_test.c
Date:   Sat, 29 Oct 2022 05:41:14 -0400
Message-Id: <20221029094114.4011-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the repeated word "and" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 749239930ca8..4db5ec73d016 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -476,7 +476,7 @@ TEST(close_range_cloexec_unshare_syzbot)
 
 	/*
 	 * Create a huge gap in the fd table. When we now call
-	 * CLOSE_RANGE_UNSHARE with a shared fd table and and with ~0U as upper
+	 * CLOSE_RANGE_UNSHARE with a shared fd table and with ~0U as upper
 	 * bound the kernel will only copy up to fd1 file descriptors into the
 	 * new fd table. If the kernel is buggy and doesn't handle
 	 * CLOSE_RANGE_CLOEXEC correctly it will not have copied all file
-- 
2.35.1

