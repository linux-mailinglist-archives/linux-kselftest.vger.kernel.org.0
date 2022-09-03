Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4F5ABC13
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiICB30 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 21:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiICB3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 21:29:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E7EF026
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 18:29:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id n30-20020a17090a5aa100b001fb0c492d5eso1717734pji.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Sep 2022 18:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=z73aDkGMCmlI5UlM6hgPB3TmsvUYEonnoizWLaQ10cM=;
        b=ECw1ZDr2XDN6n7MI/pOirS6KKSVpbkRIYzRguVWE9Qn8MEmoeF00/Ueh03stpHsVbl
         W9AcXg1hURKhHnHbWvVkp/WGSEOFUwK94hSHwdO4gKTArYVefmm7aLGqvy7+tsjgRAh1
         nxfhtTbOQz4TOwJWp/7nJFHNCHsyISe5wQhtqxsyD2eopKI4CF6/Z6L4F8477MnLoeNi
         I/E5XDj2XPpzbptV2KOKscEHsT+pS+0zIy1F5vjm1dUDGs+prf5LIuyI1nVPh48ydqrs
         2Qk8jy6T1gGiQ0OGtdO1f8ccnrr4wBI2rXx4IUkWsLpyKaHC61hvp/BwNCdlFrzz7yGZ
         cnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=z73aDkGMCmlI5UlM6hgPB3TmsvUYEonnoizWLaQ10cM=;
        b=HIK45aXnax98U8GaDxMCBJn60pFUy8l24VNxTqevp6Pnx24pCGBi9A/s2O4L6MUaXH
         wa8wFgSrL4Tkv5qyHVQQKmUvBP86XZWrlUBuIDVpjK5mTxX3YqmT93rkcWI1iOrfu7dA
         GiV0b8LjSb8RMnUlYZFBlZH+QF5s9G9c41TIxQXL3LtZb4fvj8z6eIZRIPMTEH8y9p6g
         /xqkujwMpe+Nu5IEO5g5GancDNzws+8aIWld1C8/gr2ZehXfN9z+yrpT6NgiUQckwW7q
         tz42tWM2Mzv6A2dmeEMwoo6Cvltrw3agpr1EmmImkfRqgBS+GALbp4N0d3bTXiMBmogE
         RXjQ==
X-Gm-Message-State: ACgBeo3dPZnYjkR33aTvurjcIU9f1xnOOzDYUVgYRa+Lrz7yZUQRqHjq
        C9n44XcigT1vA/xOAunzJqDqhn26GnDNiVN7
X-Google-Smtp-Source: AA6agR5GEqO+ROXViZrVrjXt/RbouehkIMHgj/lssZadxdJ3pYMrGUVuIFoqmCc00zfNKczlYjvjqs9GkGd4am1j
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a05:6a00:15ce:b0:537:24ee:cbcf with
 SMTP id o14-20020a056a0015ce00b0053724eecbcfmr38000779pfu.30.1662168549660;
 Fri, 02 Sep 2022 18:29:09 -0700 (PDT)
