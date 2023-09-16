Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666AD7A2E58
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjIPHO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIPHN4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 03:13:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03C11BC7;
        Sat, 16 Sep 2023 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694848422;
        bh=HuKIsAyLFmZmHBEu40qJ+1hV5Zu0Xnhs4WVhae5Lnlk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UABtFaabbXO8SbirT/kI4iR1QM2pkgAqQ+w7eIW7IdbX8h4v0YYjd5C9FR47ixMgq
         8Kzva2sxm5JkNOJ2ft+cmFL3JPtvXDmtCzdqVmKCgkGP221/hobrIwbveyQS28yf81
         XxZkf7lfJ+dAFW25za7OuQNQZzNqVZ7z4Xh6U3Bw=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 16 Sep 2023 09:13:29 +0200
Subject: [PATCH RFC 3/3] selftests/nolibc: drop target "rerun"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230916-nolibc-initramfs-v1-3-4416ecedca6d@weissschuh.net>
References: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
In-Reply-To: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694848421; l=1248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HuKIsAyLFmZmHBEu40qJ+1hV5Zu0Xnhs4WVhae5Lnlk=;
 b=2btfW1pmngj98gPHBzBmyfY828dC96EUdzPmE3JwmSsRA3/LEXZl1R4xP7vuHIPHZVC/7bGem
 bxgIFHXU/cNAIXaWKHvMpdY13KvWcL/mvFbqUHq9zCmC+53X4Ji0T1f
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that the target "run" does not relink the kernel all the time
anymore it is much faster and we don't need "rerun" anymore.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

Willy:

This is an optional commit, "rerun" is still a bit faster than "run".
Also maybe it should be squashed into the previous commit.
---
 tools/testing/selftests/nolibc/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index c62efc62a060..ca9ec9c6f2f4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -212,11 +212,6 @@ run: kernel initramfs.cpio
 	qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
-# re-run the tests from an existing kernel
-rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)$(REPORT) $(CURDIR)/run.out
-
 # report with existing test log
 report:
 	$(Q)$(REPORT) $(CURDIR)/run.out

-- 
2.42.0

