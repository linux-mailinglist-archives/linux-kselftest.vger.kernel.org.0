Return-Path: <linux-kselftest+bounces-41248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA85BB5344B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29713162824
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718032F75B;
	Thu, 11 Sep 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaDvvWnP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD132ED49;
	Thu, 11 Sep 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598584; cv=none; b=HvpY34UsW/Obc9P77QI3ne6h766O4Jap33SkpscExHwfB388VSMn0HmLfGG8bkHVqL15fpTiye/5bNpdc1jaUxa33vtlIiQDr7Cxz0MlJf0VUZPOKM1i0gump9EBRNZUA2CxNWB/C0kWE0OyZwKLGJHzB2mCwnaVJwoBZiWBWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598584; c=relaxed/simple;
	bh=MgG36VJmw214zv4sHqDEvyy0doXE0b66hEX+1oPfR84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GauzH2Z+fytNU5t4W9n1jju7cZ92Cq7/Zesswcth7Tsp0F7YYYXv0PzWDxmg6Db55KuOTBG7r3YSEUskAq5I7D4Fps64Umgl2qDEpd2qKuuOQbIyYysktGb5+nHwetyqO4+aZcCeKemB/gTjawPUgyLYMYkUK+bACxGYZDIWWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaDvvWnP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45df09c7128so5951095e9.1;
        Thu, 11 Sep 2025 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598581; x=1758203381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJBOYBviiAkHEGuAebJYs1rSMwBP/rg8f5sw3Y1zhrU=;
        b=YaDvvWnPDhzBa16I8VZUKoi+aqG/tKR667NbI4tmyZFbhn3uhdi1iXsJBhvs3GhAdg
         ApR7QHdO0XGmmHs/smrN0rhZP4Zbq9ThWLTBHABfzK9R0xIAoaMLyqj4TrlqjgD8RRMT
         B6CjK6KEJbMDvuAKfiUBE3b44gFskimkjwVoht994TLsPMYkM0sAiPk+J+cyfD6c5MUq
         q19sKsn/GzA9l1GA1YgLWa5lM/eAPAQf467i6waX6KWlQuat5gAWCzX1LfkMOrKxiPoV
         EM1WGnSxqE4eRQoXkrtl/3RUMUv4DegIVueT1lCDSYIQ7mjk3eNap9XjzCBNdRLrDJHs
         ZkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598581; x=1758203381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJBOYBviiAkHEGuAebJYs1rSMwBP/rg8f5sw3Y1zhrU=;
        b=KRYLrrsOfXcniLPuD0Exrpjgf6b7/04moPe3zpySEginn7eBKLB5X8PyarR1ABxXvJ
         1KtqqS1tKyTd6kpCBVVRTJ3AegF1T5UTAzHA6FAJQGTODOkhYcZEsPbQmGW3twhtMT/M
         BsQ7rArPkwSP5iiMH62VrODfQ5dN9874IDIatU2jyhJm6Cuyh7991dEwzcv+YPOQ6Lbb
         HpuFVSiJ1Su2PDfVL1X0y+iCL0Z4DYumhJsD/UkUW7xOYqDbNlu7YI3dN562qx0qBAUs
         rbwywd1fAxlT9A8484cYc1yaXl0eBKgml6LQ1t5Jz4ikxGHruyXm0/etp+TRlojoYbus
         Tesg==
X-Forwarded-Encrypted: i=1; AJvYcCWn82C4TXvKJSzgJANEQGQ3j/6ewA/r/ox+o4WGjVANRapS8TpjlvnzCYVSZ+j7D/s+hM3qeFVuhJvoeeD1WVtp@vger.kernel.org, AJvYcCXd1PM2TZCliiatFpIFgQmtaGNZ+G/G4eCTHviksrRgxxDzP/mG1NQD8a5yKuMhAj5bKhjDWv6Pk01ifqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqbqs5thuTrNeCT/91rPKZijgU8zhNndoTD99gH5Hmv58PeG10
	Yfs/WLmn0+QyBzctNvmf6sPc7v1zh3gnINZTpnHYv1gY8iv96zInxHlx
