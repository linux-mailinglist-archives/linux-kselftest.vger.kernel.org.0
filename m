Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9E7907EC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbjIBMxi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352209AbjIBMxi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 08:53:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC71713;
        Sat,  2 Sep 2023 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693659195; x=1725195195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Qt+Lm1X8zeQJ+s6KDfuGbIkk7BsKRBdYVINlOSAMDc=;
  b=bBlZHU3Mmi1fW6qX56gmkXX9OFoDjCiUi66nzuNsvuyCnr09e2XwMp6W
   64USR4msAbnzQ+McaOsoIQ4aYo2gJJoxDYQ677Vz242gihc7QeZdyEAzZ
   btcwkf6RxOHt0dvbck2m7kJYuW3a3ZnufMsbHAqN67plVRQfzySfIoj3l
   tzGOJBti9kY9MsksoWfSxdH8TFbG6+tvF+iOyoTV8U0VsalU/7PUsccIf
   aJYKXyF8SznKBL7n5vOK9tWn385ci4C64OEBUksylu4iIns6DDiGls15K
   bc7kxO12XMnK6zXou1QsrbtB5f+U3iaIU4j2kYW+XeG0niXgu3bRqZQLL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366599360"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366599360"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855022128"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="855022128"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:53:05 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, wchen <waylingii@gmail.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v2 5/8] KVM: riscv: selftests: Add exception handling support
Date:   Sat,  2 Sep 2023 20:59:27 +0800
Message-Id: <ff41e98a062e0fbb5c2d8dc26d9e4e02c4ce3ea8.1693659382.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693659382.git.haibo1.xu@intel.com>
References: <cover.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the infrastructure for guest exception handling in riscv selftests.
Customized handlers can be enabled by vm_install_exception_handler(vector)
or vm_install_interrupt_handler().

The code is inspired from that of x86/arm64.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/riscv/processor.h   |  43 ++++++++
 .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++++++++++++++++
 .../selftests/kvm/lib/riscv/processor.c       |  69 ++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index fb8904e2c06a..01638027d059 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -53,6 +53,7 @@ LIBKVM_s390x += lib/s390x/diag318_test_handler.c
 LIBKVM_s390x += lib/s390x/processor.c
 LIBKVM_s390x += lib/s390x/ucall.c
 
