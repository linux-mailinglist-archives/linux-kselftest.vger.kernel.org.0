Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9745D76256E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGYWDS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGYWCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:34 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A52680
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56336f5dc6cso2586654a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322517; x=1690927317;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0Cy1JJQ6W+mMSYpV8ot9WFSqmG5vy/p7KmZlVLqb2Q=;
        b=GrI1WzSfJbLd1bAk+LDGPC7v1KFop7dUP7mVMTqDbF9O88oZC9BxeDAjiXf6YJfPf/
         9Ttezz38iH4WfnBP1j70LLinMVvxdCZ6k7/uasoRmCWHVJvXaPx5+X5uKfoxz48C/Nai
         y/qfajSu8CJKk9th0NH9svAHDH4THdveDEsblpzXxhn4FPZtwqos7crviiV+3u2trq7T
         2HM5a5Jwh77QbGSmSaDDWimT8EfEZq/9frgYa9armkhCZly9HaJb91RaWqvkBvs5PKF7
         5yQiqIUPRgAJOU2DDC4OGrE+TJ59hLysuBmBaOzjx0/CiELXA4iGTCwaqQbiRGNSvp2v
         Vxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322517; x=1690927317;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0Cy1JJQ6W+mMSYpV8ot9WFSqmG5vy/p7KmZlVLqb2Q=;
        b=QaXoxpZKi5XHRc75/nxFdXIyT9Q44oYhJJ20OSOGKDwojt6c6EPYvc2cttqRRv0NUB
         O/ZPHo97dqT2wKn5q2eBnwoAD1zHvL5IQKZhuOH7op5wQGpexY6GEWJ/+gE+kwvAunau
         xq5+6VRg8jzbiGAog5G47/gk003T9K5Fa0S6p5wom5ny0pml6RoKBLKKgF+IZ8efOOlr
         tlR5qXwbO1on4TVAq6PAD965V9jSSIb6o0gnJBe6c2XExeT3gitmaA0Ljus+QU6EvCEH
         ElP7jDdFF4RvWAkbO7p0GIgcT8vETMVvigFFERrz6ts2AcA0ya7/l4PnHJoY7Nx8w2wB
         3VVA==
X-Gm-Message-State: ABy/qLZgBO7PiGiT98JHwN8lonjiXjzZMt9U4DlL4OxHfiHm7jwLkgGY
        3IgJNhVtjsNJJs+d9LSiKIjiOf7C6KkSITQ6vwCEpn7MF1qkSj5zSzlHTvjn228N3GEZgEEesi/
        /ARY21fEXci+gk/4BnqZP8HUeXbtWFNhb1XAjqPMVFdNxlh1Xc5hvG0Vix0hzpEc3KjtYK0OafM
        rb
X-Google-Smtp-Source: APBJJlGVxuBI95IrcHnQMp293zFs2mdZ6auFF8Neo0rC+ilGkQOKVzSRrOitCjspsO7Pf5xuUBb4NhwS2cL6
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:3855:0:b0:543:b015:600b with SMTP id
 h21-20020a633855000000b00543b015600bmr2102pgn.8.1690322516339; Tue, 25 Jul
 2023 15:01:56 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:58 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-6-afranji@google.com>
Subject: [PATCH v4 05/28] KVM: selftests: Add helper functions to create TDX VMs
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Erdem Aktas <erdemaktas@google.com>

TDX requires additional IOCTLs to initialize VM and vCPUs to add
private memory and to finalize the VM memory. Also additional utility
functions are provided to manipulate a TD, similar to those that
manipulate a VM in the current selftest framework.

A TD's initial register state cannot be manipulated directly by
setting the VM's memory, hence boot code is provided at the TD's reset
vector. This boot code takes boot parameters loaded in the TD's memory
and sets up the TD for the selftest.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I3bad2e7004da358ae78a0892293e992e8e30f70d
---
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |   4 +
 .../kvm/include/x86_64/tdx/td_boot.h          |  82 ++++
 .../kvm/include/x86_64/tdx/td_boot_asm.h      |  16 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |  16 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   2 +-
 .../selftests/kvm/lib/x86_64/tdx/td_boot.S    | 101 ++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 441 ++++++++++++++++++
 8 files changed, 663 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.=
