Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE11A7BA1C9
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 16:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJEO7F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjJEO5R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BF26A53
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vazohg9FZ6E9GP8kzgkpGCob+IwdhO7BJaWstWzvEzQ=;
        b=gLU70QCX3CVs0m9SYbep60GYSOFK1XaVh2WctUGMNxQUO2DmOsL9EefgoHvRhGTMEUaSSl
        CoWUoPQmt169veLfGRPWLP/QbfGoZLMvUUdWHmRxsqzjd4vqQCTjXvia3p+djysOxXZK3y
        xrAycVSbDLqeoP2675Kz41x0lFKYKI4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-RutCxQ4vM7W0K_V5cIuMSw-1; Thu, 05 Oct 2023 10:38:47 -0400
X-MC-Unique: RutCxQ4vM7W0K_V5cIuMSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFF9C3C1E9D7;
        Thu,  5 Oct 2023 14:38:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA0A40C6EA8;
        Thu,  5 Oct 2023 14:38:45 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/7] KVM: selftests: Add a macro to define a test with one vcpu
Date:   Thu,  5 Oct 2023 16:38:35 +0200
Message-ID: <20231005143839.365297-4-thuth@redhat.com>
In-Reply-To: <20231005143839.365297-1-thuth@redhat.com>
References: <20231005143839.365297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most tests are currently not giving any proper output for the user
to see how much sub-tests have already been run, or whether new
sub-tests are part of a binary or not. So it would be good to
support TAP output in the KVM selftests. There is already a nice
framework for this in the kselftest_harness.h header which we can
use. But since we also need a vcpu in most KVM selftests, it also
makes sense to introduce our own wrapper around this which takes
care of creating a VM with one vcpu, so we don't have to repeat
this boilerplate in each and every test. Thus let's introduce
a KVM_ONE_VCPU_TEST() macro here which takes care of this.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/Y2v+B3xxYKJSM%2FfH@google.com/
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/include/kvm_test_harness.h  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_test_harness.h

diff --git a/tools/testing/selftests/kvm/include/kvm_test_harness.h b/tools/testing/selftests/kvm/include/kvm_test_harness.h
new file mode 100644
index 0000000000000..04cfc44e3b506
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/kvm_test_harness.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Macros for defining a KVM test
+ *
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_TEST_HARNESS_H
+#define SELFTEST_KVM_TEST_HARNESS_H
+
+#include "kselftest_harness.h"
+
+#define KVM_ONE_VCPU_TEST_SUITE(name, guest_code)			\
+	FIXTURE(name) {							\
+		struct kvm_vcpu *vcpu;					\
+	};								\
+									\
+	FIXTURE_SETUP(name) {						\
+		(void)vm_create_with_one_vcpu(&self->vcpu, guest_code);	\
+	}								\
+									\
+	FIXTURE_TEARDOWN(name) {					\
+		kvm_vm_free(self->vcpu->vm);				\
+	}
+
+#define KVM_ONE_VCPU_TEST(suite, test)					\
+static void __suite##_##test(struct kvm_vcpu *vcpu);			\
+									\
+TEST_F(suite, test)							\
+{									\
+	__suite##_##test(self->vcpu);					\
+}									\
+static void __suite##_##test(struct kvm_vcpu *vcpu)
+
+#endif /* SELFTEST_KVM_TEST_HARNESS_H */
-- 
2.41.0

