Return-Path: <linux-kselftest+bounces-44244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FFC17414
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 23:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481CD3B9A06
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FE836A5E6;
	Tue, 28 Oct 2025 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mo6vsxdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF836B963
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692339; cv=none; b=rHtvnB7OLG2zcPMW43QlPgoyQ4IxxHpdhCAWxvTehfuCxT/+pLiefQaPQ7712j/I6+afn/GDnuOyW9f3U/zNRy4ldoJWp/Ow38jvvXq512HdiRTthcoNiNQMAzCyjYnc+YU7p3UIhXVIsWLofmBC1/GDk20uHpiJucjT0QbagNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692339; c=relaxed/simple;
	bh=6S5tzR8kzOK7LjG9F9GQo6jk0uAJ9VKQm3dBNs63myU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TiZh/oYDgOtiAn7jM0FpNPsxm2NiGUXLRaGhxaA4671Qkr+sIf3+vDLlsFBmIGk+ZRQAPxUYqOfDp0Ya8wq1vGl8AEyGhn5gP1xU5SUAHw8kFVsV/2zpswY2XdYV6GuS3OyKkd+gefkAoQWTDeARa5IbgFB2YA+wDgn0ezYbDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mo6vsxdv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33baef12edaso5953304a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761692336; x=1762297136; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ip0GSPcOf73baSNEbw06pVGhZdDHrjVOI7is0zaeU+I=;
        b=mo6vsxdvZtIxTLHNOfYNPvz31cHR/F3ZArQjk3u/DrjHBQiAE1NCWlfyrsnDbIyYHf
         AGBcpKFn/pZc5CyIJ2JWtywGyBHSAFJG+rlytZc/ZwdCPYc/bidxm5LMJLVvHtQLVX6c
         wyfQMHzT9PKTq0xwr7p0T6EOTy+nIAsv/jjLyTLM8bmWc65oxhxbTRl4MgDv6AmKMnYH
         rzrEqd9cHOL/rNaXIfpQ5WyikaxE07rqBSRgCSeoHNXRtebV+G3hfwiTnS1ztrDzZ/Qs
         bG/Qvzi34hdzSqvvh1WwYfQVjsg6P+LHY4u+AT/XsyTjmaqQYyqyuzcfA+lonnt1lSrh
         /MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692336; x=1762297136;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip0GSPcOf73baSNEbw06pVGhZdDHrjVOI7is0zaeU+I=;
        b=PgRXkhMP+93Kegw//l18JDiDPXFdfR1o9Y0Jfqlh5Olfmg1SqxFy17rewyjbtqiDCv
         AQPLVidsnFnxgS5+pen04dIW2o7ZG3IRUEf/PtSvJhZZyzGeh9IipO/s6OAiaHe2CZRQ
         UXfgAcL+klkSPobonuq98PHISBNju1dahNzswVtwxSEX8PgS3FRK9yDmqbrEV5rFEDxt
         D5Al57cAeVmbdIRN4V0hrXVW1Pmk5uBsTp21Z7owVE9z/olvRTE77yGWlMVUgQYIVgLa
         dSK1f4fUPj/qPS/dveFx59A4bn2JOOv6G7/npzM0kNsXhQhYJptSIv0hZQCxctXRbG9E
         45EA==
X-Forwarded-Encrypted: i=1; AJvYcCV0fN/oTsTLlWXOesbtnUxDEOJgDUjSdg+fMKI7TzL/MDK1QCyvEskuvjRxCHX55s4IiHXKbWQa53TUo68h8jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpX/+S9OQtx2WIeybylLhBbhN2/+dJlKjJJAeLj4bwGNq1auR
	q/K7iOcmnA+egginp+vhyMTXnZBaFFHpu2IlSuazSqQMEoLJyWfBjgCQ5ncM388FXMAuzngrDVe
	9sC6rt3TqFGgQUw==
X-Google-Smtp-Source: AGHT+IEocRZ/8v9VtAgKKGORzHoS2iGayjZS+sqTWSEnk3iM6JDQKTWbdjJDm+53lGtYfikxVTGa+6PFwz1akg==
X-Received: from pjtf19.prod.google.com ([2002:a17:90a:c293:b0:33b:da89:9788])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d4c:b0:340:29cf:221f with SMTP id 98e67ed59e1d1-3403a2a3952mr713832a91.33.1761692336600;
 Tue, 28 Oct 2025 15:58:56 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:30:41 -0700
