Return-Path: <linux-kselftest+bounces-44882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D217C39D9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D607B4F364E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F2E30CDB5;
	Thu,  6 Nov 2025 09:40:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF430C636;
	Thu,  6 Nov 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422032; cv=none; b=KHiX0TK3mrcI7M/TpaoY/sTx75MXxA9i+9qb3EYgcHLfdJoKw5yVhJRaTAtgWRdalruiOXlmW8z52wik9W55TdrcWH4Qba/K4EtYwiBZFjB+Ef81L9+mJEosvO2E3g9vqRSV1neAAAZYX/Vi/AXL/NAc6FgnurRQeDEpKgrsAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422032; c=relaxed/simple;
	bh=vrkroYmYNXYCJ55dzk4Mp/6Rn8rgOpPCHKw9X6pxPKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTmsPF4AT9JDu4oJgVf6kZ+ba+EEWGfAsnhxjq7kH7RYb/xe1sDgBnvrCt9MXf8zdZQG5/P8PTKBN/MRrzBwZrNP0Q1DqmCN48DaS09dP6n/ZupBp7Ln2H+9yhl2aWROQ8fuBqG3VtHQfaLgRaVNEbsTM2lAiazKDmwubaSuEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7E31596;
	Thu,  6 Nov 2025 01:40:21 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 613BB3F63F;
	Thu,  6 Nov 2025 01:40:26 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	miko.lenczewski@arm.com,
	kevin.brodsky@arm.com,
	ardb@kernel.org,
	suzuki.poulose@arm.com,
	lpieralisi@kernel.org,
	yangyicong@hisilicon.com,
	scott@os.amperecomputing.com,
	joey.gouly@arm.com,
	yuzenghui@huawei.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v11 0/9] support FEAT_LSUI
Date: Thu,  6 Nov 2025 09:40:14 +0000
Message-Id: <20251106094023.1371246-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
previleged level to access to access user memory without clearing
PSTATE.PAN bit.

This patchset support FEAT_LSUI and applies in futex atomic operation
and user_swpX emulation where can replace from ldxr/st{l}xr
pair implmentation with clearing PSTATE.PAN bit to correspondant
load/store unprevileged atomic operation without clearing PSTATE.PAN bit.


Patch Sequences
================

Patch #1 adds cpufeature for FEAT_LSUI

Patch #2-#3 expose FEAT_LSUI to guest

Patch #4 adds Kconfig for FEAT_LSUI

Patch #5-#6 support futex atomic-op with FEAT_LSUI

Patch #7-#9 support user_swpX emulation with FEAT_LSUI


Patch History
==============
from v10 to v11:
  - use cast instruction to emulate deprecated swpb instruction
  - https://lore.kernel.org/all/20251103163224.818353-1-yeoreum.yun@arm.com/

from v9 to v10:
  - apply FEAT_LSUI to user_swpX emulation.
  - add test coverage for LSUI bit in ID_AA64ISAR3_EL1
  - rebase to v6.18-rc4
  - https://lore.kernel.org/all/20250922102244.2068414-1-yeoreum.yun@arm.com/

from v8 to v9:
  - refotoring __lsui_cmpxchg64()
  - rebase to v6.17-rc7
  - https://lore.kernel.org/all/20250917110838.917281-1-yeoreum.yun@arm.com/

from v7 to v8:
  - implements futex_atomic_eor() and futex_atomic_cmpxchg() with casalt
    with C helper.
  - Drop the small optimisation on ll/sc futex_atomic_set operation.
  - modify some commit message.
  - https://lore.kernel.org/all/20250816151929.197589-1-yeoreum.yun@arm.com/

from v6 to v7:
  - wrap FEAT_LSUI with CONFIG_AS_HAS_LSUI in cpufeature
  - remove unnecessary addition of indentation.
  - remove unnecessary mte_tco_enable()/disable() on LSUI operation.
  - https://lore.kernel.org/all/20250811163635.1562145-1-yeoreum.yun@arm.com/

from v5 to v6:
  - rebase to v6.17-rc1
  - https://lore.kernel.org/all/20250722121956.1509403-1-yeoreum.yun@arm.com/

from v4 to v5:
  - remove futex_ll_sc.h futext_lsui and lsui.h and move them to futex.h
  - reorganize the patches.
  - https://lore.kernel.org/all/20250721083618.2743569-1-yeoreum.yun@arm.com/

from v3 to v4:
  - rebase to v6.16-rc7
  - modify some patch's title.
  - https://lore.kernel.org/all/20250617183635.1266015-1-yeoreum.yun@arm.com/

from v2 to v3:
  - expose FEAT_LUSI to guest
  - add help section for LUSI Kconfig
  - https://lore.kernel.org/all/20250611151154.46362-1-yeoreum.yun@arm.com/

from v1 to v2:
  - remove empty v9.6 menu entry
  - locate HAS_LUSI in cpucaps in order
  - https://lore.kernel.org/all/20250611104916.10636-1-yeoreum.yun@arm.com/

Yeoreum Yun (9):
  arm64: cpufeature: add FEAT_LSUI
  KVM: arm64: expose FEAT_LSUI to guest
  KVM: arm64: kselftest: set_id_regs: add test for FEAT_LSUI
  arm64: Kconfig: Detect toolchain support for LSUI
  arm64: futex: refactor futex atomic operation
  arm64: futex: support futex with FEAT_LSUI
  arm64: separate common LSUI definitions into lsui.h
  arm64: armv8_deprecated: convert user_swpX to inline function
  arm64: armv8_deprecated: apply FEAT_LSUI for swpX emulation.

 arch/arm64/Kconfig                            |   5 +
 arch/arm64/include/asm/futex.h                | 291 +++++++++++++++---
 arch/arm64/include/asm/lsui.h                 |  25 ++
 arch/arm64/kernel/armv8_deprecated.c          | 111 +++++--
 arch/arm64/kernel/cpufeature.c                |  10 +
 arch/arm64/kvm/sys_regs.c                     |   3 +-
 arch/arm64/tools/cpucaps                      |   1 +
 .../testing/selftests/kvm/arm64/set_id_regs.c |   1 +
 8 files changed, 381 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm64/include/asm/lsui.h


base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


