Return-Path: <linux-kselftest+bounces-34931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C585AD950E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60391E3456
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336AA248897;
	Fri, 13 Jun 2025 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHlTAdJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911A242D64
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842058; cv=none; b=qgXYTtDGcpqRBBTjVgEA56+AMUQxpazYk9GWnYfxWOgGQJumvpn9Cn3foakQHuRYiv/N7rGL2wGJp8vc4IOkUuvxOnD/c0+GZ0zQnxOs8t2OF+Xn4RnK1Wkxa9oPQXmoobx+tUEJUW3ZhtFnpTKkacaMvv0UBrVyQVAYn0bwOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842058; c=relaxed/simple;
	bh=y/hrB1WH2W68tURtle+cVWCtRB2T0n9nfcp8qRvBYpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YpA0hJDnDSSan3IunJ5/+J2Cf4ff6WA2p/ICqDEEzU4h+UqKMRdEmrQyZjW0VpHfxc2ayMdrigcdxEpKijOrurj/E3n4xVjuLLoBhJJ6dNWx609Jke4TnYDo+3ghTjLKW/1/krkMNobcei53D0yiOF2Es+xEh1w2h3gpnwvsm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHlTAdJW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so1582647a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842056; x=1750446856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOmgMRXV+mc8xC1osg2zhcuISDjyHCoSZSrFaYvlLLs=;
        b=xHlTAdJWVPSS5wdYQH8WRX9r6pHX74riahODGrI7rNJB93QNzLn0UJ+4grsHejCos5
         eEtTjCqxrPL5SZAB35Y3qO6gS88IhOudQPaqLg2KJ4HsWoAK0Z2/B7h/hTp2k5Y2jhpE
         x5BCS6yqC5wD2Mp0tJGZO7brsS19eTrzbKJ/qZUdz/0JpeAF6n4H9CvTxtxt2YFWlbPl
         O6ofIQih0Qs8bdnA8y2TxOLNZ+kaxpP5TGSd+h6bu4tr3/kJ1Ph3sGtJuDLwjV+LqYGW
         3nFq7OZ22rovxFWJbmMfwBSxiFQI2605vV/5XTn9VRJ5xzGs7E4riLvFSWuc254rgkVh
         YPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842056; x=1750446856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOmgMRXV+mc8xC1osg2zhcuISDjyHCoSZSrFaYvlLLs=;
        b=qyJ5NjV/sP3MSCpA0KT8CZ8nvaIZeblal27kk781NqfimiPB1qXi9e8+UAQko1++Pv
         +Ro8mY6sOScxUpsaBmFcc4z/K1nagiZWoiGojmLXPFu1L3MxMp0Rt3lTlS3LSSv50NzO
         tpmQKUFQgDtlFDUbY4HsslzBzajjtcsto3kYYnaC/ngXB2NuVTa1Dl6L1DkJqPyXxLgG
         BolF71f9Du0hKJU3X66t96JCu5QagMpNBUlB5UEb6MJWVBH/gno0Bo6LrFC7aWiCvrrM
         toUkatwZMB6gQZAZQzsOyOvB2RFgm0ybPQLqQZQ361Hv8V/avLKJZ45H7y7K5PbKdNLg
         UUiA==
X-Gm-Message-State: AOJu0Yx9DruArZPFbsM7q+n/uCoMhO3AAfMpbSSlAadwLd/oVWzZA4kd
	DhyePiqtpNh1M65BAbtz6zCZsWlHtklk5bjywkKlO/7+5JkvXsjYcYBBC265VDg4OtKCFgPI0kI
	cN0uqnmcFLpTrJLz1kO3m33pIBekkkR1fbdYtjlyndb68E8vk4OzG9sJD0cZfJL7OFm6Z6rvY5i
	9a34W6zbECgXjviiofyAXJeVv/z9Iga2XAckkZJJ4OYVc=
X-Google-Smtp-Source: AGHT+IHAhgpmm/q01FxLsxN/r16xAnrj+YeQUD4vxuoiPdSbJLlzwjizxPtfCy3TN+V0J86WsXFecaW5gg==
X-Received: from pjbqa3.prod.google.com ([2002:a17:90b:4fc3:b0:308:6685:55e6])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d43:b0:313:d6d9:8891
 with SMTP id 98e67ed59e1d1-313f1be1d48mr1058480a91.3.1749842055693; Fri, 13
 Jun 2025 12:14:15 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:29 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-3-sagis@google.com>
Subject: [PATCH v7 02/30] KVM: selftests: Expose function that sets up sregs
 based on VM's mode
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

This allows initializing sregs without setting vCPU registers in
KVM.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index b11b5a53ebd5..f2eb764cbd7c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1025,6 +1025,7 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 }
 
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
 
 static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a92dc1dad085..002303e2a572 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -488,34 +488,37 @@ static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
 	segp->present = 1;
 }
 
-static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
 {
-	struct kvm_sregs sregs;
-
 	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
 
-	/* Set mode specific system register values. */
-	vcpu_sregs_get(vcpu, &sregs);
-
-	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
-	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
+	sregs->idt.base = vm->arch.idt;
+	sregs->idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs->gdt.base = vm->arch.gdt;
+	sregs->gdt.limit = getpagesize() - 1;
 
-	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
+	sregs->cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+	sregs->cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
 	if (kvm_cpu_has(X86_FEATURE_XSAVE))
-		sregs.cr4 |= X86_CR4_OSXSAVE;
-	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+		sregs->cr4 |= X86_CR4_OSXSAVE;
+	sregs->efer |= (EFER_LME | EFER_LMA | EFER_NX);
+
+	kvm_seg_set_unusable(&sregs->ldt);
+	kvm_seg_set_kernel_code_64bit(&sregs->cs);
+	kvm_seg_set_kernel_data_64bit(&sregs->ds);
+	kvm_seg_set_kernel_data_64bit(&sregs->es);
+	kvm_seg_set_kernel_data_64bit(&sregs->gs);
+	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs->tr);
 
-	kvm_seg_set_unusable(&sregs.ldt);
-	kvm_seg_set_kernel_code_64bit(&sregs.cs);
-	kvm_seg_set_kernel_data_64bit(&sregs.ds);
-	kvm_seg_set_kernel_data_64bit(&sregs.es);
-	kvm_seg_set_kernel_data_64bit(&sregs.gs);
-	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs.tr);
+	sregs->cr3 = vm->pgd;
+}
+
+static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_sregs sregs;
 
-	sregs.cr3 = vm->pgd;
+	vcpu_sregs_get(vcpu, &sregs);
+	vcpu_setup_mode_sregs(vm, &sregs);
 	vcpu_sregs_set(vcpu, &sregs);
 }
 
-- 
2.50.0.rc2.692.g299adb8693-goog


