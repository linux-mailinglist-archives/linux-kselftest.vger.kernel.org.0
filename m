Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4E73D273
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFYQeQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjFYQeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:34:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90EFBB;
        Sun, 25 Jun 2023 09:33:45 -0700 (PDT)
X-QQ-mid: bizesmtp87t1687710788t6lq8x2e
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:33:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YNWjHTNB7Dh56ShOV2PiCWCmyfgKvezs6NaTZuHDGAZg/4YPbaHK
        PtaaTRTEkNvLKXw1sBjG4HMF8CnGnG26BlT3rUYAFk4uF5IVWgqHgL0QmYfdWSl4ehu96hG
        5h6/oS7JkFmnotsk3I5ym2OYZMxiGs4Cg/Vy4S8fukcz0cd8RrbSme60jYuquP8xWYeHu7z
        yb3syMYnI8NTnrJjlq9XGrW+ILtIIoF/ND79VkXZyIfb89B7Fu2FQE7MwCytyv7Ar4dJVNG
        Ol3BCS/796y0UtJmP9ETQyERpR9vAbhNZ5vPPHnigMwM6wRhu9qImtlMMZfJoSyKMfUFvSV
        oBHqBBWoGNxyrkBSK3A1QF6XO5pPDoXtebCZ3ICHU9Mp85U48U=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6973877681573296904
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 14/22] selftests/nolibc: add extra configs for mips
Date:   Mon, 26 Jun 2023 00:32:59 +0800
Message-Id: <335d7f5a0091878da56fae1d3a20bdf28c77d888.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable minimal configs for the mips malta board of qemu.

Enable CONFIG_COMPAT_32BIT_TIME for the poll test cases.

Add 8250 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 79983ddc1584..234abf54cac5 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -63,6 +63,7 @@ EXTCONFIG_x86_64     = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_x86        = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_arm64      = -e SERIAL_AMBA_PL011 -e SERIAL_AMBA_PL011_CONSOLE
 EXTCONFIG_arm        = $(addprefix -e ,COMPAT_32BIT_TIME MMU ARCH_MULTIPLATFORM ARCH_MULTI_V7 ARM_PATCH_PHYS_VIRT ARCH_VIRT SERIAL_AMBA_PL011 SERIAL_AMBA_PL011_CONSOLE)
+EXTCONFIG_mips       = $(addprefix -e ,COMPAT_32BIT_TIME MIPS_MALTA CPU_LITTLE_ENDIAN CPU_MIPS32_R2 SERIAL_8250 SERIAL_8250_CONSOLE)
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1

