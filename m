Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C3755B8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGQGYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGQGYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E0F1980;
        Sun, 16 Jul 2023 23:24:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b8b318c5a7so32665245ad.3;
        Sun, 16 Jul 2023 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575054; x=1692167054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iWyDJ0vw+EOcxJe/K1oi+A9yw85j7hp6Mnp84AwIPo=;
        b=oS3kQq+DOD+7pk4ys1tYVbpbXI1B4ZyNRYwGW5w/2TCWRnJ16a6tGACDaOhBdDginD
         tzS6EibVbsSZFOrEb43jIIcyiHv4pmNjjJbTRhVLrAL209QaU5aeL+17tvagMiHWqsZG
         d41SiveOJCTks8mxlIb2A9LnnhG5DWMpklY6EGSbEXuqim4eka+75pl/J+aLJFwAUV8M
         GJE4sYXnjCtLKcqcMiIsdh5l5DCyGjrxSMzKUHO9HtI9KGlMYaaJ+DvjLunUih+nLE+h
         wNNFnMxYwT2CkFy3jphum4wETeWHMAMfEJy3sw3umRInpG3G3DGvTWj0DQkI+IIRPgMS
         o4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575054; x=1692167054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iWyDJ0vw+EOcxJe/K1oi+A9yw85j7hp6Mnp84AwIPo=;
        b=EqmrlqbkSNzv++Qk5N2CNpluH7wWJ0OVIx9yBzt9oHAxf9pvum3QlaS96A5/B2UWlX
         Tt4j05xyjs/1ufPCqCe0wSioCrfPLwaw4t4//z3j4tGSHb1wXfwi5mNBa8FrclQ8fAVY
         v4hML3bQ/AwCvPqcM6g9OxCqjYawX53TxWjnRIvUQ8mqFQo4d3XBeO95wTnLoCcFI0iC
         HeaPixkmFnZQE+pev6s3AqtQWuEWsH84f4W5mG+ox457uIjcuShLhn3ReWjULOViP1AG
         q5IeBtQYfDjICcBOVQIyvXZXO60THoLd5oogs5Mv9yEEzIOMI9qquheiKZk33SgOU9AC
         2t8A==
X-Gm-Message-State: ABy/qLZBMbE1fUJqJp4amJlnH3BwqDf7AIQTgRXXLVlDDibJ2RaKC/GB
        BI3jkhnPkjXpduPthyrPxss=
X-Google-Smtp-Source: APBJJlEY0B87Dz696UvK5qHdiYjG9zJuLL8M44mCS8ILS2UX8pmv/9XSazJkc3kttGzsXp1NRPHY8g==
X-Received: by 2002:a17:902:9b8f:b0:1b9:de75:d5bb with SMTP id y15-20020a1709029b8f00b001b9de75d5bbmr11507397plp.7.1689575054559;
        Sun, 16 Jul 2023 23:24:14 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:24:14 -0700 (PDT)
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
Subject: [PATCH v4 4/6] KVM: selftests: Add test cases for unsupported PMU event filter input values
Date:   Mon, 17 Jul 2023 14:23:41 +0800
Message-Id: <20230717062343.3743-5-cloudliang@tencent.com>
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

Add test cases to verify the handling of unsupported input values for the
PMU event filter. The tests cover unsupported "action" values, unsupported
"flags" values, and unsupported "nevents" values. All these cases should
return an error, as they are currently not supported by the filter.
Furthermore, the tests also cover the scenario where setting non-existent
fixed counters in the fixed bitmap does not fail.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index ffcbbf25b29b..63f85f583ef8 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -32,6 +32,10 @@
 #define MAX_FILTER_EVENTS		300
 #define MAX_TEST_EVENTS		10
 
+#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
+#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)
+#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
+
 /*
  * This is how the event selector and unit mask are stored in an AMD
  * core performance event-select register. Intel's format is similar,
@@ -757,6 +761,8 @@ static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
 
 static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 {
+	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	struct __kvm_pmu_event_filter f;
 	uint64_t e = ~0ul;
 	int r;
 
@@ -777,6 +783,26 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
 					KVM_PMU_EVENT_ALLOW);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
+
+	f = base_event_filter;
+	f.action = PMU_EVENT_FILTER_INVALID_ACTION;
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r, "Set invalid action is expected to fail");
+
+	f = base_event_filter;
+	f.flags = PMU_EVENT_FILTER_INVALID_FLAGS;
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r, "Set invalid flags is expected to fail");
+
+	f = base_event_filter;
+	f.nevents = PMU_EVENT_FILTER_INVALID_NEVENTS;
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r, "Exceeding the max number of filter events should fail");
+
+	f = base_event_filter;
+	f.fixed_counter_bitmap = ~GENMASK_ULL(nr_fixed_counters, 0);
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(!r, "Masking non-existent fixed counters should be allowed");
 }
 
 int main(int argc, char *argv[])
-- 
2.39.3

