Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950A5744D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 08:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiGNGHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 02:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGNGHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 02:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86652F641
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657778833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Iv/of2lWJhY6Wq6eUx2wF1MOm6COuhI4THcs0fOz4c=;
        b=SLOmKZ/D3dNyVJtXl80Aci7SbhuuHQnWtquf6/YZerSZuzh9LBWrj11fwdfaRMUaiOWxuD
        8qrQaYc5VnQPtTcp0jNFTv4U2HjeZzuPKz4Gs2HniNUZM85MIYVj8slnxv88VTHO77wDHz
        Y5oTjR78EYMiHl4b3xJ2TTM2A3HiGqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-xg7vNdqMMFWLrvckPTivMg-1; Thu, 14 Jul 2022 02:07:10 -0400
X-MC-Unique: xg7vNdqMMFWLrvckPTivMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B956E802D1C;
        Thu, 14 Jul 2022 06:07:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6237140E80E0;
        Thu, 14 Jul 2022 06:07:05 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        mathieu.desnoyers@efficios.com, shuah@kernel.org, maz@kernel.org,
        oliver.upton@linux.dev, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH] KVM: selftests: Double check on the current CPU in rseq_test
Date:   Thu, 14 Jul 2022 16:06:42 +0800
Message-Id: <20220714080642.3376618-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In rseq_test, there are two threads created. Those two threads are
'main' and 'migration_thread' separately. We also have the assumption
that non-migration status on 'migration-worker' thread guarantees the
same non-migration status on 'main' thread. Unfortunately, the assumption
isn't true. The 'main' thread can be migrated from one CPU to another
one between the calls to sched_getcpu() and READ_ONCE(__rseq.cpu_id).
The following assert is raised eventually because of the mismatched
CPU numbers.

The issue can be reproduced on arm64 system occasionally.

  host# uname -r
  5.19.0-rc6-gavin+
  host# # cat /proc/cpuinfo | grep processor | tail -n 1
  processor    : 223
  host# pwd
  /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
  host# for i in `seq 1 100`;   \
        do echo "--------> $i"; \
        ./rseq_test; sleep 3;   \
        done
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

This fixes the issue by double-checking on the current CPU after
call to READ_ONCE(__rseq.cpu_id) and restarting the test if the
two consecutive CPU numbers aren't euqal.

Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 4158da0da2bb..74709dd9f5b2 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -207,7 +207,7 @@ int main(int argc, char *argv[])
 {
 	int r, i, snapshot;
 	struct kvm_vm *vm;
-	u32 cpu, rseq_cpu;
+	u32 cpu, rseq_cpu, last_cpu;
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
@@ -259,8 +259,9 @@ int main(int argc, char *argv[])
 			smp_rmb();
 			cpu = sched_getcpu();
 			rseq_cpu = READ_ONCE(__rseq.cpu_id);
+			last_cpu = sched_getcpu();
 			smp_rmb();
-		} while (snapshot != atomic_read(&seq_cnt));
+		} while (snapshot != atomic_read(&seq_cnt) || cpu != last_cpu);
 
 		TEST_ASSERT(rseq_cpu == cpu,
 			    "rseq CPU = %d, sched CPU = %d\n", rseq_cpu, cpu);
-- 
2.23.0

