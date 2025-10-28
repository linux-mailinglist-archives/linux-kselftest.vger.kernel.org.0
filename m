Return-Path: <linux-kselftest+bounces-44243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9EBC17408
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 23:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FF83B6C78
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E936B96D;
	Tue, 28 Oct 2025 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi4jsgAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCC36A607
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692337; cv=none; b=U6wYEBd0n5n0IwUcwJa6RW1ILVNeEgCiW6uzQbhRsxaZqgmKQz6PnD6GKIiq3ocvwrEa1Nh6kgDLOp7Urpe9R777vTk3zdesl0NAXCGr5VCGE+zoaYFmHwbLxALm6ui028KuPuFrp8xhUaqmASR4xiN/IASfVt/jp3zn5c+ZV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692337; c=relaxed/simple;
	bh=9LfQM2hIUlxZZG/asJrlAoGIB42sfh2arlqfx9NqS1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PnyNuuo/R+bCeEVYZkED02lezms7zjKrXZ6UFhWXewbbEq6QjOzhgDh7HnabP/3tPPofFMbzcDZtbeMxpHPEdMBSi8oF/jq46e3vvm9IOPhL7TILqPCEzoP3ne3BlR3jWq282ofLsP7ThQFRP96q2UVPyZEqyGgK+BChYPaQwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi4jsgAl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27ee41e062cso73407785ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761692335; x=1762297135; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsN+TIOejwkRxcFvSTLIziuR7qVC+NSwlbaa713vCGw=;
        b=Gi4jsgAl6gOVkt9ckb0Tpv47WFDv0jLavDbPetB/+v0sG2bhtZFpe1WI/M/WmmW7WC
         f4FkKhiBdhUn8zbSXlC93pS4hQ7lXg9ZlD8WDP0eYY+MdbRo0JOgQ/2tScHAoSI6l7ZE
         2xnINzE+JpAH/oE/l7qUPuzmiZe3ptERHe0wMmqmrdzgaAupueUu41kMx6GtppEJUjiH
         krNp4eynWEijmX+elrszyXel+KEOia8AEdNI+qzfgKL856cnobtRrgjtLRuXz/GJtt6u
         HEIfhyQNl6bkEtTxPGxFUgR2tVGFYh2eKZiJuTbnepwV5BWr5Y61B/v+OicPGDjVt9T9
         fCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692335; x=1762297135;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsN+TIOejwkRxcFvSTLIziuR7qVC+NSwlbaa713vCGw=;
        b=oj7gPE0oEFkrtXkKB6CURxKvJafk1MObuttQS77ATaD8DZ4di9eB8ieJQRv4DQ8MJ6
         k0516SuwekpQ4mrCrCzPQE+tZOx89QU7MnZr+R0E+5KjeuJR0yQw+aL6u5PKjljGStTC
         Km3jk58VPAia7AilIsrTn9MYDRsVJP+rFyZiTdtHeTs0z7YFTCfkFDyo8wvXFRoqrkko
         N9gH23fmMo1ZY4R+b69JnaX2B/MRQSVzyBHReonu3rPFm6D69CNFG5CWXUtwsTIm7b3N
         ++mTppiRq1GHzZfdAmMGK7NDzkXgrqrgTy7qgtIE93rYzTcTyTaXZNXAhViUx+LaXXhZ
         pAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0nuFsCEgbkcb60qREtA8OChJRgsgRsphEG6abok1C1OjkCTx9/91vnKrZdVNzc0oQGqa6laQL8M387i1csQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxfl0oPefpzPTO1Wjc1roCf/K/1Ch0SC3p79TmO2yPhANO1Kok
	JWWjNSai4GvfhU+6xnYVf3Ew98wt3qunpJMqRCuceV4kT9WU+FlJ0OKDZrcR8wwi3cojW/kfBAu
	uYDydHl4XngSZfg==
X-Google-Smtp-Source: AGHT+IEMVSuG9lR7nieExZvnnc5AQBFrpxM2bdWmWvBi3SSEzKa00dcCH/wBtXjIXiNue0RQB/h1x65fEm/mgQ==
X-Received: from pjvv11.prod.google.com ([2002:a17:90b:588b:b0:33e:3612:2208])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2a86:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-294def5a88amr8429735ad.51.1761692335281;
 Tue, 28 Oct 2025 15:58:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:30:40 -0700
In-Reply-To: <20251028225827.2269128-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028225827.2269128-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028225827.2269128-3-jmattson@google.com>
Subject: [PATCH v2 2/4] KVM: selftests: Use a loop to walk guest page tables
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

Walk the guest page tables via a loop when searching for a PTE,
instead of using unique variables for each level of the page tables.

This simplifies the code and makes it easier to support 5-level paging
in the future.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 738f2a44083f..720c678187b5 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -307,7 +307,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *level, int current_level)
 uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 				    int *level)
 {
-	uint64_t *pml4e, *pdpe, *pde;
+	uint64_t *pte = &vm->pgd;
+	int current_level;
 
 	TEST_ASSERT(!vm->arch.is_pt_protected,
 		    "Walking page tables of protected guests is impossible");
@@ -328,19 +329,15 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 	TEST_ASSERT(vaddr == (((int64_t)vaddr << 16) >> 16),
 		"Canonical check failed.  The virtual address is invalid.");
 
-	pml4e = virt_get_pte(vm, &vm->pgd, vaddr, PG_LEVEL_512G);
-	if (vm_is_target_pte(pml4e, level, PG_LEVEL_512G))
-		return pml4e;
-
-	pdpe = virt_get_pte(vm, pml4e, vaddr, PG_LEVEL_1G);
-	if (vm_is_target_pte(pdpe, level, PG_LEVEL_1G))
-		return pdpe;
-
-	pde = virt_get_pte(vm, pdpe, vaddr, PG_LEVEL_2M);
-	if (vm_is_target_pte(pde, level, PG_LEVEL_2M))
-		return pde;
+	for (current_level = vm->pgtable_levels;
+	     current_level > PG_LEVEL_4K;
+	     current_level--) {
+		pte = virt_get_pte(vm, pte, vaddr, current_level);
+		if (vm_is_target_pte(pte, level, current_level))
+			return pte;
+	}
 
-	return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
+	return virt_get_pte(vm, pte, vaddr, PG_LEVEL_4K);
 }
 
 uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
-- 
2.51.1.851.g4ebd6896fd-goog


