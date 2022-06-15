Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8D54D13F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jun 2022 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbiFOS5T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jun 2022 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOS5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jun 2022 14:57:18 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AA40E63
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 11:57:17 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 190-20020a6306c7000000b004089a651e4eso3813948pgg.20
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JOfZ+gB0dYMw5zlfGsNpFQnCHYNIGhGPLB/fJ5JUiU8=;
        b=SmOp6Z2zPaMf+7HW3xlQs45Fjh1wQY3JcE955U5EzRHsTUkE/IVL5RlhOgVgPtTUSd
         40TLB+kwbienuX8Dx2E0wGxELrUEYzz+rLJg+3O0i9zwkTixcET9vp4JBVjxgbrJBAnu
         +cYumohJ/0Z1hODaPf0Ii6qP1SyuhGSKXz4inlCZbL9c2knCQta/33jC2LQmQ/aeD1/y
         Tnpe70f0H+Jx5LGBbpe/TeG9QpvYq8ogcKYRc6PcX+ZPg4yqL5EsPmDFbBWLlmCrK4+l
         wTu6a0wUtxmkc1JTA20jJsnPffMTnk8/bBUa5UdrL8N2SVS1KlYBk5kkxZrRKRWiYilI
         BvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JOfZ+gB0dYMw5zlfGsNpFQnCHYNIGhGPLB/fJ5JUiU8=;
        b=Y/Pg+87l5DU4C+DDsg8Nkl6wV3NHIdha/D+bQfYm708NGPs/+ro9yAs2oRW9f5ZZQr
         LGeR/BssmsoXfLoTxzHg+siO6meHW+uK9tt5m2GsNMT4JGJHy5OhR8E3R8h19FrjJ5mK
         ejcCLCq0gynK/YTzPRmdcCI5CXQ5Qj4BC8mDWnQxQFZHP4uWeZ+6K5j2XgYNxzygSTxT
         V8QVPLjoEuVGU3Z8xTmzfHzgi7EE0bZpdfbkepDikWAfrqnRsw7THwVI880zplJX1DL/
         SF2Kcol5y/aLAp+IuO01SjTjavksWH7VooYMmQhm7D007utJmos/9PKHZXlnLodWRoh9
         Vt5A==
X-Gm-Message-State: AJIora8MBTMJV+6uQYUEeRLBGIonulGZUloIv0hGfKi3Ps22v/iZHK+c
        THdTn2L6vOhtHGWYHGYA9tAfmkbgy9mN
X-Google-Smtp-Source: AGRyM1tnQw7CJaekFPc8SBXFz+VUADNRt0rkCQV5Q4hm28pSqTrYYIgOQmS9We429pxh9Gldc5o2PJ/GLIXf
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:74c3:b0:167:6811:40 with SMTP id
 f3-20020a17090274c300b0016768110040mr1022512plt.120.1655319436857; Wed, 15
 Jun 2022 11:57:16 -0700 (PDT)
Date:   Wed, 15 Jun 2022 18:57:06 +0000
Message-Id: <20220615185706.1099208-1-rananta@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

The selftests, when built with newer versions of clang, is found
to have over optimized guests' ucall() function, and eliminating
the stores for uc.cmd (perhaps due to no immediate readers). This
resulted in the userspace side always reading a value of '0', and
causing multiple test failures.

As a result, prevent the compiler from optimizing the stores in
ucall() with WRITE_ONCE().

Suggested-by: Ricardo Koller <ricarkol@google.com>
Suggested-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/lib/aarch64/ucall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index e0b0164e9af8..be1d9728c4ce 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -73,20 +73,19 @@ void ucall_uninit(struct kvm_vm *vm)
 
 void ucall(uint64_t cmd, int nargs, ...)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
+	struct ucall uc = {};
 	va_list va;
 	int i;
 
+	WRITE_ONCE(uc.cmd, cmd);
 	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
+		WRITE_ONCE(uc.args[i], va_arg(va, uint64_t));
 	va_end(va);
 
-	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
+	WRITE_ONCE(*ucall_exit_mmio_addr, (vm_vaddr_t)&uc);
 }
 
 uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
-- 
2.36.1.476.g0c4daa206d-goog

