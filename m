Return-Path: <linux-kselftest+bounces-41250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1EB5344E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7200A163F15
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A833472D;
	Thu, 11 Sep 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkYcdUkv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E813314BC;
	Thu, 11 Sep 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598590; cv=none; b=IenVu2cWk9i8FwQj35eRPUobVjkLyMNJfcDEnYoUPn2CHuNpD11vpcM1yLR6m4JXaclM/oBclpeqlrZpRFCoykyltcDnHW7EW+QQ5dlJzM8BmtWj27xBK416t4YgTMSmUQV3X+57YgM7iNh8jgcGjbubZOx0AzuLCE/myuBCP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598590; c=relaxed/simple;
	bh=oD5inpjA2IcOCtviwES48RFDBTJqtvXhnvR33T0dpwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQWS692AloVfziS44yGlm4DTxT9kBIezQjm/0yc0MO3deamQM+3v0yZ8HuRb5Uf8arTBmFwl1WVw7g7o/26L8p7s6jj7ytXRkAHUtjjSP3ADVscZ2VI5UApXnC1yTpGgPBbg94jqF0mz3NBMBYOshUkmfj9UJ+6E0ZGyahsAaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkYcdUkv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e7622483beso391015f8f.3;
        Thu, 11 Sep 2025 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598587; x=1758203387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isdwFXSTuI6vyPoZ5KEzSCMF3I2UJtuA1www3knapSA=;
        b=kkYcdUkvItoMq+ZwMRIdIjyudpEtkU0eedGGIj+Q6SAqcglNrFxqkXQSjiFlMbRWoL
         HdysZa4vgwbYC2uTLt2UzMLtXgy05ZopUvqzZugNl44piZlOqM4Kz5jKJKUPfLIyWzAj
         Wr+93X2zPUM/8vDnHjlwLhVT4VhZvmPc9yrh9rKT6aIIFvThqwL7wlTQodbKdIIMjS2R
         5utj2JbTFg4nroNjElI7DAvCSG4cvXYVmGd18JE/bOsFzPq76G+eEfWsJDxDS8+6BV7n
         RWnFodxjSS9LBa+hrkYLr9ZMXBGGJTSlMtPe+s+KtH7KyMFm/UdGKJ6w1o6GfR4gzjId
         uyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598587; x=1758203387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isdwFXSTuI6vyPoZ5KEzSCMF3I2UJtuA1www3knapSA=;
        b=d8UtqINNLI/AJiduHESLQ+10/cWMqGfKx0o+oWRgnMUsAAQ/q5jRq8KEYAReiLPGib
         Fyg896mmRUBb3KbfDluudu92WrgRpYKcuJuWbAY4cn5mRxOkomvXRZSLDPhybh8YzEiU
         T8XWi1Vj0OaUlBFYm3B0VT49lV3HEiSdlK0zHVqTEptkTzOd3xpQn8cKajzfD94ENX7w
         O5f8BRo3lcrQDjkNHjYkqCK+eiMKMzkDt0oWywtDQMvb5c9/1DBXD4vJJP0vgE47f/cl
         E55sbHaO4GMWctqRXXnlP4T6vH6+PtRme+26aE2L4y18A+OMUL7pow8E7xRAiCEmKVBu
         E0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUFY4JwHsgh3tmTkpHWb+P6dteyLyNVfmN7vzVJSPuqr1U74oV9//4BCaO5WzyWOr2ouuoG3B5o5kvMk+WHuqvR@vger.kernel.org, AJvYcCW+82J5qyJSEYoYsMBwU7UpmQRTsYN4Px/L+2VdLv9AuFQbJjgOaFVM3sOAsUBZjji4ehNi+DdegRx+Drw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvc5cOnVnyi6LZP2qbAWUMexh2ZLhiv7pRGQcxQE+STz+X+7b
	TJjBSLmGewFBq9Ga39/pYO16BH5oH/jedI2NaS3tsVwv1N1QBEe8IlNa
X-Gm-Gg: ASbGncvDhkl4IGdcIT+sjT5vixgnVazxJcIQ18mvgItMRkZ+pkambl7nwGqzxIE2tjQ
	QzwClOjDRm9FJ5f/Jc9k+F9BlbK/4qgruj8cPJvCzxUErKCgPyF2JqYptDji2KmzPKfVy2+y0tG
	urMKMBxI2CeZrWfpbGUKlTvq3tJm+aAF0aJ1DSUxAtAs5taHTVisArTHs4+E5ES9kl8IfRHX58e
	9gqGFh5TylGXNyCK4vZxt0gqT0bfkQYz6yS5g9ytgpPwP1MGJSLLMIcyQdUxVVk2nbDXh7fY31G
	ODGM5Oq1OHfqoULTaC3MGqeSeNr6NkPrx1n1L0kn++03caTKKnP0ToS2t/qYOWbBVR8vGZF7etB
	u7rxtq/K1K2+WveYhx50NePvu8LecRwA/pwl1rv+TmxG2lKlvbr2ZJ2J12miw1GESnWHbbXb3
X-Google-Smtp-Source: AGHT+IEUm00hUmaf0xUsT6+9m3Zb4ZN7y4GJW9ZTUjRe1MIWGQuwO5e+uMIcjcSuvIP0YWNV9JWh1w==
X-Received: by 2002:a05:6000:2385:b0:3e0:152a:87ad with SMTP id ffacd0b85a97d-3e64bde9161mr15064477f8f.31.1757598587245;
        Thu, 11 Sep 2025 06:49:47 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:47 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 3/6] KVM: arm64: Add pre_fault_memory implementation
