Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B07B0FE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjI1AUN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 20:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjI1AUL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 20:20:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB41122
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8134eb83so151663127b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695860409; x=1696465209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=apwOiyl24ZAzh9ksVSTWSskudG0FdMibqgJzxKGTzAQ=;
        b=Zze5OchnMhY/xpYjX8HB/FriVX6nu+cRHKXB4vZY7gxJR3iPIPmqih7gNJ4BXITsmA
         ceEJtB+pIiM2mmIU6ErKSr65I4vDLO1zY7uxe0vE9L2YMttnem4Ib3Jo3z2M7Ju+pPz8
         YD6Zq2x56OMgXe/GKQfXOsNEFXWgMjVxZD5xz5DLZs7liJIKDUY8Uas7E8OguTdZRLLW
         SWptk3wTbS1K/mmQwdQb9iMOAytZ5Cnjak5CQu/CgZ9MDf0JiO+I+zrMCYBYyucb1XLM
         vA+715O0al/OePUImkKVPLPJULnRZj1WbmYUuiPAU88J8LG9CvfXiJ53yrymyuObbysT
         BAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860409; x=1696465209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apwOiyl24ZAzh9ksVSTWSskudG0FdMibqgJzxKGTzAQ=;
        b=iC/YJpL+blTEu49dp7J6WF6Z/KB0vZobK9s9aPxwL0Xs3wW0NAEePR4G0kIGnwx3A7
         V6ehJkhOiyCF7YZtf/Qc3zgW83m+dkcoc1c1G3XCdd62QinbJKAquoTAm+3eoW4fEYUu
         9ewq6gDfHjRzfCRyChmUGRUo8tXOD2pe84dPm665yst/c1lBAoBu+esUPBnBJq0HXqfV
         OfjwdQM+ALE2P4QckPHF4o0WXZLh8+v9aalObHpm49BDwUr7kCIwtimzHrudKcAPloGh
         421lSc5QEeqfoalNdarA5WyXQZxQJEQZL4n1ierwDKS/hjUGrzBgJ9cx8jdj8XOa10s9
         JNbg==
X-Gm-Message-State: AOJu0Ywpdo6BEOD4/ET5j44WHwsrx2DaNhC5+FtRIUuGjHwrUJXC+eIz
        KekqufjCZigP/hmu8WYhSx0cD6udfOQ=
X-Google-Smtp-Source: AGHT+IFjrvJ2npDBahfPzbZd3vwTKZ6Cm9AffU0wGAefuUEwJ5h8tV0U/szmpVbKu6qLaPMbte7BjNX86SI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b65e:0:b0:586:a58d:2e24 with SMTP id
 h30-20020a81b65e000000b00586a58d2e24mr63304ywk.5.1695860409338; Wed, 27 Sep
 2023 17:20:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Sep 2023 17:19:56 -0700
In-Reply-To: <20230928001956.924301-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230928001956.924301-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928001956.924301-6-seanjc@google.com>
Subject: [PATCH 5/5] KVM: selftests: Force load all supported XSAVE state in
 state test
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend x86's state to forcefully load *all* host-supported xfeatures by
modifying xstate_bv in the saved state.  Stuffing xstate_bv ensures that
the selftest is verifying KVM's full ABI regardless of whether or not the
guest code is successful in getting various xfeatures out of their INIT
state, e.g. see the disaster that is/was MPX.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h       |  9 +++++++++
 tools/testing/selftests/kvm/x86_64/state_test.c    | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 6f66861175ad..25bc61dac5fb 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -922,6 +922,15 @@ static inline bool kvm_pmu_has(struct kvm_x86_pmu_feature feature)
 	       !kvm_cpu_has(feature.anti_feature);
 }
 
+static __always_inline uint64_t kvm_cpu_supported_xcr0(void)
+{
+	if (!kvm_cpu_has_p(X86_PROPERTY_SUPPORTED_XCR0_LO))
+		return 0;
+
+	return kvm_cpu_property(X86_PROPERTY_SUPPORTED_XCR0_LO) |
+	       ((uint64_t)kvm_cpu_property(X86_PROPERTY_SUPPORTED_XCR0_HI) << 32);
+}
+
 static inline size_t kvm_cpuid2_size(int nr_entries)
 {
 	return sizeof(struct kvm_cpuid2) +
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 115b2cdf9279..88b58aab7207 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -230,6 +230,7 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 
 int main(int argc, char *argv[])
 {
+	uint64_t *xstate_bv, saved_xstate_bv;
 	vm_vaddr_t nested_gva = 0;
 	struct kvm_cpuid2 empty_cpuid = {};
 	struct kvm_regs regs1, regs2;
@@ -294,12 +295,25 @@ int main(int argc, char *argv[])
 		 * allow KVM_SET_XSAVE regardless of guest CPUID.  Manually
 		 * load only XSAVE state, MSRs in particular have a much more
 		 * convoluted ABI.
+		 *
+		 * Load two versions of XSAVE state: one with the actual guest
+		 * XSAVE state, and one with all supported features forced "on"
+		 * in xstate_bv, e.g. to ensure that KVM allows loading all
+		 * supported features, even if something goes awry in saving
+		 * the original snapshot.
 		 */
+		xstate_bv = (void *)&((uint8_t *)state->xsave->region)[512];
+		saved_xstate_bv = *xstate_bv;
+
 		vcpuN = __vm_vcpu_add(vm, vcpu->id + 1);
 		vcpu_xsave_set(vcpuN, state->xsave);
+		*xstate_bv = kvm_cpu_supported_xcr0();
+		vcpu_xsave_set(vcpuN, state->xsave);
 
 		vcpu_init_cpuid(vcpuN, &empty_cpuid);
 		vcpu_xsave_set(vcpuN, state->xsave);
+		*xstate_bv = saved_xstate_bv;
+		vcpu_xsave_set(vcpuN, state->xsave);
 
 		kvm_x86_state_cleanup(state);
 
-- 
2.42.0.582.g8ccd20d70d-goog

