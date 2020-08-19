Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF07249D92
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHSMOK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 08:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSMOJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 08:14:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B60720738;
        Wed, 19 Aug 2020 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839248;
        bh=KV4mnGXGCrFRun+EDN9OxgHUnFqbU7ZkJMYyr+CEL94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTeToc67nVsh1gRKfuZxYg5Scyvc3Cr2zYdt+z2Q+WGLVMhzFeHmNU1s/qZSPTazs
         z0aAmBdhWsef0uqrpoauI/XkedNz8KOetq9wjnE7nR9P3ywxWUXJpp6t3Q8rtQ4RDW
         K/nrRyxQcW6z/jwcN8oXmds0QwkErAfmeo9c4gTI=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 4/5] arm64: vdso: Add getcpu() implementation
Date:   Wed, 19 Aug 2020 13:13:17 +0100
Message-Id: <20200819121318.52158-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819121318.52158-1-broonie@kernel.org>
References: <20200819121318.52158-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some applications, especially trace ones, benefit from avoiding the syscall
overhead on getcpu() calls so provide a vDSO implementation of it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 arch/arm64/kernel/vdso/vdso.lds.S |  1 +
 arch/arm64/kernel/vdso/vgetcpu.c  | 48 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/vdso/vgetcpu.c

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 88cf0f0b91ed..ff350e69b8b6 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -11,7 +11,7 @@
 ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
 include $(srctree)/lib/vdso/Makefile
 
-obj-vdso := vgettimeofday.o note.o sigreturn.o
+obj-vdso := vgettimeofday.o note.o sigreturn.o vgetcpu.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index d808ad31e01f..ef3fb80e0349 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -80,6 +80,7 @@ VERSION
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
 		__kernel_clock_getres;
+		__kernel_getcpu;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso/vgetcpu.c b/arch/arm64/kernel/vdso/vgetcpu.c
new file mode 100644
index 000000000000..e8972e561e08
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgetcpu.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 userspace implementations of getcpu()
+ *
+ * Copyright (C) 2020 ARM Limited
+ *
+ */
+
+#include <asm/unistd.h>
+#include <asm/vdso/datapage.h>
+
+struct getcpucache;
+
+static __always_inline
+int getcpu_fallback(unsigned int *_cpu, unsigned int *_node,
+		    struct getcpucache *_c)
+{
+	register unsigned int *cpu asm("x0") = _cpu;
+	register unsigned int *node asm("x1") = _node;
+	register struct getcpucache *c asm("x2") = _c;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_getcpu;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (cpu), "r" (node), "r" (c), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+int __kernel_getcpu(unsigned int *cpu, unsigned int *node,
+		    struct getcpucache *c)
+{
+	struct vdso_cpu_data *cpu_data = __vdso_cpu_data();
+
+	if (cpu_data) {
+		if (cpu)
+			*cpu = cpu_data->cpu;
+		if (node)
+			*node = cpu_data->node;
+
+		return 0;
+	}
+
+	return getcpu_fallback(cpu, node, c);
+}
-- 
2.20.1

