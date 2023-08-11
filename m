Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D963A7798A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjHKUfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHKUfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:35:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C51AA;
        Fri, 11 Aug 2023 13:35:03 -0700 (PDT)
X-QQ-mid: bizesmtp75t1691786097t68neb4h
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:34:56 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: X8eDqSQ5BkoKQePf2zVu8YMMFfNFjgBgxrLs2bAsPeoLTEUbzreCZd+1mSd20
        7U3TEs36Uo9gkL4FqLIEZtzmKcjTET+hKQVgGRen90EEjks1kEZ2RdYJHJ1K60hBz0ekXsq
        EwXwQaUkkaWjEQ4/xwiAcD4sJvBPi62L6Xt0+/7eZgk2y5ce5xWUfnAWqTvsrWBuO+hsPvh
        Y0z7i6GriAoG00RsA3sB2j1wNDC2I8o71hN2UdMxANB5rFiESNUYMZ/TjksRcXH0HVuOJiJ
        Zil6yT8ZDR7IGL5eEb0DLZ9z4yr1ziQS6AH8YcVZLVzTVw/Oekri+azHmh87U2b8mZR/dLp
        7Zq35cw61OiwR9RAEyzQq7vw06R9hH//KTJUlbFHGiHhhcr4R+2DsEczjk/zuqG2BtqLzYB
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10952256110585604528
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 7/7] selftests/nolibc: allow use cross toolchains from software repository
Date:   Sat, 12 Aug 2023 04:34:55 +0800
Message-Id: <b06de47989e3138de3d178da0d705ad6560924ec.1691783604.git.falcon@tinylab.org>
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

This allows users to install and use cross toolchains from local
software repositories.

The prefixes of local cross toolchains are appended to the
CROSS_COMPILE_$(XARCH) list, cc-cross-prefix is called to search this
list and return the first <prefix> where a <prefix>gcc is found in PATH.

Since different distributions have different prefixes, here only adds
the frequently used ones.

To use more prefixes not listed in Makefile, please put the lines as
following in your script and load it with a 'source' command:

    export CROSS_COMPILE_i386="x86_64-linux-"
    export CROSS_COMPILE_x86_64="x86_64-linux-"
    export CROSS_COMPILE_x86="x86_64-linux-"
    export CROSS_COMPILE_arm64="aarch64-linux-"
    export CROSS_COMPILE_arm="arm-linux-gnueabi-"
    export CROSS_COMPILE_mips="mips64-linux-"
    export CROSS_COMPILE_ppc="powerpc64-linux-"
    export CROSS_COMPILE_ppc64="powerpc64-linux-"
    export CROSS_COMPILE_ppc64le="powerpc64-linux-"
    export CROSS_COMPILE_riscv="riscv64-linux-"
    export CROSS_COMPILE_s390="s390-linux-"
    export CROSS_COMPILE_loongarch="loongarch64-linux-"

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 7687988c780b..ef2507f12e24 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -59,24 +59,25 @@ IMAGE_NAME       = $(notdir $(IMAGE))
 # Notes,
 # - The small, newest and obtainable cross toolchains from [1] are recommended,
 #   Please download, decompress and add the bin/ path to 'PATH' env variable
+# - The frequently used prefixes are added for local cross toolchains
 # - To use another cross compiler, pass 'CROSS_COMPLE', 'CROSS_COMPILE_$(XARCH)'
 #   by variant or even 'CC' from command line
 #
 # [1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
 
-CROSS_COMPILE_i386      ?= x86_64-linux-
-CROSS_COMPILE_x86_64    ?= x86_64-linux-
-CROSS_COMPILE_x86       ?= x86_64-linux-
-CROSS_COMPILE_arm64     ?= aarch64-linux-
-CROSS_COMPILE_arm       ?= arm-linux-gnueabi-
-CROSS_COMPILE_mips      ?= mips64-linux-
-CROSS_COMPILE_ppc       ?= powerpc64-linux-
-CROSS_COMPILE_ppc64     ?= powerpc64-linux-
-CROSS_COMPILE_ppc64le   ?= powerpc64-linux-
-CROSS_COMPILE_riscv     ?= riscv64-linux-
-CROSS_COMPILE_s390      ?= s390-linux-
+CROSS_COMPILE_i386      ?= x86_64-linux- x86_64-linux-gnu-
+CROSS_COMPILE_x86_64    ?= x86_64-linux- x86_64-linux-gnu-
+CROSS_COMPILE_x86       ?= x86_64-linux- x86_64-linux-gnu-
+CROSS_COMPILE_arm64     ?= aarch64-linux- aarch64-linux-gnu-
+CROSS_COMPILE_arm       ?= arm-linux-gnueabi- arm-none-eabi-
+CROSS_COMPILE_mips      ?= mips64-linux- mips64el-linux-gnuabi64-
+CROSS_COMPILE_ppc       ?= powerpc64-linux- powerpc-linux-gnu-
+CROSS_COMPILE_ppc64     ?= powerpc64-linux- powerpc64le-linux-gnu-
+CROSS_COMPILE_ppc64le   ?= powerpc64-linux- powerpc64le-linux-gnu-
+CROSS_COMPILE_riscv     ?= riscv64-linux- riscv64-linux-gnu-
+CROSS_COMPILE_s390      ?= s390-linux- s390x-linux-gnu-
 CROSS_COMPILE_loongarch ?= loongarch64-linux-
-CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
+CROSS_COMPILE           ?= $(call cc-cross-prefix,$(CROSS_COMPILE_$(XARCH)))
 
 # Make CC is always prefixed with $(CROSS_COMPILE)
 include ../../../scripts/Makefile.include
-- 
2.25.1

