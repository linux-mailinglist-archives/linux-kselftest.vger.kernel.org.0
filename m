Return-Path: <linux-kselftest+bounces-48062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F1CEEBFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E7C302BA98
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDF3128C9;
	Fri,  2 Jan 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWW4yq8v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7031283B
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767363882; cv=none; b=VGyPduU12PrvF6pwKPPHDv0L/fMX9ei4kCGNV8PM3Bd2Zy0GCGhXAiQrtogavQRbdiwoDnCJdw3PyJb+2jT0R+qHm+mpWesUlE0rprHEKf0TAkIkDDze8kYNlPW9gZJeHn5x5DLVgFf5OVSdgqiljcPQ9kbpGTxCMTWgCki7RYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767363882; c=relaxed/simple;
	bh=wqUHPwMmugOuKzr72dNSB6jV8ahnfgwwq6tDGhuJSJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI1f1ZbtO8hmZxwQDyNU9baYIOEieuxsg0EG2WgI8iYFJZ5+FFDkqJgUoaZkngyhw2KrvRLfTk1lTVEviiBGhaQjlY8b+hyNtuZ06EgwU0TT3SL19sn5j6vOpr3fzpU3uLdbQxn0m1GqcPI7FaimhFplnvUbUCtxy6Hs5gHeMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWW4yq8v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso48966435e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767363878; x=1767968678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeg7EwyXEmjSLbkDPSXyM1TOODBHSEC3whcgQOLcUgM=;
        b=bWW4yq8vFOMwusK42eXrZYnz38Ip19HkUMTGXzB/sCPi2OQDa9PzjO0eVv6HI581Js
         Meg2BiW7OF5eliT7z51IH/WiV6aucyd2N0EnP87+lgXQZ+/jcmGBpJW5mdS6iYB9nPub
         D/AbaqK7LwaVqViQn+r1Uu7McYc6BhYzUYCmj5gYebV35OIhkNE38xx9mP2FOo/2k0Kb
         Zp/U3097ElYOo95tKnUXJGyk2uTofnYfxrtXY1A6/vC5x3MZt+oLqi3NkdzFxgwvma3n
         wbQcvMPNWDXmIIGkYeBNp6kZi/aK7YqhUQYHatX1K8UklcOUKIU0Uzl04c9gWrrsqeXd
         R3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767363878; x=1767968678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aeg7EwyXEmjSLbkDPSXyM1TOODBHSEC3whcgQOLcUgM=;
        b=QtZgPlhfKUL08GXnJT940E0wTgVR4t/NkOybKpHH61Ji1MpCsz5t4yLNlmqZ+gbo//
         J0JTDgB9L+tSOEYV2U0IulFgy941rilaCmEqUOnMVD3J58MFZ42+XkzkhvTi7+kn8LBI
         f9jwTvnm6WJVf1MzJHAg5Zo4YUB3gMbITXgi1j+Vcgl1A6NYKMAPiP25L39v5nulA41i
         6ezX0gBaVPRBMN2h6yY/vW5F2Zxoo8B3YdNSaCqMUYPaZicQOPcqWv1cyZD5ywDkzaLz
         wyB1QfqgoVuzbXR8vDnSNZJAmetq4nWyFTRKDvfpA7c/LMFueHiwSKst6sOQsA1UAgC5
         Os9A==
X-Forwarded-Encrypted: i=1; AJvYcCVd6y0/YjW2yWAl2OQ8Jvq5/6eBqh4uHjLV1ZPDItEZKZNC25TwvMhGS14XR1/BF3p5wAWb8tJQin4azM0epHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5eLpbYL78jLdk2nUo3bauJABptoWR0/avCcCclxJSFDGM4O4
	hdtgFSZpqL3NblhdiC5zaL+gD05sRYF+IbQxUHQhaG7VcSWeNpwQU8Oh
