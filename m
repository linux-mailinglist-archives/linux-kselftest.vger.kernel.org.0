Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2E6E217E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDNLB2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDNLBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C6A276;
        Fri, 14 Apr 2023 04:01:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m18so17884835plx.5;
        Fri, 14 Apr 2023 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470077; x=1684062077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPnpI8Yay4CCb2SXpz08Ippsa0FVXvZQsHG96J42rN4=;
        b=acmSGXhoVlCz3WCg206wgeur0JhxZXQthyAoYAaPfFte3P2Du16QfJVQ2YvseR7+pS
         PGMAdyrIVbS9qlM2h14+OLkdEozCHyR3WZTxxucXAz8ZmIm5OHU+wXuLnnP3Trzjh5UW
         6s6NTEvk/JwA8UC9VVacs746icfdH7+B7er7UrEi5ZWv4C0ck7Vk0YUX30lLvb5Se+yE
         Spj6KEh36+vcn89DAhvBIzWQG3onvroH9Xjl0QBP8R6tO5b21yTqXuBub3bmBtGDDQaF
         Jm2TMRxbhBaGF1BvlUFty6pVIMhUiiddkXgvA3lu6rIJV3+YJmS20D+eJrXPJ5vyjeQ5
         puJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470077; x=1684062077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPnpI8Yay4CCb2SXpz08Ippsa0FVXvZQsHG96J42rN4=;
        b=DPFRIigjqgOtjGdr6plY8ICpFvZSaNEaqqtQ6oqKLjpNw50WqkMNH6r+OmsGvIqHZr
         pxe8OE/C/cM2x3BXRtJZ3dY6VHzuAp4r3Jk05vbC3nM17dkvzSiDj9M5Lm4NWUVHzEDO
         tbdTncSB0HLcMi32XIV0aBvHavOxJVNzKm2hHpRw2rbfQqJAeTto/Si68ddo/2/IVX7s
         r5ppRoXSQJ/2UNSvud6C2xr5aPQEZVHCQSJyV1bObgkltns/WNX/9MiphHWSTO3amZVL
         WmUTUd0vuGoxoanRu5zI55SSTuktjxRIPMcXoETwHeSpxc1dD3CiiX0N5sUViN7QPRza
         99EQ==
X-Gm-Message-State: AAQBX9dxzAw1EF6eVlILSibQc4Wuj3mFddAJoUaE/NWU1E1CJH2N3JDq
        prAyb/YmrzdxjulJA3p1qJk=
X-Google-Smtp-Source: AKy350ZzeYy/GGenPKrHzd3n5DWP9/38O6KEl5puV2XiDJjmatBwHVWnLs7GR3k8hAZcbtfzJfu0pA==
X-Received: by 2002:a17:902:b40a:b0:1a2:1a5b:cc89 with SMTP id x10-20020a170902b40a00b001a21a5bcc89mr2229226plr.44.1681470077676;
        Fri, 14 Apr 2023 04:01:17 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:17 -0700 (PDT)
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
Subject: [PATCH 3/7] KVM: selftests: Test unavailable event filters are rejected
Date:   Fri, 14 Apr 2023 19:00:52 +0800
Message-Id: <20230414110056.19665-4-cloudliang@tencent.com>
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

