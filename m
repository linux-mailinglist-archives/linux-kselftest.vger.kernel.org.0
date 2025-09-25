Return-Path: <linux-kselftest+bounces-42375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15869BA0DC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98C04A16A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25C319855;
	Thu, 25 Sep 2025 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dp9CYfVe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B782319866
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821356; cv=none; b=tzRBdcpu838Pp7ZRMNCvSrCm9sRLHXouovnX2ubopELj3RLQM7Tk2RILdt+C6O9KNiHgl5zcvCnCukxYItx+MU19EI4FwWhT/YHYCJ42SNmbGS0pawiWd0wW1mgHfMZr6MLr02RLraaYi4ITZwFhmairKzYOUAmZpHhYAUhgJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821356; c=relaxed/simple;
	bh=dcZcfLBHEDdJ8yMegXc/dito69RMVA2QXmBxWBpDAAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aPlqp1+4Z2Ni8QfV6hxLxVqI7prOdNFLmN4fnoaZjKE1yoliI63Sq57FoNbpPROFzuBDPnM7UHldDQuGBLB1dRVnJdEK73utzqp4BGT7LQjjR36WdYZWerkP90OBdFk1727VMVWLOFXmfAGYtKZgOsy0c97LL6wm/CBydMcdG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dp9CYfVe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269a2b255aaso22110825ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821353; x=1759426153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjN2And+41EcoLkFolWMI5aqg9xz/C+Uf176e6DCrIA=;
        b=Dp9CYfVeWEYRrtna9BgQBmDpNjKx1mY50EydMWVnoYgawhAXR0LXQYrFB+zqYtZlqN
         C/L9NXrPuBifskY8HmfczuP46b4/4jRYhdbOWk1+DplYjkcGJ9146+rvGCzOafhCprLS
         8MFWAHlOkiRlpRq0nujfUIdz7VzAogN82IJWDV8GYZ8XrQDJYBavbb0eLSryP/SfFaD0
         iXmj5xazlggOASbFIelbVPEjLSyj0WS76YNB2W80olNw+/aLavOHHwWC+c5IkM9hTr05
         GZNWRlGL/bz0tXvjdWqN0VGInJd7tXaJtx2fIBdH2R0l2ZA3DmTYUFuTogUzUqADqHpu
         k7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821353; x=1759426153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjN2And+41EcoLkFolWMI5aqg9xz/C+Uf176e6DCrIA=;
        b=ta3jLhpFUXAgb2jBE0SrsHA14Q4yojVsCT5WBSmRsJIrTfAA42gpW7447YDOnVA0YR
         ZBwvbdNAwKw8nFBDfn71c5NbAryfV+LwNXDY08qgqGbANjzzYz5x2wqmDmQCq6t5rP51
         6wHsDbIDp2gRiZ0Ur+JXJzKXaqpwGbGeBYCxd02zTUTUA3VfLMXiTDBstekj68ok+OJm
         GKnFte3ze07qMMPurLxzIAnaT+dH2FLwTTMKmFp0ydR1M0Q6TMtQE8XRx8jchL/Fs+Zg
         QrQevgYkU/wPwkiq/69zDPuqpeiMG2RicHyMPoZgfLL3J9DYq25639fgU27M4fuRQqtR
         QbfQ==
X-Gm-Message-State: AOJu0YwPG9qtg1br4fykODwZC0/ahrWOAgnQsd0RQ6skssnV7hhayA/R
	IFJCZP9mCIqGVM0JLVZDUiYNq6AwUlIabCuv98Zy9SPjN6YgLMBZfOsvsBLt2VfUrPek+JykjkD
	tXmDI8LAWCEq5u3vcHi75q4DRGa+Mix61fn1V7b23/wxPfltPyon2emXXVkhXcJsiWLBfnDjGak
	CxDESi+XAnrOQl9wMcddq53/V0SpBucdxW9hC+oa0ikXg=
X-Google-Smtp-Source: AGHT+IHerot8YDYpsW/lm7uci9zz8zXkTxKtb9HrunoxbUDNS0AZvZE8G1xYW/zyexL5yW3KvcXNUJvQZQ==
X-Received: from plblo4.prod.google.com ([2002:a17:903:4344:b0:274:e523:6f5a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c6:b0:262:9ac8:610f
 with SMTP id d9443c01a7336-27ed4a09677mr43910195ad.22.1758821352834; Thu, 25
 Sep 2025 10:29:12 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:36 -0700
In-Reply-To: <20250925172851.606193-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-9-sagis@google.com>
Subject: [PATCH v11 08/21] KVM: selftests: Add TDX boot code
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

From: Erdem Aktas <erdemaktas@google.com>

Add code to boot a TDX test VM. Since TDX registers are inaccessible to
KVM, the boot code loads the relevant values from memory into the
registers before jumping to the guest code.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  3 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |  5 ++
 .../kvm/include/x86/tdx/td_boot_asm.h         | 16 +++++
 .../selftests/kvm/lib/x86/tdx/td_boot.S       | 60 +++++++++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 3f93c093b046..d11d02e17cc5 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -31,6 +31,7 @@ LIBKVM_x86 += lib/x86/sev.c
 LIBKVM_x86 += lib/x86/svm.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
+LIBKVM_x86 += lib/x86/tdx/td_boot.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
@@ -336,6 +337,8 @@ $(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
+$(OUTPUT)/lib/x86/tdx/td_boot.o: $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
+
 $(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
 	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
index 32631645fe13..a590516dd83c 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -66,4 +66,9 @@ struct td_boot_parameters {
 	struct td_per_vcpu_parameters per_vcpu[];
 };
 
+void td_boot(void);
+void td_boot_code_end(void);
+
+#define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
+
 #endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
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
+ * + provide enough contiguous memory for the struct td_boot_parameters such
+ *   that there is one struct td_per_vcpu_parameters for KVM_MAX_VCPUS
+ */
+#define TD_BOOT_PARAMETERS_GPA 0xffff0000
+
+#endif  // SELFTEST_TDX_TD_BOOT_ASM_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
new file mode 100644
index 000000000000..7aa33caa9a78
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include "tdx/td_boot_asm.h"
+#include "tdx/td_boot_offsets.h"
+#include "processor_asm.h"
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
+	 * memory to control registers, hence use edi as a scratch register).
+	 */
+	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
+	movl %edi, %cr4
+	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
+	movl %edi, %cr3
+	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
+	movl %edi, %cr0
+
+	/* Switching to 64bit mode after ljmp and then jump to guest code */
+	ljmp $(KERNEL_CS),$1f
+1:
+	jmp *TD_PER_VCPU_PARAMETERS_GUEST_CODE(%eax)
+
+/* Leave marker so size of td_boot code can be computed. */
+.globl td_boot_code_end
+td_boot_code_end:
+
+/* Disable executable stack. */
+.section .note.GNU-stack,"",%progbits
-- 
2.51.0.536.g15c5d4f767-goog


