Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62295750092
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGLIAF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 04:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGLIAD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 04:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885BB10F7
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689148757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iB0v9rwBrusqm+42f3XID0KuRPcsTiK7aKTnlTBA4Y0=;
        b=JBZLXUFGRNubc74zg4atOPLrNbOGAUsTEQt8N4ILWgCZzjdWo8G7edvidltcQRF4MbwNMU
        BVlqsJMELeChJxuA1rvvcOW+Japzf1EhZw8QsEl6kxkAli00nk0eckFBFHpWKAczqbMU8b
        u6XtFL63AziCiOQFOUbF3CXEqqtV6V4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-QhqDt20bMXWcyQF8AHgJgA-1; Wed, 12 Jul 2023 03:59:16 -0400
X-MC-Unique: QhqDt20bMXWcyQF8AHgJgA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C82503C23101;
        Wed, 12 Jul 2023 07:59:15 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79FAB492C13;
        Wed, 12 Jul 2023 07:59:14 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: [PATCH 1/4] KVM: selftests: Rename the ASSERT_EQ macro
Date:   Wed, 12 Jul 2023 09:59:07 +0200
Message-Id: <20230712075910.22480-2-thuth@redhat.com>
In-Reply-To: <20230712075910.22480-1-thuth@redhat.com>
References: <20230712075910.22480-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is already an ASSERT_EQ macro in the file
tools/testing/selftests/kselftest_harness.h, so we currently
can't include test_util.h from the KVM selftests together with
that file. Rename the macro in the KVM selftests to TEST_ASSERT_EQ
to avoid the problem - it is also more similar to the other macros
in test_util.h that way.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/aarch64/aarch32_id_regs.c   |  8 +--
 .../selftests/kvm/aarch64/page_fault_test.c   | 10 +--
 .../testing/selftests/kvm/include/test_util.h |  4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
 .../selftests/kvm/max_guest_memory_test.c     |  2 +-
 tools/testing/selftests/kvm/s390x/cmma_test.c | 62 +++++++++----------
 tools/testing/selftests/kvm/s390x/memop.c     |  6 +-
 tools/testing/selftests/kvm/s390x/tprot.c     |  4 +-
 .../x86_64/dirty_log_page_splitting_test.c    | 18 +++---
 .../x86_64/exit_on_emulation_failure_test.c   |  2 +-
 .../kvm/x86_64/nested_exceptions_test.c       | 12 ++--
 .../kvm/x86_64/recalc_apic_map_test.c         |  6 +-
 .../selftests/kvm/x86_64/tsc_msrs_test.c      | 32 +++++-----
 .../vmx_exception_with_invalid_guest_state.c  |  2 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  3 +-
 .../selftests/kvm/x86_64/xapic_state_test.c   |  8 +--
 .../selftests/kvm/x86_64/xen_vmcall_test.c    | 20 +++---
 17 files changed, 101 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/aarch32_id_regs.c b/tools/testing/selftests/kvm/aarch64/aarch32_id_regs.c
index 4951ac53d1f88..b90580840b228 100644
--- a/tools/testing/selftests/kvm/aarch64/aarch32_id_regs.c
+++ b/tools/testing/selftests/kvm/aarch64/aarch32_id_regs.c
@@ -98,7 +98,7 @@ static void test_user_raz_wi(struct kvm_vcpu *vcpu)
 		uint64_t val;
 
 		vcpu_get_reg(vcpu, reg_id, &val);
