Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5557711EE
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHETt6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHETt5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 15:49:57 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACB1735;
        Sat,  5 Aug 2023 12:49:51 -0700 (PDT)
X-QQ-mid: bizesmtp66t1691264978thj6pd57
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 03:49:36 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: lqtbexAaCVZhzOs8uzrbWiq+FweKzI5eb559canfa+LqYMjso6Pqha3omXgLC
        JZHlagED1Cz2ZhF4vz8byvY9U5LnxbK9ol/gNiTB7wMZUPpHEjFpkeBoTDrmx8V7Pfs5EMD
        qmfOIJ4RVrStZke1mKCzpn3Bwd/z7v7kDGnNvj4U9wAcgqwigNpQr0FekbOU8EjevHa5Gr4
        cW+pNLZZuUK47jUvNmb6xbxfz2OEoy49vucbIbckzy45yYKwbwz8gyXCeJlxxMxFjAg+gBq
        M0OX69RBEpubuAmHOjMd895rSUFrAVQbYMwvl5e/wnscSNLgjDrxHlAmdrjRav/u5eJCivy
        PFty/wT9IKrPq9nvfxR8iWd7W49zUwb2U1u8G1DV4qbXFxi64qqOnk8WHhvvDN6lRjV2p80
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1178898553885916269
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v1 3/4] selftests/nolibc: customize CROSS_COMPILE for loongarch
Date:   Sun,  6 Aug 2023 03:49:35 +0800
Message-Id: <d38f1fa6dec5ebb7ac4d54c728edb6d70cee3008.1691263493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691263493.git.falcon@tinylab.org>
References: <cover.1691263493.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Loongarch is a fresh new architecture, there is no prebuilt toolchain
from most of local software repositories, let's use the one from [1].

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d32694656221..9cd6dc0e8b75 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -56,6 +56,14 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+#
+# Notes:
+# - Loongarch may require toolchain from
+#   https://mirrors.edge.kernel.org/pub/tools/crosstool/
+#
+# For an external toolchain, please add its bin/ path to 'PATH' and then pass
+# CROSS_COMPLE, CROSS_COMPILE_$(XARCH), or even CC from command line.
+
 CROSS_COMPILE_i386      ?= x86_64-linux-gnu-
 CROSS_COMPILE_x86_64    ?= x86_64-linux-gnu-
 CROSS_COMPILE_x86       ?= x86_64-linux-gnu-
@@ -67,6 +75,7 @@ CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
 CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
 CROSS_COMPILE_riscv     ?= riscv64-linux-gnu-
 CROSS_COMPILE_s390      ?= s390x-linux-gnu-
+CROSS_COMPILE_loongarch ?= loongarch64-linux-
 CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
 
 # make sure CC is prefixed with CROSS_COMPILE
-- 
2.25.1

