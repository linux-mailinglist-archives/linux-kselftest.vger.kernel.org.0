Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F876BE10
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHATsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHATsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:48:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12CEB4;
        Tue,  1 Aug 2023 12:48:09 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690919278t8pql6gz
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:47:57 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: eSZ1CZgv+JA9h5VCVgqY6MkV5uUtGo/eDvsJodtq4QX2oqDVwJxGvf/IXII05
        Tz4myMiYEKONc6Jeqvdg2I9K6zi9iy/r7CNyiQUUcCQD5IrSkzlfXx46bEx6ak74l858j6m
        hTOUUlK+ErbZEh/b6SvaZCxIv8fx0ibJywec20+H4T02kxIXBbeu7oTIfsdDxe+t6+xE/r8
        tI/o9uVmRS/JT/H0Tr47Aac2TLg/adCa3HOWOAe2sOskwZCGfmLjzwyF8UNfZEtuoC4rDGR
        pcpMWDKAW9jgGlTkM+HuSGSU77e+WOekppFhSKD/XKqUI1toj+L2jasvT79dMM1rnNo5pYs
        hY7TBbyyBh96R+NsNZcj9h/a9rcINGRZTUNCdOmYYU02I25kdTrc2uj/OcdyQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12213163372342397090
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v4 11/12] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Wed,  2 Aug 2023 03:47:57 +0800
Message-Id: <f15f299c5d1ae2012f5d9845ad5a7cc2cf44d7d9.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index ef4b8ba83898..822cc4bae619 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -58,6 +58,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
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