Date: Thu, 11 Sep 2025 14:46:45 +0100
Message-Id: <20250911134648.58945-4-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Add kvm_arch_vcpu_pre_fault_memory() for arm64. The implementation hands
off the stage-2 faulting logic to either gmem_abort() or
user_mem_abort().

Update __gmem_abort() and __user_mem_abort() to take the pre_fault
parameter. When passed, the paths to determine write or exec faults are
short circuited to false, as when pre-faulting, it should be treated
as a read fault.

This closely follows the implementation on x86.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 arch/arm64/kvm/Kconfig |  1 +
 arch/arm64/kvm/arm.c   |  1 +
 arch/arm64/kvm/mmu.c   | 71 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index bff62e75d681..1ac0605f86cb 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -25,6 +25,7 @@ menuconfig KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select KVM_XFER_TO_GUEST_WORK
 	select KVM_VFIO
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 888f7c7abf54..65654a742864 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -322,6 +322,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_COUNTER_OFFSET:
 	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
+	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 082e7d8ae655..002f564c6ac7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1523,7 +1523,8 @@ static void adjust_nested_fault_perms(struct kvm_s2_trans *nested,
 
 static int __gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			struct kvm_s2_trans *nested,
-			struct kvm_memory_slot *memslot, bool is_perm)
+			struct kvm_memory_slot *memslot, bool is_perm,
+			bool pre_fault)
 {
 	bool write_fault, exec_fault, writable;
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
@@ -1537,6 +1538,9 @@ static int __gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	gfn_t gfn;
 	int ret;
 
+	if (pre_fault)
+		flags |= KVM_PGTABLE_WALK_PRE_FAULT;
+
 	ret = prepare_mmu_memcache(vcpu, true, &memcache);
 	if (ret)
 		return ret;
@@ -1546,8 +1550,8 @@ static int __gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	else
 		gfn = fault_ipa >> PAGE_SHIFT;
 
-	write_fault = kvm_is_write_fault(vcpu);
-	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
+	write_fault = !pre_fault && kvm_is_write_fault(vcpu);
+	exec_fault = !pre_fault && kvm_vcpu_trap_is_exec_fault(vcpu);
 
 	VM_WARN_ON_ONCE(write_fault && exec_fault);
 
@@ -1599,7 +1603,7 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		      struct kvm_s2_trans *nested,
 		      struct kvm_memory_slot *memslot, bool is_perm)
 {
-	int ret = __gmem_abort(vcpu, fault_ipa, nested, memslot, is_perm);
+	int ret = __gmem_abort(vcpu, fault_ipa, nested, memslot, is_perm, false);
 	return ret != -EAGAIN ? ret : 0;
 }
 
@@ -1607,7 +1611,7 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			    struct kvm_s2_trans *nested,
 			    struct kvm_memory_slot *memslot,
 			    long *page_size, unsigned long hva,
-			    bool fault_is_perm)
+			    bool fault_is_perm, bool pre_fault)
 {
 	int ret = 0;
 	bool topup_memcache;
@@ -1631,10 +1635,13 @@ static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	vm_flags_t vm_flags;
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
 
+	if (pre_fault)
+		flags |= KVM_PGTABLE_WALK_PRE_FAULT;
+
 	if (fault_is_perm)
 		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
-	write_fault = kvm_is_write_fault(vcpu);
-	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
+	write_fault = !pre_fault && kvm_is_write_fault(vcpu);
+	exec_fault = !pre_fault && kvm_vcpu_trap_is_exec_fault(vcpu);
 	VM_WARN_ON_ONCE(write_fault && exec_fault);
 
 	/*
@@ -1895,8 +1902,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  bool fault_is_perm)
 {
-	int ret = __user_mem_abort(vcpu, fault_ipa, nested, memslot, NULL,
-			    hva, fault_is_perm);
+	int ret = __user_mem_abort(vcpu, fault_ipa, nested, memslot, NULL, hva,
+				   fault_is_perm, false);
 	return ret != -EAGAIN ? ret : 0;
 }
 
@@ -2468,3 +2475,49 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
 
 	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
 }
+
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	int r;
+	hva_t hva;
+	phys_addr_t end;
+	long page_size;
+	struct kvm_memory_slot *memslot;
+	phys_addr_t ipa = range->gpa;
+	gfn_t gfn = gpa_to_gfn(range->gpa);
+
+	while (true) {
+		page_size = PAGE_SIZE;
+		memslot = gfn_to_memslot(vcpu->kvm, gfn);
+		if (!memslot)
+			return -ENOENT;
+
+		if (kvm_slot_has_gmem(memslot)) {
+			r = __gmem_abort(vcpu, ipa, NULL, memslot, false, true);
+		} else {
+			hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
+			if (kvm_is_error_hva(hva))
+				return -EFAULT;
+			r = __user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva, false,
+					     true);
+		}
+
+		if (r != -EAGAIN)
+			break;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
+			return -EIO;
+
+		cond_resched();
+	};
+
+	if (r < 0)
+		return r;
+
+	end = (range->gpa & ~(page_size - 1)) + page_size;
+	return min(range->size, end - range->gpa);
+}
-- 
2.43.0


