Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15E61646D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKBOGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKBOGq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F012A88
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 07:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20BB4619BD
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 14:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6179C433C1;
        Wed,  2 Nov 2022 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667398004;
        bh=Gs2WzaQs0JxsNoAcVv8XLnhCqUt0Ak13pUF943Oy1/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ctQYAnLN9nvmmAR7F30W5wwal+kDaBxppDvA8Pp6cNkU6aukMfRG4LmbM5+6sgoI0
         knO6zarCz+/0Gj657VVzKf6MqMsdVkMpOG7jrC6Vs8PSmDhUwwRIEyp9nbeOgrkMAp
         O5+MI7gAGq0rHNqAjfwQFVA/qDI5miHN0XkjxBOB1G6gbpa2s2N4pIdTWi/EFNMwAY
         O4faR+6g+E92OBmlB0Pf9xjaURCF1Loqds5hVyF6zOLPES8EQGGzrdXVaN3qxLyNeX
         0AAnzDVVHf7q/URm74OAiDxJQDjcvxot7/CoYrau37kIf45uGLQgib15pLOlz+hruj
         f/0n7wZh+iKPA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] kselftest/arm64: Print ASCII version of unknown signal frame magic values
Date:   Wed,  2 Nov 2022 14:05:43 +0000
Message-Id: <20221102140543.98193-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=broonie@kernel.org; h=from:subject; bh=Gs2WzaQs0JxsNoAcVv8XLnhCqUt0Ak13pUF943Oy1/Y=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYnk2VaY9SxZ7CSAYl1xz1k30ogFJ8ZPXXlGv7rHc CYSaufaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2J5NgAKCRAk1otyXVSH0KoKB/ wMRK4DMH/XCRiIjE82sRJydc9vTo0koRkXfbKHTMTSrgVeBZsOZPgUdKznYgSblJ3FsPAucDzxAfZ+ 7bF4I/FmmsvAD8WByUYQxw/xP5h+sAod1PnZe+2xor/4Ak2VS34+N5xAjn430Rr30y/BOaZUQMfg+X 5tc0pvs1XlPbKboVVNm3dBFuDczL8XJWIbFjA15X+towPQ+CjQfxBzo+yPVY0iAP01qqBfokIr+HMl r8GuS8ItndzoeRA3HM+YNBONAcKJMEkjW9Amej9gTn1P8pqX8UFPh/19d1oHZAGhGLcIQxuBHC8QCE P0OQTOjPCJ78BJCyhQFCAZPTu/+Ppb
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The signal magic values are supposed to be allocated as somewhat meaningful
ASCII so if we encounter a bad magic value print the any alphanumeric
characters we find in it as well as the hex value to aid debuggability.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/testcases.c        | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index e1c625b20ac4..d2eda7b5de26 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2019 ARM Limited */
+
+#include <ctype.h>
+#include <string.h>
+
 #include "testcases.h"
 
 struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
@@ -109,7 +113,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 	bool terminated = false;
 	size_t offs = 0;
 	int flags = 0;
-	int new_flags;
+	int new_flags, i;
 	struct extra_context *extra = NULL;
 	struct sve_context *sve = NULL;
 	struct za_context *za = NULL;
@@ -117,6 +121,7 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
 	void *extra_data = NULL;
 	size_t extra_sz = 0;
+	char magic[4];
 
 	if (!err)
 		return false;
@@ -194,11 +199,19 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			/*
 			 * A still unknown Magic: potentially freshly added
 			 * to the Kernel code and still unknown to the
-			 * tests.
+			 * tests.  Magic numbers are supposed to be allocated
+			 * as somewhat meaningful ASCII strings so try to
+			 * print as such as well as the raw number.
 			 */
+			memcpy(magic, &head->magic, sizeof(magic));
+			for (i = 0; i < sizeof(magic); i++)
+				if (!isalnum(magic[i]))
+					magic[i] = '?';
+
 			fprintf(stdout,
-				"SKIP Unknown MAGIC: 0x%X - Is KSFT arm64/signal up to date ?\n",
-				head->magic);
+				"SKIP Unknown MAGIC: 0x%X (%c%c%c%c) - Is KSFT arm64/signal up to date ?\n",
+				head->magic,
+				magic[3], magic[2], magic[1], magic[0]);
 			break;
 		}
 

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.30.2