-		ASSERT_EQ(val, 0);
+		TEST_ASSERT_EQ(val, 0);
 
 		/*
 		 * Expect the ioctl to succeed with no effect on the register
@@ -107,7 +107,7 @@ static void test_user_raz_wi(struct kvm_vcpu *vcpu)
 		vcpu_set_reg(vcpu, reg_id, BAD_ID_REG_VAL);
 
 		vcpu_get_reg(vcpu, reg_id, &val);
-		ASSERT_EQ(val, 0);
+		TEST_ASSERT_EQ(val, 0);
 	}
 }
 
@@ -127,14 +127,14 @@ static void test_user_raz_invariant(struct kvm_vcpu *vcpu)
 		uint64_t val;
 
 		vcpu_get_reg(vcpu, reg_id, &val);
-		ASSERT_EQ(val, 0);
+		TEST_ASSERT_EQ(val, 0);
 
 		r = __vcpu_set_reg(vcpu, reg_id, BAD_ID_REG_VAL);
 		TEST_ASSERT(r < 0 && errno == EINVAL,
 			    "unexpected KVM_SET_ONE_REG error: r=%d, errno=%d", r, errno);
 
 		vcpu_get_reg(vcpu, reg_id, &val);
-		ASSERT_EQ(val, 0);
+		TEST_ASSERT_EQ(val, 0);
 	}
 }
 
diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index df10f1ffa20d9..e5bb8767d2cb5 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -318,7 +318,7 @@ static int uffd_generic_handler(int uffd_mode, int uffd, struct uffd_msg *msg,
 
 	TEST_ASSERT(uffd_mode == UFFDIO_REGISTER_MODE_MISSING,
 		    "The only expected UFFD mode is MISSING");
-	ASSERT_EQ(addr, (uint64_t)args->hva);
+	TEST_ASSERT_EQ(addr, (uint64_t)args->hva);
 
 	pr_debug("uffd fault: addr=%p write=%d\n",
 		 (void *)addr, !!(flags & UFFD_PAGEFAULT_FLAG_WRITE));
@@ -432,7 +432,7 @@ static void mmio_on_test_gpa_handler(struct kvm_vm *vm, struct kvm_run *run)
 	region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
 	hva = (void *)region->region.userspace_addr;
 
-	ASSERT_EQ(run->mmio.phys_addr, region->region.guest_phys_addr);
+	TEST_ASSERT_EQ(run->mmio.phys_addr, region->region.guest_phys_addr);
 
 	memcpy(hva, run->mmio.data, run->mmio.len);
 	events.mmio_exits += 1;
@@ -631,9 +631,9 @@ static void setup_default_handlers(struct test_desc *test)
 
 static void check_event_counts(struct test_desc *test)
 {
-	ASSERT_EQ(test->expected_events.uffd_faults, events.uffd_faults);
-	ASSERT_EQ(test->expected_events.mmio_exits, events.mmio_exits);
-	ASSERT_EQ(test->expected_events.fail_vcpu_runs, events.fail_vcpu_runs);
+	TEST_ASSERT_EQ(test->expected_events.uffd_faults, events.uffd_faults);
+	TEST_ASSERT_EQ(test->expected_events.mmio_exits, events.mmio_exits);
+	TEST_ASSERT_EQ(test->expected_events.fail_vcpu_runs, events.fail_vcpu_runs);
 }
 
 static void print_test_banner(enum vm_guest_mode mode, struct test_params *p)
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6e9f215ce700..e734e52d8a3a6 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -53,11 +53,11 @@ void test_assert(bool exp, const char *exp_str,
 #define TEST_ASSERT(e, fmt, ...) \
 	test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
 
-#define ASSERT_EQ(a, b) do { \
+#define TEST_ASSERT_EQ(a, b) do { \
 	typeof(a) __a = (a); \
 	typeof(b) __b = (b); \
 	TEST_ASSERT(__a == __b, \
-		    "ASSERT_EQ(%s, %s) failed.\n" \
+		    "TEST_ASSERT_EQ(%s, %s) failed.\n" \
 		    "\t%s is %#lx\n" \
 		    "\t%s is %#lx", \
 		    #a, #b, #a, (unsigned long) __a, #b, (unsigned long) __b); \
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9741a7ff6380f..3170d7a4520be 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -994,7 +994,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
 		alignment = max(backing_src_pagesz, alignment);
 
-	ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
+	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
 
 	/* Add enough memory to align up if necessary */
 	if (alignment > 1)
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/max_guest_memory_test.c
index feaf2be20ff25..6628dc4dda89f 100644
--- a/tools/testing/selftests/kvm/max_guest_memory_test.c
+++ b/tools/testing/selftests/kvm/max_guest_memory_test.c
@@ -55,7 +55,7 @@ static void rendezvous_with_boss(void)
 static void run_vcpu(struct kvm_vcpu *vcpu)
 {
 	vcpu_run(vcpu);
-	ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
 }
 
 static void *vcpu_worker(void *data)
diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
index 1d73e78e8fa77..c8e0a6495a63a 100644
--- a/tools/testing/selftests/kvm/s390x/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
@@ -237,8 +237,8 @@ static void test_get_cmma_basic(void)
 
 	/* GET_CMMA_BITS without CMMA enabled should fail */
 	rc = vm_get_cmma_bits(vm, 0, &errno_out);
-	ASSERT_EQ(rc, -1);
-	ASSERT_EQ(errno_out, ENXIO);
+	TEST_ASSERT_EQ(rc, -1);
+	TEST_ASSERT_EQ(errno_out, ENXIO);
 
 	enable_cmma(vm);
 	vcpu = vm_vcpu_add(vm, 1, guest_do_one_essa);
@@ -247,31 +247,31 @@ static void test_get_cmma_basic(void)
 
 	/* GET_CMMA_BITS without migration mode and without peeking should fail */
 	rc = vm_get_cmma_bits(vm, 0, &errno_out);
-	ASSERT_EQ(rc, -1);
-	ASSERT_EQ(errno_out, EINVAL);
+	TEST_ASSERT_EQ(rc, -1);
+	TEST_ASSERT_EQ(errno_out, EINVAL);
 
 	/* GET_CMMA_BITS without migration mode and with peeking should work */
 	rc = vm_get_cmma_bits(vm, KVM_S390_CMMA_PEEK, &errno_out);
-	ASSERT_EQ(rc, 0);
-	ASSERT_EQ(errno_out, 0);
+	TEST_ASSERT_EQ(rc, 0);
+	TEST_ASSERT_EQ(errno_out, 0);
 
 	enable_dirty_tracking(vm);
 	enable_migration_mode(vm);
 
 	/* GET_CMMA_BITS with invalid flags */
 	rc = vm_get_cmma_bits(vm, 0xfeedc0fe, &errno_out);
-	ASSERT_EQ(rc, -1);
-	ASSERT_EQ(errno_out, EINVAL);
+	TEST_ASSERT_EQ(rc, -1);
+	TEST_ASSERT_EQ(errno_out, EINVAL);
 
 	kvm_vm_free(vm);
 }
 
 static void assert_exit_was_hypercall(struct kvm_vcpu *vcpu)
 {
-	ASSERT_EQ(vcpu->run->exit_reason, 13);
-	ASSERT_EQ(vcpu->run->s390_sieic.icptcode, 4);
-	ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x8300);
-	ASSERT_EQ(vcpu->run->s390_sieic.ipb, 0x5010000);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, 13);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, 4);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa, 0x8300);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipb, 0x5010000);
 }
 
 static void test_migration_mode(void)
@@ -283,8 +283,8 @@ static void test_migration_mode(void)
 
 	/* enabling migration mode on a VM without memory should fail */
 	rc = __enable_migration_mode(vm);