+LIBKVM_riscv += lib/riscv/handlers.S
 LIBKVM_riscv += lib/riscv/processor.c
 LIBKVM_riscv += lib/riscv/ucall.c
 
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 6810c887fadc..d1e5d9f7ad45 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -42,6 +42,49 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
 					     idx, KVM_REG_SIZE_ULONG)
 
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
+#define NR_VECTORS  2
+#define NR_EXCEPTIONS  32
+#define EC_MASK  (NR_EXCEPTIONS - 1)
+
+void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handler);
+
 /* L3 index Bit[47:39] */
 #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
 #define PGTBL_L3_INDEX_SHIFT			39
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
new file mode 100644
index 000000000000..877ca32d8f94
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Intel Corporation
+ */
+
+#ifndef __ASSEMBLY__
+#define __ASSEMBLY__
+#endif
+
+#include <asm/csr.h>
+
+.macro save_context
+	addi  sp, sp, (-8*34)
+	sd    x1, 0(sp)
+	sd    x2, 8(sp)
+	sd    x3, 16(sp)
+	sd    x4, 24(sp)
+	sd    x5, 32(sp)
+	sd    x6, 40(sp)
+	sd    x7, 48(sp)
+	sd    x8, 56(sp)
+	sd    x9, 64(sp)
+	sd    x10, 72(sp)
+	sd    x11, 80(sp)
+	sd    x12, 88(sp)
+	sd    x13, 96(sp)
+	sd    x14, 104(sp)
+	sd    x15, 112(sp)
+	sd    x16, 120(sp)
+	sd    x17, 128(sp)
+	sd    x18, 136(sp)
+	sd    x19, 144(sp)
+	sd    x20, 152(sp)
+	sd    x21, 160(sp)
+	sd    x22, 168(sp)
+	sd    x23, 176(sp)
+	sd    x24, 184(sp)
+	sd    x25, 192(sp)
+	sd    x26, 200(sp)
+	sd    x27, 208(sp)
+	sd    x28, 216(sp)
+	sd    x29, 224(sp)
+	sd    x30, 232(sp)
+	sd    x31, 240(sp)
+	csrr  s0, CSR_SEPC
+	csrr  s1, CSR_SSTATUS
+	csrr  s2, CSR_SCAUSE
+	sd    s0, 248(sp)
+	sd    s1, 256(sp)
+	sd    s2, 264(sp)
+.endm
+
+.macro restore_context
+	ld    s2, 264(sp)
+	ld    s1, 256(sp)
+	ld    s0, 248(sp)
+	csrw  CSR_SCAUSE, s2
+	csrw  CSR_SSTATUS, s1
+	csrw  CSR_SEPC, s0
+	ld    x31, 240(sp)
+	ld    x30, 232(sp)
+	ld    x29, 224(sp)
+	ld    x28, 216(sp)
+	ld    x27, 208(sp)
+	ld    x26, 200(sp)
+	ld    x25, 192(sp)
+	ld    x24, 184(sp)
+	ld    x23, 176(sp)
+	ld    x22, 168(sp)
+	ld    x21, 160(sp)
+	ld    x20, 152(sp)
+	ld    x19, 144(sp)
+	ld    x18, 136(sp)
+	ld    x17, 128(sp)
+	ld    x16, 120(sp)
+	ld    x15, 112(sp)
+	ld    x14, 104(sp)
+	ld    x13, 96(sp)
+	ld    x12, 88(sp)
+	ld    x11, 80(sp)
+	ld    x10, 72(sp)
+	ld    x9, 64(sp)
+	ld    x8, 56(sp)
+	ld    x7, 48(sp)
+	ld    x6, 40(sp)
+	ld    x5, 32(sp)
+	ld    x4, 24(sp)
+	ld    x3, 16(sp)
+	ld    x2, 8(sp)
+	ld    x1, 0(sp)
+	addi  sp, sp, (8*34)
+.endm
+
+.balign 4
+.global exception_vectors
+exception_vectors:
+	save_context
+	move  a0, sp
+	call  route_exception
+	restore_context
+	sret
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d146ca71e0c0..efd9ac4b0198 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -13,6 +13,8 @@
 
 #define DEFAULT_RISCV_GUEST_STACK_VADDR_MIN	0xac0000
 
+static vm_vaddr_t exception_handlers;
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
@@ -364,6 +366,73 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	va_end(ap);
 }
 
+void kvm_exit_unexpected_exception(int vector, int ec)
+{
+	ucall(UCALL_UNHANDLED, 2, vector, ec);
+}
+
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
+	struct ucall uc;
+
+	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
+		TEST_FAIL("Unexpected exception (vector:0x%lx, ec:0x%lx)",
+			uc.args[0], uc.args[1]);
+	}
+}
+
+struct handlers {
+	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
+};
+
+void route_exception(struct ex_regs *regs)
+{
+	struct handlers *handlers = (struct handlers *)exception_handlers;
+	int vector = 0, ec;
+
+	ec = regs->cause & ~CAUSE_IRQ_FLAG;
+	if (ec >= NR_EXCEPTIONS)
+		goto unexpected_exception;
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
+unexpected_exception:
+	return kvm_exit_unexpected_exception(vector, ec);
+}
+
+void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
+{
+	extern char exception_vectors;
+
+	vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)&exception_vectors);
+}
+
+void vm_init_vector_tables(struct kvm_vm *vm)
+{
+	vm->handlers = __vm_vaddr_alloc(vm, sizeof(struct handlers),
+				   vm->page_size, MEM_REGION_DATA);
+
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
+void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handler_fn handler)
+{
+	struct handlers *handlers = addr_gva2hva(vm, vm->handlers);
+
+	assert(vector < NR_EXCEPTIONS);
+	handlers->exception_handlers[0][vector] = handler;
+}
+
+void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handler)
+{
+	struct handlers *handlers = addr_gva2hva(vm, vm->handlers);
+
+	handlers->exception_handlers[1][0] = handler;
 }
-- 
2.34.1