In-Reply-To: <20251028225827.2269128-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028225827.2269128-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028225827.2269128-4-jmattson@google.com>
Subject: [PATCH v2 3/4] KVM: selftests: Change VM_MODE_PXXV48_4K to VM_MODE_PXXVYY_4K
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Jim Mattson <jmattson@google.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Use 57-bit addresses with 5-level paging on hardware that supports
LA57. Continue to use 48-bit addresses with 4-level paging on hardware
that doesn't support LA57.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  4 +--
 .../selftests/kvm/include/x86/processor.h     |  2 +-
 .../selftests/kvm/lib/arm64/processor.c       |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 30 ++++++++++---------
 .../testing/selftests/kvm/lib/x86/processor.c | 30 +++++++++++--------
 tools/testing/selftests/kvm/lib/x86/vmx.c     |  6 ++--
 6 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index d3f3e455c031..8a54a1279d44 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -177,7 +177,7 @@ enum vm_guest_mode {
 	VM_MODE_P40V48_4K,
 	VM_MODE_P40V48_16K,
 	VM_MODE_P40V48_64K,
-	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
+	VM_MODE_PXXVYY_4K,	/* For 48-bit or 57-bit VA, depending on host support */
 	VM_MODE_P47V64_4K,
 	VM_MODE_P44V64_4K,
 	VM_MODE_P36V48_4K,
@@ -219,7 +219,7 @@ extern enum vm_guest_mode vm_mode_default;
 
 #elif defined(__x86_64__)
 
-#define VM_MODE_DEFAULT			VM_MODE_PXXV48_4K
+#define VM_MODE_DEFAULT			VM_MODE_PXXVYY_4K
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 8)
 
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 51cd84b9ca66..57d62a425109 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1441,7 +1441,7 @@ enum pg_level {
 	PG_LEVEL_2M,
 	PG_LEVEL_1G,
 	PG_LEVEL_512G,
-	PG_LEVEL_NUM
+	PG_LEVEL_256T
 };
 
 #define PG_LEVEL_SHIFT(_level) ((_level - 1) * 9 + 12)
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 54f6d17c78f7..d46e4b13b92c 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -324,7 +324,7 @@ void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init)
 
 	/* Configure base granule size */
 	switch (vm->mode) {
-	case VM_MODE_PXXV48_4K:
+	case VM_MODE_PXXVYY_4K:
 		TEST_FAIL("AArch64 does not support 4K sized pages "
 			  "with ANY-bit physical address ranges");
 	case VM_MODE_P52V48_64K:
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1a93d6361671..364efd02ad4a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -201,7 +201,7 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
 		[VM_MODE_P40V48_16K]	= "PA-bits:40,  VA-bits:48, 16K pages",
 		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
-		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
+		[VM_MODE_PXXVYY_4K]	= "PA-bits:ANY, VA-bits:48 or 57, 4K pages",
 		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
 		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
 		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
@@ -228,7 +228,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P40V48_4K]	= { 40, 48,  0x1000, 12 },
 	[VM_MODE_P40V48_16K]	= { 40, 48,  0x4000, 14 },
 	[VM_MODE_P40V48_64K]	= { 40, 48, 0x10000, 16 },
-	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
+	[VM_MODE_PXXVYY_4K]	= {  0,  0,  0x1000, 12 },
 	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
 	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
 	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
@@ -310,24 +310,26 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	case VM_MODE_P36V47_16K:
 		vm->pgtable_levels = 3;
 		break;
-	case VM_MODE_PXXV48_4K:
+	case VM_MODE_PXXVYY_4K:
 #ifdef __x86_64__
 		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
 		kvm_init_vm_address_properties(vm);
-		/*
-		 * Ignore KVM support for 5-level paging (vm->va_bits == 57),
-		 * it doesn't take effect unless a CR4.LA57 is set, which it
-		 * isn't for this mode (48-bit virtual address space).
-		 */
-		TEST_ASSERT(vm->va_bits == 48 || vm->va_bits == 57,
-			    "Linear address width (%d bits) not supported",
-			    vm->va_bits);
+
 		pr_debug("Guest physical address width detected: %d\n",
 			 vm->pa_bits);