X-Gm-Gg: AY/fxX7oHv94YjT7RFwwmf3nkqFD8i+hywItLUKtTMjAOsq6EpMLoNtcngqBX7naTG8
	758ypn6006gnt4A7/Sa+6QTafOwqyVyVPw8y2Qp4z+mANtlSaa+dOMwKTeC8+2sTFeTGQCl/dUO
	UBRckb5PoHmS2x3SzNQefyJx+rTzyRX7nLuJJSMMjXdSv5lAGeOxj5l97JYrDAqvTBgJp6cHCEc
	OjHqtxo/sQo00D6iPtkdhELmuWpirifLIItDptaraIOyyRRiyhEhZrsm6VTbaErdya8NLXdTEWh
	3dWJFupCiqqKTIl6ZOxM1SZTqU5LaxQcgG8k29/Os8mWi7GYTINKA9klHO6NCyhueHJznlA7CJe
	CTGuNBZvnsZtBkButuP/ZBWM7HrKlgOOf3qaLeLzN5nstpDXrauYKiVXJbIt/kaP/6aXotaCnHj
	o9HD7A8PlFAJ2IQbIEgk+KkCD+lKP7Bu81Ca/c0cebytZUVTCHP8kCwytkSrjq530Ic6zEIvGgm
	tuKPmUbU8qb/8ynkW1bzmCnixvctgFv
X-Google-Smtp-Source: AGHT+IFvaZYaBmTu+j4Xg9NMHkyYOTXzf1YgRcKKESQHsqFOkCkOpUTusFV0oibFz4wHFe6N62j/Tw==
X-Received: by 2002:a05:600c:c1c8:10b0:47d:403c:e5a0 with SMTP id 5b1f17b1804b1-47d403ce6e0mr276742335e9.12.1767363877505;
        Fri, 02 Jan 2026 06:24:37 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm806409235e9.13.2026.01.02.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 06:24:37 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v4 02/10] KVM: pfncache: Restore guest-uses-pfn support
Date: Fri,  2 Jan 2026 14:24:21 +0000
Message-ID: <20260102142429.896101-3-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102142429.896101-1-griffoul@gmail.com>
References: <20260102142429.896101-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Restore functionality for guest page access tracking in pfncache,
enabling automatic vCPU request generation when cache invalidation
occurs through MMU notifier events.

This feature is critical for nested VMX operations where both KVM and L2
guest access guest-provided pages, such as APIC pages and posted
interrupt descriptors.

This change:

- Reverts commit eefb85b3f031 ("KVM: Drop unused @may_block param from
  gfn_to_pfn_cache_invalidate_start()")

- Partially reverts commit a4bff3df5147 ("KVM: pfncache: remove
  KVM_GUEST_USES_PFN usage"). Adds kvm_gpc_init_for_vcpu() to
  initialize pfncache for guest mode access, instead of the
  usage-specific flag approach.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 include/linux/kvm_host.h  | 29 +++++++++++++++++++++++++-
 include/linux/kvm_types.h |  1 +
 virt/kvm/kvm_main.c       |  3 ++-
 virt/kvm/kvm_mm.h         |  6 ++++--
 virt/kvm/pfncache.c       | 43 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d93f75b05ae2..04b641d381b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1412,6 +1412,9 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 			 unsigned long len);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    struct kvm_vcpu *vcpu);
+
 /**
  * kvm_gpc_init - initialize gfn_to_pfn_cache.
  *
@@ -1422,7 +1425,11 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
  * the caller before init).
  */
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
+
+static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+{
+	__kvm_gpc_init(gpc, kvm, NULL);
+}
 
 /**
  * kvm_gpc_activate - prepare a cached kernel mapping and HPA for a given guest
@@ -1504,6 +1511,26 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
  */
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
 
