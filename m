Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D817D9F78
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjJ0SJe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJ0SJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:09:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D81010A;
        Fri, 27 Oct 2023 11:09:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C3B153B;
        Fri, 27 Oct 2023 11:10:12 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3E853F64C;
        Fri, 27 Oct 2023 11:09:28 -0700 (PDT)
From:   Joey Gouly <joey.gouly@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, joey.gouly@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, shuah@kernel.org, will@kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 11/24] arm64: enable ARCH_HAS_PKEYS on arm64
Date:   Fri, 27 Oct 2023 19:08:37 +0100
Message-Id: <20231027180850.1068089-12-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable the ARCH_HAS_PKEYS config, but provide dummy
functions for the entire interface.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig             |  2 ++
 arch/arm64/include/asm/pkeys.h | 54 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c            |  7 +++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm64/include/asm/pkeys.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f1a12e28c3f..68cfcbd95c8e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2064,6 +2064,8 @@ menu "ARMv8.9 architectural features"
 config ARM64_POE
 	prompt "Permission Overlay Extension"
 	def_bool y
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_PKEYS
 	help
 	  The Permission Overlay Extension is used to implement Memory
 	  Protection Keys. Memory Protection Keys provides a mechanism for
diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
new file mode 100644
index 000000000000..5761fb48fd53
--- /dev/null
+++ b/arch/arm64/include/asm/pkeys.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ *
+ * Based on arch/x86/include/asm/pkeys.h
+*/
+
+#ifndef _ASM_ARM64_PKEYS_H
+#define _ASM_ARM64_PKEYS_H
+
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
+
+#define arch_max_pkey() 0
+
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val);
+
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	return -1;
+}
+
+static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
+		int prot, int pkey)
+{
+	return -1;
+}
+
+static inline int execute_only_pkey(struct mm_struct *mm)
+{
+	return -1;
+}
+
+static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
+{
+	return false;
+}
+
+static inline int mm_pkey_alloc(struct mm_struct *mm)
+{
+	return -1;
+}
+
+static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
+{
+	return -EINVAL;
+}
+
+#endif /* _ASM_ARM64_PKEYS_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 47781bec6171..11765791b880 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1487,3 +1487,10 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
 {
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
+
+#ifdef CONFIG_ARCH_HAS_PKEYS
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
+{
+	return -ENOSPC;
+}
+#endif
-- 
2.25.1

