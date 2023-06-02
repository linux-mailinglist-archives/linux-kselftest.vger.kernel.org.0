Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342B72070E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjFBQKw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjFBQKd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:10:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD62EE67
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:57 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b04dbcf0dbso22535545ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722181; x=1688314181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rivHDhk0ioxMpP1XynwGaSZFsNZDBBbqgVAGbR7E/X8=;
        b=IxpZG4TkYuPd8UtpcDQplKJDDIpAs6lGKWZe95duADLUk5Xly6SRvjrVvCEGB/Fk1a
         E9X3IJECzkdQ25Bkjejj4IbXek6JqPY58HRA50EOI/YFTzUpFaA/bzGSlAOm+5PEvo+T
         6jKSmBS0KSmdPni70wpBlwTPrvyYGZvMtxSC3Fbri9jwwzePk7OY91lpj01vmu9g7PZn
         a5J+YN0h1Qu/z/w7ubpNpCMDwcQqYWttGGXgoLeySgwUxIZDyVDmv/3Bk/4OJqAcfD0+
         gHcpPqAo0vTPvSXpzWrIqDWuTjrALALhGQwaLZCyItTHvmVctEjS/JfpfTvctKcX+1gM
         QFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722181; x=1688314181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rivHDhk0ioxMpP1XynwGaSZFsNZDBBbqgVAGbR7E/X8=;
        b=AkJ2NT6XGQAxWPxZLLN6bRp96GFxKU9OeSVonkvpnSKf+8P7OfYy2zvZiUnpkldL4r
         FJmmC3/FPxEaHzA9id02Wi+wPUTLendOorxfi9MH7M9whhra9GRM8dRyyNTg06XBT0X5
         5Cj/AVRExFoFQmd0+2YAEk0Ww3x4855TWYDbbPVFbh8gF5sVqY9dmrowX43FcSmAJNcO
         a1kvNSBYlSBfE8QJ0tgRO4r/mKXSWDU2SPQ5Lgt1i+7ykMzj73d2DBPFtMo/tbAH8vNz
         oqLrQabCJ05cF2C07FpvXAAKF39Tp+hHz4EnjQaEEyvUkVhaYQQZEAsUxv97mDPbrGpF
         eJvQ==
X-Gm-Message-State: AC+VfDyy5/3sETjG9gYESMtqDzoVGXWX2pwBBEvKDPyQnlE7J2B2eRk8
        RHaHHZcQvU5LDXsINbDmAWsIq+FIjWEX
X-Google-Smtp-Source: ACHHUZ4crxpGe15BxcOcaGOZO2WjPbibX9jRmjl7rSrwdD8Z6/aya1uE9CJM9AhjU7HHArKs+z3PEQeSOj8s
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:e3c5:b0:1b1:c90e:b7aa with SMTP id
 r5-20020a170902e3c500b001b1c90eb7aamr56727ple.4.1685722181662; Fri, 02 Jun
 2023 09:09:41 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:09 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-12-vipinsh@google.com>
Subject: [PATCH v2 11/16] KVM: arm64: Use KVM_PGTABLE_WALK_SHARED flag instead
 of KVM_PGTABLE_WALK_HANDLE_FAULT
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

Check against shared page table walker flag instead of fault handler
flag when determining if walk should continue or not.

vCPU page fault handlers uses shared page walker and there are no
other shared page walkers in Arm. This will change in future commit when
clear-dirty-log will use shared page walker and continue, retry or
terminate logic for a walk will change between shared page walkers.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bc8c5c4ac1cf..7f80e953b502 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -191,7 +191,7 @@ static bool kvm_pgtable_walk_continue(const struct kvm_pgtable_walker *walker,
 	 * Callbacks can also return ENOENT when PTE which is visited is not
 	 * valid.
 	 *
-	 * In the context of a fault handler interpret these as a signal
+	 * In the context of a shared walker interpret these as a signal
 	 * to retry guest execution.
 	 *
 	 * Ignore these return codes altogether for walkers outside a fault
@@ -199,7 +199,7 @@ static bool kvm_pgtable_walk_continue(const struct kvm_pgtable_walker *walker,
 	 * with the page table walk.
 	 */
 	if (r == -EAGAIN || r == -ENOENT)
-		return !(walker->flags & KVM_PGTABLE_WALK_HANDLE_FAULT);
+		return !(walker->flags & KVM_PGTABLE_WALK_SHARED);
 
 	return !r;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

