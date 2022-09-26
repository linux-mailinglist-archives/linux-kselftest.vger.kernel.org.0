Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D725E9C0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Sep 2022 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiIZI3f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbiIZI3d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 04:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91220A
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Sep 2022 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664180969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EXYzHGpVQuZ+lzxqJDL7MpKtdjQKwaei6cZnl1/10a8=;
        b=TbaabwqcKd8Vafw7vBhnlbKfWACA25U9ZAZT3AlFGO0D3mFAJ3oAmCgbCHxxNvw5WF2pWq
        JzAoA5k3ozlIRX1zFcV2n3vrHt/OsBysxz6BrH6ACZ0ASJ22Pg3PJ1CcwSA2uTACEgjuEg
        j7ox8NOB9iPSMO4EvB/ZObinXA/22es=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-gm6xPzUANT-7y0s7eTr-uQ-1; Mon, 26 Sep 2022 04:29:26 -0400
X-MC-Unique: gm6xPzUANT-7y0s7eTr-uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2ABE381A729;
        Mon, 26 Sep 2022 08:29:25 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE54E1121314;
        Mon, 26 Sep 2022 08:29:25 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH] KVM: selftests: replace assertion with warning in access_tracking_perf_test
Date:   Mon, 26 Sep 2022 04:29:23 -0400
Message-Id: <20220926082923.299554-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Page_idle uses {ptep/pmdp}_clear_young_notify which in turn calls
the mmu notifier callback ->clear_young(), which purposefully
does not flush the TLB.

When running the test in a nested guest, point 1. of the test
doc header is violated, because KVM TLB is unbounded by size
and since no flush is forced, KVM does not update the sptes
accessed/idle bits resulting in guest assertion failure.

More precisely, only the first ACCESS_WRITE in run_test() actually
makes visible changes, because sptes are created and the accessed
bit is set to 1 (or idle bit is 0). Then the first mark_memory_idle()
passes since access bit is still one, and sets all pages as idle
(or not accessed). When the next write is performed, the update
is not flushed therefore idle is still 1 and next mark_memory_idle()
fails.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 .../selftests/kvm/access_tracking_perf_test.c | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 1c2749b1481a..87b0bd5ebc65 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -31,8 +31,9 @@
  * These limitations are worked around in this test by using a large enough
  * region of memory for each vCPU such that the number of translations cached in
  * the TLB and the number of pages held in pagevecs are a small fraction of the
- * overall workload. And if either of those conditions are not true this test
- * will fail rather than silently passing.
+ * overall workload. And if either of those conditions are not true (for example
+ * in nesting, where TLB size is unlimited) this test will print a warning
+ * rather than silently passing.
  */
 #include <inttypes.h>
 #include <limits.h>
@@ -172,17 +173,23 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
 		    vcpu_idx, no_pfn, pages);
 
 	/*
-	 * Test that at least 90% of memory has been marked idle (the rest might
-	 * not be marked idle because the pages have not yet made it to an LRU
-	 * list or the translations are still cached in the TLB). 90% is
+	 * Check that at least 90% of memory has been marked idle (the rest
+	 * might not be marked idle because the pages have not yet made it to an
+	 * LRU list or the translations are still cached in the TLB). 90% is
 	 * arbitrary; high enough that we ensure most memory access went through
 	 * access tracking but low enough as to not make the test too brittle
 	 * over time and across architectures.
+	 *
+	 * Note that when run in nested virtualization, this check will trigger
+	 * much more frequently because TLB size is unlimited and since no flush
+	 * happens, much more pages are cached there and guest won't see the
+	 * "idle" bit cleared.
 	 */
-	TEST_ASSERT(still_idle < pages / 10,
-		    "vCPU%d: Too many pages still idle (%"PRIu64 " out of %"
-		    PRIu64 ").\n",
-		    vcpu_idx, still_idle, pages);
+	if (still_idle < pages / 10)
+		printf("WARNING: vCPU%d: Too many pages still idle (%"PRIu64 "
+		       out of %" PRIu64 "), this will affect performance results
+		       .\n",
+		       vcpu_idx, still_idle, pages);
 
 	close(page_idle_fd);
 	close(pagemap_fd);
-- 
2.31.1