Date:   Sat,  3 Sep 2022 01:28:45 +0000
In-Reply-To: <20220903012849.938069-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220903012849.938069-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903012849.938069-2-vannapurve@google.com>
Subject: [V1 PATCH 1/5] selftests: kvm: move common startup logic to kvm_util.c
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, drjones@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Consolidate common startup logic in one place by implementing a single main
function for all selftests within kvm_util.c.

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
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c       |  5 +----
 tools/testing/selftests/kvm/aarch64/debug-exceptions.c |  2 +-
 tools/testing/selftests/kvm/aarch64/get-reg-list.c     |  2 +-
 tools/testing/selftests/kvm/aarch64/hypercalls.c       |  4 +---
 tools/testing/selftests/kvm/aarch64/psci_test.c        |  2 +-
 .../testing/selftests/kvm/aarch64/vcpu_width_config.c  |  2 +-
 tools/testing/selftests/kvm/aarch64/vgic_init.c        |  2 +-
 tools/testing/selftests/kvm/aarch64/vgic_irq.c         |  5 +----
 .../testing/selftests/kvm/access_tracking_perf_test.c  |  4 +---
 tools/testing/selftests/kvm/demand_paging_test.c       |  7 ++-----
 tools/testing/selftests/kvm/dirty_log_perf_test.c      |  4 +---
 tools/testing/selftests/kvm/dirty_log_test.c           |  4 +---
 tools/testing/selftests/kvm/hardware_disable_test.c    |  2 +-
 tools/testing/selftests/kvm/include/kvm_util_base.h    |  5 +++++
 tools/testing/selftests/kvm/kvm_binary_stats_test.c    |  3 +--
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c     |  4 +---
 tools/testing/selftests/kvm/kvm_page_table_test.c      |  4 +---
 tools/testing/selftests/kvm/lib/kvm_util.c             | 10 ++++++++++
 tools/testing/selftests/kvm/lib/sparsebit.c            |  2 +-
 tools/testing/selftests/kvm/max_guest_memory_test.c    |  2 +-
 .../selftests/kvm/memslot_modification_stress_test.c   |  4 +---
 tools/testing/selftests/kvm/memslot_perf_test.c        |  9 ++-------
 tools/testing/selftests/kvm/rseq_test.c                |  7 +------
 tools/testing/selftests/kvm/s390x/memop.c              |  4 +---
 tools/testing/selftests/kvm/s390x/resets.c             |  4 +---
 tools/testing/selftests/kvm/s390x/sync_regs_test.c     |  5 +----
 tools/testing/selftests/kvm/s390x/tprot.c              |  2 +-
 tools/testing/selftests/kvm/set_memory_region_test.c   |  7 +------
 tools/testing/selftests/kvm/steal_time.c               |  4 +---
 .../testing/selftests/kvm/system_counter_offset_test.c |  2 +-
 tools/testing/selftests/kvm/x86_64/amx_test.c          |  2 +-
 tools/testing/selftests/kvm/x86_64/cpuid_test.c        |  2 +-
 .../testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c |  6 +-----
 tools/testing/selftests/kvm/x86_64/debug_regs.c        |  4 +---
 .../testing/selftests/kvm/x86_64/emulator_error_test.c |  7 +------
 tools/testing/selftests/kvm/x86_64/evmcs_test.c        |  2 +-
 .../testing/selftests/kvm/x86_64/fix_hypercall_test.c  |  2 +-
 .../selftests/kvm/x86_64/get_msr_index_features.c      |  2 +-
 tools/testing/selftests/kvm/x86_64/hyperv_clock.c      |  2 +-
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c      |  7 +------
 tools/testing/selftests/kvm/x86_64/hyperv_features.c   |  2 +-
 tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c   |  2 +-
 tools/testing/selftests/kvm/x86_64/kvm_clock_test.c    |  2 +-
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c       |  2 +-
 .../testing/selftests/kvm/x86_64/max_vcpuid_cap_test.c |  3 +--
 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c |  4 +---
 .../testing/selftests/kvm/x86_64/monitor_mwait_test.c  |  3 +--
 .../testing/selftests/kvm/x86_64/nx_huge_pages_test.c  |  4 +---
 .../testing/selftests/kvm/x86_64/platform_info_test.c  |  7 +------
 .../selftests/kvm/x86_64/pmu_event_filter_test.c       |  7 +------
 tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c   |  2 +-
 tools/testing/selftests/kvm/x86_64/set_sregs_test.c    |  7 +------
 tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c |  3 +--
 tools/testing/selftests/kvm/x86_64/smm_test.c          |  2 +-
 tools/testing/selftests/kvm/x86_64/state_test.c        |  2 +-
 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c  |  3 +--
 .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c |  7 +------
 tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c   |  3 +--
 tools/testing/selftests/kvm/x86_64/sync_regs_test.c    |  7 +------
 .../selftests/kvm/x86_64/triple_fault_event_test.c     |  2 +-
 tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c     |  4 +---
 tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c  |  3 +--
 .../testing/selftests/kvm/x86_64/ucna_injection_test.c |  2 +-
 tools/testing/selftests/kvm/x86_64/userspace_io_test.c |  6 +-----
 .../selftests/kvm/x86_64/userspace_msr_exit_test.c     |  7 +------
 .../selftests/kvm/x86_64/vmx_apic_access_test.c        |  3 +--
 .../selftests/kvm/x86_64/vmx_close_while_nested_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/vmx_dirty_log_test.c  |  2 +-
 .../x86_64/vmx_exception_with_invalid_guest_state.c    |  2 +-
 .../kvm/x86_64/vmx_invalid_nested_guest_state.c        |  2 +-
 tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c     |  2 +-
 .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c |  3 +--
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c |  2 +-
 .../selftests/kvm/x86_64/vmx_preemption_timer_test.c   |  2 +-
 .../selftests/kvm/x86_64/vmx_set_nested_state_test.c   |  3 +--
 .../testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c |  3 +--
 tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c    |  4 +---
 tools/testing/selftests/kvm/x86_64/xapic_state_test.c  |  2 +-
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c   |  3 +--
 tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c   |  3 +--
 tools/testing/selftests/kvm/x86_64/xss_msr_test.c      |  2 +-
 81 files changed, 96 insertions(+), 199 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 574eb73f0e90..ecb2e7011b1c 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -458,13 +458,10 @@ static bool parse_args(int argc, char *argv[])
 	return false;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);
 
diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index 2ee35cf9801e..f0aafa9a7cfc 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -246,7 +246,7 @@ static int debug_version(struct kvm_vcpu *vcpu)
 	return id_aa64dfr0 & 0xf;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index d287dd2cac0a..abae4f44638d 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -596,7 +596,7 @@ static struct vcpu_config *parse_config(const char *config)
 	return c;
 }
 
-int main(int ac, char **av)
+void __main(int argc, char *argv[])
 {
 	struct vcpu_config *c, *sel = NULL;
 	int i, ret = 0;
diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
index a39da3fe4952..afa6843c7efa 100644
--- a/tools/testing/selftests/kvm/aarch64/hypercalls.c
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -304,10 +304,8 @@ static void test_run(void)
 	kvm_vm_free(vm);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
-	setbuf(stdout, NULL);
-
 	test_run();
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index f7621f6e938e..4bdbe22d44aa 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -189,7 +189,7 @@ static void host_test_system_suspend(void)
 	kvm_vm_free(vm);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_SYSTEM_SUSPEND));
 
diff --git a/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c b/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c
index 80b74c6f152b..ec9485bbb307 100644
--- a/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c
+++ b/tools/testing/selftests/kvm/aarch64/vcpu_width_config.c
@@ -76,7 +76,7 @@ static int add_2vcpus_init_2vcpus(struct kvm_vcpu_init *init0,
  * The other is running KVM_CREATE_VCPU and KVM_ARM_VCPU_INIT for a vCPU,
  * and then run those commands for another vCPU.
  */
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu_init init0, init1;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index e05ecb31823f..3ae1b51ad80b 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -687,7 +687,7 @@ void run_tests(uint32_t gic_dev_type)
 	}
 }
 
-int main(int ac, char **av)
+void __main(int argc, char *argv[])
 {
 	int ret;
 	int pa_bits;
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 17417220a083..66943323d6da 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -810,7 +810,7 @@ static void help(const char *name)
 	exit(1);
 }
 
