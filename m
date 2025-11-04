Return-Path: <linux-kselftest+bounces-44710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A1C30C3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E2189F97E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B82EC080;
	Tue,  4 Nov 2025 11:37:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D52E8B97;
	Tue,  4 Nov 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256233; cv=none; b=M49t6JQQkXawDbn41sCoH3wXjyKx3GeE7lgp/24nySHe7DM9RVTqXShNbPVM6qD226xmACXIwPKz4kU1nUnIvu/dQA16uia2O4r3jTc067LztMrkfFldihAXPjiqCSl0F36ITZSP3154NWF6pMUNfC75kbpa1/c7MV88KJm0KmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256233; c=relaxed/simple;
	bh=gz86dfn0DGmFu2yHhSbwFeWjke9Ber3pSX10dPmWSo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmPvaoXmfZTdTwCnrUB3kOG+AyAPjWorB/VGAJC1+h9xj7cxbZRxlSjSI0SB2o54e9JGNIQ2BWvsszOQtwX5CfcKvGq5gGLBLsaDIj8BFJoCodYBr2eA6T2i8M2MWu+VZfLpa6a/XuvZL7xOu+JsMjF7OfJusi1VFmvt7Jxf+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dxvr9k5QlpZrQeAA--.64892S3;
	Tue, 04 Nov 2025 19:37:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxjcFk5QlpTjImAQ--.63810S2;
	Tue, 04 Nov 2025 19:37:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/7] KVM: LoongArch: selftests: Add exception handler register interface
Date: Tue,  4 Nov 2025 19:36:54 +0800
Message-Id: <20251104113700.1561752-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251104113700.1561752-1-maobibo@loongson.cn>
References: <20251104113700.1561752-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxjcFk5QlpTjImAQ--.63810S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add interrupt and exception handler register interface. When exception
happens, execute registered exception handler if exists, else report
error.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../kvm/include/loongarch/processor.h         | 14 +++++++++
 .../selftests/kvm/lib/loongarch/processor.c   | 29 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index 374caddfb0db..a18ac7bff303 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -84,6 +84,11 @@
 #define LOONGARCH_CSR_EUEN		0x2
 #define LOONGARCH_CSR_ECFG		0x4
 #define LOONGARCH_CSR_ESTAT		0x5  /* Exception status */
+#define  CSR_ESTAT_EXC_SHIFT		16
+#define  CSR_ESTAT_EXC_WIDTH		6
+#define  CSR_ESTAT_EXC			(0x3f << CSR_ESTAT_EXC_SHIFT)
+#define    EXCCODE_INT			0    /* Interrupt */
+#define      INT_TI			11   /* Timer interrupt*/
 #define LOONGARCH_CSR_ERA		0x6  /* ERA */
 #define LOONGARCH_CSR_BADV		0x7  /* Bad virtual address */
 #define LOONGARCH_CSR_EENTRY		0xc
@@ -133,6 +138,15 @@ struct ex_regs {
 #define PRMD_OFFSET_EXREGS		offsetof(struct ex_regs, prmd)
 #define EXREGS_SIZE			sizeof(struct ex_regs)
 
+#define VECTOR_NUM			64
+typedef void(*handler_fn)(struct ex_regs *);
+struct handlers {
+	handler_fn exception_handlers[VECTOR_NUM];
+};
+
+void vm_init_descriptor_tables(struct kvm_vm *vm);
+void vm_install_exception_handler(struct kvm_vm *vm, int vector, handler_fn handler);
+
 #else
 #define PC_OFFSET_EXREGS		((EXREGS_GPRS + 0) * 8)
 #define ESTAT_OFFSET_EXREGS		((EXREGS_GPRS + 1) * 8)
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 0ac1abcb71cb..be537c5ff74e 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -11,6 +11,7 @@
 #define LOONGARCH_GUEST_STACK_VADDR_MIN		0x200000
 
 static vm_paddr_t invalid_pgtable[4];
+static vm_vaddr_t exception_handlers;
 
 static uint64_t virt_pte_index(struct kvm_vm *vm, vm_vaddr_t gva, int level)
 {
@@ -184,6 +185,13 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 void route_exception(struct ex_regs *regs)
 {
 	unsigned long pc, estat, badv;
+	int vector;
+	struct handlers *handlers;
+
+	handlers = (struct handlers *)exception_handlers;
+	vector = (regs->estat & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
+	if (handlers && handlers->exception_handlers[vector])
+		return handlers->exception_handlers[vector](regs);
 
 	pc = regs->pc;
 	badv  = regs->badv;
@@ -192,6 +200,27 @@ void route_exception(struct ex_regs *regs)
 	while (1) ;
 }
 
+void vm_init_descriptor_tables(struct kvm_vm *vm)
+{
+	void *addr;
+
+	vm->handlers = __vm_vaddr_alloc(vm, sizeof(struct handlers),
+			LOONGARCH_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
+
+	addr = addr_gva2hva(vm, vm->handlers);
+	memset(addr, 0, vm->page_size);
+	exception_handlers = vm->handlers;
+	sync_global_to_guest(vm, exception_handlers);
+}
+
+void vm_install_exception_handler(struct kvm_vm *vm, int vector, handler_fn handler)
+{
+	struct handlers *handlers = addr_gva2hva(vm, vm->handlers);
+
+	assert(vector < VECTOR_NUM);
+	handlers->exception_handlers[vector] = handler;
+}
+
 void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 {
 	int i;
-- 
2.39.3


