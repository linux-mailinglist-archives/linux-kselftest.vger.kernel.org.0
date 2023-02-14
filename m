Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E947696D41
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 19:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjBNSqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 13:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjBNSqk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 13:46:40 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17807303D1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:32 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s4-20020a056a00194400b0058d9b9fecb6so8331969pfk.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=e45OX0NDJeq5V2rb+kyK4NF8qvuYK8lS9xJETTcIBfY=;
        b=dZKwalR76soWtGMo/M8feDWZleE8F9YbvhBn5jO8JQodvtlgXYVbP2EGrU3801TD0y
         qZ73+c84YWss5A8SySkBl4yjbd5/Sdb9gX8yrAhd8ZDXv3BGLwH7I7oSt+MdL3y7KsfG
         Ax5xYOxRWQCfS4AMl1Bn5wfNiLbvTkEblo1oqACBQy4blH/k4aS5QPnbDwXs3q3SwMaA
         Z2P0/jyyYL1IRfYgvFR1GVcBLZD+mpcMLUJ+m0MNq1Sdc9SweqA6lyI/wW4fMAb/HxTy
         NhrEoJVgUbXAd8RbJeCwCZcad7WhTgasXlKj8/OO5iXOlPFjN13GumPwwidYLsqwbhXk
         PoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e45OX0NDJeq5V2rb+kyK4NF8qvuYK8lS9xJETTcIBfY=;
        b=PVezDSNO7mdDx+iA20oAKbZsahobjOvw20TZhYJMNck+jyk0ubPurlyDmBpei7L0Nq
         6vxm7wQkZF8ppFFfytGy/vLWu658qrOqXhLkPydWbSUL55k27RDD08iKf7jtEcww67fi
         i9DkqBNlkfJMbq9W1MSVOZpdX92ASbpaVcHuRhOaKtcR0nfM+5h28A7tXeYY/dkL7uoB
         FtxLpKHK2kZLzTibi/qMNU3Wel2I0SO1w1G1Lc3d26aX8qodVQocEtqGy9Sa++9EIB1P
         39dUfkLHCufCLXMdgYWy8fVV8vIJu1Hv2FtSaX0cBu9e5AersybDw4ZI+zyP63um49/x
         1nhw==
X-Gm-Message-State: AO0yUKVAo4m93UcEMi2J2ZOegPTKQabYY6WVBh6VZW4e97C6/aotSRve
        PGelFKkMwi88ooFTwuYhWOjKo6VK6EVw
X-Google-Smtp-Source: AK7set//OVAlomKtVqsffFhmB4sl1HHUTQadW/RJWg56amu5xkKi7jMMXJu5dXgWFGhOHPGvtD2SDMH++G7n
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:3f81:0:b0:4fb:92bb:a648 with SMTP id
 m123-20020a633f81000000b004fb92bba648mr64175pga.7.1676400391579; Tue, 14 Feb
 2023 10:46:31 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 14 Feb 2023 18:46:06 +0000
In-Reply-To: <20230214184606.510551-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214184606.510551-8-mizhang@google.com>
Subject: [PATCH v2 7/7] KVM: selftests: x86: Repeat the checking of xheader
 when IA32_XFD[XTILEDATA] is set in amx_test
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
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

Repeat the checking of AMX component in xheader after XSAVEC when
IA32_XFD[XTILEDATA] is set. This check calibrates the functionality scope
of IA32_XFD: it does not intercept the XSAVE state management. Regardless
of the values in IA32_XFD, AMX component state will still be managed by
XSAVE* and XRSTOR* as long as the corresponding bits are set XCR0.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 0e4c65f9e2f2..d991a473dc11 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -201,6 +201,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
+
+	/*
+	 * XTILEDATA is cleared in xstate_bv but set in xcomp_bv, this property
+	 * remains the same even when amx tiledata is disabled by IA32_XFD.
+	 */
+	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
+	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
+	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
+	GUEST_ASSERT((xstate->header.xcomp_bv & XFEATURE_MASK_XTILEDATA));
+
 	GUEST_SYNC(6);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILEDATA);
 	set_tilecfg(amx_cfg);
-- 
2.39.1.581.gbfd45094c4-goog

