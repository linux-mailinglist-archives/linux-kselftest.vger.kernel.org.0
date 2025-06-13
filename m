Return-Path: <linux-kselftest+bounces-34952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BFDAD9550
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D133AFF26
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774642E7F2C;
	Fri, 13 Jun 2025 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+7MZua4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD72E764D
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842089; cv=none; b=Osb6n4/WqkZ/WxpPDeZAhN6h7r+ft1GXYkH4VTcynSMjvC5yYCh5CZgH06MmjxzYbqId/sSN647ZlnWgGTX70cJUPpt1P43/HR5od1D7+mmKEzR/ZUfWa+CF8JNVSUKGHxIi1z23Gq+AuSRtypyXX4azW0o1qoJZ4nr8XwAZ3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842089; c=relaxed/simple;
	bh=2C+2kEFAidXBdiAmtKQtTcVt8b+ANXwI4lH2Vsd2jQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9+HEBMp/YeDaeS3wy1qr14nI/KiddifUi8YDAhPRjjcqRRjHETHga4H4N7EXnoYpZaluNeA1HYaPkliTf6ddGrP4idrrmNXGL+K4aRll8jm2rc9Q2gFkF4YBU2iG1UVd//19/Rjgs514e6QxxX1z1PafrvA0jkanHT0Tj6LJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+7MZua4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31315427249so2484693a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842087; x=1750446887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFgWYxy267IbL0nQfyQUm4Zewpf7Dgq0ugim9DGk9mU=;
        b=b+7MZua4+4jvouFkJcrmzltTkJU/YGnYW4eQ4Vp2yKtDZc3nt+b67Fw+ueloDgCQJv
         0kwQ2Zu9k7SpEgERx7iea3q8AbcCJRSJMxY19rHxYvDDAGxFnWVABUQLw8tTCRHX3Utf
         oABHQf62RiPWu1L27qd7wPNRHNtmAHGAuzXnqDhaXoG/xLsbXnPYd2C4wRHPiwlZ9Hgw
         BRGFl2hnNrkZrfJ6TB4TtqY9G59YmjKuEFSQFU+FHezvP1ayb8SOzRZpw0wskEtfzWFB
         aKYtiskg15ATnXwJTLUX7es4/vo6nKQk/fDN/lWPYmayk/+IFFrgZc/JpN5ADlgzj96y
         cnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842087; x=1750446887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFgWYxy267IbL0nQfyQUm4Zewpf7Dgq0ugim9DGk9mU=;
        b=P0HJ+dmJdca9DVPSvGrgXPi9eCqiX3T7YnOUt+VbGn4MQaiskSGC2aZUxTuI1x4T2U
         iG93002ElHCAtVTKpbagh/ZfjCjTQ7AHIRpcl3Qvzc0x3/fC4zti33UuQxBYpY8+q4fe
         nsujd/ccQZQY2BiBWVipe7eeo1CUQbDtog0BB0mBiIDKaYOrCAbUOFfYK8VMN9bvjWPY
         hal9kDO5UCZguSf1CAeGMo0w2F+gzlSEPwOlytXQeAH9z4M8pLN44rPT5CLoK0Z9QBfw
         RabnnwId7/nDa+9VZBlEuvyaga6jCFUfJVEgUnXh4/SrOmQOOmRNib0+M370TsJ0hjwm
         BpdA==
X-Gm-Message-State: AOJu0Yy3u3j+AV+TvlPuqNrb/7sNWpkYURwIWw+hRKn7jLvyMsCTxqub
	6JJD5O1BrANU5FBbI8zzEqTvhVeIPgZ2mVbedZI4mnJSxSQntdC1jIER62EH6sG9NqfexecdntG
	5eorrqzlZTNfKwb2WWQ/E0B4PQLcMdyDz+aFUwtxUFoMslFT131544HTeiRRkpzuAIoZqt9JdkN
	mvPvqciMehcOhunaNsX5ScxWfQsxSbOMPVo70tOruNrIE=
X-Google-Smtp-Source: AGHT+IGe15mCwwCd96v7UA/dXYTm8/lCFuStdhYtYkrBVfmMXpizKcKM1pTfsOeUNlOUPPb4xjgZA7gNqA==
X-Received: from pjyf5.prod.google.com ([2002:a17:90a:ec85:b0:313:245:8921])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5241:b0:311:c93b:3ca2
 with SMTP id 98e67ed59e1d1-313f1c7dademr1027312a91.6.1749842086897; Fri, 13
 Jun 2025 12:14:46 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:50 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-24-sagis@google.com>
Subject: [PATCH v7 23/30] KVM: selftests: Add functions to allow mapping as shared
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

From: Ackerley Tng <ackerleytng@google.com>

virt_map() enforces a private mapping for private memory. Introduce
virt_map_shared() that creates a shared mapping for private as
well as shared memory. This way, the TD does not have to remap its
page tables at runtime.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 23 +++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 34 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c | 15 ++++++--
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 0d1f24c9f7c7..2e444c172261 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -662,6 +662,8 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
 void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	      unsigned int npages);
+void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+		     unsigned int npages);
 void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
@@ -1137,6 +1139,27 @@ static inline void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr
 	virt_arch_pg_map(vm, vaddr, paddr);
 }
 
+/*
+ * VM Virtual Page Map as Shared
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vaddr - VM Virtual Address
+ *   paddr - VM Physical Address
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within @vm, creates a virtual translation for the page starting
+ * at @vaddr to the page starting at @paddr.
+ */
+void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
+
+static inline void virt_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+{
+	virt_arch_pg_map_shared(vm, vaddr, paddr);
+}
 
 /*
  * Address Guest Virtual to Guest Physical
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f7e00ea0b211..14edb1de5434 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -7,6 +7,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "sparsebit.h"
 #include "ucall_common.h"
 
 #include <assert.h>
@@ -1621,6 +1622,39 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	}
 }
 
+/*
+ * Map a range of VM virtual address to the VM's physical address as shared
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   vaddr - Virtual address to map
+ *   paddr - VM Physical Address
+ *   npages - The number of pages to map
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Within the VM given by @vm, creates a virtual translation for
+ * @npages starting at @vaddr to the page range starting at @paddr.
+ */
+void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+		     unsigned int npages)
+{
+	size_t page_size = vm->page_size;
+	size_t size = npages * page_size;
+
+	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
+	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
+
+	while (npages--) {
+		virt_pg_map_shared(vm, vaddr, paddr);
+		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
+		vaddr += page_size;
+		paddr += page_size;
+	}
+}
+
 /*
  * Address VM Physical to Host Virtual
  *
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ce422da10f50..5903acf0d055 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -181,7 +181,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
 	return pte;
 }
 
-void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
+static void ___virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+			   int level, bool protected)
 {
 	const uint64_t pg_size = PG_LEVEL_SIZE(level);
 	uint64_t *pml4e, *pdpe, *pde;
@@ -231,17 +232,27 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 	 * Neither SEV nor TDX supports shared page tables, so only the final
 	 * leaf PTE needs manually set the C/S-bit.
 	 */
-	if (vm_is_gpa_protected(vm, paddr))
+	if (protected)
 		*pte |= vm->arch.c_bit;
 	else
 		*pte |= vm->arch.s_bit;
 }
 
+void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
+{
+	___virt_pg_map(vm, vaddr, paddr, level, vm_is_gpa_protected(vm, paddr));
+}
+
 void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
 {
 	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
 }
 
+void virt_arch_pg_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+{
+	___virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K, false);
+}
+
 void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		    uint64_t nr_bytes, int level)
 {
-- 
2.50.0.rc2.692.g299adb8693-goog


