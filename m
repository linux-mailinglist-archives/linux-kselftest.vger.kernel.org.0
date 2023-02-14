Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD7E696D35
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 19:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjBNSq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjBNSq2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 13:46:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332AF2FCE1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e191-20020a2537c8000000b009433a21be0dso1393299yba.19
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 10:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yFTrZ49NPc/OCN422DTCBQnAUieTNXYf1AUTcxKKvJo=;
        b=HkiNOU0OtF0CfkY42/ahYT9mmm4slpuv+KGwhyzZGBxJ7S+wC9r1M0X7JT9YhltQca
         VKbAk2ZR15AQcB6XBfCFC5nNuXzWQcCApf8nWUiAAuIq1Oym4XMmrfaWRHJljB8ceTkh
         W7ci1QAam82T757rvrhOmt6xe08JQcIQS5lImc48pPMqdSVDQwnZQ4WlxGBZ2BJU5CMP
         Sh2yCuKp9LYj106cTZoHjb6wRLvUHqInuWShbiLlngs+0OVkIwzDTCFW1mw0QMhSYI6o
         IITMqyO6TEyQFx4rLl9qwosAhabd2sb6poZ8UZchfe0jMzMDHNMus26SuAFvmp1IpJNJ
         LhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFTrZ49NPc/OCN422DTCBQnAUieTNXYf1AUTcxKKvJo=;
        b=EExyZUFlN+dmFTF5XD8/fWNTliFCuCr66peN0SFUb5qQOcEqnVAfXlTIAGlgDkn2Zv
         dJKkVb71qcg2wwv6tr+OZfzD/9rijLib5tWyz88t7rqqL1vzd8yjFoiMGF0mLHBDjqCf
         u/VTOoD0XlTyEU4o9LrL0NfsUp/bcNJzOOFfk+hV7lZKN69f0K9B7Emycb1FOAdIW4kn
         neVEznoKG1LxaP6FIpi1QdGYqrgUph3xUFqsFL0EoITO/LODI+sr+E0dH4OKs3XK4IkF
         krgsO9sXcrV4oMbj40lMaof2voIVjMaV1UFRO0+9YGBKu8XOuuMTl9O2WULPkW5pMGPL
         H4Gg==
X-Gm-Message-State: AO0yUKU9yN5jFx2eI2JhhQqsCfHRkEkof/OcJS7IJCd6Dtw5Y3CFJS/T
        NFugPjk8sVIpeQy9wd3WcaadmXjST8Cd
X-Google-Smtp-Source: AK7set9KuUaNnI3Q0H0pQH8TJTXywQ56ZpibfOMhNc75iu7Y8nfC8wCG/aWVPnx016Mn3unZW4Bcbn+4Mbyx
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6902:110f:b0:8da:f656:8da6 with SMTP
 id o15-20020a056902110f00b008daf6568da6mr30ybu.7.1676400383934; Tue, 14 Feb
 2023 10:46:23 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 14 Feb 2023 18:46:02 +0000
In-Reply-To: <20230214184606.510551-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214184606.510551-4-mizhang@google.com>
Subject: [PATCH v2 3/7] KVM: selftests: x86: Add check of CR0.TS in the #NM
 handler in amx_test
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
index aac727ff7cf8..847752998660 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -215,6 +215,7 @@ void guest_nm_handler(struct ex_regs *regs)
 {
 	/* Check if #NM is triggered by XFEATURE_MASK_XTILEDATA */
 	GUEST_SYNC(7);
+	GUEST_ASSERT((get_cr0() & X86_CR0_TS) == 0);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
 	GUEST_SYNC(8);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILEDATA);
-- 
2.39.1.581.gbfd45094c4-goog

