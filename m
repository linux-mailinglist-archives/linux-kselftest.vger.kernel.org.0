Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A54755B87
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGQGYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGQGYX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3601705;
        Sun, 16 Jul 2023 23:24:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2892313b3a.1;
        Sun, 16 Jul 2023 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575050; x=1692167050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRi+IaxQS5j3+9rDlR9mUvSIX4EcGmDuBRnj72kn4po=;
        b=C7fC+8ytGEvzzts+vsq6xv5WSvudLbJjVUc9khLSxl2whmbjZQQizAzlXPevEBldll
         hs9hZrDktVt6M0xGuoi5FT6AyvPh+6SCFr0LDfjDiWAPTgwVeKUuZgWDAZU4tN6HFewv
         5bIkWjlIBTsLbluuSS/Go99EVsqiGDmOo+gyoWGDlP9LnSH6GOybGgzZanK/WFi09oFb
         3g/+f75i0iMg3kYgZV1qKJr40juHx+W5/uTY+0aJdwhKfdzW+mZnvFcNtgV/WrZvfkwp
         VUPmcrfYpBz81K9faoQpsbynahpTa+0DD+Leh9DMGT3ZWmTW5RZzVJKHgS9Mq1QU73jS
         GOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575050; x=1692167050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRi+IaxQS5j3+9rDlR9mUvSIX4EcGmDuBRnj72kn4po=;
        b=OyigGub4THcBLvAxnbBJ8D8zh3AQkLWNPGusVtGc8lNHEjMfakH5TwNFTGwQv6tjQS
         EcSYYKXpimoEJ7BfWJ1VwlHhTzj37NefAu2aBuzapBtKtlMxkBnX/5hDydV6WUXneZxy
         G1K4taKQoCeK/BzYDGdvYsrTKkAsxcoAgg3pLIJFpLSBQqje6h5p4z88PeTR9MuUxGhW
         NzAOpmNdoG7BXC3fJUdBoD6qRqPK/P23xUcv66b2X12u3gT2m+UIQGSVuIaHGZ6wGi4S
         w1jXueU8Ed3RvDWaIEctfxrES84wXzpdprSBRrjoN4Udl/HtB1OZMnwT9PwpmSZDU9Jf
         C9DQ==
X-Gm-Message-State: ABy/qLbibWsf8qbSFAgklyLx8J1XfEjlbzki6vGR6QTeyUn2+hfFxjtV
        ffJ1HnCwqj+bezYbGj02rOAxp5IRJSx2pSdaUWA=
