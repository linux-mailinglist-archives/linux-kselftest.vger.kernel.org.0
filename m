Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F476E166
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjHCH3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjHCH2z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F262728;
        Thu,  3 Aug 2023 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=kVg+ddk4XYFgD37LXo7XQQcjwPOqCjh3CHvqXQamr2w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cAcoN1BX1ObfWjGCv6phvqKsfpgbnBqk3tMnlbPkdGwu2L4QFCpSdIQGLLSQYKubB
         Ul8HB8cJUY8ph5VEBod4gpZGyybH2UN4b87Ya3o3Fhhe2xrFMvALRdtcKv34VtR1lA
         I862uwOf/t2a8Pmlvyioq6rGxHahJFj1mSBpuDy4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:57 +0200
Subject: [PATCH v3 13/14] selftests/nolibc: don't strip nolibc-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-13-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kVg+ddk4XYFgD37LXo7XQQcjwPOqCjh3CHvqXQamr2w=;
 b=me8m7eaLVGWZI/dUtccVBUgYv/VDWJvY1LHvNTScpcUJGo0yI/YQWu4XEiTZ6NCI4kRNfYs19
 a2t59EVbMxwCGLQIcj21Hy1TW7EoZMInqcHd0nDCRNq580DBCUi/nuV
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Binary size is not important for nolibc-test and some debugging
information is nice to have, so don't strip the binary during linking.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f42adef87e12..b82d29b6c37f 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -82,7 +82,7 @@ CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
 		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
-LDFLAGS := -s
+LDFLAGS :=
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \

-- 
2.41.0

