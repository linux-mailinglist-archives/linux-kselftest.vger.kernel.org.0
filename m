Return-Path: <linux-kselftest+bounces-34930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A158AD950C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599151E37E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232C243379;
	Fri, 13 Jun 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUCMjW9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2623C397
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842056; cv=none; b=VirNEs/uniMBFUDQrHVmVl6SJgh8PU+nq88GwvhEerF0avnaKWclzGVCe8jWyIrUrs3CmB40I2vPpPXWVODT7i4sqnFPZMIlogtJPLw2JVVs1r09z4wZNjWBmpnvLtUDpBPPBy0YFCpzIzd+bQtJ2rkmcHdgSnDhWhNo9Ccjxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842056; c=relaxed/simple;
	bh=QuoLs+Ux/84Fr9p1idJvfX2ZqaXEeJLcVJ7fjk8E1lI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nj4J+3/Rsku0LhC+LhQOwKMYuy7SH6ddu59cJYlUJBPDBxS2aus4N5HEXmVwBXYOjnJhVSVeT+p1vvrykP+rdlPcfInTvEFQ+vxNZynJ7dR3a4kMg0425vNdqo42TwQd9m2B9tCPCTxGXa7uIAJTvfgBbNDsKF+Zyu4MD90Hy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUCMjW9H; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-745e89b0c32so3896717b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842054; x=1750446854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8nR6zImbEfU50Eu9z3twsYvD96Y1yoYJi3jd8xgLx4=;
        b=wUCMjW9HOeW8D41iioeTYFGt1Noeodi/Am/DeAmASpS7iuz39bQOynq6ddWI3W6IhY
         XWlLQH/nFWL5Bs1xo561bKjeA0A7atEJ9TFzkWo3/opnnSLX6jRh7gp0Pkyo4sE5+cOM
         eVMz4L2y6apHpitZ3/YPmi1vL+hj4u33Jiae1wCPP1OWVZGByywP1gbAlHRNYD8iHwV9
         WCcTFcmQtVfYQ4neaiOpu59IaQcLlbau7Cwu7Hgl9S5w1mC8M4cGSIVUSBwDjb1MKfMl
         l17+LlPxH38TlQwn9mLdVec2K+7ChFX+4k7mhDDFZWpWdyVJKZFlV5jULWDO8dm24dXa
         Xxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842054; x=1750446854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8nR6zImbEfU50Eu9z3twsYvD96Y1yoYJi3jd8xgLx4=;
        b=rfJtugEKxEi0ksS8U5FI3zTztKjDMOpx9fjiETiVkiBN0t9/qZSHiljt5OpucsVCi/
         RCu6yuf+urE+bNbBZaILDF0UgELeABxioUI52THf5zRtPYRZyI7cdl8PPMy/APdXSWsW
         hH3NRpnNPvbLOPr+hr6/Kxdul2u8ikYYVPGX9BfCzQxvT+QNUddEwD2SDMnlpZHB9hkl
         dPxnPMaTQV5TUJlovMQQZuMh2FYVo8lDhkyR0huBQX0SgOm5aU0hKsIv7wFotfUtXUMe
         PjxWYwKhfuTZtLbfpOk2BXicOTyzBIIpMFo362rNyF3Y0zhyMbgL4nLAXJJCNG4kC5Wz
         zYjA==
X-Gm-Message-State: AOJu0YxLsC3J4bPDTp93mDghS0Ii1wB1FYoZeIVWBfvibMntDGWKSMG1
	FIYpwKgf/g/y0mZ4aFbqpsxE7KZVqKEAJNEAI8TcDx7OxKyZvp0ZcAvr8xUEUWIkQCCZSJnsZSp
	zPXnU77Wo6SaOyZQ9lHM72+/4iUihDZDOYJnBAkH2x8uSsyhk39skoIFEdVY3nrSjIrWiqH9s7w
	G+hWAvi/9W6agOqH6c4yVUOK9kqK9gG2QBGQGKYfIBLCU=
X-Google-Smtp-Source: AGHT+IEQ8vV+FXVD3XBCjRhMRewZ5yjQ1j2sph+yUOFNhR655zuqbYE+7ObmNf6VZS8HUTBkCOPm+HspBQ==
X-Received: from pfblh20.prod.google.com ([2002:a05:6a00:7114:b0:746:2117:6f55])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:513:b0:21a:de8e:5cbb
 with SMTP id adf61e73a8af0-21fbd550de1mr661897637.25.1749842054156; Fri, 13
 Jun 2025 12:14:14 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:28 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-2-sagis@google.com>
Subject: [PATCH v7 01/30] KVM: selftests: Add function to allow one-to-one GVA
 to GPA mappings
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

One-to-one GVA to GPA mappings can be used in the guest to set up boot
sequences during which paging is enabled, hence requiring a transition
from using physical to virtual addresses in consecutive instructions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 27 +++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bee65ca08721..9994861d2acb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -650,6 +650,9 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type);
+vm_vaddr_t vm_vaddr_identity_alloc(struct kvm_vm *vm, size_t sz,
+				   vm_vaddr_t vaddr_min,
+				   enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a055343a7bf7..8f3dbf749afa 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1460,15 +1460,14 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 }
 
 static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
-				     vm_vaddr_t vaddr_min,
+				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
 				     enum kvm_mem_region_type type,
 				     bool protected)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = __vm_phy_pages_alloc(vm, pages,
-						KVM_UTIL_MIN_PFN * vm->page_size,
+	vm_paddr_t paddr = __vm_phy_pages_alloc(vm, pages, paddr_min,
 						vm->memslots[type], protected);
 
 	/*
@@ -1492,7 +1491,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type,
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, KVM_UTIL_MIN_PFN * vm->page_size, type,
 				  vm_arch_has_protected_memory(vm));
 }
 
@@ -1500,7 +1499,25 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
 				 vm_vaddr_t vaddr_min,
 				 enum kvm_mem_region_type type)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, false);
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, KVM_UTIL_MIN_PFN * vm->page_size, type, false);
+}
+
+/*
+ * Allocate memory in @vm of size @sz beginning with the desired virtual address
+ * of @vaddr_min and backed by physical address equal to returned virtual
+ * address.
+ *
+ * Return the address where the memory is allocated.
+ */
+vm_vaddr_t vm_vaddr_identity_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+				   enum kvm_mem_region_type type)
+{
+	vm_vaddr_t gva = ____vm_vaddr_alloc(vm, sz, vaddr_min,
+					    (vm_paddr_t)vaddr_min, type,
+					    vm_arch_has_protected_memory(vm));
+	TEST_ASSERT_EQ(gva, addr_gva2gpa(vm, gva));
+
+	return gva;
 }
 
 /*
-- 
2.50.0.rc2.692.g299adb8693-goog