h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_=
asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util=
.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests=
/kvm/Makefile
index 04f3ac6ee117..9b2210b64ab5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -39,6 +39,8 @@ LIBKVM_x86_64 +=3D lib/x86_64/processor.c
 LIBKVM_x86_64 +=3D lib/x86_64/svm.c
 LIBKVM_x86_64 +=3D lib/x86_64/ucall.c
 LIBKVM_x86_64 +=3D lib/x86_64/vmx.c
+LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdx_util.c
+LIBKVM_x86_64 +=3D lib/x86_64/tdx/td_boot.S
=20
 LIBKVM_aarch64 +=3D lib/aarch64/gic.c
 LIBKVM_aarch64 +=3D lib/aarch64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/te=
sting/selftests/kvm/include/kvm_util_base.h
index 12524d94a4eb..6ed57162b49d 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -792,6 +792,10 @@ static inline vm_paddr_t vm_phy_pages_alloc(struct kvm=
_vm *vm, size_t num,
 	return _vm_phy_pages_alloc(vm, num, paddr_min, memslot, vm->protected);
 }
=20
+uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
+			      uint32_t nr_runnable_vcpus,
+			      uint64_t extra_mem_pages);
+
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
  * loads the test binary into guest memory and creates an IRQ chip (x86 on=
ly).
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.h b/too=
ls/testing/selftests/kvm/include/x86_64/tdx/td_boot.h
new file mode 100644
index 000000000000..148057e569d6
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_H
+#define SELFTEST_TDX_TD_BOOT_H
+
+#include <stdint.h>
+#include "tdx/td_boot_asm.h"
+
+/*
+ * Layout for boot section (not to scale)
+ *
+ *                                  GPA
+ * =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=
=800x1_0000_0000 (4GB)
+ * =E2=94=82   Boot code trampoline      =E2=94=82
+ * =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=800x0_ffff_fff0: Reset vector (16B below 4GB)
+ * =E2=94=82   Boot code                 =E2=94=82
+ * =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=80td_boot will be copied here, so that the
+ * =E2=94=82                             =E2=94=82  jmp to td_boot is exac=
tly at the reset vector
+ * =E2=94=82   Empty space               =E2=94=82
+ * =E2=94=82                             =E2=94=82
+ * =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
+ * =E2=94=82                             =E2=94=82
+ * =E2=94=82                             =E2=94=82
+ * =E2=94=82   Boot parameters           =E2=94=82
+ * =E2=94=82                             =E2=94=82
+ * =E2=94=82                             =E2=94=82
+ * =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=
=800x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
+ */
+#define FOUR_GIGABYTES_GPA (4ULL << 30)
+
+/**
+ * The exact memory layout for LGDT or LIDT instructions.
+ */
+struct __packed td_boot_parameters_dtr {
+	uint16_t limit;
+	uint32_t base;
+};
+
+/**
+ * The exact layout in memory required for a ljmp, including the selector =
for
+ * changing code segment.
+ */
+struct __packed td_boot_parameters_ljmp_target {
+	uint32_t eip_gva;
+	uint16_t code64_sel;
+};
+
+/**
+ * Allows each vCPU to be initialized with different eip and esp.
+ */
+struct __packed td_per_vcpu_parameters {
+	uint32_t esp_gva;
+	struct td_boot_parameters_ljmp_target ljmp_target;
+};
+
+/**
+ * Boot parameters for the TD.
+ *
+ * Unlike a regular VM, we can't ask KVM to set registers such as esp, eip=
, etc
+ * before boot, so to run selftests, these registers' values have to be
+ * initialized by the TD.
+ *
+ * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
+ *
+ * The TD boot code will read off parameters from this struct and set up t=
he
+ * vcpu for executing selftests.
+ */
+struct __packed td_boot_parameters {
+	uint32_t cr0;
+	uint32_t cr3;
+	uint32_t cr4;
+	struct td_boot_parameters_dtr gdtr;
+	struct td_boot_parameters_dtr idtr;
+	struct td_per_vcpu_parameters per_vcpu[];
+};
+
+extern void td_boot(void);
+extern void reset_vector(void);
+extern void td_boot_code_end(void);
+
+#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
+
+#endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h b=
/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h
new file mode 100644
index 000000000000..0a07104f7deb
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_asm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_ASM_H
+#define SELFTEST_TDX_TD_BOOT_ASM_H
+
+/*
+ * GPA where TD boot parameters wil lbe loaded.
+ *
+ * TD_BOOT_PARAMETERS_GPA is arbitrarily chosen to
+ *
+ * + be within the 4GB address space
+ * + provide enough contiguous memory for the struct td_boot_parameters su=
ch
+ *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
+ */
+#define TD_BOOT_PARAMETERS_GPA 0xffff0000
+
+#endif  // SELFTEST_TDX_TD_BOOT_ASM_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h b/to=
ols/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
new file mode 100644
index 000000000000..274b245f200b
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_KVM_UTIL_H
+#define SELFTESTS_TDX_KVM_UTIL_H
+
+#include <stdint.h>
+
+#include "kvm_util_base.h"
+
+struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *gu=
est_code);
+
+struct kvm_vm *td_create(void);
+void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_typ=
e,
+		   uint64_t attributes);
+void td_finalize(struct kvm_vm *vm);
+
+#endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/sel=
ftests/kvm/lib/kvm_util.c
index 5bbcddcd6796..e2a0d979b54f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -309,7 +309,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	return vm;
 }
