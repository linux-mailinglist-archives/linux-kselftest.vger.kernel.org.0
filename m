Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5057E7BFB8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJJMeT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjJJMeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907ECF0;
        Tue, 10 Oct 2023 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696941245;
        bh=kXS7WhluAd4PiUUxRUCXnsXLrFdoS1vueCxpn04VTXE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R0WpHc8XQvn1Lji8rx5D6JKLLm6M9P6qaJYMFzgOu2iTe1Qg8jh7jI8TK+CjuABax
         ojMk4Heqk1IAnnbBYg7nOSp8qbKSO3FVazcdarSvueJfHW8l+e6AGYosXVvN7VoG4A
         Rhvxgg7pawEKVX3K8e6iEg8+3tUFU8o9y/qpW6LU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 10 Oct 2023 14:33:57 +0200
Subject: [PATCH 2/5] selftests/nolibc: use EFI -bios for LoongArch qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-nolibc-out-of-tree-v1-2-b6a263859596@weissschuh.net>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
In-Reply-To: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696941244; l=1717;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kXS7WhluAd4PiUUxRUCXnsXLrFdoS1vueCxpn04VTXE=;
 b=mRJ10rNacYK1RUuAziauqWSviXnEL+7fllM4ClTgv0Qep9/tmh+FYPxesyXQHxDXpKS8EIs7m
 uxCVv7/ALa2BuA2ZMIFijBikPeE+RdpiMB6+7/7LSYovSINaHjBTpSn
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

qemu for LoongArch does not work properly with direct kernel boot.
The kernel will panic during initialization and hang without any output.

When booting in EFI mode everything work correctly.

While users most likely don't have the LoongArch EFI binary installed at
least an explicit error about 'file not found' is better than a hanging
test without output that can never succeed.

Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Note: I'm wondering how this worked for anybody else.
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index af60e07d3c12..258293639572 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -100,7 +100,7 @@ QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)" -bios /usr/share/edk2/loongarch64/OVMF_CODE.fd
 QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise

-- 
2.42.0

