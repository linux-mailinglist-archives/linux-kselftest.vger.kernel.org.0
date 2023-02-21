Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903F69E4D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjBUQiB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjBUQhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:41 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185D2CFD0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:31 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id cn3-20020a056a00340300b0059085684b50so2595985pfb.16
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676997451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6eya8RvAso0oVSkPG+SqCdov6cQuqd8KcPbcmXzNxTo=;
        b=TVd18GDSarLsA2/lPOgVrYfYPYZtvFYr4jPuI+f6by2zc3e5pGx1TLe7+8F/v5CLcD
         C+ZUrDVI4U1jkWxXvQCJTohZULj91OSBWXga7XMNHoIQ3y9p1MLfmHOOfYPQREsSOSVx
         g2LY0iK/jP8K4IOeK/N+J+awTSjk0wSuqNeNvwP34Qzf7NDM+YArW/aoRPdbQATy4QU1
         iVfIDNRyN55PI5w/GyAPsWGgV/GAQlDYeyBx5D/HeDQ9QmeP44S8Gix/v/R9ZkOr8sJU
         QoVSUyIk00vSaTEyVgZc4PCsBDX7yXWROpx9vZXMV81E9I5nSvgGpWREuTz/5ZJP9+KS
         vIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676997451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eya8RvAso0oVSkPG+SqCdov6cQuqd8KcPbcmXzNxTo=;
        b=dNrtyhiLrHmZp4g/CSXNYO0pY1ANQx3EGASk5hwPjzp5RqTvpvMQpafk/Pw0QHCxOJ
         VZOLQBuQWGs47JWaWcFG/FswkM93HF8HlKb1M56mObWbLwCUuiTQtxmOv4RcM0GYnKu3
         QH/XWHhB+2C4wjImBFmo9oEIbAxrwGAOaxjn7wHfRxLICtx8tA4D0GRl4Uxb1ezRWFpW
         Mhi/UVRh9LVFmIpizmtYy/KAkDK6WY0gU4hJjsLL1P1NRDHTEzuSVCXZjU6wUhMIh+Xk
         5k8Ocf4+rvZeUCIL815yobubnZ2/SjS4g2NuIfaay/tA08S3y2V+HxHcSwc3xqzkyiEl
         EqWg==
X-Gm-Message-State: AO0yUKUxcGZpFHBslFEjBP31zmvF/CgO1d1PrsqWhDJM4C8sCRgooUd4
        lBljd6T2GRx8KeyMc0HYl0MYAsslrVbh
X-Google-Smtp-Source: AK7set9GqgvFSkGmlkChA0S8+JUftH2z6x67/RS3rMWptrG7AL4MP9X7ck4FrIKaNCD4eHIBUs6gU2jSXexQ
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a62:c143:0:b0:593:d4cb:dba2 with SMTP id
 i64-20020a62c143000000b00593d4cbdba2mr655957pfg.13.1676997451249; Tue, 21 Feb
 2023 08:37:31 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:50 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-9-mizhang@google.com>
Subject: [PATCH v3 08/13] KVM: selftests: x86: Repeat the checking of xheader
 when IA32_XFD[XTILEDATA] is set in amx_test
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
index 62fff3363b3b..724e991ba814 100644
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
2.39.2.637.g21b0678d19-goog

