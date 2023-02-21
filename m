Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043369E4DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjBUQiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjBUQiA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:38:00 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0319C2DE4A
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h18-20020a056a001a5200b005a8b508aecdso2411455pfv.20
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iGUJ74hklZ9IC2JyxMgKiaxBDpYa7dvkgnZvEvOVY64=;
        b=rLLClLSLRO2Tp90/r7PQXQ0zXhJU4bH3YbgREwBPeec4T+BSaGhme3PS6pRryZIl2I
         3Vx6/7T14jB9wybO+c1oOfMR7bCqjQQ/VnYnqMjA6woidQlCuLjLIdfMuBQdNW48M941
         Ri2FghSa86fAhOxHk5FbQr06jmgvgYyjPOrcT1UStStg1SBpOofv9Yg9vgeVv+T0o5XV
         u1OEO1L0WyfNDRkM9ADA7YHu99CylDNoC72jQ2FPD4hpuo8q+nPo7sttGxOYOMxUEcy9
         3sXqIBJywR+kvP6c1+AAe5h7SsBxplT6ztBAGAMYaw4kKN6FKiGbS9msYuRp8SiysKQo
         dDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGUJ74hklZ9IC2JyxMgKiaxBDpYa7dvkgnZvEvOVY64=;
        b=PR+OtaetJRDZdyYzNGzKMs4cYh0ew7ec/tnxf616+x4Jh0WdQtDp+C830WbwtKdl9Z
         PVyDsDFN+LdBQ3H+u90DtG7aRBfA5px4ZIUw5pxU5Zg0DiiERncUio1p4Ocf80bu+qxG
         E54wpFCRVtFlpxFLwzWfBKyZCqzrjHXUjea6Ebi8BnPUvTd5uqFF/jFkizp46sjp0kCn
         PShwYw/BiPvGAIFMeGGI355XGPboEGU10CmN22R0vhhaKeHLxsADoAfphbaN7JXhkOfa
         TFTPMFAzvn3MlxaXCTLVOrYsdeuWrBN/J52jeCspaM7kAYjc8yGoieRHJZkXfue3x9y2
         RaMA==
X-Gm-Message-State: AO0yUKWGq0wf/aTWb5oR1z1p16ZCjX3lrfd/K0U1AZ2epq22P4oMVaYl
        pEAHMtiARz862PyzLm7UDwDd72Wnkj9y
X-Google-Smtp-Source: AK7set+m1UL4EQdVkgxFOWJtVr69/x8dmtIcB6yIkcdQ2Uw9+EflID8jEffCwLg3f81uwnaUjq48GPyiEo04
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:903:2651:b0:19b:8cbb:30fe with SMTP id
 je17-20020a170903265100b0019b8cbb30femr708263plb.13.1676997457301; Tue, 21
 Feb 2023 08:37:37 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:53 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-12-mizhang@google.com>
Subject: [PATCH v3 11/13] KVM: selftests: x86: Remove redundant check that
 XSAVE is supported
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Aaron Lewis <aaronlewis@google.com>

In amx_test, userspace requires that XSAVE is supported before running
the test, then the guest checks that it is supported after enabling
AMX.  Remove the redundant check in the guest that XSAVE is supported.

Opportunistically, move the check that OSXSAVE is set to immediately
after the guest sets it, rather than in a separate helper.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 1a1565126255..deacd21cf744 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -109,12 +109,6 @@ static inline void __xsavec(struct xstate *xstate, uint64_t rfbm)
 		     : "memory");
 }
 
-static inline void check_cpuid_xsave(void)
-{
-	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE));
-	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
-}
-
 static void check_xtile_info(void)
 {
 	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0));
@@ -157,6 +151,7 @@ static void init_regs(void)
 	cr4 = get_cr4();
 	cr4 |= X86_CR4_OSXSAVE;
 	set_cr4(cr4);
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
 
 	xcr0 = __xgetbv(0);
 	xcr0 |= XFEATURE_MASK_XTILE;
@@ -169,7 +164,6 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 						    struct xstate *xstate)
 {
 	init_regs();
-	check_cpuid_xsave();
 	check_xtile_info();
 	GUEST_SYNC(1);
 
-- 
2.39.2.637.g21b0678d19-goog

