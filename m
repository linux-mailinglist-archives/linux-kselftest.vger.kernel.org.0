Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D64BAB58
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 21:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiBQU5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 15:57:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiBQU5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 15:57:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB90245AC;
        Thu, 17 Feb 2022 12:57:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id A09521F46304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645131422;
        bh=HVDGGUKsKqIe9BO+dcKa/W+YmBbvLNbYJGuS3cf5tY8=;
        h=From:To:Cc:Subject:Date:From;
        b=D05Qs7dtvxBGd6jZ4EUAfV+5DDT9S6mxthr1WgUlgMtsy8y0zZkHIenNjD1PZUz/I
         o53M+dy2+8RPxyGzEVWLlw7TNqkzJQ3ga+BGBCaawcRS7aQWnGxQOBcZZ+ugch1+LH
         o5xWcOnleTOfI0cceVFLQMidx8J4sEK/35bUy4UwpgM1ZNomsEAQUZhrQWjCU3AZWJ
         6zG+Ld2UFjTXz+Id47FeMA0gXS4Ok4r7CPVSUkSCdkzqWOOk4SOwPbuIGLPxbIYOsm
         ToDrfXeW7QQ8722EjJkCtzeud2MAhBSTDwTCjYBuI8s00W10sXaCiLZal4FAxoSthY
         5sPalScD/YjVA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/lkdtm: add config and turn off CFI_FORWARD_PROTO
Date:   Fri, 18 Feb 2022 01:56:19 +0500
Message-Id: <20220217205620.2512094-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add config options which are needed for LKDTM sub-tests.
STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
INIT_ON_FREE_DEFAULT_ON config.

CFI_FORWARD_PROTO always fails as there is no active CFI system of some
kind. Turn it off for now by default until proper support.

Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lkdtm/config    | 2 ++
 tools/testing/selftests/lkdtm/tests.txt | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 46f39ee762086..adc9fa60057c5 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -2,8 +2,10 @@ CONFIG_LKDTM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_FORTIFY_SOURCE=y
+CONFIG_GCC_PLUGIN_STACKLEAK=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
+CONFIG_INIT_ON_FREE_DEFAULT_ON=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 6b36b7f5dcf96..aa947b0ce1eeb 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -72,7 +72,7 @@ USERCOPY_STACK_FRAME_FROM
 USERCOPY_STACK_BEYOND
 USERCOPY_KERNEL
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
-CFI_FORWARD_PROTO
+#CFI_FORWARD_PROTO
 FORTIFIED_STRSCPY
 FORTIFIED_OBJECT
 FORTIFIED_SUBOBJECT
-- 
2.30.2

