Return-Path: <linux-kselftest+bounces-40737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E036B432FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C308D1C25CAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA228B407;
	Thu,  4 Sep 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvylHoMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DF286887
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968917; cv=none; b=TdtYYrXaucvR/V4fmKnew0wJk6FvgbwzUSsg/uCqFiTlkARK1wvoc9b7f8EqJg5UHGg+cFUO4kjwHtjUrQ+2KBBCbsiU5r+yOm1DWkDgqzryPPEy5jMFTwpbP2fOrsfrkKq5YDZmlDCNkVUcItAEwJvjUXc4irav8zjoPETFSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968917; c=relaxed/simple;
	bh=n+L9vWeyzbQUQZp/RqgYkXX79E/BX1CQXhnoKJC68eU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lWKP17pwiLvbl61hPOuNXnXrOfA4itXSLfslROm8uEXu3YGOgAcWX4rB92kTnkVPTMSCIND3maFU4/bPNkf6WNFfi/O9cEs2CP8BZ5Qp+ac3JX7niWbvhMKCLorOzJm3910PjZXNcTa694vEKb+fzSx8bqA4iTnpik47pEmpEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvylHoMt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329e55e686dso877205a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968916; x=1757573716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOAKBocMN15a/GPc9+kQ8WwGfS18ZYkBgBZhxajgBOA=;
        b=JvylHoMtUn4mrPz3+4990jL8csqbUWcN9OiTegZciJyIdUW7E1W3M5L16DKrsbfFfq
         baHrUF+ZlmJRxraTr+VEugMNjoQOVWFTt5FTKix35F3/rSFOiDyYxeqKq2QY4zGwE37L
         /UnVgmPLs38cMJODojWzLBwDnMfWEyfathO6x9GS4WmpJ3YM8/5QIWpIF8RDxte25Bq3
         tM+1bBSmA8cP29Up/YXzp/yUaQ8vPjRhedAAYEEMoZs1VM8RjDZ5qVRKSIbrXsdSWprV
         6wtGaX5T1fLrf0Jz0hHLbRop/qb+M3yQf4uriDwewuUWnVVjLQGRCi+at70ph0cTeBl2
         6JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968916; x=1757573716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOAKBocMN15a/GPc9+kQ8WwGfS18ZYkBgBZhxajgBOA=;
        b=UQeDP0DGL3wX4Ht1fhqBVyzsejiJnDL9Ep9WDmMOEanUPx05vk/3U/Sz4KPVPfL+I5
         2CWi5zzdwEKCSZ1UMyUu3Sj903Xx3OUB3QUkihPWrEO//ZGQ4lye3uVQvXuQoOfiJ0gq
         syU11JbDJc14LKXqtDyNhTYjEHlqiQ4IeNFogltP6Hx5cj7Ppxdc9xhJ+GMcetUW3rrJ
         EBvkJNJxHy4xvB9kI/7YsiapzTpa/debaNFHx2yu+BtjhcOihA6jPTn74WXTuV39pY7A
         T8/GUHa4P5SxsjXtB8joz2g8GVl0tQEdWMwsriZ+asrqvas96IK1lBIsUFK2hLewJ9LU
         KJqg==
X-Gm-Message-State: AOJu0Yw4uAYqpHoSFDk50lePb+5jjPqgMpHbATrMIyWZpvTKYsBpaVPb
	GzyoIR3ClceX8FaPZ4+c6cvKDTvPyZkp9KMY27fe+iQz49ZacfNu7tLMwjN3PK7A6IlMp3iPlms
	p9BlzDl83LdxzZwNVnHjc+HPLcJ0GgsYbdZdzeqcXilsZaZ0SKr67GEIjb/kXJyLiwm3ZXOx8Ll
	hKh3dXGTOEOYX3XtZiZtQmhgtawFovg5+vbGZjGyJxzMs=
X-Google-Smtp-Source: AGHT+IF/JgzkvqqUvrXqyvg4ttqyVIVVsNkmsuNFfNqAnjTzj0j4TENvTPgfKFid94anRdEttRjKvvvZcA==
X-Received: from pjxx3.prod.google.com ([2002:a17:90b:58c3:b0:32b:4de4:2ac9])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530d:b0:329:ca48:7090
 with SMTP id 98e67ed59e1d1-329ca4873c6mr14454454a91.37.1756968915479; Wed, 03
 Sep 2025 23:55:15 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:38 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-9-sagis@google.com>
Subject: [PATCH v10 08/21] KVM: selftests: Add TDX boot code
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

Add code to boot a TDX test VM. Since TDX registers are inaccesible to
KVM, the boot code loads the relevant values from memory into the
registers before jumping to the guest code.

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
index 8eda3ce10220..17c3083da9ca 100644
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
2.51.0.338.gd7d06c2dae-goog


