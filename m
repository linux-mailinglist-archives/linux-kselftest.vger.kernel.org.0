Return-Path: <linux-kselftest+bounces-31232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A384BA94D39
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B2818909A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18BB21325D;
	Mon, 21 Apr 2025 07:31:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752BD2101A0;
	Mon, 21 Apr 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220688; cv=none; b=Be1/evaSfgZfHrT9mqPsX1cNtlYelkfrEFeZnJreE5VUlWAr6P/o7k1SE6zWCydOPzPyoejSaJ1sQGkexzUigSpBl7c9Q7CewH59eT28X+JLEG5BRABI3zt94pT6yIBUyelye4ImG13br8QVEJV/1tlPoz2kb54YW+1r5ucYEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220688; c=relaxed/simple;
	bh=mX2Ffs5Uc/b7Mfo1o5+nW5sgSFD7e07LZOU2O2p494k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAPfRPemb1eoIoFswbzRXjM4/w8C1ngvCjEdqWQjAoITgX4D53FknMZVsYi+ndfsH1radRJkwyhtZcWfQqOCk7+1OisHdJ+l12cA3YuidL1Q8vPbiRCfqFYScLSn5q6GOrD/eYbqd+AeQWqNyZzJXOIM0vrEmrGNBgzNEbEOh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxrOJL9AVogEnDAA--.21929S3;
	Mon, 21 Apr 2025 15:31:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMBxn8U+9AVopeqNAA--.25751S6;
	Mon, 21 Apr 2025 15:31:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 4/5] KVM: selftests: Add ucall test support for LoongArch
Date: Mon, 21 Apr 2025 15:31:09 +0800
Message-Id: <20250421073110.2259397-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250421073110.2259397-1-maobibo@loongson.cn>
References: <20250421073110.2259397-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxn8U+9AVopeqNAA--.25751S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add ucall test support for LoongArch, ucall method on LoongArch uses
undefined mmio area. It will cause vCPU exits to hypervisor so that
hypervisor can communicate with vCPU.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/include/loongarch/ucall.h   | 20 ++++++++++
 .../selftests/kvm/lib/loongarch/ucall.c       | 38 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c

diff --git a/tools/testing/selftests/kvm/include/loongarch/ucall.h b/tools/testing/selftests/kvm/include/loongarch/ucall.h
new file mode 100644
index 000000000000..4ec801f37f00
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/loongarch/ucall.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_UCALL_H
+#define SELFTEST_KVM_UCALL_H
+
+#include "kvm_util.h"
+
+#define UCALL_EXIT_REASON       KVM_EXIT_MMIO
+
+/*
+ * ucall_exit_mmio_addr holds per-VM values (global data is duplicated by each
+ * VM), it must not be accessed from host code.
+ */
+extern vm_vaddr_t *ucall_exit_mmio_addr;
+
+static inline void ucall_arch_do_ucall(vm_vaddr_t uc)
+{
+	WRITE_ONCE(*ucall_exit_mmio_addr, uc);
+}
+
+#endif
diff --git a/tools/testing/selftests/kvm/lib/loongarch/ucall.c b/tools/testing/selftests/kvm/lib/loongarch/ucall.c
new file mode 100644
index 000000000000..fc6cbb50573f
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/loongarch/ucall.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucall support. A ucall is a "hypercall to userspace".
+ *
+ */
+#include "kvm_util.h"
+
+/*
+ * ucall_exit_mmio_addr holds per-VM values (global data is duplicated by each
+ * VM), it must not be accessed from host code.
+ */
+vm_vaddr_t *ucall_exit_mmio_addr;
+
+void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
+{
+	vm_vaddr_t mmio_gva = vm_vaddr_unused_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
+
+	virt_map(vm, mmio_gva, mmio_gpa, 1);
+
+	vm->ucall_mmio_addr = mmio_gpa;
+
+	write_guest_global(vm, ucall_exit_mmio_addr, (vm_vaddr_t *)mmio_gva);
+}
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	if (run->exit_reason == KVM_EXIT_MMIO &&
+	    run->mmio.phys_addr == vcpu->vm->ucall_mmio_addr) {
+		TEST_ASSERT(run->mmio.is_write && run->mmio.len == sizeof(uint64_t),
+			    "Unexpected ucall exit mmio address access");
+
+		return (void *)(*((uint64_t *)run->mmio.data));
+	}
+
+	return NULL;
+}
-- 
2.39.3