-		vm->pgtable_levels = 4;
-		vm->va_bits = 48;
+		pr_debug("Guest virtual address width detected: %d\n",
+			 vm->va_bits);
+
+		if (vm->va_bits == 57) {
+			vm->pgtable_levels = 5;
+		} else {
+			TEST_ASSERT(vm->va_bits == 48,
+				    "Unexpected guest virtual address width: %d",
+				    vm->va_bits);
+			vm->pgtable_levels = 4;
+		}
 #else
-		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
+		TEST_FAIL("VM_MODE_PXXVYY_4K not supported on non-x86 platforms");
 #endif
 		break;
 	case VM_MODE_P47V64_4K:
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 720c678187b5..40bd69b265ef 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -158,10 +158,10 @@ bool kvm_is_tdp_enabled(void)
 
 void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
-	/* If needed, create page map l4 table. */
+	/* If needed, create the top-level page table. */
 	if (!vm->pgd_created) {
 		vm->pgd = vm_alloc_page_table(vm);
 		vm->pgd_created = true;
@@ -221,8 +221,8 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 	uint64_t *pte = &vm->pgd;
 	int current_level;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K,
-		    "Unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((vaddr % pg_size) == 0,
 		    "Virtual address not aligned,\n"
@@ -307,27 +307,28 @@ static bool vm_is_target_pte(uint64_t *pte, int *level, int current_level)
 uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 				    int *level)
 {
+	int va_width = 12 + (vm->pgtable_levels) * 9;
 	uint64_t *pte = &vm->pgd;
 	int current_level;
 
 	TEST_ASSERT(!vm->arch.is_pt_protected,
 		    "Walking page tables of protected guests is impossible");
 
-	TEST_ASSERT(*level >= PG_LEVEL_NONE && *level < PG_LEVEL_NUM,
+	TEST_ASSERT(*level >= PG_LEVEL_NONE && *level <= vm->pgtable_levels,
 		    "Invalid PG_LEVEL_* '%d'", *level);
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
 		(vaddr >> vm->page_shift)),
 		"Invalid virtual address, vaddr: 0x%lx",
 		vaddr);
 	/*
-	 * Based on the mode check above there are 48 bits in the vaddr, so
-	 * shift 16 to sign extend the last bit (bit-47),
+	 * Check that the vaddr is a sign-extended va_width value.
 	 */
-	TEST_ASSERT(vaddr == (((int64_t)vaddr << 16) >> 16),
-		"Canonical check failed.  The virtual address is invalid.");
+	TEST_ASSERT(vaddr ==
+		    (((int64_t)vaddr << (64 - va_width) >> (64 - va_width))),
+		    "Canonical check failed.  The virtual address is invalid.");
 
 	for (current_level = vm->pgtable_levels;
 	     current_level > PG_LEVEL_4K;
@@ -520,7 +521,8 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
 
-	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	/* Set mode specific system register values. */
 	vcpu_sregs_get(vcpu, &sregs);
@@ -534,6 +536,8 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
 	if (kvm_cpu_has(X86_FEATURE_XSAVE))
 		sregs.cr4 |= X86_CR4_OSXSAVE;
+	if (vm->pgtable_levels == 5)
+		sregs.cr4 |= X86_CR4_LA57;
 	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
 
 	kvm_seg_set_unusable(&sregs.ldt);
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index d4d1208dd023..3bb529e8720f 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -401,11 +401,11 @@ void __nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	struct eptPageTableEntry *pt = vmx->eptp_hva, *pte;
 	uint16_t index;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		    "unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((nested_paddr >> 48) == 0,
-		    "Nested physical address 0x%lx requires 5-level paging",
+		    "Nested physical address 0x%lx is > 48-bits and requires 5-level EPT",
 		    nested_paddr);
 	TEST_ASSERT((nested_paddr % page_size) == 0,
 		    "Nested physical address not on page boundary,\n"
-- 
2.51.1.851.g4ebd6896fd-goog


