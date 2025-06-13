Return-Path: <linux-kselftest+bounces-34932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90960AD9511
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020F93AE980
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8F23F429;
	Fri, 13 Jun 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWzCelGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102C23ED5B
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842059; cv=none; b=UNpn9fxMmnMbt94M7cxIc4sddZbJArlFUsoAt5m8KX3g1eTdOd7AzyhEV1sASwQ7W9Yf6p1Kwuxb9Jj12DISO4vGYNvDsyWvAqSJmXQGSVpabFVHZGEJE1qju9tjTk+dvBVs8SieBhp6e+Bc1yoMS/3UcSOYpUHwRkGqL2tL47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842059; c=relaxed/simple;
	bh=CZWxcHUWIhBEiyWiB8Z0zKn1NDMKTAMio7jW/0D0t28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtpYFXUc2wVfGXN9APGZciOvDmbXIVL1j0ZbYVTBrC198Dci1FJsX0GFNHLAiGi6pPFMhTX8JFW/VvsepGxjDKf+M275Hu2fuYViKBESsV/kjD9KlxVownX9E+tmA+nrjInZR8cHwZdzBTkCF6j3NltLaB/PeBBgfZwUd/+Go94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xWzCelGk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso2697127a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842057; x=1750446857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGEpLUgqYonvIFbVng+CrES4z2xij5mJ0NWE1vzcGwk=;
        b=xWzCelGkIZ7DRH6ns82atV8v2tof31E8Eun95Ns7Z58js8RBx1UmOwMI6Xd5LANNjH
         8XuZJwcdrGRMRBvvonc6Dbjn02EGZcgDShh4M6pmSeHaNDcDa8UKeplFzTt+js7pFlP9
         ZYazBoXiOcDvmNUVhEsKInSj/2EjksOD8bPZmFDQWqY+osTNYOhQC1Yk6I/8c/Pf1Oi3
         KS1ndoObwWcKA1FULqJzZ1BCjftrbn/FunB0xlhbua6f8lvK8MXpDY/H+6zwnlWOwP91
         sHfy1oi2wVtmIgDBV+VGrdLGC45KIZuj1bpma1fZM0WiqahXbEz1qAzIIdWYPXdU7Pl2
         Bm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842057; x=1750446857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGEpLUgqYonvIFbVng+CrES4z2xij5mJ0NWE1vzcGwk=;
        b=oN0mstwJv8HLMRkTLwd2r/VICCH5SD5HAaisjG3aIVgwjymsWZ0HzdKwuXYwbQEoH7
         A2DIkXhGImpFrekky939r4lTpK9pkPdeKseWG54GiDG55isXvOMBPjzGdUeyJ121q5R+
         3yTmeFWNmDqx7Gre9ufI1vrgRhBbuzAjbF+VxlT4mJjBKNz4LVLvXU4cJfSgLiQf1G6/
         1HDgoKhS+dXdoZxOcWJ24ZLcDG8dRPSdrtfB9FCroToK9CEHFr/Cx6KJSSwbh7rZfaFV
         EXDL5912T133LgM8TeeFBiHLPBUk+5Z8BbPDiVxtd1a4dN1z4NySzU0CZwakw8b+8xhK
         rSEA==
X-Gm-Message-State: AOJu0Yw7iG89ezjQCuwUbY81kUiHFQcagfdM0ioCCTHJSjn2LhmqgmYg
	rQKzfyQDTBPNfom4+v0wz7Uj8YGyd2d7jNQ60IHTi7zH2908mDnhLV0I9qZ2bTzZWtDCYsN5vIj
	d6eko/rDvdMPFx4JNIHgkSRyRy+MpvjCeaoibnhY+KuF83cy4TRhfOW0G0S7p+6jfmzgrvHux09
	q7/yBLd/kQRzvrQa/VqMP10ZdNt3VGPkdj7Xf86L/am9c=
X-Google-Smtp-Source: AGHT+IGT7zb30UgV45DG78+lDcZgeztvaDSS1mxGV5acscZ5LWb0SsPW7nfVbgggzN4Y8RwiM+4/xNFPgg==
X-Received: from pjgg14.prod.google.com ([2002:a17:90b:57ce:b0:2fc:2c9c:880])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5284:b0:313:db0b:75e4
 with SMTP id 98e67ed59e1d1-313f1d2a17emr1364010a91.33.1749842057235; Fri, 13
 Jun 2025 12:14:17 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:30 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-4-sagis@google.com>
Subject: [PATCH v7 03/30] KVM: selftests: Store initial stack address in
 struct kvm_vcpu
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

TDX guests' registers cannot be initialized directly using
vcpu_regs_set(), hence the stack pointer needs to be initialized by
the guest itself, running boot code beginning at the reset vector.

Store the stack address as part of struct kvm_vcpu so that it can
be accessible later to be passed to the boot code for rsp
initialization.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h  | 1 +
 tools/testing/selftests/kvm/lib/x86/processor.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 9994861d2acb..5c4ca25803ac 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -58,6 +58,7 @@ struct kvm_vcpu {
 	int fd;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
+	vm_vaddr_t initial_stack_addr;
 #ifdef __x86_64__
 	struct kvm_cpuid2 *cpuid;
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 002303e2a572..da6e9315ebe2 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -694,6 +694,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	vcpu_init_sregs(vm, vcpu);
 	vcpu_init_xcrs(vm, vcpu);
 
+	vcpu->initial_stack_addr = stack_vaddr;
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-- 
2.50.0.rc2.692.g299adb8693-goog


