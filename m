Return-Path: <linux-kselftest+bounces-34937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37950AD9520
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB011E4A5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257A293C7F;
	Fri, 13 Jun 2025 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9mgj1L/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29C293C47
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842067; cv=none; b=XDQjSXxKKEx6xG7mK4TZ4DftuktOs88pnMI2MW7UGGitcCoaRpvzl5V/ArZHom0g6qezZTomZZuzBJEeY54SYcIdqEflW/oIkauIMp4wDcj+YrirHpgkFZFaIyZOPxDEovUyfNNo0j3fUQWcSyZCe/6P5f9R93DQeXBKUfwhZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842067; c=relaxed/simple;
	bh=KcVmSP1z2F1a4ltip8O2m08swJFdtWWy+j4vG4u1hDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ic9qR34PWNSevsLeluwsxvCd8Z1hWV5DqBWShJ1aZyCVMzG60Da7f7yvCUI/Wdc4PsS9ZpB5+NCDrCsaKyfXC3IV40hOE6O82FFyv5Lm9hYMCZvKtq+Hp67JWNcfRkG28E9mBa//sSj+3/EWjpfKlpe8qCkYk+zeyjxmjKvzslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9mgj1L/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234f1acc707so19994925ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842065; x=1750446865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AuGWyHRN5gujSVF8K3xVc7oiFPlkN5tzT3tBT+wdnU=;
        b=T9mgj1L/4sH6Wu09lsHAJ5Ukx3qoJyBYHvHzsnwoZqs86XKYZioxfi5Sq2mBoDifVt
         3wI4f6o3LrjidLCq3oETimLyPz+ysppwsMy9LpenI+5d95Zi6S/hvdfrRKCTlnDs3SgA
         eQVtGH/JiRnl84re/8diMaTwRwSYyCnAFbT+cCLNel62ev/yxgSg2ol+ksCdrLiCy7An
         P2bl1R5pE8F9Rn3N6s3sQ7Q9TSUwnRC/y12F0M2MZn9/4D4cNSnagzJ6DDyr6dcP7w6h
         7TBQCz+/VJfTovANygYhsKFTrFs7tCGzPJTqTuSeS0qq97olhnHP7vb5Svvb8RKKLgJ1
         gP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842065; x=1750446865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AuGWyHRN5gujSVF8K3xVc7oiFPlkN5tzT3tBT+wdnU=;
        b=ZmVimVnDbapqWE9HzMCNQQcrjpi79LyK3FOgPV4p2wQwZTTKMtSnhYTMAiRotIgNFy
         NbGLvi9/E32LUUTUdW5sIeaklMJ6khCAnJc3Xx6QPYOn2Ly+6NkeyuMkxEO91BO0A6Yo
         Mi9/3nyPHnuTBlSJV6lp9ihI1aJNJhuhE29LWjfa7nrZIG70I1y8g9q/4vYaOw77u6T3
         aCSy/NzpNYKbf/vszsf2Dz4PvwAVP3YbR0LbbbUrBZA6Nb5Cmasn3w+Lc8BToenxwh54
         BGBW7ighfNvi1uMstq2kgVhhXPFwc9dQ+VQ7S40zdsRUjzvTwh9KEg11SIRQ+AACaU4a
         zw7g==
X-Gm-Message-State: AOJu0Yxh25H1RHMGp5G1MrUIcJOg0hDjDwCPzt8Mp03MSkTjWOnnRdWy
	3r5dIQlm/ItQ9MGljpgVRvdYUM7ks/gqA6uOoJr/weFFEZuTTWLLeF88M3cvf20m4Xt5eJabRb2
	qGHgGldFTQ9E9l6uMnD6rU4TdBrcUqN5JEHeTxVHosbeFnd7zRvC/5K7DbixHlM60FqIA8hDNJY
	DmCuH8yoC6q7LkonmIZ8t6YfpkdwVQ50X2Gn4KjXXevaA=
X-Google-Smtp-Source: AGHT+IF18P5p08M+J/Joy/4/oVDXDnwIzpUjm+DY25LUCmL9I7E9TjnRyHCMNZ7btIS+DLrs42822fh7aQ==
X-Received: from pgbbo11.prod.google.com ([2002:a05:6a02:38b:b0:b2f:6681:1f1e])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c943:b0:234:8a4a:adac
 with SMTP id d9443c01a7336-2366b32d048mr7098285ad.20.1749842064612; Fri, 13
 Jun 2025 12:14:24 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:35 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-9-sagis@google.com>
Subject: [PATCH v7 08/30] KVM: selftests: TDX: Update load_td_memory_region()
 for VM memory backed by guest memfd
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

If guest memory is backed by restricted memfd

+ UPM is being used, hence encrypted memory region has to be
  registered
+ Can avoid making a copy of guest memory before getting TDX to
  initialize the memory region

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index bb074af4a476..e2bf9766dc03 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -324,6 +324,21 @@ static void tdx_td_finalize_mr(struct kvm_vm *vm)
 	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
 }
 
+/*
+ * Other ioctls
+ */
+
+/*
+ * Register a memory region that may contain encrypted data in KVM.
+ */
+static void register_encrypted_memory_region(struct kvm_vm *vm,
+					     struct userspace_mem_region *region)
+{
+	vm_set_memory_attributes(vm, region->region.guest_phys_addr,
+				 region->region.memory_size,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
 /*
  * TD creation/setup/finalization
  */
@@ -459,28 +474,35 @@ static void load_td_memory_region(struct kvm_vm *vm,
 	if (!sparsebit_any_set(pages))
 		return;
 
+	if (region->region.guest_memfd != -1)
+		register_encrypted_memory_region(vm, region);
+
 	sparsebit_for_each_set_range(pages, i, j) {
 		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
 		const uint64_t offset =
 			(i - lowest_page_in_region) * vm->page_size;
 		const uint64_t hva = hva_base + offset;
 		const uint64_t gpa = gpa_base + offset;
-		void *source_addr;
+		void *source_addr = (void *)hva;
 
 		/*
 		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
 		 * Make a copy if there's only one backing memory source.
 		 */
-		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
-				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-		TEST_ASSERT(source_addr,
-			    "Could not allocate memory for loading memory region");
-
-		memcpy(source_addr, (void *)hva, size_to_load);
+		if (region->region.guest_memfd == -1) {
+			source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
+					   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+			TEST_ASSERT(source_addr,
+				    "Could not allocate memory for loading memory region");
+
+			memcpy(source_addr, (void *)hva, size_to_load);
+			memset((void *)hva, 0, size_to_load);
+		}
 
 		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
 
-		munmap(source_addr, size_to_load);
+		if (region->region.guest_memfd == -1)
+			munmap(source_addr, size_to_load);
 	}
 }
 
-- 
2.50.0.rc2.692.g299adb8693-goog


