Return-Path: <linux-kselftest+bounces-44477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E2C23211
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 518EC344536
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2930B50D;
	Fri, 31 Oct 2025 03:12:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9FD4C97;
	Fri, 31 Oct 2025 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880361; cv=none; b=bCNNr4KZ/WsZWyt83vgF1jqLhwisCGmTbBIVWgwk0u9oz/9gafzc9jLjOVaqqlWURmeSk504tv/LQ9AU9nHwUl9N6Rf6kayDUBVeK8h/7GvmWPf9jqSlkkerfxC/02f6gWoAchwiPfKNDPT6xu4yg7qWUohlfz6wipQZtmGVwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880361; c=relaxed/simple;
	bh=gz86dfn0DGmFu2yHhSbwFeWjke9Ber3pSX10dPmWSo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpQex2a4cfdpLw2KP6QfK9MFCoDUsz8H1DwCHq6mA2cpClEBQxfMjAwJlh1WxvPRCQgbU+LZsqynmcVF7rlYQ11FRYLi+23S3YFlzrGPshhIg5ecVcUUFakPWtsR8AMcbK4xm3dx1wMg55pRy4rxe0VQ7DwAwz0CKGZscamp+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axjr8hKQRpoewcAA--.60915S3;
	Fri, 31 Oct 2025 11:12:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxysAbKQRpGMkeAQ--.13727S4;
	Fri, 31 Oct 2025 11:12:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/6] KVM: LoongArch: selftests: Add exception handler register interface
Date: Fri, 31 Oct 2025 11:12:23 +0800
Message-Id: <20251031031227.4020738-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251031031227.4020738-1-maobibo@loongson.cn>
References: <20251031031227.4020738-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxysAbKQRpGMkeAQ--.13727S4
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


