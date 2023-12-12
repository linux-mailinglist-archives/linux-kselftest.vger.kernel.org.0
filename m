Return-Path: <linux-kselftest+bounces-1725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D480F818
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06E51F214D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86846415A;
	Tue, 12 Dec 2023 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6iIYI84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79181CA
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5df9f98994bso22941817b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414021; x=1703018821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIyNCwZuG05oGqfsGJdjuxWZ9bJhVxMnAF0jWTMuK/Y=;
        b=s6iIYI84SnTkiUokmIAErHmVvzwNUtLYpwfRJAQow7T+J6rtYc1RURHMRWzx9wIR/p
         soCLqbIVqHyhen4U98VvDl7XMpmy5UdCN1gJE1yYS7uCSXLZOiuW99WB4w0PJ2Rkm0gz
         8cA+Eudl30rUumS/5oRkTVTOz7aidNvVoAfOeRWy877C4L0HdCq5vmFF1R2O4FtLX6rO
         /zPxbr1oU85fTeSQyWesaN+TYGRUaVLe2rnDqfx3mFW7FrEq5s8hmFL4DTVy5VzoebJF
         JNsZV21lOXsD8FQgq6CDfQtM9xgaX9yYSeu2Ytfq6k0WFVrJBJsDbcjwMP/aeHTUUk4g
         NK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414021; x=1703018821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIyNCwZuG05oGqfsGJdjuxWZ9bJhVxMnAF0jWTMuK/Y=;
        b=Qu9QOH+/QToN1MS6KHtVgecOnPf0NVQJWLCTCG3lDF9oHXqaJ1w4bE1JTgrxGR76CN
         eBxmU+2uIRGmPub3aMxmwRAtOlpWyguAsNF1aiPRUjhI4XTCePWmHYO06+urrbnbrrtB
         OEq1FZI/xxAY/RHQ4KMgjBXKnE8jOkZgCVOgWMlq/w4pbHbAZ9UjHIfbKxY+d6DIv0Tc
         sSCjnpb2PhC1AuSVTXY6ZZLmkJkKABW3c/zrueinKi+QNktXAe0t+7Il6Jh1+LdFDz7v
         T9v+EtlOJ5U4G7E32qg5WBjxKE0JdTBEo30TxVKOiDK6Tw7oZKLlH8v6pho/K3AcJID4
         yQMQ==
X-Gm-Message-State: AOJu0Yypd8yLlpqROLg5sLXkT1t6zF/Kzm+7saUw0MedqPN54/hmhXfs
	GirElZu2xwWoG6/yTfjszmn3sOjrl9axvwgtF4/2z/vRg2mEHVYOxsSqMI1ds6b5HwfcztAeuOL
	frCoCX7TS7zzzE9ilf8TY1DZfzBsTHZyUlQmQBtalcS5qywTaIfOM4gQmUNxsm+7AxoZAc8I=
X-Google-Smtp-Source: AGHT+IHEJxnUHSPsv9KIXDu3heSKIoacV+x0M8UFkzddC1cs8FogPFrD0AfIFp+QKPSNxV4NPrVCkUJUTA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:690c:2e8a:b0:5d8:ef49:748 with SMTP id
 eu10-20020a05690c2e8a00b005d8ef490748mr107655ywb.5.1702414021164; Tue, 12 Dec
 2023 12:47:01 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:17 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-3-sagis@google.com>
Subject: [RFC PATCH v5 02/29] KVM: selftests: Expose function that sets up
 sregs based on VM's mode
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

This allows initializing sregs without setting vCPU registers in
KVM.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  2 +
 .../selftests/kvm/lib/x86_64/processor.c      | 39 ++++++++++---------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 35fcf4d78dfa..0b8855d68744 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -958,6 +958,8 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
 void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
 
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
+
 static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
 							      uint32_t function,
 							      uint32_t index)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index aef1c021c4bb..f130f78a4974 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -543,36 +543,39 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 	kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
-static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
 {
-	struct kvm_sregs sregs;
-
-	/* Set mode specific system register values. */
-	vcpu_sregs_get(vcpu, &sregs);
-
-	sregs.idt.limit = 0;
+	sregs->idt.limit = 0;
 
-	kvm_setup_gdt(vm, &sregs.gdt);
+	kvm_setup_gdt(vm, &sregs->gdt);
 
 	switch (vm->mode) {
 	case VM_MODE_PXXV48_4K_SEV:
 	case VM_MODE_PXXV48_4K:
-		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-		sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
-
-		kvm_seg_set_unusable(&sregs.ldt);
-		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
-		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
-		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
-		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
+		sregs->cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+		sregs->cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
+		sregs->efer |= (EFER_LME | EFER_LMA | EFER_NX);
+
+		kvm_seg_set_unusable(&sregs->ldt);
+		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs->cs);
+		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs->ds);
+		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs->es);
+		kvm_setup_tss_64bit(vm, &sregs->tr, 0x18);
 		break;
 
 	default:
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
-	sregs.cr3 = vm->pgd;
+	sregs->cr3 = vm->pgd;
+}
+
+static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	vcpu_setup_mode_sregs(vm, &sregs);
 	vcpu_sregs_set(vcpu, &sregs);
 }
 
-- 
2.43.0.472.g3155946c3a-goog


