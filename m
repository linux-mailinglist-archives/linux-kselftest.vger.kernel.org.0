Return-Path: <linux-kselftest+bounces-38503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313CB1DDE4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A269D583FF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA36274FF4;
	Thu,  7 Aug 2025 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASer0jg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00C274B5B
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597811; cv=none; b=OSMoCZWh5F7pjZYyqXXXxa+or2KPe+y7wxOwRFweCf7pXxCHDVbE1f+CVSIUUc7LTyVbLPTrE+ur7527NZh05jQLFP6WQJ0aLO6pXKb7NwpjycR842oKC/YheVoWTEdBt+GPsJf/cwc6vDuSHFWpU6B9cNI+v336/PPYWDY2J0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597811; c=relaxed/simple;
	bh=puYw+DEIdp6ykwAZy5OOEpeoIJJ7PtsStnf4pcAGRJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSf5ZsmDGmVF2TXqKMULIw4gttiV8usPCUAciW8yRg3GXu8Y9FqsNVAsi9QKnorOgvcM/k3NZsnbGVEQ5wj7v5tyPLxOqGnv0To/x9e1rjVMRIBtk6TirA1Q7zm85GsrjoIuGQ6DEmbQ7wjjNcm7Lw52uGsfZ/G4ze85+tFLe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASer0jg4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so2496644a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597810; x=1755202610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=US9j6ZWNrs7ioksHVAQpJEm6nvGXIAewRRt1GeZbRi8=;
        b=ASer0jg4yUmZWkEMR6nxaB9bE7jd49+PWI3Ai2oeyTYjJCKoFeLyxmXp97t3Y/xbP7
         2JuqPInrOdFl3k4aQFSJlnUz57Uw1B7UQSRz8l47Ii0uw8KuZOgD5lBa1aiPIUdBMRjn
         Xl9MWhW2f1ffzB8oEp3WMjtTG8hntyV5CdSHunWSlNCsOH9AC2fRiGFny1O1+3WSUZNF
         7bnDH/CtBue9HYrTj/gkpxJW0dcACVRe8z1mjeTZenSKYYVbGpzYsnvKy3By8a0T8WJB
         LV1tqu+C935dvtIGtCYu3sfJE2qQL69TMIf73RcCvmCnt4DINfQfzhCAFzRePWhLti3N
         w+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597810; x=1755202610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US9j6ZWNrs7ioksHVAQpJEm6nvGXIAewRRt1GeZbRi8=;
        b=S8wghf+/h31zheWPao7xsUeJaYHl6eoGOZ9WhDpQc68XNv/amBx3fG9ccU4qQHtv/J
         ZcohCktItW3KwoEhWfYzITUTePxIXQIvBPSwaVdtwgMuUumXiaEib1BY9CFCyIGOgGdD
         plmN9CR/Lt/Bw069BN2PZjGtEtuf1aLL8UmWcWSC5GG9D/80jvjP6PI7+n0sGLQe0p9K
         KLnR5JSYQhgV7V5IwFv5Gu7NeMIsQA3VBsbnvsbbTalQSU3dqrV2mC2ld8XHD/hIwKjM
         ZerGgXUwUdUgc2IMHc4mH5XDwMFLjw2gsx6aOUCEETThvQ+FHpRtLYU5wCi6cFZpK4YS
         8UtA==
X-Gm-Message-State: AOJu0YzcoDTjE74y8lm9spnCAj6J8Qj12CKDcEBqBV4Vxl7lCDg+Co55
	+C9hIuz49GfewKW50agAZbJDLiDInFXA1ZbuCLqP5TEfh7PzTxZ4mw4ELWPdOILef3Aaanqp+GK
	qghzjBDElDQmUMS8uuyR+Iz1qXrc7HaEqCq+1PyGr5l4jmpN+Y7swhsxtRt6HqL6gY83FJDQLCw
	mNzw3QENc2M6r4MhDcLQigNdU47H2v1+LaEzWWkhN5gFw=
X-Google-Smtp-Source: AGHT+IFyMZB6DpVtHi3kL/x2IK8tM54yw75AkkxHEHT74p5qROfChvdgkD5MZdZL++lkM7KX+XcCTQn/Ow==
X-Received: from pjbns14.prod.google.com ([2002:a17:90b:250e:b0:31e:a865:8b32])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268b:b0:312:1ae9:152b
 with SMTP id 98e67ed59e1d1-32183c48d07mr385969a91.23.1754597809647; Thu, 07
 Aug 2025 13:16:49 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:04 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-9-sagis@google.com>
Subject: [PATCH v8 08/30] KVM: selftests: TDX: Update load_td_memory_region()
 for VM memory backed by guest memfd
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
2.51.0.rc0.155.g4a0f42376b-goog


