Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5284755B90
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGQGZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 02:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGQGZU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 02:25:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CA0171F;
        Sun, 16 Jul 2023 23:24:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b8b318c5a7so32666075ad.3;
        Sun, 16 Jul 2023 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689575062; x=1692167062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/T9TECqwtlPK/zIL+NP7OfC6MHV7iapqldWU70LRAo=;
        b=skepM+1BZmqhluFqQNxJP8LgFNsINfiA30NfKHjSH+QLCQiUnJ9r/w/IVrBsQ3d2Ir
         OiXMor9ORTLIbBZZfHp6z1H50mjnIFKD5dW16uooFXg0D8zQTCGpOCLIgW8LBcFqlwoy
         i490hSoTGkjEpmx6yfQQtK2q5e07ur1I22DpBoIVxhoA+iE5uSLr9Z089WnDAZul7EPP
         IzwKnQQstBhQF3asR8Is9oXK39cBwKCN1t+Qw2YLDq8HLEQ2r+IDGzSWxxc5KueZfWav
         nAo5nDVkLWNRe8ikQvfa/WvNhfY4cUuX1qgBGC1nnF1/VlX1cPNbKCO7Aqu6d2EJB+8m
         EQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575062; x=1692167062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/T9TECqwtlPK/zIL+NP7OfC6MHV7iapqldWU70LRAo=;
        b=dBoW4CoTIpL9J+KkaNhniOMH/KFQz7xbDvWpTCpX4ip1K6eXjQ6DUUbHkGaPs8bpiW
         hvrIr1sfX6NPEtMKzXAYYMMDGIJqV4JUjiWvpJIf233GRGFZ8ZMKWYP5ffHfOQWWGkw0
         p64lcfb4VnaSY2oISdtWr8WHdNvC6YEjpWhYQOJRw6QsRWjKQMpSWbBmsZLXf/UR3W0y
         WBfuxxLLZ+0L7+uYyA9fqxGQ0uEN+jewF7UTgstT6AQ2VzZEXLri7r5spXbISMndZk+w
         O4dR7w+4sTBN3QjcSm52GpbBdFs7vsm3DWkpzFxYS4lnX8OF/GiRe+4dCcdIKKJDegGw
         QK0g==
X-Gm-Message-State: ABy/qLYs35Wqgph2BGnBAdJGGDsIare42mRTZ8p0UM8Tb8n3SMTRc4x9
        1ll3FjGeIgHYLoIzNZtPdjk=
X-Google-Smtp-Source: APBJJlEqssmPLgnzEkJY2UQyz+TwDoq26mmaoyOH1yHSlCu8lEWXqRCK4ZQIwGDKD2A/Jc/aVvMRiQ==
X-Received: by 2002:a17:902:c946:b0:1b8:b2c6:7e8d with SMTP id i6-20020a170902c94600b001b8b2c67e8dmr12295040pla.66.1689575062571;
        Sun, 16 Jul 2023 23:24:22 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b9ff5aa2e7sm9555716plt.239.2023.07.16.23.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:24:22 -0700 (PDT)
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
Subject: [PATCH v4 6/6] KVM: selftests: Test gp event filters don't affect fixed event filters
Date:   Mon, 17 Jul 2023 14:23:43 +0800
Message-Id: <20230717062343.3743-7-cloudliang@tencent.com>
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

Add a test to ensure that setting both generic and fixed performance
event filters does not affect the consistency of the fixed event filter
behavior in KVM.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 1872b848f734..b2e432542a8c 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -835,6 +835,19 @@ static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
 	return run_vcpu_to_sync(vcpu);
 }
 
+static uint64_t test_set_gp_and_fixed_event_filter(struct kvm_vcpu *vcpu,
+						   uint32_t action,
+						   uint32_t bitmap)
+{
+	struct __kvm_pmu_event_filter f = base_event_filter;
+
+	f.action = action;
+	f.fixed_counter_bitmap = bitmap;
+	do_vcpu_set_pmu_event_filter(vcpu, &f);
+
+	return run_vcpu_to_sync(vcpu);
+}
+
 static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t idx,
 					uint8_t nr_fixed_counters)
 {
@@ -861,6 +874,20 @@ static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t idx,
 		count = test_with_fixed_counter_filter(vcpu, KVM_PMU_EVENT_DENY,
 						       bitmap);
 		ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
+
+		/*
+		 * Check that fixed_counter_bitmap has higher priority than
+		 * events[] when both are set.
+		 */
+		count = test_set_gp_and_fixed_event_filter(vcpu,
+							   KVM_PMU_EVENT_ALLOW,
+							   bitmap);
+		ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
+
+		count = test_set_gp_and_fixed_event_filter(vcpu,
+							   KVM_PMU_EVENT_DENY,
+							   bitmap);
+		ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
 	}
 }
 
-- 
2.39.3

