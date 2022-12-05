Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4664396D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiLEXYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiLEXX6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:23:58 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ECF193F6
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:23:55 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id v23-20020aa78097000000b005748c087db1so11749237pff.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks4Sd+0JxxDpqRkpXg5iGmHlGBA+0HJ4sfY/7YXtnEQ=;
        b=i4osWTqZ7ymNfeSek7naspZXApgoE2o0F0UoWSnfa/GvObXDoG+s7NlDZRY2BAV9a6
         l+GN4PjhVUKzUzq+26wXDQLVdRfg+cYDgmS22Po2BGrjbFyM/wrpER5zYnSOmqEmajjJ
         7X5a8Mm0z3R4hTfp7p1Fav+2m4pHZ20uU6ic+I9uG9lvAxgz/J8uaWjn3Eqf7bCFTrP4
         C1S3sPRoKMQ4YWYMm5Jp8ubMHkTuOX5tKYPNjsxnuxMVuC4Q8HsLN0hVqvjU5JgLMqp1
         6ISfQ8iJdlKrDX3HUZ3IkXZtnL4rGgyQQdBERlqSzjfs88rKJXda9ixTCCqNPk5SZ71y
         GYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks4Sd+0JxxDpqRkpXg5iGmHlGBA+0HJ4sfY/7YXtnEQ=;
        b=vgQIeiarvhhl12bTznfOhvO0vOUxemYUB4lz0VwSqZ7M5YFQGnHWt9CasATVdScsD3
         LuSHsMwNe2DrX+LSWp3Ho+NVmjnA/GspgFY7XpZb+SbItnbL7+y4UAsB8/b3c8Eb8HXi
         jZI/6ac76CJz+kXG9tJn7jnAWK2kWkoAcg0eJ5XBJR1NoIXVxOFQkBzdDyfEagBTn+Rd
         EI6Z+hfsgjnj8vjH0IPcgqZRPPRClPsiKj+siTnCb7NdV+2fV0GPK4L9eLyKS3mvSZeX
         0BASNYYDJI9tPNZ+khzxadeKGEINsf6Mqnw4MwTzhK1/MJBIirv5Aevah0UoCKFbkQ4D
         NDaA==
X-Gm-Message-State: ANoB5plpMNPzD8VmAB1nMypL85PKnk3nr7y4dqVZL06ffowL6qLmcs7P
        5JZvwx1g2OtgdKLgd6L2xbU9h4va09lgOkYo
X-Google-Smtp-Source: AA0mqf5/ihzWtNo3Nz7Lxe8s5ahL++r75kLMqOSvyLc4FKu35FE99mM943xm72SYVMiKiCElrWzhVThLslEqhkwk
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:9403:b0:218:6a4e:e44a with SMTP
 id r3-20020a17090a940300b002186a4ee44amr93942914pjo.6.1670282634468; Mon, 05
 Dec 2022 15:23:54 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:38 +0000
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-4-vannapurve@google.com>
Subject: [V2 PATCH 3/6] KVM: selftests: x86: Add IS_ALIGNED/IS_PAGE_ALIGNED helpers
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Add IS_ALIGNED/IS_PAGE_ALIGNED helpers for selftests.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h    | 3 +++
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 4ad99f295f2a..7ba32471df50 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -170,6 +170,9 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
 #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
 
+/* @a is a power of 2 value */
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
 struct vm_guest_mode_params {
 	unsigned int pa_bits;
 	unsigned int va_bits;
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 5d310abe6c3f..4d5dd9a467e1 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -279,6 +279,7 @@ static inline unsigned int x86_model(unsigned int eax)
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
+#define IS_PAGE_ALIGNED(x)	IS_ALIGNED(x, PAGE_SIZE)
 
 #define HUGEPAGE_SHIFT(x)	(PAGE_SHIFT + (((x) - 1) * 9))
 #define HUGEPAGE_SIZE(x)	(1UL << HUGEPAGE_SHIFT(x))
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

