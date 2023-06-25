Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AB73D216
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFYQXH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjFYQXH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:23:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5420EF7;
        Sun, 25 Jun 2023 09:23:05 -0700 (PDT)
X-QQ-mid: bizesmtp75t1687710174trrepom4
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:22:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKYSewel9R5tfK6iXWL0tG+7XzUCS2dRMwYgVkTzq+dnMLaN0SZdd
        KsHYnCbiyvVHTBeIzWRqb8bviJBXXxVYzlfu/Om2L6rc3PHQKwooqGWi+zqIfThXS6Dygc3
        WwkE3aWak9gg+eo3ddAO6C3qsX3MPEs+JoyzlUprXf84p3nQiUBXkvMjRNPw3TWJLyqILmG
        JO/YbLUK870quZTewdQq9dfIbi590Lk8nEDkN/agMayfvxS+cgcS5XpbronNLem/armSCfW
        FnsFRrtHGzfkuU5V26Me6cYIWZvM0rvrs3OHJm+42uVvr8Tr0861JBI+aG3d4ibT3XzibwY
        5oV5+sNF+xT1otht/uwHo5ZcTu4vDaAN04QmE6Z0cbUA+o34hw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13042838406856188047
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 07/22] selftests/nolibc: add common extra config options
Date:   Mon, 26 Jun 2023 00:22:41 +0800
Message-Id: <8eec688082dc5c3fde88748600b3763d13b0ba09.1687706332.git.falcon@tinylab.org>
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

This adds config options required by all of the architectures.

* for initrd
  -e BLK_DEV_INITRD --set-str CONFIG_INITRAMFS_SOURCE $(CURDIR)/initramfs

* for init executable
  -e BINFMT_ELF

* for test result print
  -e PRINTK -e TTY

* for panic reset instead of hang
  --set-val PANIC_TIMEOUT 1

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 0b810681547b..147c2db49635 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -49,7 +49,10 @@ DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(ARCH))
 
 # extra kernel configs shared among architectures
-EXTCONFIG_COMMON     = --set-str CONFIG_INITRAMFS_SOURCE $(CURDIR)/initramfs
+EXTCONFIG_COMMON     = -e BLK_DEV_INITRD --set-str INITRAMFS_SOURCE $(CURDIR)/initramfs
+EXTCONFIG_COMMON    += --set-val PANIC_TIMEOUT 1
+EXTCONFIG_COMMON    += -e PRINTK -e TTY
+EXTCONFIG_COMMON    += -e BINFMT_ELF
 
 # extra kernel configs by architecture
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
-- 
2.25.1

