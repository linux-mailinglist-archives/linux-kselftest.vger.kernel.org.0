Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06E578E51
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 01:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiGRXgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGRXgn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 19:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56BF9286D1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658187401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ySr8hj/EGMal5qilyWO6bDnZTTU7RUMAMj596WRLWVE=;
        b=IVrqWuBUFHaAMABxAzRyWePh3M3Bo4a2sPx+7A9G+Hvl46ubB3CSiITYdgHCZzU2JAazDF
        8hv7NHL0Au72vgisnT2NOUhEgyoP2w6zJPtFgXZ/AgrZGTXscXh6OI3ZfnZMxEyUpXtVGu
        AdWBgIow1Ay+6dgzmw+weyBW6fQir5Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-1Y1_456WPV-DPT80BDCaTA-1; Mon, 18 Jul 2022 19:36:35 -0400
X-MC-Unique: 1Y1_456WPV-DPT80BDCaTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15CB0801585;
        Mon, 18 Jul 2022 23:36:35 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C08718EB7;
        Mon, 18 Jul 2022 23:36:31 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        oliver.upton@linux.dev, seanjc@google.com, shuah@kernel.org,
        maz@kernel.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3] KVM: selftests: Fix target thread to be migrated in rseq_test
Date:   Tue, 19 Jul 2022 09:35:40 +0800
Message-Id: <20220719013540.3477946-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In rseq_test, there are two threads, which are vCPU thread and migration
worker separately. Unfortunately, the test has the wrong PID passed to
sched_setaffinity() in the migration worker. It forces migration on the
migration worker because zeroed PID represents the calling thread, which
is the migration worker itself. It means the vCPU thread is never enforced
to migration and it can migrate at any time, which eventually leads to
failure as the following logs show.

  host# uname -r
  5.19.0-rc6-gavin+
  host# # cat /proc/cpuinfo | grep processor | tail -n 1
  processor    : 223
  host# pwd
  /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
  host# for i in `seq 1 100`; do \
        echo "--------> $i"; ./rseq_test; done
  --------> 1
  --------> 2
  --------> 3
  --------> 4
  --------> 5
  --------> 6
  ==== Test Assertion Failure ====
    rseq_test.c:265: rseq_cpu == cpu
    pid=3925 tid=3925 errno=4 - Interrupted system call
       1  0x0000000000401963: main at rseq_test.c:265 (discriminator 2)
       2  0x0000ffffb044affb: ?? ??:0
       3  0x0000ffffb044b0c7: ?? ??:0
       4  0x0000000000401a6f: _start at ??:?
    rseq CPU = 4, sched CPU = 27

Fix the issue by passing correct parameter, TID of the vCPU thread, to
sched_setaffinity() in the migration worker.

Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
v3: Improved changelog (Oliver Upon)
---
 tools/testing/selftests/kvm/rseq_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 4158da0da2bb..c83ac7b467f8 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -38,6 +38,7 @@ static __thread volatile struct rseq __rseq = {
  */
 #define NR_TASK_MIGRATIONS 100000
 
+static pid_t rseq_tid;
 static pthread_t migration_thread;
 static cpu_set_t possible_mask;
 static int min_cpu, max_cpu;
@@ -106,7 +107,8 @@ static void *migration_worker(void *ign)
 		 * stable, i.e. while changing affinity is in-progress.
 		 */
 		smp_wmb();
-		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
+		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask),
+				      &allowed_mask);
 		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
 			    errno, strerror(errno));
 		smp_wmb();
@@ -231,6 +233,7 @@ int main(int argc, char *argv[])
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 	ucall_init(vm, NULL);
 
+	rseq_tid = gettid();
 	pthread_create(&migration_thread, NULL, migration_worker, 0);
 
 	for (i = 0; !done; i++) {
-- 
2.23.0

