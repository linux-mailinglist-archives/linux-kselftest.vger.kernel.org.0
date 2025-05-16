Return-Path: <linux-kselftest+bounces-33220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA3ABA3A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6CF507BE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658A9283689;
	Fri, 16 May 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ib356kUe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866428312C
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423207; cv=none; b=AvuFQehDfYUVzPtoXX0vhvCBIMW6Fd0Nu3f2ImefTdJmXVJdaetYbtf8DgqmuRyyXJwLCkbiO12KR9cz+9Y6fKI7nZzNTk6KDsiRurwxBaifJ7HQuWwTSy8717knCgn6ILB8/2xEMPEntFzG4L3a2v/XsAwe8KoyFz7vycApBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423207; c=relaxed/simple;
	bh=PJwIKr9/FUWqaO/m70ZkKnN0L9kCQe8nUiK6kBAipNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=huK3l+WDU4uTF00Jzcr9fj0QG91A8fhY5MVxAPH30JA88tcuhUbZmzvp4S22ClYpXhubzKUwbDUxtf+eItcNVXgeRubDkY1MGwFxtSUu8x9EGA/irh55wnP0zH6i8eJGOlfalq92yesDBUZXr/RNDmXtpXuFY5dBEQ1zij0su+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ib356kUe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e78145dc4so1778276a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423205; x=1748028005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvUe9DtS12CRd8R+tPT1Oi+Tlg1Y+CwC86YQZiCNiXs=;
        b=Ib356kUeUqXhHziBuwxaxvwfXjV2q9RShSK7l8Rwt1BWL0h5yNLVVuuGEcaGAB6FaI
         ZmtCyr/MGhvZoKJc8ekH/RFkuwguLoLKaHzgMugbElTI31uPzRVbsjGQVMqewYcAMSZc
         8Kqbi7AB15FDZRzOTX/GgpL4zbNz0bIfowEACjqXcZ1l5eJRgxGu+GLZf/BG290fX0EE
         PksJ42ARCQQfHS1CewmZLPemZt69XUTdK3TzTimVYc0Y+Ok7B9GnI2knVsoQ4uGz6pis
         9u/5r9ck9oiv4Teep+PFbulRFuPWLEA0wpF7me5ON97/2pW+RTid94OQK+TvxiDMxxQX
         x/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423205; x=1748028005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvUe9DtS12CRd8R+tPT1Oi+Tlg1Y+CwC86YQZiCNiXs=;
        b=fztAoX3BBqRhTJWjMSikLCVeUgt2+2jpQ1wQ1I9Yl35rqdkbSYYG6icBrFDSD61H8J
         w+z2hm1bMCL4WNZhPoig9ZWzj4lNiL+PJJGPZbABPb6IRxc7UF55+0+mI7ec/xqrVqby
         sn869K6jj0n20B/G2D14IErks+5SLdMFNNryM4DSjU6o++mL8xlBxI7pL3bLszAZ88sz
         1bBzMi/yY7nX5fC44YvMiBbgYgnMSpdu13oCX86dIVnRfEIrn9CKozsmmqJ4G7yblqCT
         JJuxbw5NoEUavMlHZukdnTWIEFtOUovWBPpxBiwoCeIglHW1S0WF/Cb1TQo7f81XlC/n
         negg==
X-Forwarded-Encrypted: i=1; AJvYcCX3nUhnKxAEd3HGMllEyb0dpGRwUIscWoKaYQFRms7s25rK45pOpejJsUm3DvhFi6W02FGjdwpquWhRkMFhxws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/fZBU0Rixg4W9GUKoFlqtC+LvEDluSHQa9AuBHn/O6Z4yIWU
	u2vzXS68HV10uYNzNY2prJ6zwLZRHy212WpaPZPsggtBUhGPdo3asrP3taq1B7SLqnbWuZjBMWM
	GyH8s3y7YZw==
