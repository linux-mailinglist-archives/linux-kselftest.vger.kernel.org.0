Return-Path: <linux-kselftest+bounces-41784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB4B8206F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72EF1C032D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D030E856;
	Wed, 17 Sep 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3aa4xQg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609929BDBC
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145875; cv=none; b=gEkTRJk9DWmfFPyC9SCdFFA4Df5NN4L8SNrO8NIXZPtfTyLb0HnHSSWo9zH0rr+6v8te/dovHxRdFOLsUraLQ9TML2cuAS2eATLzWIUXXLQoel7Olv4QTE5zZ+Z0r3KrHHhOI9ZD9pME/nJXxFFNG3zwLdJmVjcMu9y3/AVZyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145875; c=relaxed/simple;
	bh=fV7d+iMC4cNbWSys5ekBLpLRqjs3hfSfwJ8ddSNU6KM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sAa/WwT/0fOcaESBR0S4c8lQHhfWhu9vQ6qCRIhpt6a58vhO+16XQYr21eDai46DVRJj0Lyo6o2CiNR+t0knbM2XnZE5546gmcPRjTPCaT0Iz8UA7bE0GlYidxBfSlN6uHDO6gvog6yMa4TM6Vs+2UEZMIF02ClFuscptJZHZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3aa4xQg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e8c800a79so241169a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758145873; x=1758750673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ODBCbD440uYvQ8SizIyBgOxXgM+3hzOx7AmPapgbVc=;
        b=z3aa4xQgQfrkctS0i6sPe9nVXl1EJCSbsu1n8C6siazFdEtDSmc7J3pFYBa225h7tr
         bmhI8ToKIwhLjRxImcc1IvUfC/NYwi/ZIs0zwyN1Hk3cnQ8TjOpGLrr51uLHGCSz3xl3
         n/3xN/4tIbUbwxUcsDi/34Pd4rfIbR/RwYs3nESS9PhPz0AAZRBEnz/PKQgjRe0ET3xi
         rdeDt5XdClwVVn0kT68DN5zyQ5VSLrsyTKrcVX9GdqYLuP4HWa7pgqfAjbkLv8TuSQXW
         Fkz/nI0YcsZU5O59Sae4wnd0rrAEEpdNlxIdcl5KCMq4umVi4uUzFJ8gpooubl0S8RbB
         virg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145873; x=1758750673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ODBCbD440uYvQ8SizIyBgOxXgM+3hzOx7AmPapgbVc=;
        b=fPBwewnq4+B0qZkm8JrBFZN8yE5z0ILhW23uPN3uyy0q+mAc5652t3Uh8s+2EzH5nE
         me1iek+28bgrHlzWtf0AOnrrFcHgD15LW7qVnIDUjt91+RBWRKgP29APOC2/EsXHjcfd
         qm4WT8jTC9XSWC3m96Vz4Rzj+cYZwgQa3hBcmhQ7MKP8PaZzGF2PuDWtcemfInY1zflj
         5m/sqKey71HnkbsUf6i/Jh1uR3Afc5aH/9xu/G9tvbMje2U9J5YpK2dPMp6wWWxM7Eaq
         7hAs+errYfiMpwqPZILMxby9+MUrUgVKgLkl97WB0RxJxUkyc3OEegdOciyFcLaQwLB/
         BUxw==
X-Forwarded-Encrypted: i=1; AJvYcCU+xX4OwnpQjj4Uzxe3INJkBtyt8ODnx+BsfJ9RBu3cCPdo8sHXYmtnfaejCtjxTEQkxTf7Sy9TNMFqHjwZ+x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQ6n9t684KZb/q7NHCwiKP+s+FigPfKMnvQy138EcnpGuSEgn
	zAsAlMwrY/2mgyjKQ4ae4s8p0V7XsmE31nJwLzXbkcCl50L/1vUNOHbibDsNOVQq9FSangb4QP3
	ETuTuSU4QJZAI7w==
X-Google-Smtp-Source: AGHT+IEKqExV4mnY2Fu8atlg1uW5FJCAPBPhVFdmQ/waPYSuPzIUgusN63xwE2wudFUpWp9CX3s3sXd5/AY5zA==
X-Received: from pjbsv12.prod.google.com ([2002:a17:90b:538c:b0:32e:b87b:6c84])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:39cc:b0:329:f535:6e48 with SMTP id 98e67ed59e1d1-32ee3fa2ccemr4100883a91.36.1758145872774;
 Wed, 17 Sep 2025 14:51:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:48:38 -0700
In-Reply-To: <20250917215031.2567566-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250917215031.2567566-3-jmattson@google.com>
Subject: [PATCH 2/4] KVM: selftests: Use a loop to walk guest page tables
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Walk the guest page tables via a loop when searching for a PTE,
instead of using unique variables for each level of the page tables.

This simplifies the code and makes it easier to support 5-level paging
in the future.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 0238e674709d..433365c8196d 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -270,7 +270,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *level, int current_level)
 uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 				    int *level)
 {
-	uint64_t *pml4e, *pdpe, *pde;
+	uint64_t *pte = &vm->pgd;
+	int current_level;
 
 	TEST_ASSERT(!vm->arch.is_pt_protected,
 		    "Walking page tables of protected guests is impossible");
@@ -291,19 +292,13 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
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
+	for (current_level = vm->pgtable_levels; current_level > 0; current_level--) {
+		pte = virt_get_pte(vm, pte, vaddr, current_level);
+		if (vm_is_target_pte(pte, level, current_level))
+			return pte;
+	}
 
-	return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
+	return pte;
 }
 
 uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
-- 
2.51.0.470.ga7dc726c21-goog


