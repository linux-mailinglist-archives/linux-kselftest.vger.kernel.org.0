Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED96E2190
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDNLCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjDNLCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:02:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4804C2D;
        Fri, 14 Apr 2023 04:01:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id kh6so16359233plb.0;
        Fri, 14 Apr 2023 04:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470091; x=1684062091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/8pDX/pU7JJmfGUenCJQ2UI8+BzuFusFiT+V1gcCtU=;
        b=EP0sMfrrsKdFH6FjpOMzZRMpKo3oBbGHMOEmqm7cIDrtgbkR26QOjynrPDPBJ4CYQr
         qc3XZKs5lTXbWdFsXlsTcjryDO2PqMJF5gUxalYuB3Vj5SKJxlWsYHV9ye6orcLv+At8
         f6cNCaykJbW2IMqO1zNK3kl8QIE5S1XrcuqBaMbdHATOsKKThq62+srk9ckWqLSMsDB0
         5mH0rkgfFle7Up3fwW8hBaMegz8J6lo95Mdize3MLc4NKiJdGey2ZW2/2StbcmdT5Jzl
         A0AJGIUFkeUA/rz0+GIMs04+86HPrhpFHhgLljEturKfThgCTnimFBvw7yFyiPBTzgsu
         3lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470091; x=1684062091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/8pDX/pU7JJmfGUenCJQ2UI8+BzuFusFiT+V1gcCtU=;
        b=exNFpRejGmRb9JiEXyqkL0oRTfT1waV89We27XamJjrkM9e7tbIGRNmZV5mTS+FPId
         +F9JJ1zxENUHC/XE7hzInjouLk930KoJrHwPsEIiDec0Rx1hljQNBcjpGqhdYW/HJhNo
         OtLfz5CqLmktxK31D7miKY2ru1OVFXq0C/PgeZ5Yvc999Gm4j4eYRN+qdzS8D7KSKDIk
         87kSMhUxMF6ti+7Ku3TVlrV7tR7Apg6Hvu31XLpXRiWlz0yBfrloEhygOccCq/nhMECE
         4uKH8NOIYhlXA4pfjhHIRpW9/+BXkj1e2LphBKU0aQwmZhGjLbcxtSeTgi9KOm30HYcG
         WQ/w==
X-Gm-Message-State: AAQBX9ePNOPT+JyWhE0zS23cAdYlno71OrkFNYZU0W+7yD7jxYI8/v2T
        7W8oURkS4RAAau4CouFDV7A=
X-Google-Smtp-Source: AKy350YQH6oU0EAAitXz0YQt2587Kcb68X3kT4Wh/x5JCN5bZaXwZhyWS9d7O3SBqH8d0UBqVnre8A==
X-Received: by 2002:a17:902:7d8b:b0:1a6:487d:deab with SMTP id a11-20020a1709027d8b00b001a6487ddeabmr2258786plm.24.1681470091610;
        Fri, 14 Apr 2023 04:01:31 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:31 -0700 (PDT)
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
Subject: [PATCH 7/7] KVM: selftests: Test pmu event filter with incompatible kvm_pmu_event_filter
Date:   Fri, 14 Apr 2023 19:00:56 +0800
Message-Id: <20230414110056.19665-8-cloudliang@tencent.com>
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

Add test to verify the behavior of the pmu event filter when an
incomplete kvm_pmu_event_filter structure is used. By running the
test, we can ensure that the pmu event filter correctly handles
incomplete structures and does not allow events to be counted when
they should not be.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 9be4c6f8fb7e..a6b6e0d086ae 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -881,6 +881,24 @@ static bool fixed_ctr_is_allowed(uint8_t idx, uint32_t action, uint32_t bitmap)
 		(action == KVM_PMU_EVENT_DENY && !(bitmap & BIT_ULL(idx)));
 }
 
+struct incompatible_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 fixed_counter_bitmap;
+};
+
+static uint64_t test_incompatible_filter(struct kvm_vcpu *vcpu, uint32_t action,
+					 uint32_t bitmap)
+{
+	struct incompatible_pmu_event_filter err_f;
+
+	err_f.action = action;
+	err_f.fixed_counter_bitmap = bitmap;
+	ioctl((vcpu->vm)->fd, KVM_SET_PMU_EVENT_FILTER, &err_f.action);
+
+	return run_vcpu_to_sync(vcpu);
+}
+
 static void test_fixed_ctr_action_and_bitmap(struct kvm_vcpu *vcpu,
 					     uint8_t fixed_ctr_idx,
 					     uint8_t max_fixed_num)
@@ -918,6 +936,11 @@ static void test_fixed_ctr_action_and_bitmap(struct kvm_vcpu *vcpu,
 
 			TEST_ASSERT(expected == !!count,
 				    "Fixed event filter does not work as expected.");
+
+			/* Test incompatible event filter works as expected. */
+			count = test_incompatible_filter(vcpu, actions[i], bitmap);
+			TEST_ASSERT(expected == !!count,
+				    "Incompatible filter does not work as expected.");
 		}
 	}
 }
-- 
2.31.1

