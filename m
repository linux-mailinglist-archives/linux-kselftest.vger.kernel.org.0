Return-Path: <linux-kselftest+bounces-48876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C277D19E55
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 770AC302B8DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B096392B97;
	Tue, 13 Jan 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZz3Lo8M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918A392C5E
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318082; cv=none; b=jVY0fFf25rBfHmksJQQNjIupythfuJXFqgd2tqPntXuCa6YP+JLF1YUj1d5ev1Enf17BgG7sEc7789DMCysCFiElexE6RDmdtO3EAW13Jo3dKPWOYtev8Mio0ZhhJ0s1Q3SUR6idSJFjkwr80arJ9JcgYyIOyPp56kyzUsC5Rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318082; c=relaxed/simple;
	bh=XoO5KMHdnpZAZi99zA/PXMxt1/PSOD8GRG3MV4pqspk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRmZIRMeu5xfvJCwoAEt24iBAle37weZoyhPTnGD5WXObZ2nkdeK0GTfNhky2T781ZqN8HIAeQK7DaP2gqkzFA3/eVzx1rO59aoXn1aq/9XDG0KfZw66BANhEyHXeFaps8Uad6L2qnmaNYXfA3nYFvdSBxCdwBhaxYEZ0Eumzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZz3Lo8M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso35856285e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768318065; x=1768922865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClV6xb3uKauwGoOx6LpIuCiwNxs8C5+P0pKaRtPxBMQ=;
        b=bZz3Lo8MKztcPyjAEV9HMqbB+OGMoaorN3IlI+eY2Nl7wm9B2Qdl1L9gaPyHSih3Ol
         oc1bkD4X2DDqXPeazlEWLav7U0njxP+ib4AZTIcfrpIVseiiZU09YgHT/Ju3YaP02vWc
         +skLtbII+LzguqY5BAPCTwvp64vtAaEFQ5KRZWrw3KpM8TnMu8LTmPgPJzlvb1Sb/HBN
         DRIOpzqulydJOQZpNgti7StmLhaN0E4YaSibE1gOLcKavTQfzyAz/qAd7bcIx+Wm8TT8
         bAD9hG2maOigd9rNYS7mTj748iOjrtkUuKcp8QpTZMDIXRxuYhh/hseZ/poE49D4jbnd
         mmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318065; x=1768922865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClV6xb3uKauwGoOx6LpIuCiwNxs8C5+P0pKaRtPxBMQ=;
        b=ZoGiKVX0Yf+AVuJzghCqoyb0fTI+Qpx6MGExM0clOoFIW4Xmhi8ex7fraKuDxKhK8h
         DtxC42TClU/Fyrq02wp/Gd+ynBKxMQFXkVATC1iEbN6gqlQz8ZNgmw1MBnl+ARGUm7cW
         NedYF1woRx/2+QDC52uX9WpxS8N4YMOLPcypMeHXvN8RVhvMaLWl13BwFMx6Vn3RVID6
         zN0533u/XFg7HO6mWq//9HpV3/eoYXN8810IEnH22JgDem0LnzRDQW4wsVy2Vd/cs2y4
         4l3ci0Blx97UD7m/IBvLgfKEzcsarZAtTR+AoZCdxm+USiODMCyEjd7AFCUvgXsUjw6s
         maIw==
X-Forwarded-Encrypted: i=1; AJvYcCUOsAAmMaCQRldJO1HNbkZqz6ru6uaAbR7H7ih0bXt6Qt0WsmIzIi48RNjdkDIyEan8q7K5/rSAfYAHYfwPY3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GBIrhJYUOKz9XFxK3hBa1/qpHlAsm6FDb3CQYr9jamwvwox8
	RonL4rpl5bvxp9egAQ39cRpppfHFIe+p5X5NLnF7nUr6xxBt1LO/KsVR