-int main(int argc, char **argv)
+void __main(int argc, char *argv[])
 {
 	uint32_t nr_irqs = 64;
 	bool default_args = true;
@@ -818,9 +818,6 @@ int main(int argc, char **argv)
 	int opt;
 	bool eoi_split = false;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	while ((opt = getopt(argc, argv, "hn:e:l:")) != -1) {
 		switch (opt) {
 		case 'n':
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 1c2749b1481a..3548fc537d8c 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -340,7 +340,7 @@ static void help(char *name)
 	exit(0);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct test_params params = {
 		.backing_src = DEFAULT_VM_MEM_SRC,
@@ -382,6 +382,4 @@ int main(int argc, char *argv[])
 	close(page_idle_fd);
 
 	for_each_guest_mode(run_test, &params);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 779ae54f89c4..dca61fb5c77b 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -393,7 +393,7 @@ static void help(char *name)
 	exit(0);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 	struct test_params p = {
@@ -447,18 +447,15 @@ int main(int argc, char *argv[])
 	}
 
 	for_each_guest_mode(run_test, &p);
-
-	return 0;
 }
 
 #else /* __NR_userfaultfd */
 
 #warning "missing __NR_userfaultfd definition"
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	print_skip("__NR_userfaultfd must be present for userfaultfd test");
-	return KSFT_SKIP;
 }
 
 #endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index f99e39a672d3..87fb7e2cb033 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -387,7 +387,7 @@ static void help(char *name)
 	exit(0);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 	struct test_params p = {
@@ -460,6 +460,4 @@ int main(int argc, char *argv[])
 	pr_info("Test iterations: %"PRIu64"\n",	p.iterations);
 
 	for_each_guest_mode(run_test, &p);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 9c883c94d478..1268741654d8 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -838,7 +838,7 @@ static void help(char *name)
 	exit(0);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct test_params p = {
 		.iterations = TEST_HOST_LOOP_N,
@@ -920,6 +920,4 @@ int main(int argc, char *argv[])
 		host_log_mode = host_log_mode_option;
 		for_each_guest_mode(run_test, &p);
 	}
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index f5d59b9934f1..919d943e640c 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -151,7 +151,7 @@ void wait_for_child_setup(pid_t pid)
 	}
 }
 
-int main(int argc, char **argv)
+void __main(int argc, char *argv[])
 {
 	uint32_t i;
 	int s, r;
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 24fde97f6121..9e521d1c8afe 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -834,4 +834,9 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
 	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
 }
 
+/*
+ * API to be implemented by all the selftests.
+ */
+void __main(int argc, char *argv[]);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 0b45ac593387..8ba284006e27 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -204,7 +204,7 @@ static void vcpu_stats_test(struct kvm_vcpu *vcpu)
  * created for testing.
  */
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int i, j;
 	struct kvm_vcpu **vcpus;
@@ -250,5 +250,4 @@ int main(int argc, char *argv[])
 	for (i = 0; i < max_vm; ++i)
 		kvm_vm_free(vms[i]);
 	free(vms);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
index 31b3cb24b9a7..d3843606bfbc 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -37,7 +37,7 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
 	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int kvm_max_vcpu_id = kvm_check_cap(KVM_CAP_MAX_VCPU_ID);
 	int kvm_max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
@@ -89,6 +89,4 @@ int main(int argc, char *argv[])
 	if (kvm_max_vcpu_id > kvm_max_vcpus)
 		test_vcpu_creation(
 			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index f42c6ac6d71d..895de52fea97 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -438,7 +438,7 @@ static void help(char *name)
 	puts("");
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 	struct test_params p = {
@@ -476,6 +476,4 @@ int main(int argc, char *argv[])
 	}
 
 	for_each_guest_mode(run_test, &p);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9889fe0d8919..2e611a021c6e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1979,3 +1979,13 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		break;
 	}
 }