-	ASSERT_EQ(rc, -1);
-	ASSERT_EQ(errno, EINVAL);
+	TEST_ASSERT_EQ(rc, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
 	TEST_ASSERT(!is_migration_mode_on(vm), "migration mode should still be off");
 	errno = 0;
 
@@ -304,8 +304,8 @@ static void test_migration_mode(void)
 
 	/* migration mode when memslots have dirty tracking off should fail */
 	rc = __enable_migration_mode(vm);
-	ASSERT_EQ(rc, -1);
-	ASSERT_EQ(errno, EINVAL);
+	TEST_ASSERT_EQ(rc, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
 	TEST_ASSERT(!is_migration_mode_on(vm), "migration mode should still be off");
 	errno = 0;
 
@@ -314,7 +314,7 @@ static void test_migration_mode(void)
 
 	/* enabling migration mode should work now */
 	rc = __enable_migration_mode(vm);
-	ASSERT_EQ(rc, 0);
+	TEST_ASSERT_EQ(rc, 0);
 	TEST_ASSERT(is_migration_mode_on(vm), "migration mode should be on");
 	errno = 0;
 
@@ -350,7 +350,7 @@ static void test_migration_mode(void)
 	 */
 	vm_mem_region_set_flags(vm, TEST_DATA_TWO_MEMSLOT, KVM_MEM_LOG_DIRTY_PAGES);
 	rc = __enable_migration_mode(vm);
-	ASSERT_EQ(rc, 0);
+	TEST_ASSERT_EQ(rc, 0);
 	TEST_ASSERT(is_migration_mode_on(vm), "migration mode should be on");
 	errno = 0;
 
@@ -394,9 +394,9 @@ static void assert_all_slots_cmma_dirty(struct kvm_vm *vm)
 	};
 	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
 	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
-	ASSERT_EQ(args.count, MAIN_PAGE_COUNT);
-	ASSERT_EQ(args.remaining, TEST_DATA_PAGE_COUNT);
-	ASSERT_EQ(args.start_gfn, 0);
+	TEST_ASSERT_EQ(args.count, MAIN_PAGE_COUNT);
+	TEST_ASSERT_EQ(args.remaining, TEST_DATA_PAGE_COUNT);
+	TEST_ASSERT_EQ(args.start_gfn, 0);
 
 	/* ...and then - after a hole - the TEST_DATA memslot should follow */
 	args = (struct kvm_s390_cmma_log){
@@ -407,9 +407,9 @@ static void assert_all_slots_cmma_dirty(struct kvm_vm *vm)
 	};
 	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
 	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
-	ASSERT_EQ(args.count, TEST_DATA_PAGE_COUNT);
-	ASSERT_EQ(args.start_gfn, TEST_DATA_START_GFN);
-	ASSERT_EQ(args.remaining, 0);
+	TEST_ASSERT_EQ(args.count, TEST_DATA_PAGE_COUNT);
+	TEST_ASSERT_EQ(args.start_gfn, TEST_DATA_START_GFN);
+	TEST_ASSERT_EQ(args.remaining, 0);
 
 	/* ...and nothing else should be there */
 	args = (struct kvm_s390_cmma_log){
@@ -420,9 +420,9 @@ static void assert_all_slots_cmma_dirty(struct kvm_vm *vm)
 	};
 	memset(cmma_value_buf, 0xff, sizeof(cmma_value_buf));
 	vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
-	ASSERT_EQ(args.count, 0);
-	ASSERT_EQ(args.start_gfn, 0);
-	ASSERT_EQ(args.remaining, 0);
+	TEST_ASSERT_EQ(args.count, 0);
+	TEST_ASSERT_EQ(args.start_gfn, 0);
+	TEST_ASSERT_EQ(args.remaining, 0);
 }
 
 /**
@@ -498,11 +498,11 @@ static void assert_cmma_dirty(u64 first_dirty_gfn,
 			      u64 dirty_gfn_count,
 			      const struct kvm_s390_cmma_log *res)
 {
-	ASSERT_EQ(res->start_gfn, first_dirty_gfn);
-	ASSERT_EQ(res->count, dirty_gfn_count);
+	TEST_ASSERT_EQ(res->start_gfn, first_dirty_gfn);
+	TEST_ASSERT_EQ(res->count, dirty_gfn_count);
 	for (size_t i = 0; i < dirty_gfn_count; i++)
-		ASSERT_EQ(cmma_value_buf[0], 0x0); /* stable state */
-	ASSERT_EQ(cmma_value_buf[dirty_gfn_count], 0xff); /* not touched */
+		TEST_ASSERT_EQ(cmma_value_buf[0], 0x0); /* stable state */
+	TEST_ASSERT_EQ(cmma_value_buf[dirty_gfn_count], 0xff); /* not touched */
 }
 
 static void test_get_skip_holes(void)
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 8e4b94d7b8dd9..de73dc0309051 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -281,8 +281,8 @@ enum stage {
 	if (uc.cmd == UCALL_ABORT) {					\
 		REPORT_GUEST_ASSERT_2(uc, "hints: %lu, %lu");		\
 	}								\
-	ASSERT_EQ(uc.cmd, UCALL_SYNC);					\
-	ASSERT_EQ(uc.args[1], __stage);					\
+	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);				\
+	TEST_ASSERT_EQ(uc.args[1], __stage);				\
 })									\
 
 static void prepare_mem12(void)
