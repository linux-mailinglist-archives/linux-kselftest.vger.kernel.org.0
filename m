Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA677989C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHKUcu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjHKUct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:32:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6518E;
        Fri, 11 Aug 2023 13:32:48 -0700 (PDT)
X-QQ-mid: bizesmtp74t1691785963tp54ggzl
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:32:42 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: +ynUkgUhZJmk+CmCBh8hIWz7kAw/TgBO6SK/g3i3wf3qZL1DjYMFDwQpLi61w
        QrkXy+r9OW+Wp8HSnO76LSPbMqIxJjDmNxbqur9WbAzA3u7JISFeDOMqkoP3lHEJ5IP2KxM
        Du26jloWTDgWRPDhYE9/4HWirH0fMkbvCfL6EZ4wPf1cb1JvrsIes1wxcxn+68Xbnmu9pBm
        JBvPHO54FvcVguAcMFURVp9vMhRE+3Sup3pat94nDCP8/cuAjBJyVjiUf4sdc1e0jTUU72q
        ZHXX5VNPFOTFwHQFW0QQSWlDlbAtn7Fs9uuxyDN6eN+WKgB8Cc9BC04muM4DpmI77vTSL51
        X36+B3RYg6jr9B7+XZHLHVdQVUpSRMk/2cCM/Vxow6BufaIvYaRRIrp0jrcH82VKkxt6/yf
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10532850792558521576
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 5/7] selftests/nolibc: customize CROSS_COMPILE for all architectures
Date:   Sat, 12 Aug 2023 04:32:41 +0800
Message-Id: <a5deb231269cff5225be8331888fbea19337d5f9.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This simplifies the 'make' commands for nolibc supported architectures,
only requires the XARCH option now.

As suggested by Willy, the small, newest and obtainable cross toolchains
from [1] are customized by default, users must download, decompress and
configure the bin/ path to the PATH environment variable manually.

If still want to use a cross toolchain from local software repositories,
we can also pass CROSS_COMPILE, CROSS_COMPILE_$(XARCH) or even CC from
command line.

After carefully install and configure $(CROSS_COMPILE_$(XARCH)),
qemu-system-$(XARCH) and qemu-$(XARCH), it is able to run tests for the
architectures or their variants like this:

    $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390 loongarch"
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status; done
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make defconfig run XARCH=$arch | grep status; done

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 5aff60d31d72..9a787fdf9842 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -55,6 +55,27 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+#
+# Notes,
+# - The small, newest and obtainable cross toolchains from [1] are recommended,
+#   Please download, decompress and add the bin/ path to 'PATH' env variable
+# - To use another cross compiler, pass 'CROSS_COMPLE', 'CROSS_COMPILE_$(XARCH)'
+#   by variant or even 'CC' from command line
+#
+# [1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
+
+CROSS_COMPILE_i386      ?= x86_64-linux-
+CROSS_COMPILE_x86_64    ?= x86_64-linux-
+CROSS_COMPILE_x86       ?= x86_64-linux-
+CROSS_COMPILE_arm64     ?= aarch64-linux-
+CROSS_COMPILE_arm       ?= arm-linux-gnueabi-
+CROSS_COMPILE_mips      ?= mips64-linux-
+CROSS_COMPILE_ppc       ?= powerpc64-linux-
+CROSS_COMPILE_ppc64     ?= powerpc64-linux-
+CROSS_COMPILE_ppc64le   ?= powerpc64-linux-
+CROSS_COMPILE_riscv     ?= riscv64-linux-
+CROSS_COMPILE_s390      ?= s390-linux-
+CROSS_COMPILE_loongarch ?= loongarch64-linux-
 CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
 
 # Make CC is always prefixed with $(CROSS_COMPILE)
-- 
2.25.1

