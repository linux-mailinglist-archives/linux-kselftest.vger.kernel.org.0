Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627173D26C
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjFYQcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFYQcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:32:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D412728;
        Sun, 25 Jun 2023 09:31:30 -0700 (PDT)
X-QQ-mid: bizesmtp85t1687710626t7jbsr0w
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:30:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: CR3LFp2JE4mpAf5y1pCIlD9ZuX5yZ9/MFjh9Rx/IYCq+dZVYGNuGoTwWI2/cU
        7y7AqL44Pdv4fR6BRFE2lKIGGIqoK7WSllgvTCbiF7Pt8YiUDmgoWHuaE8vvDnY+kob8aD4
        rcRFHrAWameWRiSQXD4QKc6YlPDfxIzaySY1pj4n91YVobq79egaQIPRAOBoL2w6xj1KX90
        rbJYg/39ozxNvpn0O7+NW9mQyyWrrN6yhBjt3CXXQboXTRbjlGk8sl0/6rjRnvp1w9Lbgiu
        Qwvd0ki0gNaYVTUHb1oNuJoIv0UZODB0/WFuM31AGbiFatgymF9gTMwqsJboJt+o6sISVp8
        R0T37t5eMjeoZHVqoaRHxNNYneZp41r5cY9m6ZV691Y9P+tG1s=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16565260553308252172
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 12/22] selftests/nolibc: add extra configs for arm64
Date:   Mon, 26 Jun 2023 00:30:17 +0800
Message-Id: <ca6cad47facf3096fad6a5e755ba9d6723edcf8f.1687706332.git.falcon@tinylab.org>
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

Add AMBA PL011 console for test result print.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d45454f86ae1..6e59a694096d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -61,6 +61,7 @@ EXTCONFIG_COMMON    += -e SHMEM -e TMPFS
 EXTCONFIG_i386       = -e COMPAT_32BIT_TIME -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_x86_64     = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
 EXTCONFIG_x86        = -e 64BIT -e SERIAL_8250 -e SERIAL_8250_CONSOLE
+EXTCONFIG_arm64      = -e SERIAL_AMBA_PL011 -e SERIAL_AMBA_PL011_CONSOLE
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
 
 # extra kernel configs, include common + architecture specific
-- 
2.25.1

