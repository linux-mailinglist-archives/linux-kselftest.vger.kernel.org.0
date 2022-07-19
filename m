Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47D578EB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiGSAJR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 20:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiGSAJL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 20:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ECB21FA
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658189349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NEVx0pB2HnnThMov1umNo2N7MZ+/Y6MEAU+qrFJg/CQ=;
        b=X6VBX/3+3GzP8iqzHyJidvwtPSPc7HVwoK0kl5zR9lXdbEgo3FNwZ2W+1ydT7gLzCs1nb7
        JibTfDqiFoHVCcmIpn6amBoSXbQwqhtAXsigZ0INpJXBpHPG0GvDnG97G4Sm/bXr8jCGsm
        Dvsj4hxwYLLZO3FHmJOybIv5wK40WAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-GID_6yVGPdS7z3RsC3m02w-1; Mon, 18 Jul 2022 20:08:59 -0400
X-MC-Unique: GID_6yVGPdS7z3RsC3m02w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A989811E7A;
        Tue, 19 Jul 2022 00:08:59 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0E111121314;
        Tue, 19 Jul 2022 00:08:55 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        oliver.upton@linux.dev, seanjc@google.com, shuah@kernel.org,
        maz@kernel.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v4] KVM: selftests: Fix target thread to be migrated in rseq_test
Date:   Tue, 19 Jul 2022 10:08:30 +0800
Message-Id: <20220719020830.3479482-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
v4: Pick the code change as Sean suggested.
---
 tools/testing/selftests/kvm/rseq_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 4158da0da2bb..2237d1aac801 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -82,8 +82,9 @@ static int next_cpu(int cpu)
 	return cpu;
 }
 
-static void *migration_worker(void *ign)
+static void *migration_worker(void *__rseq_tid)
 {
+	pid_t rseq_tid = (pid_t)(unsigned long)__rseq_tid;
 	cpu_set_t allowed_mask;
 	int r, i, cpu;
 
@@ -106,7 +107,7 @@ static void *migration_worker(void *ign)
 		 * stable, i.e. while changing affinity is in-progress.
 		 */
 		smp_wmb();
-		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
+		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask), &allowed_mask);
 		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
 			    errno, strerror(errno));
 		smp_wmb();
@@ -231,7 +232,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 	ucall_init(vm, NULL);
 
-	pthread_create(&migration_thread, NULL, migration_worker, 0);
+	pthread_create(&migration_thread, NULL, migration_worker,
+		       (void *)(unsigned long)gettid());
 
 	for (i = 0; !done; i++) {
 		vcpu_run(vm, VCPU_ID);
-- 
2.23.0

