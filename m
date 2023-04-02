Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C16D39B0
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjDBSEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDBSEq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:04:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756030F1;
        Sun,  2 Apr 2023 11:04:45 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680458683;
        bh=VdplZ+maLIRLoILvVLhk3/Dt0NnSp9+Gg5MHvNvgDRw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BXFkLPbAaMWSTu/omAa6Y/mhMmuqfhq5K4cACX9Vgp7EeUr6XyWyuUPZzvQoIuWKU
         DiUbA8F3Q0FpS0FTRvSZHlCO5UkbxEN0l/WQMML8dKGAyr6CIf91Tb7sz24cH5Wjyj
         JalR+QBPFTo3raO2HR+N1Da/Jlx6A161G4Kpdu84=
Date:   Sun, 02 Apr 2023 18:04:34 +0000
Subject: [PATCH v3 1/4] tools/nolibc: add libc-test binary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v3-1-ddc79f92efd5@weissschuh.net>
References: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680458682; l=1521;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=VdplZ+maLIRLoILvVLhk3/Dt0NnSp9+Gg5MHvNvgDRw=;
 b=hRbD6xU9saIGMWt1sGt6Mi0mtKNW3F6bkYNL5ReSDde7wIy+bDoefllyjYGG7Yw5nJuMv9xU0
 nzRT07XK5oMBll3kna9KXUOCgVga4xzAeVzcQ1jyt8g/t61Lcg/7Zs2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This can be used to easily compare the behavior of nolibc to the system
libc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Feel free to drop this if it does not fit in.
---
 tools/testing/selftests/nolibc/.gitignore | 1 +
 tools/testing/selftests/nolibc/Makefile   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
index 4696df589d68..52f613cdad54 100644
--- a/tools/testing/selftests/nolibc/.gitignore
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -1,4 +1,5 @@
 /initramfs/
+/libc-test
 /nolibc-test
 /run.out
 /sysroot/
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index bbce57420465..903990d22ac8 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -128,6 +128,9 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
 
+libc-test: nolibc-test.c
+	$(QUIET_CC)$(CC) -o $@ $<
+
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
@@ -159,6 +162,8 @@ clean:
 	$(Q)rm -rf sysroot
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
+	$(call QUIET_CLEAN, libc-test)
+	$(Q)rm -f libc-test
 	$(call QUIET_CLEAN, initramfs)
 	$(Q)rm -rf initramfs
 	$(call QUIET_CLEAN, run.out)

-- 
2.40.0

