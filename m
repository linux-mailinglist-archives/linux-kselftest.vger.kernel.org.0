Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522E6EAFD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjDUQ4d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjDUQ4T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 12:56:19 -0400
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB255167C9
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:55:44 -0700 (PDT)
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-63d30b08700so12914938b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682096003; x=1684688003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qC7e8besLo1ag72RTnGUdqUNToUJA9of6W+yz9oDvfY=;
        b=GOG4w3Pi6Eguql63DqPQoIqooDk2CqgiNgSILELR6uyDzdTl7Vzyy+xaIluVcSjhyC
         RvCjMUQV09KGtSZBzaSFu2ULcU3Y3JJpf5vC4vVKPaROFTvqMFHnKW7ByaMxXfk+EzAG
         99Opx1mgfDUi8BUkLeU+cbao2T7UFu79PD2joe0F54/b7N6UHkeWd9KQWvVxtVFSqqBN
         4IaiBkj2jyw7kaprKEY+F3kKrY4x7q4duJcpFclPPBqAR7WayXdFPSvh7rZW6yMWTzoe
         DS8bOW/ilapcUDSa/xMSHG8hRonLGXyfdOJIEtji0VIqlLUQKZGmAZZyv+1a4rxUZ26s
         iMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096003; x=1684688003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC7e8besLo1ag72RTnGUdqUNToUJA9of6W+yz9oDvfY=;
        b=TR1UR6dtTI+EDclhCpiquZaJbSqOMiQo07phw4k3Tn2plQPDq2cMHf+pAt7kpAEv9+
         O6dcEgtdwaENjXGAoR4oTtbYM+8z+SqfWinU6eUXA4FbwOY7VO7xIgXmxcq3IAI7A4ze
         ertyBhjR7Ycj3bFUkf2dxfsUjt0Gl2vAk32b9+mOmNuuoo2bOFjCzVuXC8cOF9vkxqko
         K9m3OaHLb84qwykH8Xy8QYzzHi+7L0KusbMrqTFl3VVEqAKPuUppRpjEVkwUoO6oRmhE
         j7+YZqzHx7wfvBrVI8TmSo5qeEWdK156M18zGvtio21hLeX1dsvO4aTcE0JRsR1mhzfS
         ncYQ==
X-Gm-Message-State: AAQBX9c1akfjP//bkMfR3a2Fncgl88tb07A5bte+93xwfNjQCjFLw9BQ
        fH0t1dzdmwJ+nu1QT4lDOATzQQvZxqAJ
X-Google-Smtp-Source: AKy350YK5qI2wTpVn2+n76a4c4LFk6EXRJamXsvoVbLWqldR9ZGNS6cWNNDnQcdFV3v/V2rDAy2uQXHrhTp1
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:a6a:b0:244:9909:6e60 with SMTP id
 o97-20020a17090a0a6a00b0024499096e60mr1346561pjo.3.1682096003103; Fri, 21 Apr
 2023 09:53:23 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:53:04 -0700
In-Reply-To: <20230421165305.804301-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230421165305.804301-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421165305.804301-9-vipinsh@google.com>
Subject: [PATCH 8/9] KMV: arm64: Allow stage2_apply_range_sched() to pass page
 table walker flags
From:   Vipin Sharma <vipinsh@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow stage2_apply_range_sched() to pass enum kvm_pgtable_walk_flags{}
to stage 2 walkers. Pass 0 as the flag to make this change no-op

This capability will be used in future commits to enable clear-dirty-log
operation under MMU read lock.

Current users of stage2_apply_range_*() API run under assumption of
holding MMU write lock. Stage2 page table walkers then run under the
same assumption. In future commits when clear-dirty-log operation under
MMU read lock is added then there needs to be a way to pass this shared
intent to page table walkers.

No functional changes intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h  | 12 +++++++++---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  4 ++--
 arch/arm64/kvm/hyp/pgtable.c          | 16 ++++++++++------
 arch/arm64/kvm/mmu.c                  | 26 ++++++++++++++++----------
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 4cd62506c198..79a452d78e08 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -508,6 +508,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address from which to remove the mapping.
  * @size:	Size of the mapping.
+ * @flags:	Page-table walker flags.
  *
  * The offset of @addr within a page is ignored and @size is rounded-up to
  * the next page boundary.
@@ -520,7 +521,8 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			     enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_wrprotect() - Write-protect guest stage-2 address range
@@ -528,6 +530,7 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address from which to write-protect,
  * @size:	Size of the range.
+ * @flags:	Page-table walker flags.
  *
  * The offset of @addr within a page is ignored and @size is rounded-up to
  * the next page boundary.
@@ -538,7 +541,8 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size,
+				 enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
@@ -610,13 +614,15 @@ bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address from which to flush.
  * @size:	Size of the range.
