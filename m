Return-Path: <linux-kselftest+bounces-45883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0BC6AE92
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 479C03559D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD23A9C15;
	Tue, 18 Nov 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsr/KvOk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEA03A79BE
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485886; cv=none; b=CAwcmVdO31tDedZ5PGQIJ4TK6tB6auKe9hCg8NHa3T7y09L3OL+RZchQHLkZdu3/f5CeiMUC+AtikqLBtVGMw3fQ5whBLy1pSzFoXGihIZ3ABP+SraLpuVs7qRMPRZcHJcHcgmLgqEX48idtHPoNhRixVhXcv3u8lMNrOiuy0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485886; c=relaxed/simple;
	bh=NuQn3OfYxineh0KWDf920OOndHNl13nMc1XXtPNfvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9dZMQLfhFz+7hb+cOoSdJRBdHu3wGzNqDrFCFKlRQLVwz5ObDIrnGGycHCW3hZp1b55OHT4ORChCo+Xqtx2rVgcegytViRPIoB+E47LFmic5TUIck8gTSItZMYbSTPVLitXb4w8XyTjVed2eZCufYSJ3KkuF3IJnc1niFdGUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsr/KvOk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47790b080e4so24055025e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 09:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485882; x=1764090682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/+N5QsX2rcNo+FLul8FJV25DAtd4OsYln3zlGw8aLQ=;
        b=gsr/KvOkK4dVgr6eKSsL4WCDdNej0G+7iw3SwD/LyJlX9Dl75Cc5E+tNHEHcfPICut
         rlhqVs3OtKKgvQR6gP3moIqVVVtnkOAqaPh7mwKde4D0w0TQSIGtX+nFFCpZ5CT1gwkL
         wADn6EPHw0VbBmVb4yxAzojBse7CdBjRdUeU18FbHr1GTLWqrGKVw7zNTG83uihysAgc
         nu5NlpBDsewR/MGH3SlUodMLhR3TDT4SyGwJdYxu8aTdOc7WOeDLI/A6h5871/DK4Ler
         B8rowsCtqDoMKvYBx8QzeaMFSR8enX9WbG+FDKq1F5mUri5A+LbM+IWUT+/ADMzHShTX
         dH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485882; x=1764090682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/+N5QsX2rcNo+FLul8FJV25DAtd4OsYln3zlGw8aLQ=;
        b=lHgaVifUjEWaoXi5033qmeEpOj7irdTZFYbUHHJpbkjeNtEqd7GiU3oMa8bdS0dbr3
         St1aP+183+D90UQ75YETh04SunENDXrx66KwcFRNErIXKEdL+hc+3tF1ZJ+C6Mg9TX87
         S985AGvDzp9tV2l8+Ms9BJoifZQ/FXKqrvIoZuPA2NtTRdEXa3VEE3C/qOoi3du6M7wA
         uN38jln4rVLpDG/jwtLWiNF0EKYvYyk7GHCOg6bBPDsAtZcoFQuF0xzSBnM47JIHTdgH
         CjTjyn4eOofXsa7Wgv+hhQkkfYevNVyKIjiBAWMlfyl0whptHOfdxXhlZdqZam1dY5gr
         pn9g==
X-Forwarded-Encrypted: i=1; AJvYcCXBg5Ave6uL1dW3ePLWLtsdpNVaCltHHHRZ8VFMnMc9kRKFAEQlBaiPiJdGwvQ2GXuBjqQ4YHGnLuwoYWxm9EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcMoOlwHyRl5Im+0hWa1q+BF7aTUa07QjDCPRJxUeSvZdPR8S
	Fp1eovwL31nLbjq7K3YifWBeb6Md6+y/8IHC78DpBR78npQZQADifXpj
X-Gm-Gg: ASbGnctdzwqFCxaAr5Kv7wOQgC70dfFGAodQm2lI4RPwgnmNkhcEjJAiUOPvTB9QDEm
	9R6DzG8SmQf384ENHN4M9uJ0LzcMt4KJPwN1QkwwpnNfVcmF1CHJ5G/7BIE1JEO/wdp3BCOQllE
	ccPXoO+luFwz12NVhJ5uNUoEx7OMR818ddVlog9cKzYxoKlkda0UikHZ4usgcWTwNehUHrQSmjy
	zUMCkiFJeceAKe/3NawwjeFozIGSL8oSHD5+ZBo0EyD0JoSTFarUwcMrDf192sZHhtXRtsJQ3Rr
	I7qY0IPbkFQ7c5nQqmJV8Ci9nVUaF52JvRda1u2DlSTaEtskMy9Si3UC9ptKpNNHzOwBRtbNzYb
	9vX9xVrD8LBQ3+vzluW7zcMmKSwr6CTe8u8BKouVt4ljTR9UxcRiTG/340Wcr8OR8xNOgAlH54k
	7es0OVQd6WUSEypLVJn4oqUCy+2FwDdXur9JK/0Z0YaSdM5meKFoZOHOwb4oQ1TYa6mKB5uBcqC
	acNP/Ll+7fvl9oNVKM4ZIgvDT+8rkioj3C+HPGy/sQ=
X-Google-Smtp-Source: AGHT+IHzxclG4jBwiQp70vxCA2ZAiQghW7Y5GZpasp1HpOszP3Zzx0IMeOTCiRFywIuJghT3KdWqlw==
X-Received: by 2002:a05:600c:1d16:b0:477:7c45:87b1 with SMTP id 5b1f17b1804b1-4778feb78e1mr160881775e9.36.1763485881445;
        Tue, 18 Nov 2025 09:11:21 -0800 (PST)
Received: from ip-10-0-150-200.eu-west-1.compute.internal (ec2-52-49-196-232.eu-west-1.compute.amazonaws.com. [52.49.196.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b103d312sm706385e9.13.2025.11.18.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:11:20 -0800 (PST)
From: griffoul@gmail.com
X-Google-Original-From: griffoul@gmail.org
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	vkuznets@redhat.com,
	shuah@kernel.org,
	dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: [PATCH v2 02/10] KVM: pfncache: Restore guest-uses-pfn support
Date: Tue, 18 Nov 2025 17:11:05 +0000
Message-ID: <20251118171113.363528-3-griffoul@gmail.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118171113.363528-1-griffoul@gmail.org>
References: <20251118171113.363528-1-griffoul@gmail.org>
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


