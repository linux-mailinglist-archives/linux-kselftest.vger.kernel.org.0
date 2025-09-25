Return-Path: <linux-kselftest+bounces-42374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BDBA0DB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4181C206A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459431A061;
	Thu, 25 Sep 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0s5InbC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E37315785
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821354; cv=none; b=Y7OIV+iwa6SfMn1/qxmcZAqXSFT1/NuUTqSmBXaS0GDM/BpMU8Q1nHPEPZfY2eNDv/UdqGLPNjLEdtl5jYzK7TTKYPFIC9AGOFiEFWbcD3NPWrseGyqNlc0SR4jtYxxTnwY0HnsB2DQzqAAIbDyeqiSqScM/OxA7lPi5Q0BVa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821354; c=relaxed/simple;
	bh=2aGhCVj/LNDFnEdSAf8neR5oHQqP5TXDmEwdpSPrxU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eRNUEXHayDHEp+5DESp9Qudh/O6rF34MuyEclnKdauyVxH3GmWYKEYMyjJu++ufuvz24h3q3RWJcPOyDjnKdDd6raZ+TSz0yxl++iHBDpNbNE0xaaW/daE1tb5bpIfSeTqDN0aIOoYGJHl9gMz+aMr/t/uycqbnNG1tmNDy0Pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0s5InbC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780f914b5a4so1322339b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821351; x=1759426151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBv2XFOPOYwVrsbHlHK72SSQVDUecqQrSx2DBvtfKys=;
        b=q0s5InbCUmubsN4ARCeOP/UIqkQLG0uotJEeCLMQ6XqLwKD+XgHZj47QH7o9bDSAcH
         zUHC2uuUvr/NjsBY0s61AjsbhSFPV0d5XR9uhaGviJnqzNtkKIWutmKTSscfq/6gvOsV
         aOyq5x0Hv1C7M+lKBKp/nZcI/dJU5D1XtXxCsLeFuYDg6KSbvGpemi+cICPAE6VsWEu3
         xJTuRRLK+1WQAIkOazPGPUEFO6VhHqs/QUio2Y54XT/aZ5O5azxbTlCGyRV4+cbK/4s3
         0sMcfioticJMEy3LiFNjaZaEVbp8wwD2ReFb2CsT285OKH8lm/qQWgY5A9bvoDD4QjBI
         FLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821351; x=1759426151;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBv2XFOPOYwVrsbHlHK72SSQVDUecqQrSx2DBvtfKys=;
        b=IIzwrlmYRQdLxmxE2YY1scFKuNyvuD7rzEBXZtrbfBln1RHK/uek+QcjItw75THt8w
         70F5nH3Wu+Ls9Q47fEBFADox66kHdI0p+FHr4soIjzNZYvpLVS9fHaeNGf/p8Ktv16I2
         j5Flty6U7UgCuyzZ3wfjlNvq0jojZGfPya5pzn1jeeo1jTYu/fpbCUCAhRblzhfe/01x
         6rnD4d+pD7cciYd9PA4Ndf+IhvwMuBIpiOL6on7wkZYPHjvymC/NA/x5UKzjNvKTvV8k
         lK1m1CM7v0KpQYTBQs1Di0uDJExL8SSDPLaviGPjOztJEOP2cf+LuN5XDta00LN9nyOb
         0hIw==
X-Gm-Message-State: AOJu0YwpJizWmg+NRjLdNwEakzAjp2iYOLF+LwslIQJL0Ff01wXUGPQZ
	Mc8X24a0+GVjB0u9+rXbWRe7o4M0lfFuCVMqMO2QeVSqSA0H+cqH0DjKXIB9f0ghSFjs1aOfbeZ
	tgnxeul5URgbmn3prWoDHpSS6Yggzpf88VRe8HWVR96/td0g1fvztGtf8+yalY0KkUz0iUAoq0D
	seFkn0OrZB3I2+oDnvb1uauxmbD3nT1cwoon/z5KedBl8=
X-Google-Smtp-Source: AGHT+IH/sptRbEA29DMiih/wuul98Bn98Ig0LrOqxAWzIlzvAqkRKtdxath+4sAuWyfk7/KQTJZQyTAwGA==
X-Received: from pfoh3.prod.google.com ([2002:aa7:86c3:0:b0:77d:12a5:d3dc])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:76a5:b0:2d6:9a15:137a
 with SMTP id adf61e73a8af0-2e7d474b870mr3423110637.53.1758821351240; Thu, 25
 Sep 2025 10:29:11 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:35 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-8-sagis@google.com>
Subject: [PATCH v11 07/21] KVM: selftests: Define structs to pass parameters
 to TDX boot code
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

TDX registers are inaccessible to KVM. Therefore we need a different
mechanism to load boot parameters for TDX code. TDX boot code will read
the registers values from memory and set the registers manually.

This patch defines the data structures used to communicate between c
code and the TDX assembly boot code which will be added in a later
patch.

