Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518E69E4C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjBUQha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjBUQh2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF222CFE3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l1-20020a056a0016c100b0059395f5a701so2224011pfc.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AyHb4Yx7urg+Zx7LCzA3DPIwt3rV/2dFui2+3APs9Tw=;
        b=rJnHYpiq5KubUJYTSiL6hLKa3WdBN7dObACs3EooXynZnDtSUFMMac+rcUMHzOwXan
         N1auXr5kJDb0xBpddo87Mu10IQGJR64S8FHMz7w2VZCZrOABJv8RJQfeccvr41wzKuom
         CcPj7lu4XfpGMjIfHZj+AZxChF9kGaoUu1jJT6X6HY6KZdk9lD/y8fCAy9NdLTQ8U65X
         zFbtEdVVKjkf9uhBse6jbZoYCl5miFUFGutHh65L/bFqbxAsG3kbRVKbd+BUT/X+7qyw
         k4CuWZv7SUWSuzzMxtGskoyZqxq30YuNSC4xEkZuIFkGG0liJhveNy5yECEk8jlwxhMu
         w4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyHb4Yx7urg+Zx7LCzA3DPIwt3rV/2dFui2+3APs9Tw=;
        b=rlktbTfA7kXspK9yw8IktCzl1nu4985O+vKHFGaFBxfe7XKBjBL5twMmASjbBjRRVa
         a3YR/trpZ7WWYDz8bAEPiRpp0BavnPoLcj0brHQ5u8XZ7Dz+MTeDIDZA8qn58HYHmyQC
         32xvx99E/O/UTyWB2vZsYamQq07ilmuSCaGERa5n+PHlpfReIYXrEp8BuuGTgsNE09Be
         810XFjJMxAaguCmiIItdnEiV5cue0bW8FHBx5dYVeAHSFijb1Zz5zNcORUJ1Pw+WFJNx
         n3ntp3K/HOBYYEo4UgmjyUOuP3vLJWKw8gOYbTlI4A2ZRFRmCueyxZvvWuCa6WYGS20E
         fcYg==
X-Gm-Message-State: AO0yUKXPaWAeik3flp7eegq1cCziFoB/nTMmNbpevGISEYWjUJKc4xrh
        u1j6hGiQeDbjkAD2lB6ro9YqgsKgsmwB
X-Google-Smtp-Source: AK7set+WXUie8cV2x/2H7NwHmU008RDRGepmXDcXx6OTSn+v7LisP2WwfmcqvY9as4zuGcs0HwwzGct/WAfm
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a62:de44:0:b0:5a8:670c:c94e with SMTP id
 h65-20020a62de44000000b005a8670cc94emr859351pfg.12.1676997442517; Tue, 21 Feb
 2023 08:37:22 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:45 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-4-mizhang@google.com>
Subject: [PATCH v3 03/13] KVM: selftests: x86: Fix an error in comment of amx_test
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

After the execution of __tilerelease(), AMX component will be in INIT
state. Therefore, execution of XSAVEC saving the AMX state into memory will
cause the xstate_bv[18] cleared in xheader. However, the xcomp_bv[18] will
remain set. Fix the error in comment. Also, update xsavec() to XSAVEC
because xcomp_bv[18] is set due to the instruction, not the function.
Finally, use XTILEDATA instead 'bit 18' in comments.

Cc: Jim Mattson <jmattson@google.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index bb9dc0008f43..16c857c1052e 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -190,7 +190,10 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_SYNC(4);
 	__tilerelease();
 	GUEST_SYNC(5);
-	/* bit 18 not in the XCOMP_BV after xsavec() */
+	/*
+	 * After XSAVEC, XTILEDATA is cleared in the xstate_bv but is set in
+	 * the xcomp_bv.
+	 */
 	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
 	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
-- 
2.39.2.637.g21b0678d19-goog

