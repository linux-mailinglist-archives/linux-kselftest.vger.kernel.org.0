Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80C7BFB88
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjJJMeU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjJJMeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D5115;
        Tue, 10 Oct 2023 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696941245;
        bh=fsO74MWqtM4jVQuGUdntQXoI033jmuUmq363SjvsrzE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PMAns0zZx3Np5CZIIV5quub/x4ZRSTDxPXg9ff+629CjRY8nc8NJM7Lb+juwV3XHz
         5KOj4pqFlmZnMPymL4SehEzB/S9U7gpIiZn/UZsgeG9eZ7bzbpMcPdfPFhAEvxrjjR
         SAyA16qH6ln4og1bVtnXt/unzItw1kGTT+tU//Qw=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 10 Oct 2023 14:33:56 +0200
Subject: [PATCH 1/5] selftests/nolibc: use qemu-system-ppc64 also for
 ppc64le
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-nolibc-out-of-tree-v1-1-b6a263859596@weissschuh.net>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
In-Reply-To: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696941244; l=992;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fsO74MWqtM4jVQuGUdntQXoI033jmuUmq363SjvsrzE=;
 b=wBSRpTIRiZpeQkBRJz5IkeqbVATp2Vm3/3mSLvtxPjEqug6p2AE6S8BcC7VaMG9QkRctG4DKq
 1EpwfekvHEACtwJLn0KV+nDLNowX1elG/TuCScWOv7UJCRd/xdY4xNn
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

qemu-system-ppc64 can handle both big and little endian kernels.

While some setups, like Debian, provide a symlink to execute
qemu-system-ppc64 as qemu-system-ppc64le, others, like ArchLinux, do not.

So always use qemu-system-ppc64 directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 891aa396163d..af60e07d3c12 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -82,7 +82,7 @@ QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
-QEMU_ARCH_ppc64le    = ppc64le
+QEMU_ARCH_ppc64le    = ppc64
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64

-- 
2.42.0

