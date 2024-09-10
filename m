Return-Path: <linux-kselftest+bounces-17616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5B973BE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61967B24F65
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A91A071C;
	Tue, 10 Sep 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="U5ph+NPr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADB196434;
	Tue, 10 Sep 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981996; cv=none; b=h3l/TfqenPhbMvH8k/FhFvTHgoH/7l81Unh+WRFHySjDxRGhGVOh7ZpMHWX4I5cNaIEmyOc1IFgzFMt2wOUiqu0keEYzsIZVrIKribS42/7KELUi1rgUWl1JWVCKQxRDNrr9cAhuXHjGqcZkFgfWVI1dGsOkqzMVMXK85sP0E+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981996; c=relaxed/simple;
	bh=P1+qeKj1jWxQHOBUtyutYQVE5fRKcoSoqDE+RShE8+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRATGVVUksHn3zmuYlNJAJ0WTxst8Ui5DLIVZvCq20F6SXaAaN2vgAYKfC8L37N3c97zI1SXyg3GOCXGFbq6y8rmEkDsD1TTJ9tLVL1Ra2jk+nlLNg6nLSwn6Eld1m8tY2905OXD+wBGUvNxU1hil6jkI1np2wcugT6dm86z8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=U5ph+NPr; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981995; x=1757517995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQ6xRuASXpOta6yp55hPSDQn+GPR+RFHRqTzI9yNfP0=;
  b=U5ph+NPrIc2zYgg1+f1J/W+CGgYoHBawkeA0bqaa5JQ7cjR8PawrgUmx
   otabuRlXV9gvHr68rW10KVKepO9EnhBH+LVjtT7wCn0OVLMUVk/uNZQgz
   UseLUhSxlWrlP2g4xRULo8ye8cf1DtgdxAYMclj62o5j6gYMXNylDDhQN
   A=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="452528207"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:26:27 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:21666]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.168:2525] with esmtp (Farcaster)
 id dd915001-a97f-4234-a16e-6bb0e9589d81; Tue, 10 Sep 2024 15:26:26 +0000 (UTC)
X-Farcaster-Flow-ID: dd915001-a97f-4234-a16e-6bb0e9589d81
Received: from EX19D004EUA004.ant.amazon.com (10.252.50.183) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:26:24 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D004EUA004.ant.amazon.com (10.252.50.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:26:23 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:26:22 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 14/15] KVM: x86: Implement KVM_TRANSLATE2
Date: Tue, 10 Sep 2024 15:22:06 +0000
Message-ID: <20240910152207.38974-15-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement KVM_TRANSLATE2 for x86 using the default KVM page walker.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/x86.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 27fc71aaa1e4..3bcbad958324 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4683,6 +4683,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
+	case KVM_CAP_TRANSLATE2:
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
@@ -12156,6 +12157,81 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/*
+ * Translate a guest virtual address to a guest physical address.
+ */
+int kvm_arch_vcpu_ioctl_translate2(struct kvm_vcpu *vcpu,
+				    struct kvm_translation2 *tr)
+{
+	int idx, set_bit_mode = 0, access = 0;
+	struct x86_exception exception = { };
+	gva_t vaddr = tr->linear_address;
+	u16 status = 0;
+	gpa_t gpa;
+
+	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_ACCESSED)
+		set_bit_mode |= PWALK_SET_ACCESSED;
+	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_DIRTY)
+		set_bit_mode |= PWALK_SET_DIRTY;
+	if (tr->flags & KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED)
+		set_bit_mode |= PWALK_FORCE_SET_ACCESSED;
+
+	if (tr->access & KVM_TRANSLATE_ACCESS_WRITE)
+		access |= PFERR_WRITE_MASK;
+	if (tr->access & KVM_TRANSLATE_ACCESS_USER)
+		access |= PFERR_USER_MASK;
+	if (tr->access & KVM_TRANSLATE_ACCESS_EXEC)
+		access |= PFERR_FETCH_MASK;
+
+	vcpu_load(vcpu);
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	/* Even with PAE virtual addresses are still 32-bit */
+	if (is_64_bit_mode(vcpu) ? is_noncanonical_address(vaddr, vcpu) :
+				   tr->linear_address >> 32) {
+		tr->valid = false;
+		tr->error_code = KVM_TRANSLATE_FAULT_INVALID_GVA;
+		goto exit;
+	}
+
+	gpa = kvm_mmu_gva_to_gpa(vcpu, vaddr, access, set_bit_mode, &exception,
+				 &status);
+
+	tr->physical_address = exception.error_code_valid ? exception.gpa_page_fault : gpa;
+	tr->valid = !exception.error_code_valid;
+
+	/*
+	 * Order is important here:
+	 * - If there are access restrictions those will always be set in the
+	 *   error_code
+	 * - If a PTE GPA is unmapped, the present bit in error_code may not
+	 *   have been set already
+	 */
+	if (exception.flags & KVM_X86_UNMAPPED_PTE_GPA)
+		tr->error_code = KVM_TRANSLATE_FAULT_INVALID_GPA;
+	else if (!(exception.error_code & PFERR_PRESENT_MASK))
+		tr->error_code = KVM_TRANSLATE_FAULT_NOT_PRESENT;
+	else if (exception.error_code & PFERR_RSVD_MASK)
+		tr->error_code = KVM_TRANSLATE_FAULT_RESERVED_BITS;
+	else if (exception.error_code & (PFERR_USER_MASK | PFERR_WRITE_MASK |
+					 PFERR_FETCH_MASK))
+		tr->error_code = KVM_TRANSLATE_FAULT_PRIVILEGE_VIOLATION;
+
+	/*
+	 * exceptions.flags and thus tr->set_bits_succeeded have meaning
+	 * regardless of the success of the page walk.
+	 */
+	tr->set_bits_succeeded = tr->flags &&
+				 !(status & PWALK_STATUS_READ_ONLY_PTE_GPA);
+
+exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	vcpu_put(vcpu);
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
 	struct fxregs_state *fxsave;
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


