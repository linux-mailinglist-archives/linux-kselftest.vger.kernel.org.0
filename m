Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E665ABE51
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiICJzm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Sep 2022 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiICJzl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Sep 2022 05:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610DC3D59E
        for <linux-kselftest@vger.kernel.org>; Sat,  3 Sep 2022 02:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4516114C
        for <linux-kselftest@vger.kernel.org>; Sat,  3 Sep 2022 09:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738F8C433D6;
        Sat,  3 Sep 2022 09:55:36 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/2] tools: Add LoongArch build infrastructure
Date:   Sat,  3 Sep 2022 17:55:06 +0800
Message-Id: <20220903095507.3425208-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We will add tools support for LoongArch (bpf, perf, objtool, etc.), add
build infrastructure and common headers for preparation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 tools/arch/loongarch/include/uapi/asm/bitsperlong.h |  9 +++++++++
 tools/scripts/Makefile.arch                         | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/loongarch/include/uapi/asm/bitsperlong.h

diff --git a/tools/arch/loongarch/include/uapi/asm/bitsperlong.h b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..d4e32b3d4843
--- /dev/null
+++ b/tools/arch/loongarch/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_LOONGARCH_BITSPERLONG_H
+#define __ASM_LOONGARCH_BITSPERLONG_H
+
+#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* __ASM_LOONGARCH_BITSPERLONG_H */
diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index 0c6c7f456887..1c72d07cb9fe 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -5,7 +5,7 @@ HOSTARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
                                   -e s/s390x/s390/ -e s/parisc64/parisc/ \
                                   -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
                                   -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-                                  -e s/riscv.*/riscv/)
+                                  -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
 
 ifndef ARCH
 ARCH := $(HOSTARCH)
@@ -34,6 +34,15 @@ ifeq ($(ARCH),sh64)
        SRCARCH := sh
 endif
 
+# Additional ARCH settings for loongarch
+ifeq ($(ARCH),loongarch32)
+       SRCARCH := loongarch
+endif
+
+ifeq ($(ARCH),loongarch64)
+       SRCARCH := loongarch
+endif
+
 LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
-- 
2.31.1

