Return-Path: <linux-kselftest+bounces-47554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F856CBBA0A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC59F300442A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Dec 2025 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336E3128CA;
	Sun, 14 Dec 2025 11:23:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC33128BA;
	Sun, 14 Dec 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765711384; cv=none; b=QSS1h3l1XBFRZMPnMaHsyt6ALhI6xZcETQpALxbHm8e/qOeff8gWy5xlVNuLmlHQqds6O1JumVewwYa1NG4TNh9AJY629l0hJzNaQfveYPLNOC0QODnQQnj4UON53pqnP9V+UitbA/vdn5l1zTbqkrxN/lGf3iJBoJ3vd+vM8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765711384; c=relaxed/simple;
	bh=XDSDi5h/fuwj32uTomF9VLHfGU2PnEDhrbwKBeZtl6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d105ySmGmu+UOkAfBZlkwLrBKXlWY4KTDG6eimAsSUa0X7u48N+x0qW2VdkAuQpzHed0XQdwnQJ3uNCci2YEwan9UBGK7R7v7a9u8QPNQ6bw4WiPAufyhBXWGlD/ONmGZwA3Muimxya8RC5c6WuTN0LfjYFr96UBk0Gax26SYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED840497;
	Sun, 14 Dec 2025 03:22:47 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4FD73F73B;
	Sun, 14 Dec 2025 03:22:51 -0800 (PST)
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
	mark.rutland@arm.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v11 RESEND 0/9] support FEAT_LSUI
Date: Sun, 14 Dec 2025 11:22:39 +0000
Message-Id: <20251214112248.901769-1-yeoreum.yun@arm.com>
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

This patch based on v6.19-rc1


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
  - rebase to v6.19-rc1
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


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


