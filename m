Return-Path: <linux-kselftest+bounces-4764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35D8567C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A171F2B234
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63847135A55;
	Thu, 15 Feb 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="cSpmbqk4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889B13540A;
	Thu, 15 Feb 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011046; cv=none; b=L1s1pdmBQLMIzegKLFvodQqj8CXMl3QoHbm6r5O7p+esWkOgyK645qx4EtyZC/978R6uuv+N/xg8hInOkIaPtl1Cg6yCDcujjBBYm3bkV/hK3MG7pQabY+y2v35Jx5/D3vm9ubDRHOpNuMT95adUvWz65inuXIiaUXnrwG99p0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011046; c=relaxed/simple;
	bh=STCYp8hlp+MiB5Ynx/ErSBf64wQDmWMFRv1LIlw8HCs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HviJGmoNyhXUbftRQC8HoX/u/3LPm57udp+/37eaIDtY7iYXwOaCs8wLqchqT+sIr45oSVfReIFjEYAN9ZpLFHLJAfeyb2ouPOdG52sfLkJsWrZAJikDE454XFYcWJU1ZTcmE4T8MlmO/8WDXmM44gXzxNN5QZGYoSFX67v8kWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=cSpmbqk4; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=vidRqY/husiNAcsXLmx8RKhnEHcdfKPAREQpb1Abk68=; b=cSpmbqk4igwIM8oZ2HgWyMpq43
	urm7g0oevw99lhaMdmHBiEbdyS4CxrFeu9mM4H6zNgEl9vE/rEoK0zDfF1i77IlBV5QQvEMaqObvg
	adxZbMUr9DIs9reVafS6B37T5+6BwXX998NDHzpJPB3bkq80FaFDBg8c+4YubGWOaFSw=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radh0-0001GG-NC; Thu, 15 Feb 2024 15:30:30 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radh0-00089r-EY; Thu, 15 Feb 2024 15:30:30 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 08/21] KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
Date: Thu, 15 Feb 2024 15:29:03 +0000
Message-Id: <20240215152916.1158-9-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215152916.1158-1-paul@xen.org>
References: <20240215152916.1158-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Rename kvm_is_error_gpa() to kvm_is_gpa_in_memslot() and invert the
polarity accordingly in order to (a) free up kvm_is_error_gpa() to match
with kvm_is_error_{hva,page}(), and (b) to make it more obvious that the
helper is doing a memslot lookup, i.e. not simply checking for INVALID_GPA.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

v13:
 - New in this version.
---
 arch/s390/kvm/diag.c     |  2 +-
 arch/s390/kvm/gaccess.c  | 14 +++++++-------
 arch/s390/kvm/kvm-s390.c |  4 ++--
 arch/s390/kvm/priv.c     |  4 ++--
 arch/s390/kvm/sigp.c     |  2 +-
 include/linux/kvm_host.h |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3c65b8258ae6..2a32438e09ce 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -102,7 +102,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
 			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-		if (kvm_is_error_gpa(vcpu->kvm, parm.token_addr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		vcpu->arch.pfault_token = parm.token_addr;
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5bfcc50c1a68..415c99649e43 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -664,7 +664,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_REGION1:	{
 		union region1_table_entry rfte;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &rfte.val))
 			return -EFAULT;
@@ -682,7 +682,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &rste.val))
 			return -EFAULT;
@@ -700,7 +700,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &rtte.val))
 			return -EFAULT;
@@ -728,7 +728,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &ste.val))
 			return -EFAULT;
@@ -748,7 +748,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		ptr = ste.fc0.pto * (PAGE_SIZE / 2) + vaddr.px * 8;
 	}
 	}
-	if (kvm_is_error_gpa(vcpu->kvm, ptr))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 		return PGM_ADDRESSING;
 	if (deref_table(vcpu->kvm, ptr, &pte.val))
 		return -EFAULT;
@@ -770,7 +770,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		*prot = PROT_TYPE_IEP;
 		return PGM_PROTECTION;
 	}
-	if (kvm_is_error_gpa(vcpu->kvm, raddr.addr))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, raddr.addr))
 		return PGM_ADDRESSING;
 	*gpa = raddr.addr;
 	return 0;
@@ -957,7 +957,7 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 				return rc;
 		} else {
 			gpa = kvm_s390_real_to_abs(vcpu, ga);
-			if (kvm_is_error_gpa(vcpu->kvm, gpa)) {
+			if (!kvm_is_gpa_in_memslot(vcpu->kvm, gpa)) {
 				rc = PGM_ADDRESSING;
 				prot = PROT_NONE;
 			}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea63ac769889..3e5a1d7aa81a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2878,7 +2878,7 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 
-	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
+	if (!kvm_is_gpa_in_memslot(kvm, mop->gaddr)) {
 		r = PGM_ADDRESSING;
 		goto out_unlock;
 	}
@@ -2940,7 +2940,7 @@ static int kvm_s390_vm_mem_op_cmpxchg(struct kvm *kvm, struct kvm_s390_mem_op *m
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 
-	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
+	if (!kvm_is_gpa_in_memslot(kvm, mop->gaddr)) {
 		r = PGM_ADDRESSING;
 		goto out_unlock;
 	}
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 621a17fd1a1b..0ece9c581ebf 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -149,7 +149,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	 * first page, since address is 8k aligned and memory pieces are always
 	 * at least 1MB aligned and have at least a size of 1MB.
 	 */
-	if (kvm_is_error_gpa(vcpu->kvm, address))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, address))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	kvm_s390_set_prefix(vcpu, address);
@@ -464,7 +464,7 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 	addr = kvm_s390_real_to_abs(vcpu, addr);
 
-	if (kvm_is_error_gpa(vcpu->kvm, addr))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, addr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	/*
 	 * We don't expect errors on modern systems, and do not care
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index d9696b530064..55c34cb35428 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -172,7 +172,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 	 * first page, since address is 8k aligned and memory pieces are always
 	 * at least 1MB aligned and have at least a size of 1MB.
 	 */
-	if (kvm_is_error_gpa(vcpu->kvm, irq.u.prefix.address)) {
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, irq.u.prefix.address)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INVALID_PARAMETER;
 		return SIGP_CC_STATUS_STORED;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index da20b7018cc8..41ee515b304e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1791,11 +1791,11 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
 
-static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
+static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
 
-	return kvm_is_error_hva(hva);
+	return !kvm_is_error_hva(hva);
 }
 
 enum kvm_stat_kind {
-- 
2.39.2


