Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2E69E4CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjBUQhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjBUQha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:37:30 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF972D144
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o17-20020a17090ab89100b00230aa3c1350so1616327pjr.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LHzOHHZRF0Z0PxEe7g90IRKekQBPW5kSPBGZ896mCAw=;
        b=iYq/M/swxMz4Ajz5CWey7J9Cn2hGpOfZNKoeQVqLmLqWDDu83kf7cKxB5F54bE8hgY
         6vq352hL3hkuyr+xvGGBPsMBFVU/kUaywZAPGbjpw45pwBVNsUBhXvaHp3p5ij76cNyt
         rDAfZbAgReB4EQSAA7OwInJ6lY9U5BvKp/01wMwOxtpg44NJRhHT8Xq4rTmDcrsxjTti
         pfGVpDEXEfEJGnxNtzFVmYPT2BiwBWDwDKgsfrnnVyf/fxGl4166/OjhO4zVgoSeAI5l
         SvSQxAOupvX+FgQXWxfzi4j2RPAPPbmJeclJTu28XTV+YePpR+2e/aj+jRqUzJYVs/du
         fzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHzOHHZRF0Z0PxEe7g90IRKekQBPW5kSPBGZ896mCAw=;
        b=Oawo25hl7156EJkT45tDK6jc/kOscxxjj0kFwWREEVwRQdGwDf0ZF1a4ZkD/NgyaG/
         UV5FhR+08IKbgs/jIKsgCH8jJCihl2JydRK2jPLbFQq37S7EKNb/QQfTTM29Cu3v6VbP
         JTnS/VgeFy8zpe1YRFzugXpyhys4vJi34Qv4FXX1hlK75dne9fhvhsrjUcSmd4t0btf6
         9FyJAxC6NgQogj12mQAERDw4r37xwntbyIkIdTfiIDQicA7Ud/9EF4SoM4hZAjfXg35W
         iVXI5SB3+uAUD9hHIni767sXqnNK6eztVP5XdVB3H5QtO13CSuW3uHxtnfH/fAVobJLD
         +9ZA==
X-Gm-Message-State: AO0yUKU49u4kQKh8OFNuNxtAHcMjKLTH38s6Lwd4KJUhJkEwkOxxmwiN
        Q8B+sgQbbhSjlp4MCzP0gJgGpxoMS6oC
X-Google-Smtp-Source: AK7set/FsPqQ8rlzY7E1G6gdIEFDYIPaZx1jD1gvFI1btYAhTJ4yElO3zkb5t9OHD55Nxe6cLFjy5KIM8l9A
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:3344:0:b0:502:e48d:6ea7 with SMTP id
 z65-20020a633344000000b00502e48d6ea7mr9485pgz.10.1676997445850; Tue, 21 Feb
 2023 08:37:25 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:47 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-6-mizhang@google.com>
Subject: [PATCH v3 05/13] KVM: selftests: x86: Add check of CR0.TS in the #NM
 handler in amx_test
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

Add check of CR0.TS[bit 3] before the check of IA32_XFD_ERR in the #NM
handler in amx_test. This is because XFD may not be the only reason of
the IA32_XFD MSR and the bitmap corresponding to the state components
required by the faulting instruction." (Intel SDM vol 1. Section 13.14)

Add the missing check of CR0.TS.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index ba8c0afdbac8..ac49b14460b6 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -216,6 +216,7 @@ void guest_nm_handler(struct ex_regs *regs)
 {
 	/* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
 	GUEST_SYNC(7);
+	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
-- 
2.39.2.637.g21b0678d19-goog

