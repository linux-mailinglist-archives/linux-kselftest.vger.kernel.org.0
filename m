Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62236121FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ2Jq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ2Jq6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 05:46:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB919284;
        Sat, 29 Oct 2022 02:46:57 -0700 (PDT)
X-QQ-mid: bizesmtp62t1667036809t7njbpzb
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Oct 2022 17:46:44 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: D6RqbDSxuq6cl7v6+jiUzOwsMIqLKR3vyxMmJUI7LbiJuMEO0xzlTsP1JQPEv
        mWGLT9H0GslUYISo6RVuqOdBRtSdgzbRohNS30tbt4OyKxbV9EfU6alLVINk0cLS8AJGNOW
        +Arn+7QyDYlpZVfoAVtkUTNmZxcUE3EtuYHGr0hQ5GOW+GoBKWzF3j+iiDu65AYSxkOQe4q
        KvZeWyhgtxzfuCwK+jvoM6o4fW2RnflgwDHuUGAloPtyAQvJ3wQystrdiBVj8rpHrPJkSg4
        +LlFUfq2SegkwOPF85ah5YGbpKywZJE7wVUkALHXVb2a8k6BKAkMXhKmLbfA0/dvMYgv3mG
        gLjEbywiQoUNZAoTfgxK8eBED3C+c0Rr/4l2TieDCXskIqa8YGW2/DoD7zxPQ==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     shuah@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] selftests/powerpc: Remove repeated word in comments
Date:   Sat, 29 Oct 2022 05:46:43 -0400
Message-Id: <20221029094643.5595-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the repeated word "not" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/testing/selftests/powerpc/include/pkeys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
index 3312cb1b058d..51729d9a7111 100644
--- a/tools/testing/selftests/powerpc/include/pkeys.h
+++ b/tools/testing/selftests/powerpc/include/pkeys.h
@@ -24,7 +24,7 @@
 #undef PKEY_DISABLE_EXECUTE
 #define PKEY_DISABLE_EXECUTE	0x4
 
-/* Older versions of libc do not not define this */
+/* Older versions of libc do not define this */
 #ifndef SEGV_PKUERR
 #define SEGV_PKUERR	4
 #endif
-- 
2.35.1