@@ -808,7 +808,7 @@ static void test_termination(void)
 	HOST_SYNC(t.vcpu, STAGE_IDLED);
 	MOP(t.vm, ABSOLUTE, READ, &teid, sizeof(teid), GADDR(prefix + 168));
 	/* Bits 56, 60, 61 form a code, 0 being the only one allowing for termination */
-	ASSERT_EQ(teid & teid_mask, 0);
+	TEST_ASSERT_EQ(teid & teid_mask, 0);
 
 	kvm_vm_free(t.kvm_vm);
 }
diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index a9a0b76e5fa45..40d3ea16c052f 100644
--- a/tools/testing/selftests/kvm/s390x/tprot.c
+++ b/tools/testing/selftests/kvm/s390x/tprot.c
@@ -191,8 +191,8 @@ static void guest_code(void)
 	get_ucall(__vcpu, &uc);					\
 	if (uc.cmd == UCALL_ABORT)				\
 		REPORT_GUEST_ASSERT_2(uc, "hints: %lu, %lu");	\
-	ASSERT_EQ(uc.cmd, UCALL_SYNC);				\
-	ASSERT_EQ(uc.args[1], __stage);				\
+	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);			\
+	TEST_ASSERT_EQ(uc.args[1], __stage);			\
 })
 
 #define HOST_SYNC(vcpu, stage)			\
diff --git a/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c b/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c
index beb7e2c102113..634c6bfcd5720 100644
--- a/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c
+++ b/tools/testing/selftests/kvm/x86_64/dirty_log_page_splitting_test.c
@@ -72,7 +72,7 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 
 		vcpu_run(vcpu);
 
-		ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
+		TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
 
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
 
@@ -179,12 +179,12 @@ static void run_test(enum vm_guest_mode mode, void *unused)
 	 * with that capability.
 	 */
 	if (dirty_log_manual_caps) {
-		ASSERT_EQ(stats_clear_pass[0].hugepages, 0);
-		ASSERT_EQ(stats_clear_pass[0].pages_4k, total_4k_pages);
-		ASSERT_EQ(stats_dirty_logging_enabled.hugepages, stats_populated.hugepages);
+		TEST_ASSERT_EQ(stats_clear_pass[0].hugepages, 0);
+		TEST_ASSERT_EQ(stats_clear_pass[0].pages_4k, total_4k_pages);
+		TEST_ASSERT_EQ(stats_dirty_logging_enabled.hugepages, stats_populated.hugepages);
 	} else {
-		ASSERT_EQ(stats_dirty_logging_enabled.hugepages, 0);
-		ASSERT_EQ(stats_dirty_logging_enabled.pages_4k, total_4k_pages);
+		TEST_ASSERT_EQ(stats_dirty_logging_enabled.hugepages, 0);
+		TEST_ASSERT_EQ(stats_dirty_logging_enabled.pages_4k, total_4k_pages);
 	}
 
 	/*
@@ -192,9 +192,9 @@ static void run_test(enum vm_guest_mode mode, void *unused)
 	 * memory again, the page counts should be the same as they were
 	 * right after initial population of memory.
 	 */
-	ASSERT_EQ(stats_populated.pages_4k, stats_repopulated.pages_4k);
-	ASSERT_EQ(stats_populated.pages_2m, stats_repopulated.pages_2m);
-	ASSERT_EQ(stats_populated.pages_1g, stats_repopulated.pages_1g);
+	TEST_ASSERT_EQ(stats_populated.pages_4k, stats_repopulated.pages_4k);
+	TEST_ASSERT_EQ(stats_populated.pages_2m, stats_repopulated.pages_2m);
+	TEST_ASSERT_EQ(stats_populated.pages_1g, stats_repopulated.pages_1g);
 }
 
 static void help(char *name)
diff --git a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
index e334844d6e1d7..6c2e5e0ceb1f7 100644
--- a/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
+++ b/tools/testing/selftests/kvm/x86_64/exit_on_emulation_failure_test.c
@@ -35,7 +35,7 @@ int main(int argc, char *argv[])
 	vcpu_run(vcpu);
 	handle_flds_emulation_failure_exit(vcpu);
 	vcpu_run(vcpu);
-	ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
 
 	kvm_vm_free(vm);
 	return 0;
