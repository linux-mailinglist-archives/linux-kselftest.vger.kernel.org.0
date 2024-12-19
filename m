Return-Path: <linux-kselftest+bounces-23624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68B9F878E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 23:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BCD1646F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F74D1D8DF6;
	Thu, 19 Dec 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLrRiCr8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4181D3582
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646248; cv=none; b=nSj7IBDxOtqTTgIhbqLkvLFTC2KF6LA210ZPq6JSFISMFIGxr1ZqqbUuY7mb/nISBn1Di/huXsMOoaZbx+0eRFdQnGiISZdV0adgMJ0ITvYqywwKr1z4OW79D/tdqzLM5YC7TMOoe+oMeaYJWo6438tEuJ1MGg7C+MfMz7RxBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646248; c=relaxed/simple;
	bh=dx9Kn5dR0P+jrZO0loU0EjWR7kEKZD92qi2+boNDsTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUbGTr7EszfEIJz7rIPf329DVCP/6jEZNGEVpkKgA1ttuWARJyiziAU2m5358F8ceTGHn5lhwsYZT6dbJfkA42yten0LuZJXMdI399P9wQ6SD2n1vCYA83uSsRVRZOpQneBicTl6ULYeaTVypkTYl1pdt1dOoJhb2hbZedcno0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLrRiCr8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734646246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jE4qKYHCQP5jiikBn8xoHuxOcqZyN66g2/G/5w6lsq8=;
	b=fLrRiCr8viiM+TQREZ2Wz/MMk3aQWV+jyAMQf6p84AlHd2OZ6a0bIwqwvKE5kRdp1up7c3
	DRwv4wbI8ywxKlX8EQivfTEl7gSCMoyTX1i9CKhXxh1ivEdragZ8oJsW14nsUF1bx/QkZX
	P6HfWfGmedo7rE7RHo9jylI+MfpWinI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-g-KI7falMH-d3GhysvJliA-1; Thu,
 19 Dec 2024 17:10:41 -0500
X-MC-Unique: g-KI7falMH-d3GhysvJliA-1
X-Mimecast-MFC-AGG-ID: g-KI7falMH-d3GhysvJliA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0C171956046;
	Thu, 19 Dec 2024 22:10:39 +0000 (UTC)
Received: from starship.lan (unknown [10.22.65.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73CF219560A2;
	Thu, 19 Dec 2024 22:10:37 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-kselftest@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 1/2] KVM: VMX: refactor PML terminology
Date: Thu, 19 Dec 2024 17:10:33 -0500
Message-Id: <20241219221034.903927-2-mlevitsk@redhat.com>
In-Reply-To: <20241219221034.903927-1-mlevitsk@redhat.com>
References: <20241219221034.903927-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Rename PML_ENTITY_NUM to PML_LOG_NR_ENTRIES
Add PML_HEAD_INDEX to specify the first entry that CPU writes.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/main.c   |  2 +-
 arch/x86/kvm/vmx/nested.c |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 10 +++++-----
 arch/x86/kvm/vmx/vmx.h    |  5 ++++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 92d35cc6cd15..0c0ea786a947 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -126,7 +126,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.check_intercept = vmx_check_intercept,
 	.handle_exit_irqoff = vmx_handle_exit_irqoff,
 
-	.cpu_dirty_log_size = PML_ENTITY_NUM,
+	.cpu_dirty_log_size = PML_LOG_NR_ENTRIES,
 	.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
 
 	.nested_ops = &vmx_nested_ops,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index aa78b6f38dfe..71e0d887ff9c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3442,7 +3442,7 @@ static int nested_vmx_write_pml_buffer(struct kvm_vcpu *vcpu, gpa_t gpa)
 	if (!nested_cpu_has_pml(vmcs12))
 		return 0;
 
-	if (vmcs12->guest_pml_index >= PML_ENTITY_NUM) {
+	if (vmcs12->guest_pml_index >= PML_LOG_NR_ENTRIES) {
 		vmx->nested.pml_full = true;
 		return 1;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0f008f5ef6f0..30fc54eefeb4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4828,7 +4828,7 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 
 	if (enable_pml) {
 		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
-		vmcs_write16(GUEST_PML_INDEX, PML_ENTITY_NUM - 1);
+		vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 	}
 
 	vmx_write_encls_bitmap(&vmx->vcpu, NULL);
@@ -6216,17 +6216,17 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 	pml_idx = vmcs_read16(GUEST_PML_INDEX);
 
 	/* Do nothing if PML buffer is empty */
-	if (pml_idx == (PML_ENTITY_NUM - 1))
+	if (pml_idx == PML_HEAD_INDEX)
 		return;
 
 	/* PML index always points to next available PML buffer entity */
-	if (pml_idx >= PML_ENTITY_NUM)
+	if (pml_idx >= PML_LOG_NR_ENTRIES)
 		pml_idx = 0;
 	else
 		pml_idx++;
 
 	pml_buf = page_address(vmx->pml_pg);
-	for (; pml_idx < PML_ENTITY_NUM; pml_idx++) {
+	for (; pml_idx < PML_LOG_NR_ENTRIES; pml_idx++) {
 		u64 gpa;
 
 		gpa = pml_buf[pml_idx];
@@ -6235,7 +6235,7 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 	}
 
 	/* reset PML index */
-	vmcs_write16(GUEST_PML_INDEX, PML_ENTITY_NUM - 1);
+	vmcs_write16(GUEST_PML_INDEX, PML_HEAD_INDEX);
 }
 
 static void vmx_dump_sel(char *name, uint32_t sel)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 43f573f6ca46..83ca5c574704 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -330,7 +330,10 @@ struct vcpu_vmx {
 	bool ple_window_dirty;
 
 	/* Support for PML */
-#define PML_ENTITY_NUM		512
+#define PML_LOG_NR_ENTRIES	512
+	/* PML is written backwards: this is the first entry written by the CPU */
+#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES-1)
+
 	struct page *pml_pg;
 
 	/* apic deadline value in host tsc */
-- 
2.26.3