+/**
+ * kvm_gpc_init_for_vcpu - initialize gfn_to_pfn_cache for pin/unpin usage
+ *
+ * @gpc:        struct gfn_to_pfn_cache object.
+ * @vcpu:       vCPU that will pin and directly access this cache.
+ * @req:        request to send when cache is invalidated while pinned.
+ *
+ * This sets up a gfn_to_pfn_cache for use by a vCPU that will directly access
+ * the cached physical address. When the cache is invalidated while pinned,
+ * the specified request will be sent to the associated vCPU to force cache
+ * refresh.
+ *
+ * Note, the cache must be zero-allocated (or zeroed by the caller before init).
+ */
+static inline void kvm_gpc_init_for_vcpu(struct gfn_to_pfn_cache *gpc,
+					 struct kvm_vcpu *vcpu)
+{
+	__kvm_gpc_init(gpc, vcpu->kvm, vcpu);
+}
+
 static inline bool kvm_gpc_is_gpa_active(struct gfn_to_pfn_cache *gpc)
 {
 	return gpc->active && !kvm_is_error_gpa(gpc->gpa);
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..39eaed7f49fb 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -88,6 +88,7 @@ struct gfn_to_pfn_cache {
 	struct kvm_memory_slot *memslot;
 	struct kvm *kvm;
 	struct list_head list;
+	struct kvm_vcpu *vcpu;
 	rwlock_t lock;
 	struct mutex refresh_lock;
 	void *khva;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5b5b69c97665..8009fdaa4d4f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -761,7 +761,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 * mn_active_invalidate_count (see above) instead of
 	 * mmu_invalidate_in_progress.
 	 */
-	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
+	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end,
+					  hva_range.may_block);
 
 	/*
 	 * If one or more memslots were found and thus zapped, notify arch code
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..987c8324d0ef 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -58,11 +58,13 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp);
 #ifdef CONFIG_HAVE_KVM_PFNCACHE
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 				       unsigned long start,
-				       unsigned long end);
+				       unsigned long end,
+				       bool may_block);
 #else
 static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 						     unsigned long start,
-						     unsigned long end)
+						     unsigned long end,
+						     bool may_block)
 {
 }
 #endif /* HAVE_KVM_PFNCACHE */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..543466ff40a0 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -23,9 +23,11 @@
  * MMU notifier 'invalidate_range_start' hook.
  */
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
-				       unsigned long end)
+				       unsigned long end, bool may_block)
 {
+	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
 	struct gfn_to_pfn_cache *gpc;
+	bool evict_vcpus = false;
 
 	spin_lock(&kvm->gpc_lock);
 	list_for_each_entry(gpc, &kvm->gpc_list, list) {
@@ -46,8 +48,21 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 
 			write_lock_irq(&gpc->lock);
 			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-			    gpc->uhva >= start && gpc->uhva < end)
+			    gpc->uhva >= start && gpc->uhva < end) {
 				gpc->valid = false;
+
+				/*
+				 * If a guest vCPU could be using the physical address,
+				 * it needs to be forced out of guest mode.
+				 */
+				if (gpc->vcpu) {
+					if (!evict_vcpus) {
+						evict_vcpus = true;
+						bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
+					}
+					__set_bit(gpc->vcpu->vcpu_idx, vcpu_bitmap);
+				}
+			}
 			write_unlock_irq(&gpc->lock);
 			continue;
 		}
@@ -55,6 +70,27 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 		read_unlock_irq(&gpc->lock);
 	}
 	spin_unlock(&kvm->gpc_lock);
+
+	if (evict_vcpus) {
+		/*
+		 * KVM needs to ensure the vCPU is fully out of guest context
+		 * before allowing the invalidation to continue.
+		 */
+		unsigned int req = KVM_REQ_OUTSIDE_GUEST_MODE;
+		bool called;
+
+		/*
+		 * If the OOM reaper is active, then all vCPUs should have
+		 * been stopped already, so perform the request without
+		 * KVM_REQUEST_WAIT and be sad if any needed to be IPI'd.
+		 */
+		if (!may_block)
+			req &= ~KVM_REQUEST_WAIT;
+
+		called = kvm_make_vcpus_request_mask(kvm, req, vcpu_bitmap);
+
+		WARN_ON_ONCE(called && !may_block);
+	}
 }
 
 static bool kvm_gpc_is_valid_len(gpa_t gpa, unsigned long uhva,
@@ -382,7 +418,7 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
 
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
 	rwlock_init(&gpc->lock);
 	mutex_init(&gpc->refresh_lock);
@@ -391,6 +427,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->pfn = KVM_PFN_ERR_FAULT;
 	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
+	gpc->vcpu = vcpu;
 	gpc->active = gpc->valid = false;
 }
 
-- 
2.43.0