diff --git a/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
index 6502aa23c2f84..5f074a6da90cd 100644
--- a/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c
@@ -247,12 +247,12 @@ int main(int argc, char *argv[])
 
 	/* Verify the pending events comes back out the same as it went in. */
 	vcpu_events_get(vcpu, &events);
-	ASSERT_EQ(events.flags & KVM_VCPUEVENT_VALID_PAYLOAD,
-		  KVM_VCPUEVENT_VALID_PAYLOAD);
-	ASSERT_EQ(events.exception.pending, true);
-	ASSERT_EQ(events.exception.nr, SS_VECTOR);
-	ASSERT_EQ(events.exception.has_error_code, true);
-	ASSERT_EQ(events.exception.error_code, SS_ERROR_CODE);
+	TEST_ASSERT_EQ(events.flags & KVM_VCPUEVENT_VALID_PAYLOAD,
+			KVM_VCPUEVENT_VALID_PAYLOAD);
+	TEST_ASSERT_EQ(events.exception.pending, true);
+	TEST_ASSERT_EQ(events.exception.nr, SS_VECTOR);
+	TEST_ASSERT_EQ(events.exception.has_error_code, true);
+	TEST_ASSERT_EQ(events.exception.error_code, SS_ERROR_CODE);
 
 	/*
 	 * Run for real with the pending #SS, L1 should get a VM-Exit due to
diff --git a/tools/testing/selftests/kvm/x86_64/recalc_apic_map_test.c b/tools/testing/selftests/kvm/x86_64/recalc_apic_map_test.c
index 4c416ebe7d66d..cbc92a862ea9c 100644
--- a/tools/testing/selftests/kvm/x86_64/recalc_apic_map_test.c
+++ b/tools/testing/selftests/kvm/x86_64/recalc_apic_map_test.c
@@ -57,7 +57,7 @@ int main(void)
 	for (i = 0; i < KVM_MAX_VCPUS; i++)
 		vcpu_set_msr(vcpus[i], MSR_IA32_APICBASE, LAPIC_X2APIC);
 
-	ASSERT_EQ(pthread_create(&thread, NULL, race, vcpus[0]), 0);
+	TEST_ASSERT_EQ(pthread_create(&thread, NULL, race, vcpus[0]), 0);
 
 	vcpuN = vcpus[KVM_MAX_VCPUS - 1];
 	for (t = time(NULL) + TIMEOUT; time(NULL) < t;) {
@@ -65,8 +65,8 @@ int main(void)
 		vcpu_set_msr(vcpuN, MSR_IA32_APICBASE, LAPIC_DISABLED);
 	}
 
-	ASSERT_EQ(pthread_cancel(thread), 0);
-	ASSERT_EQ(pthread_join(thread, NULL), 0);
+	TEST_ASSERT_EQ(pthread_cancel(thread), 0);
+	TEST_ASSERT_EQ(pthread_join(thread, NULL), 0);
 
 	kvm_vm_free(vm);
 
diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
index c9f67702f657f..9265965bd2cd3 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -103,39 +103,39 @@ int main(void)
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	val = 0;
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/* Guest: writes to MSR_IA32_TSC affect both MSRs.  */
 	run_vcpu(vcpu, 1);
 	val = 1ull * GUEST_STEP;
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/* Guest: writes to MSR_IA32_TSC_ADJUST affect both MSRs.  */
 	run_vcpu(vcpu, 2);
 	val = 2ull * GUEST_STEP;
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/*
 	 * Host: writes to MSR_IA32_TSC set the host-side offset
 	 * and therefore do not change MSR_IA32_TSC_ADJUST.
 	 */
 	vcpu_set_msr(vcpu, MSR_IA32_TSC, HOST_ADJUST + val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 	run_vcpu(vcpu, 3);
 
 	/* Host: writes to MSR_IA32_TSC_ADJUST do not modify the TSC.  */
 	vcpu_set_msr(vcpu, MSR_IA32_TSC_ADJUST, UNITY * 123456);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_TSC_ADJUST), UNITY * 123456);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_TSC_ADJUST), UNITY * 123456);
 
 	/* Restore previous value.  */
 	vcpu_set_msr(vcpu, MSR_IA32_TSC_ADJUST, val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/*
 	 * Guest: writes to MSR_IA32_TSC_ADJUST do not destroy the
@@ -143,8 +143,8 @@ int main(void)
 	 */
 	run_vcpu(vcpu, 4);
 	val = 3ull * GUEST_STEP;
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), HOST_ADJUST + val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val);
 
 	/*
 	 * Guest: writes to MSR_IA32_TSC affect both MSRs, so the host-side
@@ -152,8 +152,8 @@ int main(void)
 	 */
 	run_vcpu(vcpu, 5);
 	val = 4ull * GUEST_STEP;
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
-	ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
+	TEST_ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUST);
 
 	kvm_vm_free(vm);
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index be0bdb8c6f78c..a9b827c69f32c 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -50,7 +50,7 @@ static void set_timer(void)
 	timer.it_value.tv_sec  = 0;
 	timer.it_value.tv_usec = 200;
 	timer.it_interval = timer.it_value;