+
+int main(int argc, char *argv[])
+{
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	__main(argc, argv);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 50e0cf41a7dd..6c76507dfc9e 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -2071,7 +2071,7 @@ uint64_t get64(void)
 	return (x << 8) | get8();
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	s = sparsebit_alloc();
 	for (;;) {
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index 9a6e4f3ad6b5..72753dadf277 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -153,7 +153,7 @@ static void calc_default_nr_vcpus(void)
 	TEST_ASSERT(nr_vcpus > 0, "Uh, no CPUs?");
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	/*
 	 * Skip the first 4gb and slot0.  slot0 maps <1gb and is used to back
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 6ee7e1dde404..e656c680596f 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -139,7 +139,7 @@ static void help(char *name)
 	exit(0);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 	int opt;
@@ -185,6 +185,4 @@ int main(int argc, char *argv[])
 	}
 
 	for_each_guest_mode(run_test, &p);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 44995446d942..f5d630729930 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -995,7 +995,7 @@ static bool test_loop(const struct test_data *data,
 	return true;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct test_args targs = {
 		.tfirst = 0,
@@ -1007,11 +1007,8 @@ int main(int argc, char *argv[])
 	struct test_result rbestslottime;
 	int tctr;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	if (!parse_args(argc, argv, &targs))
-		return -1;
+		exit(-1);
 
 	rbestslottime.slottimens = 0;
 	for (tctr = targs.tfirst; tctr <= targs.tlast; tctr++) {
@@ -1042,6 +1039,4 @@ int main(int argc, char *argv[])
 		pr_info("Best slot setup time for the whole test area was %ld.%.9lds\n",
 			rbestslottime.slot_runtime.tv_sec,
 			rbestslottime.slot_runtime.tv_nsec);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index fac248a43666..2803bc82b37a 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -198,16 +198,13 @@ static void calc_min_max_cpu(void)
 		       "Only one usable CPU, task migration not possible");
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int r, i, snapshot;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 	u32 cpu, rseq_cpu;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
 	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
 		    strerror(errno));
@@ -277,6 +274,4 @@ int main(int argc, char *argv[])
 	kvm_vm_free(vm);
 
 	rseq_unregister_current_thread();
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 9113696d5178..ffa2119a9c24 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -754,14 +754,12 @@ struct testdef {
 	},
 };
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int extension_cap, idx;
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_MEM_OP));
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
-
 	ksft_print_header();
 
 	ksft_set_plan(ARRAY_SIZE(testlist));
diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index 19486084eb30..517016169dd7 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -291,13 +291,11 @@ struct testdef {
 	{ "clear", test_clear, true },
 };
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	bool has_s390_vcpu_resets = kvm_check_cap(KVM_CAP_S390_VCPU_RESETS);
 	int idx;
 
-	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
-
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(testlist));
 
diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index 3fdb6e2598eb..3590159f7849 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -223,7 +223,7 @@ struct testdef {
 	{ "clear kvm_dirty_regs bits", test_clear_kvm_dirty_regs_bits },
 };
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -231,9 +231,6 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SYNC_REGS));
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	ksft_print_header();
 
 	ksft_set_plan(ARRAY_SIZE(testlist));
diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index a9a0b76e5fa4..893eae876906 100644
--- a/tools/testing/selftests/kvm/s390x/tprot.c
+++ b/tools/testing/selftests/kvm/s390x/tprot.c
@@ -201,7 +201,7 @@ static void guest_code(void)
 	ksft_test_result_pass("" #stage "\n");	\
 })
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 0d55f508d595..5af62d6eb4dc 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -386,15 +386,12 @@ static void test_add_max_memory_regions(void)
 	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 #ifdef __x86_64__
 	int i, loops;
 #endif
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 #ifdef __x86_64__
 	/*
 	 * FIXME: the zero-memslot test fails on aarch64 and s390x because
@@ -419,6 +416,4 @@ int main(int argc, char *argv[])
 	for (i = 0; i < loops; i++)
 		test_delete_memory_region();
 #endif
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index db8967f1a17b..7037d2a08b26 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -239,7 +239,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 	}
 }
 
-int main(int ac, char **av)
+void __main(int ac, char *av[])
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
@@ -317,6 +317,4 @@ int main(int ac, char **av)
 			steal_time_dump(vm, i);
 		}
 	}
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
index 1c274933912b..bc0a1a652f74 100644
--- a/tools/testing/selftests/kvm/system_counter_offset_test.c
+++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
@@ -114,7 +114,7 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	}
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index dadcbad10a1d..fb4b64d2e68e 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -294,7 +294,7 @@ void guest_nm_handler(struct ex_regs *regs)
 	GUEST_SYNC(9);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_regs regs1, regs2;
 	struct kvm_vcpu *vcpu;
diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index a6aeee2e62e4..41d27705adee 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -172,7 +172,7 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu)
 	ent->eax = eax;
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	vm_vaddr_t cpuid_gva;
diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 4208487652f8..b5d967a6134f 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -47,7 +47,7 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
@@ -57,9 +57,6 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVE));
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
@@ -90,5 +87,4 @@ int main(int argc, char *argv[])
 
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 7ef99c3359a0..40fe07a4f911 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -75,7 +75,7 @@ static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_guest_debug debug;
 	unsigned long long target_dr6, target_rip;
@@ -209,6 +209,4 @@ int main(void)
 	TEST_ASSERT(cmd == UCALL_DONE, "UCALL_DONE");
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
index 236e11755ba6..6c967f36bbd3 100644
--- a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
+++ b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
@@ -148,7 +148,7 @@ static uint64_t process_ucall(struct kvm_vcpu *vcpu)
 	return uc.cmd;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -156,9 +156,6 @@ int main(int argc, char *argv[])
 	uint64_t *hva;
 	int rc;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SMALLER_MAXPHYADDR));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
@@ -188,6 +185,4 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(process_ucall(vcpu) == UCALL_DONE, "Expected UCALL_DONE");
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 99bc202243d2..24e02b22e94b 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -196,7 +196,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 	return vcpu;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva = 0;
 
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index b1905d280ef5..d85a0be5d106 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -154,7 +154,7 @@ static void test_fix_hypercall_disabled(void)
 	enter_guest(vcpu);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
 
diff --git a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
index d09b3cbcadc6..04c67a250947 100644
--- a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
+++ b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
@@ -15,7 +15,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	const struct kvm_msr_list *feature_list;
 	int i;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index d576bc8ce823..cece1814098e 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -203,7 +203,7 @@ static void host_check_tsc_msr_rdtsc(struct kvm_vcpu *vcpu)
 		    (t2 - t1) * 100, (r2 - r1) * 1000000000 / tsc_freq);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index e804eb08dff9..506450541fa8 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -128,15 +128,12 @@ void test_hv_cpuid_e2big(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 		    " it should have: %d %d", !vcpu ? "KVM" : "vCPU", ret, errno);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 	const struct kvm_cpuid2 *hv_cpuid_entries;
 	struct kvm_vcpu *vcpu;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_CPUID));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
@@ -172,6 +169,4 @@ int main(int argc, char *argv[])
 
 out:
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 79ab0152d281..c6960281fb85 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -632,7 +632,7 @@ static void guest_test_hcalls_access(void)
 	}
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	pr_info("Testing access to Hyper-V specific MSRs\n");
 	guest_test_msrs_access();
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index a380ad7bb9b3..f54e6f3e8431 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -117,7 +117,7 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
index 813ce282cf56..f94e77ecb6a9 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
@@ -171,7 +171,7 @@ static void check_clocksource(void)
 	fclose(fp);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	vm_vaddr_t pvti_gva;
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index 619655c1a1f3..014ae6dd1482 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -136,7 +136,7 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	}
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/max_vcpuid_cap_test.c b/tools/testing/selftests/kvm/x86_64/max_vcpuid_cap_test.c
index 3cc4b86832fe..8dbb7a48703b 100644
--- a/tools/testing/selftests/kvm/x86_64/max_vcpuid_cap_test.c
+++ b/tools/testing/selftests/kvm/x86_64/max_vcpuid_cap_test.c
@@ -11,7 +11,7 @@
 
 #define MAX_VCPU_ID	2
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 	int ret;
@@ -40,5 +40,4 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(ret < 0, "Creating vCPU with ID > MAX_VCPU_ID should fail");
 
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index fb02581953a3..03684a188a81 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -89,7 +89,7 @@ int get_warnings_count(void)
 	return warnings;
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	int warnings_before, warnings_after;
 
@@ -116,6 +116,4 @@ int main(void)
 	warnings_after = get_warnings_count();
 	TEST_ASSERT(warnings_before == warnings_after,
 		   "Warnings found in kernel.  Run 'dmesg' to inspect them.");
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
index 016070cad36e..cb631d934452 100644
--- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
+++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
@@ -60,7 +60,7 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	uint64_t disabled_quirks;
 	struct kvm_vcpu *vcpu;
@@ -127,5 +127,4 @@ int main(int argc, char *argv[])
 
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index cc6421716400..3a6756a3eda8 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -225,7 +225,7 @@ static void help(char *name)
 	exit(0);
 }
 
-int main(int argc, char **argv)
+void __main(int argc, char *argv[])
 {
 	int reclaim_period_ms = 0, token = 0, opt;
 	bool reboot_permissions = false;
@@ -263,7 +263,5 @@ int main(int argc, char **argv)
 
 	run_test(reclaim_period_ms, false, reboot_permissions);
 	run_test(reclaim_period_ms, true, reboot_permissions);
-
-	return 0;
 }
 
diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index 76417c7d687b..e32e7bc32d3f 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -66,15 +66,12 @@ static void test_msr_platform_info_disabled(struct kvm_vcpu *vcpu)
 			exit_reason_str(run->exit_reason));
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	uint64_t msr_platform_info;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_MSR_PLATFORM_INFO));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
@@ -87,6 +84,4 @@ int main(int argc, char *argv[])
 	vcpu_set_msr(vcpu, MSR_PLATFORM_INFO, msr_platform_info);
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index ea4e259a1e2e..80f58ef7ace4 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -441,15 +441,12 @@ static bool use_amd_pmu(void)
 		 is_zen3(entry->eax));
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	void (*guest_code)(void);
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PMU_EVENT_FILTER));
 
 	TEST_REQUIRE(use_intel_pmu() || use_amd_pmu());
@@ -474,6 +471,4 @@ int main(int argc, char *argv[])
 	kvm_vm_free(vm);
 
 	test_pmu_config_disable(guest_code);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index b25d7556b638..4cc460efb2a4 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -119,7 +119,7 @@ static void check_set_bsp_busy(void)
 	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SET_BOOT_CPU_ID));
 
diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 2bb08bf2125d..a414535d46b2 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -74,7 +74,7 @@ static uint64_t calc_supported_cr4_feature_bits(void)
 	return cr4;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_sregs sregs;
 	struct kvm_vcpu *vcpu;
@@ -82,9 +82,6 @@ int main(int argc, char *argv[])
 	uint64_t cr4;
 	int rc;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	/*
 	 * Create a dummy VM, specifically to avoid doing KVM_SET_CPUID2, and
 	 * use it to verify all supported CR4 bits can be set prior to defining
@@ -132,6 +129,4 @@ int main(int argc, char *argv[])
 		    sregs.apic_base);
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index c7ef97561038..5e7a16a68200 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -393,7 +393,7 @@ static void test_sev_move_copy(void)
 	kvm_vm_free(sev_vm);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_VM_COPY_ENC_CONTEXT_FROM));
@@ -417,5 +417,4 @@ int main(int argc, char *argv[])
 			test_sev_mirror(/* es= */ true);
 		test_sev_mirror_parameters();
 	}
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 1f136a81858e..5f8ebe7795c1 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -126,7 +126,7 @@ void inject_smi(struct kvm_vcpu *vcpu)
 	vcpu_events_set(vcpu, &events);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index ea578971fb9f..3d42c18d4c5f 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -151,7 +151,7 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t nested_gva = 0;
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
index 4a07ba227b99..bd546610e913 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -82,7 +82,7 @@ static void l1_guest_code(struct svm_test_data *svm)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
@@ -123,5 +123,4 @@ int main(int argc, char *argv[])
 	}
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index e637d7736012..a990ff4df5aa 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -192,11 +192,8 @@ static void run_test(bool is_nmi)
 	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	TEST_ASSERT(kvm_cpu_has(X86_FEATURE_NRIPS),
@@ -206,6 +203,4 @@ int main(int argc, char *argv[])
 
 	run_test(false);
 	run_test(true);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
index c3ac45df7483..95ddc2bff332 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
@@ -33,7 +33,7 @@ static void l1_guest_code(struct svm_test_data *svm)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	vm_vaddr_t svm_gva;
@@ -70,5 +70,4 @@ int main(int argc, char *argv[])
 	}
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 9b6db0b0b13e..cb9eed58031b 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -80,7 +80,7 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 #define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
 #define INVALID_SYNC_FIELD 0x80000000
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -90,9 +90,6 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu_events events;
 	int rv, cap;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
 	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
 	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
