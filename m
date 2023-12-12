Return-Path: <linux-kselftest+bounces-1651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B804B80E738
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 10:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD0E1F21912
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ADD5813A;
	Tue, 12 Dec 2023 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kq9A51q9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB03C7;
	Tue, 12 Dec 2023 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372750; x=1733908750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r1px4BsQs/X7Xgfx+BYJsYmJ0wM7HnTCh77HJxhuwZg=;
  b=Kq9A51q9SyoffKynEIkyZdQK5BnPL/L/qaxH80gLkSO3Q5CcdT4PweX5
   vmrs6uPxhvn0J7Lc/OiUbnyXpszN8nQsRCebgWZ3Vr/rLy2qCcHvwPJCo
   1g0J0uycHJYOhZy6P3wyJooNJRQ5OQ7RIwK8x490PFJ28yxGjcuSWNgqJ
   x2nw6KAPqt0kGCBQonM1wQVMTyGiS6inGxH9nIVwO4V/SfC35t/LVX7dQ
   2DjibEZg90pnoKY4NVUO+sz6UrKSQOd8jCGaVz6nI2PAvDlA8pTK4DdYa
   Ruzr8zgNrtujr5uswJPFzuxacSe8VYBWUbhB1FbJA+vDm9HJ101Jhawdm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974125"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974125"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:19:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917212797"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917212797"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:19:00 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	haibo1.xu@intel.com,
	ajones@ventanamicro.com,
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
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	wchen <waylingii@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel@sholland.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Like Xu <likexu@tencent.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v4 00/11] RISCV: Add kvm Sstc timer selftests
Date: Tue, 12 Dec 2023 17:31:09 +0800
Message-Id: <cover.1702371136.git.haibo1.xu@intel.com>
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
with Linux v6.7-rc4 on a Qemu riscv64 virt machine.

---
Changed since v4:
  * Rebased to Linux 6.7-rc4
  * Included Paolo's patch(01/11) to fix issues with SPLIT_TESTS
  * Droped the patch(KVM: selftests: Unify the makefile rule for split targets) 
    since Paolo's patch had included the fix
  * Added new patch(05/11) to include header file vdso/processor.h from linux
    source tree to leverage the cpu_relax() definition - Conor/Andrew
  * Added new patch(11/11) to enable user configuration of timer error margin
    parameter which alleviate the intermitent failure in stress test - Andrew
  * Other minor fixes per Andrew's comments

Haibo Xu (10):
  KVM: arm64: selftests: Split arch_timer test code
  KVM: selftests: Add CONFIG_64BIT definition for the build
  tools: riscv: Add header file csr.h
  tools: riscv: Add header file vdso/processor.h
  KVM: riscv: selftests: Switch to use macro from csr.h
  KVM: riscv: selftests: Add exception handling support
  KVM: riscv: selftests: Add guest helper to get vcpu id
  KVM: riscv: selftests: Change vcpu_has_ext to a common function
  KVM: riscv: selftests: Add sstc timer test
  KVM: selftests: Enable tunning of err_margin_us in arch timer test

Paolo Bonzini (1):
  selftests/kvm: Fix issues with $(SPLIT_TESTS)

 tools/arch/riscv/include/asm/csr.h            | 521 ++++++++++++++++++
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
 15 files changed, 1333 insertions(+), 307 deletions(-)
 create mode 100644 tools/arch/riscv/include/asm/csr.h
 create mode 100644 tools/arch/riscv/include/asm/vdso/processor.h
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
 create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c

-- 
2.34.1


