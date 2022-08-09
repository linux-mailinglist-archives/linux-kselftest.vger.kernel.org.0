Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAA58D29D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 06:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiHIEGg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiHIEG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 00:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6D719024
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 21:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660017984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpMqE31lls01IVsW/AFKiHmLzH6RkUJAa9i/teIiT1c=;
        b=dzw0HZFZmctcDcatOVZJxt20X0NSWR/MSgfMfN2vM/PtdxjymV9XDJmKH2G+6NWfhQs/Po
        YzvG6EZ172IKEjkA1evdpW5cF39lPVUrawxFglR1rUfkxDEfkoaf2wCQOv6NqW6Y8odc64
        HvcpfTu3IHPo63LYlffJuKuKvlUQqCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-ahVzwH5mPJ6nYZb0VLyzfg-1; Tue, 09 Aug 2022 00:06:21 -0400
X-MC-Unique: ahVzwH5mPJ6nYZb0VLyzfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF4D8804191;
        Tue,  9 Aug 2022 04:06:20 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-20.bne.redhat.com [10.64.54.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26FE72166B26;
        Tue,  9 Aug 2022 04:06:15 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, maz@kernel.org,
        oliver.upton@linux.dev, andrew.jones@linux.dev, seanjc@google.com,
        mathieu.desnoyers@efficios.com, fweimer@redhat.com,
        yihyu@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 2/2] KVM: selftests: Use getcpu() instead of sched_getcpu() in rseq_test
Date:   Tue,  9 Aug 2022 14:06:27 +0800
Message-Id: <20220809060627.115847-3-gshan@redhat.com>
In-Reply-To: <20220809060627.115847-1-gshan@redhat.com>
References: <20220809060627.115847-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sched_getcpu() is glibc dependent and it can simply return the CPU
ID from the registered rseq information, as Florian Weimer pointed.
In this case, it's pointless to compare the return value from
sched_getcpu() and that fetched from the registered rseq information.

Fix the issue by replacing sched_getcpu() with getcpu(), as Florian
suggested. The comments are modified accordingly.

Reported-by: Yihuang Yu <yihyu@redhat.com>
Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 32 ++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index acb1bf1f06b3..621b9b15049b 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -126,7 +126,7 @@ static void *migration_worker(void *__rseq_tid)
 		atomic_inc(&seq_cnt);
 
 		/*
-		 * Ensure the odd count is visible while sched_getcpu() isn't
+		 * Ensure the odd count is visible while getcpu() isn't
 		 * stable, i.e. while changing affinity is in-progress.
 		 */
 		smp_wmb();
@@ -167,10 +167,10 @@ static void *migration_worker(void *__rseq_tid)
 		 *     check completes.
 		 *
 		 *  3. To ensure the read-side makes efficient forward progress,
-		 *     e.g. if sched_getcpu() involves a syscall.  Stalling the
-		 *     read-side means the test will spend more time waiting for
-		 *     sched_getcpu() to stabilize and less time trying to hit
-		 *     the timing-dependent bug.
+		 *     e.g. if getcpu() involves a syscall. Stalling the read-side
+		 *     means the test will spend more time waiting for getcpu()
+		 *     to stabilize and less time trying to hit the timing-dependent
+		 *     bug.
 		 *
 		 * Because any bug in this area is likely to be timing-dependent,
 		 * run with a range of delays at 1us intervals from 1us to 10us
@@ -264,9 +264,9 @@ int main(int argc, char *argv[])
 
 		/*
 		 * Verify rseq's CPU matches sched's CPU.  Ensure migration
-		 * doesn't occur between sched_getcpu() and reading the rseq
-		 * cpu_id by rereading both if the sequence count changes, or
-		 * if the count is odd (migration in-progress).
+		 * doesn't occur between getcpu() and reading the rseq cpu_id
+		 * by rereading both if the sequence count changes, or if the
+		 * count is odd (migration in-progress).
 		 */
 		do {
 			/*
@@ -276,15 +276,15 @@ int main(int argc, char *argv[])
 			snapshot = atomic_read(&seq_cnt) & ~1;
 
 			/*
-			 * Ensure reading sched_getcpu() and rseq.cpu_id
-			 * complete in a single "no migration" window, i.e. are
-			 * not reordered across the seq_cnt reads.
+			 * Ensure reading getcpu() and rseq.cpu_id complete in
+			 * a single "no migration" window, i.e. are not reordered
+			 * across the seq_cnt reads.
 			 */
 			smp_rmb();
-			cpu = sched_getcpu();
+			r = getcpu(&cpu, NULL);
 			rseq_cpu = READ_ONCE(__rseq_info->cpu_id);
 			smp_rmb();
-		} while (snapshot != atomic_read(&seq_cnt));
+		} while (r || snapshot != atomic_read(&seq_cnt));
 
 		TEST_ASSERT(rseq_cpu == cpu,
 			    "rseq CPU = %d, sched CPU = %d\n", rseq_cpu, cpu);
@@ -293,9 +293,9 @@ int main(int argc, char *argv[])
 	/*
 	 * Sanity check that the test was able to enter the guest a reasonable
 	 * number of times, e.g. didn't get stalled too often/long waiting for
-	 * sched_getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a
-	 * fairly conservative ratio on x86-64, which can do _more_ KVM_RUNs
-	 * than migrations given the 1us+ delay in the migration task.
+	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
+	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
+	 * migrations given the 1us+ delay in the migration task.
 	 */
 	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
 		    "Only performed %d KVM_RUNs, task stalled too much?\n", i);
-- 
2.23.0

