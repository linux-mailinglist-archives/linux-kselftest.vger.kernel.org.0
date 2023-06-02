Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F7720714
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjFBQLD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbjFBQKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:10:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559810CC
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:10:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb1e332f648so2298625276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722186; x=1688314186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiQKR5r12cEmfxEtqKB501qQ7U5/inaqlNqkSHrg1Dk=;
        b=pa3mVvglr9ldo0oASWJgWygRLd3hw8lG1pjLeB+Qzm3K3zOU5BQU88aja7wxcgPXwA
         AwayadZx6shxLAXjuJFrDzlMtsvb67kGNUVBIz8jQ9pcx5Jd6BF7pMABQixgPuk47qo/
         QPSMIrvsitPTIbIvBs3Unmlez10KGpvyazPz0vuoWxeM0ddu7MUX6bOpsZv5FX/RHsfI
         ab0UhQ4BKG9ohwFpekgRN7rsQtHAtMFU2PEbvOsbX5+K7m399sRVLlUcmEJAu36XrUm4
         MIK72o4Xoc2dnSjS77GyfH7dzmpmSt4gmenJO3sxGLvRMkP8fiKXjBjSppWa9vRlnGfd
         FwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722186; x=1688314186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiQKR5r12cEmfxEtqKB501qQ7U5/inaqlNqkSHrg1Dk=;
        b=aYrlVvHaQbVQt2a5Pu0mIakWKo1fkGFjo4nRa7ssDws5xYxETxWokadjBosRxzbHdd
         UWtAERIhPGETg9GRcAx+nf0gBFzme1yqWNi/QpwDzgViFp3Dbg5dDCGplFQXO3XV0H3q
         TXG59zFtu5K81CRVIExDHimG8riDshJjXacJnenwcTZK3HS6Xd7lV1c1uhvKrphbB3qB
         6wB9Ca9FhvHwQkG5AI0Y3BneuN8bhaw/Yn3JL+X0CXB1hYL7QePKF+pAdCBComdgMf2A
         OceCAV+jeRUvHN8SkDDP32noc5IpLcKTcKTrvJzsAtMmlvHqZrMSvsBI74xSkDCfNOui
         w1TQ==
X-Gm-Message-State: AC+VfDySugFNqw0LvPrsQMwBs9bB/MYMTG+gi0499fF1MWXJFrK4YVNt
        0UUUcv6z9LlPSqKMSDJtHT5OYCt0LNyw
X-Google-Smtp-Source: ACHHUZ4B/VNE5B0Lzqq5kfdIQx5Z2vYuoQBh8/63RZRhZfWL9mTILlGstZ7p9kQje0NOJUJPGy2sE9Fs2xL/
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6902:1545:b0:ba8:181b:2558 with SMTP
 id r5-20020a056902154500b00ba8181b2558mr2255805ybu.4.1685722186031; Fri, 02
 Jun 2023 09:09:46 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:11 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-14-vipinsh@google.com>
Subject: [PATCH v2 13/16] KVM: arm64: Run clear-dirty-log under MMU read lock
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

Take MMU read lock for clearing dirty logs and use shared page table
walker.

Dirty logs are currently cleared using MMU write locks. This
means vCPUs page faults, which takes MMU read lock,  will
be blocked while dirty logs are being cleared. This causes guest
degradation and especially noticeable on VMs with lot of vCPUs.

Taking MMU read lock will allow vCPUs to execute parallelly and reduces
the impact on vCPUs performance.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/kvm/mmu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 356dc4131023..7c966f6f1a41 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -74,8 +74,12 @@ static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
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
@@ -1131,11 +1135,11 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
 	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
 
-	write_lock(&kvm->mmu_lock);
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	stage2_wp_range(&kvm->arch.mmu, start, end, 0);
+	read_lock(&kvm->mmu_lock);
+	stage2_wp_range(&kvm->arch.mmu, start, end, KVM_PGTABLE_WALK_SHARED);
+	read_unlock(&kvm->mmu_lock);
 
+	write_lock(&kvm->mmu_lock);
 	/*
 	 * Eager-splitting is done when manual-protect is set.  We
 	 * also check for initially-all-set because we can avoid
-- 
2.41.0.rc0.172.g3f132b7071-goog

