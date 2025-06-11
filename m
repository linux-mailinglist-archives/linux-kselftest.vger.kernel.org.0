Return-Path: <linux-kselftest+bounces-34763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C943AD60F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9013AB451
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E48248F44;
	Wed, 11 Jun 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtB1acE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659F2472B6
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676624; cv=none; b=a+rJsDDClzviOeeaaOJHxGnwk8fHG6eEaCYlk7XXmrQVWxr3A/oxhDvKDniJ3Aocadj01gAtEF4GWdSxJIFC5bfi9OuoJQQhDXUn2SOdiEMEFWBtRJBFSHMPoMQyrHIN3hwA9Q73XGbElPzLMH/R1A7LdQyi7m7W16Wm2TvD5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676624; c=relaxed/simple;
	bh=23eEzMfMOXF7V+bWkGGPvYl3Tz385egAD6gxjflsMOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxCHLxCUI5NiZYWkOuF2XilotOeFKi9MW137Odvf1NyRdDFaLdOQxqwAJimAUCAE2rZBr6K+eQK9kG63PF5DYAaRhOm/lmnqBdI+zEDOcJtU5LPH51PEXO79rnAJNDtaYUDka+tyllPPnSnAR+AzXVSLr40v+U2wlIgGNbcXn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtB1acE6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so3387545ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676622; x=1750281422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeeVbKpBN3tx4HaouiCrmDPq5kK6kn8OwuY8SLpOHLs=;
        b=XtB1acE6yjL3I9NFyGCi6BYqW5VF0TzWICdBJCaWrTIweyMGIEavO6DhZQhBZkW8GN
         786v4e9GuoOBRbsWWukwctYitSaiboVz/g9ey/7nvWZdUf9A73r1NzG0OuTsaWze0ci/
         2uSGrvblLTyRME7FgeaE70AdV0c/+zbTK0ogfcXscUemWAkRubi0wEqZIu8Uw+Sd7rDJ
         HhAxEe5kGoJD0ew12TqXBWIL3UNK9RJj+Bd4YRSFavUK/CClwPizZHgDeoEz9a59jur0
         hbrwGNn7dJNWbzqe390gjZCLv8yuzvmcraRo5R12sd3BxZK6AGaOo/rcnIISN1D3RTAZ
         H3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676622; x=1750281422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeeVbKpBN3tx4HaouiCrmDPq5kK6kn8OwuY8SLpOHLs=;
        b=UYQFkEo6pPK4kDw7vbU7aDHC3/Vki9p4Gh5fu8DArFv6/4j4CYM2H66VgRLc0s7ywZ
         Mkl/Kj1ynsW+zZVtggg0uo72HAgApXsOPNXNu5o0JheWbxiGoJdf5tO4q7dp6elXh3yU
         gEQ56VKsiD8sI4/aH6V3g07R2SWyWai8yjOfU39jns31n4gHVa+JB0357VGFiGF6BTzU
         cNDLjTk41jXhhj0be+Xg0pLmRmLgfov7oKYJYnrv0+DkCz94P/bGG27Fs7swcH7/nFy5
         zZXAOvKJcnp7M9vEmtlKqAnMmhaitGp6Q4VkZEy4xRW5wYPz7oG21j6v7+wM/TLE9oSe
         cUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWstujiZdm1X40EuxezobCBysz3xbLsp25TAo1y+zCmtERamr4AmfXMA8pQMUOcq1Q0Ojgqy0HRpti7Jqhjy3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3khL/7QYyjx1oqBC69noCvD4juef5rSMUt2jyTr4yt1o9X7SX
	g9gXNTOkhhivsHxAOQjYfm/Sakjz7O3ar4pVmvDqqkK+++7Uv7vqFBH8K12pdnmNTZl0E3SQVUc
	lLH+I0DWgHg==
