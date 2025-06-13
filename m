Return-Path: <linux-kselftest+bounces-34935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916EAD9518
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615D93AAA54
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37406291C38;
	Fri, 13 Jun 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVsc0EWi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA423CEF8
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842065; cv=none; b=OBp06o2DmE4Fm7CNaXt65KkdkXhN7s6sNLWkCMn1rOqSD5SeWVnQ0fW/Zv3+jC+XXVvm9sXwJRIHcLj2cyxC2DraGA/Gt4uwJ3sin5q22q0c+X76I+DXRicsuGti6RfyqQuOIPzoljNuSzNWzLz0yiQV3WFp71Nf8BGIq47S7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842065; c=relaxed/simple;
	bh=OonyLTR3/swd/U1Mmwwgmw5zqxLheIbNAF4jVd/qgfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YfCUxgoS+k8vYcvThQ0Or6574kY0GcyZKYU7nylO/40Y6USYkXnh12mhKkqEkpl81Gq3B40YivtsiKF2NsxOsgbmBgIDg7jnfVwWgHxFmy86XEIXoICAsHZ/tCbyL4UiZZH48J74+IlK38gVg9wHmAscr03HnaiQ0ATYbZW63yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JVsc0EWi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so2298898a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842061; x=1750446861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UcojkCHrQxtH5hldlPMr9j63gRaYxzXi6/8ZN/k6QE=;
        b=JVsc0EWiG5PnOnYEw+aWjQGBl3WkDXzGkz9Vy6T6k4GSylHMTnwOhlw9PeD0oIxykE
         CQ7fqHnjgT5Fr8NXh1vas4mpcB2oRU6pFzAzw0MtUD4WGn5ti46DccTUbadWLGqBV8jB
         qvO8CaoMSrJHavWpQAESFYkQq98qmFhOE6vgzZOIoVWkRiBQzPOwvCHcqLNC6HjU/N7c
         KttVIGjMCP2+va/AsGnMlRFtItzNDk8RykfvDKx616lTggLZT3/Q2lIkBR/n7Nf00jpf
         IZdV4K+ykKm1gu+hPm91pA29vAUEEHGpsxCF2c5sYLxSLxZOWDTng8sHyjGO0FUFvT1/
         frww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842061; x=1750446861;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UcojkCHrQxtH5hldlPMr9j63gRaYxzXi6/8ZN/k6QE=;
        b=bhbCTd3cdpIdtjWuXkYn4EEctM6d0d3KeSkyf9OpKi/Ys2IjKhOz3r5AEme8TRxTtG
         g6p/FHXMKkh3SSkx1mX4psc53Ktm+x5N5E7xdg54NLe4yxUMD0ndZHg1cY9R4PLzeCTt
         Gud/55SjWE2sFOw+7/cjzHK9kAkBBfX7eh7A84oT3UG4aqwWMJpIuj+8ppVW9592MKj2
         pPmiXhKEovLKE5SkzU1KGbcBvvY2bayuLHoZPISw0vAWZ/T2Posw0SYPn8tkGTSZd4aB
         2/Mifhnrc0hGiWpdYKNSfSpqubd9JLPUlzFxLFHLTuUvZAYsgac3WlgrvegcRWSja7Wv
         OLsQ==
X-Gm-Message-State: AOJu0YycDIcbYEE6XhRVFcM+Xg60ij7Rk8V2QDTT0bxaT2Q4AShjPy9p
	42k+jlSed2hP3hdfsrIfkogwZYD385GZn6aGzPFPAWQiPrRULSAfUx+3MTO41oEympyICVBgT9a
	cgzPphVNELeHAMtfhZEGqO8ngjYHuQlnw9AAuzCW3W6TdwqP5SCSnJXYErbO1Mqt07W05uk6EQ9
	o22JFg/qLymMj56fAYJg2VtrM+xi6LBXpC4xY3EtYMV7E=
