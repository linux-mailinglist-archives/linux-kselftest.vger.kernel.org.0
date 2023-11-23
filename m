Return-Path: <linux-kselftest+bounces-468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB97F5862
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 07:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB88FB20BAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 06:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BDEC2E3;
	Thu, 23 Nov 2023 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X30QnB21"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3AC1
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 22:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700721493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nWktWqMM4G/wXCLhrelXgnsFw3mwZMTHYGnEyrCPhDA=;
	b=X30QnB21dzixih25wdqhCaDuvYDoGpe9NWddhZQ5MmAmnD4yHW5EPxqqhUefAIDg1XGnnz
	UxV2yMxUUZWXMWcNYexpmCqU8IUK3pL6+vhF54XzvF30RoMk+wtc5XMw1WLOb1AR6/oNw/
	NOcXtnpbV0uxdrMr4MK0ZD2bRlCNwc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-AC3FAiN5OAO27fE9bMEl8A-1; Thu, 23 Nov 2023 01:38:06 -0500
X-MC-Unique: AC3FAiN5OAO27fE9bMEl8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B813899EC2;
	Thu, 23 Nov 2023 06:38:06 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F04E21C060AE;
	Thu, 23 Nov 2023 06:38:05 +0000 (UTC)
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
Subject: [PATCH v1 0/3] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Thu, 23 Nov 2023 01:37:42 -0500
Message-Id: <20231123063750.2176250-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The test is inspired by the pmu_event_filter_test which implemented by x86. On
the arm64 platform, there is the same ability to set the pmu_event_filter
through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.

The series first move some pmu common code from vpmu_counter_access to lib/
which can be used by pmu_event_filter_test. Then implements the test itself.

Shaoqin Huang (3):
  KVM: selftests: aarch64: Make the [create|destroy]_vpmu_vm() can be
    reused
  KVM: selftests: aarch64: Move the pmu helper function into lib/
  KVM: selftests: aarch64: Introduce pmu_event_filter_test

 tools/testing/selftests/kvm/Makefile          |   2 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 227 ++++++++++++++++++
 .../kvm/aarch64/vpmu_counter_access.c         | 218 ++---------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 139 +++++++++++
 .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  74 ++++++
 5 files changed, 466 insertions(+), 194 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c

-- 
2.40.1


