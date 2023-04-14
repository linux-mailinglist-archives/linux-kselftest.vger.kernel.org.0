Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2206E2188
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjDNLB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjDNLBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D9AF29;
        Fri, 14 Apr 2023 04:01:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so97970pjl.2;
        Fri, 14 Apr 2023 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470084; x=1684062084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItElodv0Lp944jxYhEPXrCk25YJBgGM6Rbhbgi2W32k=;
        b=SvMGD+r2ITG1qpiAbPpsPTCFTcYdnWrFWYTfD0ZUXCCWN7QFe6StxPF3pyfhES5tFw
         PZgtrt6kOgX86I1gF+kniRIIwxGUfKxOy1tDdzL7hdDkUVmOlInGgbTDWo91KvU+vF8d
         7Q+C0lbRLvT/SHDWpQbkBLechCCCjGA6Y+Pt+gnJMvUP6xSUkohLxidk4JtoI7pE/ADb
         fRQVnm1IX4fPMwYB2aOygOjgEX+aGKXQ+unfqAp9gWuNHKs2o3XbLNfLw5FY+XN7cWnd
         nwokUzFkKgA6WycI8xyx39nxAzMhFOOjVWIgE6SlU01zmNEispcI8nJ2aHrGJX5NEzW9
         Zkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470084; x=1684062084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItElodv0Lp944jxYhEPXrCk25YJBgGM6Rbhbgi2W32k=;
        b=VIks7cfoN/qzODy43NVw+MB8Tvhrx/e1Ljbv4i7bFlllpCkGNJuPfuDQjt1GIUX9Ud
         wLqLF9w/3mcxiqULoqYhxAv/w3aA1OomMpZRpL6N7uCHaLtrO2QPBGluBJaT79wE/MS7
         cZQjG6x2rEKyUE1IxkRv+SLvBuHZ85Z7t7SADb6KF6W02YTM+JIwTqcimcxXjdJwnP2E
         gDWs0oH6+cSiJOjPI/kI3PIHE9swDzVJk+jI2ajwT1B7oVQfNt5JTMuzs4+4rT2x/FAB
         PdUswPl2yCl+zCRRc4IN+dow+PQNzgUEMeuxPbcv4y4B4uiobLbmeL3qWB7o8nLFiqPg
         SUEQ==
X-Gm-Message-State: AAQBX9d8UbM/kVyumzby75uSJLFsObFUW5oZ5Z+N4CRctl1wyrtd7ujK
        oUA5x5yuHXoDB9eM1mNCsEBg2Hxr8HuPbyebJcw=
X-Google-Smtp-Source: AKy350Y8LUlibw1gBdE/mFbXYx1KLO3aS0xsM3+vRWOF3qdJp11hpoaMcTSP6tSE8u16E8JVKeBcqA==
X-Received: by 2002:a17:90a:4d09:b0:247:11eb:2941 with SMTP id c9-20020a17090a4d0900b0024711eb2941mr5049990pjg.37.1681470084629;
        Fri, 14 Apr 2023 04:01:24 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:24 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] KVM: selftests: Check if pmu_event_filter meets expectations on fixed ctrs
Date:   Fri, 14 Apr 2023 19:00:54 +0800
Message-Id: <20230414110056.19665-6-cloudliang@tencent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414110056.19665-1-cloudliang@tencent.com>
References: <20230414110056.19665-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add tests to cover that pmu_event_filter works as expected when
it's applied to fixed performance counters, even if there is none
fixed counter exists (e.g. Intel guest pmu version=1 or AMD guest).

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index a3d5c30ce914..0f54c53d7fff 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -31,6 +31,7 @@
 #define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
 #define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)
 #define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