X-Google-Smtp-Source: APBJJlHolwI70G47YAetZ7RSrRqJY8eUZYiSi4tR45oWzlUyEaJST6XP+YbcHhNFrIdxH/tntBs+eA==
X-Received: by 2002:a05:6a21:3814:b0:122:10f9:f635 with SMTP id yi20-20020a056a21381400b0012210f9f635mr8579693pzb.19.1689575050340;
        Sun, 16 Jul 2023 23:24:10 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:24:10 -0700 (PDT)
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
Subject: [PATCH v4 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter to improved event filter settings
Date:   Mon, 17 Jul 2023 14:23:40 +0800
Message-Id: <20230717062343.3743-4-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717062343.3743-1-cloudliang@tencent.com>
References: <20230717062343.3743-1-cloudliang@tencent.com>
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

Add custom "__kvm_pmu_event_filter" structure to improve pmu event
filter settings. Simplifies event filter setup by organizing event
filter parameters in a cleaner, more organized way.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 179 +++++++++---------
 1 file changed, 87 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 5ac05e64bec9..ffcbbf25b29b 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -28,6 +28,10 @@
 
 #define NUM_BRANCHES 42
 
+/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
+#define MAX_FILTER_EVENTS		300
+#define MAX_TEST_EVENTS		10
+
 /*
  * This is how the event selector and unit mask are stored in an AMD
  * core performance event-select register. Intel's format is similar,
@@ -69,21 +73,33 @@
 
 #define INST_RETIRED EVENT(0xc0, 0)
 
+struct __kvm_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 fixed_counter_bitmap;
+	__u32 flags;
+	__u32 pad[4];
+	__u64 events[MAX_FILTER_EVENTS];
+};
+
 /*
  * This event list comprises Intel's eight architectural events plus
  * AMD's "retired branch instructions" for Zen[123] (and possibly
  * other AMD CPUs).
  */
-static const uint64_t event_list[] = {
-	EVENT(0x3c, 0),
-	INST_RETIRED,
-	EVENT(0x3c, 1),
-	EVENT(0x2e, 0x4f),
-	EVENT(0x2e, 0x41),
-	EVENT(0xc4, 0),
-	EVENT(0xc5, 0),
-	EVENT(0xa4, 1),
-	AMD_ZEN_BR_RETIRED,
+static const struct __kvm_pmu_event_filter base_event_filter = {
+	.nevents = ARRAY_SIZE(base_event_filter.events),
+	.events = {
+		EVENT(0x3c, 0),
+		INST_RETIRED,
+		EVENT(0x3c, 1),
+		EVENT(0x2e, 0x4f),
+		EVENT(0x2e, 0x41),
+		EVENT(0xc4, 0),
+		EVENT(0xc5, 0),
+		EVENT(0xa4, 1),
+		AMD_ZEN_BR_RETIRED,
+	},
 };
 
 struct {
@@ -225,47 +241,11 @@ static bool sanity_check_pmu(struct kvm_vcpu *vcpu)
 	return !r;
 }
 
-static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t nevents)
-{
-	struct kvm_pmu_event_filter *f;
-	int size = sizeof(*f) + nevents * sizeof(f->events[0]);
-
-	f = malloc(size);
-	TEST_ASSERT(f, "Out of memory");
-	memset(f, 0, size);
-	f->nevents = nevents;
-	return f;
-}
-
-
-static struct kvm_pmu_event_filter *
-create_pmu_event_filter(const uint64_t event_list[], int nevents,
-			uint32_t action, uint32_t flags)
-{
-	struct kvm_pmu_event_filter *f;
-	int i;
-
-	f = alloc_pmu_event_filter(nevents);
-	f->action = action;
-	f->flags = flags;
-	for (i = 0; i < nevents; i++)
-		f->events[i] = event_list[i];
-
-	return f;
-}
-
-static struct kvm_pmu_event_filter *event_filter(uint32_t action)
-{
-	return create_pmu_event_filter(event_list,
-				       ARRAY_SIZE(event_list),
-				       action, 0);
-}
-
 /*
  * Remove the first occurrence of 'event' (if any) from the filter's
  * event list.
  */
-static void remove_event(struct kvm_pmu_event_filter *f, uint64_t event)
+static void remove_event(struct __kvm_pmu_event_filter *f, uint64_t event)
 {
 	bool found = false;
 	int i;
@@ -313,66 +293,70 @@ static void test_without_filter(struct kvm_vcpu *vcpu)
 }
 
 static void test_with_filter(struct kvm_vcpu *vcpu,
-			     struct kvm_pmu_event_filter *f)
+			     struct __kvm_pmu_event_filter *__f)
 {
+	struct kvm_pmu_event_filter *f = (void *)__f;
+
 	vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
 	run_vcpu_and_sync_pmc_results(vcpu);
 }
 
 static void test_amd_deny_list(struct kvm_vcpu *vcpu)
 {
-	uint64_t event = EVENT(0x1C2, 0);
-	struct kvm_pmu_event_filter *f;
+	struct __kvm_pmu_event_filter f = base_event_filter;
 
-	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0);
-	test_with_filter(vcpu, f);
-	free(f);
+	f.action = KVM_PMU_EVENT_DENY;
+	f.nevents = 1;
+	f.events[0] = EVENT(0x1C2, 0);
+	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_COUNTING_INSTRUCTIONS();
 }
 
 static void test_member_deny_list(struct kvm_vcpu *vcpu)
 {
-	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_DENY);
+	struct __kvm_pmu_event_filter f = base_event_filter;
 
-	test_with_filter(vcpu, f);
-	free(f);
+	f.action = KVM_PMU_EVENT_DENY;
+	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
 }
 
 static void test_member_allow_list(struct kvm_vcpu *vcpu)
 {
-	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_ALLOW);
+	struct __kvm_pmu_event_filter f = base_event_filter;
 
-	test_with_filter(vcpu, f);
-	free(f);
+	f.action = KVM_PMU_EVENT_ALLOW;
+	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_COUNTING_INSTRUCTIONS();
 }
 
 static void test_not_member_deny_list(struct kvm_vcpu *vcpu)
 {
-	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_DENY);
+	struct __kvm_pmu_event_filter f = base_event_filter;
+
+	f.action = KVM_PMU_EVENT_DENY;
 