X-Google-Smtp-Source: AGHT+IE5WV553GbkZv8fO1P4XOmH7RTOhAm37uG1sjPoDpJHdYSQZ79D7+wj8i1Ji8ZCsjPC1Fa02a37Bbim
X-Received: from pjbqo13.prod.google.com ([2002:a17:90b:3dcd:b0:311:a4ee:7c3d])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c5:b0:234:8ec1:4ad3
 with SMTP id d9443c01a7336-23641b291acmr69887485ad.40.1749676622084; Wed, 11
 Jun 2025 14:17:02 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:31 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <c55c9b7099cbb646d63803110889ddeddf4c370f.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 04/10] KVM: TDX: Implement moving mirror pages between
 2 TDs
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sagi Shahar <sagis@google.com>

Added functionality for moving the mirror EPT table from one TD to a new
one.

This function moves the root of the mirror EPT table and overwrites the
root of the destination.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/kvm/mmu.h         |  2 ++
 arch/x86/kvm/mmu/mmu.c     | 66 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c | 61 ++++++++++++++++++++++++++++++++---
 arch/x86/kvm/mmu/tdp_mmu.h |  6 ++++
 4 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b4b6860ab971..b43d770daa05 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -102,6 +102,8 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu);
 void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu);
 void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 			 int bytes);
+int kvm_mmu_move_mirror_pages_from(struct kvm_vcpu *vcpu,
+				   struct kvm_vcpu *src_vcpu);
 
 static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cbc84c6abc2e..09c1892e0ac1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3943,6 +3943,72 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 	return r;
 }
 
+int kvm_mmu_move_mirror_pages_from(struct kvm_vcpu *vcpu,
+				   struct kvm_vcpu *src_vcpu)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_mmu *src_mmu = src_vcpu->arch.mmu;
+	gfn_t gfn_shared = kvm_gfn_direct_bits(vcpu->kvm);
+	hpa_t mirror_root_hpa;
+	int r = -EINVAL;
+
+	if (!gfn_shared)
+		return r;
+
+	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->root_role.direct);
+	if (r)
+		return r;
+
+	/* Hold locks for both src and dst. Always take the src lock first. */
+	read_lock(&src_vcpu->kvm->mmu_lock);
+	write_lock_nested(&vcpu->kvm->mmu_lock, SINGLE_DEPTH_NESTING);
+
+	WARN_ON_ONCE(!is_tdp_mmu_active(vcpu));
+	WARN_ON_ONCE(!is_tdp_mmu_active(src_vcpu));
+
+	/*
+	 * The mirror root is moved from the src to the dst and is marked as
+	 * invalid in the src.
+	 */
+	mirror_root_hpa = kvm_tdp_mmu_move_mirror_pages_from(vcpu, src_vcpu);
+	if (mirror_root_hpa == INVALID_PAGE) {
+		struct kvm_mmu_page *mirror_root;
+		union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
+
+		/*
+		 * This likely means that the mirror root was already moved by
+		 * another vCPU.
+		 */
+		role.is_mirror = true;
+		mirror_root = kvm_tdp_mmu_get_vcpu_root(vcpu, role);
+		if (!mirror_root) {
+			r = -EINVAL;
+			goto out_unlock;
+		}
+		mirror_root_hpa = __pa(mirror_root->spt);
+	}
+
+	mmu->mirror_root_hpa = mirror_root_hpa;
+	mmu_free_root_page(src_vcpu->kvm, &src_mmu->mirror_root_hpa, NULL);
+	write_unlock(&vcpu->kvm->mmu_lock);
+	read_unlock(&src_vcpu->kvm->mmu_lock);
+
+	/* The direct root is allocated normally and is not moved from src. */
+	kvm_tdp_mmu_alloc_root(vcpu, false);
+
+	kvm_mmu_load_pgd(vcpu);
+	kvm_x86_call(flush_tlb_current)(vcpu);
+
+	return r;
+
+out_unlock:
+	write_unlock(&vcpu->kvm->mmu_lock);
+	read_unlock(&src_vcpu->kvm->mmu_lock);
+
+	return r;
+}
+EXPORT_SYMBOL(kvm_mmu_move_mirror_pages_from);
+
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 115af5e4c5ed..212716ab7e8b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -251,6 +251,22 @@ static void tdp_mmu_init_child_sp(struct kvm_mmu_page *child_sp,
 	tdp_mmu_init_sp(child_sp, iter->sptep, iter->gfn, role);
 }
 
