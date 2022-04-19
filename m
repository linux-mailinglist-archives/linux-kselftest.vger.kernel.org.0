Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18240507992
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357455AbiDSTCJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357430AbiDSTCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 15:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58C03F305
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650394760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyIEdvhmJJJsD19FekHwRVcHvpWqFs76gAJaIth1sgU=;
        b=SNM+1P/V40INmLpzdIh7yoR6yEJS5eOsCGmPEhxKbfJzz84ocvZDKEDj6c2mlUJy76QNnF
        1Vx/BJYysuKiaEjOsipGxGw/eDsuNADaBMpDaIpb4VxYrU6HSzhZOOZxNPbLG7b3W2GnhI
        Wt9Viyv0mykrJsoJ6v80F8XyANSz45Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-gUax4OPVOWWjWoH5cflGEg-1; Tue, 19 Apr 2022 14:59:16 -0400
X-MC-Unique: gUax4OPVOWWjWoH5cflGEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46DAD2999B53;
        Tue, 19 Apr 2022 18:59:16 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2909E413736;
        Tue, 19 Apr 2022 18:59:11 +0000 (UTC)
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
Subject: [PATCH v2 3/4] KVM: s390: selftests: Use TAP interface in the tprot test
Date:   Tue, 19 Apr 2022 20:58:56 +0200
Message-Id: <20220419185857.128351-4-thuth@redhat.com>
In-Reply-To: <20220419185857.128351-1-thuth@redhat.com>
References: <20220419185857.128351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/tprot.c | 28 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index c097b9db495e..baba883d7a6d 100644
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
+	STAGE_END			/* this must be the last entry */
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
+{						\
+	HOST_SYNC_NO_TAP(vmp, stage);		\
+	ksft_test_result_pass("" #stage "\n");	\
+}
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
 
@@ -212,9 +222,13 @@ int main(int argc, char *argv[])
 	HOST_SYNC(vm, TEST_SIMPLE);
 
 	guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
-	if (guest_0_page != 0)
-		print_skip("Did not allocate page at 0 for fetch protection override tests");
-	HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
+	if (guest_0_page != 0) {
+		HOST_SYNC_NO_TAP(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
+		ksft_test_result_skip("STAGE_INIT_FETCH_PROT_OVERRIDE - "
+				      "Did not allocate page at 0\n");
+	} else {
+		HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
+	}
 	if (guest_0_page == 0)
 		mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
 	run->s.regs.crs[0] |= CR0_FETCH_PROTECTION_OVERRIDE;
@@ -224,4 +238,8 @@ int main(int argc, char *argv[])
 	run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
 	run->kvm_dirty_regs = KVM_SYNC_CRS;
 	HOST_SYNC(vm, TEST_STORAGE_PROT_OVERRIDE);
+
+	kvm_vm_free(vm);
+
+	ksft_finished();
 }
-- 
2.27.0

