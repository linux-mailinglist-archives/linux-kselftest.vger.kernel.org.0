Return-Path: <linux-kselftest+bounces-4367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214084E9E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97581F2D911
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7948CC6;
	Thu,  8 Feb 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm2TTpjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0344A99C
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425344; cv=none; b=jgc4NJglsup1+dwnlavnl3bNQYsfC3xT1o823JNL/Vie4MlinFe5he2Y6nYrqsAgkbOReoSkqPzDpekGQWYMnS4IRcU1V/PqsGUCoSQkYCK/iNkcyNvBWQxZYXDIagFiczFv1xuyXx8db7/mUR3UhIJrMc8ADbGLHOvkLrDfM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425344; c=relaxed/simple;
	bh=VI7qXJxS/lasyNThrbyjvkzs+3R4P9ZKyEkXMk7ilKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqRVucnDaByNKdpawuLmER/yMaOutR7+P1WIwnCehjo+FUFJGuM2l5CoRUfPtkoPVwzKXu/OYUYDlyQvdRFWmhqJnqcDCHtkhDKH826Hf9O2a4Qu5Ie1WsAW7MEMj9qHz48yLG2OBqcOBP/4lqpg5IZKHN3VpvpZ1I8riYBvjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm2TTpjA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBTElX16WHnJ/uasV+kMXYqDLGTcdRCMmjiGOz8erC0=;
	b=Nm2TTpjAlrcIWMWUFM37Nqn0fQnRGz2YzRWrfC8yHbSwTSxLiR180Y/xzm0FDOlxeDfQo/
	cuTrqinCpsjGidmAOqnlP144RruqvDuv5qBa9KF48f4FtqOYiavdH1LTJRaFfcObLzClSE
	/A99EXzmn4AttcnMCWxq3TZW+Zp1PNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-Fdy4qd_EMbOwjBSIVnuhwQ-1; Thu,
 08 Feb 2024 15:48:56 -0500
X-MC-Unique: Fdy4qd_EMbOwjBSIVnuhwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7D211C05141;
	Thu,  8 Feb 2024 20:48:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 856C91C10C0E;
	Thu,  8 Feb 2024 20:48:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 4/8] KVM: selftests: Add a macro to define a test with one vcpu
Date: Thu,  8 Feb 2024 21:48:40 +0100
Message-ID: <20240208204844.119326-5-thuth@redhat.com>
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
References: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
 .../selftests/kvm/include/kvm_test_harness.h  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_test_harness.h

diff --git a/tools/testing/selftests/kvm/include/kvm_test_harness.h b/tools/testing/selftests/kvm/include/kvm_test_harness.h
new file mode 100644
index 0000000000000..8f7c6858e8e2d
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/kvm_test_harness.h
@@ -0,0 +1,36 @@
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
+#define KVM_ONE_VCPU_TEST_SUITE(name)					\
+	FIXTURE(name) {							\
+		struct kvm_vcpu *vcpu;					\
+	};								\
+									\
+	FIXTURE_SETUP(name) {						\
+		(void)vm_create_with_one_vcpu(&self->vcpu, NULL);	\
+	}								\
+									\
+	FIXTURE_TEARDOWN(name) {					\
+		kvm_vm_free(self->vcpu->vm);				\
+	}
+
+#define KVM_ONE_VCPU_TEST(suite, test, guestcode)			\
+static void __suite##_##test(struct kvm_vcpu *vcpu);			\
+									\
+TEST_F(suite, test)							\
+{									\
+	vcpu_arch_set_entry_point(self->vcpu, guestcode);		\
+	__suite##_##test(self->vcpu);					\
+}									\
+static void __suite##_##test(struct kvm_vcpu *vcpu)
+
+#endif /* SELFTEST_KVM_TEST_HARNESS_H */
-- 
2.43.0


