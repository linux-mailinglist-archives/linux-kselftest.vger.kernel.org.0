Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549F6E2173
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDNLBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNLBN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C58D35B1;
        Fri, 14 Apr 2023 04:01:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-246f856d751so518535a91.0;
        Fri, 14 Apr 2023 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470071; x=1684062071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh/XSi4I3WO2A97bJ5WxQEPSGlXqsNCf/xgmHJn584A=;
        b=WnuE6nxkUlOOm8aUiTcKLZz3d1ReJdCFwQ12dlUaotuNneEvqUszV9C3QTDBUaGuzz
         D3FTTrB7hGVjgsny9xBMOSD7vV74BzAarOP3sRO1nwtkUMMNWyAxSkeZGmJe2nWX+lug
         bvqBzZK4lj/yPp58hBG+ndHEH16WbMjz9I0+z9G2UxFY0MCVqvtMAyk8CZ3bMmE8Jrhc
         57HZpZmnozj5S3N7fensi2ui+XkRhPISg3gv1oCnXA0NgdtcL70TnZHQivTNE9zN7wmo
         +E3M5PqQlOGHawZa2yBaSNFLHKkoGTA7+VPNGPZAfqwBmWsoDCbKktPn/DHWL+L8+1al
         0E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470071; x=1684062071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh/XSi4I3WO2A97bJ5WxQEPSGlXqsNCf/xgmHJn584A=;
        b=fqjcEHPh/fPvR1489G1KYKZgbi65l6vBFOV06j0PEEwyhQ4cUPRuTB91W8EG2+3dML
         hh9oRtXLwU/MCdbxDwM8Y1htrNPyBY9pUtqhLQF5kG4MnzVku5GT9qWlh2BlSur6WoEb
         Wf6ZGCiI/usaOKeRAkCJ8SS2NWM0hzprIMNjys2hMy9m2zs3rRtAH8qHSIMNagfXh50U
         aLANtVeKkIggekzhXcq59R8FkpFbeKi4Adb/uUKbAR98MsOBGhDViz/0bQKRcufE5d/L
         Jl54PAHRPOmHsT5u+pRB4BPTjSLVuP/SO18bwyavxJTxhqgYOcHJIafiYjNK4X9MhB36
         fR2g==
X-Gm-Message-State: AAQBX9dhvR+XDIqQ1XRGkokOxsC9T0LVa8QpqNjb6TuHc004um0PuLr7
        TSBjR54mAYkhO9NUU7bqQso=
X-Google-Smtp-Source: AKy350Ysfs2nFJ1j7gjqVzfTb9TkQ+bVpZvNlBcfTP28Dsay0LynWBtG/x8942HogUTA/djobpnl+w==
X-Received: by 2002:a05:6a00:2e1d:b0:636:ea6c:68d8 with SMTP id fc29-20020a056a002e1d00b00636ea6c68d8mr7585283pfb.27.1681470070694;
        Fri, 14 Apr 2023 04:01:10 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:10 -0700 (PDT)
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
Subject: [PATCH 1/7] KVM: selftests: Replace int with uint32_t for nevents
Date:   Fri, 14 Apr 2023 19:00:50 +0800
Message-Id: <20230414110056.19665-2-cloudliang@tencent.com>
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

Defined as type __u32, the nevents field in kvm_pmu_event_filter
can only accept positive values within a specific range. Therefore,
replacing int with uint32_t for nevents ensures consistency and
readability in the code. This change has been tested and verified
to work correctly with all relevant code.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_event_filter_test.c     | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 1f60dfae69e0..c0521fc9e8f6 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -194,7 +194,7 @@ static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t nevents)
 
 
 static struct kvm_pmu_event_filter *
-create_pmu_event_filter(const uint64_t event_list[], int nevents,
+create_pmu_event_filter(const uint64_t event_list[], uint32_t nevents,
 			uint32_t action, uint32_t flags)
 {
 	struct kvm_pmu_event_filter *f;
@@ -648,7 +648,7 @@ const struct masked_events_test test_cases[] = {
 };
 
 static int append_test_events(const struct masked_events_test *test,
-			      uint64_t *events, int nevents)
+			      uint64_t *events, uint32_t nevents)
 {
 	const uint64_t *evts;
 	int i;
@@ -670,7 +670,7 @@ static bool bool_eq(bool a, bool b)
 }
 
 static void run_masked_events_tests(struct kvm_vcpu *vcpu, uint64_t *events,
-				    int nevents)
+				    uint32_t nevents)
 {
 	int ntests = ARRAY_SIZE(test_cases);
 	struct perf_counter c;
@@ -695,7 +695,7 @@ static void run_masked_events_tests(struct kvm_vcpu *vcpu, uint64_t *events,
 	}
 }
 
-static void add_dummy_events(uint64_t *events, int nevents)
+static void add_dummy_events(uint64_t *events, uint32_t nevents)
 {
 	int i;
 
@@ -714,7 +714,7 @@ static void add_dummy_events(uint64_t *events, int nevents)
 
 static void test_masked_events(struct kvm_vcpu *vcpu)
 {
-	int nevents = MAX_FILTER_EVENTS - MAX_TEST_EVENTS;
+	uint32_t nevents = MAX_FILTER_EVENTS - MAX_TEST_EVENTS;
 	uint64_t events[MAX_FILTER_EVENTS];
 
 	/* Run the test cases against a sparse PMU event filter. */
@@ -726,7 +726,7 @@ static void test_masked_events(struct kvm_vcpu *vcpu)
 }
 
 static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
-			   int nevents, uint32_t flags)
+			   uint32_t nevents, uint32_t flags)
 {
 	struct kvm_pmu_event_filter *f;
 	int r;
-- 
2.31.1

