Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AA86EAFC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjDUQzP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjDUQyo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 12:54:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7AD167CC
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:54:26 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-247a8ef12d2so1362552a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682096005; x=1684688005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZkpp0Q8jjYvxCvjV0ny/+Rc/wVVpL1bL7ck4xeVhlc=;
        b=0h1fkH+Qg9TAAOhRy5ByqB0jrA5qVCSK4v4VOevyiT2ApjSQTkdNJB5NveNHYdDJyn
         UJHQdihO3xA3kzsZEepsUYjUUldoQQHE3IwikHmH626x/P3dqcuE74kUFvi/fYfmL8id
         EDHpOrTTDrdls8Ay6MgcRCV+nPsBif06WnlTwtqTPlBkRDbsQd0Ihsksz1E+BPVTlwL+
         Wr1jDKNxfs+qyRuwYH973UQwgCLkK4mXV3n/qkGEbaFtetzvIDazfRsZNp9s0jwVrFs5
         k56stUv4Ja+Quv0wmKFN8uJmrJL9UvFWW6XEpyc/9yhzn8gHY1vEcRlztKntO6uIDVGX
         jZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682096005; x=1684688005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZkpp0Q8jjYvxCvjV0ny/+Rc/wVVpL1bL7ck4xeVhlc=;
        b=abYJv7e2HEuo6AIC4PUXsaZjIWfupQV17AXy0fvry1hIg5iSaJRg8ts13OeP4as1DX
         dMlErr/XFpvPL2E43AhmdQe+hKuZwKCGC+tGDBFbNHPlp9CCMhEv/NInWvO/Tvk6//e3
         VmnEnf9zIVJwPc3LYnkGhxD+44qJYofnE+N2FefEF5V4BJyXrp77HDhjlROo00S3fbBx
         oUMXtpY76cVOPW+S1z232oT7PqjNXN5tpYiJ49UJikyrSM64PiXMsbr+zo9d51SrRtoB
         WOFk6+yi0cEHkGSrSGeHPOLRbhQioSx9LTBzD8c86vupDp3R0LoLWGp4qbsqULMQXeMZ
         EiOw==
X-Gm-Message-State: AAQBX9cQdkG3fgQKQpJMd9tyAd2TARADEPHKRcJXt3AR8139gju5cpn8
        UU2nhF3INC8LnpxbMxQRiqcTcZpr9H0b
X-Google-Smtp-Source: AKy350bDKAEiJjC/uv+A89c39cSNVyu8ADQH7b61iTn5O1CeNgQ8Eu2os+9yNYOIL6Af0Fk180jnNb9Y53o2
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:690d:b0:23f:a851:4f04 with SMTP id
 r13-20020a17090a690d00b0023fa8514f04mr1467442pjj.3.1682096004881; Fri, 21 Apr
 2023 09:53:24 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:53:05 -0700
In-Reply-To: <20230421165305.804301-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230421165305.804301-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421165305.804301-10-vipinsh@google.com>
Subject: [PATCH 9/9] KVM: arm64: Run clear-dirty-log under MMU read lock
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

Take MMU read lock for write protecting PTEs and use shared page table
walker for clearing dirty logs.

Clearing dirty logs are currently performed under MMU write locks. This
means vCPUs write protection fault, which also take MMU read lock,  will
be blocked during this operation. This causes guest degradation and
especially noticeable on VMs with lot of vCPUs.

Taking MMU read lock will allow vCPUs to execute parallelly and reduces
the impact on vCPUs performance.

Tested improvement on a ARM Ampere Altra host (64 CPUs, 256 GB
memory and single NUMA node) via dirty_log_perf_test for 48 vCPU, 96
GB memory, 8GB clear chunk size, 1 second wait between Clear-Dirty-Log
calls and configuration:

Test command:
./dirty_log_perf_test -s anonymous_hugetlb_2mb -b 2G -v 48 -l 1 -k 8G -j -m 2

Before:
Total pages touched: 50331648 (Reads: 0, Writes: 50331648)

After:
Total pages touched: 125304832 (Reads: 0, Writes: 125304832)

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/kvm/mmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index e0189cdda43d..3f2117d93998 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -67,8 +67,12 @@ static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
 		if (ret)
 			break;
 
-		if (resched && next != end)
-			cond_resched_rwlock_write(&kvm->mmu_lock);
+		if (resched && next != end) {
+			if (flags & KVM_PGTABLE_WALK_SHARED)
+				cond_resched_rwlock_read(&kvm->mmu_lock);
+			else
+				cond_resched_rwlock_write(&kvm->mmu_lock);
+		}
 	} while (addr = next, addr != end);
 
 	return ret;
@@ -994,7 +998,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
 	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
 
-	stage2_wp_range(&kvm->arch.mmu, start, end, 0);
+	stage2_wp_range(&kvm->arch.mmu, start, end, KVM_PGTABLE_WALK_SHARED);
 }
 
 /*
@@ -1008,9 +1012,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
-	write_lock(&kvm->mmu_lock);
+	read_lock(&kvm->mmu_lock);
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
-	write_unlock(&kvm->mmu_lock);
+	read_unlock(&kvm->mmu_lock);
 }
 
 static void kvm_send_hwpoison_signal(unsigned long address, short lsb)
-- 
2.40.0.634.g4ca3ef3211-goog