+struct kvm_mmu_page *
+kvm_tdp_mmu_get_vcpu_root(struct kvm_vcpu *vcpu,
+			  union kvm_mmu_page_role role)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_mmu_page *root;
+
+	lockdep_assert_held(&kvm->mmu_lock);
+	list_for_each_entry(root, &kvm->arch.tdp_mmu_roots, link) {
+		if (root->role.word == role.word &&
+		    !WARN_ON_ONCE(!kvm_tdp_mmu_get_root(root)))
+			return root;
+	}
+	return NULL;
+}
+
 void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
@@ -285,11 +301,9 @@ void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
 	 * fails, as the last reference to a root can only be put *after* the
 	 * root has been invalidated, which requires holding mmu_lock for write.
 	 */
-	list_for_each_entry(root, &kvm->arch.tdp_mmu_roots, link) {
-		if (root->role.word == role.word &&
-		    !WARN_ON_ONCE(!kvm_tdp_mmu_get_root(root)))
-			goto out_spin_unlock;
-	}
+	root = kvm_tdp_mmu_get_vcpu_root(vcpu, role);
+	if (!!root)
+		goto out_spin_unlock;
 
 	root = tdp_mmu_alloc_sp(vcpu);
 	tdp_mmu_init_sp(root, NULL, 0, role);
@@ -321,6 +335,43 @@ void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
 	}
 }
 
+hpa_t kvm_tdp_mmu_move_mirror_pages_from(struct kvm_vcpu *vcpu,
+					 struct kvm_vcpu *src_vcpu)
+{
+	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm *src_kvm = src_vcpu->kvm;
+	struct kvm_mmu_page *mirror_root = NULL;
+	s64 num_mirror_pages, old;
+
+	lockdep_assert_held_read(&src_vcpu->kvm->mmu_lock);
+	lockdep_assert_held_write(&vcpu->kvm->mmu_lock);
+
+	/* Find the mirror root of the source. */
+	role.is_mirror = true;
+	mirror_root = kvm_tdp_mmu_get_vcpu_root(src_vcpu, role);
+	if (!mirror_root)
+		return INVALID_PAGE;
+
+	/* Remove the mirror root from the src kvm and add it to dst kvm. */
+	spin_lock(&src_vcpu->kvm->arch.tdp_mmu_pages_lock);
+	list_del_rcu(&mirror_root->link);
+	spin_unlock(&src_vcpu->kvm->arch.tdp_mmu_pages_lock);
+
+	/* The destination holds a write lock so no spin_lock required. */
+	list_add_rcu(&mirror_root->link, &kvm->arch.tdp_mmu_roots);
+
+#ifdef CONFIG_KVM_PROVE_MMU
+	num_mirror_pages = atomic64_read(&src_kvm->arch.tdp_mirror_mmu_pages);
+	old = atomic64_cmpxchg(&kvm->arch.tdp_mirror_mmu_pages, 0,
+			       num_mirror_pages);
+	/* The destination VM should have no mirror pages at this point. */
+	WARN_ON(old);
+	atomic64_set(&src_kvm->arch.tdp_mirror_mmu_pages, 0);
+#endif
+	return __pa(mirror_root->spt);
+}
+
 static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				u64 old_spte, u64 new_spte, int level,
 				bool shared);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 52acf99d40a0..abb1a84d8b1c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -63,6 +63,12 @@ static inline struct kvm_mmu_page *tdp_mmu_get_root(struct kvm_vcpu *vcpu,
 	return root_to_sp(vcpu->arch.mmu->root.hpa);
 }
 
+struct kvm_mmu_page *
+kvm_tdp_mmu_get_vcpu_root(struct kvm_vcpu *vcpu,
+			  union kvm_mmu_page_role role);
+hpa_t kvm_tdp_mmu_move_mirror_pages_from(struct kvm_vcpu *vcpu,
+					  struct kvm_vcpu *src_vcpu);
+
 bool kvm_tdp_mmu_zap_leafs(struct kvm *kvm, gfn_t start, gfn_t end, bool flush);
 bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp);
 void kvm_tdp_mmu_zap_all(struct kvm *kvm);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


