Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27B27206F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjFBQKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjFBQJz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:09:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D710F5
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b01aa55219so22123535ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722180; x=1688314180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i16qvWrTxXmM44zqvAfMO+VQ2ZgLrONxQcP35eFduXw=;
        b=7epqj+D7b/Vs8MJCaB/Yaig4pdk6Xsa6+PhHha/KiUX7vkzJuwNVRvh/QKSBOYWOoF
         9Kl1CGagQi1DXxlGyYvTod7C6g15Jc/lvseccbcVTnZGlpUMuN85YotpNb24SiVNDe/4
         jJWg+BewppQ9iRi+5TbG/EFvPtgidVbx51XdS+ZgnSZfKoodj1WI4tk7ctB/2mpU7ujt
         5GR5L1lxyi6Yc/dQP61OizppKV4BxJWb97C2tfKTvu6BWLjF7QcXhyPnKGED9xXxbRV0
         rkKjEao0Yem9n3mVyvzo3PMl7x2joHF/KT0tNezMLtd5RxYZ9imnBCUvokvJr8Ssuvgw
         mKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722180; x=1688314180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i16qvWrTxXmM44zqvAfMO+VQ2ZgLrONxQcP35eFduXw=;
        b=XH3Hi2yEkSYh/1ZmFG5SotaPFW/NBnZlHZ8l7+GqvWapL4kEoBzwK6ZE1sIKP8Egsb
         NdjRMV1iRVjn2k52rtphfIXzM4kAcFdDJ1uwmRQiG5FQLQtKnJnc/NtyJmt3uAdwieUU
         7BWUwsQLZ9BUJZduOTj0YUeJggW5oQ4JNH8bKh8pN+pYPO8woMxcX0aLypw/OUzmLW5o
         UOwPbRZAywyi1fuVDeJmh8KezvB3KQOhgVQ19qTd99LOXd3J93+jALkp255dyBVOtHer
         pjm01Za4hRf7wEmi1/r2Bd3osHZvDbbYzqERBgBT/Q3m4aakWES7WpUaJk3ZrMribptr
         Vb6w==
X-Gm-Message-State: AC+VfDzW3nHFf+EbkC7D8t1SbWQpZq12nw5AzoCCKqirkqZMfdHLVPun
        XI+0eNKsUC40Q0QtH/KgxxSbxsf/Sjxv
X-Google-Smtp-Source: ACHHUZ50eFmYtmjd+7phpNHJVAKKYKF0b2Pf24cv0bbiOkOy3oeWBFiQvv39uMwyDgbA4q0xlnPSa5qY2vtt
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:903:3251:b0:1b0:6a10:1ba1 with SMTP id
 ji17-20020a170903325100b001b06a101ba1mr117384plb.13.1685722180001; Fri, 02
 Jun 2023 09:09:40 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:08 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-11-vipinsh@google.com>
Subject: [PATCH v2 10/16] KVM: arm64: Return -ENOENT if PTE is not valid in stage2_attr_walker
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Return -ENOENT from stage2_attr_walker for invalid PTE. Continue page
table walk if walker callback returns -ENOENT outside of the fault
handler path else terminate the walk. In fault handler path, similar to
-EAGAIN in user_mem_abort, retry guest execution.

stage2_attr_walker() is used from multiple places like, write
protection, MMU notifier callbacks, and relaxing permission during vCPU
faults. This function returns -EAGAIN for different cases:
1. When PTE is not valid.
2. When cmpxchg() fails while setting new SPTE.

For non-shared walkers, like write protection and MMU notifier, above 2
cases are just ignored by walker and it moves to the next SPTE. #2 will
never happen for non-shared walkers as they don't use cmpxchg() for
updating SPTEs.

For shared walkers, like vCPU fault handler, above 2 cases results in
walk termination.

In future commits, clear-dirty-log walker will write protect SPTEs under
MMU read lock and use shared page table walker. This will result in two
shared page table walkers type, vCPUs fault handler and clear-dirty-log,
competing with each other and sometime causing cmpxchg() failure. So,
-EAGAIN in clear-dirty-log walker due to cmpxchg() failure must be
retried. Whereas, -EAGAIN in the clear-dirty-log due to invalid SPTE
must be ignored instead of exiting as per the current logic of shared
page table walker. This is not needed for vCPU fault handler which also
runs via shared page table walker and terminates walk on getting -EAGAIN
due to invalid SPTE.

To handle all these scenarios, stage2_attr_walker must return different
error codes for invalid SPTEs and cmxchg() failure. -ENOENT for invalid
SPTE is chosen because it is not used by any other shared walker. When
clear-dirty-log will be changed to use shared page table walker, it will
be possible to differentiate cases of retrying, continuing or
terminating the walk for shared fault handler and shared
clear-dirty-log.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h |  1 +
 arch/arm64/kvm/hyp/pgtable.c         | 19 ++++++++++++-------
 arch/arm64/kvm/mmu.c                 |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 957bc20dab00..23e7e7851f1d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -720,6 +720,7 @@ int kvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * -------------|------------------|--------------
  * Non-Shared   | 0                | Continue
  * Non-Shared   | -EAGAIN          | Continue
+ * Non-Shared   | -ENOENT          | Continue
  * Non-Shared   | Any other        | Exit
  * -------------|------------------|--------------
  * Shared       | 0                | Continue
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index a3a0812b2301..bc8c5c4ac1cf 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -186,14 +186,19 @@ static bool kvm_pgtable_walk_continue(const struct kvm_pgtable_walker *walker,
 	/*
 	 * Visitor callbacks return EAGAIN when the conditions that led to a
 	 * fault are no longer reflected in the page tables due to a race to
-	 * update a PTE. In the context of a fault handler this is interpreted
-	 * as a signal to retry guest execution.
+	 * update a PTE.
 	 *
-	 * Ignore the return code altogether for walkers outside a fault handler
-	 * (e.g. write protecting a range of memory) and chug along with the
-	 * page table walk.
+	 * Callbacks can also return ENOENT when PTE which is visited is not
+	 * valid.
+	 *
+	 * In the context of a fault handler interpret these as a signal
+	 * to retry guest execution.
+	 *
+	 * Ignore these return codes altogether for walkers outside a fault
+	 * handler (e.g. write protecting a range of memory) and chug along
+	 * with the page table walk.
 	 */
-	if (r == -EAGAIN)
+	if (r == -EAGAIN || r == -ENOENT)
 		return !(walker->flags & KVM_PGTABLE_WALK_HANDLE_FAULT);
 
 	return !r;
@@ -1072,7 +1077,7 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
 
 	if (!kvm_pte_valid(ctx->old))
-		return -EAGAIN;
+		return -ENOENT;
 
 	data->level = ctx->level;
 	data->pte = pte;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1030921d89f8..356dc4131023 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1551,7 +1551,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	read_unlock(&kvm->mmu_lock);
 	kvm_set_pfn_accessed(pfn);
 	kvm_release_pfn_clean(pfn);
-	return ret != -EAGAIN ? ret : 0;
+	return (ret != -EAGAIN && ret != -ENOENT) ? ret : 0;
 }
 
 /* Resolve the access fault by making the page young again. */
-- 
2.41.0.rc0.172.g3f132b7071-goog

