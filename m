Return-Path: <linux-kselftest+bounces-22677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5D39E04E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 15:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6702B61998
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6C2036FE;
	Mon,  2 Dec 2024 13:56:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226A202F95;
	Mon,  2 Dec 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147761; cv=none; b=ZMUHdiMwl+5oat33mL3RsiYEFfWPfb2hjU2z9YHQtn1xYbeXiQCDdM+qPTPOm1AjlsSep4rErJ5eK3bdpK+FZ7T0wdb/iPL4sFUpXZfZGoJPAFqXk4JiZC6nXBX17ZS2J/NQ0L5swR14Yqwn0c/Ne8Tr8vLR+GwNVm0lD4IeSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147761; c=relaxed/simple;
	bh=E53zZjd6flzuqs7YV+RgWw0eJj3bkXNqsocCztsJtfA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNaC0ONyJEVuxRRWQe/+S7EbHfmRt+PeDCD52VXsb8rDkSfKlTFDbSe3QZX5O6brm161qJn0pAIKfK417T4ATgGv4LXpUB7s+6AxRTXPjEmSlmDk0iliBoZxWhfq5k/wiHF75bNebrDxo604CFwcfcc25+poKEfBvqWxWJSi2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y24yh36hqz21mLK;
	Mon,  2 Dec 2024 21:54:20 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id ADF711A0188;
	Mon,  2 Dec 2024 21:55:55 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 2 Dec 2024 21:55:54 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 0/5] Add support for FEAT_{LS64, LS64_V, LS64_ACCDATA} and related tests
Date: Mon, 2 Dec 2024 21:54:59 +0800
Message-ID: <20241202135504.14252-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Armv8.7 introduces single-copy atomic 64-byte loads and stores
instructions and its variants named under FEAT_{LS64, LS64_V,
LS64_ACCDATA}. Add support for Armv8.7 FEAT_{LS64, LS64_V, LS64_ACCDATA}:
- Add identifying and enabling in the cpufeature list
- Expose the support of these features to userspace through HWCAP3
  and cpuinfo
- Add related hwcap test
- Handle the trap of unsupported memory (normal/uncacheable) access in a VM

A real scenario for this feature is that the userspace driver can make use of
this to implement direct WQE (workqueue entry) - a mechanism to fill WQE
directly into the hardware.

This patchset also depends on Marc's patchset[1] for enabling related
features in a VM, HCRX trap handling, etc.

[1] https://lore.kernel.org/linux-arm-kernel/20240815125959.2097734-1-maz@kernel.org/

Tested with updated hwcap test:
On host:
root@localhost:/# dmesg | grep "All CPU(s) started"
[    1.600263] CPU: All CPU(s) started at EL2
root@localhost:/# ./hwcap
[snip...]
# LS64 present          
ok 169 cpuinfo_match_LS64
ok 170 sigill_LS64
ok 171 # SKIP sigbus_LS64
# LS64_V present
ok 172 cpuinfo_match_LS64_V
ok 173 sigill_LS64_V
ok 174 # SKIP sigbus_LS64_V
# LS64_ACCDATA present
ok 175 cpuinfo_match_LS64_ACCDATA
ok 176 sigill_LS64_ACCDATA
ok 177 # SKIP sigbus_LS64_ACCDATA
# Totals: pass:92 fail:0 xfail:0 xpass:0 skip:85 error:0

On guest:
root@localhost:/# dmesg | grep "All CPU(s) started"
[    1.375272] CPU: All CPU(s) started at EL1 
root@localhost:/# ./hwcap
[snip...]
# LS64 present
ok 169 cpuinfo_match_LS64
ok 170 sigill_LS64
ok 171 # SKIP sigbus_LS64
# LS64_V present
ok 172 cpuinfo_match_LS64_V
ok 173 sigill_LS64_V
ok 174 # SKIP sigbus_LS64_V
# LS64_ACCDATA present
ok 175 cpuinfo_match_LS64_ACCDATA
ok 176 sigill_LS64_ACCDATA
ok 177 # SKIP sigbus_LS64_ACCDATA
# Totals: pass:92 fail:0 xfail:0 xpass:0 skip:85 error:0

Yicong Yang (5):
  arm64: Provide basic EL2 setup for FEAT_{LS64, LS64_V, LS64_ACCDATA}
    usage at EL0/1
  arm64: Add support for FEAT_{LS64, LS64_V, LS64_ACCDATA}
  kselftest/arm64: Add HWCAP test for FEAT_{LS64, LS64_V, LS64_ACCDATA}
  arm64: Add ESR.DFSC definition of unsupported exclusive or atomic
    access
  KVM: arm64: Handle DABT caused by LS64* instructions on unsupported
    memory

 Documentation/arch/arm64/booting.rst      |  28 +++++
 Documentation/arch/arm64/elf_hwcaps.rst   |   9 ++
 arch/arm64/include/asm/el2_setup.h        |  26 ++++-
 arch/arm64/include/asm/esr.h              |   8 ++
 arch/arm64/include/asm/hwcap.h            |   3 +
 arch/arm64/include/uapi/asm/hwcap.h       |   3 +
 arch/arm64/kernel/cpufeature.c            |  70 +++++++++++-
 arch/arm64/kernel/cpuinfo.c               |   3 +
 arch/arm64/kvm/mmu.c                      |  14 +++
 arch/arm64/tools/cpucaps                  |   3 +
 tools/testing/selftests/arm64/abi/hwcap.c | 127 ++++++++++++++++++++++
 11 files changed, 291 insertions(+), 3 deletions(-)

-- 
2.24.0


