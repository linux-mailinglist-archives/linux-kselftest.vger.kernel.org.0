Return-Path: <linux-kselftest+bounces-40738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189DB43303
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D391C25C8A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9809291C3F;
	Thu,  4 Sep 2025 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qu/EDxFo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364728D8D0
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968919; cv=none; b=c9OKHPmM+0HRi/m1ngaqP/OXOQfndAnVh6xREXu7c50dka/7XF6b6eTwthyZmvXMP4TP3Cp/gx6es/lkES1PsAiKDqh2vXtnwVhuuism1MbonSB14L3EGG5fw/3/PSsGXcy0Q3vrNgmb+akmkgFz6RaTw671/SIvJpdUgGxEZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968919; c=relaxed/simple;
	bh=fl5WFH2pE48prKI9Xye9Kp56WYjFCfdYw5kFeG22K4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y55//ZnCHlXAu17i3fM8xoUCf4QQ0m9jv9DD8E9NWMuIQ3faZx+rmBfudATbbBX5FYZCSdmJxNCu9qr73kXHbqvur5zRqdtocZVaY5l4SWBLCqf1xLkH4MsLOR1EQ6mEZfQLdZfP725xK/eIZ/AJy0g6E6husd3KBW9Ckh0JobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qu/EDxFo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c9e2213f8so9977285ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968917; x=1757573717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbSK0q2wvsUvwJsHeMu0UEX5HMzL8ImDejpjGFji5HE=;
        b=qu/EDxFoOV4ELyAERC3Qntxd6bkNghnA2r0qmvIeUWNwki4V2b8pm+py5zhzI3oufK
         7vHYBNuY1oXYfm67uH/mvuOlDFMNZfJ44f3BSqG4HjxvMuUoeJZhXI3gYNkO/IsafBXw
         NOht/T8ybr7z+drBQI66MvRu/wvQzKFsrxmipxFRZ77fadmsNpGx/Ev0XVh2oAMLfAQa
         lVPVZ8dvXALSnhePNPzKvkXsmldLPt7cHpctWI3quH8s2PuLEuMrlqRrLi1/s+nEWEXc
         5fL7+Gq76WMOzvvfYhxxBlg7bO6gM/yPIsKzqp2el/PxEgfKRJSxUlvSAJtOi/NY13Ag
         B92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968917; x=1757573717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbSK0q2wvsUvwJsHeMu0UEX5HMzL8ImDejpjGFji5HE=;
        b=q8vnQWNYUKeagKdQ7OunzfR5zBVbR/OcCFZdbqjXSD1tlriEgPsQAMAL+r1Hsc7vIF
         zMqmt1CvY3aztiuAGncaZLeaMpeGtGdozoiNMVi2RltyyAK09sgjily0iZ0Gnw7LuFDb
         +gv3nqfv2gXj1/eEMl2Uh4GSZLgwKKSclt7mYnAs9tudeLW6L8pFIqwdT+XN7VV5gjrO
         WtW5NCVtsWpKACukjXYMlVn0s/UcVD5EeHxSvaIY4ldb82z6Ik4Ww7aHFjik/Cs/Apc6
         NR09NxNfSL8E1Tmo7Mt9CR0hz0vajnp9s+RaP2VEpD+bUSZPoI0nchgRZi59hjHhD1G8
         i3sw==
X-Gm-Message-State: AOJu0YwVK292JAQQlS6BSVgVz/V4SqbTBV6Y0vmkYoYsGq6IF3a9JaXK
	Z+7PiXb2wrvfjDFrVxtXpFCEImPnCQnlcKlQRJ+bqMOgdumqdML8wfQZ8k6BT2dMBJ6iNcVC6UP
	bEzN9HWiUk7rTGe3asoab/3b5SPt9yQL8eb1pKzH2ZIIsNs5e73gvtp77ReDqDguMOrGZVitT4o
	/AGoX0YKKHigJkjOg9yrxvIIjOk35BhLw7ixMce8JTvnc=
X-Google-Smtp-Source: AGHT+IEIVmyBAsxeMnfR2DE0V7+2eEBlwFJC8ibSKdd/uSqU1DT1NSlXejdciIy1eX1XFGzYaP5WdMeUOQ==
X-Received: from pfau2.prod.google.com ([2002:a05:6a00:aa82:b0:76e:1da7:f2ba])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244c:b0:243:c23c:85cc
 with SMTP id adf61e73a8af0-243d6ddb139mr26453840637.7.1756968917074; Wed, 03
 Sep 2025 23:55:17 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:39 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-10-sagis@google.com>
Subject: [PATCH v10 09/21] KVM: selftests: Set up TDX boot code region
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

Add memory for TDX boot code in a separate memslot.

Use virt_map() to get identity map in this memory region to allow for
seamless transition from paging disabled to paging enabled code.

Copy the boot code into the memory region and set up the reset vectors
at this point. While it's possible to separate the memory allocation and
boot code initialization into separate functions, having all the
calculations for memory size and offsets in one place simplifies the
code and avoids duplications.

Handcode the reset vector as suggested by Sean Christopherson.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 54 +++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d11d02e17cc5..52c90f1c0484 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -31,6 +31,7 @@ LIBKVM_x86 += lib/x86/sev.c
 LIBKVM_x86 += lib/x86/svm.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
+LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 286d5e3c24b1..ec05bcd59145 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,4 +11,6 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
+
 #endif // SELFTESTS_TDX_TDX_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
new file mode 100644
index 000000000000..a1cf12de9d56
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdint.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "tdx/td_boot.h"
+#include "tdx/tdx_util.h"
+
+/* Arbitrarily selected to avoid overlaps with anything else */
+#define TD_BOOT_CODE_SLOT	20
+
+#define X86_RESET_VECTOR	0xfffffff0ul
+#define X86_RESET_VECTOR_SIZE	16
+
+void vm_tdx_setup_boot_code_region(struct kvm_vm *vm)
+{
+	size_t total_code_size = TD_BOOT_CODE_SIZE + X86_RESET_VECTOR_SIZE;
+	vm_paddr_t boot_code_gpa = X86_RESET_VECTOR - TD_BOOT_CODE_SIZE;
+	vm_paddr_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
+	size_t nr_pages = DIV_ROUND_UP(total_code_size, PAGE_SIZE);
+	vm_paddr_t gpa;
+	uint8_t *hva;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    alloc_gpa,
+				    TD_BOOT_CODE_SLOT, nr_pages,
+				    KVM_MEM_GUEST_MEMFD);
+
+	gpa = vm_phy_pages_alloc(vm, nr_pages, alloc_gpa, TD_BOOT_CODE_SLOT);
+	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc\n");
+
+	virt_map(vm, alloc_gpa, alloc_gpa, nr_pages);
+	hva = addr_gpa2hva(vm, boot_code_gpa);
+	memcpy(hva, td_boot, TD_BOOT_CODE_SIZE);
+
+	hva += TD_BOOT_CODE_SIZE;
+	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
+		    "Expected RESET vector at hva 0x%lx, got %lx",
+		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
+
+	/*
+	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
+	 * code, as there are only 16 bytes at the RESET vector before RIP will
+	 * wrap back to zero.  Insert a trailing int3 so that the vCPU crashes
+	 * in case the JMP somehow falls through.  Note!  The target address is
+	 * relative to the end of the instruction!
+	 */
+	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 <= 128,
+		    "TD boot code not addressable by 'JMP rel8'");
+	hva[0] = 0xeb;
+	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
+	hva[2] = 0xcc;
+}
-- 
2.51.0.338.gd7d06c2dae-goog


