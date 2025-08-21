Return-Path: <linux-kselftest+bounces-39444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA2B2ECE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0383BE151
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846222EA480;
	Thu, 21 Aug 2025 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CobjnBMe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE872EA14A
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750581; cv=none; b=YgNEHyNFBWisoCbbzuJdSQvgBD9GVayP3+MIoCl6p+sbpSR1TPz5yD1PAlTh6mRCyebF4qfjbJFhlf69i3BHwMayD2fEj4ePq9fRojYkciT/4U82zVPhK7CLEBW6KnH7jwKLjcLRiH5KeF+Bt4BuI2pmzTn/wPn76m4a99Z+Kmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750581; c=relaxed/simple;
	bh=NUi+wLh63XmU2/9e9btG6TTRvY/VrCTLCEnPp7jjenQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XljaoKwQ6lOIXhH6ZA+hsW5r0uUE2guti5mNvJGh2erjCLf9JAFq2P4P+M9rvH944mvfj0lR3SbtExGXcbRpBDpULiDY2/Of9wNi/e7hbNl+P5ZjlDNTij8BMGJc/6/E169u4ad4sEccWfY041XZST8hlPxViRcohCRnjHgSNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CobjnBMe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458027f67so13032855ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750579; x=1756355379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vju2IXdyDSNF7xuvLEH3C0LRA97fTr3t18ZFMFBtRU=;
        b=CobjnBMexNnMsTbdsljf+BxlCFI8X0URwqwLbgeUHN4JyGJNosiHmi91CvtvHslMI1
         EXefOgxVhHdRkr8DtT4Ett+89JSB9OY0yNHDNNTBuDaU8e5oBpMLd58lty0gX0hxiNyu
         E6XllGuJ0UNvQTb/c5zPW54KvJEBGqlU34Sxfm7vS6S5z899Kjh3ts3qli1+qAEP6kZ+
         s44gABaLKIc23oil7GZT7Cfhb42t5EgCjJkdgjZ0CSs1upkRcHysvqI1LOa2jWNOiRJA
         rpGOL75sQrsMozWVTkqTte1pALPvMSIbxqaYFiCP3ujHQBOyhOqdqfqMRvt3HAjsJ5k/
         YkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750579; x=1756355379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vju2IXdyDSNF7xuvLEH3C0LRA97fTr3t18ZFMFBtRU=;
        b=lFBqnjYuC1MwAxkoK0nZ955JYBfmmxR1+4TRvM6G8EOLpqB8P0Rn/Xi4eDP3t8ykft
         FaO2/BaXImTAdYhCtKgiORrUgA5mWhUSB+afOPIuiXhm9fbW786SQWBQWF0YbxSjdH4w
         NO2bPJibqZgNTU2Y3WYZctO4K1W6B3toApDjmxsOVvbghTF1BysKNfmCGDP+uGatQbLi
         qsn9a71EyoNS9zbfrzkQZ6VELHAMy1Wke53i/2E8Q6fskwrFrZphMu2bUuUN46Yd5IbQ
         3RI5dFZqRuXjANlgWyBiBfICgobN0/FeIAu1lxn41+fKGKStYEIvBlIaX1LwAo7yLDIT
         mFDQ==
X-Gm-Message-State: AOJu0YzOM4lzOe08x+jn8OCLwgwTYrcG3ZkNRXeAKMcPSdQ8BmSulXLz
	AyJBqCaQJlCjlH/vwfoHKe3ck7E1Yzl1S23KKDKcx7sdoMkXTVc0u40/mpLlYX/xP5eLKUUxphq
	bnfSvqcKOtYF1k3jDs9RBFZr7BV5Jk84Hp4SvaTUdu5UPh6rROmR4M3QaIxUCfSbtlfazYkY2lg
	pMZr0gnQROxfty7Pjv8bu6zbJ+XzPSML+ZXVeuKQa9EGE=
X-Google-Smtp-Source: AGHT+IHtx93Wr+8FjzBgy9E/bSjt5H5ghDMawbNoFrIZtX1PPjx+tQDbbekIaI8BQILiBI45ztn0MUZiPA==
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:321:44d1:ebab])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78b:b0:240:bf59:26ae
 with SMTP id d9443c01a7336-245fedb04abmr16890325ad.36.1755750578963; Wed, 20
 Aug 2025 21:29:38 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:03 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-11-sagis@google.com>
Subject: [PATCH v9 10/19] KVM: selftests: Set up TDX boot code region
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
index 03754ce2e983..c42b579fb7c5 100644
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
index 000000000000..15833b9eb5d5
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
+	TEST_ASSERT(TD_BOOT_CODE_SIZE < 256,
+		    "TD boot code not addressable by 'JMP rel8'");
+	hva[0] = 0xeb;
+	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
+	hva[2] = 0xcc;
+}
-- 
2.51.0.rc1.193.gad69d77794-goog


