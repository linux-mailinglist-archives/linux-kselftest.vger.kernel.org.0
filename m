Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6077334B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHGXCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHGXCJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:02:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D21BCC
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58440eb872aso65576777b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449306; x=1692054106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmCSN9U26XeKjtggc7A1AMQ3t040EnO1ZTd61OqRXuY=;
        b=d72qL5jaNo875D2Ttbag8JHQYT0xztiBQFBU5CxKpoNsYkmS2+1znT1q9wiJEFvc63
         +c+Avp84BYasJEda1jz758T5BmgFVY9UR451d1KAluobzBS+p1AxvdBTSy6eF/jtEbm2
         MOMjeEHA8cbVLcnuO+BfSIMApEJUigH/OETJLnHKppMM72zxbrbKCcn//LSACaAS9Vov
         95P7RI0h7cIj8D7tONzUpe9CtETOANdTi/8X497uExjXNbjmkbWvwFvfnXozz/0ccb2R
         S3YQE+WFDkENXvnJocQWdvHXkH1wbtnNpLJSq4RXbNBFh5COsIr2Jdq+OPF3tw8UgQOU
         d6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449306; x=1692054106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmCSN9U26XeKjtggc7A1AMQ3t040EnO1ZTd61OqRXuY=;
        b=hMeeWrw0wEgkSfyE3nnuWshHBUiJINjdM3BLQ2aoDEZXTCCuyr8vD5QHwkHmprlCfr
         VTv99nYnbUDytn3ibO7kK5eAA9LVukn/TLc0rORFJUgrDUAduSMcLjm9hFPowyGSnKc1
         R8w+QvkJ5On6XIO4QNDYswaUf2yZCXPr9irvZOpl/VlTA7SDFHKBJubniQyWS4OoJdcV
         AEFQFc6lUXG3LhpFpsXmsUHXjeatr8ZVuoB6pKV4BI9uiePhtHtlPD+tW/JMbWFJUKqB
         RQHM7fUfG8OEhzHDTSn7e18odne8YmXDtl/sPE4rtHyZLFcgpK6eWYV8GCwVHQaD08lJ
         OcWw==
X-Gm-Message-State: AOJu0YzUE3EJOIf11QOrUgGR3gLynSFjjtM+1pzuiV5VQRAnx44Z0gp0
        XVs9IPjiMz/gWdn9zQoqBbeuAg9Dg8qncSajkA==
X-Google-Smtp-Source: AGHT+IExjc0x98FZmfGU4JNmMPoNaPHSdSedyqNJXW+Jgjfi29x9X+b9Rq+BbC+BOMnbjOvbXPm6IhRLXHIT9Zp4IQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:add3:0:b0:d05:7ba4:67f9 with SMTP
 id d19-20020a25add3000000b00d057ba467f9mr57902ybe.3.1691449306075; Mon, 07
 Aug 2023 16:01:46 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:12 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <a3d025e75df68558dcd8a12656772c27c4a36f97.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 09/11] KVM: x86: Handle moving of memory context for
 intra-host migration
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com,
        Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Migration of memory context involves moving lpage_info and
mem_attr_array from source to destination VM.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c       | 110 +++++++++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  17 ++++++
 virt/kvm/guest_mem.c     |  25 +++++++++
 3 files changed, 152 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1a28dd77b94..12688754c556 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4402,6 +4402,33 @@ void kvm_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
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
@@ -6325,6 +6352,78 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
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
@@ -6351,6 +6450,14 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
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
 	 * encryption context should be supported.
@@ -6360,6 +6467,9 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
 	}
 
+out_unlock_memslots:
+	kvm_unlock_vm_memslots(kvm, source_kvm);
+out_unlock:
 	kvm_unlock_two_vms(kvm, source_kvm);
 out_mark_migration_done:
 	kvm_mark_migration_done(kvm, source_kvm);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3e03eeca279f..2f44b5d294a8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1144,6 +1144,15 @@ static inline bool kvm_memslot_iter_is_valid(struct kvm_memslot_iter *iter, gfn_
 	     kvm_memslot_iter_is_valid(iter, end);			\
 	     kvm_memslot_iter_next(iter))
 
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
@@ -2359,6 +2368,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #ifdef CONFIG_KVM_PRIVATE_MEM
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 			      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
+bool kvm_gmem_params_match(struct kvm_memory_slot *slot1,
+			   struct kvm_memory_slot *slot2);
 #else
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
@@ -2367,6 +2378,12 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 	KVM_BUG_ON(1, kvm);
 	return -EIO;
 }
+
+static inline bool kvm_gmem_params_match(struct kvm_memory_slot *slot1,
+					 struct kvm_memory_slot *slot2)
+{
+	return false;
+}
 #endif /* CONFIG_KVM_PRIVATE_MEM */
 
 #endif
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 1b3df273f785..2f84e5c67942 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -686,6 +686,31 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
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
 static int kvm_gmem_init_fs_context(struct fs_context *fc)
 {
 	if (!init_pseudo(fc, GUEST_MEMORY_MAGIC))
-- 
2.41.0.640.ga95def55d0-goog

