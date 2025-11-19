Return-Path: <linux-kselftest+bounces-45998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BF3C6FE89
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2913334A526
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E453730EC;
	Wed, 19 Nov 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUiH1uoa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6436CDF4
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567381; cv=none; b=UUVIHL+ZGA0CIAfgVXhk6V8WxtdqzM7miSoAKaCw0P5V9Ema9nX8/aQaxxi4f2Bwc5a1ZWHv6Ohl0/Y8WYh33GJ28f+FmDIISuBP1OnKz2rF2W6kBPMjFSorcGcrHOF5a42aRaMWPTyt1AGrMhxYOyuwOBhicPfsYqr0eo8l1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567381; c=relaxed/simple;
	bh=sTnGVg0SCaIrS4UjjUcMvcDbivW2KJoCD34GtIJku8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iANlOUkApk/azyHZaZo3APoNUBlCGMA3dZehZmCag3+tF/160riaVAvaGSICz7AF4Dzi3rYbzeIBOvDe5p7x+jny5A0Yy2YEEdCe4NEVvAVu/wSdq3EMwhoxbUQNSqZWchuCLz/UhJISAQ24HwsUH4zSAwB/t0NI6jCvdptGtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUiH1uoa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755de027eso46953095e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763567377; x=1764172177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxA90nGyzmSaiY6A5XGVLVAHyvsgTHRyJZyrvZboKIE=;
        b=QUiH1uoatNKgaVZS7t15EjkrJsfRTJixt+bHZtUNcxvZJ9XqioXXHnQ36zSLj6YdA8
         7euX9erZBOia5tI4DqzWu3hChskAfwnbEpQmoO5rkzHf95jjij7vA44RF0CNbiVT3/vO
         A4ykgJaSw43+R4i03wLy56+opWW9SJ07kmcdkNwhbVR1D3gMgmhTE4Vat0sgB2bejVqI
         PizjpwziAQtBFp9K8TercF38i1A9RSeI1R2T67Fri3eukT/w2w1KyhdO1vC+IL8DeJOi
         jvqUYPdhpexljHvb2fYB1G2lzTObxQsNh+49eU+5Z1HlUQ80IdTdChdK71Egfn99vSBV
         pbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567377; x=1764172177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxA90nGyzmSaiY6A5XGVLVAHyvsgTHRyJZyrvZboKIE=;
        b=mjkSu/KMUAI4qRjWKGChjf6mjPng2fR5rltG1i3IWR588oc94ra1AmZz1DOiA9lWlp
         tuNPfBvTpiWk5bWaAEJUc5WdTgQdhVFoDzpYd7RTttrkBlC1WgB3btwGIQmwZOtCVJd0
         GNgstWfkA2pNba56zo0Qxz0WKHHNVs0NxoTXXwuNm+orx037pJJgt1xjTN8cky8nNNjC
         9E3HzdA6d+ol5HRW5KNm2dtvlgDxKvovbhINS3Z0HTfNwMliFApP+UHTxC0uEHXXKuzq
         d8JuIJQh2t3LydgdaYG/NusBuzn0L8UjsqD4gCf61n0yKWKEvWgeAm+inLUCeR+eVi/3
         5qpA==
X-Forwarded-Encrypted: i=1; AJvYcCVT8CTk+hTfKHNbkX7Gkld+Hc8Qp4F+dO2GMT4NR11bJVxzbgZQ6Nv7DKyesVbUBPoTnz5Q43AyeANvjF7xtwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpD4vVwp3BxtBg3w16JtzXg/7wudUcNFuhRpQ5JpXTq5uJwmU
	frn7h39iOQADrLv4aIOsZdFtxyL/G6MUDY7/KfSZx7S/nK28lc/5FPpx
X-Gm-Gg: ASbGncuEXIUzXZix96S7ZbHKueNCxK9b3PlOPM1PCE3OFNySsU8OHS/4xw3HE3R6bx/
	PMYXAc/k2TIeUS+rhIsVNz2o0KhXnprfSf8WA2riipw24IpBESwJDZxTqhYyQMg/F1wHHtxKpR5
	Q8LbBc9B+gWrROSqcQnZ4yabzulTuPigVWLtYgEg9vDRnkZ7cGVaJYBK4z5pUM+zsmtRP1rfkNu
	UMrkV/rMpxcCpfkOOlrVINJqlpzJyupmy533V33tox5VXhAIfYGpIkUnuoH+j7NR127hzK5itRn
	wBWJnOot1JpZU5ofwvrZkTTqm459ixhVjL9sPv1e8snooqcGecbAUV3LWN60quOkko5t9MddC8w
	1U57saLQgwlOd9g92iGe6P/ESwPh1Py9EaoTEQ6qUGO4ADe0nCjFwTaLP4kO8IaRDGNYIiM6qNv
	hWm/z+2uDz40gvFFd+n5CusARhhnw3geHLZS+tBXvjDoIgePkcBec1vNxpmG3spHjLuQ==