+ * @flags:	Page-table walker flags.
  *
  * The offset of @addr within a page is ignored and @size is rounded-up to
  * the next page boundary.
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			     enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_walk() - Walk a page-table.
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 552653fa18be..bac3c2c31cbe 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -326,11 +326,11 @@ static int host_stage2_unmap_dev_all(void)
 	/* Unmap all non-memory regions to recycle the pages */
 	for (i = 0; i < hyp_memblock_nr; i++, addr = reg->base + reg->size) {
 		reg = &hyp_memory[i];
-		ret = kvm_pgtable_stage2_unmap(pgt, addr, reg->base - addr);
+		ret = kvm_pgtable_stage2_unmap(pgt, addr, reg->base - addr, 0);
 		if (ret)
 			return ret;
 	}
-	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr);
+	return kvm_pgtable_stage2_unmap(pgt, addr, BIT(pgt->ia_bits) - addr, 0);
 }
 
 struct kvm_mem_range {
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d61bd3e591d..3a585e1fba11 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1024,12 +1024,14 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	return 0;
 }
 
-int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
+int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			     enum kvm_pgtable_walk_flags flags)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_unmap_walker,
 		.arg	= pgt,
-		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
+		.flags	= flags | KVM_PGTABLE_WALK_LEAF |
+				KVM_PGTABLE_WALK_TABLE_POST,
 	};
 
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
@@ -1108,11 +1110,12 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 	return 0;
 }
 
-int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
+int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size,
+				 enum kvm_pgtable_walk_flags flags)
 {
 	return stage2_update_leaf_attrs(pgt, addr, size, 0,
 					KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
-					NULL, NULL, 0);
+					NULL, NULL, flags);
 }
 
 kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
@@ -1193,11 +1196,12 @@ static int stage2_flush_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	return 0;
 }
 
-int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
+int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			     enum kvm_pgtable_walk_flags flags)
 {
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_flush_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= flags | KVM_PGTABLE_WALK_LEAF,
 		.arg	= pgt,
 	};
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index dc1c9059604e..e0189cdda43d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -48,7 +48,9 @@ static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
  */
 static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
 			      phys_addr_t end,
-			      int (*fn)(struct kvm_pgtable *, u64, u64),
+			      enum kvm_pgtable_walk_flags flags,
+			      int (*fn)(struct kvm_pgtable *, u64, u64,
+					enum kvm_pgtable_walk_flags),
 			      bool resched)
 {
 	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
@@ -61,7 +63,7 @@ static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
 			return -EINVAL;
 
 		next = stage2_range_addr_end(addr, end);
-		ret = fn(pgt, addr, next - addr);
+		ret = fn(pgt, addr, next - addr, flags);
 		if (ret)
 			break;
 
@@ -72,8 +74,8 @@ static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
 	return ret;
 }
 
-#define stage2_apply_range_resched(mmu, addr, end, fn)			\
-	stage2_apply_range(mmu, addr, end, fn, true)
+#define stage2_apply_range_resched(mmu, addr, end, flags, fn)		\
+	stage2_apply_range(mmu, addr, end, flags, fn, true)
 
 static bool memslot_is_logging(struct kvm_memory_slot *memslot)
 {
@@ -236,7 +238,7 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 	WARN_ON(size & ~PAGE_MASK);
-	WARN_ON(stage2_apply_range(mmu, start, end, kvm_pgtable_stage2_unmap,
+	WARN_ON(stage2_apply_range(mmu, start, end, 0, kvm_pgtable_stage2_unmap,
 				   may_block));
 }
 
@@ -251,7 +253,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
 	phys_addr_t end = addr + PAGE_SIZE * memslot->npages;
 
-	stage2_apply_range_resched(&kvm->arch.mmu, addr, end, kvm_pgtable_stage2_flush);
+	stage2_apply_range_resched(&kvm->arch.mmu, addr, end, 0,
+				   kvm_pgtable_stage2_flush);
 }
 
 /**
@@ -932,10 +935,13 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
  * @mmu:        The KVM stage-2 MMU pointer
  * @addr:	Start address of range
  * @end:	End address of range
+ * @flags:	Page-table walker flags.
  */
-static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_t end)
+static void stage2_wp_range(struct kvm_s2_mmu *mmu, phys_addr_t addr, phys_addr_t end,
+			    enum kvm_pgtable_walk_flags flags)
 {
-	stage2_apply_range_resched(mmu, addr, end, kvm_pgtable_stage2_wrprotect);
+	stage2_apply_range_resched(mmu, addr, end, flags,
+				   kvm_pgtable_stage2_wrprotect);
 }
 
 /**
@@ -964,7 +970,7 @@ static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
 
 	write_lock(&kvm->mmu_lock);
-	stage2_wp_range(&kvm->arch.mmu, start, end);
+	stage2_wp_range(&kvm->arch.mmu, start, end, 0);
 	write_unlock(&kvm->mmu_lock);
 	kvm_flush_remote_tlbs(kvm);
 }
@@ -988,7 +994,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
 	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
 
-	stage2_wp_range(&kvm->arch.mmu, start, end);
+	stage2_wp_range(&kvm->arch.mmu, start, end, 0);
 }
 
 /*
-- 
2.40.0.634.g4ca3ef3211-goog

