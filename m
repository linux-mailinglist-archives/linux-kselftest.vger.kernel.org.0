Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124A77988F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjHKU31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKU30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:29:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA66E4D;
        Fri, 11 Aug 2023 13:29:25 -0700 (PDT)
X-QQ-mid: bizesmtp68t1691785759term9hyb
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:29:18 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: vrqOr+ppv0uBaIpwqqkyD2NSGBPtX6bqJ79M3tA90otUDH674hIAw+1qNu3L9
        vlKc5wwueXdseNPhnpq/8OoJ0cA0Ny4Am8Bg6FJKDLNvkuw1GKGOwYe69FXvUG9Iu9vKiA0
        PLY0Q3mjrBixGAkNsF6l0p49hRIgsamlJJaMt/Sn06SHuLvOxDVzbHoBfrA4KrG9jXZB4sS
        k5JqKi3YxbulBI0lEchTPI+bUziiuvxoRWwOw5LoEZwk9rvNEnCW/LegnmNEkXGlcKnIq3C
        UyqcKppdJw7fdoYxMuuxDOA6wBQBSV14Wk6+vBbmTccIyhkEch8p53V3jhTrog2zTIVdgFA
        jUudS9rNKYCNLQF0DWgzMvyCLIujgVrqg6Luy+dvgETDpmLhmui39X8p0pPEQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9388448604258754597
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 2/7] selftests/nolibc: allow use mips64 toolchain for mips
Date:   Sat, 12 Aug 2023 04:29:17 +0800
Message-Id: <954c9c14ddd37f8612db256ccde0efc26a300a2e.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to share the same mips64 toolchain for mips architecture.

Pass '-mabi=32' CFLAGS to tell mips64 toolchains to generate 32-bit mips
executable.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 98d0a619d49d..d1012f006405 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -130,7 +130,7 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
-CFLAGS_mips = -EL
+CFLAGS_mips = -mabi=32 -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) \
-- 
2.25.1

