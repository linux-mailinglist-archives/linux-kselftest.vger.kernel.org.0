Return-Path: <linux-kselftest+bounces-40746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD9B43318
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 08:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD12B582F38
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8836129E0F6;
	Thu,  4 Sep 2025 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mf6c99XR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67829D277
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968931; cv=none; b=f+xzAtdZ5r1dWzzs5LgjFDTcBfF6eZiKjaKVMo0DrO2z188Ihv8zPhGXuIhNt8V6liWysXPZbE04m4jwf6BXhZcuqCl9GG0gsv8V/UudPFRE4IowRDF5Z+4j/+tgVN7kJUYGqk5G3Pfd3UK9CtN8VZMdWKNDx0Eu6m5nVxLv4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968931; c=relaxed/simple;
	bh=RW05ySQDdsIFpEjdK0DhL1N2wBFwDRbslCaLfnA5S1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ei2//OUTXLz9QJmDe3ssWjRN6xxXhzH0hWeH9fIklZhJv/zZlS8/cB64G1F0s+m9+9X9N1E7GF001Mqt6oT5wElVb8cbut/hKzJKTL18/C+YUYay2ZjxChkWhxnnpQ1L4Jq9cL4H+TU5L2M/P4Tg+nvJtoc/BsO0o9rxY7uerlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mf6c99XR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445806b18aso9214575ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 23:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756968929; x=1757573729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwpwna9XgBpUtgEehRSSyfXaOgUGlQYKXpp1R7Oe4SU=;
        b=mf6c99XR5RZqlnBYe0Pnlp4jqoEnr3fvcgDw2/PEYyXawT4mXjjAQS8VgC6pR6/cBv
         WSNas3V7cDFIpuidq8i+MDXhk43ZH8kIpdHe4tATFXbr6WHbC0PS4X2VGyGw8qLaU4Ns
         sfSWJTw6IeLSM8iCtSze6z650++vVQQ1AHAGQV26qFLg847BtP6OvTJV5R1ehmZ5EE1E
         u6/VOt8tRZDWOFPn3lLfYc98Z/foXTFTyDTX6hlTdYGLoOtUXZ40DkV8rp940RRCgRgu
         6PEPzxCL3KA8HCZPc09MfVXFjh/LBuo2M3hhOpoE/AUWxHYIkZDd2V4/pR0RZ0ub/T2x
         //4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968929; x=1757573729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwpwna9XgBpUtgEehRSSyfXaOgUGlQYKXpp1R7Oe4SU=;
        b=VqnRfZITwn+iU/uQNRBtjAU/jLC2ov4QkmGyKEtwWAyDLCTS8gkvXyNlg9of4SuhlV
         P/PYTFbgdAMvKJhS+9ioCKLUKsGS0HlAjaAWgYdKU3UnVGR9JXC/GDEdjeATvvgsvqiD
         o1jrTwYYhHPRvQBB5GyxSw01Iulqtws+teIMOU+ELBPEroEKPqNfbDYltw4VhMyL+bHV
         50xoMQx2eYaE+Y2pEmg8OlfnMWFOE29BnrBXNOT5vSnKcOM812i6Plcugd55HPMp1jeX
         aWsdafzpG9dGntbpwtlUT8F0GKwOoEzV8oIYdCsVtZM/LLzatGaHqPAO1vzaNPg0f+97
         6tJg==
X-Gm-Message-State: AOJu0YyTA2HU7JT4Y7W3PavmvH7f46V2o9Vk32uWZ7ti+tEZ8B3iD7fn
	V+S6JZpmDmIVleWJDm6HzwDRS45HRi2i0i4eaasfDeZIGbTiUOgUyJ3YGFpdb0E9b3uK6x+hiX2
	m0mSVqx7Q2aSuqLSF7DmgNTqs0K6jTkjBdCx7JRmh5JHyoSokA8KBdL5WWmR1mU+mu4GoywxA39
	00MCSk++Z+83tK2yy5m+PaCqabVEZboMUi1RgR0BfVf38=
X-Google-Smtp-Source: AGHT+IGTvEeHEwVjQcaCZIJtCzHKu5Fk7QZqOq/RQ0i8WE5vhn5/ejm8chAGsKWMY9tCoRWfG5svPLcwPQ==
X-Received: from pjbsx12.prod.google.com ([2002:a17:90b:2ccc:b0:30a:7da4:f075])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db03:b0:249:c66:199e
 with SMTP id d9443c01a7336-24944a177fbmr236741125ad.26.1756968929203; Wed, 03
 Sep 2025 23:55:29 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:54:47 -0700
In-Reply-To: <20250904065453.639610-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904065453.639610-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904065453.639610-18-sagis@google.com>
Subject: [PATCH v10 17/21] KVM: selftests: Set entry point for TDX guest code
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the rip register is inaccessible for TDX VMs, we need a different
way to set the guest entry point for TDX VMs. This is done by writing
the guest code address to a predefined location in the guest memory and
loading it into rip as part of the TDX boot code.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b1e5f4137629..4a831b0f206e 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -654,9 +654,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu, &regs);
-	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vcpu->vm))
+		vm_tdx_set_vcpu_entry_point(vcpu, guest_code);
+	else {
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip = (unsigned long) guest_code;
+		vcpu_regs_set(vcpu, &regs);
+	}
 }
 
 vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
-- 
2.51.0.338.gd7d06c2dae-goog


