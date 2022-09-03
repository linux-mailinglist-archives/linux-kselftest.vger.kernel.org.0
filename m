Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CA5ABC19
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiICB3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 21:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiICB3V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 21:29:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1581F0749
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 18:29:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g9-20020a17090a290900b001fd59cc2c14so1704806pjd.7
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Sep 2022 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=EGQ1xeBC4LCXTSPvP+phFjbrfAsAViM23WFgEc3VwWA=;
        b=LeQTvv9IoZ4QU9QeWnRxLQz0N8KsNx9s8CH6u1XeCquSogNEz2dtV5t8y63+a+dyvW
         +hWenHbImRPsx/nFKmodMCrRpUQ95jp3JO82EpcC1iHCIOp4zq5VgRtoLVkIm7rsfQL3
         zSI6T8WoKrZdozzYR6inhNfoYgWUAAjMxTN10TTrRpYlOXJG6i1Qq5C/KzVWJAoJjIWe
         tN94tk27by9ZJbcdlUg/mVXRo7ROhmdpbV5K8Nk11h9ZuObKkWu7vmrv0cmhdG2hBGnx
         X8UIF+mdNWqjRGhYT0PNvKmGUntQRaINoLZCTND3zkESMSh21+w5MdWkp1wgs/3Bv8Kl
         uWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=EGQ1xeBC4LCXTSPvP+phFjbrfAsAViM23WFgEc3VwWA=;
        b=Az4f3k8A/AEYniMv+jrww6Z894CMjdqXs6B8X7E3St2wujxilEY7fJHb2EUVVjJb7l
         8tGDlZYS6ws/upBrYcMj86+Oj5Yjfa23FIq6E7X9oTFzW2xP/sUdADtRYujbcPnF1t/h
         t0D6fejaw5lk7QJVRX4yxMn0+3HFB5r9dWCkFHN8DVIH0+zGFp1g7aO6+NxpxYaWs1eA
         L5BUiRF5tli4dZDqhjdwbXzXAnmqFbuPagLPMFiLkJ7sR3Ldzbc1mZlYjcMQk0w1LRZI
         DoXDfplZzsdGHQ/bHtU6mQ4WoqeU/WxWt2zJRaHme5b/iQPLdpklPPXvBfWy44TunaRR
         IK/w==
X-Gm-Message-State: ACgBeo1oQH2Fwr2EQzYuJfoSVJWOxtj0yNq7ROJYEflBP7nbqBcnfmDU
        qQet6tdAUG00hUb5Nr1+yjsQW3zvAiftB54J
X-Google-Smtp-Source: AA6agR7Hjiw99qaPxZVhiVRFIWIIr8V00ASIbExW2PI8LjzD1LeQ/yOquLi/hR9pa5cUJNeA5vGm5I4yhDc+c78W
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:33c9:b0:1fe:5861:7a0f with SMTP
 id lk9-20020a17090b33c900b001fe58617a0fmr7566523pjb.187.1662168559380; Fri,
 02 Sep 2022 18:29:19 -0700 (PDT)
Date:   Sat,  3 Sep 2022 01:28:49 +0000
In-Reply-To: <20220903012849.938069-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220903012849.938069-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903012849.938069-6-vannapurve@google.com>
Subject: [V1 PATCH 5/5] selftests: kvm: Execute vmcall/vmmcall as per cpu type
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

Modify existing tests to execute vmcall/vmmcall instructions as per the
cpu type.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 10 +++
 .../selftests/kvm/include/x86_64/vmx.h        |  9 ---
 .../selftests/kvm/lib/x86_64/perf_test_util.c |  2 +-
 .../selftests/kvm/lib/x86_64/processor.c      | 15 +++++
 tools/testing/selftests/kvm/x86_64/smm_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/state_test.c |  8 +--
 .../kvm/x86_64/vmx_apic_access_test.c         |  2 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  2 +-
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  |  2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  2 +-
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  2 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 64 +++++++------------
 .../selftests/kvm/x86_64/xen_vmcall_test.c    | 14 ++--
 13 files changed, 70 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0cbc71b7af50..74893a7a80f8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -833,6 +833,16 @@ void vm_set_page_table_entry(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3);
 
+/*
+ * Execute vmcall instruction.
+ */
+static inline void vmcall(void)
+{
+	kvm_hypercall(0, 0, 0, 0, 0);
+}
+
+void nested_guest_vmcall(void);
+
 void __vm_xsave_require_permission(int bit, const char *name);
 
 #define vm_xsave_require_permission(perm)	\
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 99fa1410964c..d8d4fd3353e5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -480,15 +480,6 @@ static inline int vmresume(void)
 	return ret;
 }
 
