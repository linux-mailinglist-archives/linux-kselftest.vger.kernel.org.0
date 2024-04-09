Return-Path: <linux-kselftest+bounces-7451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7A89D0A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DAE1C21C4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF725473F;
	Tue,  9 Apr 2024 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce21qbkg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFEB548F2
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631992; cv=none; b=B6LrTYyRaFAC9TEgETWzTDtwpaKBcqFvgHn/VAKKK1TJMSB+m/GYywO00ipdfhPqB3FK/4dsnpGMoxFIZM3iSlSkcOKFAzr9m+SByluuVtiH5YzRFGBjZiR0ffUClzdHaRqDMogYoSAkcp22c1biwIDVBvBxEZ5HVfYAkURRHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631992; c=relaxed/simple;
	bh=N4sxI9pzkVnczNB9OhVPdKGn1mKGvMMhqcWAS7kPLTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RSKx0BKejLI4Aaj9S2ye8lR2rYq5xXqvLym98XM2JxYvsUteYcAFzzVN7e6mc7KK+6WQw7oDdQrJ1G4TO/340H4EF56P6NPrlNbyvfiWbTQHBKbDgQ5mhursv2kwA0UPvfIY38A1Su5HZjcwV+dGEiQn81N1aUfPANFuQReRD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce21qbkg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712631989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oZkhwxc1rV+er5vlPURBYWccH3WvtLWNURgRz3mDLRM=;
	b=ce21qbkgVcc2ilLNj76CAb6JFVjGX1HDIyImJdQc4ubq1gZ9ztURs/mLTgxdLzmFO0NDqn
	E4tUlV8jIS2XElTrlRohe2ZH6vLx7m+0lZjR7N8hsbda9IDNHfjxssF+ZwCxq4tvipR3Bm
	PEYFbTRR3twAuJhUTh2ZwVXViCI5pY8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-UutkogDIMyqz7slyz7zimg-1; Mon,
 08 Apr 2024 23:06:27 -0400
X-MC-Unique: UutkogDIMyqz7slyz7zimg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB65E1C03162;
	Tue,  9 Apr 2024 03:06:26 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64DA717AB1;
	Tue,  9 Apr 2024 03:06:26 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v7 0/3] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Mon,  8 Apr 2024 23:03:13 -0400
Message-Id: <20240409030320.182591-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The test is inspired by the pmu_event_filter_test which implemented by x86. On
the arm64 platform, there is the same ability to set the pmu_event_filter
through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.

The series first create the helper function which can be used
for the vpmu related tests. Then, it implement the test.

Changelog:
----------
v6->v7:
  - Rebased to v6.9-rc3.

v5->v6:
  - Rebased to v6.9-rc1.
  - Collect RB.
  - Add multiple filter test.

v4->v5:
  - Rebased to v6.8-rc6.
  - Refactor the helper function, make it fine-grained and easy to be used.
  - Namimg improvements.
  - Use the kvm_device_attr_set() helper.
  - Make the test descriptor array readable and clean.
  - Delete the patch which moves the pmu related helper to vpmu.h.
  - Remove the kvm_supports_pmu_event_filter() function since nobody will run
  this on a old kernel.

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
v4: https://lore.kernel.org/all/20240202025659.5065-1-shahuang@redhat.com/
v5: https://lore.kernel.org/all/20240229065625.114207-1-shahuang@redhat.com/
v6: https://lore.kernel.org/all/20240326033706.117189-1-shahuang@redhat.com/

Shaoqin Huang (3):
  KVM: selftests: aarch64: Add helper function for the vpmu vcpu
    creation
  KVM: selftests: aarch64: Introduce pmu_event_filter_test
  KVM: selftests: aarch64: Add invalid filter test in
    pmu_event_filter_test

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 336 ++++++++++++++++++
 .../kvm/aarch64/vpmu_counter_access.c         |  33 +-
 .../selftests/kvm/include/aarch64/vpmu.h      |  28 ++
 4 files changed, 372 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h

-- 
2.40.1


