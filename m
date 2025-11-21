Return-Path: <linux-kselftest+bounces-46211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A6C78B0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D7F04E9EDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD4348454;
	Fri, 21 Nov 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNNKsIpC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAC346E71
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723489; cv=none; b=ummrpXpDvBMhTi8AV0r8QSt3xumfjcwqBynblMv6301GRyjL2vyf086IiucHdjyto2EuKi2L7q9VgIX3gbG8MahHB852m4PX+Hkuj/T2rAefaQve6Qh31/Sb5hYYDa7+09pq/e8MzpIRN1bAD+PRYJZjCQh6qC+Suqaj3kg2JPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723489; c=relaxed/simple;
	bh=NuQn3OfYxineh0KWDf920OOndHNl13nMc1XXtPNfvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbgD6lt1LiXtNOeZZQ+qkS4BfSqtt6Ciyh/ALPXRHH4vA0yV9C61+A6rFSPwaI+2vqe5gQw8o9pPi8DegvmvJOeYzp+JpGq/5lULawOIdL8b3pwOQJmAUulPDDhA2KY1NbdNVh45M92SBJhBbabc5ZP8wlWegd4EV44ud1U3zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNNKsIpC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2dc17965so1808167f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 03:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723486; x=1764328286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/+N5QsX2rcNo+FLul8FJV25DAtd4OsYln3zlGw8aLQ=;
        b=gNNKsIpCGs0ulvRAZXWJ+salB/54cCkF4H7Odzj1875RWLcbmacLB9ip5qqsDTGKgx
         oDveFtmlH4eSZlHBjmfXBJ7mfgUXNm/Ih3HGMVrqPu4x3UDNU/UL5nquACHF35d5dhNz
         7kFnwckSUIKpe8+lfdnEAIfFCZA5rA3bCKN9gaiYjMSqlrlHqUILVLhoPHL+pfzFQwAh
         HgbEacCFjO83PPOqx3ku+9CnVEgID8qJ8dqXBpno93gKsToXdIgWMj1CcYLDMIn9XqcX
         dTvlFolFXrZZQwyNXJPBmwY9YHpRr8k7trIpRKPSPfyWZ1zJvyHZp9jS9TOvyyR6vpFK
         WKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723486; x=1764328286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/+N5QsX2rcNo+FLul8FJV25DAtd4OsYln3zlGw8aLQ=;
        b=PgPtc9nJfe3016n37YxGWg5T1onPT/T1YMdW9YV0Xeh1aP8rp5x7nT+F/5M2WR4O7D
         BFEDYwcWSiwZmq68WgAOm5L8wT0xjDfCtp/UXXYMf9p2JDcCfeNK9/oHggfS7kiXyUQ8
         4ky3LWNIRgzDtRoKg1kFc38pIsekAOYW9+LQhHKQPJDwjbX7o8IjemNj7ZbuDXFObg7Z
         bWA2sG+QkzGBoZpz99MAGzsISxslWm+j4LZI4rIx4grazmdjBkWoDw/D25N9HfIRoiYp
         tl2qAZSo7b7z6FyIi8U3lzD/arLXA6ygho3wY7Zf1XwEi+TK2LChe1Hb345Qc/lrN0FP
         YT3w==
X-Forwarded-Encrypted: i=1; AJvYcCXY7aEcgb2vBDOPb66+yVTHtdaekWWA5wKGkaKOTG0jr7ivUHS66ZlpzOYUKFDZ9TX767J5d30XIEwDF5QF2b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRDFKGlfuidWi1pGiKJaJg8ibVOkDy/LdHtdYjDYRYM5ozwk8
	11CCUsw12D46llV/kU8Z9b3sXg1MwnD2arHf1T9YZYwDpRCG+qEx1egc
X-Gm-Gg: ASbGncuBvgr56Y4rl2KnF2G0hLZncZy5CXy6gGQRWTjOfrf3C73n5HM1M0S7zFvLunr
	7AKKF837DPf8LqJb3pp8Sf/C43V1GqL/Et56c+Yj/a2Q3KRtw+uVd84hUG6m0FTo0VPoJfUVH9L
	23dUWp06gw9UZYTXwHS78CVIdb7ZbqnV7h6FxbSHF3Wv/ei4ygpksueNL3L962Usg8UeOq3O7NH
	Oe89Tv2grzmIhV9exjgZQmJOzpalDMzY9nwQ6sI9iI8aPm2+XPZhLHuUkjh7yETZzicylgPLJow
	YHO/tbJWvPDZGpXfH0yZgGJsWkTuCKvlip3QiR/0bpHIT3NeUdbezhMuRuh5l+2TPqEk1RN8lB7
	CW2l0teztZWQ1Zb0qB/FX8RJLoQQWmo0Ro0IVpORxXDU9ha3smIB81slGHm453DZ0YDjYPwzEuU
	v+umFM+9pK7wwM9xFLDQ18wh3pAHjIflv3xmxRmB4Nb4/LpgDz56zTt9GlQKM3jonuJVgQQu8/A
	0LxowdvAihz0shKlzABTONG/up27c6+
X-Google-Smtp-Source: AGHT+IE04GkdDWbSoxK4nXnivsbovEmPBdGfBxOvSa2BVNcTZwUMEgj+UKflNwgV9u/2RIjRITxxBg==
X-Received: by 2002:a5d:5f95:0:b0:42b:52c4:663a with SMTP id ffacd0b85a97d-42cc1ac9d17mr1913155f8f.11.1763723485380;
        Fri, 21 Nov 2025 03:11:25 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm10484180f8f.12.2025.11.21.03.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:11:25 -0800 (PST)
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
Subject: [PATCH v3 02/10] KVM: pfncache: Restore guest-uses-pfn support
Date: Fri, 21 Nov 2025 11:11:05 +0000
Message-ID: <20251121111113.456628-3-griffoul@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121111113.456628-1-griffoul@gmail.com>
References: <20251121111113.456628-1-griffoul@gmail.com>
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
index 19b8c4bebb9c..6253cf1c38c1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1402,6 +1402,9 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 			 unsigned long len);
 void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    struct kvm_vcpu *vcpu);
+
 /**
  * kvm_gpc_init - initialize gfn_to_pfn_cache.
  *
@@ -1412,7 +1415,11 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
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
@@ -1494,6 +1501,26 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
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
index 490464c205b4..445170ea23e4 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -74,6 +74,7 @@ struct gfn_to_pfn_cache {
 	struct kvm_memory_slot *memslot;
 	struct kvm *kvm;
 	struct list_head list;
+	struct kvm_vcpu *vcpu;
 	rwlock_t lock;
 	struct mutex refresh_lock;
 	void *khva;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 226faeaa8e56..88de1eac5baf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -760,7 +760,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	 * mn_active_invalidate_count (see above) instead of
 	 * mmu_invalidate_in_progress.
 	 */
-	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
+	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end,
+					  hva_range.may_block);
 
 	/*
 	 * If one or more memslots were found and thus zapped, notify arch code
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 31defb08ccba..f1ba02084bd9 100644
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


