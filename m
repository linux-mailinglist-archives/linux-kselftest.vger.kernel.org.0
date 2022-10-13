Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A75FD8F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMMNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJMMNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 08:13:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1BFA018
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d18-20020a170902ced200b00180680b8ed1so1217414plg.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha6GYXqOCdxk7Kwn26PWu14QdftbtUnZTnWvsuhKyeA=;
        b=qi6xs+1DmyJ+XBybmwxGghutK/vyh8MrXuZP2ndTxf6cRb8+TjU4GMhNFldA677yVz
         Rf0SCBRboTZI2pemoxW61pbGMK6ObK/hbhFwYIqLjFY7ty5HjlTEuQTES9hwXFQpRoHy
         1FWH6ts/E+Y0/8eoOWVrMoXiY6RxmSsXtF9I2EZO86Oz34Ql1e9SxfMQkimC5elYlYE9
         HfU+alIrI4QinOyiqgxBuM88Nod5g2+3CoYgzWnhqKJIvV+tuIhg5mtVGv7ZCvYig7Kl
         50jiEmjAb/BjPbke1eFLV0JP28WuaBjLUqcOI5fNAP6pCSojeO4RNHFgXQYZkUa2BG2t
         WTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha6GYXqOCdxk7Kwn26PWu14QdftbtUnZTnWvsuhKyeA=;
        b=LOlEJgQ2WEAkAXouD8JKteQNseV6VSP1ty5IPyRLw6nmaqQvmJzfNa7ynriVSg/48l
         E/89EhwVa1Zxl0Sv89XUxaNlrpvIZPvFHgiKjZLBwFHpjcG6LkQ+oU/qelMKPXfP8fbV
         mjD2ktBIv9G1jBA9V1mGUUcrq6Mm1z1D/3JNlQvlC2r0k4zPv+1E6lupRnB5ybFse5gh
         xnQWBnCyzBcgmnFo9YkoCwV1iX3obiS5ldGa3GWuh/rhBtu5Q0yJIAUReuUE+DY2wi5M
         pfGq8SZb4LhgvCr4C5B1Om03hNompaWPHM2Kes2YMsQln71IcefmwG3BaQbl9RooVsdy
         OwNA==
X-Gm-Message-State: ACrzQf3sla2wlgnznEtVyBmOJwnOA06/obb5FbKLyvsxO3kNfCJGSKLI
        t03K3MOFF3eEsPnoYkBs+joAuUouA4dYPoPI
X-Google-Smtp-Source: AMsMyM6/cKOYWKYCXujby+VYTFBw+RQ+E62rbuWrR96IfS1jUPIYkT594VMOKW2g07JkwJ7ORVTIqx195qOcBOKr
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:1306:b0:555:6d3f:11ed with
 SMTP id j6-20020a056a00130600b005556d3f11edmr35687794pfu.55.1665663224332;
 Thu, 13 Oct 2022 05:13:44 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:13:16 +0000
In-Reply-To: <20221013121319.994170-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221013121319.994170-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221013121319.994170-2-vannapurve@google.com>
Subject: [V3 PATCH 1/4] KVM: selftests: move common startup logic to kvm_util.c
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>,
        Andrew Jones <andrew.jones@linux.dev>
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

Consolidate common startup logic in one place by implementing a single
setup function with __attribute((constructor)) for all selftests within
kvm_util.c.

This allows moving logic like:
        /* Tell stdout not to buffer its content */
        setbuf(stdout, NULL);
to a single file for all selftests.

This will also allow any required setup at entry in future to be done in
common main function.

More context is discussed at:
https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c            | 3 ---
 tools/testing/selftests/kvm/aarch64/hypercalls.c            | 2 --
 tools/testing/selftests/kvm/aarch64/vgic_irq.c              | 3 ---
 tools/testing/selftests/kvm/lib/kvm_util.c                  | 6 ++++++
 tools/testing/selftests/kvm/memslot_perf_test.c             | 3 ---
 tools/testing/selftests/kvm/rseq_test.c                     | 3 ---
 tools/testing/selftests/kvm/s390x/memop.c                   | 2 --
 tools/testing/selftests/kvm/s390x/resets.c                  | 2 --
 tools/testing/selftests/kvm/s390x/sync_regs_test.c          | 3 ---
 tools/testing/selftests/kvm/set_memory_region_test.c        | 3 ---
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c    | 3 ---
 tools/testing/selftests/kvm/x86_64/emulator_error_test.c    | 3 ---
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c           | 3 ---
 tools/testing/selftests/kvm/x86_64/platform_info_test.c     | 3 ---
 tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c  | 3 ---
 tools/testing/selftests/kvm/x86_64/set_sregs_test.c         | 3 ---
 .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c      | 3 ---
 tools/testing/selftests/kvm/x86_64/sync_regs_test.c         | 3 ---
 tools/testing/selftests/kvm/x86_64/userspace_io_test.c      | 3 ---
 .../testing/selftests/kvm/x86_64/userspace_msr_exit_test.c  | 3 ---
 20 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 574eb73f0e90..07836bd2672b 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -462,9 +462,6 @@ int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);
 
diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
index a39da3fe4952..6463fd118429 100644
--- a/tools/testing/selftests/kvm/aarch64/hypercalls.c
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -306,8 +306,6 @@ static void test_run(void)
 
 int main(void)
 {
-	setbuf(stdout, NULL);
-
 	test_run();
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 17417220a083..3f204f2e93bf 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -818,9 +818,6 @@ int main(int argc, char **argv)
 	int opt;
 	bool eoi_split = false;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	while ((opt = getopt(argc, argv, "hn:e:l:")) != -1) {
 		switch (opt) {
 		case 'n':
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f1cb1627161f..37d7d144c74e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2021,3 +2021,9 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		break;
 	}
 }
+
+void __attribute((constructor)) kvm_selftest_init(void)
+{
+	/* Tell stdout not to buffer its content. */
+	setbuf(stdout, NULL);
+}
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 44995446d942..f7ba77ff45c9 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -1007,9 +1007,6 @@ int main(int argc, char *argv[])
 	struct test_result rbestslottime;
 	int tctr;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	if (!parse_args(argc, argv, &targs))
 		return -1;
 
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 6f88da7e60be..18297b803159 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -205,9 +205,6 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	u32 cpu, rseq_cpu;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
 		    strerror(errno));
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 9113696d5178..3fd81e58f40c 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -760,8 +760,6 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
-
 	ksft_print_header();
 
 	ksft_set_plan(ARRAY_SIZE(testlist));
diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index 19486084eb30..e41e2cb8ffa9 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -296,8 +296,6 @@ int main(int argc, char *argv[])
 	bool has_s390_vcpu_resets = kvm_check_cap(KVM_CAP_S390_VCPU_RESETS);
 	int idx;
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
-
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(testlist));
 
diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index 3fdb6e2598eb..2ddde41c44ba 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -231,9 +231,6 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SYNC_REGS));
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	ksft_print_header();
 
 	ksft_set_plan(ARRAY_SIZE(testlist));
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 0d55f508d595..614141d6e53d 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -392,9 +392,6 @@ int main(int argc, char *argv[])
 	int i, loops;
 #endif
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 #ifdef __x86_64__
 	/*
 	 * FIXME: the zero-memslot test fails on aarch64 and s390x because
diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 4208487652f8..1027a671c7d3 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -57,9 +57,6 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVE));
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
diff --git a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
index 236e11755ba6..3334adcfd591 100644
--- a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
+++ b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
@@ -156,9 +156,6 @@ int main(int argc, char *argv[])
 	uint64_t *hva;
 	int rc;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SMALLER_MAXPHYADDR));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index e804eb08dff9..5c27efbf405e 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -134,9 +134,6 @@ int main(int argc, char *argv[])
 	const struct kvm_cpuid2 *hv_cpuid_entries;
 	struct kvm_vcpu *vcpu;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_CPUID));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index 76417c7d687b..310a104d94f0 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -72,9 +72,6 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 	uint64_t msr_platform_info;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_MSR_PLATFORM_INFO));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index ea4e259a1e2e..a6ffa245c897 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -447,9 +447,6 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_FILTER));
 
 	TEST_REQUIRE(use_intel_pmu() || use_amd_pmu());
diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 2bb08bf2125d..a284fcef6ed7 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -82,9 +82,6 @@ int main(int argc, char *argv[])
 	uint64_t cr4;
 	int rc;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	/*
 	 * Create a dummy VM, specifically to avoid doing KVM_SET_CPUID2, and
 	 * use it to verify all supported CR4 bits can be set prior to defining
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index e637d7736012..e497ace629c1 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -194,9 +194,6 @@ static void run_test(bool is_nmi)
 
 int main(int argc, char *argv[])
 {
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	TEST_ASSERT(kvm_cpu_has(X86_FEATURE_NRIPS),
diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 9b6db0b0b13e..d2f9b5bdfab2 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -90,9 +90,6 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu_events events;
 	int rv, cap;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
 	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
 	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
index 7316521428f8..91076c9787b4 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
@@ -56,9 +56,6 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index a4f06370a245..8ef5c8b25e95 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -735,9 +735,6 @@ static void test_msr_permission_bitmap(void)
 
 int main(int argc, char *argv[])
 {
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	test_msr_filter_allow();
 
 	test_msr_filter_deny();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

