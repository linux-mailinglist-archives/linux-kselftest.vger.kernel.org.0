Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4688D7773D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHJJKl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjHJJKY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 05:10:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F7211E;
        Thu, 10 Aug 2023 02:10:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-564a0d2d35eso460328a12.0;
        Thu, 10 Aug 2023 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691658622; x=1692263422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCYgAfd5bZuG3/28sUikGuYme1J7pykWX651228hrR8=;
        b=VvXorgPLVm/eEiFpVC0OIv0jPwu7sPvvMO30Dp8Chf7YNfeYIlXawKXW0/rSn0rQgx
         DwuRLG/LX09ieLeAebicdXsSAJn2sw6vdBOsVYNyAqGEAgUX3JbW3JynOHl/rdGgA7Ao
         orGR7iyF80qBS57wSzBaMZWk0hKIzTzJO5ysUnCizqY4vMyjQ2moL1+4E8cxB5Jsmm5F
         lbxXG/gnVylwiMaPPmMsJQQvd+D8YKG2Oj+jA4EN1JhVWIfDm6PLtwM+7wPqsAWjEOtV
         4LNS+ApgsMLFD6LuVOdkxvIoIeWhfNN+MQ684U+66FYCVGpkgN0A+hshXDvSvgXDw8ta
         6FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658622; x=1692263422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCYgAfd5bZuG3/28sUikGuYme1J7pykWX651228hrR8=;
        b=aYaZQSD8QB0MHjyGTre6jWUO/3kTrS1QmUHHCkeOYDxGuJU7plOo+hN1DOGxSCD6aW
         PwmnQbQLaP9U7oeWDajeCfYOl3z7Z3oCafW+nax8MS9c8aXS5B7b4gUCEl7kElv/blJP
         Tom4gYD7W4k9JEkS66zTZPrCQJ2yqtiv05/nbVv2B4Dq6ODgPYLkc9ymJRMiQl9qENMw
         q/yejSTfuP3Ky0ZJUrHg72j+k4KVh6WbQIzTzfpaMqd81uRWHL7+NXpeC40dVP/Ivxlh
         I3M+8agbQ7Lwg1Cfo7ZJaW7txOqW98cSSASq++LLRDOEWDXZm+ReQC7Wg+Z80zyiRX2A
         7mMw==
X-Gm-Message-State: AOJu0YxL9cxXaAMBXWu316dAVxNJ++iymfvwivoXwLnyHExCvBAbjVEm
        rKMltDJcS92OiNiL/rQ8MjY=
X-Google-Smtp-Source: AGHT+IF7EVucMd05qUvpask4vh1ZQLlRGwgIr9/xKVM72fgSx73Vs2mbIbW1BNycb1vVzPhA/8LtEQ==
X-Received: by 2002:a17:90a:9747:b0:269:96e:7d52 with SMTP id i7-20020a17090a974700b00269096e7d52mr1291397pjw.26.1691658621801;
        Thu, 10 Aug 2023 02:10:21 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00263154aab24sm970704pjb.57.2023.08.10.02.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:21 -0700 (PDT)
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
Subject: [PATCH v6 6/6] KVM: selftests: Test gp event filters don't affect fixed event filters
Date:   Thu, 10 Aug 2023 17:09:45 +0800
Message-Id: <20230810090945.16053-7-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810090945.16053-1-cloudliang@tencent.com>
References: <20230810090945.16053-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 732c76c41bb0..2166b4085ca3 100644
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
 		TEST_ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
+
+		/*
+		 * Check that fixed_counter_bitmap has higher priority than
+		 * events[] when both are set.
+		 */
+		count = test_set_gp_and_fixed_event_filter(vcpu,
+							   KVM_PMU_EVENT_ALLOW,
+							   bitmap);
+		TEST_ASSERT_EQ(!!count, !!(bitmap & BIT(idx)));
+
+		count = test_set_gp_and_fixed_event_filter(vcpu,
+							   KVM_PMU_EVENT_DENY,
+							   bitmap);
+		TEST_ASSERT_EQ(!!count, !(bitmap & BIT(idx)));
 	}
 }
 
-- 
2.39.3

