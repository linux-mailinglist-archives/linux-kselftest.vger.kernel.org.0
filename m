Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BF58D94B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiHINVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiHINVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 09:21:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB433270A;
        Tue,  9 Aug 2022 06:20:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:861:4a40:8620:d901:c525:a85f:2da3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 146FF6601C45;
        Tue,  9 Aug 2022 14:20:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660051258;
        bh=IRRAMUEUPxNXQ73JNz6LTxgshzzauiZ5jk1N1jdJQNk=;
        h=From:To:Cc:Subject:Date:From;
        b=ZbWIrGOcD4FwA0rzsff8Ft3NU2YDbX1+dx6DbnBlSvS+cNPwtaf+EdFYKCTwuwXIS
         OVuIgBOmgWe194wf0m3BInrxWEFzwZEfAfPeyzgkWz/oZdObqH52DwwcyJgNcb1p/l
         Fez/zGZrgD2Fae0+vEExqEo/eyN6Iy7MhQzKLbhlWm/qyr+rlJWF1fz99h4RmmW2Ol
         lJaD2w0vMi3TtU6Y9IIMLeOTJU86KQc0yncP6Mdt5ZMNb4x8sp+a0DhsVkW3cJ+Kd1
         UPwnwxGsBOgr0Yan6SOiKzKdEoMRygULcHL8AANYB1tIrhfFHFVHMSzYjwXnsnb5U7
         zJwqxK2v3pTDg==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] selftests: add missing ')' in lib.mk
Date:   Tue,  9 Aug 2022 15:20:46 +0200
Message-Id: <7de08f7f11551d6b8195c3e5d801db2fae3f49a9.1660048017.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add missing closing ')' in lib.mk in a call to $error().  This only
affects LLVM / Clang builds.

Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 947fc72413e9..a87f60873e5b 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,7 +20,7 @@ CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
 
 ifeq ($(CROSS_COMPILE),)
 ifeq ($(CLANG_TARGET_FLAGS),)
-$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
 else
 CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
 endif # CLANG_TARGET_FLAGS
-- 
2.30.2

