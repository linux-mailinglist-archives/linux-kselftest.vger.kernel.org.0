Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0B73D27D
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjFYQit (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYQis (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:38:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDEB9;
        Sun, 25 Jun 2023 09:38:46 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687711115t4rohu2l
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:38:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 2d9G4llBGh4DhBoewQkeqNdbGbShZj+bIjJtuorGsg9cHW2fmzqLOFLxYqvxw
        pEqO5rq3507HWCbQcfrPUIMZINYQMoOtFqdx41gYZGHTemgu4FSZIrkqKqDysRj8Q0wlxvE
        2XSwxmPS/dZv978bg86pm8FzAbz9mng4G+DHzgUSY/JvlBYs1OWdeUK1+KJC7lEPOCSzW/z
        S9ENACer8nmXJJTVVwA+so5Y+avPCzbhXhpdOPcDRQ4mHhOlBMtPwGpHqDMaKERVve+OqHp
        DPCQiiRT+1bFE3S6QjMXlEaRH6N668GgmhKH2TFBJqjlpOi/YIEfvJ8JjlEebaAEopQqgxj
        BwqaA01EvQ4uXoaFNmwpP0ocbQE3SwLJFTo9HU8eZ8Eo9q/Kxj3FrSZGP/+zA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6002407721714959409
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 18/22] selftests/nolibc: add extra configs for loongarch
Date:   Mon, 26 Jun 2023 00:38:01 +0800
Message-Id: <b95a1f02f77af2dd76a49121182eb4e7c382961d.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
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

Enable efi support for vmlinuz.efi boot.

Add 8250 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 4d0de9e90d86..9092d209ebd0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -68,6 +68,7 @@ EXTCONFIG_riscv32    = $(addprefix -e ,MMU ARCH_RV32I NONPORTABLE SERIAL_8250 SE
 EXTCONFIG_riscv64    = -e SERIAL_8250 -e SERIAL_8250_CONSOLE -e SERIAL_OF_PLATFORM
 EXTCONFIG_riscv      = -e SERIAL_8250 -e SERIAL_8250_CONSOLE -e SERIAL_OF_PLATFORM
 EXTCONFIG_s390       = -e SCLP_VT220_TTY -e SCLP_VT220_CONSOLE
+EXTCONFIG_loongarch  = $(addprefix -e ,EFI_STUB EFI_ZBOOT SERIAL_8250 SERIAL_8250_CONSOLE SERIAL_8250_PNP)
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1