X-Google-Smtp-Source: AGHT+IEHRSEOlV/PjXO/es3oQjzN6p04w3tM9GnKGrsmunlZpgWhO8lg57u4CtlSOr65Ov1n2stQfw==
X-Received: by 2002:a05:6000:288d:b0:42b:5567:854b with SMTP id ffacd0b85a97d-42b59394d6cmr19768291f8f.45.1763567376680;
        Wed, 19 Nov 2025 07:49:36 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c9628ebacsm25969755f8f.30.2025.11.19.07.49.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 07:49:36 -0800 (PST)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v3 3/3] KVM: selftests: Add option for different backing in pre-fault tests
Date: Wed, 19 Nov 2025 15:49:10 +0000
Message-ID: <20251119154910.97716-4-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119154910.97716-1-jackabt.amazon@gmail.com>
References: <20251119154910.97716-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Add a -m option to specify different memory backing types for the
pre-fault tests (e.g., anonymous, hugetlb), allowing testing of the
pre-fault functionality across different memory configurations.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 .../selftests/kvm/pre_fault_memory_test.c     | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 674931e7bb3a..e1111c4df748 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -172,6 +172,7 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 base_gpa, u64 offset,
 struct test_params {
 	unsigned long vm_type;
 	bool private;
+	enum vm_mem_backing_src_type mem_backing_src;
 };
 
 static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
@@ -190,14 +191,19 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	uint64_t guest_test_virt_mem;
 	uint64_t alignment, guest_page_size;
 
+	size_t backing_src_pagesz = get_backing_src_pagesz(p->mem_backing_src);
+
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(guest_mode));
+	pr_info("Testing memory backing src type: %s\n",
+		vm_mem_backing_src_alias(p->mem_backing_src)->name);
 
 	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
 	guest_page_size = vm_guest_mode_params[guest_mode].page_size;
 
 	test_config.page_size = guest_page_size;
-	test_config.test_size = TEST_BASE_SIZE + test_config.page_size;
+	test_config.test_size = align_up(TEST_BASE_SIZE + test_config.page_size,
+					 backing_src_pagesz);
 	test_config.test_num_pages = vm_calc_num_guest_pages(vm->mode, test_config.test_size);
 
 	guest_test_phys_mem = (vm->max_gfn - test_config.test_num_pages) * test_config.page_size;
@@ -206,20 +212,23 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 #else
 	alignment = SZ_2M;
 #endif
+	alignment = max(alignment, backing_src_pagesz);
 	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
 	guest_test_virt_mem = guest_test_phys_mem & ((1ULL << (vm->va_bits - 1)) - 1);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+	vm_userspace_mem_region_add(vm, p->mem_backing_src,
 				    guest_test_phys_mem, TEST_SLOT, test_config.test_num_pages,
 				    p->private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, test_config.test_num_pages);
 
 	if (p->private)
 		vm_mem_set_private(vm, guest_test_phys_mem, test_config.test_size);
-	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_BASE_SIZE, 0, p->private);
+
+	pre_fault_memory(vcpu, guest_test_phys_mem, test_config.test_size, 0, p->private);
 	/* Test pre-faulting over an already faulted range */
-	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_BASE_SIZE, 0, p->private);
-	pre_fault_memory(vcpu, guest_test_phys_mem + TEST_BASE_SIZE,
+	pre_fault_memory(vcpu, guest_test_phys_mem, test_config.test_size, 0, p->private);
+	pre_fault_memory(vcpu, guest_test_phys_mem +
+			 test_config.test_size - test_config.page_size,
 			 test_config.page_size * 2, test_config.page_size, p->private);
 	pre_fault_memory(vcpu, guest_test_phys_mem + test_config.test_size,
 			 test_config.page_size, test_config.page_size, p->private);
@@ -251,7 +260,8 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	kvm_vm_free(vm);
 }
 
-static void test_pre_fault_memory(unsigned long vm_type, bool private)
+static void test_pre_fault_memory(unsigned long vm_type, enum vm_mem_backing_src_type backing_src,
+				  bool private)
 {
 	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
 		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
@@ -261,6 +271,7 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
 	struct test_params p = {
 		.vm_type = vm_type,
 		.private = private,
+		.mem_backing_src = backing_src,
 	};
 
 	for_each_guest_mode(__test_pre_fault_memory, &p);
@@ -270,10 +281,23 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
 
-	test_pre_fault_memory(0, false);
+	int opt;
+	enum vm_mem_backing_src_type backing = VM_MEM_SRC_ANONYMOUS;
+
+	while ((opt = getopt(argc, argv, "m:")) != -1) {
+		switch (opt) {
+		case 'm':
+			backing = parse_backing_src_type(optarg);
+			break;
+		default:
+			break;
+		}
+	}
+
+	test_pre_fault_memory(0, backing, false);
 #ifdef __x86_64__
-	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, false);
-	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, true);
+	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, backing, false);
+	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, backing, true);
 #endif
 	return 0;
 }
-- 
2.43.0


