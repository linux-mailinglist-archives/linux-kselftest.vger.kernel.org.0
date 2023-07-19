Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B07596C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGSN2b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGSN2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:28:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBC113;
        Wed, 19 Jul 2023 06:28:29 -0700 (PDT)
X-QQ-mid: bizesmtp89t1689773299tf1rngp7
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:28:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: D2GZf6M6C/hHMjfdxJUjT9SWMLhUQYgJDIrrFhp+Fwq9+ZemwYDahDg/LFlAP
        uRCI1W5PfFWLILP0jV14OzSZhvAjwT4JZJTRHhO4PVQ15kr/ZQ9JR0EiD3YRUFfmoLyTf80
        yKxjFV5yEYTSI1DpVfwYWdjzZfsjO0jxhtzaevKeOxSD7/EDiON1DMkYCuFlJWao2CHZsB1
        NuZOf4qzhHOsFYbXDTlblJbeiiBHtfZg4hVxHnklzJNXeNQDqzWrJ1Cqg5dTF9zMTjNHTEd
        6QAsOoq2RCed4fNTKqx0EkMJo4aEfJ/+A00vEnNrMqR0/UFliRfBSKlMwmCmbzvbnXpYJ72
        PPDNYb1Hfc1LYSjQCQjC5CSXp1FCMsjHCP83F8/1Gb+DCR0ezn5mcb1eyrM4w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12822490735475471790
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 10/14] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Wed, 19 Jul 2023 21:28:17 +0800
Message-Id: <39df39b4023831b796a1b21c7e31f4be0b432416.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some cross compilers may not just be prefixed with ARCH or XARCH,
customize them by architecture may easier the test a lot, especially,
when iterate with XARCH or ARCH.

After customizing this for every architecture, the minimal test argument
will be architecture itself, no CROSS_COMPILE will be passed.

If the installed cross compiler is not the same as the one customized,
we can also pass CROSS_COMPILE from command line as before, no
regression.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index a03fab020ebe..3c2be27747ea 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -42,6 +42,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
+# CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE             ?= $(CROSS_COMPILE_$(XARCH))
+
+# make sure CC is prefixed with CROSS_COMPILE
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+
 # default kernel configurations that appear to be usable
 DEFCONFIG_i386       = defconfig
 DEFCONFIG_x86_64     = defconfig
-- 
2.25.1