X-Google-Smtp-Source: AGHT+IE5eF+kxb6VLiE2fNkSUDgpls4vOCLtVr5Q/29gPedOOB72vxfQCXU21zJ/4QF72crD7AvLY5JwTQ==
X-Received: from pfbko19.prod.google.com ([2002:a05:6a00:4613:b0:746:18ec:d11a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7702:b0:1f5:64fd:68ea
 with SMTP id adf61e73a8af0-21fbd54d5f3mr685924637.4.1749842061538; Fri, 13
 Jun 2025 12:14:21 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:33 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-7-sagis@google.com>
Subject: [PATCH v7 06/30] KVM: selftests: Add helper functions to create TDX VMs
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Erdem Aktas <erdemaktas@google.com>

TDX requires additional IOCTLs to initialize VM and vCPUs to add
private memory and to finalize the VM memory. Also additional utility
functions are provided to manipulate a TD, similar to those that
manipulate a VM in the current selftest framework.

A TD's initial register state cannot be manipulated directly by
setting the VM's memory, hence boot code is provided at the TD's reset
vector. This boot code takes boot parameters loaded in the TD's memory
and sets up the TD for the selftest.

Userspace needs to ensure consistency between KVM's CPUID and the
TDX Module's view. Obtain the CPUID supported by KVM and make
adjustments to reflect features of interest and the limited
KVM PV features supported for TD guest. This involves masking the
feature bits from CPUID entries and filtering CPUID entries of
features not supported by TDX before initializing the TD.

Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../testing/selftests/kvm/include/kvm_util.h  |   6 +
 .../selftests/kvm/include/x86/kvm_util_arch.h |   1 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |  83 +++
 .../kvm/include/x86/tdx/td_boot_asm.h         |  16 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  19 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   6 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  19 +-
 .../selftests/kvm/lib/x86/tdx/td_boot.S       | 100 ++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 566 ++++++++++++++++++
 10 files changed, 807 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm=
.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 38b95998e1e6..b429c92e07d8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -29,6 +29,8 @@ LIBKVM_x86 +=3D lib/x86/sev.c
 LIBKVM_x86 +=3D lib/x86/svm.c
 LIBKVM_x86 +=3D lib/x86/ucall.c
 LIBKVM_x86 +=3D lib/x86/vmx.c
+LIBKVM_x86 +=3D lib/x86/tdx/tdx_util.c
+LIBKVM_x86 +=3D lib/x86/tdx/td_boot.S
=20
 LIBKVM_arm64 +=3D lib/arm64/gic.c
 LIBKVM_arm64 +=3D lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing=
/selftests/kvm/include/kvm_util.h
index 5c4ca25803ac..0d1f24c9f7c7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -79,6 +79,7 @@ enum kvm_mem_region_type {
 	MEM_REGION_DATA,
 	MEM_REGION_PT,
 	MEM_REGION_TEST_DATA,
+	MEM_REGION_TDX_BOOT_PARAMS,
 	NR_MEM_REGIONS,
 };
=20
@@ -1026,6 +1027,9 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)=
;
 unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_g=
uest_pages);
 unsigned int vm_num_guest_pages(enum vm_guest_mode mode, unsigned int num_=
host_pages);
+uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
+			      uint32_t nr_runnable_vcpus,
+			      uint64_t extra_mem_pages);
 static inline unsigned int
 vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_=