@@ -235,6 +232,4 @@ int main(int argc, char *argv[])
 		    regs.rbx);
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
index 70b44f0b52fe..d92e1426650b 100644
--- a/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
+++ b/tools/testing/selftests/kvm/x86_64/triple_fault_event_test.c
@@ -38,7 +38,7 @@ void l1_guest_code(struct vmx_pages *vmx)
 	GUEST_DONE();
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index 22d366c697f7..8647453df134 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -86,7 +86,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 	}
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -148,6 +148,4 @@ int main(void)
 	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
index 47139aab7408..143881fd223c 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
@@ -91,7 +91,7 @@ static void *run_vcpu(void *_cpu_nr)
 	return (void *)failures;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_VM_TSC_CONTROL));
 
@@ -114,5 +114,4 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(!failures, "TSC sync failed");
 	pthread_spin_destroy(&create_lock);
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
index a897c7fd8abe..1f466aa6eb26 100644
--- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
+++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
@@ -275,7 +275,7 @@ static struct kvm_vcpu *create_vcpu_with_mce_cap(struct kvm_vm *vm, uint32_t vcp
 	return vcpu;
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct thread_params params;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
index 7316521428f8..7bdf6ac4c2b8 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
@@ -48,7 +48,7 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_regs regs;
@@ -56,9 +56,6 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
@@ -104,5 +101,4 @@ int main(int argc, char *argv[])
 	}
 
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index a4f06370a245..7bdd2b6872d9 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -733,16 +733,11 @@ static void test_msr_permission_bitmap(void)
 	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
 	test_msr_filter_allow();
 
 	test_msr_filter_deny();
 
 	test_msr_permission_bitmap();
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index 5abecf06329e..2d503dce0481 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -69,7 +69,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	unsigned long apic_access_addr = ~0ul;
 	vm_vaddr_t vmx_pages_gva;