X-Gm-Gg: AY/fxX7VHGBPJKK65SROG5QnsQBGFmwjUaawf+jZtDrWo4dSeI5lkRfv7KxiBeQNnZd
	TId9Cw8Tk3xlt4smbZHKON2SAtK4/+279Do+nNNCUs7RerpHGKDw0iKBOBlWedOp2gedBMpX1Sm
	9tF17PsB96cx5PV8uWbV9nYQ8WljYvBgV20WGId+VuUpSdHNWn7ltjJElmWGRv96cn5QSbimSjw
	OqGsvjVu1yAt73UhrVWM0noahnEXQnPOS+9KmIB25nawnalqr5t290LcChJQHPfbphENeBpWALM
	Ds8NnWUODmA5HRM+aosgNayY0RYTCUMLQzEZBWaDzPN6ENV6/M1bU5YbFtL08cFfihOzxv/KsSy
	gtYOyuUNk9LSGK3iyXwvNyBlvg/pJWM+dQpOTKAL927bi5XPfQKe/X1h+dIlkVGsoAGIQg/KedJ
	bfN8ZgkuyiP0N41qhC6AketdcjnMyuj3rfplbrK5m6fDk7CZVAhgMwRVNyeSj+gBoRvQ==
X-Google-Smtp-Source: AGHT+IFPYD4aUkgLw+ElK2nCfQAn3fMA8ZdORSxU/HjmPMO8JbFroHKdhuJYQgeH2rPGmtTppuBJ8Q==
X-Received: by 2002:a05:600c:1391:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-47ed7cccaa3mr41796735e9.12.1768318064610;
        Tue, 13 Jan 2026 07:27:44 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm421025325e9.2.2026.01.13.07.27.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 07:27:44 -0800 (PST)
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
Subject: [PATCH v4 3/3] KVM: selftests: Add option for different backing in pre-fault tests
Date: Tue, 13 Jan 2026 15:26:42 +0000
Message-ID: <20260113152643.18858-4-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152643.18858-1-jackabt.amazon@gmail.com>
References: <20260113152643.18858-1-jackabt.amazon@gmail.com>
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
index be1a84a6c137..1a177f89bc43 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -172,6 +172,7 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 base_gpa, u64 offset,
 struct test_params {
 	unsigned long vm_type;
 	bool private;
+	enum vm_mem_backing_src_type mem_backing_src;
 };
 
 static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
@@ -187,14 +188,19 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	struct kvm_vm *vm;
 	struct ucall uc;
 
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
 
 	gpa = (vm->max_gfn - test_config.test_num_pages) * test_config.page_size;
@@ -203,20 +209,23 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 #else
 	alignment = SZ_2M;
 #endif
+	alignment = max(alignment, backing_src_pagesz);
 	gpa = align_down(gpa, alignment);
 	gva = gpa & ((1ULL << (vm->va_bits - 1)) - 1);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+	vm_userspace_mem_region_add(vm, p->mem_backing_src,
 				    gpa, TEST_SLOT, test_config.test_num_pages,
 				    p->private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, gva, gpa, test_config.test_num_pages);
 
 	if (p->private)
 		vm_mem_set_private(vm, gpa, test_config.test_size);
-	pre_fault_memory(vcpu, gpa, 0, TEST_BASE_SIZE, 0, p->private);
+
+	pre_fault_memory(vcpu, gpa, 0, test_config.test_size, 0, p->private);
 	/* Test pre-faulting over an already faulted range */
-	pre_fault_memory(vcpu, gpa, 0, TEST_BASE_SIZE, 0, p->private);
-	pre_fault_memory(vcpu, gpa, TEST_BASE_SIZE,
+	pre_fault_memory(vcpu, gpa, 0, test_config.test_size, 0, p->private);
+	pre_fault_memory(vcpu, gpa,
+			 test_config.test_size - test_config.page_size,
 			 test_config.page_size * 2, test_config.page_size, p->private);
 	pre_fault_memory(vcpu, gpa, test_config.test_size,
 			 test_config.page_size, test_config.page_size, p->private);
@@ -248,11 +257,13 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	kvm_vm_free(vm);
 }
 
-static void test_pre_fault_memory(unsigned long vm_type, bool private)
+static void test_pre_fault_memory(unsigned long vm_type, enum vm_mem_backing_src_type backing_src,
+				  bool private)
 {
 	struct test_params p = {
 		.vm_type = vm_type,
 		.private = private,
+		.mem_backing_src = backing_src,
 	};
 
 	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
@@ -265,14 +276,27 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
 
 int main(int argc, char *argv[])
 {
+	enum vm_mem_backing_src_type backing = VM_MEM_SRC_ANONYMOUS;
+	int opt;
+
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
 
 	guest_modes_append_default();
 
-	test_pre_fault_memory(0, false);
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