pages)
 {
@@ -1191,6 +1195,8 @@ static inline int __vm_disable_nx_huge_pages(struct k=
vm_vm *vm)
  */
 void kvm_selftest_arch_init(void);
=20
+void vm_init_descriptor_tables(struct kvm_vm *vm);
+
 void kvm_arch_vm_post_create(struct kvm_vm *vm);
=20
 bool vm_is_gpa_protected(struct kvm_vm *vm, vm_paddr_t paddr);
diff --git a/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h b/tool=
s/testing/selftests/kvm/include/x86/kvm_util_arch.h
index 972bb1c4ab4c..80db1e4c38ba 100644
--- a/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86/kvm_util_arch.h
@@ -19,6 +19,7 @@ struct kvm_vm_arch {
 	uint64_t s_bit;
 	int sev_fd;
 	bool is_pt_protected;
+	bool has_protected_regs;
 };
=20
 static inline bool __vm_arch_has_protected_memory(struct kvm_vm_arch *arch=
)
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/=
testing/selftests/kvm/include/x86/tdx/td_boot.h
new file mode 100644
index 000000000000..94a50295f953
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_H
+#define SELFTEST_TDX_TD_BOOT_H
+
+#include <stdint.h>
+
+#include "tdx/td_boot_asm.h"
+
+/*
+ * Layout for boot section (not to scale)
+ *
+ *                                   GPA
+ * _________________________________ 0x1_0000_0000 (4GB)
+ * |   Boot code trampoline    |
+ * |___________________________|____ 0x0_ffff_fff0: Reset vector (16B belo=
w 4GB)
+ * |   Boot code               |
+ * |___________________________|____ td_boot will be copied here, so that =
the
+ * |                           |     jmp to td_boot is exactly at the rese=
t vector
+ * |   Empty space             |
+ * |                           |
+ * |=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80|
+ * |                           |
+ * |                           |
+ * |   Boot parameters         |
+ * |                           |
+ * |                           |
+ * |___________________________|____ 0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
+ */
+#define FOUR_GIGABYTES_GPA (4ULL << 30)
+
+/*
+ * The exact memory layout for LGDT or LIDT instructions.
+ */
+struct __packed td_boot_parameters_dtr {
+	uint16_t limit;
+	uint32_t base;
+};
+
+/*
+ * The exact layout in memory required for a ljmp, including the selector =
for
+ * changing code segment.
+ */
+struct __packed td_boot_parameters_ljmp_target {
+	uint32_t eip_gva;
+	uint16_t code64_sel;
+};
+
+/*
+ * Allows each vCPU to be initialized with different eip and esp.
+ */
+struct __packed td_per_vcpu_parameters {
+	uint32_t esp_gva;
+	struct td_boot_parameters_ljmp_target ljmp_target;
+};
+
+/*
+ * Boot parameters for the TD.
+ *
+ * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
+ * before boot, so to run selftests, these registers' values have to be
+ * initialized by the TD.
+ *
+ * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
+ *
+ * The TD boot code will read off parameters from this struct and set up t=
he
+ * vCPU for executing selftests.
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
+void td_boot(void);
+void reset_vector(void);
+void td_boot_code_end(void);
+
+#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
+
+#endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h b/to=
ols/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
new file mode 100644
index 000000000000..10b4b527595c
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_ASM_H
+#define SELFTEST_TDX_TD_BOOT_ASM_H
+
+/*
+ * GPA where TD boot parameters will be loaded.
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
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools=
/testing/selftests/kvm/include/x86/tdx/tdx_util.h
new file mode 100644
index 000000000000..57a2f5893ffe
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTESTS_TDX_KVM_UTIL_H
+#define SELFTESTS_TDX_KVM_UTIL_H
+
+#include <stdint.h>
+
+#include "kvm_util.h"
+
+void tdx_filter_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid_data);
+void __tdx_mask_cpuid_features(struct kvm_cpuid_entry2 *entry);
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
index 8f3dbf749afa..f7e00ea0b211 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -376,9 +376,9 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	return vm;
 }
=20
-static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
-				     uint32_t nr_runnable_vcpus,
-				     uint64_t extra_mem_pages)
+uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
+			      uint32_t nr_runnable_vcpus,
+			      uint64_t extra_mem_pages)
 {
 	uint64_t page_size =3D vm_guest_mode_params[mode].page_size;
 	uint64_t nr_pages;
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testin=
g/selftests/kvm/lib/x86/processor.c
index d9f4ecd6ffbc..ce422da10f50 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -590,7 +590,7 @@ void sync_exception_handlers_to_guest(struct kvm_vm *vm=
)
 	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) =3D vm=
->handlers;
 }
=20
-static void vm_init_descriptor_tables(struct kvm_vm *vm)
+void vm_init_descriptor_tables(struct kvm_vm *vm)
 {
 	extern void *idt_handlers;
 	struct kvm_segment seg;
@@ -696,16 +696,19 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, =
uint32_t vcpu_id)
=20
 	vcpu =3D __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
=20
 	vcpu->initial_stack_addr =3D stack_vaddr;
=20
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags =3D regs.rflags | 0x2;
-	regs.rsp =3D stack_vaddr;
-	vcpu_regs_set(vcpu, &regs);
+	if (!vm->arch.has_protected_regs) {
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags =3D regs.rflags | 0x2;
+		regs.rsp =3D stack_vaddr;
+		vcpu_regs_set(vcpu, &regs);
+	}
=20
 	/* Setup the MP state */
 	mp_state.mp_state =3D 0;
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/test=
ing/selftests/kvm/lib/x86/tdx/td_boot.S
new file mode 100644
index 000000000000..c8cbe214bba9
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "tdx/td_boot_asm.h"
+
+/* Offsets for reading struct td_boot_parameters. */
+#define TD_BOOT_PARAMETERS_CR0         0
+#define TD_BOOT_PARAMETERS_CR3         4
+#define TD_BOOT_PARAMETERS_CR4         8
+#define TD_BOOT_PARAMETERS_GDT         12
+#define TD_BOOT_PARAMETERS_IDT         18
+#define TD_BOOT_PARAMETERS_PER_VCPU    24
+
+/* Offsets for reading struct td_per_vcpu_parameters. */
+#define TD_PER_VCPU_PARAMETERS_ESP_GVA     0
+#define TD_PER_VCPU_PARAMETERS_LJMP_TARGET 4
+
+#define SIZEOF_TD_PER_VCPU_PARAMETERS      10
+
+.code32
+
+.globl td_boot
+td_boot:
+	/* In this procedure, edi is used as a temporary register. */
+	cli
+
+	/* Paging is off. */
+
+	movl $TD_BOOT_PARAMETERS_GPA, %ebx
+
+	/*
+	 * Find the address of struct td_per_vcpu_parameters for this
+	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
+	 * struct address into register for indirect addressing.
+	 */
+	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
+	mul %esi
+	leal TD_BOOT_PARAMETERS_PER_VCPU(%ebx), %edi
+	addl %edi, %eax
+
+	/* Setup stack. */
+	movl TD_PER_VCPU_PARAMETERS_ESP_GVA(%eax), %esp
+
+	/* Setup GDT. */
+	leal TD_BOOT_PARAMETERS_GDT(%ebx), %edi
+	lgdt (%edi)
+
+	/* Setup IDT. */
+	leal TD_BOOT_PARAMETERS_IDT(%ebx), %edi
+	lidt (%edi)
+
+	/*
+	 * Set up control registers (There are no instructions to mov from
+	 * memory to control registers, hence use ebx as a scratch register).
+	 */
+	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
+	movl %edi, %cr4
+	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
+	movl %edi, %cr3
+	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
+	movl %edi, %cr0
+
+	/* Paging is on after setting the most significant bit on cr0. */
+
+	/*
+	 * Jump to selftest guest code. Far jumps read <segment
+	 * selector:new eip> from <addr+4:addr>. This location has
+	 * already been set up in boot parameters, and boot parameters can
+	 * be read because boot code and boot parameters are loaded so
+	 * that GVA and GPA are mapped 1:1.
+	 */
+	ljmp *TD_PER_VCPU_PARAMETERS_LJMP_TARGET(%eax)
+
+.globl reset_vector
+reset_vector:
+	jmp td_boot
+	/*
+	 * Pad reset_vector to its full size of 16 bytes so that this
+	 * can be loaded with the end of reset_vector aligned to GPA=3D4G.
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
+/* Leave marker so size of td_boot code can be computed. */
+.globl td_boot_code_end
+td_boot_code_end:
+
+/* Disable executable stack. */
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/tes=
ting/selftests/kvm/lib/x86/tdx/tdx_util.c
new file mode 100644
index 000000000000..392d6272d17e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/kvm.h>
+#include <errno.h>
+#include <linux/kvm.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "tdx/td_boot.h"
+#include "test_util.h"
+
+uint64_t tdx_s_bit;
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
+	"KVM_TDX_FINALIZE_VM",
+	"KVM_TDX_GET_CPUID"
+};
+
+#define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
+
+static int _tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	struct kvm_tdx_cmd tdx_cmd;
+
+	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
+		    ioctl_no);
+
+	memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
+	tdx_cmd.id =3D ioctl_no;
+	tdx_cmd.flags =3D flags;
+	tdx_cmd.data =3D (uint64_t)data;
+
+	return ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+}
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	int r;
+
+	r =3D _tdx_ioctl(fd, ioctl_no, flags, data);
+	TEST_ASSERT(r =3D=3D 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
+		    errno);
+}
+
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *v=
m)
+{
+	struct kvm_tdx_capabilities *tdx_cap =3D NULL;
+	int nr_cpuid_configs =3D 4;
+	int rc =3D -1;
+	int i;
+
+	do {
+		nr_cpuid_configs *=3D 2;
+
+		tdx_cap =3D realloc(tdx_cap, sizeof(*tdx_cap) +
+					   sizeof(tdx_cap->cpuid) +
+					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
+		TEST_ASSERT(tdx_cap,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n=
",
+			    nr_cpuid_configs);
+
+		tdx_cap->cpuid.nent =3D nr_cpuid_configs;
+		rc =3D _tdx_ioctl(vm->fd, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno =3D=3D E2BIG);
+
+	TEST_ASSERT(rc =3D=3D 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: supported_attrs: 0x%016llx\n"
+		 "tdx_cap: supported_xfam 0x%016llx\n",
+		 tdx_cap->supported_attrs, tdx_cap->supported_xfam);
+
+	for (i =3D 0; i < tdx_cap->cpuid.nent; i++) {
+		const struct kvm_cpuid_entry2 *config =3D &tdx_cap->cpuid.entries[i];
+
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08=
x ecx 0x%08x edx 0x%08x\n",
+			 i, config->function, config->index,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
+static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capab=
ilities *cap,
+						      uint32_t leaf, uint32_t sub_leaf)
+{
+	struct kvm_cpuid_entry2 *config;
+	uint32_t i;
+
+	for (i =3D 0; i < cap->cpuid.nent; i++) {
+		config =3D &cap->cpuid.entries[i];
+
+		if (config->function =3D=3D leaf && config->index =3D=3D sub_leaf)
+			return config;
+	}
+
+	return NULL;
+}
+
+#define XFEATURE_MASK_CET (XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERN=
EL)
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
+#define KVM_MAX_CPUID_ENTRIES 256
+
+#define CPUID_EXT_VMX			BIT(5)
+#define CPUID_EXT_SMX			BIT(6)
+#define CPUID_PSE36			BIT(17)
+#define CPUID_7_0_EBX_TSC_ADJUST	BIT(1)
+#define CPUID_7_0_EBX_SGX		BIT(2)
+#define CPUID_7_0_EBX_INTEL_PT		BIT(25)
+#define CPUID_7_0_ECX_SGX_LC		BIT(30)
+#define CPUID_APM_INVTSC		BIT(8)
+#define CPUID_8000_0008_EBX_WBNOINVD	BIT(9)
+#define CPUID_EXT_PDCM			BIT(15)
+
+#define TDX_SUPPORTED_KVM_FEATURES  ((1U << KVM_FEATURE_NOP_IO_DELAY) | \
+				     (1U << KVM_FEATURE_PV_UNHALT) |	\
+				     (1U << KVM_FEATURE_PV_TLB_FLUSH) | \
+				     (1U << KVM_FEATURE_PV_SEND_IPI) |	\
+				     (1U << KVM_FEATURE_POLL_CONTROL) | \
+				     (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
+				     (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
+
+void __tdx_mask_cpuid_features(struct kvm_cpuid_entry2 *entry)
+{
+	/*
+	 * Only entries with sub-leaf zero need to be masked, but some of these
+	 * leaves have other sub-leaves defined. Bail on any non-zero sub-leaf,
+	 * so they don't get unintentionally modified.
+	 */
+	if (entry->index)
+		return;
+
+	switch (entry->function) {
+	case 0x1:
+		entry->ecx &=3D ~(CPUID_EXT_VMX | CPUID_EXT_SMX);
+		entry->edx &=3D ~CPUID_PSE36;
+		break;
+	case 0x7:
+		entry->ebx &=3D ~(CPUID_7_0_EBX_TSC_ADJUST | CPUID_7_0_EBX_SGX);
+		entry->ebx &=3D ~CPUID_7_0_EBX_INTEL_PT;
+		entry->ecx &=3D ~CPUID_7_0_ECX_SGX_LC;
+		break;
+	case 0x40000001:
+		entry->eax &=3D TDX_SUPPORTED_KVM_FEATURES;
+		break;
+	case 0x80000007:
+		entry->edx |=3D CPUID_APM_INVTSC;
+		break;
+	case 0x80000008:
+		entry->ebx &=3D CPUID_8000_0008_EBX_WBNOINVD;
+		break;
+	default:
+		break;
+	}
+}
+
+static void tdx_mask_cpuid_features(struct kvm_cpuid2 *cpuid_data)
+{
+	for (int i =3D 0; i < cpuid_data->nent; i++)
+		__tdx_mask_cpuid_features(&cpuid_data->entries[i]);
+}
+
+void tdx_filter_cpuid(struct kvm_vm *vm, struct kvm_cpuid2 *cpuid_data)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+	struct kvm_cpuid_entry2 *config;
+	struct kvm_cpuid_entry2 *e;
+	int i;
+
+	tdx_cap =3D tdx_read_capabilities(vm);
+
+	i =3D 0;
+	while (i < cpuid_data->nent) {
+		e =3D cpuid_data->entries + i;
+		config =3D tdx_find_cpuid_config(tdx_cap, e->function, e->index);
+
+		if (!config) {
+			int left =3D cpuid_data->nent - i - 1;
+
+			if (left > 0)
+				memmove(cpuid_data->entries + i,
+					cpuid_data->entries + i + 1,
+					sizeof(*cpuid_data->entries) * left);
+			cpuid_data->nent--;
+			continue;
+		}
+
+		e->eax &=3D config->eax;
+		e->ebx &=3D config->ebx;
+		e->ecx &=3D config->ecx;
+		e->edx &=3D config->edx;
+
+		i++;
+	}
+
+	free(tdx_cap);
+}
+
+static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_init_vm *init_vm;
+	const struct kvm_cpuid2 *tmp;
+	struct kvm_cpuid2 *cpuid;
+
+	tmp =3D kvm_get_supported_cpuid();
+
+	cpuid =3D allocate_kvm_cpuid2(KVM_MAX_CPUID_ENTRIES);
+	memcpy(cpuid, tmp, kvm_cpuid2_size(tmp->nent));
+	tdx_mask_cpuid_features(cpuid);
+
+	init_vm =3D calloc(1, sizeof(*init_vm) +
+			 sizeof(init_vm->cpuid.entries[0]) * cpuid->nent);
+	TEST_ASSERT(init_vm, "vm allocation failed");
+
+	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
+	free(cpuid);
+
+	init_vm->attributes =3D attributes;
+
+	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
+	tdx_filter_cpuid(vm, &init_vm->cpuid);
+
+	tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, init_vm);
+	free(init_vm);
+}
+
+static void tdx_td_vcpu_init(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid =3D allocate_kvm_cpuid2(KVM_MAX_CPUID_ENTRIES);
+	tdx_ioctl(vcpu->fd, KVM_TDX_GET_CPUID, 0, cpuid);
+	vcpu_init_cpuid(vcpu, cpuid);
+	free(cpuid);
+	tdx_ioctl(vcpu->fd, KVM_TDX_INIT_VCPU, 0, NULL);
+	/*
+	 * Refresh CPUID to get KVM's "runtime" updates which are done by
+	 * KVM_TDX_INIT_VCPU.
+	 */
+	vcpu_get_cpuid(vcpu);
+}
+
+static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
+				uint64_t gpa, uint64_t size)
+{
+	uint32_t metadata =3D KVM_TDX_MEASURE_MEMORY_REGION;
+	struct kvm_tdx_init_mem_region mem_region =3D {
+		.source_addr =3D (uint64_t)source_pages,
+		.gpa =3D gpa,
+		.nr_pages =3D size / PAGE_SIZE,
+	};
+	struct kvm_vcpu *vcpu;
+
+	vcpu =3D list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
+
+	TEST_ASSERT((mem_region.nr_pages > 0) &&
+		    ((mem_region.nr_pages * PAGE_SIZE) =3D=3D size),
+		    "Cannot add partial pages to the guest memory.\n");
+	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) =3D=3D 0,
+		    "Source memory buffer is not page aligned\n");
+	tdx_ioctl(vcpu->fd, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
+}
+
+static void tdx_td_finalize_mr(struct kvm_vm *vm)
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
+		    "The reset vector must be 16 bytes in size.");
+	memcpy(boot_code_hva, td_boot, TD_BOOT_CODE_SIZE);
+}
+
+static void load_td_per_vcpu_parameters(struct td_boot_parameters *params,
+					struct kvm_sregs *sregs,
+					struct kvm_vcpu *vcpu,
+					void *guest_code)
+{
+	struct td_per_vcpu_parameters *vcpu_params =3D &params->per_vcpu[vcpu->id=
];
+
+	TEST_ASSERT(vcpu->initial_stack_addr !=3D 0,
+		    "initial stack address should not be 0");
+	TEST_ASSERT(vcpu->initial_stack_addr <=3D 0xffffffff,
+		    "initial stack address must fit in 32 bits");
+	TEST_ASSERT((uint64_t)guest_code <=3D 0xffffffff,
+		    "guest_code must fit in 32 bits");
+	TEST_ASSERT(sregs->cs.selector !=3D 0, "cs.selector should not be 0");
+
+	vcpu_params->esp_gva =3D (uint32_t)(uint64_t)vcpu->initial_stack_addr;
+	vcpu_params->ljmp_target.eip_gva =3D (uint32_t)(uint64_t)guest_code;
+	vcpu_params->ljmp_target.code64_sel =3D sregs->cs.selector;
+}
+
+static void load_td_common_parameters(struct td_boot_parameters *params,
+				      struct kvm_sregs *sregs)
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
+	TEST_ASSERT(params->idtr.base !=3D 0, "idt base address should not be 0")=
;
+}
+
+static void load_td_boot_parameters(struct td_boot_parameters *params,
+				    struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct kvm_sregs sregs;
+
+	/* Assemble parameters in sregs */
+	memset(&sregs, 0, sizeof(struct kvm_sregs));
+	vcpu_setup_mode_sregs(vcpu->vm, &sregs);
+	tdx_apply_cr4_restrictions(&sregs);
+
+	if (!params->cr0)
+		load_td_common_parameters(params, &sregs);
+
+	load_td_per_vcpu_parameters(params, &sregs, vcpu, guest_code);
+}
+
+/*
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
+ *   vcpuid - The id of the vCPU to add to the VM.
+ */
+struct kvm_vcpu *td_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id, void *gu=
est_code)
+{
+	struct kvm_vcpu *vcpu;
+
+	vm->arch.has_protected_regs =3D true;
+	vcpu =3D vm_arch_vcpu_add(vm, vcpu_id);
+
+	tdx_td_vcpu_init(vcpu);
+
+	load_td_boot_parameters(addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA),
+				vcpu, guest_code);
+
+	return vcpu;
+}
+
+static void load_td_memory_region(struct kvm_vm *vm,
+				  struct userspace_mem_region *region)
+{
+	const struct sparsebit *pages =3D region->protected_phy_pages;
+	const vm_paddr_t gpa_base =3D region->region.guest_phys_addr;
+	const uint64_t hva_base =3D region->region.userspace_addr;
+	const sparsebit_idx_t lowest_page_in_region =3D gpa_base >> vm->page_shif=
t;
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
+		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
+		 * Make a copy if there's only one backing memory source.
+		 */
+		source_addr =3D mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
+				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+		TEST_ASSERT(source_addr,
+			    "Could not allocate memory for loading memory region");
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
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		load_td_memory_region(vm, region);
+	}
+}
+
+struct kvm_vm *td_create(void)
+{
+	const struct vm_shape shape =3D {
+		.mode =3D VM_MODE_DEFAULT,
+		.type =3D KVM_X86_TDX_VM,
+	};
+
+	return ____vm_create(shape);
+}
+
+static void td_setup_boot_code(struct kvm_vm *vm, enum vm_mem_backing_src_=
type src_type)
+{
+	size_t boot_code_allocation =3D round_up(TD_BOOT_CODE_SIZE, PAGE_SIZE);
+	vm_paddr_t boot_code_base_gpa =3D FOUR_GIGABYTES_GPA - boot_code_allocati=
on;
+	size_t npages =3D DIV_ROUND_UP(boot_code_allocation, PAGE_SIZE);
+	vm_vaddr_t addr;
+
+	vm_userspace_mem_region_add(vm, src_type, boot_code_base_gpa, 1, npages,
+				    KVM_MEM_GUEST_MEMFD);
+	vm->memslots[MEM_REGION_CODE] =3D 1;
+	addr =3D vm_vaddr_identity_alloc(vm, boot_code_allocation,
+				       boot_code_base_gpa, MEM_REGION_CODE);
+	TEST_ASSERT_EQ(addr, boot_code_base_gpa);
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
+	size_t boot_params_size =3D td_boot_parameters_size();
+	int npages =3D DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
+	size_t total_size =3D npages * PAGE_SIZE;
+	vm_vaddr_t addr;
+
+	vm_userspace_mem_region_add(vm, src_type, TD_BOOT_PARAMETERS_GPA, 2,
+				    npages, KVM_MEM_GUEST_MEMFD);
+	vm->memslots[MEM_REGION_TDX_BOOT_PARAMS] =3D 2;
+	addr =3D vm_vaddr_identity_alloc(vm, total_size, TD_BOOT_PARAMETERS_GPA,
+				       MEM_REGION_TDX_BOOT_PARAMS);
+	TEST_ASSERT_EQ(addr, TD_BOOT_PARAMETERS_GPA);
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
+	tdx_td_init(vm, attributes);
+
+	nr_pages_required =3D vm_nr_pages_required(VM_MODE_DEFAULT, 1, 0);
+
+	/*
+	 * Add memory (add 0th memslot) for TD. This will be used to setup the
+	 * CPU (provide stack space for the CPU) and to load the elf file.
+	 */
+	vm_userspace_mem_region_add(vm, src_type, 0, 0, nr_pages_required,
+				    KVM_MEM_GUEST_MEMFD);
+
+	kvm_vm_elf_load(vm, program_invocation_name);
+	tdx_s_bit =3D vm->arch.s_bit;
+	sync_global_to_guest(vm, tdx_s_bit);
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
+	tdx_td_finalize_mr(vm);
+}
--=20
2.50.0.rc2.692.g299adb8693-goog


