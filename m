Return-Path: <linux-kselftest+bounces-30766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F09A88E30
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C3D16BEEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2821F5425;
	Mon, 14 Apr 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PX4vlN3q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EA1F4703
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667324; cv=none; b=oho1SExRgDq0oyUmhk431Zr7FEx12fXk9u+ykRX29EBQHE1zzbFlPDLQegbQK2HLMzd17FH6+oc4U+KVoBQd17bPypP91N1QPB2MfkcbK9v8h5KXLc7a7SUdi/XkZf9msefntKRwSqT9WXhojeDCHPjkFIOWKArlZcl5DBKYTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667324; c=relaxed/simple;
	bh=zXIy8wp9ENWZZU/yGe029AJkVIa80ioH9U720gzOIyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dmUTl7smEct97UYhvQY1n4vaIyEr5mhJr2g8fuYqHpPcBAZQyX9JdugEJz2Noc37ycfGu73KJNxmnWRSQbVjxzmu+Iu9tQ8Cu9OreVXHbQLCpiP0nKMFkitCKucATjpRV6GoMQi3TVO5hGUZYux8X6XBPRY8oO4Ezr8b7LNPHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PX4vlN3q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-739764217ecso3892438b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667320; x=1745272120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzI5aRflQA+UIMG4VjX2vvTmh9PpabPrUILX2tEJsMo=;
        b=PX4vlN3qAlJ/me9qZV+GZglZ+wL+SCCycUcvVVYTmMNXJ9wUSnnIZQeuIDw59VUMNL
         rSrT2DLjGCKHTtykP+XGC94k/yu/P4phNIdSNxe+yHfdQwUYYOH50FFXJQOJndyXTebW
         PK/izYcPoSDadCB6qx1rexHKVWlzNdXITyHozGPWEXlwMLnUauXGujkDIXVN7EeLTOnT
         WJ2zF4G8IMOMXwjePPsTrK4eIUZ2pe7+5WP9sd0LzTwfVu2my/8ykHTNi5U7WvYavM+G
         WKld0oBtUdDW7czFbyp8KS/R3WXqOkqLi2GtYKItOXgfLiUDkUv2TciztXIsRonWW0vD
         /UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667320; x=1745272120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzI5aRflQA+UIMG4VjX2vvTmh9PpabPrUILX2tEJsMo=;
        b=q0PfiMaQ9pLJFdiFuXmoxwmqwR31rKf89dD7k5P1vZxCiuizaHGmLL/CC+9ZAOulOa
         mvO/xJT5aapmonayz/hYKJhMor3mEXmAx24JUWolxP37IvFPTBcm4Wxz4BwQxoXPzsZb
         ffvVUhA+MvvKYOV6VmEc327drvedDizH09B9Du1RUpPCDjgV7DrEEpwEvRdhZZ+XbmXR
         jCRoDWWJN5NuYkoZEUtgtcGmFQsTmODunkNDCXNLvUvfH1MSYYgT3GuC/ANjwvKndPD9
         tO57gIOoGTtzJlFskUgtVeD9wqbwxZp5uZJSADNAvgf1EIKqG6pTiMzpDawDiscVKx8H
         yRNw==
X-Gm-Message-State: AOJu0YydC4jYxIEGDhevFBbm7ZyosuOjOYant8QwIUvsj62AWtM8HeC0
	mmEPgK6Qxlpp+LZBPX4KcV+sdj3QfAlEtDLkBzhj1ZUZqgdAzvgHX30dYHy/A8239nzxVno9IVq
	SeM1YTWaDRLtmCSvgheKME8UuILRMXnfsan43FERSDkaJDAeofc8vga0snVFE78yWDN0Z1Q69ba
	KJm93g09eoYlUGUOzklw8J/32a9aJqFI4DrwJY4LM=
X-Google-Smtp-Source: AGHT+IFw8vSXyfGeiog1g404xaZ017GVCJhGGbLRThfJe1UiAaqNHvSMOzvD43pJ6KSMt107c1fS4vO/xw==
X-Received: from pfbbe16.prod.google.com ([2002:a05:6a00:1f10:b0:736:af6b:e58d])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8a4a:0:b0:736:b923:5323
 with SMTP id d2e1a72fcca58-73c0c9f7177mr1344426b3a.10.1744667319920; Mon, 14
 Apr 2025 14:48:39 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:30 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-2-sagis@google.com>
Subject: [PATCH v6 01/30] KVM: selftests: Add function to allow one-to-one GVA
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
index 373912464fb4..1bc0b44e78de 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -609,6 +609,9 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
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
index 0be1c61263eb..40dd63f2bd05 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1443,15 +1443,14 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
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
@@ -1475,7 +1474,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type)
 {
-	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type,
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, KVM_UTIL_MIN_PFN * vm->page_size, type,
 				  vm_arch_has_protected_memory(vm));
 }
 
@@ -1483,7 +1482,25 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
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
2.49.0.504.g3bcea36a83-goog


