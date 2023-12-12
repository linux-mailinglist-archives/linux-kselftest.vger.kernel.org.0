Return-Path: <linux-kselftest+bounces-1729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1852E80F823
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADED6B210DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151D64CC1;
	Tue, 12 Dec 2023 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5SBDkyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B713B116
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-28ab4205b60so928310a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414031; x=1703018831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ+55M1H0qZo6X91hhLwa23PvdZhvqeKwQZ30mHQwEs=;
        b=m5SBDkyPWjRgLkEHL2PAvvenAAJM3IlCyqL+sHJq1RgzTeoctp17PBE8yFDOGvzPTa
         AWg5I2r9/vrmsQ224+1RLlxAWoU/H9iaSVl2NN77xmr++b9lKaJqsZsdAW5AnuE9nceI
         /1aNHB8R9ePUx89gsE240M0EvHnhxyVenSfLDMWxb5QRy5y68ZoJefas+CG+Xit8RnxJ
         gkWhAp85Y/GYs4odrkvXv6pRz1svCqs59b9RSSoLba4BJEoNFTUmqLPA3FsQt4NIiXs/
         tkPP0i2CnHhGwoa7seC16MTbOPUNwlr44J6MtrluilDxNm10dllsFR3VtAScX3oJPwgr
         Vo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414031; x=1703018831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ+55M1H0qZo6X91hhLwa23PvdZhvqeKwQZ30mHQwEs=;
        b=GzRayDeoekywEgo/Bw6DCChY921oehmycVxpGa0pS0WsXMoe10iH9+MYM7BmhrMoSD
         Bwx7ZzF1rFUJwfrWuCb14bf/INyeDOpPlS7TBHKa9d02gdndeX0mcjjquS96M/a/mzBU
         ZmIpT5+rcRrc9L+jXFuASTLAdJLA8wfAEO29b3aYk6nQ8wvIObDmQoJwo8QyegGJp79+
         0Exv/9bDvpSprFU5HA4fyIU6I1LT1QTyFDEJyZFLVnEc7CbhauT1KN18Ly5sJW5IL7C1
         4GXTsSLTt4OLHhT8FQs6WZCCHXYfFNy56EbGONEQ3jBYMbjXgEg/RGNF0ogyxtptJDfC
         qUQg==
X-Gm-Message-State: AOJu0YySKY++t/V8+3kbdN3KpLzBgaJVw3pmJpjmZkWIex4fERpiDbGj
	9cAxTUtUNWabhDzuYBrf/5ONgrCC4kQrO2cKEIWOgs8hxnTLDS3jXlZQv1dxTePfrz6UH+2Gnpj
	El05K2n+RJp10UH0B1uBwMk4aaDedFNs4Pj/2slIFFP60sqgd1Q+Zk1sh0/5U+fGVI9spJ2M=
X-Google-Smtp-Source: AGHT+IGrrCQ4I7TQxCpkYqcamRceKsuPqXvFL+HKwNI2jpNCtkJmM866iSTSbXOwhW4q37bO7UDTRHUXAQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:e84a:b0:1d0:c738:73ad with SMTP id
 t10-20020a170902e84a00b001d0c73873admr49342plg.7.1702414029871; Tue, 12 Dec
 2023 12:47:09 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:22 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-8-sagis@google.com>
Subject: [RFC PATCH v5 07/29] KVM: selftests: TDX: Update load_td_memory_region
 for VM memory backed by guest memfd
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

If guest memory is backed by restricted memfd

+ UPM is being used, hence encrypted memory region has to be
  registered
+ Can avoid making a copy of guest memory before getting TDX to
  initialize the memory region

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 41 +++++++++++++++----
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index 6b995c3f6153..063ff486fb86 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -192,6 +192,21 @@ static void tdx_td_finalizemr(struct kvm_vm *vm)
 	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
 }
 
+/*
+ * Other ioctls
+ */
+
+/**
+ * Register a memory region that may contain encrypted data in KVM.
+ */
+static void register_encrypted_memory_region(
+	struct kvm_vm *vm, struct userspace_mem_region *region)
+{
+	vm_set_memory_attributes(vm, region->region.guest_phys_addr,
+				 region->region.memory_size,
+				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
 /*
  * TD creation/setup/finalization
  */
@@ -376,30 +391,38 @@ static void load_td_memory_region(struct kvm_vm *vm,
 	if (!sparsebit_any_set(pages))
 		return;
 
+
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
 		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place,
 		 * hence we have to make a copy if there's only one backing
 		 * memory source
 		 */
-		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
-				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-		TEST_ASSERT(
-			source_addr,
-			"Could not allocate memory for loading memory region");
-
-		memcpy(source_addr, (void *)hva, size_to_load);
+		if (region->region.guest_memfd == -1) {
+			source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
+					MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+			TEST_ASSERT(
+				source_addr,
+				"Could not allocate memory for loading memory region");
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
2.43.0.472.g3155946c3a-goog


