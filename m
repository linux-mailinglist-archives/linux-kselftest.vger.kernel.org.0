Return-Path: <linux-kselftest+bounces-3297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93F835E71
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916631F2541A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A3439AE2;
	Mon, 22 Jan 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMQnyxl9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B93A1A2;
	Mon, 22 Jan 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916703; cv=none; b=DGVciwSUFHnngmfTRbRBLueSKWoSZVLAagVxdlN5q00p4bBtQlHdofGPiU8Qb9SoucVwQfktfdVq+fXRm5nyJOxu0yR5Zsxwzu8MAe6ZpNUq0Qrmt8WriJPjn9hqR4f5wGXbFHOzq0QjpOjZNwCZ2gWrnVNE3vAzQJU5atTTWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916703; c=relaxed/simple;
	bh=t4I3ga6CJht5tl0WmnhE1Xni4i5mXbwGq8WdKx7/4Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=forTIN2kpKzIkzIdR0C8qkR1z1ddZt5sFmNt/eu/A+NMvA73d+dkzqMNE9KBDwSEdClDQazVTfQtTFuWn3AY7XseQz9ta3vt7wJ621tulFioEiynLXnabuOsAy8nuIJPVMmcUfAY/ZqugueJLTAIiJ13eR7g9jDvjdrSXPnSSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMQnyxl9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916702; x=1737452702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4I3ga6CJht5tl0WmnhE1Xni4i5mXbwGq8WdKx7/4Ag=;
  b=JMQnyxl927QdETq8CXDQp3cJIojE1tLvAR8vTFmHn7wAzcjd5s8u1jOF
   bodUgC9+EwrZA9nm6NC+uHHYsEUnRZZS3vFdriz4eBl4golC+1tsMeZaS
   AV1l6T/YTWRDnhEzTR36Cu8kDWGFXzlxHSl8xz+4DTRbyF8qVLwhW9ymY
   sC8XGi0beKISd0AVX9LS+O5FZeDAJO30BtbTtNeFASy4LudGNe8tYUzzf
   MP88YtnkcsnlJE6zDId+wnyrgKIYL7rNnwUqMFkopp+baGKi3o9YRbgu+
   q5rkC+8fPJFNFk3xAS8eKW2ZVJzvJwLYGaMfDQmYJUBCrCC4TYYTKCyLE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22641468"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22641468"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:45:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535212"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535212"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:44:50 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	wchen <waylingii@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Like Xu <likexu@tencent.com>,
	Vipin Sharma <vipinsh@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v5 00/12] RISCV: Add kvm Sstc timer selftests
Date: Mon, 22 Jan 2024 17:58:30 +0800
Message-Id: <cover.1705916069.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V arch_timer selftests is used to validate Sstc timer
functionality in a guest, which sets up periodic timer interrupts
and check the basic interrupt status upon its receipt.

This KVM selftests was ported from aarch64 arch_timer and tested
with Linux v6.7-rc8 on a Qemu riscv64 virt machine.

---
Changed since v4:
  * Rebased to Linux 6.7-rc8
  * Added new patch(2/12) to clean up the data type in struct test_args
  * Re-ordered patch(11/11) in v4 to patch(3/12)
  * Changed the timer_err_margin_us type from int to uint32_t

Haibo Xu (11):
  KVM: arm64: selftests: Data type cleanup for arch_timer test
  KVM: arm64: selftests: Enable tuning of error margin in arch_timer
    test
  KVM: arm64: selftests: Split arch_timer test code
  KVM: selftests: Add CONFIG_64BIT definition for the build
  tools: riscv: Add header file csr.h
  tools: riscv: Add header file vdso/processor.h
  KVM: riscv: selftests: Switch to use macro from csr.h
  KVM: riscv: selftests: Add exception handling support
  KVM: riscv: selftests: Add guest helper to get vcpu id
  KVM: riscv: selftests: Change vcpu_has_ext to a common function
  KVM: riscv: selftests: Add sstc timer test

Paolo Bonzini (1):
  selftests/kvm: Fix issues with $(SPLIT_TESTS)

 tools/arch/riscv/include/asm/csr.h            | 541 ++++++++++++++++++
 tools/arch/riscv/include/asm/vdso/processor.h |  32 ++
 tools/testing/selftests/kvm/Makefile          |  27 +-
 .../selftests/kvm/aarch64/arch_timer.c        | 295 +---------
 tools/testing/selftests/kvm/arch_timer.c      | 259 +++++++++
 .../selftests/kvm/include/aarch64/processor.h |   4 -
 .../selftests/kvm/include/kvm_util_base.h     |   9 +
 .../selftests/kvm/include/riscv/arch_timer.h  |  71 +++
 .../selftests/kvm/include/riscv/processor.h   |  65 ++-
 .../testing/selftests/kvm/include/test_util.h |   2 +
 .../selftests/kvm/include/timer_test.h        |  45 ++
 .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
 .../selftests/kvm/lib/riscv/processor.c       |  87 +++
 .../testing/selftests/kvm/riscv/arch_timer.c  | 111 ++++
 .../selftests/kvm/riscv/get-reg-list.c        |  11 +-
 15 files changed, 1353 insertions(+), 307 deletions(-)
 create mode 100644 tools/arch/riscv/include/asm/csr.h
 create mode 100644 tools/arch/riscv/include/asm/vdso/processor.h
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
 create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c

-- 
2.34.1


