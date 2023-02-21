Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0469E4D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjBUQh5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjBUQhf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:35 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E292CFE3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q15-20020a63d60f000000b00502e1c551aaso265845pgg.21
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w2vMSj1pqCX3K6DVzozBWZ+Uf2g2Y7SPE2PRI36z9us=;
        b=DajTbx4B7dtFVQSGSpYck2dVAgO/b8AL4deOPuANwJ64sRfLWumNJeJtLq/ZJhv1cd
         yZWJoeLFSSuBT/rlTQHY7vzTP4QT3n/5udfMxWhlVkEWx4t5gCEsKVk8sNPlw4dDbHA0
         Ursp80w7OYSX68Zf6OoswIr88aR9PE0Qfsr7QHn9+wrdLLSluIsk6n9xW0rfPs7VeskL
         pq8Vr+ypMELlFgBAowcAcH2M9km1WyH9jA/iXN8M1XBA/G0Z/B319HA3S0cOzj7+0iIe
         USKzDbX8ParyU9iv0Dge7ttZs31dbK/DxHkLUDoeCXa+esdohVJqyFf9LjHvGXXzV6JK
         ac9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2vMSj1pqCX3K6DVzozBWZ+Uf2g2Y7SPE2PRI36z9us=;
        b=Z5RPrSXhcC8iO7lPXqJDje4kBsClK9pyB/PL5IiWbdyqAvE1ZBIpCHsXf2Q1rpZfn1
         bxMxvlIB/Eh5o8+JoAda1Llxlqp6cwBtv/8CyTAlOVQxbpTzuBVNXb6L7WnIUVgUWOg2
         dzKGGFkWMqw4SIKSO7IkA2pTWsl3grh53HswDcaIxRtx6aBOhVCUu0LobApmUzbF+D5O
         cJ9EPNJs1Ck0L8UM6YNDi1EGlJq6Wba77cVvBPc2hqC1w0JjvsHsxSVJWIvXXOQWKu5/
         6jlaivwxldwDIxYhkDUk3W6ESfdz7LOnDZdEPoNB1Kdv3DOIbBBxmtwdCcxC+zaULLDA
         VT1g==
X-Gm-Message-State: AO0yUKXyqnw6oI70U70AycC9er3jyUBNmBbwFxISfBQ37I2MNS+YXGa0
        KXOma5TVAK9MgvbyNlSddVvJPIvkDWNu
X-Google-Smtp-Source: AK7set8qAXOR2/Hd1KkJ1/GP+RXMvy0M0Bdho4jquC9vVEHvs+inVCvxtWU0xDTeZGKfNFydgvkLwrV+5g1l
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:f811:b0:19a:f153:b73e with SMTP id
 ix17-20020a170902f81100b0019af153b73emr729491plb.4.1676997449336; Tue, 21 Feb
 2023 08:37:29 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:49 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-8-mizhang@google.com>
Subject: [PATCH v3 07/13] KVM: selftests: x86: Fix the checks to XFD_ERR using
 and operation
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the checks to XFD_ERR using logical AND operation because XFD_ERR might
contain more information in the future. According Intel SDM Vol 1. 13.14:

"Specifically, the MSR is loaded with the logical AND of the IA32_XFD MSR
and the bitmap corresponding to the state component(s) required by the
faulting instruction."

So fix the check by using AND instead of '=='.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 296c954dfd6d..62fff3363b3b 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -217,10 +217,10 @@ void guest_nm_handler(struct ex_regs *regs)
 	/* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
 	GUEST_SYNC(7);
 	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
-	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) & XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
-	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) & XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) & XFEATURE_MASK_XTILEDATA);
 	/* Clear xfd_err */
 	wrmsr(MSR_IA32_XFD_ERR, 0);
-- 
2.39.2.637.g21b0678d19-goog

