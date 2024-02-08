Return-Path: <linux-kselftest+bounces-4363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E684E9D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103A71F2D56D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2414A990;
	Thu,  8 Feb 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBEbsDoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97399487B8
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425334; cv=none; b=Xe76T39ydNOxKHhMGLP2jhqQwdpdODM3Kz8rgDSBQEbVFW7lzgsm8CZadyi72CoOW/+RLFH+J7nYqyzjnF6wa5vgN74uAufsVV4iF4kabXVKs4yGaoknjnODfibzOCWOM+KnTZEDSmGLOcdNLGLKAkH7FzpL804b2ozvyIGHjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425334; c=relaxed/simple;
	bh=hQPpfJEcu1TBw9wCkVbp3RFuJW56wCEGbFWMn8aip4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8/F7zFsT9CcO7U3ZHD0on7WlqXww6ZQb0xm6szIgFWKAstNdTBL0hpEjmFrauSvaavmB1o3jy/tawMtAsttyE93UK8MmPVGbGONaFThtKfYa5fv+BMJ46ng3JTS4nKY39NW0TzACnTG+7Kg/QmxnbbpWuR6wRdYHHcQNBHct8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBEbsDoY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NjzbgvZWqOOP842jfLLt5QLs4+yDffYTw25/cut6/mc=;
	b=JBEbsDoYcyUE7+FH7eP6TuupRP+QscnIrfalMUcJ9X+GQ8SwrTNVTTUvuCe+pA+dCltUzm
	ve+kjTgAZNcMJ90s3GtkyV9KVCT+jDZ1PWvdoWXzPYtQA0/CvEpt6vOeW5gOiWmOen3WFD
	ZFfDzOk6bx57mG/z3V7/D2qFS1NyHGw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-Zf_C2lMwNNSk9wblRrq7XQ-1; Thu,
 08 Feb 2024 15:48:48 -0500
X-MC-Unique: Zf_C2lMwNNSk9wblRrq7XQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 886B73810790;
	Thu,  8 Feb 2024 20:48:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D81121C10C0C;
	Thu,  8 Feb 2024 20:48:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 0/8] Use TAP in some more x86 KVM selftests
Date: Thu,  8 Feb 2024 21:48:36 +0100
Message-ID: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Basic idea of this series is now to use the kselftest_harness.h
framework to get TAP output in the tests, so that it is easier
for the user to see what is going on, and e.g. to be able to
detect whether a certain test is part of the test binary or not
(which is useful when tests get extended in the course of time).

Since most tests also need a vcpu, we introduce our own macros
to define such tests, so we don't have to repeat this code all
over the place.

v3:
- Add patch from Sean to allow setting vCPU's entry points seperately
- Let each test define the entry point via KVM_ONE_VCPU_TEST(), don't
  do it globally from KVM_ONE_VCPU_TEST_SUITE()

v2:
- Dropped the "Rename the ASSERT_EQ macro" patch (already merged)
- Split the fixes in the sync_regs_test into separate patches
  (see the first two patches)
- Introduce the KVM_ONE_VCPU_TEST_SUITE() macro as suggested
  by Sean (see third patch) and use it in the following patches
- Add a new patch to convert vmx_pmu_caps_test.c, too

Sean Christopherson (1):
  KVM: selftests: Move setting a vCPU's entry point to a dedicated API

Thomas Huth (7):
  KVM: selftests: x86: sync_regs_test: Use vcpu_run() where appropriate
  KVM: selftests: x86: sync_regs_test: Get regs structure before
    modifying it
  KVM: selftests: Add a macro to define a test with one vcpu
  KVM: selftests: x86: Use TAP interface in the sync_regs test
  KVM: selftests: x86: Use TAP interface in the fix_hypercall test
  KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
  KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test

 .../selftests/kvm/include/kvm_test_harness.h  |  36 ++++++
 .../selftests/kvm/include/kvm_util_base.h     |  11 +-
 .../selftests/kvm/lib/aarch64/processor.c     |  23 +++-
 .../selftests/kvm/lib/riscv/processor.c       |   9 +-
 .../selftests/kvm/lib/s390x/processor.c       |  13 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  13 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  27 ++--
 .../selftests/kvm/x86_64/sync_regs_test.c     | 121 +++++++++++++-----
 .../kvm/x86_64/userspace_msr_exit_test.c      |  52 ++------
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  50 ++------
 10 files changed, 215 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_test_harness.h

-- 
2.43.0


