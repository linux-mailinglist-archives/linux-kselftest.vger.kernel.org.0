Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787557500A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGLIAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLIAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 04:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52C1BC2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689148764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pvw4j2K8XqOylaArL4/E5ue75t8iqRSsLMUN6UWuxgI=;
        b=c03IgiIY8Ow61pk3ffFbS0U8bB9ca79IQKC06DI0S4j06LY+aYhRzx/0CzjlXP1CSyJ47L
        UGGcyIXmPOudb7vG/hfoKwDaq5Qxc7cSusOCxOI52b03W50tRCEBqB9LVQWL9uE6nMO+Iv
        j/EU4W1LoSqIYgg3cjRt9GX8WdO7CBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-8hIItBy_PVCdm0HVPdI0AQ-1; Wed, 12 Jul 2023 03:59:21 -0400
X-MC-Unique: 8hIItBy_PVCdm0HVPdI0AQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07887800CAF;
        Wed, 12 Jul 2023 07:59:21 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52F5492C13;
        Wed, 12 Jul 2023 07:59:19 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: [PATCH 4/4] KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test
Date:   Wed, 12 Jul 2023 09:59:10 +0200
Message-Id: <20230712075910.22480-5-thuth@redhat.com>
In-Reply-To: <20230712075910.22480-1-thuth@redhat.com>
References: <20230712075910.22480-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the kselftest_harness.h interface in this test to get TAP
output, so that it is easier for the user to see what the test
is doing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../kvm/x86_64/userspace_msr_exit_test.c      | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index 3533dc2fbfeeb..9843528bba0c6 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -8,6 +8,7 @@
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <sys/ioctl.h>
 
+#include "kselftest_harness.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "vmx.h"
@@ -527,7 +528,7 @@ static void run_guest_then_process_ucall_done(struct kvm_vcpu *vcpu)
 	process_ucall_done(vcpu);
 }
 
-static void test_msr_filter_allow(void)
+TEST(msr_filter_allow)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -646,7 +647,7 @@ static void handle_wrmsr(struct kvm_run *run)
 	}
 }
 
-static void test_msr_filter_deny(void)
+TEST(msr_filter_deny)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -693,7 +694,7 @@ static void test_msr_filter_deny(void)
 	kvm_vm_free(vm);
 }
 
-static void test_msr_permission_bitmap(void)
+TEST(msr_permission_bitmap)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -786,7 +787,7 @@ static void run_msr_filter_flag_test(struct kvm_vm *vm)
 }
 
 /* Test that attempts to write to the unused bits in a flag fails. */
-static void test_user_exit_msr_flags(void)
+TEST(user_exit_msr_flags)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -804,13 +805,5 @@ static void test_user_exit_msr_flags(void)
 
 int main(int argc, char *argv[])
 {
-	test_msr_filter_allow();
-
-	test_msr_filter_deny();
-
-	test_msr_permission_bitmap();
-
-	test_user_exit_msr_flags();
-
-	return 0;
+	return test_harness_run(argc, argv);
 }
-- 
2.39.3

