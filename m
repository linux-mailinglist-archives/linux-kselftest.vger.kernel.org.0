Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8C7773CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjHJJKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjHJJKS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6962699;
        Thu, 10 Aug 2023 02:10:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-26934bc3059so1331667a91.1;
        Thu, 10 Aug 2023 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691658615; x=1692263415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fZBKSqD0Jf4EbIjfm4Dlb8jsXARp8sPconxfCXxUFY=;
        b=pUXZg1XyvkyccRwfZE2pTI5oYft+dcK8ubaWMfticT7kSrzLA4G7VohMnE7R+cLRn3
         LvApPqaVitYZm7H8t6Z4MHWFQnoIsenEXzQtkzBq8ylpz4bvlfwMFkk5ja3w+G8/TPAt
         TqUwLYKaGo62OlaTzgnFXnoBFVqC0sqJkIXp1s44LoCrSUZuYdRHprVvujmxLpwVT4oa
         QSoPJaclxrXYovfUEIRQi1fFF5LAWf8sh0aLs3ySUXlSyo51+mZCsKdEyEPDGw1HbZct
         gDFA7p2ESBHPg5wzuaSr7sWC7FnI/up+Sr/CAs9ZZ6QOzKTOXNerU9RxsLYOBAwnuzsv
         pULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658615; x=1692263415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fZBKSqD0Jf4EbIjfm4Dlb8jsXARp8sPconxfCXxUFY=;
        b=Wfm85JPWs/BBISGPVBK0U1Yn95daIxQUj35xn+RiFyrQnLCTPkmLZog9NDlKsaSNZ2
         H8nieYrJi5oXE01TNEFt+SBPPKM3V0AOPAXeBssVRYQPNtcS5XlCu7L/La5TBmDh7PO2
         TvH8FZy23KVaLn3PCmdl5JEp5I5m3ujV25GGAQh179zxYt/MdEMvF4A4qSGGFG3R6P4u
         FNbriGu25/tfItfFW1LE8Q63yvLapfJw/6pLSnvD0OK7QuF5aTtDikn1ozwj6xeCt9uZ
         AJlYSSp72CJYsEFgNT0OBZs1mY51Jcb1l7VWWMqoydmw7uHL53IoTjR96IB/j9O1prFs
         I2wA==
X-Gm-Message-State: AOJu0YzBZG7vZ0YBKlBjRuEtf1M5a8Cx53AB3gD0zKqRSRqVVmMV/Y9H
        NV/xKHDkChyyad7Qobn+s24=
X-Google-Smtp-Source: AGHT+IG2yGaeJeVpezS7e5wbJ7D30Ot3wdzkudHAl1q5S8YvCuRHrcFjYvpfgmrZYgbLgLXKRFoBlQ==
X-Received: by 2002:a17:90a:7149:b0:269:23fe:e325 with SMTP id g9-20020a17090a714900b0026923fee325mr2041612pjs.6.1691658614866;
        Thu, 10 Aug 2023 02:10:14 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263154aab24sm970704pjb.57.2023.08.10.02.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:14 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
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
Subject: [PATCH v6 4/6] KVM: selftests: Add test cases for unsupported PMU event filter input values
Date:   Thu, 10 Aug 2023 17:09:43 +0800
Message-Id: <20230810090945.16053-5-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810090945.16053-1-cloudliang@tencent.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Furthermore, the tests also cover the case where setting non-existent
fixed counters in the fixed bitmap does not fail.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 94f5a89aac40..8b8bfee11016 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -32,6 +32,10 @@
 #define MAX_FILTER_EVENTS		300
 #define MAX_TEST_EVENTS		10
 
+#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
+#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAGS_VALID_MASK << 1)
+#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
+
 /*
  * This is how the event selector and unit mask are stored in an AMD
  * core performance event-select register. Intel's format is similar,
@@ -760,6 +764,8 @@ static int set_pmu_single_event_filter(struct kvm_vcpu *vcpu, uint64_t event,
 
 static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 {
+	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+	struct __kvm_pmu_event_filter f;
 	uint64_t e = ~0ul;
 	int r;
 
@@ -780,6 +786,26 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
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

