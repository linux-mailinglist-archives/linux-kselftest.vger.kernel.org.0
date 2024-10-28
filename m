Return-Path: <linux-kselftest+bounces-20839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B99B3BAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4671A1C2221F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A2C1E9083;
	Mon, 28 Oct 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSeYfq1G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B491E766F;
	Mon, 28 Oct 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147184; cv=none; b=tGTef5H/miOEFcb8RuqOnIZc6av0la5vnPAvVzMLuRHjuWZYfTheaU6VIrGtxFN+u0ZPvqLxV4SUpvligs4nFGbZq/uL1rMelZ7afNXXHdgX/dDOuLIdMDWNKKQhN/cUwJGQoOcXZLsEwOZ0DQG/gShhpJA/9CkGcgsCOYSFNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147184; c=relaxed/simple;
	bh=sol/MuipOzf7KPplFOyD2hmajqHTW1hr8fw/YDH04Sw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pQV5IfvWAJpf9k4UY6aSlEQDpEyA00NE5nPcOamXzZAGyl+MFhbc9b6SXaUn6dREks6cNgBf5LcA+NhLMBAfhkzMJRpsAlXKf81giP6nY1beTmtyk7UHZiuMi1uVHSEa1wH+TpEl8lqJ7uwK1/imS9vR2MdcptlBlp3Uh0HdhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSeYfq1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7768AC4CEC3;
	Mon, 28 Oct 2024 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147184;
	bh=sol/MuipOzf7KPplFOyD2hmajqHTW1hr8fw/YDH04Sw=;
	h=From:Subject:Date:To:Cc:From;
	b=YSeYfq1GuuUN74PjNeQwmirBJkoKp/sKxRnF1E0Cnxy/y1QoLmAM2vqqeGHE9VqDr
	 24AYIkLN6LpsE7bzTaIbUdsFgKjnReK2OgfaOgRW5hxOcDVzNXaS3i3cgGk1wXaaul
	 r1wlMOU1pRtvOgrZBVgnvUszYGAWfdhP9fqsqdr2zYnuEDxDOAbbtm7usJX9zzv2oH
	 912tL0BaXFWuCmy/tbYZvRaCjB6yl81KS5PBdTRFJXggknNLWr7Y6U4YbYk/Io+fXI
	 LZEOjy5wj/rk9qBqs6z9g8a2dxjAN5hXmx6kYDKFHOCwG4RC3d4jo/Ip2lIm9rmdTS
	 2FXDR7Le6+nvQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/9] arm64: Support 2024 dpISA extensions
Date: Mon, 28 Oct 2024 20:24:09 +0000
Message-Id: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOryH2cC/x3MQQqAIBBA0avErBsYQ9K6SrSQGmsWWShEIN49a
 /kW/2dIHIUTjE2GyLckOUOFahtYdhc2RlmroaNOKyKLLh69xo+4XpIcWhoUGe2M1xZqdkX28vz
 LaS7lBStH7MRiAAAA
X-Change-ID: 20241008-arm64-2024-dpisa-8091074a7f48
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sol/MuipOzf7KPplFOyD2hmajqHTW1hr8fw/YDH04Sw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/Nlf7bEh5sJxyS9APvTiice6ZVXCG3VF3/2rCov
 VfneMG+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zZQAKCRAk1otyXVSH0Dy2B/
 wOJiOkm/F/QceJ5m1SqfcfVDltQ/WB5NLgUx/abPOvKJKrbmWPOVlM4ZOcWcoqqwm2WUnLTJinRb6D
 Yrk0wRqPes1owib+tQ9R4rxSXf5pOUI0d1/DzGdycCoMa4QUmrMSYBlvAAIerccegORPfVM/lL5YxG
 PzZ7UhJatVuiXQyhCOb/8kB98i26M6ojfWJXd6gMxUI1eRRgIAEdQ0wqmQq5QIHJilv/Hn/UHB5/Qi
 nUG1pfjtnTrYw68Py5XqNo0+tE24AhPFSxitA88NKsolV34Po9NAz9/wdhSxQBKlHiSh21iaPaMQIr
 HPhCbK9eSGiCoQ/zjsALkEuGLYb77P
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 architecture release includes a number of data processing
extensions, mostly SVE and SME additions with a few others.  These are
all very straightforward extensions which add instructions but no
architectural state so only need hwcaps and exposing of the ID registers
to KVM guests and userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (9):
      arm64/sysreg: Update ID_AA64PFR2_EL1 to DDI0601 2024-09
      arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601 2024-09
      arm64/sysreg: Update ID_AA64FPFR0_EL1 to DDI0601 2024-09
      arm64/sysreg: Update ID_AA64ZFR0_EL1 to DDI0601 2024-09
      arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601 2024-09
      arm64/sysreg: Update ID_AA64ISAR2_EL1 to DDI0601 2024-09
      arm64/hwcap: Describe 2024 dpISA extensions to userspace
      KVM: arm64: Allow control of dpISA extensions in ID_AA64ISAR3_EL1
      kselftest/arm64: Add 2024 dpISA extensions to hwcap test

 Documentation/arch/arm64/elf_hwcaps.rst   |  51 ++++++
 arch/arm64/include/asm/hwcap.h            |  17 ++
 arch/arm64/include/uapi/asm/hwcap.h       |  17 ++
 arch/arm64/kernel/cpufeature.c            |  35 ++++
 arch/arm64/kernel/cpuinfo.c               |  17 ++
 arch/arm64/kvm/sys_regs.c                 |   3 +-
 arch/arm64/tools/sysreg                   |  87 +++++++++-
 tools/testing/selftests/arm64/abi/hwcap.c | 273 +++++++++++++++++++++++++++++-
 8 files changed, 490 insertions(+), 10 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241008-arm64-2024-dpisa-8091074a7f48

Best regards,
-- 
Mark Brown <broonie@kernel.org>


