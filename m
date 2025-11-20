Return-Path: <linux-kselftest+bounces-46069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC959C72776
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AD86F2A31C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E1305942;
	Thu, 20 Nov 2025 06:58:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854B230146A;
	Thu, 20 Nov 2025 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621906; cv=none; b=HdithDV4/TwBo5lHu95DfO9bY3BYwP0HQ3covGLiLB/J/qhX20YWSmH8Ncnecuv1g+Fjwi6U+XuDf67b9b0xRH1vvLPalkgtetY/2LIpWo4rzckwuAhm89Mksg6ugSfB2lKM78mm5ffxRcwHbB8YqVsfI/434o9xqba5LQxJoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621906; c=relaxed/simple;
	bh=Hrayqg9KoT2jTaTXtUgtYEvgDpoR9jSt23jxQa+Sthc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nui4Fr7RhLae3BjK9MFIIo9awaNE1lcyit4S/cEypWS45GelCrCgkhucdgTbiRV7Y5Bw49CUPEw3tKx0ufiJKbwkw/avb6qbwzWPOBU4J0tZnvYW0qB1VugsqeJXsICQKOVq/Se05zSGSrDUvfF5xAQ2B/q86NmaztJqeBGaR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxJ9EJvB5pBP8lAA--.15859S3;
	Thu, 20 Nov 2025 14:58:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxicD3ux5pSkU5AQ--.5850S5;
	Thu, 20 Nov 2025 14:58:16 +0800 (CST)
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
Subject: [PATCH v3 3/6] KVM: LoongArch: selftests: Add exception handler register interface
Date: Thu, 20 Nov 2025 14:57:55 +0800
Message-Id: <20251120065758.3064368-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251120065758.3064368-1-maobibo@loongson.cn>
References: <20251120065758.3064368-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxicD3ux5pSkU5AQ--.5850S5
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
index 0bf120d23092..b027f8f4dac7 100644
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
@@ -155,6 +160,15 @@ struct ex_regs {
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
 static inline void local_irq_enable(void)
 {
 	unsigned int flags = CSR_CRMD_IE;
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 5b5f09acf229..20ba476ccb72 100644
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


