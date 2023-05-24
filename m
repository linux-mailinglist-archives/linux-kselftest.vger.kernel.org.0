Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BCF70FD3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjEXRxT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjEXRxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:53:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC982119;
        Wed, 24 May 2023 10:53:16 -0700 (PDT)
X-QQ-mid: bizesmtp71t1684950791tp8m1e4l
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:53:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 7jw2iSiCazqOcSM2MVgG4xMJ96kdb0v9csKqpcqqtj1u7+0ZkGV3bSXiAUJcM
        aPAdZ6wZXqVvTeOt/M4goYfpVARuW8z6EguvDuAJLX/NMvw9T9A3DVvTtgOUPKl1YALRxBS
        TdLGLYANVLa841J7A+shvQ0d56mm3F+wZ2zfuMB4lB4eq2tK9eIeOca6d4tS+HIqWRd4Lr0
        0CL0rD9Hk+708Xu1EYn2Ak3UMQlVPaHi14GgDDo8Tzi8zkdMP4S8OGl/mV4JGQvjMcYYFzY
        5U0oHA1KcUDOfkfEGRI0VTMWnd1DPmcYH2nY7flo325+orDVrm0s9NfMyRhzR4T84rIEw17
        27UMTVpM1ghVZtFwUpljIeOYNo9xmcTklQXF3dzYwF1eVQVUSdDO0Xd9JD7qA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2012140808971303429
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 06/13] selftests/nolibc: allow specify a bios for qemu
Date:   Thu, 25 May 2023 01:52:29 +0800
Message-Id: <63bee74a7b3754a1b0e82bc57de52c18d2de003d.1684949268.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

riscv qemu has a builtin bios (opensbi), but it may not match the latest
kernel and some old versions may hang during boot, let's allow user pass
a newer version to qemu via the -bios option.

we can use it like this:

    $ make run BIOS=/path/to/new-bios ...

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9adc8944dd80..9213763ab3b6 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -70,7 +70,8 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH))
+QEMU_ARGS_BIOS       = $(if $(BIOS),-bios $(BIOS))
+QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_BIOS)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
-- 
2.25.1

