Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE42D6E90E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjDTKs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjDTKsf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BE10EA;
        Thu, 20 Apr 2023 03:47:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so835695a12.2;
        Thu, 20 Apr 2023 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987619; x=1684579619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUsKL4hqeOrADLXVSzAKCm9V00hdTaU+8spEB1aYNQY=;
        b=XwOj6TyipWhhJdAB/ZOgsH+8NkWNHP9eop/f1eQlml/0xc71YH8eJGrLygEzTd9ECL
         keYbS0+HlxqcLXMjXaOR9Z3Hl1CeU5/pLmBQ/EzVtnfppCWcRK4YogbQ6deH1DSen2sV
         Mlxu7ov93Wj0KZ5ZRy3WaY8enAZrb1A8C/33Sn6oOVYdbAzQgYzdvQDDMDMJmKXaYbKK
         hSdNVHvVyNfa3Gpl7OHpDSLxEuGu7CBu2cw6JuS8DfqUf/1tL5d/5LtDYxr/Sw7U0rNd
         DcMRhwq1zCKdubu8rnzugBJIqls8P7zkxv8eTup0v/x2huQERG2UVCtnl6CaPt9w/ilU
         IoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987619; x=1684579619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUsKL4hqeOrADLXVSzAKCm9V00hdTaU+8spEB1aYNQY=;
        b=PqXrqwd7UYdU1ecQQ1QlV3+V+b6lpwfBlg16/6xYaTL5C128rm3fH5Y2RfM1P516Hu
         +wutCwdwPVQ3nnO61ywcOg1f245NgVhxUGrNzonnUm35vnzSZnPC/yMO0Hqi9LxOYUbQ
         ExrhrSFOf0aR5gAUeAmZGt5hJcWcHnVEqoWGONAHyBBerwCHtGzY/TAU6jTONq9ZhcD7
         2iKsE3hPoBZiEmUfKYVkWR0koBUrSUolCbHzaXvhDr50J3vBc+uR47fGuo/+J6DOUcQA
         pSidfIYWjVjN3dwdd6MXZEVwxWYARsK6G1QADH5QRvoQFTwWFPnppa2ZS6gW23NnpdCk
         dK2A==
X-Gm-Message-State: AAQBX9ekZzkVqnFGPV/+JMBnJuzCkR6fHq60qxuZkb3d6XeBMbpgJSiN
        9JnHWMzO6bqNrWOaN1R2V0g497/dz6hZL+a0
X-Google-Smtp-Source: AKy350aI2hqildqUB6LxE9IbVKgqCR4ALns3I3izkecaOeS3k/gPSceIf14vciqRl46CPQ7yhdCZhg==
X-Received: by 2002:a17:90b:1bc8:b0:249:897b:fac with SMTP id oa8-20020a17090b1bc800b00249897b0facmr1154624pjb.39.1681987618824;
        Thu, 20 Apr 2023 03:46:58 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:58 -0700 (PDT)
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
Subject: [PATCH v2 7/7] KVM: selftests: Test pmu event filter with incompatible kvm_pmu_event_filter
Date:   Thu, 20 Apr 2023 18:46:22 +0800
Message-Id: <20230420104622.12504-8-ljrcore@126.com>
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

