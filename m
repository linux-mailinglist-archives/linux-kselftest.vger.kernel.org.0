Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ED875AD5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGTLsN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjGTLsL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:48:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E032D58;
        Thu, 20 Jul 2023 04:47:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-66869feb7d1so411256b3a.3;
        Thu, 20 Jul 2023 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853672; x=1690458472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVjv2WAK3Cdmf9F59ofePZQ7PJUx/o9HNI9lncLrB+U=;
        b=Uu3WhS+wxAa6/eXFHI/5XnLsQKJ5NdVrQVUTo869pnB7XIlm6BzM3xzFIYicsZ45xl
         yKoIxFYyeuIlEim9kawM+A5rgihebtgseQ+xmOXXh4NaWNZegYAa4jwLQtYTYYyPIdUm
         bZC9JwcvtY4d8muZ3yaoqxSRYThFbXxRQhXaw5bXk/P93rjx7J9/WWJLz0TyCUfGOTRI
         sOMAvTPMYTh1EpXkPDU/IzZtKMjOImzTNEEVXflAKqWyuGoopEzwdXPt801/qyTKjoSy
         PQE9C9DWreVVII+5gPUJdBMZuW/nM2/+y2iAmxn8+i+QFI4ifArrK7Ac35pkbVYhmY/3
         wz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853672; x=1690458472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVjv2WAK3Cdmf9F59ofePZQ7PJUx/o9HNI9lncLrB+U=;
        b=L3f6ux2L4BMgKYB5Hb700F9WB1LPGUhmYPcrgbsMUwfwaIcX4ugwhad5Bm0q4guZVN
         lt9sOQFhS3O/XU/vmyYbwCEvYdQ5eN0aCUs7hAgZ6LEoytrnbEZ+XMs+YqTdIRfU6T6W
         0uCUKP6vsX1oqU84cReVRotNsa0GhzeGWNrN0hctvViv2kInwKDPSRXbMwrQiU51fIaF
         PoUiNLPeQ2zEBckF617oKpwnDgatL8J13ElPwgHZlJc/Byj6pxIaO5vC+fkSg84Q0jmg
         sVrZRij3rWkdNBspZZUxYUrjxtZpWY5ojxMOy0zrjrmspn7LM3XHMCzIuCSkBg9LpYZA
         Nl/Q==
X-Gm-Message-State: ABy/qLbnexZH9e0UU2KVj5hxRyXHWQmC74CFwMf3Zzjl3iuTuxehfzpj
        ZPP34aw8XVTPYCH/ThC8mz0=
X-Google-Smtp-Source: APBJJlHVuHmI6wwuw4vyxxRHzGTtlq9FSgN8Jop9WFnmatGG0tTRgakrr+yPx1UYLsc+NjftNkCDsA==
X-Received: by 2002:a05:6a21:3613:b0:135:38b5:7e4e with SMTP id yg19-20020a056a21361300b0013538b57e4emr1499934pzb.59.1689853672100;
        Thu, 20 Jul 2023 04:47:52 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm1164007plq.18.2023.07.20.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:47:51 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] KVM: selftests: Test if event filter meets expectations on fixed counters
Date:   Thu, 20 Jul 2023 19:47:13 +0800
Message-Id: <20230720114714.34079-6-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720114714.34079-1-cloudliang@tencent.com>
References: <20230720114714.34079-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add tests to cover that pmu event_filter works as expected when it's
applied to fixed performance counters, even if there is none fixed
counter exists (e.g. Intel guest pmu version=1 or AMD guest).

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 8b8bfee11016..a9d44ec210c4 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -27,6 +27,7 @@
 #define ARCH_PERFMON_BRANCHES_RETIRED		5
 
 #define NUM_BRANCHES 42
+#define INTEL_PMC_IDX_FIXED		32
 
 /* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
 #define MAX_FILTER_EVENTS		300
@@ -808,6 +809,84 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	TEST_ASSERT(!r, "Masking non-existent fixed counters should be allowed");
 }
 
+static void intel_run_fixed_counter_guest_code(uint8_t fixed_ctr_idx)
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
+static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
+					       uint32_t action, uint32_t bitmap)
+{
+	struct __kvm_pmu_event_filter f = {
+		.action = action,
+		.fixed_counter_bitmap = bitmap,
+	};
+	do_vcpu_set_pmu_event_filter(vcpu, &f);
+
+	return run_vcpu_to_sync(vcpu);
+}
+
+static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t idx,
+					uint8_t nr_fixed_counters)
+{
+	unsigned int i;
+	uint32_t bitmap;
+	uint64_t count;
+
+	TEST_ASSERT(nr_fixed_counters < sizeof(bitmap) * 8,
+		    "Invalid nr_fixed_counters");
+
+	/*
+	 * Check the fixed performance counter can count normally when KVM
+	 * userspace doesn't set any pmu filter.
+	 */
+	count = run_vcpu_to_sync(vcpu);
+	TEST_ASSERT(count, "Unexpected count value: %ld\n", count);
+
+	for (i = 0; i < BIT(nr_fixed_counters); i++) {
+		bitmap = BIT(i);
+		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_ALLOW,
+						       bitmap);
+		ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
+
+		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
+						       bitmap);
+		ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
+	}
+}
+
+static void test_fixed_counter_bitmap(void)
+{
+	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	uint8_t idx;
+
+	/*
+	 * Check that pmu_event_filter works as expected when it's applied to
+	 * fixed performance counters.
+	 */
+	for (idx = 0; idx < nr_fixed_counters; idx++) {
+		vm = vm_create_with_one_vcpu(&vcpu,
+					     intel_run_fixed_counter_guest_code);
+		vcpu_args_set(vcpu, 1, idx);
+		__test_fixed_counter_bitmap(vcpu, idx, nr_fixed_counters);
+		kvm_vm_free(vm);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	void (*guest_code)(void);
@@ -851,6 +930,7 @@ int main(int argc, char *argv[])
 	kvm_vm_free(vm);
 
 	test_pmu_config_disable(guest_code);
+	test_fixed_counter_bitmap();
 
 	return 0;
 }
-- 
2.39.3