+#define INTEL_PMC_IDX_FIXED 32
 
 /*
  * This is how the event selector and unit mask are stored in an AMD
@@ -817,6 +818,113 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void intel_guest_run_fixed_counters(uint8_t fixed_ctr_idx)
+{
+	for (;;) {
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx, 0);
+
+		/* Only OS_EN bit is enabled for fixed counter[idx]. */
+		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, BIT_ULL(4 * fixed_ctr_idx));
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL,
+		      BIT_ULL(INTEL_PMC_IDX_FIXED + fixed_ctr_idx));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+
+		GUEST_SYNC(rdmsr(MSR_CORE_PERF_FIXED_CTR0 + fixed_ctr_idx));
+	}
+}
+
+static struct kvm_vcpu *new_vcpu(void *guest_code)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	return vcpu;
+}
+
+static void free_vcpu(struct kvm_vcpu *vcpu)
+{
+	kvm_vm_free(vcpu->vm);
+}
+
+static uint64_t test_fixed_ctr_without_filter(struct kvm_vcpu *vcpu)
+{
+	return run_vcpu_to_sync(vcpu);
+}
+
+static const uint32_t actions[] = {
+	KVM_PMU_EVENT_ALLOW,
+	KVM_PMU_EVENT_DENY,
+};
+
+static uint64_t test_fixed_ctr_with_filter(struct kvm_vcpu *vcpu,
+					   uint32_t action,
+					   uint32_t bitmap)
+{
+	struct kvm_pmu_event_filter *f;
+	uint64_t r;
+
+	f = create_pmu_event_filter(0, 0, action, 0, bitmap);
+	r = test_with_filter(vcpu, f);
+	free(f);
+	return r;
+}
+
+static bool fixed_ctr_is_allowed(uint8_t idx, uint32_t action, uint32_t bitmap)
+{
+	return (action == KVM_PMU_EVENT_ALLOW && (bitmap & BIT_ULL(idx))) ||
+		(action == KVM_PMU_EVENT_DENY && !(bitmap & BIT_ULL(idx)));
+}
+
+static void test_fixed_ctr_action_and_bitmap(struct kvm_vcpu *vcpu,
+					     uint8_t fixed_ctr_idx,
+					     uint8_t max_fixed_num)
+{
+	uint8_t i;
+	uint32_t bitmap;
+	uint64_t count;
+	bool expected;
+
+	/*
+	 * Check the fixed performance counter can count normally works when
+	 * KVM userspace doesn't set any pmu filter.
+	 */
+	TEST_ASSERT(max_fixed_num && test_fixed_ctr_without_filter(vcpu),
+		    "Fixed counter does not exist or does not work as expected.");
+
+	for (i = 0; i < ARRAY_SIZE(actions); i++) {
+		for (bitmap = 0; bitmap < BIT_ULL(max_fixed_num); bitmap++) {
+			expected = fixed_ctr_is_allowed(fixed_ctr_idx, actions[i], bitmap);
+			count = test_fixed_ctr_with_filter(vcpu, actions[i], bitmap);
+
+			TEST_ASSERT(expected == !!count,
+				    "Fixed event filter does not work as expected.");
+		}
+	}
+}
+
+static void test_fixed_counter_bitmap(void)
+{
+	struct kvm_vcpu *vcpu;
+	uint8_t idx, max_fixed_num = get_kvm_supported_fixed_num();
+
+	/*
+	 * Check that pmu_event_filter works as expected when it's applied to
+	 * fixed performance counters.
+	 */
+	for (idx = 0; idx < max_fixed_num; idx++) {
+		vcpu = new_vcpu(intel_guest_run_fixed_counters);
+		vcpu_args_set(vcpu, 1, idx);
+		test_fixed_ctr_action_and_bitmap(vcpu, idx, max_fixed_num);
+		free_vcpu(vcpu);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	void (*guest_code)(void);
@@ -860,6 +968,7 @@ int main(int argc, char *argv[])
 	kvm_vm_free(vm);
 
 	test_pmu_config_disable(guest_code);
+	test_fixed_counter_bitmap();
 
 	return 0;
 }
-- 
2.31.1

