Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900DA725FA4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 14:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbjFGMhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 08:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbjFGMhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 08:37:31 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E261BFD;
        Wed,  7 Jun 2023 05:37:29 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-39c6a912fbfso424536b6e.2;
        Wed, 07 Jun 2023 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686141449; x=1688733449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JulaA06kDm2sGfAisFXplukNUhlKK2eT1+N5qu5QA8=;
        b=NVaskHjNhPFgUZLhChEdjToQh+YCHQSm9cUwDsJmmrQ5r99ZaxRwtPd4zAOqUJDcxX
         I4Ys104Pl/qRzOZtIsBl3AQbojPlCywRnSLiWGOJJzQQJPyNAj8Rw4R/iEAbNRmuLnJE
         wU25CzkIL8tiqBzpL4vM4gfdA91NsHGEMG1cr+uq5oGW1/XtK7wKh06oWmUw00CpKjU1
         MqE1wszRTT8BijgVoUK+syKnOMrUtsUDt9AOmJABVtCpYJPh7UE/eVqXA7Y4lRxECQT1
         WS6flTZJr6REXSHebzPNpZvJwkEjOTNrb/GhusbTn+vW87kBIxkQWqEN3J1vnmU8jXt+
         Afvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686141449; x=1688733449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JulaA06kDm2sGfAisFXplukNUhlKK2eT1+N5qu5QA8=;
        b=lF8YK0dC3l/m3dPao1xISqgOzlbU9kZbSwnnPRGXK53KU1idnbGaBG/m5Xeqq+zom7
         Y2AUzVrnRpTWs45zyV55rZCE5HfHWWwJcsakUuz731xWmlj83W9noG8gJXims3b9Gx2h
         e5qhL6U5wh65JbeCaKhSqWM8YLWvHB2yxgLTsKjNk/xTsh1BLyhVHEcXPTmOCPJ8izGx
         DDl488O1S3YUuFgvWVwXOPnkRf4nghM0/0WLwC6R2VCbVIwQVhOaET8l3wsd93e3LHXF
         9qrkDZY2z6YxlP9R9PtTvTS61qlMaOEfHXzXQMhk3rluy0u/K92h6vcTCEZzMfnYiCT9
         4e/w==
X-Gm-Message-State: AC+VfDyCJyWJRQcdeziFsXIPybNoaZL9bpyukYa0cMh9ZQryby0GsmyN
        N+CkjR9GGimf5q3GDJ/DjA8=
X-Google-Smtp-Source: ACHHUZ5NU8+maeRhLeFdmgUPOmyVJH2ur1fcMk17xDFWnaWR+nMrYUXQrnGOS9W7gRWezFYo3AUkpQ==
X-Received: by 2002:a54:4604:0:b0:38e:d739:6f3f with SMTP id p4-20020a544604000000b0038ed7396f3fmr4738680oip.56.1686141448942;
        Wed, 07 Jun 2023 05:37:28 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id k18-20020a635a52000000b00528db73ed70sm9038904pgm.3.2023.06.07.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:37:28 -0700 (PDT)
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
Subject: [PATCH v3 4/4] KVM: selftests: Test gp event filters don't affect fixed event filters
Date:   Wed,  7 Jun 2023 20:37:00 +0800
Message-Id: <20230607123700.40229-5-cloudliang@tencent.com>
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

Add a test to ensure that setting both generic and fixed performance
event filters does not affect the consistency of the fixed performance
filter behavior in KVM. This test helps to ensure that the fixed
performance filter works as expected even when generic performance
event filters are also set.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 72f7fdb821e5..79bfdb64820b 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -853,6 +853,19 @@ static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
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
@@ -881,6 +894,25 @@ static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t idx,
 						       bitmap);
 		TEST_ASSERT(!!count == !(bitmap & BIT(idx)),
 			    "Fixed event filter does not work as expected.");
+
+		/*
+		 * Check that setting both events[] and fixed_counter_bitmap
+		 * does not affect the consistency of the fixed ctrs' behaviour.
+		 *
+		 * Note, the fixed_counter_bitmap has higher priority than the
+		 * events list.
+		 */
+		count = test_set_gp_and_fixed_event_filter(vcpu,
+							   KVM_PMU_EVENT_ALLOW,
+							   bitmap);
+		TEST_ASSERT(!!count == !!(bitmap & BIT(idx)),
+			    "Fixed event filter does not work as expected.");
+
+		count = test_set_gp_and_fixed_event_filter(vcpu,
+							   KVM_PMU_EVENT_DENY,
+							   bitmap);
+		TEST_ASSERT(!!count == !(bitmap & BIT(idx)),
+			    "Fixed event filter does not work as expected.");
 	}
 }
 
-- 
2.31.1

