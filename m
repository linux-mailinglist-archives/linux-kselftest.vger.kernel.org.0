Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9488D69E4E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Feb 2023 17:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjBUQig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Feb 2023 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjBUQiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Feb 2023 11:38:07 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0062D16A
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:44 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w3-20020aa78583000000b005d244af158eso418383pfn.23
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Feb 2023 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HMhvhuYsZ3myRfljiC/gjTRwZifcMTe4p3PNN7RnFQc=;
        b=KmVIllOgr72sC/pqD6niGV7eoTluq+PS7s7CCPGlsX1a2kPtiFgCkfe/csntWgWF9O
         OmiYudDws7aCektHRVfDdkOlHQnKMwbf59UDCpld140yXaGH+KdKApX6nXhTN/SgZ2nq
         5U1n+Lxme8YZL0X0OOafeKn73deIl7BysH+vQNQw5kIWq78UX6dnOhjQ7IP8rDCLcYIT
         4hN80G10dXWP4zMV4Bjl90+cJk/RDZIBOYURHPeIwUegjZDRIYoNYTggUb3Qzz6fPH+g
         MguyLJitJgtzcDpXLOsQoIfVG2/345V/I7EC3KPaLv8bj/LmBYyfcUSN5ReCIyGhkxhY
         uXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMhvhuYsZ3myRfljiC/gjTRwZifcMTe4p3PNN7RnFQc=;
        b=XUZeQJ/lPXC4tYJk+XejcwGHomgXx4c/AoUmDQtIxxsFrIcp39qO9twiWdfxKd7PKe
         X7UI/2/EjelcBZ6K2PCsLVJY4XxfSwOGLMLoXyLJ/biCKZkekra3i+hRF7nFX4Fhf7wV
         TgvOuvcNOrmd+uO0uX4tXhpE93ZWjFZVmA0mjbNBTPimf+Pundwa3BMi7ndeWSYJfRPv
         kubxFzG1OlSBt7mWh2gL7rrAw9PJ8OprxN6kuMu0MJu4EXQ0glq8sqf7UOGAHXCaMLDQ
         bnKXumM/P0SsylY7p4Qmn5B7cwPiE0KqmHVtLoZ0swt8spSXzT4cJMnfOQqvbbzclsRM
         pl0w==
X-Gm-Message-State: AO0yUKXTppHT7HVRNNlMBVZYSLYhQC+5XqMoG/LVrSj9Qi4Y0dNV6bsL
        z+vYPUjtfjd2n+vUHctTqbWN7t0UKMeU
X-Google-Smtp-Source: AK7set84GVPCvLI6mWm++un/vVhlpwfDQIVN2HL5K5Uy9ESpyg35gAsQNDDeljXg4j72rXVwu8BYtk/LyP5h
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:3445:0:b0:4fb:d8d:2362 with SMTP id
 b66-20020a633445000000b004fb0d8d2362mr748058pga.8.1676997460862; Tue, 21 Feb
 2023 08:37:40 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 21 Feb 2023 16:36:55 +0000
In-Reply-To: <20230221163655.920289-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221163655.920289-14-mizhang@google.com>
Subject: [PATCH v3 13/13] KVM: selftests: x86: Check that XTILEDATA supports XFD
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

From: Aaron Lewis <aaronlewis@google.com>

Check that XTILEDATA supports XFD. In amx_test, add the requirement that
the guest allows the xfeature, XTILEDATA, to be set in XFD. Otherwise, the
test may fail.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 tools/testing/selftests/kvm/x86_64/amx_test.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a6a86c41ed75..4f6d2d31ff34 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -140,6 +140,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
 #define	X86_FEATURE_XFD			KVM_X86_CPU_FEATURE(0xD, 1, EAX, 4)
+#define X86_FEATURE_XTILEDATA_XFD	KVM_X86_CPU_FEATURE(0xD, 18, ECX, 2)
 
 /*
  * Extended Leafs, a.k.a. AMD defined
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 2fd6a8a928d9..2eb265297898 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -257,6 +257,7 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_AMX_TILE));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XTILECFG));
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XTILEDATA));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XTILEDATA_XFD));
 
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.39.2.637.g21b0678d19-goog

