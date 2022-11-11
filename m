Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6693A624FCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiKKBnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiKKBnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:43:01 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583163CE2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id k9-20020a17090a39c900b0021671e97a25so2004254pjf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rskjLkbODIexPxLrJc/USQMyzeu36Ctaw92D6onS+x0=;
        b=ehggVnskMsJgqKKa+6vJjADkOveKoVwH7/SDLjWFxjrT2/eJ+gFgOcbosh6ft2K+Bz
         FmSt0Ekaa5rvorfY8V3mX9X6GX6dM49GHb2rbID2FLAemEpao47sYpnS41mhTDvKDrsd
         FtBibK2GMmyl2cZkLsp0Ja33WMgbVizT9B+JA9VKhvGoS1q/kqvgknv8E0ORnr+DjEWD
         03MSRvi4OKIfz/jP1SFETQ9cOKPVmWFHnB87nvKc/6hHt/43MPaPbC6rul29uhWbKctG
         mUzTWy1qV6qhpjHKGLG6ttfkVpiXKaSBQvzUOTLUc42CfpnaEj3bJ5568/IogSctOckk
         +Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rskjLkbODIexPxLrJc/USQMyzeu36Ctaw92D6onS+x0=;
        b=gZK7soTYrxoMkB/Hzw/td129oIuY1hFuGlQ/vQ2Ix2YN/vfJIyvS9lzlNyhHDCK1zM
         w2sJIzUG4n+AbgflQx8jl28WQGgahCriopFK2rYUbksZBBlVgzx/yq8K12A0MvF4kUXg
         wz/H1MD0clcTWc6KzBZX8gA99rNM+kit/PKfNWJKGE0n1JIZturmaHQqqae2HIVqLvf/
         buL8s6sL7tyOvKnSE5ypc/T23G8gmrGfW/rhJW7PIlskvzpWEWlKMLrDXXmCwUeyXB1T
         oHPyNtoDjFekPnXf2CE21GXdAQxaFu6Vul3+3/6Ye+6h82FbG56JScz57QqS6PEAv+uy
         C7cA==
X-Gm-Message-State: ANoB5pmrR02Zg6aQAnLodNDaPFDnjiTTMYiQs5B0mHEopS8o+vbHUf0L
        B2zjIf81BTFx7RWWjudIDFCc0wrjK04OkkFh
X-Google-Smtp-Source: AA0mqf5fwdMBBuQMRwtryX0dTsTve47Bgf8VZBQbrYiIXNpyfWB8wtQvdSNP3sqrRbCBH44mHJUhkABx1MsdG8zu
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:8b49:0:b0:56b:b37d:9857 with SMTP
 id i9-20020aa78b49000000b0056bb37d9857mr426691pfd.12.1668130979320; Thu, 10
 Nov 2022 17:42:59 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:41 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-4-vannapurve@google.com>
Subject: [V1 PATCH 3/6] KVM: selftests: x86: Add IS_ALIGNED/IS_PAGE_ALIGNED helpers
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
index 5e30f5b461bf..4eecc847d9f9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -168,6 +168,9 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
 #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
 
+/* @a is a power of 2 value */
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
 struct vm_guest_mode_params {
 	unsigned int pa_bits;
 	unsigned int va_bits;
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e8ca0d8a6a7e..62677f266583 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -175,6 +175,7 @@ struct kvm_x86_cpu_feature {
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
+#define IS_PAGE_ALIGNED(x)	IS_ALIGNED(x, PAGE_SIZE)
 
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 #define PTE_GET_PFN(pte)        (((pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
-- 
2.38.1.431.g37b22c650d-goog

