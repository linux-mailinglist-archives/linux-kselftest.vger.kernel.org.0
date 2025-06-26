Return-Path: <linux-kselftest+bounces-35837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D49AE978F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63F73ABBF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA625C81D;
	Thu, 26 Jun 2025 08:09:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657925B69B;
	Thu, 26 Jun 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925365; cv=none; b=jXHoXkbTUv+3deeVisnAeM204A+vYAVU3GXC2vu1uD2n0b7flKHATEDR0C35AbYa+hXRp51y4YwVOipUUXf3CbrsMggm2ed9o56muzbGtAyTdvL0PUJ/8medkC94AwNQ3zQ6ye5RcVsPcI9tvPZNv3bdH7ye0VaxUNIPSM/GK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925365; c=relaxed/simple;
	bh=2qUwvorJKhJX/rnLKPbtBqT32gzi34OE7WyleCENtYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=stahZYVI5IeHyChqLoHPkHv4uWOL9nkOEeGVHg7fMowfJxvyZ2mkvZZpVfQ/FLvfGVlFsMcbgP13S09Q0E31MsrQ9eghTaD60z8lVcomy2SD71vYqAdohRbSdlaYZv6RzEraZIvfkDqvQvSydZApBbK5T4LCERSO3xLYEkRsjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bSWSw2MzLz2CfD1;
	Thu, 26 Jun 2025 16:05:20 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CA191A016C;
	Thu, 26 Jun 2025 16:09:18 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 16:09:18 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 16:09:17 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v3 0/7] Add support for FEAT_{LS64, LS64_V} and related tests
Date: Thu, 26 Jun 2025 16:08:59 +0800
Message-ID: <20250626080906.64230-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemq200018.china.huawei.com (7.202.195.108)

From: Yicong Yang <yangyicong@hisilicon.com>

Armv8.7 introduces single-copy atomic 64-byte loads and stores
instructions and its variants named under FEAT_{LS64, LS64_V}.
Add support for Armv8.7 FEAT_{LS64, LS64_V}:
- Add identifying and enabling in the cpufeature list
- Expose the support of these features to userspace through HWCAP3
  and cpuinfo
- Add related hwcap test
- Handle the trap of unsupported memory (normal/uncacheable) access in a VM

A real scenario for this feature is that the userspace driver can make use of
this to implement direct WQE (workqueue entry) - a mechanism to fill WQE
directly into the hardware.

Picked Marc's 2 patches form [1] for handling the LS64 trap in a VM on emulated
MMIO and the introduce of KVM_EXIT_ARM_LDST64B.

[1] https://lore.kernel.org/linux-arm-kernel/20240815125959.2097734-1-maz@kernel.org/

Tested with hwcap test [*]:
[*] https://lore.kernel.org/linux-arm-kernel/20250331094320.35226-5-yangyicong@huawei.com/
On host:
root@localhost:/tmp# dmesg | grep "All CPU(s) started"
[    0.504846] CPU: All CPU(s) started at EL2
root@localhost:/tmp# ./hwcap
[...]
# LS64 present
ok 217 cpuinfo_match_LS64
ok 218 sigill_LS64
ok 219 # SKIP sigbus_LS64
# LS64_V present
ok 220 cpuinfo_match_LS64_V
ok 221 sigill_LS64_V
ok 222 # SKIP sigbus_LS64_V
# 115 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:107 fail:0 xfail:0 xpass:0 skip:115 error:0

On guest:
root@localhost:/# dmesg | grep "All CPU(s) started"
[    0.451482] CPU: All CPU(s) started at EL1
root@localhost:/mnt# ./hwcap
[...]
# LS64 present
ok 217 cpuinfo_match_LS64
ok 218 sigill_LS64
ok 219 # SKIP sigbus_LS64
# LS64_V present
ok 220 cpuinfo_match_LS64_V
ok 221 sigill_LS64_V
ok 222 # SKIP sigbus_LS64_V
# 115 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:107 fail:0 xfail:0 xpass:0 skip:115 error:0

Change since v2:
- Handle the LS64 fault to userspace and allow userspace to inject LS64 fault
- Reorder the patches to make KVM handling prior to feature support
Link: https://lore.kernel.org/linux-arm-kernel/20250331094320.35226-1-yangyicong@huawei.com/

Change since v1:
- Drop the support for LS64_ACCDATA
- handle the DABT of unsupported memory type after checking the memory attributes
Link: https://lore.kernel.org/linux-arm-kernel/20241202135504.14252-1-yangyicong@huawei.com/

Marc Zyngier (2):
  KVM: arm64: Add exit to userspace on {LD,ST}64B* outside of memslots
  KVM: arm64: Add documentation for KVM_EXIT_ARM_LDST64B

Yicong Yang (5):
  KVM: arm64: Handle DABT caused by LS64* instructions on unsupported
    memory
  KVM: arm/arm64: Allow user injection of unsupported exclusive/atomic
    DABT
  arm64: Provide basic EL2 setup for FEAT_{LS64, LS64_V} usage at EL0/1
  arm64: Add support for FEAT_{LS64, LS64_V}
  KVM: arm64: Enable FEAT_{LS64, LS64_V} in the supported guest

 Documentation/arch/arm64/booting.rst    | 12 ++++++
 Documentation/arch/arm64/elf_hwcaps.rst |  6 +++
 Documentation/virt/kvm/api.rst          | 43 +++++++++++++++++----
 arch/arm64/include/asm/el2_setup.h      | 12 +++++-
 arch/arm64/include/asm/esr.h            |  8 ++++
 arch/arm64/include/asm/hwcap.h          |  2 +
 arch/arm64/include/asm/kvm_emulate.h    |  7 ++++
 arch/arm64/include/uapi/asm/hwcap.h     |  2 +
 arch/arm64/include/uapi/asm/kvm.h       |  3 +-
 arch/arm64/kernel/cpufeature.c          | 51 +++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c             |  2 +
 arch/arm64/kvm/guest.c                  |  4 ++
 arch/arm64/kvm/inject_fault.c           | 29 ++++++++++++++
 arch/arm64/kvm/mmio.c                   | 27 ++++++++++++-
 arch/arm64/kvm/mmu.c                    | 21 +++++++++-
 arch/arm64/tools/cpucaps                |  2 +
 include/uapi/linux/kvm.h                |  3 +-
 17 files changed, 222 insertions(+), 12 deletions(-)

-- 
2.24.0


