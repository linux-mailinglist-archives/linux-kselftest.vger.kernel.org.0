Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C575AD54
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGTLsH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjGTLr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:47:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C32717;
        Thu, 20 Jul 2023 04:47:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1b8b2b60731so3686065ad.2;
        Thu, 20 Jul 2023 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853668; x=1690458468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fZBKSqD0Jf4EbIjfm4Dlb8jsXARp8sPconxfCXxUFY=;
        b=TxgaJKo30NHJbsD8qj5iMbi2YtknFcRWNPHNlyvE/r3f5bPpDbeOzcN72Oz9CIwLAM
         CMW84HXF1VWlyTMRVjhoT9gi+jzZ0lGGNF6AYWU665fUvU7Z0/CcYLBp6OK9WNMLq5qV
         EgJ+SDo6TjAL8sph1RD1ds3APon9z4j0JLmKuZ1X7Qr3u+4YgwayAUWelgSdOrJffYN2
         OHKLClpWlsh6LUpg0v3M9WfuqylAQ97YrskOBH4nBu0CGeoVDeEp3LH9miRqRdP1tJob
         CdkSdtRzoL2RfEn2N2M6amd0gQ1x6fhIWowKfryo7nxvmCr1s2Y/kAzBBVT+983CjwZi
         doCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853668; x=1690458468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fZBKSqD0Jf4EbIjfm4Dlb8jsXARp8sPconxfCXxUFY=;
        b=aAechK96Yy3LGJbsqY8eKTSRsGCgoCN5DocL177HkJB1BoC5bcKyFc/vsDcbFQ0gPM
         rD5kTs6RRJ2ZSdRj78Sp3v4Tzszlqp6vSaKnNzDKt96x2QvkgDl+BceQzi85u8XppcnA
         yKMmieQ4nC7wF8hqLuYq6BZP0rsxX1KjzXlyXUFjKx58bVCW7DbBp+m4UstNtlaq4NGs
         mUcuvSdw5NSjmFZ6x9qpAYesfWbnGGC345h4h3Zk7Ec1Qto8NvFJDaAoP6SNxsUFq3R2
         HaapbJsaQIv3XwQ/UWq+SUo9P6BHNiBw7X/pkzJL5PCZr/x2xPMNnM9fPAocQaXrw/3w
         XbMg==
X-Gm-Message-State: ABy/qLbKr57DA53+W61jUxy296q0trLcnxUuvHtDtQFDmwxdUPyK6OPk
        vlG4mC/BBwQCBFcGPTMMzAdnT7mgps1fZJIBxP0=
X-Google-Smtp-Source: APBJJlF77fVdbFjzM5yk7KZZfObH84Tbjs+A+leFC7VtcZUXAXEtrIo6Y0115xhBd33BKoRTyaS+dA==
X-Received: by 2002:a17:902:cec3:b0:1b8:1e58:e906 with SMTP id d3-20020a170902cec300b001b81e58e906mr21334755plg.67.1689853668602;
        Thu, 20 Jul 2023 04:47:48 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm1164007plq.18.2023.07.20.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:47:48 -0700 (PDT)
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
Subject: [PATCH v5 4/6] KVM: selftests: Add test cases for unsupported PMU event filter input values
Date:   Thu, 20 Jul 2023 19:47:12 +0800
Message-Id: <20230720114714.34079-5-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720114714.34079-1-cloudliang@tencent.com>
References: <20230720114714.34079-1-cloudliang@tencent.com>
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