-static inline void vmcall(void)
-{
-	/* Currently, L1 destroys our GPRs during vmexits.  */
-	__asm__ __volatile__("push %%rbp; vmcall; pop %%rbp" : : :
-			     "rax", "rbx", "rcx", "rdx",
-			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
-			     "r13", "r14", "r15");
-}
-
 static inline int vmread(uint64_t encoding, uint64_t *value)
 {
 	uint64_t tmp;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c b/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c
index 0f344a7c89c4..b420b35b7f45 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/perf_test_util.c
@@ -18,7 +18,7 @@
 void perf_test_l2_guest_code(uint64_t vcpu_id)
 {
 	perf_test_guest_code(vcpu_id);
-	vmcall();
+	nested_guest_vmcall();
 }
 
 extern char perf_test_l2_guest_entry[];
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ac104653ab43..5227b2c48a50 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1195,6 +1195,21 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 	return r;
 }
 
+void nested_guest_vmcall(void)
+{
+	/* Currently, L1 destroys our GPRs during vmexits.  */
+	if (is_amd_cpu())
+		__asm__ __volatile__("push %%rbp; vmmcall; pop %%rbp" : : :
+			     "rax", "rbx", "rcx", "rdx",
+			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
+			     "r13", "r14", "r15");
+	else
+		__asm__ __volatile__("push %%rbp; vmcall; pop %%rbp" : : :
+			     "rax", "rbx", "rcx", "rdx",
+			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
+			     "r13", "r14", "r15");
+}
+
 const struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
 {
 	static struct kvm_cpuid2 *cpuid;
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index 5f8ebe7795c1..26db9b18c1ca 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -61,7 +61,7 @@ static void l2_guest_code(void)
 
 	sync_with_host(10);
 
-	vmcall();
+	nested_guest_vmcall();
 }
 
 static void guest_code(void *arg)
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 3d42c18d4c5f..889f73e38af1 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -26,10 +26,10 @@ void svm_l2_guest_code(void)
 {
 	GUEST_SYNC(4);
 	/* Exit to L1 */
-	vmcall();
+	nested_guest_vmcall();
 	GUEST_SYNC(6);
 	/* Done, exit to L1 and never come back.  */
-	vmcall();
+	nested_guest_vmcall();
 }
 
 static void svm_l1_guest_code(struct svm_test_data *svm)
@@ -57,7 +57,7 @@ void vmx_l2_guest_code(void)
 	GUEST_SYNC(6);
 
 	/* Exit to L1 */
-	vmcall();
+	nested_guest_vmcall();
 
 	/* L1 has now set up a shadow VMCS for us.  */
 	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
@@ -70,7 +70,7 @@ void vmx_l2_guest_code(void)
 	GUEST_SYNC(12);
 
 	/* Done, exit to L1 and never come back.  */
-	vmcall();
+	nested_guest_vmcall();
 }
 
 static void vmx_l1_guest_code(struct vmx_pages *vmx_pages)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
index 2d503dce0481..b6caeea02dc3 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
@@ -31,7 +31,7 @@
 static void l2_guest_code(void)
 {
 	/* Exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages, unsigned long high_gpa)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
index 5ab735bcf8ab..f8eeb35432f0 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
@@ -42,7 +42,7 @@ static void l2_guest_code(void)
 	GUEST_SYNC(false);
 
 	/* Exit to L1 and never come back.  */
-	vmcall();
+	nested_guest_vmcall();
 }
 
 void l1_guest_code(struct vmx_pages *vmx)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index e3887e08666c..9ec1b5197193 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -76,7 +76,7 @@ static void l2_guest_code(void)
 	check_tsc_freq(UCHECK_L2);
 
 	/* exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
index 629b9c4bd6e4..1d5ff49be97d 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
@@ -38,7 +38,7 @@ void l2_guest_code(void)
 {
 	u64 vmx_pt_delta;
 
-	vmcall();
+	nested_guest_vmcall();
 	l2_vmx_pt_start = (rdtsc() >> vmx_pt_rate) << vmx_pt_rate;
 
 	/*
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index da9628db7ee6..26cf2554a0a0 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -74,7 +74,7 @@ static void l2_guest_code(void)
 	check_ia32_tsc_adjust(-2 * TSC_ADJUST_VALUE);
 
 	/* Exit to L1 */
-	__asm__ __volatile__("vmcall");
+	vmcall();
 }
 
 static void l1_guest_code(struct vmx_pages *vmx_pages)
diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index f003c8cc2812..4c32c977a98f 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -145,6 +145,23 @@ static void guest_wait_for_irq(void)
 	guest_saw_irq = false;
 }
 
