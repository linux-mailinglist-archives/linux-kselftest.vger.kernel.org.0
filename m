Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764847711E6
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 21:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHETop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 15:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHETop (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 15:44:45 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 12:44:39 PDT
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D91732;
        Sat,  5 Aug 2023 12:44:38 -0700 (PDT)
X-QQ-mid: bizesmtp70t1691264671t108lc7o
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 03:44:30 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: zT6n3Y95oi1y8fInte+k+VHvD3XvDVwfE8g+6rqb4AalVd+4Dp8ranF9L+Uj4
        FgiLWpRUWNssQ6BCu3QpEgULh0+D/vQtwuqkIXWYGYlD+YIAz5eQv/h/FUeYLMOXuvHWr3U
        iZVd5cYtdKsLGjzv0XBVn8z2/lm0WxRoq4SwkO4RpyypFtUdzMcoI1cJDkq62YP1K3/H/W+
        wE6UYkpZpbAwgMGvNLShExMa42TNO0QIB4hfIYreA0tA1Hg7gukvqVND8Z0HWwXn6bT2kdP
        MSQLwxMRj5O4r50e1fdPek4yKGvwE/wGNjf29Tijk9xfzyE5HP/JMcYACthhu3MZ7M1uMch
        ji0eYxYDIBWe/zp5CyFRzpVGCZPo25ZKSscKXyVDtlNgvHXJQ1CPYQTW4+H9oUG8CotnEqf
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7505355185918316706
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v1 2/4] selftests/nolibc: customize CROSS_COMPILE for many architectures
Date:   Sun,  6 Aug 2023 03:44:29 +0800
Message-Id: <3ec048008a9b2c1ed7406214c6899e5412a97596.1691263493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691263493.git.falcon@tinylab.org>
References: <cover.1691263493.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This simplifies the 'make' commands for most of nolibc supported
architectures, only requires the XARCH option now.

Almost all distributions provide qemu and toolchains for i386, x86_64,
arm64, arm, mips, riscv and s390, let's customize the local toolchains
for them. The fresh new loongarch is an exception, which is not covered
here.

If want to use another toolchain which is not customized here, we can
also pass CROSS_COMPILE, CROSS_COMPILE_$(XARCH) and even CC from command
line.

After carefully install and configure $(CROSS_COMPILE_$(XARCH)) and
qemu-$(XARCH), it is able to run tests for the architectures or their
variants like this:

    $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390"
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status; done
         i386: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
       x86_64: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
        arm64: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
          arm: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
         mips: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
          ppc: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
        ppc64: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
      ppc64le: 165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
        riscv: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
         s390: 165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index e2b02761ad44..d32694656221 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -56,9 +56,17 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE_i386      ?= x86_64-linux-gnu-
+CROSS_COMPILE_x86_64    ?= x86_64-linux-gnu-
+CROSS_COMPILE_x86       ?= x86_64-linux-gnu-
+CROSS_COMPILE_arm64     ?= aarch64-linux-gnu-
+CROSS_COMPILE_arm       ?= arm-linux-gnueabi-
+CROSS_COMPILE_mips      ?= mipsel-linux-gnu-
 CROSS_COMPILE_ppc       ?= powerpc-linux-gnu-
 CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
 CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
+CROSS_COMPILE_riscv     ?= riscv64-linux-gnu-
+CROSS_COMPILE_s390      ?= s390x-linux-gnu-
 CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
 
 # make sure CC is prefixed with CROSS_COMPILE
-- 
2.25.1


