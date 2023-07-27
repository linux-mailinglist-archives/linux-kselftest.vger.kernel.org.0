Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8976488B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjG0HZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjG0HYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:24:21 -0400
Received: from mgamail.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CD65AA;
        Thu, 27 Jul 2023 00:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690442133; x=1721978133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//1/LLYO5oApTbEBhVCPVL/NEfjxItf5NDXvgd2wGBs=;
  b=AXqLtSoZecCZXEDhL2OmnVV/aEmIrGrHNBvy6jRkPaEeEPtkD/UCzqIG
   x3BK1YC5ur69ZGYgN5RyA5DCzxw4Pt6BsDXb4gyylJ3vW0KCx2WhibueH
   /tRw6KtT4wTOicLb6wsyWjm+a1UIUmQtQUvW1Fd+Vi3w7IOKr4So+hmXl
   tkbcLOK7jmGP4iYsPcRvTQpY1ftjM9+HHjPwq6bWMk4WRTLoL2bG7Y7FK
   bZ1zbIyvD5gsWLeC0duUW18Bg0rzekDzHhd09fbHpscUOHYRHndPt8At0
   CbLyJMkJE3Cn1NA82g+peg3iQt7Sgdl4CT+8ffLu2jqZRjssNkBw9SC7k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367102239"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367102239"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720785822"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720785822"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:31 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Colton Lewis <coltonlewis@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 2/4] KVM: riscv: selftests: Add exception handling support
Date:   Thu, 27 Jul 2023 15:20:06 +0800
Message-Id: <7e9d2d5518375083f10c92a3d1acd98914f69fd8.1690364259.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690364259.git.haibo1.xu@intel.com>
References: <cover.1690364259.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the infrastructure for exception handling in riscv selftests.
Currently, the guest_unexp_trap handler was used by default, which
aborts the test. Customized handlers can be enabled by calling
vm_install_exception_handler(vector) or vm_install_interrupt_handler().

The code is inspired from that of x86/arm64.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/riscv/processor.h   |  49 +++++++++
 .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++++++++++++++++
 .../selftests/kvm/lib/riscv/processor.c       |  57 ++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c692cc86e7da..70f3a5ba991e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -52,6 +52,7 @@ LIBKVM_s390x += lib/s390x/diag318_test_handler.c
 LIBKVM_s390x += lib/s390x/processor.c
 LIBKVM_s390x += lib/s390x/ucall.c
 
+LIBKVM_riscv += lib/riscv/handlers.S
 LIBKVM_riscv += lib/riscv/processor.c
 LIBKVM_riscv += lib/riscv/ucall.c
 
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index d00d213c3805..9ea6e7bedc61 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -9,6 +9,7 @@
 
 #include "kvm_util.h"
 #include <linux/stringify.h>
+#include <asm/csr.h>
 
 static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 				    uint64_t  size)
@@ -38,6 +39,54 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 					     KVM_REG_RISCV_TIMER_REG(name), \
 					     KVM_REG_SIZE_U64)
 
