Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B57500B99
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiDNK4G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242038AbiDNK4C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 06:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23CD57E5BA
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649933614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qezaIFsTkLoWKaonJSnIU/m+cPX3t3dpi0YKUuYR714=;
        b=XvF3/g0+6bXbgfEkDsAPWEEV2WDBXkDgVLtGx4qY8RZ8Dwa4mmby+iHk1z0h7w5RNrA4qV
        itZ0Y2Kq7hv76MtUH5HAZlnUj7fS5AKPYuadROK4pMlTtzVZJojbNziYvO8GFK92iWY4ym
        soNcXxcriHCCL4ytQhZUmcYPQErzE58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-nt_ZLx7LN_edxJW2oG7ggg-1; Thu, 14 Apr 2022 06:53:30 -0400
X-MC-Unique: nt_ZLx7LN_edxJW2oG7ggg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3134801E95;
        Thu, 14 Apr 2022 10:53:29 +0000 (UTC)
Received: from thuth.com (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 708ABC28114;
        Thu, 14 Apr 2022 10:53:28 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Subject: [PATCH 3/4] KVM: s390: selftests: Use TAP interface in the tprot test
Date:   Thu, 14 Apr 2022 12:53:21 +0200
Message-Id: <20220414105322.577439-4-thuth@redhat.com>
In-Reply-To: <20220414105322.577439-1-thuth@redhat.com>
References: <20220414105322.577439-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 tools/testing/selftests/kvm/s390x/tprot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
index c097b9db495e..a714b4206e95 100644
--- a/tools/testing/selftests/kvm/s390x/tprot.c
+++ b/tools/testing/selftests/kvm/s390x/tprot.c
@@ -8,6 +8,7 @@
 #include <sys/mman.h>
 #include "test_util.h"
 #include "kvm_util.h"
+#include "kselftest.h"
 
 #define PAGE_SHIFT 12
 #define PAGE_SIZE (1 << PAGE_SHIFT)
@@ -69,6 +70,7 @@ enum stage {
 	STAGE_INIT_FETCH_PROT_OVERRIDE,
 	TEST_FETCH_PROT_OVERRIDE,
 	TEST_STORAGE_PROT_OVERRIDE,
+	NUM_STAGES			/* this must be the last entry */
 };
 
 struct test {
@@ -196,6 +198,7 @@ static void guest_code(void)
 	}									\
 	ASSERT_EQ(uc.cmd, UCALL_SYNC);						\
 	ASSERT_EQ(uc.args[1], __stage);						\
+	ksft_test_result_pass("" #stage "\n");					\
 })
 
 int main(int argc, char *argv[])
@@ -204,6 +207,9 @@ int main(int argc, char *argv[])
 	struct kvm_run *run;
 	vm_vaddr_t guest_0_page;
 
+	ksft_print_header();
+	ksft_set_plan(NUM_STAGES - 1);	/* STAGE_END is not counted, thus - 1 */
+
 	vm = vm_create_default(VCPU_ID, 0, guest_code);
 	run = vcpu_state(vm, VCPU_ID);
 
@@ -213,7 +219,7 @@ int main(int argc, char *argv[])
 
 	guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
 	if (guest_0_page != 0)
-		print_skip("Did not allocate page at 0 for fetch protection override tests");
+		ksft_print_msg("Did not allocate page at 0 for fetch protection override tests\n");
 	HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
 	if (guest_0_page == 0)
 		mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
@@ -224,4 +230,8 @@ int main(int argc, char *argv[])
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

