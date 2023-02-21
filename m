Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D669E4C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjBUQhd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjBUQha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:30 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7432B2BF
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf649e70so38999517b3.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=b5cXkH41Dpz3xl6Z7o6kxBjd79dMhYH0BWx6BfiSfBo=;
        b=CZqHake47gq3cd03ZUsZh+xOkan8dZo2tmN+vrMtOJQriJNPTqmfglWH2l9ManWKVJ
         ze1EbMlWwtI2gznNO6XbtWUxOWwDC4cTM7CUf6WrRBL5FWgdYDu3fcCNnA9+BWCDiMYp
         i4GHjTBuI9ijI9LjZWNWantpodnjMqpS1kNGyrFtoSUd8vz1GJdeEtRhXpqBq3D8DSC8
         5cUNM3sbtaxkSj2cJvJ4tDH9/kZlZ075/b2Lh7toAGX7RwWHeFQe/XA0pO7iCSbCjtIo
         A7C2ltL8CxMbBRvN3g61e/lXrHTT0bZJG3OAKapt8gRsAB8tv0bxsF/81Gp26/Tfmo4+
         D9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5cXkH41Dpz3xl6Z7o6kxBjd79dMhYH0BWx6BfiSfBo=;
        b=f41mcZdyIs+Fi8gOSM5QUN3wL+iYI07EEA6pZYq7emvk7oc3ScxP0r1UgBN5sHS7Ah
         NbV0Z3vOXpG4Ia5udEVpwZHAvJV00xbFdvCQMp82p9H9Tgi3QAPlmiePUUrRlBCnwykP
         E/AlW98bH/ryM9L1w3iOHWEyQm1QN6Rt/WErAJVuSSgP/O/utR80ZCAQtuIOp/t6uI3T
         pcE1V3z4frkY1ptODGmiBOBO+wVEwqQ/1+Fm/kKzEJpnKXZUkWnpORxbAGxBDClSPnM0
         0ttliL4rABk1iFU0RzWNeRGEfD6s8qQ/fsaHWYdHJYkQXtliq91BrSUuiJeXjU/OpcEC
         sTgQ==
X-Gm-Message-State: AO0yUKXoO41oCSFTi/ClROMp006/sXU8IXdIXDM/r+JdQZkuXaTEvT5f
        LdyaZp+fDMHfxa92+ZcyF22tGdgIfIho
X-Google-Smtp-Source: AK7set+lsrO0DRQyUKeLS34m+CI/REvkWAnKXiFjmVCheEFMJ7XVJNdadgKb6R5DIHKliO32zKTKPYD50nIW
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a25:828a:0:b0:959:9937:49ce with SMTP id
 r10-20020a25828a000000b00959993749cemr1788344ybk.188.1676997444339; Tue, 21
 Feb 2023 08:37:24 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:46 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-5-mizhang@google.com>
Subject: [PATCH v3 04/13] KVM: selftests: x86: Enable checking on xcomp_bv in amx_test
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

After tilerelease instruction, AMX tiles are in INIT state. According to
Intel SDM vol 1. 13.10: "If RFBM[i] = 1, XSTATE_BV[i] is set to the
value of XINUSE[i].", XSTATE_BV[18] should be cleared after xsavec.

On the other hand, according to Intel SDM vol 1. 13.4.3: "If XCOMP_BV[i] =
1, state component i is located at a byte offset locationI from the base
address of the XSAVE area". Since at the time of xsavec, XCR0[18] is set
indicating AMX tile data component is still enabled, xcomp_bv[18] should be
set.

Complete the checks by adding the assert to xcomp_bv[18] after xsavec.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 16c857c1052e..ba8c0afdbac8 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -197,6 +197,7 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	xstate->header.xstate_bv = XFEATURE_MASK_XTILEDATA;
 	__xsavec(xstate, XFEATURE_MASK_XTILEDATA);
 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILEDATA));
+	GUEST_ASSERT((xstate->header.xcomp_bv & XFEATURE_MASK_XTILEDATA));
 
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
-- 
2.39.2.637.g21b0678d19-goog

