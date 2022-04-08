Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584E4F9EC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiDHVIG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiDHVIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 17:08:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B313CCE7
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 14:05:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id o6-20020a170902778600b00153a7c44e4bso5030772pll.13
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GW1vKV9N5teOyvfb5I9sUS6KK3JTNrM8T3BSiJA3u58=;
        b=YPJzdBeiwqt4fjOsYpcbGkh1gLEAIoalUN0DQYlSc34An29/tzLZqwDKzPep8ILYxR
         Gu3b8EV6mtpXvJASkRADF/66OiaUIGTMgyJ5ovvU6ymdAYVy6wSWmka6NJGH0QRLTXL6
         r2umjRjjUO6obXxOyLt75iI38lUoWAVVot2IPIJrVpmnX2hCCKBQw8JrfIKdkNKRgrh9
         HaASvu7mS+//qfMTma0LOYpXsp7UOHwgUHWVY2EbYHGbGfqmSHagSzBTN5AqRBH8YL7h
         0etiyCrAptQNAVpnH5L7JXc2gn6U8vp7IR3Wvr+y9Af1hD+XHs5GzjRM+yZELeINoH3k
         fh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GW1vKV9N5teOyvfb5I9sUS6KK3JTNrM8T3BSiJA3u58=;
        b=nb/7y08+nyvNL9n3yB/lRSuHVL63OLj603Zv8nrPd3lWW3K8+B6Y/t1E6AcNicfIXC
         O7Eq9fHr4t0pF5pmuF6fhrr1D3nzW9o7zmMZr1To/aDEhq33Kf5+goY7LPJthNAX5FJc
         5AomE3d+MFYnB07eSGu/i8Z1774lsk1V1Fg0qdhytRaAsLTTUYoL3grkqBONiOxrZUW2
         ZPfcMtjUKjmLPLT18PFhk3pVnHVp0vpeRvMF3SPQnBD4pj3JEoPWX86mlXwutFk5aNO5
         qHePrB/7EBCzu2nAmx2i8HOaJDRxBsEFf1kX8rMNMEPDuadATdtPW6I85B5rSa+7NhD9
         3qow==
X-Gm-Message-State: AOAM533XthLPwFHF1loH5Pmvm7gO/Wh0LRKDKP+i70qvAZ7/RKPeATuU
        YS2qH/rhj19BeZCSsbM3exfzI80s2hDPZqIs
X-Google-Smtp-Source: ABdhPJxPmdiW7rz30UJ3Ed7dM0wffN2Qn1qWfxF8EThuEe9ikuR8T5UVcG1/UtpEZ1q7GRUv78CpjaDK4xF4IDVi
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:198c:b0:4fa:c717:9424 with
 SMTP id d12-20020a056a00198c00b004fac7179424mr21025716pfl.63.1649451957132;
 Fri, 08 Apr 2022 14:05:57 -0700 (PDT)
Date:   Fri,  8 Apr 2022 21:05:42 +0000
In-Reply-To: <20220408210545.3915712-1-vannapurve@google.com>
Message-Id: <20220408210545.3915712-3-vannapurve@google.com>
Mime-Version: 1.0
References: <20220408210545.3915712-1-vannapurve@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [RFC V1 PATCH 2/5] selftests: kvm: Fix inline assembly for hypercall
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, seanjc@google.com, diviness@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Fix inline assembly for hypercall to explicitly set
eax with hypercall number to allow the implementation
to work even in cases where compiler would inline the
function.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 9f000dfb5594..4d88e1a553bf 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1461,7 +1461,7 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 
 	asm volatile("vmcall"
 		     : "=a"(r)
-		     : "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
 	return r;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog

