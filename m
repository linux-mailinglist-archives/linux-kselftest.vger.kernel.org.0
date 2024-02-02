Return-Path: <linux-kselftest+bounces-3969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12083846615
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB7628AE2B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 02:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2BBE7C;
	Fri,  2 Feb 2024 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtzBrCyg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A77C14E
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842631; cv=none; b=iRuvJ84XxtawN7Jpk6lOJTiufSNn1wrMkF9OKlEsSrXcelIgYRfP1LVLcM9CBQ0XdoKbj+W15IRWtSNMrQEn/cvQ13oKHDAmzEcg7RtVMFq60/lh08/3ghi/qm8oJd+FpOPwKTh5UBaj18rwkiYLqWOb9k26ZoSYK2tMwTJuWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842631; c=relaxed/simple;
	bh=m9FZO3q9smB7cSYDW0f7Awe436TxHdLzwmgKLOV6UpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0pC4b2esjfVPXAdzsPM5qjdWwXsM2VyzM/pqmXzYiVlKjwtuZbzz/RSHNFvy/gI5w0RaUlcIE52odvxbnbUiQh89qsDzkCMsIob/9MITKwQtp+IImdCqcJ8wyUPQy6jvgZkSsuPPYYI2btpa/UnuTczD85a43g79Ikg7DEQuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtzBrCyg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706842627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=alz1bWzkdlVdcD3J1YSOwuXprTmyNWB0NW6vFsZRqwo=;
	b=RtzBrCygpv9TkMbCRHGXXiH8zATHPyvmGojl862MHljwWomOmr4nGNisGEQ67lZPlutTZ7
	2UkOgXFj7aYkQOdw+yQTHulrnkZ0lB22GPnLjDXC+GewbbJ+kJApd5O34QI8y+M2BjMOvN
	6oNmrCWbpnGr/7+uOiwD+fADJEnykIU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-1EBHbB8BPyqnm_YXc-oHSA-1; Thu, 01 Feb 2024 21:57:03 -0500
X-MC-Unique: 1EBHbB8BPyqnm_YXc-oHSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D75883514A;
	Fri,  2 Feb 2024 02:57:02 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58548C15E61;
	Fri,  2 Feb 2024 02:57:02 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 0/5] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Thu,  1 Feb 2024 21:56:49 -0500
Message-Id: <20240202025659.5065-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The test is inspired by the pmu_event_filter_test which implemented by x86. On
the arm64 platform, there is the same ability to set the pmu_event_filter
through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.

The series first move some pmu common code from vpmu_counter_access to
lib/aarch64/vpmu.c and include/aarch64/vpmu.h, which can be used by
pmu_event_filter_test. Then fix a bug related to the [enable|disable]_counter,
and at last, implement the test itself.

Changelog:
----------
v3->v4:
  - Rebased to the v6.8-rc2.

v2->v3:
  - Check the pmceid in guest code instead of pmu event count since different
  hardware may have different event count result, check pmceid makes it stable
  on different platform.                        [Eric]
  - Some typo fixed and commit message improved.

v1->v2:
  - Improve the commit message.                 [Eric]
  - Fix the bug in [enable|disable]_counter.    [Raghavendra & Marc]
  - Add the check if kvm has attr KVM_ARM_VCPU_PMU_V3_FILTER.
  - Add if host pmu support the test event throught pmceid0.
  - Split the test_invalid_filter() to another patch. [Eric]

v1: https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/
v2: https://lore.kernel.org/all/20231129072712.2667337-1-shahuang@redhat.com/
v3: https://lore.kernel.org/all/20240116060129.55473-1-shahuang@redhat.com/

Shaoqin Huang (5):
  KVM: selftests: aarch64: Make the [create|destroy]_vpmu_vm() public
  KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
  KVM: selftests: aarch64: Fix the buggy [enable|disable]_counter
  KVM: selftests: aarch64: Introduce pmu_event_filter_test
  KVM: selftests: aarch64: Add invalid filter test in
    pmu_event_filter_test

 tools/testing/selftests/kvm/Makefile          |   2 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 255 ++++++++++++++++++
 .../kvm/aarch64/vpmu_counter_access.c         | 217 ++-------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 134 +++++++++
 .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  74 +++++
 5 files changed, 489 insertions(+), 193 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.40.1


