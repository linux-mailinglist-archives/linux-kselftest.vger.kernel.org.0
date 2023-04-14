Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE596E218C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDNLCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjDNLBy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE5AD12;
        Fri, 14 Apr 2023 04:01:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m18so17885186plx.5;
        Fri, 14 Apr 2023 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470088; x=1684062088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK9pwOgB2nPITqmSfwvLaMyb+zQIu3ReFYaoFX7ikX4=;
        b=PljFlbRIrwC3l66d28sWfITf4lXIEcrg1199QsL6Xk8ADfdMZnqIiOKwFCpcjEvkvg
         DgtYI0mGZqCc2Ijsn2/1l3eWUFmD37wK1Ts/fhqWfWgtXHmReAsT7pzBsBBL9sDdPEVe
         tTWNjc9/aG6BUsBFqFpBzuJ5HPhW30Vq0BsArrL4kAgRIN1wHnOVYhLcWT0wj4wwfGwf
         M9ee1OIE5JtBhzizP7j/pSxzhxogCRGkvM0WGJP3DUY+/UanhWPp1TeQN1ndPxkPj9R5
         wmX/mTTkWcNbzcMuxt3FfqtPq9gaTBgeNlRNQhqMKGhDpBTF4/2tSBGR4uZsARWgJqcN
         MzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470088; x=1684062088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK9pwOgB2nPITqmSfwvLaMyb+zQIu3ReFYaoFX7ikX4=;
        b=mDGgmOoDUGV2rxphMn7tus7iC+xt/7J75zApZXT0ttKfnsXh/noVzF4SuT/+46Zy1g
         0eyEAFlsBq2iJK5oDpvcgsdlQq/I3kNLx7hh1GPwbcbM+EKrjA9VOM2svv9EsbtO+sX5
         GE+8PbthBN/wpwlLdrZRX7fbp5kUgZZDxVHYEA1sKGDWWGQ5djGGIwwCtb06v2YOhUPk
         7DrgJjUVRCtxc5HlQq4DeOOBqHntBsaeKw4IjnfbBsF3OYDnbnsN/A0S6r/RJ++OJE3c
         az7bQ9gn/URcNUeQn1b1AGhvKX8QVtE8u+UVNgoTFfRM1rObsP4hqK7tJN3OPsFxWuBG
         O/YA==
X-Gm-Message-State: AAQBX9eWzP5yUPCQ9Z9wdGBfHU9FjbYKV5UxPrwhlWsaXx+XiZH8SPA2
        O0scb1RJpLdjKuV3XFZwpqE=
X-Google-Smtp-Source: AKy350asCprAU6527zyhHcwBBYydceA7UYQzsFvjOl46nDBEehhSUpZTUIYnQBkOtkB5u2KbeJ18DQ==
X-Received: by 2002:a17:902:e552:b0:1a6:6f09:6736 with SMTP id n18-20020a170902e55200b001a66f096736mr2768923plf.20.1681470088177;
        Fri, 14 Apr 2023 04:01:28 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:27 -0700 (PDT)
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
Subject: [PATCH 6/7] KVM: selftests: Check gp event filters without affecting fixed event filters
Date:   Fri, 14 Apr 2023 19:00:55 +0800
Message-Id: <20230414110056.19665-7-cloudliang@tencent.com>
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