-	remove_event(f, INST_RETIRED);
-	remove_event(f, INTEL_BR_RETIRED);
-	remove_event(f, AMD_ZEN_BR_RETIRED);
-	test_with_filter(vcpu, f);
-	free(f);
+	remove_event(&f, INST_RETIRED);
+	remove_event(&f, INTEL_BR_RETIRED);
+	remove_event(&f, AMD_ZEN_BR_RETIRED);
+	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_COUNTING_INSTRUCTIONS();
 }
 
 static void test_not_member_allow_list(struct kvm_vcpu *vcpu)
 {
-	struct kvm_pmu_event_filter *f = event_filter(KVM_PMU_EVENT_ALLOW);
+	struct __kvm_pmu_event_filter f = base_event_filter;
 
-	remove_event(f, INST_RETIRED);
-	remove_event(f, INTEL_BR_RETIRED);
-	remove_event(f, AMD_ZEN_BR_RETIRED);
-	test_with_filter(vcpu, f);
-	free(f);
+	f.action = KVM_PMU_EVENT_ALLOW;
+
+	remove_event(&f, INST_RETIRED);
+	remove_event(&f, INTEL_BR_RETIRED);
+	remove_event(&f, AMD_ZEN_BR_RETIRED);
+	test_with_filter(vcpu, &f);
 
 	ASSERT_PMC_NOT_COUNTING_INSTRUCTIONS();
 }
@@ -567,19 +551,16 @@ static void run_masked_events_test(struct kvm_vcpu *vcpu,
 				   const uint64_t masked_events[],
 				   const int nmasked_events)
 {
-	struct kvm_pmu_event_filter *f;
+	struct __kvm_pmu_event_filter f = {
+		.nevents = nmasked_events,
+		.action = KVM_PMU_EVENT_ALLOW,
+		.flags = KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+	};
 
-	f = create_pmu_event_filter(masked_events, nmasked_events,
-				    KVM_PMU_EVENT_ALLOW,
-				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
-	test_with_filter(vcpu, f);
-	free(f);
+	memcpy(f.events, masked_events, sizeof(uint64_t) * nmasked_events);
+	test_with_filter(vcpu, &f);
 }
 
-/* Matches KVM_PMU_EVENT_FILTER_MAX_EVENTS in pmu.c */
-#define MAX_FILTER_EVENTS	300
-#define MAX_TEST_EVENTS		10
-
 #define ALLOW_LOADS		BIT(0)
 #define ALLOW_STORES		BIT(1)
 #define ALLOW_LOADS_STORES	BIT(2)
@@ -751,17 +732,27 @@ static void test_masked_events(struct kvm_vcpu *vcpu)
 	run_masked_events_tests(vcpu, events, nevents);
 }
 
-static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
-			   int nevents, uint32_t flags)
+static int do_vcpu_set_pmu_event_filter(struct kvm_vcpu *vcpu,
+					struct __kvm_pmu_event_filter *__f)
 {
-	struct kvm_pmu_event_filter *f;
-	int r;
+	struct kvm_pmu_event_filter *f = (void *)__f;
 
-	f = create_pmu_event_filter(events, nevents, KVM_PMU_EVENT_ALLOW, flags);
-	r = __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
-	free(f);
+	return __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
+}
+
+static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
+				       uint32_t flags, uint32_t action)
+{
+	struct __kvm_pmu_event_filter f = {
+		.nevents = 1,
+		.flags = flags,
+		.action = action,
+		.events = {
+			event,
+		},
+	};
 
-	return r;
+	return do_vcpu_set_pmu_event_filter(vcpu, &f);
 }
 
 static void test_filter_ioctl(struct kvm_vcpu *vcpu)
@@ -773,14 +764,18 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	 * Unfortunately having invalid bits set in event data is expected to
 	 * pass when flags == 0 (bits other than eventsel+umask).
 	 */
-	r = run_filter_test(vcpu, &e, 1, 0);
+	r = set_pmu_single_event_filter(vcpu, e, 0, KVM_PMU_EVENT_ALLOW);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
 
-	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+	r = set_pmu_single_event_filter(vcpu, e,
+					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+					KVM_PMU_EVENT_ALLOW);
 	TEST_ASSERT(r != 0, "Invalid PMU Event Filter is expected to fail");
 
 	e = KVM_PMU_ENCODE_MASKED_ENTRY(0xff, 0xff, 0xff, 0xf);
-	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+	r = set_pmu_single_event_filter(vcpu, e,
+					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+					KVM_PMU_EVENT_ALLOW);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
 }
 
-- 
2.39.3

