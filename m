Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B76E2178
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDNLBR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDNLBP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0E5BA2;
        Fri, 14 Apr 2023 04:01:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m18so17884712plx.5;
        Fri, 14 Apr 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470074; x=1684062074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+JDAvtrWEsHLmAmNtEcddpwsMXPhmUa/XaRlUIpwE0=;
        b=IJhMErUL5COHfQo08l1fw7uGzSHQ/msKDAANngGbXkxWvMCRggJePPzdekV5yVBmHe
         0cNF8pXUmA05q4/O9UD4yLNzoSMyVyoEXye5G6ymTN824okLYTtELUbTtxZNUsDad1ri
         Xje4mU8ROX/cdb1rReDVh1TPcrCRvNKqwFG92MqDi1tDD/FbzY87A/L8ericyd6D38zy
         PSfB/3knDqmzF/Igwt1U7W0LkzPcIxD3IVGx9DJm0uKDI9OwLv8QKWPGNht/xICVTQmF
         T4yUvxokuSK/DQKq7dyfowQDvVcGloKWhS2znO8FekLwnqQABMOwL265gyYBCK3G7SLS
         VA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470074; x=1684062074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+JDAvtrWEsHLmAmNtEcddpwsMXPhmUa/XaRlUIpwE0=;
        b=gs+qF6YEdwZJrd89A2wnI0Y6Y+FFaA7Z8gzjE8H6TzeMGuxyzDuy4DpOZdLsQAiLs4
         RxnX2b1DZvw33KY6Wh4hv9qfDrJDqBXuV8pw6EkuHiShqwsM5uWr7n5vg4KV/Y/quBZR
         GAlN6MB8dykqlseT8VsK7zrI0e3whpiuvtxaxmhgPgbxZl9jlTOu6APTFAOjrQEGI8ab
         klTSNakoLyGd61Mad6baG/u/4RCHDbST6MyhXVFgJ763cH9WzBqtlopYBbEEcQIe7epb
         dA4kvQPcBF8YV4SeXWM5ZSccZchSrd6F1tmLvUcUdRe0AXND0HVcFUSoBiReavn7P04/
         lZpQ==
X-Gm-Message-State: AAQBX9eN1PuJFlSLO5A+IctSjYF3CD4Vey82WKwv1VtISwomyoxI260Y
        TylgzhDkUPYQvl0XA35+20M=
X-Google-Smtp-Source: AKy350a0dG1c2JOXIMlUTl/xV6eZHBWW+o3n12vpBTPiE7XVLd7nrFP5RT4Xs+3rCJWLHchnaLEL6Q==
X-Received: by 2002:a17:90b:4a8f:b0:23d:29c7:916f with SMTP id lp15-20020a17090b4a8f00b0023d29c7916fmr4910995pjb.32.1681470074150;
        Fri, 14 Apr 2023 04:01:14 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:13 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] KVM: selftests: Apply create_pmu_event_filter() to fixed ctrs
Date:   Fri, 14 Apr 2023 19:00:51 +0800
Message-Id: <20230414110056.19665-3-cloudliang@tencent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414110056.19665-1-cloudliang@tencent.com>
References: <20230414110056.19665-1-cloudliang@tencent.com>
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

Add fixed_counter_bitmap to the create_pmu_event_filter() to
support the use of the same creator to control the use of guest
fixed counters.

No functional change intended.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index c0521fc9e8f6..4e87eea6986b 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -192,19 +192,22 @@ static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t nevents)
 	return f;
 }
 
-
 static struct kvm_pmu_event_filter *
 create_pmu_event_filter(const uint64_t event_list[], uint32_t nevents,
-			uint32_t action, uint32_t flags)
+			uint32_t action, uint32_t flags,
+			uint32_t fixed_counter_bitmap)
 {
 	struct kvm_pmu_event_filter *f;
 	int i;
 
 	f = alloc_pmu_event_filter(nevents);
 	f->action = action;
+	f->fixed_counter_bitmap = fixed_counter_bitmap;
 	f->flags = flags;
-	for (i = 0; i < nevents; i++)
-		f->events[i] = event_list[i];
+	if (f->nevents) {
+		for (i = 0; i < f->nevents; i++)
+			f->events[i] = event_list[i];
+	}
 
 	return f;
 }
@@ -213,7 +216,7 @@ static struct kvm_pmu_event_filter *event_filter(uint32_t action)
 {
 	return create_pmu_event_filter(event_list,
 				       ARRAY_SIZE(event_list),
-				       action, 0);
+				       action, 0, 0);
 }
 
 /*
@@ -260,7 +263,7 @@ static void test_amd_deny_list(struct kvm_vcpu *vcpu)
 	struct kvm_pmu_event_filter *f;
 	uint64_t count;
 
-	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0);
+	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0, 0);
 	count = test_with_filter(vcpu, f);
 
 	free(f);
@@ -544,7 +547,7 @@ static struct perf_counter run_masked_events_test(struct kvm_vcpu *vcpu,
 
 	f = create_pmu_event_filter(masked_events, nmasked_events,
 				    KVM_PMU_EVENT_ALLOW,
-				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS, 0);
 	r.raw = test_with_filter(vcpu, f);
 	free(f);
 
@@ -726,12 +729,14 @@ static void test_masked_events(struct kvm_vcpu *vcpu)
 }
 
 static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
-			   uint32_t nevents, uint32_t flags)
+			   uint32_t nevents, uint32_t flags, uint32_t action,
+			   uint32_t fixed_counter_bitmap)
 {
 	struct kvm_pmu_event_filter *f;
 	int r;
 
-	f = create_pmu_event_filter(events, nevents, KVM_PMU_EVENT_ALLOW, flags);
+	f = create_pmu_event_filter(events, nevents, action, flags,
+				    fixed_counter_bitmap);
 	r = __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
 	free(f);
 
@@ -747,14 +752,16 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	 * Unfortunately having invalid bits set in event data is expected to
 	 * pass when flags == 0 (bits other than eventsel+umask).
 	 */
-	r = run_filter_test(vcpu, &e, 1, 0);
+	r = run_filter_test(vcpu, &e, 1, 0, KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
 
-	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+			    KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r != 0, "Invalid PMU Event Filter is expected to fail");
 
 	e = KVM_PMU_ENCODE_MASKED_ENTRY(0xff, 0xff, 0xff, 0xf);
-	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+			    KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
 }
 
-- 
2.31.1

