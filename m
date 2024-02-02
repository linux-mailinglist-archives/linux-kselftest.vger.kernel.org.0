Return-Path: <linux-kselftest+bounces-3974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD437846625
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8671F258F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8DBE7C;
	Fri,  2 Feb 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8tVfKiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F012E70
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842638; cv=none; b=XNaKZzCYwustvhyvmfycwB4gKTkyCQYmlwlAsRBSTTCkqQ7YaZKG3bUUGzc3JuzW+KQGCcEyC3KadBpuDbTI5pLFQnuxf/JOuVwZeT5bXi/Z0eckWebL+6oof50sI9Wxi0Y5eMAPfjGdzLfl6xP+g1u1xLHe+P+DLGEUp8tfywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842638; c=relaxed/simple;
	bh=zte8xL5zY+PwyfTErBl+176GxQqh6zCUN2wZuJg8x1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRXDhINDv1vq7kQbvQ+y1e1kAal2SHh8xeFyJGRTA0I/rU7zQKcp7WHmyT8u6pGSXG0WLRB1iXxVcULYdPQN5ZumTQxOZhmobg1xt/SoEOFTNrHUJViWAoSu+WJ/7Lfxze2vQtCyMj8xtQiakFVf1YKWdreyQQc9eqbqihqhGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8tVfKiI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706842636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdhKz6AkD7EoSnhTdlrYl+SSLH69MnV7i+2uXd+vqdc=;
	b=F8tVfKiIPQpNs2b8oWIsjFgyma6sR3dItnUpXCnV65VyufhUTr1UAulj4brzQcMNYnK5qY
	cgHrs/8CZGlMoc5a5BbbG74cqqYiKWWNjQC0kPx0pM+gWO5VSVfOg8ySMPlX3SwrE1l7Vw
	xpWO38kie+5awmRR1iE/lH4pzY7aRJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253--tbSrAG7OjG93kxjDSKTrA-1; Thu,
 01 Feb 2024 21:57:11 -0500
X-MC-Unique: -tbSrAG7OjG93kxjDSKTrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C6BC3C0BE47;
	Fri,  2 Feb 2024 02:57:10 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48783C1ED76;
	Fri,  2 Feb 2024 02:57:10 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] KVM: selftests: aarch64: Add invalid filter test in pmu_event_filter_test
Date: Thu,  1 Feb 2024 21:56:54 -0500
Message-Id: <20240202025659.5065-6-shahuang@redhat.com>
In-Reply-To: <20240202025659.5065-1-shahuang@redhat.com>
References: <20240202025659.5065-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Add the invalid filter test includes sets the filter beyond the event
space and sets the invalid action to double check if the
KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 .../kvm/aarch64/pmu_event_filter_test.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
index d280382f362f..68e1f2003312 100644
--- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
@@ -7,6 +7,7 @@
  * This test checks if the guest only see the limited pmu event that userspace
  * sets, if the guest can use those events which user allow, and if the guest
  * can't use those events which user deny.
+ * It also checks that setting invalid filter ranges return the expected error.
  * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
  * is supported on the host.
  */
@@ -183,6 +184,39 @@ static void for_each_test(void)
 		run_test(t);
 }
 
+static void set_invalid_filter(struct vpmu_vm *vm, void *arg)
+{
+	struct kvm_pmu_event_filter invalid;
+	struct kvm_device_attr attr = {
+		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
+		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
+		.addr	= (uint64_t)&invalid,
+	};
+	int ret = 0;
+
+	/* The max event number is (1 << 16), set a range largeer than it. */
+	invalid = __DEFINE_FILTER(BIT(15), BIT(15)+1, 0);
+	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
+	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
+		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
+		    ret, errno);
+
+	ret = 0;
+
+	/* Set the Invalid action. */
+	invalid = __DEFINE_FILTER(0, 1, 3);
+	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
+	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
+		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
+		    ret, errno);
+}
+
+static void test_invalid_filter(void)
+{
+	vpmu_vm = __create_vpmu_vm(guest_code, set_invalid_filter, NULL);
+	destroy_vpmu_vm(vpmu_vm);
+}
+
 static bool kvm_supports_pmu_event_filter(void)
 {
 	int r;
@@ -216,4 +250,6 @@ int main(void)
 	TEST_REQUIRE(host_pmu_supports_events());
 
 	for_each_test();
+
+	test_invalid_filter();
 }
-- 
2.40.1


