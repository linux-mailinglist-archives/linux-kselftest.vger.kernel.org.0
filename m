Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8857F2F3DC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhALVph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393245AbhALVoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 16:44:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C57C061383
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j1so111143ybj.11
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=16jbzAetGxf2Iv1g2IYZbvaGAz4mTMe0xFaX8UvhNy8=;
        b=tmIvX70kf0AHC4077r/GFIgFMtTnN+ZuZyI7xh65Jyok9zaS1lSl7Zz+YbJ+acDWye
         /OqgiaUfGzobMJF/iSMhTiI0k29jAxIgpMDYotVyW1YVr7z+4oyKqYsCBStXQ9Iu0F+q
         sBJlMXozAWqF42QCdpv4Pmmesi1Xq+/hy5jP0dkMqBOP0NlXlNeM+iM9u0hrXF4lYTJD
         2W6Ptq/dtbm6qOmgYqkoViv6pQ5E/chYSZcJ8mCj6CmcDybFQ4Ed86p/9xkmHqXFFGk5
         aH8kbii/6/elVIL73n5Wxg/efKxRNhH8PMw9/GrPaCBdzcZnfmxfSClzqmviDOS5gEQD
         B1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=16jbzAetGxf2Iv1g2IYZbvaGAz4mTMe0xFaX8UvhNy8=;
        b=WrxG+0lYOC+sSPWJ1b2BIJ4B2xe20U/YuB5KgupNXMO7egYVtOrGJVn8ywMqPWcjIi
         TdqbFcCBq6wDjLSlEpMGV2yZGwGaexSGlyeS+jsDewQw2NR4vQq1hmBZ+HsXVPPeUZ62
         iGgV0kwOiQoDyBRufHSOw/S2mxAvH/wqgAg/20/edlYiWN/V4lco02LJ8Ac7QkGbg6C8
         2GFfEllX16+psZZoxFLs6oD7nweMHdCLlEbANW9klnbM22+oCmgFChgLINba8sr/R1kt
         RHbiB5eH6Ooj4/qvktrWIX84A0o0EpuwsIHFlVI1O3s2gg2/w4ozWuiAKywvGZcxLY6o
         uBLA==
X-Gm-Message-State: AOAM531YqCH4181BQTNWeadGzw+v2N/qiZQ88k7DWNvTGEcxCEegFvOH
        UEGknCYK8SofagFTjJOEhPvFxWeeB5jy
X-Google-Smtp-Source: ABdhPJxTjoIqSDq8yGZNncNeEfmIVI0e54UPHQjHvk8yhSLAZXhHCFW85AWEH4wSxU3IYMR8Yk3pRl1zS/D9
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a25:cb42:: with SMTP id
 b63mr2317704ybg.521.1610487784576; Tue, 12 Jan 2021 13:43:04 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:42:51 -0800
In-Reply-To: <20210112214253.463999-1-bgardon@google.com>
Message-Id: <20210112214253.463999-5-bgardon@google.com>
Mime-Version: 1.0
References: <20210112214253.463999-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 4/6] KVM: selftests: Fix population stage in dirty_log_perf_test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the population stage in the dirty_log_perf_test does nothing
as the per-vCPU iteration counters are not initialized and the loop does
not wait for each vCPU. Remedy those errors.

Reviewed-by: Jacob Xu <jacobhxu@google.com>
Reviewed-by: Makarand Sonare <makarandsonare@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/dirty_log_perf_test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 3875f22d7283..fb6eb7fa0b45 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -139,14 +139,19 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		vcpu_last_completed_iteration[vcpu_id] = -1;
+
 		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
 			       &perf_test_args.vcpu_args[vcpu_id]);
 	}
 
-	/* Allow the vCPU to populate memory */
+	/* Allow the vCPUs to populate memory */
 	pr_debug("Starting iteration %d - Populating\n", iteration);
-	while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
-		;
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) !=
+		       iteration)
+			;
+	}
 
 	ts_diff = timespec_elapsed(start);
 	pr_info("Populate memory time: %ld.%.9lds\n",
-- 
2.30.0.284.gd98b1dd5eaa7-goog

