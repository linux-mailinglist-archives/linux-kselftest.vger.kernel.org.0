Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70C6E90E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjDTKtG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDTKsM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA26EA0;
        Thu, 20 Apr 2023 03:46:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1a67bcde3a7so10271305ad.3;
        Thu, 20 Apr 2023 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987610; x=1684579610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m58sQ2zZW4kkVQwmxOu9IKi6UpDywmoKBSwhLDA+62U=;
        b=ePGwN4tL1X/kVDLO7KIqIF1t4QwQRWkV6pdTmYPK78yRK1Ks4nD3e9qD8M8rJBXFiP
         Cu7sXwOigJ1u5doRf/ryzLo16XE2VPt5+ryJmt0wiumswgHIlvLriFXigSzdrW327TbQ
         DBpiruj3fhinapWbo6UtB6Vlnw/Xc9uz8rDA0yflU5a+jTuLOBHLyYOtT77UyZr7nnhQ
         7jDcREmbAAPNRYXWxb7HXFTiFaMReleNPnKzPw5v4lvvfCUIBc9hfd+MSKA1sryuGnFm
         ua3cqEcl4Pq3suom7yqyrnKxnE62p/DTgnYYTdpBQLTB3mBWKrxoDxakZZS71hMFry60
         Dulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987610; x=1684579610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m58sQ2zZW4kkVQwmxOu9IKi6UpDywmoKBSwhLDA+62U=;
        b=jI273tbn0dn25qQSjjK6wbUANbxOgwgKgdUT0ttrXSFAr9tmVjC2pbwnXIDgeBk3Rw
         vZDWg9yB69r49F5p3LlOrDB2EztPmlRFLAr6MwI3Ql/T0+rTd5b2XNI8dRMnFbORp1ct
         nKjpty9h7jDixAiiQ5vNKWUg3YttlYsOfrTFR4IS192EM5h5OCUM0Qnp5jiGzxWihrPF
         nQilPdgEK13chZueL0zpoZUjG5Kz1H9ZMwy/U6ME+QLMt/wcuEJYlimLDkhPopNu8XhA
         /NA+p+rMj8U8HJbSzEOfpfqvVQW+8Rb7fo+bWIHGo1KbFnrRFZgyWbHWYXCKJXnWVI/S
         IKPQ==
X-Gm-Message-State: AAQBX9dbcgMG9iCT+K1ypDBBwWoyd6eem7C3KWNXZP71iX3qGjNtgVKS
        sHC1/iE8IxJORy1yNAS0Jxs=
X-Google-Smtp-Source: AKy350Z6Ua1OcQuBr4eInEUPBjDfMv2rx88wJpK8ERipkHWVd5XIXonkGtexK/9canUWHeGOFKLgxA==
X-Received: by 2002:a17:902:ba8a:b0:1a5:1b94:e63d with SMTP id k10-20020a170902ba8a00b001a51b94e63dmr1058109pls.65.1681987609995;
        Thu, 20 Apr 2023 03:46:49 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:49 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <ljrcore@126.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] KVM: selftests: Check if pmu_event_filter meets expectations on fixed ctrs
Date:   Thu, 20 Apr 2023 18:46:20 +0800
Message-Id: <20230420104622.12504-6-ljrcore@126.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420104622.12504-1-ljrcore@126.com>
References: <20230420104622.12504-1-ljrcore@126.com>
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

