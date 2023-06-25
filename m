Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE7B73D21A
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFYQYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYQYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:24:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D0FB;
        Sun, 25 Jun 2023 09:24:12 -0700 (PDT)
X-QQ-mid: bizesmtp91t1687710243tcm1mhg6
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:24:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8RGulXWTTLakwGCbDFVogyRym+KcgI8bU6ETz331jXlzFM5MTin9
        CA+sFl4YVEPL6MSq+ixvxplRIFqOTDkDC5NKXwsqkB9WPq2xjlElrvw84ep+MC8DFb0vwk7
        XZPPcIQtMJJglM+j+fwH2oTrJNysRCScR8Y5Use/Lw9XL44i3wyj2Amq+DF1Ym1Fxvx4aOj
        rOwhCL5FZnaqXZPJDQ34+PEMkz3VHEi4/2po95wETckplOa1BVBG1yvZZn5dlHp2xi1lRVp
        uaArzlPWpSRTPVuMQbOh8gNMafrGTw6SarbAUIQcOvzraSWHZCbFEnJwYdfKqbnZAA6AQeQ
        zQrGhTt9pjUN8UL5DCwPEVxQSK25U8bH79V1EYU0jnXRCD5ZVodR4ESDAdQkA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8067436170865169837
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 08/22] selftests/nolibc: add power reset control support
Date:   Mon, 26 Jun 2023 00:23:58 +0800
Message-Id: <7b9dd1d0b70de3917ee3d375187a5cb572303e7c.1687706332.git.falcon@tinylab.org>
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

Some boards require the power reset control options, they should have no
side effect, enable them for all.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 147c2db49635..ae8519fb1b49 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -53,6 +53,7 @@ EXTCONFIG_COMMON     = -e BLK_DEV_INITRD --set-str INITRAMFS_SOURCE $(CURDIR)/in
 EXTCONFIG_COMMON    += --set-val PANIC_TIMEOUT 1
 EXTCONFIG_COMMON    += -e PRINTK -e TTY
 EXTCONFIG_COMMON    += -e BINFMT_ELF
+EXTCONFIG_COMMON    += -e POWER_RESET -e POWER_RESET_SYSCON
 
 # extra kernel configs by architecture
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
-- 
2.25.1

