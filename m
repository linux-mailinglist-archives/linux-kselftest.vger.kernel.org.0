Return-Path: <linux-kselftest+bounces-41253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44BDB53469
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B9A7AC3AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C1338F51;
	Thu, 11 Sep 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvlHHC4S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76E338F35;
	Thu, 11 Sep 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598598; cv=none; b=jCQ2rXlwvJRZw4cXyygAfYAFqXarbGR7u8l4r7idvQsFcWH8fAj/L2FOMrLCLfk9uqM5tMbiVUzc+lhOuk8lHkBX2Wr2XdYLB1kPx5WhCx4DV8g4k9VqzOdjRydT14hlqjdtVaEVuIckV7jZxplViEDTwgOgHkHdbhhPT1OkklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598598; c=relaxed/simple;
	bh=AfUKt9Y64nk4DJCkkE4xk0dAPQmcJX1fmTUpYECF7XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSqrrB0wBSDYUO5XA+c2fbFrb2URlzSYpmw54TO8b4Eoe43apzAjgXcEbY03vGxUm7k1I5jHSMlqbk8E1rcm5Oy2K5OdbvuySyAX3fClWS7GlJBRnxoh3/OHQC1MtlOzhqfyo2AjHJ6kr+dg21W7EQmfJFrREkImA4yfpV6iZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvlHHC4S; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3dad6252eacso337703f8f.1;
        Thu, 11 Sep 2025 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598595; x=1758203395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzQnDluOQWqcbRXyu07+4Pf89SEymkI9ph5TfK7+5co=;
        b=LvlHHC4SmIi/kSG7pkg+UfQottCcU4htM/n6X9PUTkJlogSi8knYWYfrFai9JIvKxj
         /gZd+8PTWfTiMqXlHA4+xXVC5RzaM2Ye0WVaykmFiHkwZeItG+D0r7cV+01YKxIKG0DL
         /HSLQwTaHzp75LOirXqkknbgIAJjq1ogKMs8nfWCUFUFCC1ms9pdAjir0KE7mfQ6rq6e
         r/R51e4ToIVIoxrdIuF+30U7tL6fCo2JOBViYGmDYPfpZ/lgR0jXpJP42d2OofyFhurr
         JVr+MhHZNHblOGpTErJDcsFKqRp1PoQCZRCBQBo0REH08VcvHXlaCUHvtmOpq5IPWr4+
         LRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598595; x=1758203395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzQnDluOQWqcbRXyu07+4Pf89SEymkI9ph5TfK7+5co=;
        b=LYm9hpuQP6VvgilRjxVzcIElwQa8EpUHOC//gYj4txvaR3fkOxFn5NE+yOz7ZfEjqq
         BTaQ8Gqs0Tyu/r8vCZ9Bicgaf6sujFniyMSsz6vdHXpoG9IjbS7U/lg+O5MMHeTnV/Jh
         tNYQx7Wz/cFTxnovVpAF7qBCgxL+Khk2QZMezY6QwA7RT9cBrOgnjoeyW2ZkbqovJghm
         KL0SL6NT2TX+qRLYfoEk9jX9YJmUpkp16czVNZMwSX5S7vcCaUKHd7zt4WROvswQlrso
         rDoDdQlqY5ikMkDX0ahwQL0vUWiy9YmA152+5YfAZRnx+43rfwWoWwfsSbngaQIIR0+8
         vTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2P62mtAJoiCtTJ0x07N7bZ7Gq95oRE2FzcSOjhyuMVXPwP/gFv2fQ/gScaK1sQ2XonV12B4nWpl+Y2nI=@vger.kernel.org, AJvYcCXNaeB3MPGS/3aQFCqx/WNr+VqZGaEW612DTAehKmWXzA3DiTNdWRykxve9/dqUU2Mar78HBalY0uDWf+0XZt/k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fzfrKh4Ml5Wl3gy2gVOMcgZSpR3nigkzg1LZxREbLFvOQVaX
	93d0UdHq8LhoXl4EqrdozyDGtMdCQZ8+dA4x7mSaXZi1o5tL5rQlhzIT
X-Gm-Gg: ASbGncsau6d4qd0HiCKCDUcy2X9425bbePlJYkAGmw5/JbyFUHfPZ0PkFbGf9zDDiJs
	ex3AyIi1WoHpOQ+5OLIT29UBpaNf9KEHypQ/qidZKFbFSUtWiBb+yt3zscYEYGKWpK/Ma/kcgbT
	6IETBtR05zCmV2PqArg95OQJac0FAMm8BUg3j5A5Vow5fp0fXBt+hEW4JPzcI+UbMKY67mmxdS+
	yKGBDGkJ1tIPqelmy8van+34Ic+BUvb/64twZRfTWvCTZR8qMwt5/r4T3F5VGZRXJ0ygde/qu9b
	ouopxNpnbT/puOjTUQe729W4NXOYrUruYv0XLz5uJLrmA/sU56KB9O64293KUOqzZNjiicHO9cp
	5DhB82AkS1hmkOPW0DjUVeFJBrL+zBRYJF5IAidMdpe4XOHOZARaGHvRSRnb+fwy4Fslj7+ew
X-Google-Smtp-Source: AGHT+IG/J8P3rse6GJgnSeKVDJySxFHBWlgnLhBSgwpmqxWIY8gC4wxlNuo/9KWFNfyudpaEFtWD+g==
X-Received: by 2002:a5d:5d02:0:b0:3e1:2d70:674e with SMTP id ffacd0b85a97d-3e643e08071mr16467931f8f.47.1757598594539;
        Thu, 11 Sep 2025 06:49:54 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:54 -0700 (PDT)
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
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 6/6] KVM: selftests: Add option for different backing in pre-fault tests
Date: Thu, 11 Sep 2025 14:46:48 +0100
Message-Id: <20250911134648.58945-7-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
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
 .../selftests/kvm/pre_fault_memory_test.c     | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index ed9848a8af60..22e2e53945d9 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -76,6 +76,7 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
 struct test_params {
 	unsigned long vm_type;
 	bool private;
+	enum vm_mem_backing_src_type mem_backing_src;
 };
 
 static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
@@ -94,7 +95,11 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	uint64_t guest_test_virt_mem;
 	uint64_t alignment, guest_page_size;
 
+	size_t backing_src_pagesz = get_backing_src_pagesz(p->mem_backing_src);
+
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(guest_mode));
+	pr_info("Testing memory backing src type: %s\n",
+		vm_mem_backing_src_alias(p->mem_backing_src)->name);
 
 	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
@@ -110,10 +115,11 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
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
@@ -155,7 +161,8 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	kvm_vm_free(vm);
 }
 
-static void test_pre_fault_memory(unsigned long vm_type, bool private)
+static void test_pre_fault_memory(unsigned long vm_type, enum vm_mem_backing_src_type backing_src,
+				  bool private)
 {
 	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
 		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
@@ -165,6 +172,7 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
 	struct test_params p = {
 		.vm_type = vm_type,
 		.private = private,
+		.mem_backing_src = backing_src,
 	};
 
 	for_each_guest_mode(__test_pre_fault_memory, &p);
@@ -174,10 +182,23 @@ int main(int argc, char *argv[])
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


