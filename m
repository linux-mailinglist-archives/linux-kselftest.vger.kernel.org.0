Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B706E90D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjDTKsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjDTKsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5672AE;
        Thu, 20 Apr 2023 03:46:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-63d4595d60fso6018799b3a.0;
        Thu, 20 Apr 2023 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987595; x=1684579595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXFHW7iXk4dJ6nVc5Wo6lbWk1qPwCtaiF8CuuRqSUi0=;
        b=d32rF8ERS9tUt0wzbfB8qbCf7jO6drVH44mgIs+0uWTVYZDXPeutVnJwBTa4E5XfjW
         rdRDzTG2J9z+NDBTMt9y7zT9WPqMhHwhlahB/KSlcu47rONknE3lDM9ojnMEfeDH3Osw
         egqmLGq00gFlNwt63Dtg+TRY0fWSCTRMkDcbGyYqm92Iy1oFcfW8q4XEKdhT1WgpoLD3
         cF3q4QIiY4tjpNc0+Hxu8pHj/WTdUfvOGCp2+XaBI4sbRM7yYAqd2WjTkloNB2jyNiQc
         RcnVndrZU4jHZZXInwkvsEaZmqZI06PjeKVXvBtj+cxPHf9IgP8CJ12Cb3jP4KT5xxLH
         Aykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987595; x=1684579595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXFHW7iXk4dJ6nVc5Wo6lbWk1qPwCtaiF8CuuRqSUi0=;
        b=FpXz5BHsOJ/hi6ShFE7KndEuvo3iq723R72WkKf3utMLQqu73Eor8PxNJTMBWJ/v+q
         sKn/H9in0IJ8LXKcmrCgtbr8rr+mIpf2EmsaK9ETw+Hr6U5SpobLtfTqzYC2BOvjcvZE
         +q2wWPY95sWjuKdwrhXojEFg+NDJb4O2F+GSr/PYG5yoEtEg8N4Nhlk6dKP81TiR4V/B
         sYMveH3u9vMijH5aHyN8siU4/pDT3qpKfbkfHf4cHJx6bpPy27FGdy1l6YkwKMN16g4+
         Xdf8CzOesDISZemfF2HcvysvwgnQm2tMFAjdNnAGqV/xcZ6QaepKtMPIgDT0I5r8mHfN
         TjXg==
X-Gm-Message-State: AAQBX9c8lOgFklabaGe937VV9TeOTbYLVlXjsOZzYED4GSMTA2cJSAKE
        RZUDxi1MmTESZxYeNLD6n34=
X-Google-Smtp-Source: AKy350a1y/bsuU9YAw5AlxkPFGbXMO/u5JXsUPPOo8PmN4178ccGushfA7+gQOtl4aNA/fu4rWoaxQ==
X-Received: by 2002:a17:902:d486:b0:1a6:98a4:e941 with SMTP id c6-20020a170902d48600b001a698a4e941mr1442379plg.2.1681987594807;
        Thu, 20 Apr 2023 03:46:34 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:34 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <ljrcore@126.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] KVM: selftests: Replace int with uint32_t for nevents
Date:   Thu, 20 Apr 2023 18:46:16 +0800
Message-Id: <20230420104622.12504-2-ljrcore@126.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420104622.12504-1-ljrcore@126.com>
References: <20230420104622.12504-1-ljrcore@126.com>
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

