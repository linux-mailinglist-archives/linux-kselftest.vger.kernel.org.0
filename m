Return-Path: <linux-kselftest+bounces-4649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E6854DF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EFEB2623E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6D5FF17;
	Wed, 14 Feb 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb+Ua2jq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF655FF07
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927619; cv=none; b=aM/k6yIbAMDsEpMHek/umO+03wKZcjYS8udGZdvEDCQcg8Rk7E/hHBEf+K+tqLNI6IfN7C94RoUF55T0gPjgcniOgjjBwe/+FPEwoFmdmlIEVIxjlJ0IV8eZ+vTSVVITgT3fDF7+Jz6M2S4f2aiVk7uQv1Cd8PM3P9OIwe7JlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927619; c=relaxed/simple;
	bh=0HcfJmmBqgnxEibVXmvtKiQfWDI/qjmiO3qS4+TsxxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=atCcyJamqyffM7MzOEzwwvsa+wB5jmSWa1D6M+CbfulJ7T4AQ069wtRPiS99awOny0iF4n38XejqdcsuajknVt+dYvjhutlcd/E/IE1gG9BVeMANzp9PngBkwMqekOni3d8oc74CFDp2gjW6WWxI/LITuVU08fFLunyZ8QxCPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hb+Ua2jq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5ce632b2adfso5399859a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707927617; x=1708532417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm0rEdFpfBw8yrd8ZCjG8lJI7FOozunf2bgbBsdJdm0=;
        b=Hb+Ua2jq7CbJygC6codkBXNvS1oHVKlJW5tWam94GlvHyNLvyJYHO5Sz/JIySq7SzE
         mAMywQxAe5T7l/K2vsvPHq2jA1WI6Mt7S0jqdKxf+10UtTwP4T/Xj64RE79Moh8Ptwgy
         Th0IzgdFW4WGqKe8c39h7FzSe3ztIZqR0iNzL4vDdHbeZNDs4wX1PptBcob7WC/9If1/
         t/BjKNUO0qqXjnupAhoV2dAEcJ64m0Cc/upo2p4HhCxaR8ipC1JdzFqRuVYzdYwt5+Fz
         IB7I7iliqYufEd9VrbJ4rtc4ipr0m6XbSJYOrV6MZRwMSkATIHexopkx/n4IevzYwePF
         ADHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927617; x=1708532417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm0rEdFpfBw8yrd8ZCjG8lJI7FOozunf2bgbBsdJdm0=;
        b=Wx7rNE7QHfsa1VK8Sqd+Lr5sxrva+PvAvLmyzyg4K0rf4E1Bww3ioH8DDQKEV2qEpL
         rrWiOmk17VgMGEoB1qcJOIiTNguDF26V3BF9ZiUX2QiSdfY6XGMX9Zo2u1iCkOBoLsy+
         phUBYXl4sp5Myb3M9QXeZOVll97IY1TPf1D0YrLOvBvU1FFLYHpeS4l0W2EOl7SLVf2J
         csRKgytAv94g4ShOzs8opQvbKTldMhKVvPSSXTkemi2gxbsgGz8/VofC7RKXppRFRNmQ
         sTJcM0GQjJRYtQ+1o2r1zF3V7DF2m+6TAZkaJKckgKKgpNP+a6C1AYwehafR0jqd2Fxx
         3GvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT2/9rXTrzBSo6CZDkH2ItQc0nvIKQNFwlQOez5k1gIg1OH4UZ6EQFj6+0+odttWAhOUs9Vt6siM940OVVy9WlKBr0rEcEkMANZQtzmbJk
X-Gm-Message-State: AOJu0YwNvC6EZ1KEqdGeegObAmZqnrkjfpnUN9qzFmhtj6ft2IHK2Jbn
	FUPjpnY+q5zfVsS6e6aJNgOxSf2QZJ6OypFBgz9pqb1S36+byVZRPAckJS3f4KepLiPmDMTkaof
	VrQ==
X-Google-Smtp-Source: AGHT+IHa4kkG/0f9ehySoOxGA7p25JnA0B81TqydyG2BEVARRtuNpfCLKC2Wn9Ns0F6pvUgaCDhVtXIwZ5A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:996:b0:5ce:6c6:6973 with SMTP id
 cl22-20020a056a02099600b005ce06c66973mr40244pgb.8.1707927616820; Wed, 14 Feb
 2024 08:20:16 -0800 (PST)
Date: Wed, 14 Feb 2024 08:20:15 -0800
In-Reply-To: <9c542f39-959e-4ab1-94a5-39e049a30743@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-9-paul@xen.org>
 <ZcMBDP6H5PRo5C2d@google.com> <9c542f39-959e-4ab1-94a5-39e049a30743@xen.org>
Message-ID: <ZczoP_pfb4E3i8OO@google.com>
Subject: Re: [PATCH v12 08/20] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
From: Sean Christopherson <seanjc@google.com>
To: paul@xen.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 14, 2024, Paul Durrant wrote:
> On 07/02/2024 04:03, Sean Christopherson wrote:
> > +s390 folks (question on kvm_is_error_gpa() for ya)
> > But!  kvm_is_error_gpa() already exists, and it very, very sneakily does a memslot
> > lookup and checks for a valid HVA.
> > 
> > s390 people, any objection to renaming kvm_is_error_gpa() to something like
> > kvm_gpa_has_memslot() or kvm_gpa_is_in_memslot()?  s390 is the only code that
> > uses the existing helper.
> > 
> > That would both to free up the name to pair with kvm_is_error_hva(), and would
> > make it obvious what the helper does; I was quite surprised that "error" means
> > "is covered by a valid memslot".
> > 
> 
> Seemingly no response to this; I'll define a local helper rather than
> re-working the open-coded tests to check against INVALID_GPA. This can then
> be trivially replaced if need be.

How about we force a decision with a patch?  This should be easy enough to slot
in, and I would be quite surprised if s390 is overly attached to kvm_is_error_gpa().

From: Sean Christopherson <seanjc@google.com>
Date: Wed, 14 Feb 2024 08:05:49 -0800
Subject: [PATCH] KVM: s390: Refactor kvm_is_error_gpa() into
 kvm_is_gpa_in_memslot()

Rename kvm_is_error_gpa() to kvm_is_gpa_in_memslot() and invert the
polarity accordingly in order to (a) free up kvm_is_error_gpa() to match
with kvm_is_error_{hva,page}(), and (b) to make it more obvious that the
helper is doing a memslot lookup, i.e. not simply checking for INVALID_GPA.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
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
index f875a404a0a0..1be19cc9d73c 100644
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
index 7e7fd25b09b3..d175b64488ec 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1788,11 +1788,11 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
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

base-commit: 687d8f4c3dea0758afd748968d91288220bbe7e3
-- 


