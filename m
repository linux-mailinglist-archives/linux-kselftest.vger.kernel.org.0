Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007073D27B
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjFYQhK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYQhI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:37:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98294119;
        Sun, 25 Jun 2023 09:37:06 -0700 (PDT)
X-QQ-mid: bizesmtp75t1687711017tppn3g8b
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:36:56 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: D2GZf6M6C/jnrzaM/7cYWsO2GcCj0igagDr7PV1z4cEq6WN6WlYwJodtMIHN/
        Hnl1tikDNdJv3IbomWQz1ZAijLcfpKiglb9dlWrzBRDFn5I9vZgyMZBV6+FZoRHObY+a66H
        KK+Fa/wCuOTydHQ7SiXwDZdqgJTPW9izf5tJSZL76NI9AZcA6EUvEl+vTCr35/6EnPsR4nw
        XXLRcx4ALagiODjy7XnWeht6FzgUZUModD+/50YD1iqY7CJNkop8BZnI1DuRAoFRse3vtfk
        hc0wjmmWj28BgedMdnxM6xlQDRD6VooQPRjHFL23hkCfXhRLZEBW5YLEFIf0FA7jO3BgpRG
        eEvWHnfpyup5Y4kZ9SzesC4vNIL8NbLZQUYSQvVnMwRb36gXa8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17452886390884145354
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 17/22] selftests/nolibc: add extra configs for s390x
Date:   Mon, 26 Jun 2023 00:36:46 +0800
Message-Id: <0a9d0c36a9332409b63691a49f4f629285e82372.1687706332.git.falcon@tinylab.org>
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

Add SCLP VT220 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8f9cb118cefe..4d0de9e90d86 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -67,6 +67,7 @@ EXTCONFIG_mips       = $(addprefix -e ,COMPAT_32BIT_TIME MIPS_MALTA CPU_LITTLE_E
 EXTCONFIG_riscv32    = $(addprefix -e ,MMU ARCH_RV32I NONPORTABLE SERIAL_8250 SERIAL_8250_CONSOLE SERIAL_OF_PLATFORM)
 EXTCONFIG_riscv64    = -e SERIAL_8250 -e SERIAL_8250_CONSOLE -e SERIAL_OF_PLATFORM
 EXTCONFIG_riscv      = -e SERIAL_8250 -e SERIAL_8250_CONSOLE -e SERIAL_OF_PLATFORM
+EXTCONFIG_s390       = -e SCLP_VT220_TTY -e SCLP_VT220_CONSOLE
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1

