Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DA6E90E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjDTKsz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjDTKsU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350C8A58;
        Thu, 20 Apr 2023 03:46:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-63d4595d60fso6020402b3a.0;
        Thu, 20 Apr 2023 03:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987613; x=1684579613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yAzb4w95wvVcgK4ZPqFRB6yxn5Nne+39hIPjBrv118=;
        b=F3aF8Cnc7IXk2LbCDoFPoAOekJWCyTFvqXfYTAAH3Za74ef9yaytvuxUxZBzIAfcK7
         AQiBQP8RoAHHBthO1+apTkKVw6ZV3gk9SFnw8lZKdgZ7eqCYc0tX1/yo3zxtL2lcnB99
         jawHlqrm369l5TK8ukjEaBgSkSYFfpXdbexiovT5hDaqVFeCRcniRQUU9umtvw7/7hWx
         BsoEH5oLSuYrpujfnCzhWMRPJhoU7f123YG6oActbOfs7KoLKH1AQWleoGy82gP3WlEA
         TUatCgIJS8QuiEXHgRIR238qLSYRQ/SFdxJNGC+CEyfVGyY5gSbVFyJMooNX7AnU99v0
         w4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987613; x=1684579613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yAzb4w95wvVcgK4ZPqFRB6yxn5Nne+39hIPjBrv118=;
        b=ezBzqpJYdvDig4GhSNkHBUmPz0C6jY9WZQlCS4Ggtfas6BNX/vws3YcX4zy4KBwWQW
         OtOB1dKz027NK6HvBIXJDTpuAz/7Wtc5j06TKLWwtDZv1n5+W4bq6Bbo7yNvmXQ0Spgf
         oshQCUwJB2Ya20GNQleIpSR4w26KGdO9WjEx5S3N485QcB3nI6KOg+0bJy0qj5BUgh1t
         FMAptzLPshhhJn2jVUpxTs1hq2yZxJBdKHve0HZGknhxziCjEWu9olaOfsUXlFFk4XtJ
         YuCfeEfViOyO5qtIbT8fC73r6+zuVIzdiC6oH/d4sQdrHGdUST+rA9LJMI2CGlWow/3t
         sxcg==
X-Gm-Message-State: AAQBX9eJ/RXVZyWBUHCrVArEtdSIqRDnqDI/nKjz9oW2A/wtOdMsidRj
        yty0CfSjj6UtI4TykrZViKs=
X-Google-Smtp-Source: AKy350bqAMWPDl52EnaNvLd4H6X1qnaaLvTseHnoGDVw+9AmZEUGC6HORZFIEbnL049P3giRB1qeEQ==
X-Received: by 2002:a17:903:32d2:b0:1a9:3b64:3761 with SMTP id i18-20020a17090332d200b001a93b643761mr120785plr.9.1681987613692;
        Thu, 20 Apr 2023 03:46:53 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:53 -0700 (PDT)
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
Subject: [PATCH v2 6/7] KVM: selftests: Check gp event filters without affecting fixed event filters
Date:   Thu, 20 Apr 2023 18:46:21 +0800
Message-Id: <20230420104622.12504-7-ljrcore@126.com>
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

Add a test to ensure that setting both generic and fixed performance
event filters does not affect the consistency of the fixed performance
filter behavior in KVM. This test helps to ensure that the fixed
performance filter works as expected even when generic performance
event filters are also set.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_event_filter_test.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 0f54c53d7fff..9be4c6f8fb7e 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -889,6 +889,7 @@ static void test_fixed_ctr_action_and_bitmap(struct kvm_vcpu *vcpu,
 	uint32_t bitmap;
 	uint64_t count;
 	bool expected;
+	struct kvm_pmu_event_filter *f;
 
 	/*
 	 * Check the fixed performance counter can count normally works when
@@ -902,6 +903,19 @@ static void test_fixed_ctr_action_and_bitmap(struct kvm_vcpu *vcpu,
 			expected = fixed_ctr_is_allowed(fixed_ctr_idx, actions[i], bitmap);
 			count = test_fixed_ctr_with_filter(vcpu, actions[i], bitmap);
 
+			TEST_ASSERT(expected == !!count,
+				    "Fixed event filter does not work as expected.");
+
+			/*
+			 * Check that setting both events[] and fixed_counter_bitmap
+			 * does not affect the consistency of the fixed ctrs' behaviour.
+			 *
+			 * Note, the fixed_counter_bitmap rule has high priority.
+			 */
+			f = event_filter(actions[i]);
+			f->fixed_counter_bitmap = bitmap;
+			count = test_with_filter(vcpu, f);
+
 			TEST_ASSERT(expected == !!count,
 				    "Fixed event filter does not work as expected.");
 		}
-- 
2.31.1

