Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F5725F9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbjFGMhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 08:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbjFGMh0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 08:37:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81023173B;
        Wed,  7 Jun 2023 05:37:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-256531ad335so5930397a91.0;
        Wed, 07 Jun 2023 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686141445; x=1688733445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKBwSDV28BdDyvlxEELSUZjctmUqc1iZiO73Q6+SEqk=;
        b=e7XiKZ6YT0Hg++nqCvixqP6FBMgFUTn1fKQnYtOzeLSKeUM+Tldl7Gs7DV+fAgBdxG
         u8R+Hwn2h4b0ZVfaoQnDgs2T5rirQRGiLdrgZdePi+Gx7h9LUP1H1Ef59+5kAJ7ilDVJ
         jdbQnP6oUGhv4R2Dej1N913cvGvkEDn1f7TLTk4ioPRg3LWLX4872AHfXzKxYUJ5JW5l
         nVqDz3iNZ6vTEHg4O7UmeUC4/BhPmFE49MWL6VYVjyLX1AwN4ph5urv7VHi84z56ew6t
         dOh3xnLcH5iOc4z25CY8tLvO+dAb9Elc1JfYJRTAdpF1Yr08x2QETdI8P+j/gnYUl981
         byzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686141445; x=1688733445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKBwSDV28BdDyvlxEELSUZjctmUqc1iZiO73Q6+SEqk=;
        b=XIBOb+NWZhXrk7C2XO6SUYrB8/DXEqK+yZDhddw13Sy3V60WwkhRlKO+aZrrBUFtcw
         LbB7lBqJINaRygZV/QF9ZXwu9ulGNqENBtrmbG/p7IUibmzT/6+wtok74uZNpyw0BL0+
         JKwOlsgjDyjSsyKzbixLldtFq8z20pxmMTDwyICUgXV6qEfpvYQJsfQtI7AVNyYOMMXJ
         c7Bfs7ltAwh6+N2BkMiKIxrPtR6bx/t6gl11Yj883PTk4PJ2rMrs9uGu1jweyfi9JQE+
         lOIb37mudadjI176/rOhjIZYi64S4ODhXwWbMrg3rjrgpU3xQhKgud4NvWdpNGrcX7NM
         cn+g==
X-Gm-Message-State: AC+VfDyY0XHX6N1dCKqxWNp3kICF3ukL1Cq57g+yT2DsSC31+Da0lQP2
        +i8UBDMceGjAgDvG/v/ZneO8fbmECXD9B8FQ
X-Google-Smtp-Source: ACHHUZ4EmFdN073FchFNyguUajQJ6teW03O5Dn8oY1fR4Yu6pXL+7QErbPZS5SQRktoyabKmZrBqSQ==
X-Received: by 2002:a17:90a:af8c:b0:255:9453:3780 with SMTP id w12-20020a17090aaf8c00b0025594533780mr5054331pjq.32.1686141444973;
        Wed, 07 Jun 2023 05:37:24 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id k18-20020a635a52000000b00528db73ed70sm9038904pgm.3.2023.06.07.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:37:24 -0700 (PDT)
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
Subject: [PATCH v3 3/4] KVM: selftests: Check if event filter meets expectations on fixed counters
Date:   Wed,  7 Jun 2023 20:36:59 +0800
Message-Id: <20230607123700.40229-4-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607123700.40229-1-cloudliang@tencent.com>
References: <20230607123700.40229-1-cloudliang@tencent.com>
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

Add tests to cover that pmu event_filter works as expected when
it's applied to fixed performance counters, even if there is none
fixed counter exists (e.g. Intel guest pmu version=1 or AMD guest).

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 7555e0f4290c..72f7fdb821e5 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -824,6 +824,86 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 		    "Setting invalid or non-exist fixed cunters in the fixed bitmap fail.");
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
+	 * Check the fixed performance counter can count normally works when
+	 * KVM userspace doesn't set any pmu filter.
+	 */
+	TEST_ASSERT(run_vcpu_to_sync(vcpu),
+		    "Fixed counter does not exist or does not work as expected.");
+
+	for (i = 0; i < BIT(nr_fixed_counters); i++) {
+		bitmap = BIT(i);
+		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_ALLOW,
+						       bitmap);
+		TEST_ASSERT(!!count == !!(bitmap & BIT(idx)),
+			    "Fixed event filter does not work as expected.");
+
+		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
+						       bitmap);
+		TEST_ASSERT(!!count == !(bitmap & BIT(idx)),
+			    "Fixed event filter does not work as expected.");
+	}
+}
+
+static void test_fixed_counter_bitmap(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	uint8_t idx;
+
+	/*
+	 * Check that pmu_event_filter works as expected when it's applied to
+	 * fixed performance counters.
+	 */
+	for (idx = 0; idx < X86_INTEL_MAX_FIXED_CTR_NUM; idx++) {
+		vm = vm_create_with_one_vcpu(&vcpu,
+					     intel_run_fixed_counter_guest_code);
+		vcpu_args_set(vcpu, 1, idx);
+		__test_fixed_counter_bitmap(vcpu, idx,
+					    X86_INTEL_MAX_FIXED_CTR_NUM);
+		kvm_vm_free(vm);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	void (*guest_code)(void);
@@ -867,6 +947,7 @@ int main(int argc, char *argv[])
 	kvm_vm_free(vm);
 
 	test_pmu_config_disable(guest_code);
+	test_fixed_counter_bitmap();
 
 	return 0;
 }
-- 
2.31.1