+static unsigned long vmcall_helper(unsigned long reg_a, unsigned long reg_di,
+	unsigned long reg_si)
+{
+	unsigned long ret;
+
+	if (is_amd_cpu())
+		__asm__ __volatile__ ("vmmcall" :
+			"=a" (ret) :
+			"a" (reg_a), "D" (reg_di), "S" (reg_si));
+	else
+		__asm__ __volatile__ ("vmcall" :
+			"=a" (ret) :
+			"a" (reg_a), "D" (reg_di), "S" (reg_si));
+
+	return ret;
+}
+
 static void guest_code(void)
 {
 	struct vcpu_runstate_info *rs = (void *)RUNSTATE_VADDR;
@@ -217,12 +234,7 @@ static void guest_code(void)
 	 * EVTCHNOP_send hypercall. */
 	unsigned long rax;
 	struct evtchn_send s = { .port = 127 };
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_event_channel_op),
-			      "D" (EVTCHNOP_send),
-			      "S" (&s));
-
+	rax = vmcall_helper(__HYPERVISOR_event_channel_op, EVTCHNOP_send, (unsigned long)&s);
 	GUEST_ASSERT(rax == 0);
 
 	guest_wait_for_irq();
@@ -232,12 +244,7 @@ static void guest_code(void)
 	/* Deliver "outbound" event channel to an eventfd which
 	 * happens to be one of our own irqfds. */
 	s.port = 197;
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_event_channel_op),
-			      "D" (EVTCHNOP_send),
-			      "S" (&s));
-
+	rax = vmcall_helper(__HYPERVISOR_event_channel_op, EVTCHNOP_send, (unsigned long)&s);
 	GUEST_ASSERT(rax == 0);
 
 	guest_wait_for_irq();
@@ -245,10 +252,7 @@ static void guest_code(void)
 	GUEST_SYNC(13);
 
 	/* Set a timer 100ms in the future. */
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_set_timer_op),
-			      "D" (rs->state_entry_time + 100000000));
+	rax = vmcall_helper(__HYPERVISOR_set_timer_op, (rs->state_entry_time + 100000000), 0);
 	GUEST_ASSERT(rax == 0);
 
 	GUEST_SYNC(14);
@@ -271,36 +275,21 @@ static void guest_code(void)
 		.timeout = 0,
 	};
 
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_sched_op),
-			      "D" (SCHEDOP_poll),
-			      "S" (&p));
-
+	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
 	GUEST_ASSERT(rax == 0);
 
 	GUEST_SYNC(17);
 
 	/* Poll for an unset port and wait for the timeout. */
 	p.timeout = 100000000;
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_sched_op),
-			      "D" (SCHEDOP_poll),
-			      "S" (&p));
-
+	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
 	GUEST_ASSERT(rax == 0);
 
 	GUEST_SYNC(18);
 
 	/* A timer will wake the masked port we're waiting on, while we poll */
 	p.timeout = 0;
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_sched_op),
-			      "D" (SCHEDOP_poll),
-			      "S" (&p));
-
+	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
 	GUEST_ASSERT(rax == 0);
 
 	GUEST_SYNC(19);
@@ -309,12 +298,7 @@ static void guest_code(void)
 	 * actual interrupt, while we're polling on a different port. */
 	ports[0]++;
 	p.timeout = 0;
-	__asm__ __volatile__ ("vmcall" :
-			      "=a" (rax) :
-			      "a" (__HYPERVISOR_sched_op),
-			      "D" (SCHEDOP_poll),
-			      "S" (&p));
-
+	rax = vmcall_helper(__HYPERVISOR_sched_op, SCHEDOP_poll, (unsigned long)&p);
 	GUEST_ASSERT(rax == 0);
 
 	guest_wait_for_irq();
diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
index b17f36bd41cc..63fca30f085b 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
@@ -37,10 +37,16 @@ static void guest_code(void)
 	register unsigned long r9 __asm__("r9") = ARGVALUE(6);
 
 	/* First a direct invocation of 'vmcall' */
-	__asm__ __volatile__("vmcall" :
-			     "=a"(rax) :
-			     "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
-			     "r"(r10), "r"(r8), "r"(r9));
+	if (is_amd_cpu())
+		__asm__ __volatile__("vmmcall" :
+			"=a"(rax) :
+			"a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
+			"r"(r10), "r"(r8), "r"(r9));
+	else
+		__asm__ __volatile__("vmcall" :
+			"=a"(rax) :
+			"a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
+			"r"(r10), "r"(r8), "r"(r9));
 	GUEST_ASSERT(rax == RETVALUE);
 
 	/* Fill in the Xen hypercall page */
-- 
2.37.2.789.g6183377224-goog

