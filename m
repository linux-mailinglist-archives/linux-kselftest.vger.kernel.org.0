Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB507BCE58
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Oct 2023 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbjJHMeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Oct 2023 08:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbjJHMeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Oct 2023 08:34:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB376B6;
        Sun,  8 Oct 2023 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696768442;
        bh=gs3Q5ckwSMfG87NEL5Jp5qePton1W9wYfWxYZQZdOk4=;
        h=From:Date:Subject:To:Cc:From;
        b=qfQXqf6fD5MWKC6onIE4MPIjbeFdwNqKMbzuxt9zSMHJlL6Gc2gILJdQuXVMYo1rD
         XRW03jTWtIMy/FRsDGNA9FJqjXUFkH2vx1a8c2wX/bu5lnY4ZeeQ9m1QycKDep8COH
         3m0ESw4cB6lH3I56tgpnLdbeN4kKZKZCbpWgHgxQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 08 Oct 2023 14:34:01 +0200
Subject: [PATCH] selftests/nolibc: use qemu-system-ppc64 for ppc64le
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231008-nolibc-qemu-ppc64-v1-1-29e2326e0420@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALihImUC/x3MQQ5AMBBA0avIrE0yaEpcRSyoKZNQ1YZIxN01l
 m/x/wORg3CENnsg8CVRdpdQ5BmYZXAzo0zJUFJZFUQNun2V0eDB24neG62Q6lHZWpGqBg2p84G
 t3P+z69/3A+FVVQ9jAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696768442; l=1155;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gs3Q5ckwSMfG87NEL5Jp5qePton1W9wYfWxYZQZdOk4=;
 b=scFFXC3DIVBIrx83J3nXT5zvZ9Zq2PWEiycS5TbOckrbcO7gL29G+bDO2k9o40UkaKDXCmnFk
 coWLrwPwBlSC9qP7RHimvTfK9tmLK5ZvNE3vyHriR2WPj1E9GSkUycg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

---
base-commit: 361fbc295e965a3c7f606d281e6107e098d33730
change-id: 20231008-nolibc-qemu-ppc64-07b4f74043a6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

