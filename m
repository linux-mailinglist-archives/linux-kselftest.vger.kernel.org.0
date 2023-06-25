Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC273D26F
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjFYQdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjFYQd2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:33:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEDA1BE4;
        Sun, 25 Jun 2023 09:33:05 -0700 (PDT)
X-QQ-mid: bizesmtp66t1687710716t7j8m98e
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:31:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8RGulXWTTLak4tKHmM9RyxNo4MpbhA1cetkjXVlxD7BfmIkGgBxZ
        Ucd2qvMGnBiNEi1gt8gFRG/QB4iuakqK4bLQWTHiXz1IFwr0pOKNSipi+OQqDhF0Xlr1Erx
        YjmmGzMcDzYy5AeV9+gNwwrympcxJjWnFXHhFjuQCcKDNm76J/5XjOVV+mce7JRpYWu5t7h
        6oynNPEO+ZTpgOFIBwTo5o0vPxK3IFg2rh6vYk3RQG9dDPAv7S67oy4ZdlgYzahE/ppOHyz
        vjDr8orwmf4JL47UyysQnYEeHvjyV+jojY+XvtHZCdTb1609MzK+3yXbnVp9QMHWeszl11t
        KU0+RkddaxiUciiOajhmc54aRNxd1T5qnX7/jvvTmjghBGlEOY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7069103967638041911
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 13/22] selftests/nolibc: add extra configs for arm
Date:   Mon, 26 Jun 2023 00:31:30 +0800
Message-Id: <c246545360acd511e06b4fb47d42c2d9bf724189.1687706332.git.falcon@tinylab.org>
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

Enable minimal configs for the arm virt board of qemu.

Enable CONFIG_COMPAT_32BIT_TIME for the poll test cases.

Add AMBA PL011 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 6e59a694096d..79983ddc1584 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -62,6 +62,7 @@ EXTCONFIG_i386       = -e COMPAT_32BIT_TIME -e SERIAL_8250 -e SERIAL_8250_CONSOL
 EXTCONFIG_x86_64     = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_x86        = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_arm64      = -e SERIAL_AMBA_PL011 -e SERIAL_AMBA_PL011_CONSOLE
+EXTCONFIG_arm        = $(addprefix -e ,COMPAT_32BIT_TIME MMU ARCH_MULTIPLATFORM ARCH_MULTI_V7 ARM_PATCH_PHYS_VIRT ARCH_VIRT SERIAL_AMBA_PL011 SERIAL_AMBA_PL011_CONSOLE)
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1