+struct ex_regs {
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+	unsigned long epc;
+	unsigned long status;
+	unsigned long cause;
+};
+
+#define VECTOR_NUM  2
+#define EC_NUM  32
+#define EC_MASK  (EC_NUM - 1)
+
+void vm_init_trap_vector_tables(struct kvm_vm *vm);
+void vcpu_init_trap_vector_tables(struct kvm_vcpu *vcpu);
+
+typedef void(*handler_fn)(struct ex_regs *);
+void vm_install_exception_handler(struct kvm_vm *vm, int ec, handler_fn handler);
+void vm_install_interrupt_handler(struct kvm_vm *vm, handler_fn handler);
+
 /* L3 index Bit[47:39] */
 #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
 #define PGTBL_L3_INDEX_SHIFT			39
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
new file mode 100644
index 000000000000..ce0b1d5415b9
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Intel Corporation
+ */
+
+#include <asm/csr.h>
+
+.macro save_context
+	addi sp, sp, (-8*34)
+
+	sd x1, 0(sp)
+	sd x2, 8(sp)
+	sd x3, 16(sp)
+	sd x4, 24(sp)
+	sd x5, 32(sp)
+	sd x6, 40(sp)
+	sd x7, 48(sp)
+	sd x8, 56(sp)
+	sd x9, 64(sp)
+	sd x10, 72(sp)
+	sd x11, 80(sp)
+	sd x12, 88(sp)
+	sd x13, 96(sp)
+	sd x14, 104(sp)
+	sd x15, 112(sp)
+	sd x16, 120(sp)
+	sd x17, 128(sp)
+	sd x18, 136(sp)
+	sd x19, 144(sp)
+	sd x20, 152(sp)
+	sd x21, 160(sp)
+	sd x22, 168(sp)
+	sd x23, 176(sp)
+	sd x24, 184(sp)
+	sd x25, 192(sp)
+	sd x26, 200(sp)
+	sd x27, 208(sp)
+	sd x28, 216(sp)
+	sd x29, 224(sp)
+	sd x30, 232(sp)
+	sd x31, 240(sp)
+
+	csrr s0, CSR_SEPC
+	csrr s1, CSR_SSTATUS
+	csrr s2, CSR_SCAUSE
+	sd s0, 248(sp)
+	sd s1, 256(sp)
+	sd s2, 264(sp)
+.endm
+
+.balign 4
+.global exception_vectors
+exception_vectors:
+	save_context
+	move a0, sp
+	la ra, ret_from_exception
+	tail route_exception
+
+.global ret_from_exception
+ret_from_exception:
+	ld s2, 264(sp)
+	ld s1, 256(sp)
+	ld s0, 248(sp)
+	csrw CSR_SCAUSE, s2
+	csrw CSR_SSTATUS, s1
+	csrw CSR_SEPC, s0
+
+	ld x31, 240(sp)
+	ld x30, 232(sp)
+	ld x29, 224(sp)
+	ld x28, 216(sp)
+	ld x27, 208(sp)
+	ld x26, 200(sp)
+	ld x25, 192(sp)
+	ld x24, 184(sp)
+	ld x23, 176(sp)
+	ld x22, 168(sp)
+	ld x21, 160(sp)
+	ld x20, 152(sp)
+	ld x19, 144(sp)
+	ld x18, 136(sp)
+	ld x17, 128(sp)
+	ld x16, 120(sp)
+	ld x15, 112(sp)
+	ld x14, 104(sp)
+	ld x13, 96(sp)
+	ld x12, 88(sp)
+	ld x11, 80(sp)
+	ld x10, 72(sp)
+	ld x9, 64(sp)
+	ld x8, 56(sp)
+	ld x7, 48(sp)
+	ld x6, 40(sp)
+	ld x5, 32(sp)
+	ld x4, 24(sp)
+	ld x3, 16(sp)
+	ld x2, 8(sp)
+	ld x1, 0(sp)
+
+	addi sp, sp, (8*34)
+	sret
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d146ca71e0c0..f1b0be58a5dc 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -13,6 +13,8 @@
 
 #define DEFAULT_RISCV_GUEST_STACK_VADDR_MIN	0xac0000
 
+static vm_vaddr_t exception_handlers;
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
@@ -367,3 +369,58 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+struct handlers {
+	handler_fn exception_handlers[VECTOR_NUM][EC_NUM];
+};
+
+void route_exception(struct ex_regs *regs)
+{
+	struct handlers *handlers = (struct handlers *)exception_handlers;
+	int vector = 0, ec;
+
+	ec = regs->cause & ~CAUSE_IRQ_FLAG;
+	if (ec >= EC_NUM)
+		goto guest_unexpected_trap;
+
+	/* Use the same handler for all the interrupts */
+	if (regs->cause & CAUSE_IRQ_FLAG) {
+		vector = 1;
+		ec = 0;
+	}
+
+	if (handlers && handlers->exception_handlers[vector][ec])
+		return handlers->exception_handlers[vector][ec](regs);
+
+guest_unexpected_trap:
+	return guest_unexp_trap();
+}
+
+void vcpu_init_trap_vector_tables(struct kvm_vcpu *vcpu)
+{
+	extern char exception_vectors;
+
+	vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)&exception_vectors);
+}
+
+void vm_init_trap_vector_tables(struct kvm_vm *vm)
+{
+	vm->handlers = __vm_vaddr_alloc(vm, sizeof(struct handlers),
+				   vm->page_size, MEM_REGION_DATA);
+
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
+void vm_install_exception_handler(struct kvm_vm *vm, int ec, void (*handler)(struct ex_regs *))
+{
+	struct handlers *handlers = addr_gva2hva(vm, vm->handlers);
+
+	handlers->exception_handlers[0][ec] = handler;
+}
+
+void vm_install_interrupt_handler(struct kvm_vm *vm, void (*handler)(struct ex_regs *))
+{
+	struct handlers *handlers = addr_gva2hva(vm, vm->handlers);
+
+	handlers->exception_handlers[1][0] = handler;
+}
-- 
2.34.1