-	ASSERT_EQ(setitimer(ITIMER_REAL, &timer, NULL), 0);
+	TEST_ASSERT_EQ(setitimer(ITIMER_REAL, &timer, NULL), 0);
 }
 
 static void set_or_clear_invalid_guest_state(struct kvm_vcpu *vcpu, bool set)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 4c90f76930f99..34efd57c2b32f 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -103,7 +103,8 @@ static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
 		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
 	}
 
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
+	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES),
+			host_cap.capabilities);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
 
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 396c13f42457d..ab75b873a4ad8 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -65,17 +65,17 @@ static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
 	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &xapic);
 
 	vcpu_run(vcpu);
-	ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
-	ASSERT_EQ(uc.args[1], val);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], val);
 
 	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
 	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
 	if (!x->is_x2apic) {
 		val &= (-1u | (0xffull << (32 + 24)));
-		ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
+		TEST_ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
 	} else {
-		ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
+		TEST_ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
 	}
 }
 
diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
index c94cde3b523f2..e149d0574961c 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
@@ -108,16 +108,16 @@ int main(int argc, char *argv[])
 		vcpu_run(vcpu);
 
 		if (run->exit_reason == KVM_EXIT_XEN) {
-			ASSERT_EQ(run->xen.type, KVM_EXIT_XEN_HCALL);
-			ASSERT_EQ(run->xen.u.hcall.cpl, 0);
-			ASSERT_EQ(run->xen.u.hcall.longmode, 1);
-			ASSERT_EQ(run->xen.u.hcall.input, INPUTVALUE);
-			ASSERT_EQ(run->xen.u.hcall.params[0], ARGVALUE(1));
-			ASSERT_EQ(run->xen.u.hcall.params[1], ARGVALUE(2));
-			ASSERT_EQ(run->xen.u.hcall.params[2], ARGVALUE(3));
-			ASSERT_EQ(run->xen.u.hcall.params[3], ARGVALUE(4));
-			ASSERT_EQ(run->xen.u.hcall.params[4], ARGVALUE(5));
-			ASSERT_EQ(run->xen.u.hcall.params[5], ARGVALUE(6));
+			TEST_ASSERT_EQ(run->xen.type, KVM_EXIT_XEN_HCALL);
+			TEST_ASSERT_EQ(run->xen.u.hcall.cpl, 0);
+			TEST_ASSERT_EQ(run->xen.u.hcall.longmode, 1);
+			TEST_ASSERT_EQ(run->xen.u.hcall.input, INPUTVALUE);
+			TEST_ASSERT_EQ(run->xen.u.hcall.params[0], ARGVALUE(1));
+			TEST_ASSERT_EQ(run->xen.u.hcall.params[1], ARGVALUE(2));
+			TEST_ASSERT_EQ(run->xen.u.hcall.params[2], ARGVALUE(3));
+			TEST_ASSERT_EQ(run->xen.u.hcall.params[3], ARGVALUE(4));
+			TEST_ASSERT_EQ(run->xen.u.hcall.params[4], ARGVALUE(5));
+			TEST_ASSERT_EQ(run->xen.u.hcall.params[5], ARGVALUE(6));
 			run->xen.u.hcall.result = RETVALUE;
 			continue;
 		}
-- 
2.39.3