@@ -127,5 +127,4 @@ int main(int argc, char *argv[])
 		}
 	}
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
index d79651b02740..bfaf9efe1fe8 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
@@ -45,7 +45,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_ASSERT(0);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva;
 	struct kvm_vcpu *vcpu;
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index 2d8c23d639f7..5ab735bcf8ab 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -64,7 +64,7 @@ void l1_guest_code(struct vmx_pages *vmx)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva = 0;
 	struct vmx_pages *vmx;
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 2641b286b4ed..81ff187a5325 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -106,7 +106,7 @@ static void sigalrm_handler(int sig)
 	}
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
index 6bfb4bb471ca..ae11ec5402bd 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
@@ -50,7 +50,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva;
 	struct kvm_sregs sregs;
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c b/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c
index 322d561b4260..ed34a09a2eeb 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c
@@ -67,7 +67,7 @@ static void vmx_save_restore_msrs_test(struct kvm_vcpu *vcpu)
 	vmx_fixed1_msr_test(vcpu, MSR_IA32_VMX_VMFUNC, -1ull);
 }
 
-int main(void)
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index 465a9434d61c..e3887e08666c 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -137,7 +137,7 @@ static void stable_tsc_check_supported(void)
 	exit(KSFT_SKIP);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -227,5 +227,4 @@ int main(int argc, char *argv[])
 
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 069589c52f41..fded1964251b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -51,7 +51,7 @@ static void guest_code(void)
 	wrmsr(MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	const struct kvm_cpuid_entry2 *entry_a_0;
 	struct kvm_vm *vm;
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index 0efdc05969a5..629b9c4bd6e4 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -151,7 +151,7 @@ void guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva = 0;
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index 41ea7028a1f8..4c1cd8910922 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -243,7 +243,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
 	free(state);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 	struct kvm_nested_state state;
@@ -296,5 +296,4 @@ int main(int argc, char *argv[])
 	test_vmx_nested_state(vcpu);
 
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 5943187e8594..da9628db7ee6 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -122,7 +122,7 @@ static void report(int64_t val)
 		val, val / TSC_ADJUST_VALUE, val % TSC_ADJUST_VALUE);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva;
 	struct kvm_vcpu *vcpu;
