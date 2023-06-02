Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351F27206FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjFBQKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjFBQJs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:09:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6CA10CF
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba802c775caso3188863276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722176; x=1688314176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJx+yypKzd3COmz5TQWkFGxt9Sb1HD5xNFJXRHqVvy0=;
        b=szBGu+EQ2vs8Q3A0ZT1RS79FNLRJxSOVkrDrBBX7rmCKLzKn/b+E4mNymytABzCLif
         EgUFXaPy7nG7KM6jDjkYBO0vsJLxZ4XBjsoF6X75ZimJDOLxnKGoSfjvnPNLfA9vSHBD
         s9ihl+kXGelNmLHAJZYRz4+yQ+Fx6J3bT5bOlL9FOfNpgH6MN5wQNIGrZvk2XbL68tHF
         B/csW1RkKWfzpRPcNxb+4yNUfWvhAhXwGpxjibheJUkN4+CaHLLPZUdUbJv/P8pKuPN/
         Cvmf4i9nzVBBvNWz3J0YGn8SEauVZOkYjg+xhiWvEBlTBwkFZHPSrYROctUU+loxAFaS
         zjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722176; x=1688314176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJx+yypKzd3COmz5TQWkFGxt9Sb1HD5xNFJXRHqVvy0=;
        b=IctQ5Ke+24fQ3YoVWIgflLWCke1sCa8fO5Fg6hM959BwO4uJU0PGNkDiO20y+hZCiY
         cRxvYJPRtos17kBHk+WhYSEPUn18c40ab7k2Ed1CwVCM0Q5Vw9iSJsQxVDOr2SZHrd1R
         V0h70ZdH1avts8phWomv/AyPmEwNYqhzPYetmQfqYsmOxcGV4iDfZhu2Zw1CxFTwBAtk
         7DkgGsW9ALlOKtnEEY+DUDZGvKiD/B5Hbv+wOmjvbXNsqHNZAuOqDtuBB5u1fuwwlHVX
         MgZngVwqr7j10mXAIK9bu8A0uc8kCSc4e7klpi/eNInWfeIFsFTQewJWhGR5izxlWEjM
         37Mg==
X-Gm-Message-State: AC+VfDz6bZOiiwoNtNlkDBsYeioIheWANn5eWvJb4YMxIoUFYTNb8rJz
        ewO2zte7BBI/7mWJqt0usv6UtxFsQYo0
X-Google-Smtp-Source: ACHHUZ55GAWUbCX2pBxCQpbjCqZ+MgzCwRW5rUzsUOGzP4VGdNUP2AN+4xPnboHdKBOoO7J5TTwkex+IpQ+T
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6902:100a:b0:bad:600:1833 with SMTP id
 w10-20020a056902100a00b00bad06001833mr2072241ybt.0.1685722176005; Fri, 02 Jun
 2023 09:09:36 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:06 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-9-vipinsh@google.com>
Subject: [PATCH v2 08/16] KMV: arm64: Pass page table walker flags to stage2_apply_range_*()
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow stage2_apply_range_*() to accept enum kvm_pgtable_walk_flags{}
for stage 2 walkers. Pass 0 as the flag value from all of its caller
effectively making it a no-op.

Page table walker flags  will be used in future commits to enable
clear-dirty-log operation under MMU read lock.

Current users of stage2_apply_range_*() API runs under assumption of
holding MMU write lock. Stage2 page table walkers then run under the
same assumption. In future commits, when clear-dirty-log is modified to
run under MMU read lock then this flag will be used to pass shared page
walk intent.

No functional changes intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h  | 12 +++++++++---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  4 ++--
 arch/arm64/kvm/hyp/pgtable.c          | 16 ++++++++++------
 arch/arm64/kvm/mmu.c                  | 26 ++++++++++++++++----------
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d542a671c564..8ef7e8f3f054 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -560,6 +560,7 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address from which to remove the mapping.
  * @size:	Size of the mapping.
+ * @flags:	Page-table walker flags.
  *
  * The offset of @addr within a page is ignored and @size is rounded-up to
  * the next page boundary.
@@ -572,7 +573,8 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size,
+			     enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_wrprotect() - Write-protect guest stage-2 address range
@@ -580,6 +582,7 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address from which to write-protect,
  * @size:	Size of the range.
+ * @flags:	Page-table walker flags.
  *
  * The offset of @addr within a page is ignored and @size is rounded-up to
  * the next page boundary.
@@ -590,7 +593,8 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
  *
  * Return: 0 on success, negative error code on failure.
  */
-int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
+int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size,
+				 enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
@@ -662,13 +666,15 @@ bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
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
  * kvm_pgtable_stage2_split() - Split a range of huge pages into leaf PTEs pointing
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index d35e75b13ffe..13f5cf5f87c3 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -333,11 +333,11 @@ static int host_stage2_unmap_dev_all(void)
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
index 364b68013038..a3a0812b2301 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1044,12 +1044,14 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
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
+			  KVM_PGTABLE_WALK_TABLE_POST,
 	};
 
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
@@ -1128,11 +1130,12 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
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
@@ -1213,11 +1216,12 @@ static int stage2_flush_walker(const struct kvm_pgtable_visit_ctx *ctx,
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
index 0c2c2c0846f1..1030921d89f8 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -55,7 +55,9 @@ static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
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
@@ -68,7 +70,7 @@ static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
 			return -EINVAL;
 
 		next = stage2_range_addr_end(addr, end);
-		ret = fn(pgt, addr, next - addr);
+		ret = fn(pgt, addr, next - addr, flags);
 		if (ret)
 			break;
 
@@ -79,8 +81,8 @@ static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
 	return ret;
 }
 
-#define stage2_apply_range_resched(mmu, addr, end, fn)			\
-	stage2_apply_range(mmu, addr, end, fn, true)
+#define stage2_apply_range_resched(mmu, addr, end, flags, fn)		\
+	stage2_apply_range(mmu, addr, end, flags, fn, true)
 
 /*
  * Get the maximum number of page-tables pages needed to split a range
@@ -316,7 +318,7 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 	WARN_ON(size & ~PAGE_MASK);
-	WARN_ON(stage2_apply_range(mmu, start, end, kvm_pgtable_stage2_unmap,
+	WARN_ON(stage2_apply_range(mmu, start, end, 0, kvm_pgtable_stage2_unmap,
 				   may_block));
 }
 
@@ -331,7 +333,8 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	phys_addr_t addr = memslot->base_gfn << PAGE_SHIFT;
 	phys_addr_t end = addr + PAGE_SIZE * memslot->npages;
 
-	stage2_apply_range_resched(&kvm->arch.mmu, addr, end, kvm_pgtable_stage2_flush);
+	stage2_apply_range_resched(&kvm->arch.mmu, addr, end, 0,
+				   kvm_pgtable_stage2_flush);
 }
 
 /**
@@ -1041,10 +1044,13 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
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
@@ -1073,7 +1079,7 @@ static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
 
 	write_lock(&kvm->mmu_lock);
-	stage2_wp_range(&kvm->arch.mmu, start, end);
+	stage2_wp_range(&kvm->arch.mmu, start, end, 0);
 	write_unlock(&kvm->mmu_lock);
 	kvm_flush_remote_tlbs(kvm);
 }
@@ -1128,7 +1134,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	write_lock(&kvm->mmu_lock);
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	stage2_wp_range(&kvm->arch.mmu, start, end);
+	stage2_wp_range(&kvm->arch.mmu, start, end, 0);
 
 	/*
 	 * Eager-splitting is done when manual-protect is set.  We
-- 
2.41.0.rc0.172.g3f132b7071-goog

