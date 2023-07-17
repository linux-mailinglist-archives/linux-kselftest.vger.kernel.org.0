Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64D755B8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGQGZL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGQGYu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9DE10F0;
        Sun, 16 Jul 2023 23:24:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6687466137bso2559711b3a.0;
        Sun, 16 Jul 2023 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575059; x=1692167059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCeTe38A90jfPJyG3hYITaHvW8Yih1iw621ZZ3nJC5U=;
        b=GJXR8DVQlIaakajHyVXDghyDXaomxIJNgBFt9z15tAHEG0KbGVBE44HbxTrSc9Bj/A
         Jer5k2x6zyHrdXOQwFkE3d+VOJXwxAhEsbX8qB++xRx7w1ASxqgakT5A+Litotlz73Xf
         kGHZuGg5gS8ZNRGWRXtyAxUXaZ+JoplwbsU6xdMUDL3S13LiHYA5wl/rN070gTL4dNHj
         OGhn5TPCbapgfLIrRNiwNgVHyqKzL2bJOmsJhYXPzvOC7l06UT614UghbLIItdcTkR6w
         eQkFjtlcfPJ3buDPgriBw4TQ0IoS6aGLvL0EaZiBrTYCeY0MpPbGVXK/bBdnh5S7kAJV
         rCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575059; x=1692167059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCeTe38A90jfPJyG3hYITaHvW8Yih1iw621ZZ3nJC5U=;
        b=eIX3yP2k2162aFahcspqaDCxb5VSvWBQJDB4RU/ABXwPmxBP1g74LwcW9Rbm4qZLf0
         Vyxk7VcGPenOWNakopRQ/yNhylo2WS83mRuXHS1gDkRrGf7fLSRH5iUJFMEkSHkZb0Ry
         tl2hyNBRwKv4M5MhbyqCyfVWZWCfA39SlsIq2sThqG3G2SmkX/a5EACc9L/w29D1VUXf
         LdSvI7D0gk0EZDnl9cf/Zc1MNuMkcQp2DOfoKflfBAaHccs4Db+doiUY0dF2WioWC0OI
         z7r/vElIbHQTSLiu5D+hYKQmJitbxaK6phdimuLuZ4jgKXxVjMkSCyuc+vkmouBu53xi
         PZlg==
X-Gm-Message-State: ABy/qLa4rjksMpVM4i+Pfmw1U3BuelL2mksEK91XIYDZdAWmsTqHmLqy
        MVS5UhRxVYagZXEXxIHDJqc=
X-Google-Smtp-Source: APBJJlGREx0hjtXLU2porkX28XvHnBuDcr/f5QtSQqB0hrBJ0KnA0pKwEyFAniEEhU206zy5T9VnMg==
X-Received: by 2002:a05:6a20:8e1c:b0:12b:f7ff:9fe5 with SMTP id y28-20020a056a208e1c00b0012bf7ff9fe5mr12872125pzj.49.1689575058696;
        Sun, 16 Jul 2023 23:24:18 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:24:18 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v4 5/6] KVM: selftests: Test if event filter meets expectations on fixed counters
Date:   Mon, 17 Jul 2023 14:23:42 +0800
Message-Id: <20230717062343.3743-6-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717062343.3743-1-cloudliang@tencent.com>
References: <20230717062343.3743-1-cloudliang@tencent.com>
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

Add tests to cover that pmu event_filter works as expected when
it's applied to fixed performance counters, even if there is none
fixed counter exists (e.g. Intel guest pmu version=1 or AMD guest).

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 63f85f583ef8..1872b848f734 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -27,6 +27,7 @@
 #define ARCH_PERFMON_BRANCHES_RETIRED		5
 
 #define NUM_BRANCHES 42
+#define INTEL_PMC_IDX_FIXED		32
 
 /* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
 #define MAX_FILTER_EVENTS		300
@@ -805,6 +806,84 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
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
+	TEST_ASSERT(nr_fixed_counters < sizeof(bitmap),
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
@@ -848,6 +927,7 @@ int main(int argc, char *argv[])
 	kvm_vm_free(vm);
 
 	test_pmu_config_disable(guest_code);
+	test_fixed_counter_bitmap();
 
 	return 0;
 }
-- 
2.39.3