X-Gm-Gg: ASbGncvUm0QlDCrqA/+0xAD5iesLIDsMe5j3/0/0RnWy4k8sXF1B3O+f2Dn2xsYXWSY
	WboyW43OCwB/E8PjUrkOfvTWmpitLq/qGQjSW3ZpM1mU17QxvA+Wp4Q/ONoKdViwIwyD2Y+JaXb
	zX550VKOqPSogGe83NVcXHfxSCnfpG1Ou8fi/gJhrdR1nVf6vS6ivQL9hYbQLalFt27K8RUzRcm
	Q0VDVZWf7h/voLH0zcpQXIzdOwcQ+d++A5l6g2ywY6gyzyUL4pfXkti6MQWvjNHgL2GiWp83IxL
	hzL4sbYRhar+h2N+6UUUxXApeTjCFXUgHkKBbup1pWpW1sQzn7rE+w+jaP4h+WB76BG2b5ez06o
	eDNdGtyAclsIpsRziW50Vj42cfAw55/dz4m4y8+brLOhatwIzPN9LRFnIDjcDpw==
X-Google-Smtp-Source: AGHT+IF9gYWYpXj1cgrspFLvRu0yrW6lKAr/MmACXhsm2WBvm6knLxYnlrbbjGF1EG0D4ZDyCrnxvA==
X-Received: by 2002:a05:600c:a103:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45dfd5e3d68mr29948455e9.12.1757598580729;
        Thu, 11 Sep 2025 06:49:40 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:40 -0700 (PDT)
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
Subject: [PATCH 1/6] KVM: arm64: Add __gmem_abort and __user_mem_abort
Date: Thu, 11 Sep 2025 14:46:43 +0100
Message-Id: <20250911134648.58945-2-jackabt.amazon@gmail.com>
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

Adding __gmem_abort and __user_mem_abort that preserve -EAGAIN results.
These will be used by the pre-fault implementation which needs to retry
on -EAGAIN.

Also add an optional page_size output parameter to __user_mem_abort to
return the VMA page size, which will be needed for pre-faulting.

No functional changes are intended

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 arch/arm64/kvm/mmu.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a36426ccd9b5..082e7d8ae655 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1521,9 +1521,9 @@ static void adjust_nested_fault_perms(struct kvm_s2_trans *nested,
 
 #define KVM_PGTABLE_WALK_MEMABORT_FLAGS (KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED)
 
-static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-		      struct kvm_s2_trans *nested,
-		      struct kvm_memory_slot *memslot, bool is_perm)
+static int __gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			struct kvm_s2_trans *nested,
+			struct kvm_memory_slot *memslot, bool is_perm)
 {
 	bool write_fault, exec_fault, writable;
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_MEMABORT_FLAGS;
@@ -1592,13 +1592,22 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (writable && !ret)
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 
+	return ret;
+}
+
+static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+		      struct kvm_s2_trans *nested,
+		      struct kvm_memory_slot *memslot, bool is_perm)
+{
+	int ret = __gmem_abort(vcpu, fault_ipa, nested, memslot, is_perm);
 	return ret != -EAGAIN ? ret : 0;
 }
 
-static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_s2_trans *nested,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  bool fault_is_perm)
+static int __user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			    struct kvm_s2_trans *nested,
+			    struct kvm_memory_slot *memslot,
+			    long *page_size, unsigned long hva,
+			    bool fault_is_perm)
 {
 	int ret = 0;
 	bool topup_memcache;
@@ -1871,10 +1880,23 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	kvm_release_faultin_page(kvm, page, !!ret, writable);
 	kvm_fault_unlock(kvm);
 
+	if (page_size)
+		*page_size = vma_pagesize;
+
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret)
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 
+	return ret;
+}
+
+static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
+			  struct kvm_s2_trans *nested,
+			  struct kvm_memory_slot *memslot, unsigned long hva,
+			  bool fault_is_perm)
+{
+	int ret = __user_mem_abort(vcpu, fault_ipa, nested, memslot, NULL,
+			    hva, fault_is_perm);
 	return ret != -EAGAIN ? ret : 0;
 }
 
-- 
2.43.0