X-Google-Smtp-Source: AGHT+IFe7wb4jKDnCBfjN1IPr6GM/6UYnn4ThD1t1Bl8AbwTaMAWMava3PN/z1prmrpDxfzbHRStPUVZPwkp
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2fc:2ee0:d38a])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d83:b0:30e:9349:2da4
 with SMTP id 98e67ed59e1d1-30e934931cbmr3770525a91.12.1747423204953; Fri, 16
 May 2025 12:20:04 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:31 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <50e8f0950e00ec11385e5ce26764f95db80a973a.1747368093.git.afranji@google.com>
Subject: [RFC PATCH v2 11/13] KVM: x86: Handle moving of memory context for
 intra-host migration
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Migration of memory context involves moving lpage_info and
mem_attr_array from source to destination VM.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/kvm/x86.c       | 110 +++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  17 ++++++
 virt/kvm/guest_memfd.c   |  25 +++++++++
 3 files changed, 152 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3a7e05c47aa8..887702781465 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4564,6 +4564,33 @@ void kvm_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_unlock_two_vms);
 
+static int kvm_lock_vm_memslots(struct kvm *dst_kvm, struct kvm *src_kvm)
+{
+	int r = -EINVAL;
+
+	if (dst_kvm == src_kvm)
+		return r;
+
+	r = -EINTR;
+	if (mutex_lock_killable(&dst_kvm->slots_lock))
+		return r;
+
+	if (mutex_lock_killable_nested(&src_kvm->slots_lock, SINGLE_DEPTH_NESTING))
+		goto unlock_dst;
+
+	return 0;
+
+unlock_dst:
+	mutex_unlock(&dst_kvm->slots_lock);
+	return r;
+}
+
+static void kvm_unlock_vm_memslots(struct kvm *dst_kvm, struct kvm *src_kvm)
+{
+	mutex_unlock(&src_kvm->slots_lock);
+	mutex_unlock(&dst_kvm->slots_lock);
+}
+
 /*
  * Read or write a bunch of msrs. All parameters are kernel addresses.
  *
@@ -6597,6 +6624,78 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 	return 0;
 }
 
+static bool memslot_configurations_match(struct kvm_memslots *src_slots,
+					 struct kvm_memslots *dst_slots)
+{
+	struct kvm_memslot_iter src_iter;
+	struct kvm_memslot_iter dst_iter;
+
+	kvm_for_each_memslot_pair(&src_iter, src_slots, &dst_iter, dst_slots) {
+		if (src_iter.slot->base_gfn != dst_iter.slot->base_gfn ||
+		    src_iter.slot->npages != dst_iter.slot->npages ||
+		    src_iter.slot->flags != dst_iter.slot->flags)
+			return false;
+
+		if (kvm_slot_can_be_private(dst_iter.slot) &&
+		    !kvm_gmem_params_match(src_iter.slot, dst_iter.slot))
+			return false;
+	}
+
+	/* There should be no more nodes to iterate if configurations match */
+	return !src_iter.node && !dst_iter.node;
+}
+
+static int kvm_move_memory_ctxt_from(struct kvm *dst, struct kvm *src)
+{
+	struct kvm_memslot_iter src_iter;
+	struct kvm_memslot_iter dst_iter;
+	struct kvm_memslots *src_slots, *dst_slots;
+	int i;
+
+	/* TODO: Do we also need to check consistency for as_id == SMM? */
+	src_slots = __kvm_memslots(src, 0);
+	dst_slots = __kvm_memslots(dst, 0);
+
+	if (!memslot_configurations_match(src_slots, dst_slots))
+		return -EINVAL;
+
+	/*
+	 * Transferring lpage_info is an optimization, lpage_info can be rebuilt
+	 * by the destination VM.
+	 */
+	kvm_for_each_memslot_pair(&src_iter, src_slots, &dst_iter, dst_slots) {
+		for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
+			unsigned long ugfn = dst_iter.slot->userspace_addr >> PAGE_SHIFT;
+			int level = i + 1;
+
+			/*
+			 * If the gfn and userspace address are not aligned wrt each
+			 * other, skip migrating lpage_info.
+			 */
+			if ((dst_iter.slot->base_gfn ^ ugfn) &
+				(KVM_PAGES_PER_HPAGE(level) - 1))
+				continue;
+
+			kvfree(dst_iter.slot->arch.lpage_info[i - 1]);
+			dst_iter.slot->arch.lpage_info[i - 1] =
+				src_iter.slot->arch.lpage_info[i - 1];
+			src_iter.slot->arch.lpage_info[i - 1] = NULL;
+		}
+	}
+
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	/*
+	 * For VMs that don't use private memory, this will just be moving an
+	 * empty xarray pointer.
+	 */
+	dst->mem_attr_array.xa_head = src->mem_attr_array.xa_head;
+	src->mem_attr_array.xa_head = NULL;
+#endif
+
+	kvm_vm_dead(src);
+	return 0;
+}
+
 static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
 	int r;
