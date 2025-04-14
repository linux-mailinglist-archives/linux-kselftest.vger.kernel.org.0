Return-Path: <linux-kselftest+bounces-30787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D062EA88E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106AE189AD60
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130723315F;
	Mon, 14 Apr 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIK+AcA0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0F231C87
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667356; cv=none; b=GAlhAucaXxh+tuMcw33mcGCDF1Erq4u1TZsukk2yRXNrsfN+RLWqQ8ckeq985m3Z21uGVFJcnUFtaVyruy+rWSUK9CWweOgZWQ+MTS6TpkI44ohpL+4BupdvyxbSiWZF/jXHT1iRVnGSPZGuGiVCTd8N2yNqhmWU2etjf2cL51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667356; c=relaxed/simple;
	bh=tCFtSTSogyNF/+rS9krKtvA9wAW2z3R8oZuKWjnmmA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SPjfzOo6AnKLfCuSCvjx2Ap1PZFBFEwcWwfr605lwkKMm7olyJ8aXmUgzdhKEiI3ZH0udTHH5l/MpPMly5uZyNtm/twt8TjAnGyc6/y4quvdaiMGTAfuujkIv2nfCp4TFQIfrZ4rkXaP/Sz721lRa7ArS2fTPMnICL/S5l+az24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HIK+AcA0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af91ea9e885so4039714a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667353; x=1745272153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OuYZt7O/LrariOfsKxnKybrKmybF4OGMs3N8T6kaPg=;
        b=HIK+AcA0yFWd88ge0ibGwcGxHrcUCpAyoa7OyxKy12FSx4ycnT7J8/MtjqnzJEkmI0
         ifKwF1gA684zZN+5CbG9qnNCljrTsWH0gwcv95i3OCj0SgYMr8ikVbiB5ddzOQ2jE7Sj
         NkZT+1lA5AtGF0qBlCPsR/D0Acqp7OXLW7X6VKGfcbBLXgb3YblvcJrMGT6kE975Apol
         OH/S4C+NnlIRw1dgDFolf4JqXwMIBFNu8ycTy6yhubHoCOVxnIthOJbHztvXDj/6TG05
         bREuYIIGXJHOCfBSxzNQG6ignPT7v5hfDaxqfp8PO4jPIlLmv5ABG9XboSaBV7RSK0km
         7Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667353; x=1745272153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OuYZt7O/LrariOfsKxnKybrKmybF4OGMs3N8T6kaPg=;
        b=aRufIfCN/Jh1BHuJY1aLt2s+8A6sgeFoqXdEQUgL+7RutFo/ecYQFXqSm7S9fIwASf
         GV3x83c4zBoZ9K4oIssqK238PTlhbzw0s7jtA+nAEnrVvJRgzXGbtJB6XyekRyCbhQk6
         E+j/lExF3djnBKrAV8tibavIm7YPvPtXIggW/q9G/mtQr3/1FKh1pcez2sNr1nD3LiGC
         sfT9OMkMX766YRNo9Hg53Xakrfs2iuNB9ne2uvpvw9H935MaAprStizXglIA43cXMnVt
         RkcYVtJWhXHoUqntQoMfGUvAlOoXJ5NRZtV0pFmfRaPFVCHzW3B/5g4dtTklRBVi9dOW
         yEcA==
X-Gm-Message-State: AOJu0YwqqtPcharoPt7J1Dhtg1bIaRahxiPCBK5si0rBEvApIWWi80cF
	tAwkqXPzYwMiHX6u7j+9Q5rcIVNl9w5vhh9vtJq+7JoO8i39m62B2iGqsNT8pSW0FN6/3oCoUZ8
	Y2ZVNi3xWw47qAgWiNjpcc8w9ZAei/aYi7G321q8JHQ+kAZjBuaFWwcvwjSKpao0z4LUnT14tmZ
	dV4AdT4P7weqMZjwc/BLi97hsN19+WuEW3BcDP+fQ=
X-Google-Smtp-Source: AGHT+IFi5Jv0DqyPsRLf8qX/GrYnlpfFg934hUE5Ea7Yccg4j8t8Sk9aMLE8ug9zdNZTLyTgfIgAgGe7rg==
X-Received: from pglz28.prod.google.com ([2002:a63:191c:0:b0:af2:5c9b:c55d])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d04a:b0:1f5:8153:9407
 with SMTP id adf61e73a8af0-201797b94ecmr19132125637.20.1744667353486; Mon, 14
 Apr 2025 14:49:13 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:52 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-24-sagis@google.com>
Subject: [PATCH v6 23/30] KVM: selftests: Add functions to allow mapping as shared
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
index 813ba634dc49..442e34c6ed84 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -621,6 +621,8 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
 void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	      unsigned int npages);
+void virt_map_shared(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
+		     unsigned int npages);
 void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
 void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
@@ -1096,6 +1098,27 @@ static inline void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr
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
index f8cf49794eed..008f01831036 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -7,6 +7,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "sparsebit.h"
 #include "ucall_common.h"
 
 #include <assert.h>
@@ -1604,6 +1605,39 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
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
index 9b2c236e723a..fef63d807c91 100644
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
2.49.0.504.g3bcea36a83-goog


