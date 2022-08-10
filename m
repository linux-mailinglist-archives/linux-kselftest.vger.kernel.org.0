Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6596758EA99
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 12:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiHJKmZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 06:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiHJKmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 06:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CA496C774
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660128127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdNPgMQAyUx4falAdQJ3yohJSAww4fRub8jAW+HiU3Y=;
        b=LaAAzuPYkf2ZADrDXMNBPVjRYC5Ln24KfBkadxc4MkfGrmHMxZEmKD/ZlcUQpIPMtNdO/O
        B/5pcTmlYLWNEJMGtpoflQLfYiJu9T0jPMkkI37lBf+7V/q7WXe8229vEQR1mDOqB76GMk
        OEF++gMit+1WTMcMSLzqvFVGAF+mM1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638--LdPjS-RNeKxeCRUylwCPQ-1; Wed, 10 Aug 2022 06:42:03 -0400
X-MC-Unique: -LdPjS-RNeKxeCRUylwCPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C894910115F1;
        Wed, 10 Aug 2022 10:42:02 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FEEF4050067;
        Wed, 10 Aug 2022 10:41:57 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, fweimer@redhat.com,
        shan.gavin@gmail.com, maz@kernel.org, andrew.jones@linux.dev,
        mathieu.desnoyers@efficios.com, pbonzini@redhat.com,
        yihyu@redhat.com, seanjc@google.com, oliver.upton@linux.dev
Subject: [PATCH v2 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
Date:   Wed, 10 Aug 2022 18:41:13 +0800
Message-Id: <20220810104114.6838-2-gshan@redhat.com>
In-Reply-To: <20220810104114.6838-1-gshan@redhat.com>
References: <20220810104114.6838-1-gshan@redhat.com>
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

The rseq information is registered by TLS, starting from glibc-2.35.
In this case, the test always fails due to syscall(__NR_rseq). For
example, on RHEL9.1 where upstream glibc-2.35 features are enabled
on downstream glibc-2.34, the test fails like below.

  # ./rseq_test
  ==== Test Assertion Failure ====
    rseq_test.c:60: !r
    pid=112043 tid=112043 errno=22 - Invalid argument
       1        0x0000000000401973: main at rseq_test.c:226
       2        0x0000ffff84b6c79b: ?? ??:0
       3        0x0000ffff84b6c86b: ?? ??:0
       4        0x0000000000401b6f: _start at ??:?
    rseq failed, errno = 22 (Invalid argument)
  # rpm -aq | grep glibc-2
  glibc-2.34-39.el9.aarch64

Fix the issue by using "../rseq/rseq.c" to fetch the rseq information,
registred by TLS if it exists. Otherwise, we're going to register our
own rseq information as before.

Reported-by: Yihuang Yu <yihyu@redhat.com>
Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/Makefile    |  5 +++--
 tools/testing/selftests/kvm/rseq_test.c | 28 +++++++------------------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c7f47429d6cd..89c9a8c52c5f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -197,7 +197,8 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \
+	$(KHDR_INCLUDES)
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
@@ -206,7 +207,7 @@ no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
 pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
 
-
+LDLIBS += -ldl
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
 # After inclusion, $(OUTPUT) is defined and
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index a54d4d05a058..2cd5fe49ac8b 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -20,15 +20,7 @@
 #include "processor.h"
 #include "test_util.h"
 
-static __thread volatile struct rseq __rseq = {
-	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
-};
-
-/*
- * Use an arbitrary, bogus signature for configuring rseq, this test does not
- * actually enter an rseq critical section.
- */
-#define RSEQ_SIG 0xdeadbeef
+#include "../rseq/rseq.c"
 
 /*
  * Any bug related to task migration is likely to be timing-dependent; perform
@@ -37,6 +29,7 @@ static __thread volatile struct rseq __rseq = {
 #define NR_TASK_MIGRATIONS 100000
 
 static pthread_t migration_thread;
+static struct rseq_abi *__rseq;
 static cpu_set_t possible_mask;
 static int min_cpu, max_cpu;
 static bool done;
@@ -49,14 +42,6 @@ static void guest_code(void)
 		GUEST_SYNC(0);
 }
 
-static void sys_rseq(int flags)
-{
-	int r;
-
-	r = syscall(__NR_rseq, &__rseq, sizeof(__rseq), flags, RSEQ_SIG);
-	TEST_ASSERT(!r, "rseq failed, errno = %d (%s)", errno, strerror(errno));
-}
-
 static int next_cpu(int cpu)
 {
 	/*
@@ -218,7 +203,10 @@ int main(int argc, char *argv[])
 
 	calc_min_max_cpu();
 
-	sys_rseq(0);
+	r = rseq_register_current_thread();
+	TEST_ASSERT(!r, "rseq_register_current_thread failed, errno = %d (%s)",
+		    errno, strerror(errno));
+	__rseq = rseq_get_abi();
 
 	/*
 	 * Create and run a dummy VM that immediately exits to userspace via
@@ -256,7 +244,7 @@ int main(int argc, char *argv[])
 			 */
 			smp_rmb();
 			cpu = sched_getcpu();
-			rseq_cpu = READ_ONCE(__rseq.cpu_id);
+			rseq_cpu = READ_ONCE(__rseq->cpu_id);
 			smp_rmb();
 		} while (snapshot != atomic_read(&seq_cnt));
 
@@ -278,7 +266,7 @@ int main(int argc, char *argv[])
 
 	kvm_vm_free(vm);
 
-	sys_rseq(RSEQ_FLAG_UNREGISTER);
+	rseq_unregister_current_thread();
 
 	return 0;
 }
-- 
2.23.0