Use kbuild.h to expose the offsets into the structs from c code to
assembly code.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      | 18 +++++
 .../selftests/kvm/include/x86/tdx/td_boot.h   | 69 +++++++++++++++++++
 .../kvm/lib/x86/tdx/td_boot_offsets.c         | 21 ++++++
 3 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets=
.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 41b40c676d7f..3f93c093b046 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -19,6 +19,8 @@ LIBKVM +=3D lib/userfaultfd_util.c
=20
 LIBKVM_STRING +=3D lib/string_override.c
=20
+LIBKVM_ASM_DEFS +=3D lib/x86/tdx/td_boot_offsets.c
+
 LIBKVM_x86 +=3D lib/x86/apic.c
 LIBKVM_x86 +=3D lib/x86/handlers.S
 LIBKVM_x86 +=3D lib/x86/hyperv.c
@@ -230,6 +232,10 @@ OVERRIDE_TARGETS =3D 1
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
=20
+# Enable Kbuild tools.
+include $(top_srcdir)/scripts/Kbuild.include
+include $(top_srcdir)/scripts/Makefile.lib
+
 INSTALL_HDR_PATH =3D $(top_srcdir)/usr
 LINUX_HDR_PATH =3D $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE =3D $(top_srcdir)/tools/include
@@ -282,6 +288,7 @@ LIBKVM_S :=3D $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ :=3D $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
+LIBKVM_ASM_DEFS_OBJ +=3D $(patsubst %.c, $(OUTPUT)/%.s, $(LIBKVM_ASM_DEFS)=
)
 LIBKVM_OBJS =3D $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIB=
CGROUP_O)
 SPLIT_TEST_GEN_PROGS :=3D $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ :=3D $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS=
))
@@ -308,6 +315,7 @@ $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%=
.c
=20
 EXTRA_CLEAN +=3D $(GEN_HDRS) \
 	       $(LIBKVM_OBJS) \
+	       $(LIBKVM_ASM_DEFS_OBJ) \
 	       $(SPLIT_TEST_GEN_OBJ) \
 	       $(TEST_DEP_FILES) \
 	       $(TEST_GEN_OBJ) \
@@ -319,18 +327,28 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
 $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
=20
+$(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
+
 # Compile the string overrides as freestanding to prevent the compiler fro=
m
 # generating self-referential code, e.g. without "freestanding" the compil=
er may
 # "optimize" memcmp() by invoking memcmp(), thus causing infinite recursio=
n.
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
=20
+$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot=
_offsets.s FORCE
+	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
+
+EXTRA_CLEAN +=3D $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
+
 $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
 $(TEST_GEN_OBJ): $(GEN_HDRS)
=20
+FORCE:
+
 cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include =
lib ..
 cscope:
 	$(RM) cscope.*
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/=
testing/selftests/kvm/include/x86/tdx/td_boot.h
new file mode 100644
index 000000000000..32631645fe13
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_H
+#define SELFTEST_TDX_TD_BOOT_H
+
+#include <stdint.h>
+
+#include <linux/compiler.h>
+#include <linux/sizes.h>
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
+#define FOUR_GIGABYTES_GPA (SZ_4G)
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
+ * Allows each vCPU to be initialized with different rip and esp.
+ */
+struct td_per_vcpu_parameters {
+	uint32_t esp_gva;
+	uint64_t guest_code;
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
+struct td_boot_parameters {
+	uint32_t cr0;
+	uint32_t cr3;
+	uint32_t cr4;
+	struct td_boot_parameters_dtr gdtr;
+	struct td_boot_parameters_dtr idtr;
+	struct td_per_vcpu_parameters per_vcpu[];
+};
+
+#endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c b/to=
ols/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
new file mode 100644
index 000000000000..7f76a3585b99
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+
+#include <linux/kbuild.h>
+
+#include "tdx/td_boot.h"
+
+static void __attribute__((used)) common(void)
+{
+	OFFSET(TD_BOOT_PARAMETERS_CR0, td_boot_parameters, cr0);
+	OFFSET(TD_BOOT_PARAMETERS_CR3, td_boot_parameters, cr3);
+	OFFSET(TD_BOOT_PARAMETERS_CR4, td_boot_parameters, cr4);
+	OFFSET(TD_BOOT_PARAMETERS_GDT, td_boot_parameters, gdtr);
+	OFFSET(TD_BOOT_PARAMETERS_IDT, td_boot_parameters, idtr);
+	OFFSET(TD_BOOT_PARAMETERS_PER_VCPU, td_boot_parameters, per_vcpu);
+	OFFSET(TD_PER_VCPU_PARAMETERS_ESP_GVA, td_per_vcpu_parameters, esp_gva);
+	OFFSET(TD_PER_VCPU_PARAMETERS_GUEST_CODE, td_per_vcpu_parameters,
+	       guest_code);
+	DEFINE(SIZEOF_TD_PER_VCPU_PARAMETERS,
+	       sizeof(struct td_per_vcpu_parameters));
+}
--=20
2.51.0.536.g15c5d4f767-goog


