Return-Path: <linux-kselftest+bounces-23193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7BE9ED693
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 20:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2381885156
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5920371B;
	Wed, 11 Dec 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYopwj31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB851C4612
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945837; cv=none; b=f7uFcgZeB3n0u7uiP/sBkfNJE16mLaGG753LBiNjNJ27CnJ5SB+xtb4/k/8OesffyucrCDdkmGQrcyE0JAoWxEc6gtuf+vHZcZazH9YIDQSPVRTIOMpatyh3NZs4sHId+oui8ESz9wCACgfdEUIwY9j6a0nYkETLa8mvoE2DTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945837; c=relaxed/simple;
	bh=gsaF2mp6+IFXG0g59HGoFlRenIZvGwM/zs6wchiu/aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yljj1Y5j03tEq6pnaEAHa1nKzhRQ2sXLPhpTaudyI1wMY0ZgAvb6wgEJ0LnhSC0jb0MXLrf9mttwuNVHe8ixHfB73AkMpJ4rQZdrqmpp83HvQcn6HbfM9kYYIsPTPDcMLdckM5mCyp9WKocUcdd1dT16cXsXgGGvv6eFJPis6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYopwj31; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733945834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCr0ZS2R3dDRLHGaXzPRHv9yEgb4A4mVvp8VJCXI81M=;
	b=SYopwj31A8g/Sd4vXFPiSIF8Wm/meH+pnavXJfbr/rhoewH5Qr/cQ8DNVOmPbNB9epNFyv
	jwxgZYGnmiUzGBkKJrA2l5YYYFJ0Laoy6qHEsWWmMjxD01eBq9DpayzpAuZG1cwOUMIlcM
	BCUu3TVlyhN5WcBx9yaF3L/0+kFZVgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-Q2fhomCGNlaIt0r6kdwOlA-1; Wed,
 11 Dec 2024 14:37:12 -0500
X-MC-Unique: Q2fhomCGNlaIt0r6kdwOlA-1
X-Mimecast-MFC-AGG-ID: Q2fhomCGNlaIt0r6kdwOlA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 452311944B17;
	Wed, 11 Dec 2024 19:37:11 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C43281956048;
	Wed, 11 Dec 2024 19:37:09 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it was written
Date: Wed, 11 Dec 2024 14:37:03 -0500
Message-Id: <20241211193706.469817-2-mlevitsk@redhat.com>
In-Reply-To: <20241211193706.469817-1-mlevitsk@redhat.com>
References: <20241211193706.469817-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

X86 spec specifies that the CPU writes to the PML log 'backwards'
or in other words, it first writes entry 511, then entry 510 and so on,
until it writes entry 0, after which the 'PML log full' VM exit happens.

I also confirmed on the bare metal that the CPU indeed writes the entries
in this order.

KVM on the other hand, reads the entries in the opposite order, from the
last written entry and towards entry 511 and dumps them in this order to
the dirty ring.

Usually this doesn't matter, except for one complex nesting case:

KVM reties the instructions that cause MMU faults.
This might cause an emulated PML log entry to be visible to L1's hypervisor
before the actual memory write was committed.

This happens when the L0 MMU fault is followed directly by the VM exit to
L1, for example due to a pending L1 interrupt or due to the L1's
'PML log full' event.

This problem doesn't have a noticeable real-world impact because this
write retry is not much different from the guest writing to the same page
multiple times, which is also not reflected in the dirty log. The users of
the dirty logging only rely on correct reporting of the clean pages, or
in other words they assume that if a page is clean, then no writes were
committed to it since the moment it was marked clean.

However KVM has a kvm_dirty_log_test selftest, a test that tests both
the clean and the dirty pages vs the memory contents, and can fail if it
detects a dirty page which has an old value at the offset 0 which the test
writes.

To avoid failure, the test has a workaround for this specific problem:

The test skips checking memory that belongs to the last dirty ring entry,
which it has seen, relying on the fact that as long as memory writes are
committed in-order, only the last entry can belong to a not yet committed
memory write.

However, since L1's KVM is reading the PML log in the opposite direction
that L0 wrote it, the last dirty ring entry often will be not the last
entry written by the L0.

To fix this, switch the order in which KVM reads the PML log.

Note that this issue is not present on the bare metal, because on the
bare metal, an update of the A/D bits of a present entry, PML logging and
the actual memory write are all done by the CPU without any hypervisor
intervention and pending interrupt evaluation, thus once a PML log and/or
vCPU kick happens, all memory writes that are in the PML log are
committed to memory.

The only exception to this rule is when the guest hits a not present EPT
entry, in which case KVM first reads (backward) the PML log, dumps it to
the dirty ring, and *then* sets up a SPTE entry with A/D bits set, and logs
this to the dirty ring, thus making the entry be the last one in the
dirty ring.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 32 +++++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.h |  1 +
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0f008f5ef6f0..6fb946b58a75 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6211,31 +6211,41 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 *pml_buf;
-	u16 pml_idx;
+	u16 pml_idx, pml_last_written_entry;
+	int i;
 
 	pml_idx = vmcs_read16(GUEST_PML_INDEX);
 
 	/* Do nothing if PML buffer is empty */
-	if (pml_idx == (PML_ENTITY_NUM - 1))
+	if (pml_idx == PML_LAST_ENTRY)
 		return;
+	/*
+	 * PML index always points to the next available PML buffer entity
+	 * unless PML log has just overflowed, in which case PML index will be
+	 * 0xFFFF.
+	 */
+	pml_last_written_entry = (pml_idx >= PML_ENTITY_NUM) ? 0 : pml_idx + 1;
 
-	/* PML index always points to next available PML buffer entity */
-	if (pml_idx >= PML_ENTITY_NUM)
-		pml_idx = 0;
-	else
-		pml_idx++;
-
+	/*
+	 * PML log is written backwards: the CPU first writes the entity 511
+	 * then the entity 510, and so on, until it writes the entity 0 at which
+	 * point the PML log full VM exit happens and the logging stops.
+	 *
+	 * Read the entries in the same order they were written, to ensure that
+	 * the dirty ring is filled in the same order the CPU wrote them.
+	 */
 	pml_buf = page_address(vmx->pml_pg);
-	for (; pml_idx < PML_ENTITY_NUM; pml_idx++) {
+
+	for (i = PML_LAST_ENTRY; i >= pml_last_written_entry; i--) {
 		u64 gpa;
 
-		gpa = pml_buf[pml_idx];
+		gpa = pml_buf[i];
 		WARN_ON(gpa & (PAGE_SIZE - 1));
 		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
 	}
 
 	/* reset PML index */
-	vmcs_write16(GUEST_PML_INDEX, PML_ENTITY_NUM - 1);
+	vmcs_write16(GUEST_PML_INDEX, PML_LAST_ENTRY);
 }
 
 static void vmx_dump_sel(char *name, uint32_t sel)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 43f573f6ca46..d14401c8e499 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -331,6 +331,7 @@ struct vcpu_vmx {
 
 	/* Support for PML */
 #define PML_ENTITY_NUM		512
+#define PML_LAST_ENTRY		(PML_ENTITY_NUM - 1)
 	struct page *pml_pg;
 
 	/* apic deadline value in host tsc */
-- 
2.26.3


