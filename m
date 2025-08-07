Return-Path: <linux-kselftest+bounces-38518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC44B1DE14
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163D458747B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743FD280025;
	Thu,  7 Aug 2025 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPuZMWUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BE27E05B
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597835; cv=none; b=sbBDsWGwZvym+hCxduqKvzinejCAUVifPT+7P5SPQlLkwhIWLOIqpiLdLZYmgqiTcw/vDO4GyAJ0257i+mR899XBxIRF8PTwNjQE9xlzLyz+EDc6vzHzbjCmuBSFI2ofDLTBi0DttWbu0SqbBrKD+g2Jn3Xe2UXYs7w4ensnODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597835; c=relaxed/simple;
	bh=Cx031TrNZdIdQOdyX5MvihIAkWY+q9L/OKrZ+vPmjlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dE5XsCO+osLjz8DznuiQdERAD72BzmsXxLj1qBHqz8oBYcN9JR3bE+oOlShXrrTUEHK4b04ck9sPxZ1HrPxz3yP3k21FusQLlI8fhFILz7fzaOwfjuf0DjIw48pmL8ghmyKvvuH8niguUcfcSOLDPbAZhRrjwEsqLsmhJdInjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPuZMWUy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400cbd4241so20684485ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597833; x=1755202633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3wuATvJOp/SkY0VMTyZzPLWrVuKCL/L6FqFW9/aW0g=;
        b=vPuZMWUykW85vr/wUjK3QQMoHeV4Zz+KVwBtTvK7shKxAyy3E633YVhLX4r5ad4847
         2YdpmahzlOzPrkptmxnKIdSdurHZpdXSB4FubuFLVC3Z0k4d7L4dXGbwybpdOrOmR4YK
         73L2obkmBKni/ry2KhMlJL1T13EDGaNO6scZcXPKeSDN/SeyhmT1eQhiLCqeRrYB99WC
         jc0Eo0Wi5Uu1qfVzaF8zI9u3yWGNgMM0suJCfdYQFg78zlab2Glk8huP3Y2I2Mis9hG5
         L3RxQviaR+bxvrkcxlIicSDVkQmK7RmhhidvALVDDSnovNuMuCi7gkDPfFDPZ3vnGyU1
         QxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597833; x=1755202633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3wuATvJOp/SkY0VMTyZzPLWrVuKCL/L6FqFW9/aW0g=;
        b=FiJQVomBarmTfs7QfeUpIpZSuaSeV0sYLfeeLWfa8F40j6ahJRSfc4v1PB70HpjGDE
         NLWg1otpa35l7EO6lScN4ch9OgZZJ4PFPzLc8fHK/yvg+DPFv98OO3qBsWFPANNpvphc
         s9os3I1G57/+Nct1YlHhlLsbyeYJRowykoYha79VL5tN4GD8k8AJavbokiDTJeG3cvRs
         vzquB5ChBMcMPaB+w04jbNKwbW27Ggb0JVBXTs+qAGTTTODcEnRAVbtauCZ2WpBRDLuk
         OfQUX+6r/USBpC/9KALIa6BpaANFgFscJnzedYiAnebAgZNOAZibnBIXyCZZPZQEpYPv
         gJ3g==
X-Gm-Message-State: AOJu0Yxm2YkltT38lR1qJtKUtMHJjqZSqDxhTHDdLS/Audws0sC+1Pv4
	ft6JsL3uabMPjy5jR0SH7m9eZKCkn/5JQAfeoRzaTefOhGbYKpHDPMt+QJqhZqjVSGlBM6gj/wb
	3DDH1mtjgQ+78mMMLJE6mkZdOWftWZpdPEB2ow5bmXvk0c/+uTNi9N+RhwjvRu29igGzSWGWHmP
	qxpUcfUaERdDNkKFbaMoUe6lqk1JImlC1fSNrVPcRaavg=
X-Google-Smtp-Source: AGHT+IE/3DFZe9krhrc2eyCS++Yn/kdLvd8XWaVDRyTWJURT0NfTFvhoaMS+6eOuMSLA/3cLW1O97RFczg==
X-Received: from pjoa22.prod.google.com ([2002:a17:90a:8c16:b0:31e:d9dc:605f])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef0a:b0:235:f459:69c7
 with SMTP id d9443c01a7336-242c225dbfemr4507735ad.52.1754597832669; Thu, 07
 Aug 2025 13:17:12 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:19 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-24-sagis@google.com>
Subject: [PATCH v8 23/30] KVM: selftests: Add functions to allow mapping as shared
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
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
index 3977719c7893..7742c01d48b1 100644
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
2.51.0.rc0.155.g4a0f42376b-goog


