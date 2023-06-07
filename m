Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF48725F9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbjFGMhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 08:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjFGMhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 08:37:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528C81BD4;
        Wed,  7 Jun 2023 05:37:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5428f63c73aso3666157a12.1;
        Wed, 07 Jun 2023 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686141442; x=1688733442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jycjm7UUY6dgXlUa3M0HM9k2B3+PK9kZAAwfi4QoyuU=;
        b=YX7x6kblEiYxd0MxFjQqQ06ofuf55tBCihaVYilD9L5ee5/dVRvrXSeqfF38Vxkntl
         2wFSfbcH7gs3FwkKtERDLPhEtulOPkQv4qkapwnBSuxACtodyUKwjtCvpAf1SmPq7LDP
         DZBiEGzOb3PX34p87PFgTTvbStFihBfIqqtMhyQj097T+VvfECbDH0N8OHpk6Bexl4Sk
         RUv579n49vjQxD5vivSNk6TBKnTXpKNKq1DuhVDTiVTO02b78cPT1XsjLcS+igGRzQmP
         pYdKj9uteNFCsw76YrweG0D17RmSEn2rLGDgTeHH1vWJGeSpPGHH6ZPBQCKWTzIcWN9a
         InQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686141442; x=1688733442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jycjm7UUY6dgXlUa3M0HM9k2B3+PK9kZAAwfi4QoyuU=;
        b=O4qvTor0uiaeiGVtjknlMUUxvOpwpadY++iBPUV3nykTWd6Q++N0nCKpxUP6Ow506k
         JSSgT+F2AuLAmcRYXTrkCyrtcVTUdjRsD/KRbX/O6lKKMteh+Aj8S8EBgz5EoihlBl9C
         eFKozo4AhJVLW9dW9KGkGYTjwQVxYsJz7dGMRMw9QDoi5DeJAkqKWMbU6N/2ALdUfKDA
         WsYUG6nIThkDtBxrKyrVDactJLhGEIl4tJ37VNPVOQLHnRmxKnOMFYiD8BCM4GRUKoBo
         K5nSzTjrs1DB1tNv1Ia/Z+w+Rk2SE8EOGb5obVp5YpjtCRHWmhkweq9MlR5buURTZt6i
         H8Mw==
X-Gm-Message-State: AC+VfDx+NXICBhMa9TVA7bGDBms4kNJ13DToy05B3UPAWKhtmfHqCbaC
        Ac+PU73JrThlG3EizlVrKaA=
X-Google-Smtp-Source: ACHHUZ45Gqrp4FF81uOlD7FjTZo5QO6fx/aMAGdDxlJaGzCzOLC7m3sKWhPp+4wRpH0BY2pf+mR4pw==
X-Received: by 2002:a17:90a:b28e:b0:258:d917:26f2 with SMTP id c14-20020a17090ab28e00b00258d91726f2mr2791881pjr.14.1686141441666;
        Wed, 07 Jun 2023 05:37:21 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id k18-20020a635a52000000b00528db73ed70sm9038904pgm.3.2023.06.07.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:37:21 -0700 (PDT)
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
Subject: [PATCH v3 2/4] KVM: selftests: Test unavailable event filters are rejected
Date:   Wed,  7 Jun 2023 20:36:58 +0800
Message-Id: <20230607123700.40229-3-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607123700.40229-1-cloudliang@tencent.com>
References: <20230607123700.40229-1-cloudliang@tencent.com>
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

This commit adds test cases for unsupported input values in the
PMU event filter. The tests cover unsupported "action" values,
unsupported "flags" values, and unsupported "nevents" values.
All these cases should return an error, as they are currently
not supported by the filter. Additionally, the patch tests setting
non-exist fixed counters in the fixed bitmap doesn't fail.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 48 +++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 26f674c32cde..7555e0f4290c 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -11,9 +11,7 @@
  */
 
 #define _GNU_SOURCE /* for program_invocation_short_name */
-#include "test_util.h"
-#include "kvm_util.h"
-#include "processor.h"
+#include "pmu.h"
 
 /*
  * In lieu of copying perf_event.h into tools...
@@ -32,6 +30,10 @@
 #define MAX_FILTER_EVENTS	300
 #define MAX_TEST_EVENTS	10
 
+#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
+#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)
+#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
+
 /*
  * This is how the event selector and unit mask are stored in an AMD
  * core performance event-select register. Intel's format is similar,
@@ -762,6 +764,7 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 {
 	uint64_t e = ~0ul;
 	int r;
+	struct __kvm_pmu_event_filter f;
 
 	/*
 	 * Unfortunately having invalid bits set in event data is expected to
@@ -780,6 +783,45 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 					KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
 					KVM_PMU_EVENT_ALLOW);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
+
+	/*
+	 * Testing unsupported "action" input values should return an error.
+	 * Currently, only values 0 or 1 are supported.
+	 */
+	f = base_event_filter;
+	f.action = PMU_EVENT_FILTER_INVALID_ACTION;
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r != 0, "Set invalid action is expected to fail.");
+
+	/*
+	 * Testing unsupported "flags" input values should return an error.
+	 * Currently, only values 0 or 1 are supported.
+	 */
+	f = base_event_filter;
+	f.flags = PMU_EVENT_FILTER_INVALID_FLAGS;
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r != 0, "Set invalid flags is expected to fail.");
+
+	/*
+	 * Testing unsupported "nevents" input values should return an error.
+	 * Currently, only values less than or equal to
+	 * MAX_FILTER_EVENTS are supported.
+	 */
+	f = base_event_filter;
+	f.nevents = PMU_EVENT_FILTER_INVALID_NEVENTS;
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r != 0,
+		    "Setting PMU event filters that exceeds the maximum supported value should fail");
+
+	/*
+	 * In this case, setting non-exist fixed counters in the fixed bitmap
+	 * doesn't fail.
+	 */
+	f = base_event_filter;
+	f.fixed_counter_bitmap = ~GENMASK_ULL(X86_INTEL_MAX_FIXED_CTR_NUM, 0);
+	r = do_vcpu_set_pmu_event_filter(vcpu, &f);
+	TEST_ASSERT(r == 0,
+		    "Setting invalid or non-exist fixed cunters in the fixed bitmap fail.");
 }
 
 int main(int argc, char *argv[])
-- 
2.31.1

