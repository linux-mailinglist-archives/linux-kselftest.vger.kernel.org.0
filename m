Return-Path: <linux-kselftest+bounces-40736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A18B432FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349D25834AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658828C864;
	Thu,  4 Sep 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RD73djsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2628B415
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968916; cv=none; b=Z+rkJzfawjKtUK4gNHlpu05Y3tQswc7E7a9s6ieAXV/9qJTtwTwiTenT+Ve7e1chGLCeTMZ7f8pcGapKBDxC7j5b8NTBQanXa+WK4hiR2sTIaiCJ91YuueWNKRJtpxV23HboMcumE3nR4EsoobZG0Tde1NdqbCTFzOV4i+rNWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968916; c=relaxed/simple;
	bh=WqerTk+Ce1mi+b7UK6B3fZJzoVkFc8hKiorCbP72pys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cecNdnYxfRMoQib7iZpu81l2bI+Zgz7o4aiY1lu9URMO+r5uY5UojcSCKk2KEUBRmmqvme01wzvdv3Z19A16ikFBjFvDIc8O83ObRfHAh1mlOE7/ahaX4KXADrUQ0cnIe8ke6su1X/BIkh+YaAFhzJWk46eqd8MOQhVsn8joHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RD73djsB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24a94fef521so12983235ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968914; x=1757573714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnnUKXqaS1PhubecyA39BBSAxyYQ9KOIV0BIog+vX5o=;
        b=RD73djsBnl2O5gLXX55TuO2dmNBsZG5itgCbMBhtZayL/cpgcXOymzvSsJs/eqXl0t
         ne1WUBM15DbEVa8OV8aTNYI2g98Ur7yxNn5klBFu683+AmCvbBW5MwcapU5mDkutCVm6
         KNt0Xz0mmKH0hPR5LbBPQr73ORrE6vASZgmGZaj65oiFmLPURmKDRuyDYSJ/dxliHM05
         vIs080YnRpoLMrYZeeVgI9OauZhR0gkVUAfdh9dj2hOtUwj3MlfvEoMMreZ9KvCj078R
         LVVyRk7JRsnyiysfl873rjEWTsKYlU07R6p1GN0QD3StqnTY06AKtTzGsLt9vZkZz6+2
         Pc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968914; x=1757573714;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wnnUKXqaS1PhubecyA39BBSAxyYQ9KOIV0BIog+vX5o=;
        b=fqhHJJQyqRuZ7JyDvJePAPyGDb/33d8bn2LWS4sxtILtv4fUn5+d2qHndV2ETgh9dC
         7GFkXYUFsN3NaJI1uWzB33sh5BkBOlBEY/wCd+PUvKdnx0UoWl+yEAs1oYUje6QNzN/g
         C4nIye1occUmbYrbLY/wWBg9Usvcxi1QqYF8PZNiMtpoX/jvu3byYFFJK4cVzqaooijd
         E3fmhIZkzhpYWW3vQnpZA/Tg32nKvCY+uTDYwbVD4lbWbIYbTDW9IjFaKKqee6bZqw2R
         YHe0lFvOjZVf781uqRkEUdqhjvBCvhBhmPS1C9a2nSJy1cLJZwfMGbAsaVqBbhJKrlr/
         ku/w==
X-Gm-Message-State: AOJu0YzVK4Tc2dksHES2uOdSCp+GX2O1LCWe57ZAOzYk4OCQ+JvxBREu
	ntU1DigTmxouK1Y9rSUR7XJwGO03mssRPN2d1gyqOsGJ4Z+UgfWPmsNn8Dnf76uTDY1CzEcQkE4
	eQx2+4xPa03I01tM9daGUrbYJm5NIWVDYksF2yEzoqHUEf5jDMA5niiqf3q9j3EB7FBMCKV4Zmx
	bxND3guLliNhitLlWgeGu8jCkrYuA8BB3CxBfzqkiNL3k=
X-Google-Smtp-Source: AGHT+IHdgqyNpBMpt/bYzJ7+FnZp+WxzXkfhv7pByoS1YtSmKG0gimKr6Fdi62pDlbZtDTPV/NoU2SBoGw==
X-Received: from ploq15.prod.google.com ([2002:a17:903:1aaf:b0:248:f37a:bc17])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e783:b0:242:bba6:fc85
 with SMTP id d9443c01a7336-24944b75a04mr252914475ad.56.1756968913924; Wed, 03
 Sep 2025 23:55:13 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:37 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-8-sagis@google.com>
Subject: [PATCH v10 07/21] KVM: selftests: Define structs to pass parameters
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

TDX registers are inaccesible to KVM. Therefore we need a different
mechanism to load boot parameters for TDX code. TDX boot code will read
the registers values from memory and set the registers manually.

This patch defines the data structures used to communicate between c
code and the TDX assembly boot code which will be added in a later
patch.

Use kbuild.h to expose the offsets into the structs from c code to
assembly code.

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
index 000000000000..8eda3ce10220
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
+ * Allows each vCPU to be initialized with different eip and esp.
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
2.51.0.338.gd7d06c2dae-goog


