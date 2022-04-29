Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D6514287
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354671AbiD2Gld (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 02:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354637AbiD2GlY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 02:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011EAB8982
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 23:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651214286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqGWw/ivhKelEL7FQU6pGgIvs7rLjxXrY22Ao4PTmdI=;
        b=G8v6bS7pI86TMyeDA8qxgeeN+DAYkiCTNtqPm21n4+t66QQ04TyLb5u3YrlrBmmAKNcStL
        qVZpX+8tHF4tRidW7A4Xn47ke/r6ztXHBTD9cYlPy5GPYjORrYZhdgUpccz8amYuANDG1I
        slkDo0e450q8rUhpye9g78zR37a6GLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-TuQ3Bu46PY-FIXLQbGLQOQ-1; Fri, 29 Apr 2022 02:38:00 -0400
X-MC-Unique: TuQ3Bu46PY-FIXLQbGLQOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A52AB101AA45;
        Fri, 29 Apr 2022 06:37:59 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3850614A5066;
        Fri, 29 Apr 2022 06:37:57 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 3/4] KVM: s390: selftests: Use TAP interface in the tprot test
Date:   Fri, 29 Apr 2022 08:37:23 +0200
Message-Id: <20220429063724.480919-4-thuth@redhat.com>
In-Reply-To: <20220429063724.480919-1-thuth@redhat.com>
References: <20220429063724.480919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The tprot test currently does not have any output (unless one of
the TEST_ASSERT statement fails), so it's hard to say for a user
whether a certain new sub-test has been included in the binary or
not. Let's make this a little bit more user-friendly and include
some TAP output via the kselftests.h interface.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/tprot.c | 29 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index c097b9db495e..14d74a9e7b3d 100644
--- a/tools/testing/selftests/kvm/s390x/tprot.c
+++ b/tools/testing/selftests/kvm/s390x/tprot.c
@@ -8,6 +8,7 @@
 #include <sys/mman.h>
 #include "test_util.h"
 #include "kvm_util.h"
+#include "kselftest.h"
 
 #define PAGE_SHIFT 12
 #define PAGE_SIZE (1 << PAGE_SHIFT)
@@ -63,12 +64,12 @@ static enum permission test_protection(void *addr, uint8_t key)
 }
 
 enum stage {
-	STAGE_END,
 	STAGE_INIT_SIMPLE,
 	TEST_SIMPLE,
 	STAGE_INIT_FETCH_PROT_OVERRIDE,
 	TEST_FETCH_PROT_OVERRIDE,
 	TEST_STORAGE_PROT_OVERRIDE,
+	STAGE_END	/* must be the last entry (it's the amount of tests) */
 };
 
 struct test {
@@ -182,7 +183,7 @@ static void guest_code(void)
 	GUEST_SYNC(perform_next_stage(&i, mapped_0));
 }
 
-#define HOST_SYNC(vmp, stage)							\
+#define HOST_SYNC_NO_TAP(vmp, stage)						\
 ({										\
 	struct kvm_vm *__vm = (vmp);						\
 	struct ucall uc;							\
@@ -198,12 +199,21 @@ static void guest_code(void)
 	ASSERT_EQ(uc.args[1], __stage);						\
 })
 
+#define HOST_SYNC(vmp, stage)			\
+({						\
+	HOST_SYNC_NO_TAP(vmp, stage);		\
+	ksft_test_result_pass("" #stage "\n");	\
+})
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
 	struct kvm_run *run;
 	vm_vaddr_t guest_0_page;
 
+	ksft_print_header();
+	ksft_set_plan(STAGE_END);
+
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 	run = vcpu_state(vm, VCPU_ID);
 
@@ -212,9 +222,14 @@ int main(int argc, char *argv[])
 	HOST_SYNC(vm, TEST_SIMPLE);
 
 	guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
-	if (guest_0_page != 0)
-		print_skip("Did not allocate page at 0 for fetch protection override tests");
-	HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
+	if (guest_0_page != 0) {
+		/* Use NO_TAP so we don't get a PASS print */
+		HOST_SYNC_NO_TAP(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
+		ksft_test_result_skip("STAGE_INIT_FETCH_PROT_OVERRIDE - "
+				      "Did not allocate page at 0\n");
+	} else {
+		HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
+	}
 	if (guest_0_page == 0)
 		mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
 	run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
@@ -224,4 +239,8 @@ int main(int argc, char *argv[])
 	run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
 	run->kvm_dirty_regs = KVM_SYNC_CRS;
 	HOST_SYNC(vm, TEST_STORAGE_PROT_OVERRIDE);
+
+	kvm_vm_free(vm);
+
+	ksft_finished();	/* Print results and exit() accordingly */
 }
-- 
2.27.0

