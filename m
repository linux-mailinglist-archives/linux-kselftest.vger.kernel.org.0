Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CC6E90D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjDTKsm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjDTKsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36B1723;
        Thu, 20 Apr 2023 03:46:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1a66b9bd893so8852875ad.1;
        Thu, 20 Apr 2023 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987602; x=1684579602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amyRMXzkbBlo1Nn8Dg6ZmQl7pYumfbivxhnDwHgT/8I=;
        b=Gn7JdtZxGjvrp92lW/UyBh1jY6HN5BMqlYRtswXKqqVayIYeNtYqJF4Vkb/DUIVqts
         /80vWZFPwyEHbbxTciHZkMerUddWKZesdbuy1XXaI/EPGaXtvdxHLZRbczSSQJ3GUDI3
         hkTmn3+yIsUp5zwRHTqh/zSy1x8tN7v2325RJXXqAmEt5hiyY6OOMEWBERhYDbNEoKQS
         ic2l7PVjLr0jFx+8QEBAcvzKNYGMDARpW464cJIARtL3ffERGANHYcZzQZTJfJ8K10gV
         A95SmFcB0r4x24c0ir+Cj0X2/nkdEVdiszaS3kCLYUqoKBUCO1NIy5Oaie5uSEG/7ykQ
         DNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987602; x=1684579602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amyRMXzkbBlo1Nn8Dg6ZmQl7pYumfbivxhnDwHgT/8I=;
        b=K+1rbt9AAp6EaHEtUFI/Amg/GufKp7QM/177O5P8iUELgbiTD8aAoI9CquJ+3Zkz9n
         j0DqPJyNK0neA+O/kbT3N8GZl+AyXDZgfk/E9DrTNV9E8J65SGA04xO6Q7OrgyZ8dvGq
         myRIy4O2kAK+zglqtuRBnKC7+AmcTZQRU1kRUAlYPdj0d2Nqlav4FNfcjTlHWZu49AcA
         li7aTsRjej0yCWYFrjvMpDJKo6Uorns+6uR1NPyEbqWtCmES6CEn2PmCixh9MYPx4/8n
         +XhZyfvOtp2Yls7kbYgO1WwTfErM/OL8pmvzzImSHTHMI6OjTtTkElVkzOvAQxxucDGP
         E2qg==
X-Gm-Message-State: AAQBX9eS/c7qCNuxQxXTWBKWcQCYmXk3LOTajwEyGv04t9ngwU5EYV1+
        wGcYIw+Z1eartoXynVC8pB4=
X-Google-Smtp-Source: AKy350YELMSrDxge3JDDa9nCYfG5YWnArj50vcMnmOucXLMOum6Atz5dw3L0xEmm0ozMqkKyjbzf9w==
X-Received: by 2002:a17:902:f803:b0:1a5:22f3:220d with SMTP id ix3-20020a170902f80300b001a522f3220dmr996991plb.49.1681987602527;
        Thu, 20 Apr 2023 03:46:42 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:42 -0700 (PDT)
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
Subject: [PATCH v2 3/7] KVM: selftests: Test unavailable event filters are rejected
Date:   Thu, 20 Apr 2023 18:46:18 +0800
Message-Id: <20230420104622.12504-4-ljrcore@126.com>
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

Adds unsupported input test cases for PMU filter. Specifically,
it tests the input of unsupported "action" values, unsupported
"flags" values, and unsupported "nevents" values, which should
all return an error, as they are currently unsupported by the
filter. Additionally, the patch tests setting non-exist fixed
counters in the fixed bitmap doesn't fail.

This change aims to improve the testing of the PMU filter and
ensure that it functions correctly in all supported use cases.
The patch has been tested and verified to function correctly.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 4e87eea6986b..a3d5c30ce914 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -27,6 +27,10 @@
 #define ARCH_PERFMON_BRANCHES_RETIRED		5
 
 #define NUM_BRANCHES 42
+#define FIXED_CTR_NUM_MASK				GENMASK_ULL(4, 0)
+#define PMU_EVENT_FILTER_INVALID_ACTION		(KVM_PMU_EVENT_DENY + 1)
+#define PMU_EVENT_FILTER_INVALID_FLAGS			(KVM_PMU_EVENT_FLAG_MASKED_EVENTS + 1)
+#define PMU_EVENT_FILTER_INVALID_NEVENTS		(MAX_FILTER_EVENTS + 1)
 
 /*
  * This is how the event selector and unit mask are stored in an AMD
@@ -743,10 +747,22 @@ static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
 	return r;
 }
 
+static uint8_t get_kvm_supported_fixed_num(void)
+{
+	const struct kvm_cpuid_entry2 *kvm_entry;
+
+	if (host_cpu_is_amd)
+		return 0;
+
+	kvm_entry = get_cpuid_entry(kvm_get_supported_cpuid(), 0xa, 0);
+	return kvm_entry->edx & FIXED_CTR_NUM_MASK;
+}
+
 static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 {
 	uint64_t e = ~0ul;
 	int r;
+	uint8_t max_fixed_num = get_kvm_supported_fixed_num();
 
 	/*
 	 * Unfortunately having invalid bits set in event data is expected to
@@ -763,6 +779,42 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
 			    KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
+
+	/*
+	 * Test input of unsupported "action" values should return an error.
+	 * The only values currently supported are 0 or 1.
+	 */
+	r = run_filter_test(vcpu, 0, 0, 0, PMU_EVENT_FILTER_INVALID_ACTION, 0);
+	TEST_ASSERT(r != 0, "Set invalid action is expected to fail.");
+
+	/*
+	 * Test input of unsupported "flags" values should return an error.
+	 * The only values currently supported are 0 or 1.
+	 */
+	r = run_filter_test(vcpu, 0, 0, PMU_EVENT_FILTER_INVALID_FLAGS,
+			    KVM_PMU_EVENT_ALLOW, 0);
+	TEST_ASSERT(r != 0, "Set invalid flags is expected to fail.");
+
+	/*
+	 * Test input of unsupported "nevents" values should return an error.
+	 * The only values currently supported are those less than or equal to
+	 * MAX_FILTER_EVENTS.
+	 */
+	r = run_filter_test(vcpu, event_list, PMU_EVENT_FILTER_INVALID_NEVENTS,
+			    0, KVM_PMU_EVENT_ALLOW, 0);
+	TEST_ASSERT(r != 0,
+		    "Setting PMU event filters that exceeds the maximum supported value should fail");
+
+	/*
+	 * In this case, set non-exist fixed counters in the fixed bitmap
+	 * doesn't fail.
+	 */
+	if (max_fixed_num) {
+		r = run_filter_test(vcpu, 0, 0, 0, KVM_PMU_EVENT_ALLOW,
+				    ~GENMASK_ULL(max_fixed_num, 0));
+		TEST_ASSERT(r == 0,
+			    "Set invalid or non-exist fixed cunters in the fixed bitmap fail.");
+	}
 }
 
 int main(int argc, char *argv[])
-- 
2.31.1

