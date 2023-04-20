Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522816E90D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjDTKsk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjDTKsH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:48:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D12D43;
        Thu, 20 Apr 2023 03:46:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1a66b9bd7dfso10431295ad.2;
        Thu, 20 Apr 2023 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987599; x=1684579599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LeXiyoAgzuIFL7O4vGG3hN/1It8pY+Tbdd0XVylW0Q=;
        b=LmNzJ9siwL8usxifCanL62JyPjnmWtKG4dW0lPBBQJ3ZwYOK4G5n7P7zhfcQw9kNvh
         SwSuDBJv4bevKYkE6BZmvkrnQdGONclypqrWnJCpFJLRNZYri2Xmtz096QbjY3HQU0yz
         vWD+Kr0WrtrMZPZ7N4dpMhuXFYrYJHS8PWGBdlh3BSpkr7rEkzi5RGGML2Iu/Bd0kGTF
         UTpzyNQbR8XSVBv/fQgolthyrVKrJp5J2bTtBfXxRk2eXkplo/bWzg20YeSx14wIyeNA
         zugDSPK4rFacvWiy8tDn91lWuwwf6tHS05xUT0Bud2pXO6pAFIhJYtg8aMgaRe8XIV5c
         1E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987599; x=1684579599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LeXiyoAgzuIFL7O4vGG3hN/1It8pY+Tbdd0XVylW0Q=;
        b=kkkWJ/wX49z0yMxJ784/Exk0olsgX3mgbzokqlKkrcsbUd0zE8sn28uJyx+nuN00cp
         TFV0nYVe3+A/zzz7R/mavm0hzRVnLtBd7aXhBmOKpWwdxmej+78/lSSYkOYgZ8RDfWh4
         VdZCk0yvmDB3g0dKLkinO0tB6hklZef/+ovnd8sm6H3QMP0SrIjY9G7c1tKYAAx6kIpE
         mn3OCTEkUE5qMhEg4kBxraGegexGu/UefDDaT4rl5yKRBTDRL6Ho0K2iCKZ4JxXEcUDc
         fVk9+qR+m4ttVmHjZA891NTPbAYDWTNeKFNLKdg4sfyIBuK4Ykn5GECSFmwkwwk0kqEH
         jNLQ==
X-Gm-Message-State: AAQBX9cnQJd35JF03NOpHydGJQ6VibkKktLYANd7HBlKZAgq1dwq6arU
        VZob6Do45nL/8HOGf+3hOpE=
X-Google-Smtp-Source: AKy350bfDDYx7+W3PqyjSMho6KIU83TDG5OJp7rRawSNqhkGCNgxKbjFaztXMUb0hr89VFOkv+dS8w==
X-Received: by 2002:a17:902:f544:b0:1a6:84be:a08f with SMTP id h4-20020a170902f54400b001a684bea08fmr1174663plf.64.1681987598666;
        Thu, 20 Apr 2023 03:46:38 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:38 -0700 (PDT)
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
Subject: [PATCH v2 2/7] KVM: selftests: Apply create_pmu_event_filter() to fixed ctrs
Date:   Thu, 20 Apr 2023 18:46:17 +0800
Message-Id: <20230420104622.12504-3-ljrcore@126.com>
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

Add fixed_counter_bitmap to the create_pmu_event_filter() to
support the use of the same creator to control the use of guest
fixed counters.

No functional change intended.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index c0521fc9e8f6..4e87eea6986b 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -192,19 +192,22 @@ static struct kvm_pmu_event_filter *alloc_pmu_event_filter(uint32_t nevents)
 	return f;
 }
 
-
 static struct kvm_pmu_event_filter *
 create_pmu_event_filter(const uint64_t event_list[], uint32_t nevents,
-			uint32_t action, uint32_t flags)
+			uint32_t action, uint32_t flags,
+			uint32_t fixed_counter_bitmap)
 {
 	struct kvm_pmu_event_filter *f;
 	int i;
 
 	f = alloc_pmu_event_filter(nevents);
 	f->action = action;
+	f->fixed_counter_bitmap = fixed_counter_bitmap;
 	f->flags = flags;
-	for (i = 0; i < nevents; i++)
-		f->events[i] = event_list[i];
+	if (f->nevents) {
+		for (i = 0; i < f->nevents; i++)
+			f->events[i] = event_list[i];
+	}
 
 	return f;
 }
@@ -213,7 +216,7 @@ static struct kvm_pmu_event_filter *event_filter(uint32_t action)
 {
 	return create_pmu_event_filter(event_list,
 				       ARRAY_SIZE(event_list),
-				       action, 0);
+				       action, 0, 0);
 }
 
 /*
@@ -260,7 +263,7 @@ static void test_amd_deny_list(struct kvm_vcpu *vcpu)
 	struct kvm_pmu_event_filter *f;
 	uint64_t count;
 
-	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0);
+	f = create_pmu_event_filter(&event, 1, KVM_PMU_EVENT_DENY, 0, 0);
 	count = test_with_filter(vcpu, f);
 
 	free(f);
@@ -544,7 +547,7 @@ static struct perf_counter run_masked_events_test(struct kvm_vcpu *vcpu,
 
 	f = create_pmu_event_filter(masked_events, nmasked_events,
 				    KVM_PMU_EVENT_ALLOW,
-				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+				    KVM_PMU_EVENT_FLAG_MASKED_EVENTS, 0);
 	r.raw = test_with_filter(vcpu, f);
 	free(f);
 
@@ -726,12 +729,14 @@ static void test_masked_events(struct kvm_vcpu *vcpu)
 }
 
 static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
-			   uint32_t nevents, uint32_t flags)
+			   uint32_t nevents, uint32_t flags, uint32_t action,
+			   uint32_t fixed_counter_bitmap)
 {
 	struct kvm_pmu_event_filter *f;
 	int r;
 
-	f = create_pmu_event_filter(events, nevents, KVM_PMU_EVENT_ALLOW, flags);
+	f = create_pmu_event_filter(events, nevents, action, flags,
+				    fixed_counter_bitmap);
 	r = __vm_ioctl(vcpu->vm, KVM_SET_PMU_EVENT_FILTER, f);
 	free(f);
 
@@ -747,14 +752,16 @@ static void test_filter_ioctl(struct kvm_vcpu *vcpu)
 	 * Unfortunately having invalid bits set in event data is expected to
 	 * pass when flags == 0 (bits other than eventsel+umask).
 	 */
-	r = run_filter_test(vcpu, &e, 1, 0);
+	r = run_filter_test(vcpu, &e, 1, 0, KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
 
-	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+			    KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r != 0, "Invalid PMU Event Filter is expected to fail");
 
 	e = KVM_PMU_ENCODE_MASKED_ENTRY(0xff, 0xff, 0xff, 0xf);
-	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS);
+	r = run_filter_test(vcpu, &e, 1, KVM_PMU_EVENT_FLAG_MASKED_EVENTS,
+			    KVM_PMU_EVENT_ALLOW, 0);
 	TEST_ASSERT(r == 0, "Valid PMU Event Filter is failing");
 }
 
-- 
2.31.1

