Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E45765D53
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjG0U2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjG0U16 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:27:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409C30CD;
        Thu, 27 Jul 2023 13:27:39 -0700 (PDT)
X-QQ-mid: bizesmtp70t1690489632tls6eljb
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:27:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3gIqvGRracM+M018bYz/CeLA38os0ZqnkmoJW4wVgNSRIQZdhvX6
        5EL3U0qRh1Axy5sg9nEMQa38Xh1XKzC3OxtnQ5dPOq/ijA/xvg4dJGdWt09QYM8U6n1AeOO
        gWyTYSsHDZ8DyuU9ABRFFQUF8o6y9L+bcrYPZ45mBij+b4Jt6Qcsx52aQVkbgkGXoqwQVKE
        2hbxOFotjr3YrNdj7gQHjgIsXMs7fKzDwgxwnckcRnGOjpsGNj7AH9X7LQbdvH3F72D5ZxN
        Om1OiM1U+BEAu/CEPdnCykyL2Z2kJ4Z370aR0Jg3WG30L1+ED5CpK57rgYiqO0oaEcIr58I
        BISGpTKi5+LFxkX/uBje4OCPzEVcwl4ue7TkGUJFKN5XXAojYn6Xfrkf9QtPw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7483023099886591231
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 05/12] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Fri, 28 Jul 2023 04:27:10 +0800
Message-Id: <b5e181d8dd12d48a17199df2e11da9e0e82065b2.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690489039.git.falcon@tinylab.org>
References: <cover.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some cross compilers may not just be prefixed with ARCH, customize them
by architecture may simplify the test a lot, especially, when iterate
with ARCH.

After customizing this for every architecture, the minimal test argument
will be architecture itself, no CROSS_COMPILE required to be passed.

If the prefix of installed cross compiler is not the same as the one
customized, we can also pass CROSS_COMPILE as before or even pass
CROSS_COMPILE_<ARCH>.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3a61fa7e42a0..3f15c7f7ef76 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -45,6 +45,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
+# CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
+
+# make sure CC is prefixed with CROSS_COMPILE
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+
 # default kernel configurations that appear to be usable
 DEFCONFIG_i386       = defconfig
 DEFCONFIG_x86_64     = defconfig
-- 
2.25.1