=20
-static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
+uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 				     uint32_t nr_runnable_vcpus,
 				     uint64_t extra_mem_pages)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S b/tools/t=
esting/selftests/kvm/lib/x86_64/tdx/td_boot.S
new file mode 100644
index 000000000000..800e09264d4e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "tdx/td_boot_asm.h"
+
+/* Offsets for reading struct td_boot_parameters */
+#define TD_BOOT_PARAMETERS_CR0         0
+#define TD_BOOT_PARAMETERS_CR3         4
+#define TD_BOOT_PARAMETERS_CR4         8
+#define TD_BOOT_PARAMETERS_GDT         12
+#define TD_BOOT_PARAMETERS_IDT         18
+#define TD_BOOT_PARAMETERS_PER_VCPU    24
+
+/* Offsets for reading struct td_per_vcpu_parameters */
+#define TD_PER_VCPU_PARAMETERS_ESP_GVA     0
+#define TD_PER_VCPU_PARAMETERS_LJMP_TARGET 4
+
+#define SIZEOF_TD_PER_VCPU_PARAMETERS      10
+
+.code32
+
+.globl td_boot
+td_boot:
+	/* In this procedure, edi is used as a temporary register */
+	cli
+
+	/* Paging is off */
+
+	movl $TD_BOOT_PARAMETERS_GPA, %ebx
+
+	/*
+	 * Find the address of struct td_per_vcpu_parameters for this
+	 * vCPU based on esi (TDX spec: initialized with vcpu id). Put
+	 * struct address into register for indirect addressing
+	 */
+	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
+	mul %esi
+	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
+	addl %edi, %eax
+
+	/* Setup stack */
+	movl TD_PER_VCPU_PARAMETERS_ESP_GVA(%eax), %esp
+
+	/* Setup GDT */
+	leal TD_BOOT_PARAMETERS_GDT(%ebx), %edi
+	lgdt (%edi)
+
+	/* Setup IDT */
+	leal TD_BOOT_PARAMETERS_IDT(%ebx), %edi
+	lidt (%edi)
+
+	/*
+	 * Set up control registers (There are no instructions to
+	 * mov from memory to control registers, hence we need to use ebx
+	 * as a scratch register)
+	 */
+	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
+	movl %edi, %cr4
+	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
+	movl %edi, %cr3
+	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
+	movl %edi, %cr0
+
+	/* Paging is on after setting the most significant bit on cr0 */
+
+	/*
+	 * Jump to selftest guest code. Far jumps read <segment
+	 * selector:new eip> from <addr+4:addr>. This location has
+	 * already been set up in boot parameters, and we can read boot
+	 * parameters because boot code and boot parameters are loaded so
+	 * that GVA and GPA are mapped 1:1.
+	 */
+	ljmp *TD_PER_VCPU_PARAMETERS_LJMP_TARGET(%eax)
+
+.globl reset_vector
+reset_vector:
+	jmp td_boot
+	/*
+	 * Pad reset_vector to its full size of 16 bytes so that this
+	 * can be loaded with the end of reset_vector aligned to GPA=3D4G
+	 */
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+	int3
+
+/* Leave marker so size of td_boot code can be computed */
+.globl td_boot_code_end
+td_boot_code_end:
+
+/* Disable executable stack */
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/=
testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
new file mode 100644
index 000000000000..c90ad29f7733
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <asm/kvm.h>
+#include <asm/kvm_host.h>
+#include <errno.h>
+#include <linux/kvm.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "tdx/td_boot.h"
+#include "kvm_util_base.h"
+#include "processor.h"
+
+/*
+ * TDX ioctls
+ */
+
+static char *tdx_cmd_str[] =3D {
+	"KVM_TDX_CAPABILITIES",
+	"KVM_TDX_INIT_VM",
+	"KVM_TDX_INIT_VCPU",
+	"KVM_TDX_INIT_MEM_REGION",
+	"KVM_TDX_FINALIZE_VM"
+};
+#define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	struct kvm_tdx_cmd tdx_cmd;
+	int r;
+
+	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
+		    ioctl_no);
+
+	memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
+	tdx_cmd.id =3D ioctl_no;
+	tdx_cmd.flags =3D flags;
+	tdx_cmd.data =3D (uint64_t)data;
+
+	r =3D ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	TEST_ASSERT(r =3D=3D 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
+		    errno);
+}
+
+#define XFEATURE_LBR 15
+#define XFEATURE_CET_U 11
+#define XFEATURE_CET_S 12
+
+#define XFEATURE_MASK_LBR (1 << XFEATURE_LBR)
+#define XFEATURE_MASK_CET_U (1 << XFEATURE_CET_U)
+#define XFEATURE_MASK_CET_S (1 << XFEATURE_CET_S)
+#define XFEATURE_MASK_CET (XFEATURE_MASK_CET_U | XFEATURE_MASK_CET_S)
+
+static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
+{
+	for (int i =3D 0; i < cpuid_data->nent; i++) {
+		struct kvm_cpuid_entry2 *e =3D &cpuid_data->entries[i];
+
+		if (e->function =3D=3D 0xd && e->index =3D=3D 0) {
+			/*
+			 * TDX module requires both XTILE_{CFG, DATA} to be set.
+			 * Both bits are required for AMX to be functional.
+			 */
+			if ((e->eax & XFEATURE_MASK_XTILE) !=3D
+			    XFEATURE_MASK_XTILE) {
+				e->eax &=3D ~XFEATURE_MASK_XTILE;
+			}
+		}
+		if (e->function =3D=3D 0xd && e->index =3D=3D 1) {
+			/*
+			 * TDX doesn't support LBR yet.
+			 * Disable bits from the XCR0 register.
+			 */
+			e->ecx &=3D ~XFEATURE_MASK_LBR;
+			/*
+			 * TDX modules requires both CET_{U, S} to be set even
+			 * if only one is supported.
+			 */
+			if (e->ecx & XFEATURE_MASK_CET)
+				e->ecx |=3D XFEATURE_MASK_CET;
+		}
+	}
+}
+
+static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
+{
+	const struct kvm_cpuid2 *cpuid;
+	struct kvm_tdx_init_vm *init_vm;
+
+	cpuid =3D kvm_get_supported_cpuid();
+
+	init_vm =3D malloc(sizeof(*init_vm) +
+			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
+
+	memset(init_vm, 0, sizeof(*init_vm));
+	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
+
+	init_vm->attributes =3D attributes;
+
+	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
+
+	tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, init_vm);
+}
+
+static void tdx_td_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	const struct kvm_cpuid2 *cpuid =3D kvm_get_supported_cpuid();
+
+	vcpu_init_cpuid(vcpu, cpuid);
+	tdx_ioctl(vcpu->fd, KVM_TDX_INIT_VCPU, 0, NULL);
+}
+
+static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
+				uint64_t gpa, uint64_t size)
+{
+	struct kvm_tdx_init_mem_region mem_region =3D {
+		.source_addr =3D (uint64_t)source_pages,
+		.gpa =3D gpa,
+		.nr_pages =3D size / PAGE_SIZE,
+	};
+	uint32_t metadata =3D KVM_TDX_MEASURE_MEMORY_REGION;
+
+	TEST_ASSERT((mem_region.nr_pages > 0) &&
+			    ((mem_region.nr_pages * PAGE_SIZE) =3D=3D size),
+		    "Cannot add partial pages to the guest memory.\n");
+	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) =3D=3D 0,
+		    "Source memory buffer is not page aligned\n");
+	tdx_ioctl(vm->fd, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
+}
+
+static void tdx_td_finalizemr(struct kvm_vm *vm)
+{
+	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
+}
+
+/*
+ * TD creation/setup/finalization
+ */
+
+static void tdx_enable_capabilities(struct kvm_vm *vm)
+{
+	int rc;
+
+	rc =3D kvm_check_cap(KVM_CAP_X2APIC_API);
+	TEST_ASSERT(rc, "TDX: KVM_CAP_X2APIC_API is not supported!");
+	rc =3D kvm_check_cap(KVM_CAP_SPLIT_IRQCHIP);
+	TEST_ASSERT(rc, "TDX: KVM_CAP_SPLIT_IRQCHIP is not supported!");
+
+	vm_enable_cap(vm, KVM_CAP_X2APIC_API,
+		      KVM_X2APIC_API_USE_32BIT_IDS |
+			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
+	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+}
+
+static void tdx_configure_memory_encryption(struct kvm_vm *vm)
+{
+	/* Configure shared/enCrypted bit for this VM according to TDX spec */
+	vm->arch.s_bit =3D 1ULL << (vm->pa_bits - 1);
+	vm->arch.c_bit =3D 0;
+	/* Set gpa_protected_mask so that tagging/untagging of GPAs works */
+	vm->gpa_protected_mask =3D vm->arch.s_bit;
+	/* This VM is protected (has memory encryption) */
+	vm->protected =3D true;
+}
+
+static void tdx_apply_cr4_restrictions(struct kvm_sregs *sregs)
+{
+	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
+	sregs->cr4 |=3D X86_CR4_MCE;
+
+	/* Set this because UEFI also sets this up, to handle XMM exceptions */
+	sregs->cr4 |=3D X86_CR4_OSXMMEXCPT;
+
+	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
+	sregs->cr4 &=3D ~(X86_CR4_VMXE | X86_CR4_SMXE);
+}
+
+static void load_td_boot_code(struct kvm_vm *vm)
+{
+	void *boot_code_hva =3D addr_gpa2hva(vm, FOUR_GIGABYTES_GPA - TD_BOOT_COD=
E_SIZE);
+
+	TEST_ASSERT(td_boot_code_end - reset_vector =3D=3D 16,
+		"The reset vector must be 16 bytes in size.");
+	memcpy(boot_code_hva, td_boot, TD_BOOT_CODE_SIZE);
+}
+
+static void load_td_per_vcpu_parameters(struct td_boot_parameters *params,
+					struct kvm_sregs *sregs,
+					struct kvm_vcpu *vcpu,
+					void *guest_code)
+{
+	/* Store vcpu_index to match what the TDX module would store internally *=
/
+	static uint32_t vcpu_index;
+
+	struct td_per_vcpu_parameters *vcpu_params =3D &params->per_vcpu[vcpu_ind=
ex];
+
+	TEST_ASSERT(vcpu->initial_stack_addr !=3D 0,
+		"initial stack address should not be 0");
+	TEST_ASSERT(vcpu->initial_stack_addr <=3D 0xffffffff,
+		"initial stack address must fit in 32 bits");
+	TEST_ASSERT((uint64_t)guest_code <=3D 0xffffffff,
+		"guest_code must fit in 32 bits");
+	TEST_ASSERT(sregs->cs.selector !=3D 0, "cs.selector should not be 0");
+
+	vcpu_params->esp_gva =3D (uint32_t)(uint64_t)vcpu->initial_stack_addr;
+	vcpu_params->ljmp_target.eip_gva =3D (uint32_t)(uint64_t)guest_code;
+	vcpu_params->ljmp_target.code64_sel =3D sregs->cs.selector;
+
+	vcpu_index++;
+}
+
+static void load_td_common_parameters(struct td_boot_parameters *params,
+				struct kvm_sregs *sregs)
+{
+	/* Set parameters! */
+	params->cr0 =3D sregs->cr0;
+	params->cr3 =3D sregs->cr3;
+	params->cr4 =3D sregs->cr4;
+	params->gdtr.limit =3D sregs->gdt.limit;
+	params->gdtr.base =3D sregs->gdt.base;
+	params->idtr.limit =3D sregs->idt.limit;
+	params->idtr.base =3D sregs->idt.base;
+
+	TEST_ASSERT(params->cr0 !=3D 0, "cr0 should not be 0");
+	TEST_ASSERT(params->cr3 !=3D 0, "cr3 should not be 0");
+	TEST_ASSERT(params->cr4 !=3D 0, "cr4 should not be 0");
+	TEST_ASSERT(params->gdtr.base !=3D 0, "gdt base address should not be 0")=
;
+}
+
+static void load_td_boot_parameters(struct td_boot_parameters *params,
+				struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct kvm_sregs sregs;
+
+	/* Assemble parameters in sregs */
+	memset(&sregs, 0, sizeof(struct kvm_sregs));
+	vcpu_setup_mode_sregs(vcpu->vm, &sregs);
+	tdx_apply_cr4_restrictions(&sregs);
+	kvm_setup_idt(vcpu->vm, &sregs.idt);
+
+	if (!params->cr0)
+		load_td_common_parameters(params, &sregs);
+
+	load_td_per_vcpu_parameters(params, &sregs, vcpu, guest_code);
+}
+
+/**
+ * Adds a vCPU to a TD (Trusted Domain) with minimum defaults. It will not=
 set
+ * up any general purpose registers as they will be initialized by the TDX=
. In
+ * TDX, vCPUs RIP is set to 0xFFFFFFF0. See Intel TDX EAS Section "Initial=
 State
+ * of Guest GPRs" for more information on vCPUs initial register values wh=
en
+ * entering the TD first time.
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vcpuid - The id of the VCPU to add to the VM.
+ */
+struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *gu=
est_code)
+{
+	struct kvm_vcpu *vcpu;
+
+	/*
+	 * TD setup will not use the value of rip set in vm_vcpu_add anyway, so
+	 * NULL can be used for guest_code.
+	 */
+	vcpu =3D vm_vcpu_add(vm, vcpu_id, NULL);
+
+	tdx_td_vcpu_init(vcpu);
+
+	load_td_boot_parameters(addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA),
+				vcpu, guest_code);
+
+	return vcpu;
+}
+
+/**
+ * Iterate over set ranges within sparsebit @s. In each iteration,
+ * @range_begin and @range_end will take the beginning and end of the set =
range,
+ * which are of type sparsebit_idx_t.
+ *
+ * For example, if the range [3, 7] (inclusive) is set, within the iterati=
on,
+ * @range_begin will take the value 3 and @range_end will take the value 7=
.
+ *
+ * Ensure that there is at least one bit set before using this macro with
+ * sparsebit_any_set(), because sparsebit_first_set() will abort if none a=
re
+ * set.
+ */
+#define sparsebit_for_each_set_range(s, range_begin, range_end)		\
+	for (range_begin =3D sparsebit_first_set(s),			\
+		     range_end =3D sparsebit_next_clear(s, range_begin) - 1; \
+	     range_begin && range_end;					\
+	     range_begin =3D sparsebit_next_set(s, range_end),		\
+		     range_end =3D sparsebit_next_clear(s, range_begin) - 1)
+/*
+ * sparsebit_next_clear() can return 0 if [x, 2**64-1] are all set, and th=
e -1
+ * would then cause an underflow back to 2**64 - 1. This is expected and
+ * correct.
+ *
+ * If the last range in the sparsebit is [x, y] and we try to iterate,
+ * sparsebit_next_set() will return 0, and sparsebit_next_clear() will try=
 and
+ * find the first range, but that's correct because the condition expressi=
on
+ * would cause us to quit the loop.
+ */
+
+static void load_td_memory_region(struct kvm_vm *vm,
+				  struct userspace_mem_region *region)
+{
+	const struct sparsebit *pages =3D region->protected_phy_pages;
+	const uint64_t hva_base =3D region->region.userspace_addr;
+	const vm_paddr_t gpa_base =3D region->region.guest_phys_addr;
+	const sparsebit_idx_t lowest_page_in_region =3D gpa_base >>
+						      vm->page_shift;
+
+	sparsebit_idx_t i;
+	sparsebit_idx_t j;
+
+	if (!sparsebit_any_set(pages))
+		return;
+
+	sparsebit_for_each_set_range(pages, i, j) {
+		const uint64_t size_to_load =3D (j - i + 1) * vm->page_size;
+		const uint64_t offset =3D
+			(i - lowest_page_in_region) * vm->page_size;
+		const uint64_t hva =3D hva_base + offset;
+		const uint64_t gpa =3D gpa_base + offset;
+		void *source_addr;
+
+		/*
+		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place,
+		 * hence we have to make a copy if there's only one backing
+		 * memory source
+		 */
+		source_addr =3D mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
+				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+		TEST_ASSERT(
+			source_addr,
+			"Could not allocate memory for loading memory region");
+
+		memcpy(source_addr, (void *)hva, size_to_load);
+
+		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
+
+		munmap(source_addr, size_to_load);
+	}
+}
+
+static void load_td_private_memory(struct kvm_vm *vm)
+{
+	int ctr;
+	struct userspace_mem_region *region;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		load_td_memory_region(vm, region);
+	}
+}
+
+struct kvm_vm *td_create(void)
+{
+	struct vm_shape shape;
+
+	shape.mode =3D VM_MODE_DEFAULT;
+	shape.type =3D KVM_X86_PROTECTED_VM;
+	return ____vm_create(shape);
+}
+
+static void td_setup_boot_code(struct kvm_vm *vm, enum vm_mem_backing_src_=
type src_type)
+{
+	vm_vaddr_t addr;
+	size_t boot_code_allocation =3D round_up(TD_BOOT_CODE_SIZE, PAGE_SIZE);
+	vm_paddr_t boot_code_base_gpa =3D FOUR_GIGABYTES_GPA - boot_code_allocati=
on;
+	size_t npages =3D DIV_ROUND_UP(boot_code_allocation, PAGE_SIZE);
+
+	vm_userspace_mem_region_add(vm, src_type, boot_code_base_gpa, 1, npages,
+				    KVM_MEM_PRIVATE);
+	addr =3D vm_vaddr_alloc_1to1(vm, boot_code_allocation, boot_code_base_gpa=
, 1);
+	ASSERT_EQ(addr, boot_code_base_gpa);
+
+	load_td_boot_code(vm);
+}
+
+static size_t td_boot_parameters_size(void)
+{
+	int max_vcpus =3D kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	size_t total_per_vcpu_parameters_size =3D
+		max_vcpus * sizeof(struct td_per_vcpu_parameters);
+
+	return sizeof(struct td_boot_parameters) + total_per_vcpu_parameters_size=
;
+}
+
+static void td_setup_boot_parameters(struct kvm_vm *vm, enum vm_mem_backin=
g_src_type src_type)
+{
+	vm_vaddr_t addr;
+	size_t boot_params_size =3D td_boot_parameters_size();
+	int npages =3D DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
+	size_t total_size =3D npages * PAGE_SIZE;
+
+	vm_userspace_mem_region_add(vm, src_type, TD_BOOT_PARAMETERS_GPA, 2,
+				    npages, KVM_MEM_PRIVATE);
+	addr =3D vm_vaddr_alloc_1to1(vm, total_size, TD_BOOT_PARAMETERS_GPA, 2);
+	ASSERT_EQ(addr, TD_BOOT_PARAMETERS_GPA);
+}
+
+void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_typ=
e,
+		   uint64_t attributes)
+{
+	uint64_t nr_pages_required;
+
+	tdx_enable_capabilities(vm);
+
+	tdx_configure_memory_encryption(vm);
+
+	tdx_td_init(vm, attributes);
+
+	nr_pages_required =3D vm_nr_pages_required(VM_MODE_DEFAULT, 1, 0);
+
+	/*
+	 * Add memory (add 0th memslot) for TD. This will be used to setup the
+	 * CPU (provide stack space for the CPU) and to load the elf file.
+	 */
+	vm_userspace_mem_region_add(vm, src_type, 0, 0, nr_pages_required,
+				    KVM_MEM_PRIVATE);
+
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	vm_init_descriptor_tables(vm);
+
+	td_setup_boot_code(vm, src_type);
+	td_setup_boot_parameters(vm, src_type);
+}
+
+void td_finalize(struct kvm_vm *vm)
+{
+	sync_exception_handlers_to_guest(vm);
+
+	load_td_private_memory(vm);
+
+	tdx_td_finalizemr(vm);
+}
--=20
2.41.0.487.g6d72f3e995-goog

