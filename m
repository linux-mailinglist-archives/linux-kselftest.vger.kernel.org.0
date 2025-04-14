Return-Path: <linux-kselftest+bounces-30772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406F0A88E41
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DC13AB5DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBE3208997;
	Mon, 14 Apr 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kgx0xRY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FA20469E
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667332; cv=none; b=er12ZBrMHV4bP6sOCJ+qozXKYnlgkHqnK63ls2vAIc6hSc6yjATEAAXRFo83eJlii16VKT5m2OdXoRXQB7jY/4Ym3jChy9C0iges0yGbKyf+5iudMIBc3nl7HRrscKEdZTFaaOTKqz0xbkAtNG5iBIcxVPfxfwTKHXpCJixB7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667332; c=relaxed/simple;
	bh=ocxRN7xdwWLtr5hQHt+BZ4mkKFTanjb/oeVK5mDnB68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgRhHVepLmpkAIDWgI1m1kP0prijjRbIMgJTO1Z/ZhWP17mpqEU0bV9Z5BI8IvGzxlJP/ypi/oRfmvOLUYMapiESrZLtqa/4VgJBRsjHV1rEV4tzYb/IqoRP6W525tsyJn6BBSZsISL76PjgX7Qx74ke6Q6J/qA+hV4QpC8nzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kgx0xRY8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73c09e99069so506127b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667330; x=1745272130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRhTODvisTfaiy4uFCxlPOQM9xPsqUOZrcKfVYCdQmc=;
        b=Kgx0xRY827sI1nxJaSfiKHrG/nL4NVkiDHxFdNUtWsTVlDQnJgTtzmhegA8xQNegl4
         yKfHOVsUs1UinK0jt7ZcTf+UK7j9TrjwdVRQfMRCMqxT/oHD4Tv/Hl6szM5lJNvAntX+
         ewGsnEqDlnbvgkpxOcda7XCCnq7lEzi+v7I8MTNz2Nn57TzMdrXGjuxCk7KSt96ivRxd
         ArZ42N4FdYHJ3JvBDcdlFlUtmnZISeB/vqYRfQUtQEu8ZffoX4sbOTMF+w6YlSW7Yf5D
         XXzQXG41vfwjqnjbN6krqMAThMkVOgc3TmFXXAUbfQJIA2JAoaiRTdlSzaCMYJHpinbp
         5ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667330; x=1745272130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRhTODvisTfaiy4uFCxlPOQM9xPsqUOZrcKfVYCdQmc=;
        b=QXCqIdpC3lAUbzhwsHqgZIwYZEpMxmYfJM9ptC1GKcBGzg+uDyC72IekBzGkzx5DFZ
         EoVAr5SEwXWWBZ4JYOJoYCFUS5o428yY4UUdHJwbhCPWQNF2fWo0367WF8mT6nJRQfMt
         mhEn/I9Fn80TaL7RhIV6hWP/Kjb2KhVu/iDv/u4oFfNJccDaSpHPe/tjeHhc6Z2ImuEc
         3U0ssrvkIfaVsairPlS0MWuQem6ADJdkS2lLTRbfyMeIxRSYKs8Vym03SkaMy3mNUHJY
         wUenvxgAZfQ2HcsVDxmhporOG/FTE2eE1ehHUG36lLrKnpkztXtvHIOyuyO1Ne9+UE2L
         0foQ==
X-Gm-Message-State: AOJu0Ywcc+V4Um35Yt/fr/pd7sZxSbFefFI77GDfpNvriXnWEBxRDDLq
	UUtvYNzltYP6CFhmGYIQT+fFpn12NK5flm8ivWy4Xpvb+BL/zHAcNUvQwq7aV9icjThq3Wf5zJG
	KzffEsr3UjrlM6rjkPcip1/kUd/S6yCd55Wt06kJmRUoVxs5axbomxLGvBXazkY3abF3axwvfvC
	mHyLJff52Cd0QemjA8HVOooAUMvYt7s1YIcDLaSJc=
X-Google-Smtp-Source: AGHT+IH2ANqybdgPb08Zf42UrpVzKMTzNDhF/aTJYqnSLdF4VZx5xXyV/A/WViTs4yT1sBwJSAozJW64vw==
X-Received: from pfjf20.prod.google.com ([2002:a05:6a00:22d4:b0:739:8c87:ed18])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1907:b0:737:6e1f:29da
 with SMTP id d2e1a72fcca58-73bd12dc5e6mr18296407b3a.21.1744667330365; Mon, 14
 Apr 2025 14:48:50 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:37 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-9-sagis@google.com>
Subject: [PATCH v6 08/30] KVM: selftests: TDX: Update load_td_memory_region()
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
2.49.0.504.g3bcea36a83-goog


