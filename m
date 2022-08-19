Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C7599211
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 02:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiHSA5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 20:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345710AbiHSA5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 20:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FBDDF652
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 17:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660870651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtiIgnIOWAAHwJQ2LveDQTHCn3qhSJFmqy9sxEsG1rc=;
        b=MYZzpYaGYZuDC3c3NpxjkJ81fPmvyocs94YkRfy4kjp+1bXmQ5ysFPQkfu9pYJtUGquXXe
        zoqP7tjZ4IUMQkKzoqiah6wDQI5sMzdiodL6x2MxZPbAZjq6c0aM1oFBggC8nEZrAJ7y6u
        ru7D+a8X4FiGKV09fwErMdK2T3n8js0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-hcWi1V5tPBipyahNrluaWA-1; Thu, 18 Aug 2022 20:57:26 -0400
X-MC-Unique: hcWi1V5tPBipyahNrluaWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCBDF801755;
        Fri, 19 Aug 2022 00:57:24 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C878FC15BB8;
        Fri, 19 Aug 2022 00:57:16 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, peterx@redhat.com,
        pbonzini@redhat.com, corbet@lwn.net, maz@kernel.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v1 5/5] KVM: selftests: Automate choosing dirty ring size in dirty_log_test
Date:   Fri, 19 Aug 2022 08:56:01 +0800
Message-Id: <20220819005601.198436-6-gshan@redhat.com>
In-Reply-To: <20220819005601.198436-1-gshan@redhat.com>
References: <20220819005601.198436-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the dirty ring case, we rely on VM_EXIT due to full dirty ring
state. On ARM64 system, there are 4096 host pages when the host
page size is 64KB. In this case, the vcpu never exits due to the
full dirty ring state. The vcpu corrupts same set of pages, but the
dirty page information isn't collected in the main thread. This
leads to infinite loop as the following log shows.

  # ./dirty_log_test -M dirty-ring -c 65536 -m 5
  Setting log mode to: 'dirty-ring'
  Test iterations: 32, interval: 10 (ms)
  Testing guest mode: PA-bits:40,  VA-bits:48,  4K pages
  guest physical test memory offset: 0xffbffe0000
  vcpu stops because vcpu is kicked out...
  Notifying vcpu to continue
  vcpu continues now.
  Iteration 1 collected 576 pages
  <No more output afterwards>

Fix the issue by automatically choosing the best dirty ring size,
to ensure VM_EXIT due to full dirty ring state. The option '-c'
provides a hint to it, instead of the value of it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 24 ++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 450e97d10de7..ad31b6e3fe6a 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -23,6 +23,9 @@
 #include "guest_modes.h"
 #include "processor.h"
 
+#define DIRTY_MEM_BITS 30 /* 1G */
+#define PAGE_SHIFT_4K  12
+
 /* The memory slot index to track dirty pages */
 #define TEST_MEM_SLOT_INDEX		1
 
@@ -298,6 +301,22 @@ static bool dirty_ring_supported(void)
 
 static void dirty_ring_create_vm_done(struct kvm_vm *vm)
 {
+	uint64_t pages;
+	uint32_t limit;
+
+	/*
+	 * We rely on VM_EXIT due to full dirty ring state. Adjust
+	 * the ring buffer size to ensure we're able to reach the
+	 * full dirty ring state.
+	 */
+	pages = (1ul << (DIRTY_MEM_BITS - vm->page_shift)) + 3;
+	pages = vm_adjust_num_guest_pages(vm->mode, pages);
+	pages = vm_num_host_pages(vm->mode, pages);
+
+	limit = 1 << (31 - __builtin_clz(pages));
+	test_dirty_ring_count = 1 << (31 - __builtin_clz(test_dirty_ring_count));
+	test_dirty_ring_count = min(limit, test_dirty_ring_count);
+
 	/*
 	 * Switch to dirty ring mode after VM creation but before any
 	 * of the vcpu creation.
@@ -710,9 +729,6 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, struct kvm_vcpu **vcpu,
 	return vm;
 }
 
-#define DIRTY_MEM_BITS 30 /* 1G */
-#define PAGE_SHIFT_4K  12
-
 struct test_params {
 	unsigned long iterations;
 	unsigned long interval;
@@ -856,7 +872,7 @@ static void help(char *name)
 	printf("usage: %s [-h] [-i iterations] [-I interval] "
 	       "[-p offset] [-m mode]\n", name);
 	puts("");
-	printf(" -c: specify dirty ring size, in number of entries\n");
+	printf(" -c: hint to dirty ring size, in number of entries\n");
 	printf("     (only useful for dirty-ring test; default: %"PRIu32")\n",
 	       TEST_DIRTY_RING_COUNT);
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
-- 
2.23.0

