Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67DB6C1A48
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjCTPu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjCTPtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:47 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4078A77;
        Mon, 20 Mar 2023 08:41:24 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326881;
        bh=8+nQaJm+ZpSS5pDVDYI8Ih7aP+obiBBNskXrcuawcY4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VdYuP7uYCUpZyRNirukTM8/cDEaFkpqBlXmt2CKnGfoSb+HKuGYOax1JiCSV2ZDdt
         LbJkixmmNM134m39O+raBfqHfuG3c9Hj2n8LdjunxEFlpwBFEN48z5HfW4SjPpLL7X
         oHx1Qg7jnXszNuARoiFN+CyCpfAa384ZtFERU0y0=
Date:   Mon, 20 Mar 2023 15:41:05 +0000
Subject: [PATCH v2 5/8] tools/nolibc: tests: fold in no-stack-protector
 cflags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-5-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326878; l=987;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8+nQaJm+ZpSS5pDVDYI8Ih7aP+obiBBNskXrcuawcY4=;
 b=TaXGkzUL3xHCtunu6pxuTjT6Der+r4LEofS5YgQayMdk3NgAUO2r6DsVBZrRzelmREo9bB9L1
 nrNsis9gLYgDvKhmE0MsrOgYVZe3KOKZ1ROVCIsjF6flvn6rD3033hm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For the cflags to enable stack protectors to work properly they need to
be specified after -fno-stack-protector.

To do this fold all cflags into a single variable and move
-fno-stack-protector before the arch-specific cflags.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index c99bbcda7495..236c0364f5fb 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -77,8 +77,9 @@ Q=@
 endif
 
 CFLAGS_s390 = -m64
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables $(CFLAGS_$(ARCH))
-CFLAGS  += $(call cc-option,-fno-stack-protector)
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
+		$(call cc-option,-fno-stack-protector) \
+		$(CFLAGS_$(ARCH))
 LDFLAGS := -s
 
 help:

-- 
2.40.0