@@ -161,5 +161,4 @@ int main(int argc, char *argv[])
 
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
index 3d272d7f961e..fd0d5fbdeae2 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
@@ -391,7 +391,7 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 	}
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	int r;
 	int wait_secs;
@@ -490,6 +490,4 @@ int main(int argc, char *argv[])
 		data->migrations_attempted, data->migrations_completed);
 
 	kvm_vm_free(vm);
-
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 6f7a5ef66718..750a3cb90b24 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -130,7 +130,7 @@ static void test_icr(struct xapic_vcpu *x)
 	__test_icr(x, -1ull & ~APIC_DM_FIXED_MASK);
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct xapic_vcpu x = {
 		.vcpu = NULL,
diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 8a5cb800f50e..f003c8cc2812 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -352,7 +352,7 @@ static void handle_alrm(int sig)
 	TEST_FAIL("IRQ delivery timed out");
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	struct timespec min_ts, max_ts, vm_ts;
 	struct kvm_vm *vm;
@@ -876,5 +876,4 @@ int main(int argc, char *argv[])
 			    "runstate times don't add up");
 	}
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
index 88914d48c65e..b17f36bd41cc 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
@@ -78,7 +78,7 @@ static void guest_code(void)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	unsigned int xen_caps;
 	struct kvm_vcpu *vcpu;
@@ -141,5 +141,4 @@ int main(int argc, char *argv[])
 	}
 done:
 	kvm_vm_free(vm);
-	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
index e0ddf47362e7..86cf86361637 100644
--- a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
@@ -14,7 +14,7 @@
 
 #define MSR_BITS      64
 
-int main(int argc, char *argv[])
+void __main(int argc, char *argv[])
 {
 	bool xss_in_msr_list;
 	struct kvm_vm *vm;
-- 
2.37.2.789.g6183377224-goog

