Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282687DD71E
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjJaUhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJaUhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 16:37:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F5F3;
        Tue, 31 Oct 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698784621;
        bh=W5TEpxfyI98GvsWGNdqegtj19Ji2ow6WvLtnijFpbxE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=n4hF25HXVWKd8mEbbgUYBm4ihR20qlzNQ+HSpVwYZ0Dyxux6K46kz0O/wE0STdQLi
         kAgIxiPHPb57Uq33RKDKEUlRTkQ2DcDl2RmFBBPFsx62v4zsFiNhcI8rhsH8ehzaCY
         QYpz+LR2raYl0jVsEE8m4/9Z6psF44ZSRRsOtdm8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 31 Oct 2023 21:36:58 +0100
Subject: [PATCH 1/3] selftests/nolibc: use EFI -bios for LoongArch qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231031-nolibc-out-of-tree-v1-1-47c92f73590a@weissschuh.net>
References: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
In-Reply-To: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698784620; l=2150;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=W5TEpxfyI98GvsWGNdqegtj19Ji2ow6WvLtnijFpbxE=;
 b=xfctWRM9ByPw1ywv0Ip8sy2zDAjHMebbxY8PmyqXN0WXGJfH8FEL+EaPzaUfkLdhn+v4leaZJ
 gn5w5DGsQANAJ1fxefufQIpB4RQnW7gkA8yv1qsGCJhQiF5j71lHhT2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

qemu for LoongArch does not work properly with direct kernel boot.
The kernel will panic during initialization and hang without any output.

When booting in EFI mode everything work correctly.

While users most likely don't have the LoongArch EFI binary installed at
least an explicit error about 'file not found' is better than a hanging
test without output that can never succeed.

Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index a0fc07253baf..eb258ae1d948 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -88,6 +88,13 @@ QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
+QEMU_BIOS_DIR = /usr/share/edk2/
+QEMU_BIOS_loongarch = $(QEMU_BIOS_DIR)/loongarch64/OVMF_CODE.fd
+
+ifneq ($(QEMU_BIOS_$(XARCH)),)
+QEMU_ARGS_BIOS = -bios $(QEMU_BIOS_$(XARCH))
+endif
+
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -101,7 +108,7 @@ QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.

-- 
2.42.0