@@ -6624,6 +6723,14 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (r)
 		goto out_mark_migration_done;
 
+	r = kvm_lock_vm_memslots(kvm, source_kvm);
+	if (r)
+		goto out_unlock;
+
+	r = kvm_move_memory_ctxt_from(kvm, source_kvm);
+	if (r)
+		goto out_unlock_memslots;
+
 	/*
 	 * Different types of VMs will allow userspace to define if moving
 	 * encryption context should be required.
@@ -6633,6 +6740,9 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		r = kvm_x86_call(vm_move_enc_context_from)(kvm, source_kvm);
 	}
 
+out_unlock_memslots:
+	kvm_unlock_vm_memslots(kvm, source_kvm);
+out_unlock:
 	kvm_unlock_two_vms(kvm, source_kvm);
 out_mark_migration_done:
 	kvm_mark_migration_done(kvm, source_kvm);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0c1d637a6e7d..99abe9879856 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1197,6 +1197,16 @@ struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
 struct kvm_memslots *kvm_vcpu_memslots(struct kvm_vcpu *vcpu);
 struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn);
 
+
+/* Iterate over a pair of memslots in gfn order until one of the trees end */
+#define kvm_for_each_memslot_pair(iter1, slots1, iter2, slots2)		\
+	for (kvm_memslot_iter_start(iter1, slots1, 0),			\
+		     kvm_memslot_iter_start(iter2, slots2, 0);		\
+	     kvm_memslot_iter_is_valid(iter1, U64_MAX) &&		\
+		     kvm_memslot_iter_is_valid(iter2, U64_MAX);		\
+	     kvm_memslot_iter_next(iter1),				\
+		     kvm_memslot_iter_next(iter2))
+
 /*
  * KVM_SET_USER_MEMORY_REGION ioctl allows the following operations:
  * - create a new memory slot
@@ -2521,6 +2531,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
 		     int *max_order);
+bool kvm_gmem_params_match(struct kvm_memory_slot *slot1,
+			   struct kvm_memory_slot *slot2);
 #else
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
@@ -2530,6 +2542,11 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 	KVM_BUG_ON(1, kvm);
 	return -EIO;
 }
+static inline bool kvm_gmem_params_match(struct kvm_memory_slot *slot1,
+					 struct kvm_memory_slot *slot2)
+{
+		return false;
+}
 #endif /* CONFIG_KVM_PRIVATE_MEM */
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d76bd1119198..1a4198c4a4dd 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -778,6 +778,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
+bool kvm_gmem_params_match(struct kvm_memory_slot *slot1,
+			   struct kvm_memory_slot *slot2)
+{
+	bool ret;
+	struct file *file1;
+	struct file *file2;
+
+	if (slot1->gmem.pgoff != slot2->gmem.pgoff)
+		return false;
+
+	file1 = kvm_gmem_get_file(slot1);
+	file2 = kvm_gmem_get_file(slot2);
+
+	ret = (file1 && file2 &&
+	       file_inode(file1) == file_inode(file2));
+
+	if (file1)
+		fput(file1);
+	if (file2)
+		fput(file2);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_params_match);
+
 #ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
-- 
2.49.0.1101.gccaa498523-goog


