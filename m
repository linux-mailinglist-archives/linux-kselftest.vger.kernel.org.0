Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7B75AD62
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGTLsT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjGTLsO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:48:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4001711;
        Thu, 20 Jul 2023 04:47:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b8a462e0b0so4112575ad.3;
        Thu, 20 Jul 2023 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689853675; x=1690458475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3msxjZdgetMbrGi/qXLG+gWb+dY8uVEsPP0nY7G4QQ=;
        b=nO5tehWvaIgWtdqxq77tk0usuoipGQXYmcIJVLSVxabUWEFmKxlLhb1u+voA2UhAY8
         tf5PD0Lz86rT2JT4HGJbjh04Xb2NjGCZQpU1FnEl5La+yBg05yzTBgLPOMFQO/nHpiYc
         j7JGD3oNEpGPxax8El4mk0QXy4OFkovT7ongxxXZoAW4D4aTVTq7AJ3eXYc+okMDt15x
         1gLFv1aYNv88VbErxUKhzgVXmppKMYRGMQPkWQTGG04ekeDu6FvDHrAtmrThBAPWVvBY
         cM5rbakOv2+xMrodu3FXbosh1KmTulNwrdCzMVvNTYJJMzIvDc5r+n8licLkGmEPhate
         OKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689853675; x=1690458475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3msxjZdgetMbrGi/qXLG+gWb+dY8uVEsPP0nY7G4QQ=;
        b=VDMBn5oWV1JK5trP9op+H7bukWXczrXDepjDyOQo88odvx1noBc8KSCV26uvTXcTmj
         5eSzpeUkCw7pypc/PIAFbGdUyz17s7UI6QbY+tIUs+wIBffsy64HHPhRmtEDwgHCcRow
         383aW4TziuI86PMO23J0j8do/o+M3NLz+U0TX2ogVQCLfd8guAu9xBBFCW0lVAwn7+O+
         XSVB1aaD9lRnpBCKamCXMIpk5upREr8jB5GJJmtEVCUSvjMeH1kS5XUSC4+OaT4ts+Np
         DJELk58R9xO1brWVcxaIWmA4kQs/duWaYFmsuHZnBW9ziFEjGFOIS+RJIXgOmKgnF5vs
         JiiQ==
X-Gm-Message-State: ABy/qLZEIIJ0vA0NRUw0hokPeY1MYKPF0rjxYYANZbJVUKzQVal0Jhnr
        NAoYjxVclVKCGww7JW7bDdk=
X-Google-Smtp-Source: APBJJlGhnr3budaAVAV3RnSZI66mWhW6dvpa/wc8siefx8aeHt5+M50r4WAe/hn2d3bUgjJ025iF/Q==
X-Received: by 2002:a17:903:234c:b0:1b8:86a1:9cf with SMTP id c12-20020a170903234c00b001b886a109cfmr5893507plh.32.1689853675583;
        Thu, 20 Jul 2023 04:47:55 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm1164007plq.18.2023.07.20.04.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:47:55 -0700 (PDT)
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
Subject: [PATCH v5 6/6] KVM: selftests: Test gp event filters don't affect fixed event filters
Date:   Thu, 20 Jul 2023 19:47:14 +0800
Message-Id: <20230720114714.34079-7-cloudliang@tencent.com>
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

Add a test to ensure that setting both generic and fixed performance
event filters does not affect the consistency of the fixed event filter
behavior in KVM.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index a9d44ec210c4..08c7ccd81be2 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -838,6 +838,19 @@ static uint64_t test_with_fixed_counter_filter(struct kvm_vcpu *vcpu,
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
@@ -864,6 +877,20 @@ static void __test_fixed_counter_bitmap(struct kvm_vcpu *vcpu, uint8_t idx,
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

