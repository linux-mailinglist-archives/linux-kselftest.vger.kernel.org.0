Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502A97773D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjHJJKf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjHJJKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:21 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8CE2129;
        Thu, 10 Aug 2023 02:10:19 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-56c85b723cfso554493eaf.3;
        Thu, 10 Aug 2023 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691658618; x=1692263418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaGQGXVS3Xb/dgWAgI7rZr0EhirlVtsDOIjVVbosZ/k=;
        b=NAUqDsLFpreU3gHZ4wgAAlia3OKZsm0IuaycUTTezGP3/5LbDefIGyuAKSkIEEd0SX
         65K99uXaxN0IU/LjEj+mlulbvtbTjuaWWFbmCcksp+u2mf9EUYzgce5yIFaAZuF+E34a
         lXmphcV1MaH+2rv7vYUEkjFh9TSlskOdzJGyjdnjx1uiXprTcGZBQQeneRmb+PUX6YMd
         8Hcmsqs5dL2uhsBiWRlX88EcbDBBSDZLG7Xu2zTZZ1d5B83yCF41U/vcgtP/gTkYiX+G
         DzIIFQCnnmzI9kx45ptOiilqf+asQpXjefmErEEUMrzMIWWmqp0Ll3kOJoN7VaLKRwLI
         GM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658618; x=1692263418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaGQGXVS3Xb/dgWAgI7rZr0EhirlVtsDOIjVVbosZ/k=;
        b=R2sVGnjGojyz/POIbbwdsGiw5QiWr32mfcE+bqL/u8Bf/olNJ9AQSNnqaPJBqZ+ZW+
         MyOSiZSp/uWsGAJw//7tOI1QGbyhYFY36yY3y+BOb9/WFfgyZv4N67avbUz8aZA7mSJN
         6d13iVNJH12+AWAK/4Xx1i0H9ysOMUh9LJ1+CGklCmtsVY+uU84Vpj64X1nkmDTTPzGT
         mj93ypSV+CP5PhnfOuSPeQ1sE5lq8N0A7yCjsiogpoPEJMcGgVqEhQn4V5vGmbP1Shyp
         cXSouQ/rD3O2EmjUu49Axu+dS9j2eRA7VkidDKnu7wTdya9UnH17IQjkAMQTouztMxCL
         q8nw==
X-Gm-Message-State: AOJu0YxnsAe3S2oRM8s3+ZYDpvtlbsr3wjL5lpZIptgE1GwCGM5czWlS
        CGZNRuldJHFnZM6iY4QknyqmdcKk0CziX/rkiJo=
X-Google-Smtp-Source: AGHT+IFVi/hH3g8Nm6FPOlP2XH/VFJrCbjjW0RQN+wkRyhp1UTQXAG7nVbh0JdJeQD2fskhm/Eplvg==
X-Received: by 2002:a05:6808:185:b0:3a7:49e5:e0da with SMTP id w5-20020a056808018500b003a749e5e0damr1881288oic.26.1691658618324;
        Thu, 10 Aug 2023 02:10:18 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263154aab24sm970704pjb.57.2023.08.10.02.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:18 -0700 (PDT)
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
Subject: [PATCH v6 5/6] KVM: selftests: Test if event filter meets expectations on fixed counters
Date:   Thu, 10 Aug 2023 17:09:44 +0800
Message-Id: <20230810090945.16053-6-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810090945.16053-1-cloudliang@tencent.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8b8bfee11016..732c76c41bb0 100644
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
+		TEST_ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
+
+		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
+						       bitmap);
+		TEST_ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
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

