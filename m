Return-Path: <linux-kselftest+bounces-22736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5A9E1D39
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AB8B48233
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BEB1F7073;
	Tue,  3 Dec 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHwue4hi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91001F706A;
	Tue,  3 Dec 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229823; cv=none; b=jthcY/89vxSPx7nRwaG/McX4FWpiIU9j9WWVEOIFHShFsUT12dF5gnF3Jc5tmRLnm5WwsfsnfjOIs97PBNqdczV03ayjQaLY5MB4LuJ8yTP4guUuNGgmP0TX9yoo++ZvypZU5NvGI+RoAkeDwBvYfyz/5qa7zEt+qoT1sBBYlsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229823; c=relaxed/simple;
	bh=IZV9ZhzHqJVnEKcJxYKcUwlnmw8jFD+SNDgdQoZo3EE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KEREwH+uJytMK5FQeu4LAQQibEzBSXMspTP0P/zxiKZK+TT1Ks1FYek59z8ulGqwDK0yjtPxbOGo3oDRE4Uj9GJSng+WoXsHxPWU+/6wZWuMsOy2mxI3BYvH5EbxmJa+U9ibZy7pcP4pu/IGUC75kP9Ve/4gPRr6Aw5gq2BDC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHwue4hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F70C4CECF;
	Tue,  3 Dec 2024 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229822;
	bh=IZV9ZhzHqJVnEKcJxYKcUwlnmw8jFD+SNDgdQoZo3EE=;
	h=From:Subject:Date:To:Cc:From;
	b=eHwue4hiGhU7+JckTcKQExSjN39OQ+LcvCPsrbvsG3Jtl+C7Wc613FxEoPK2RFTVS
	 2Kva0TyImTcKhid1jZGB2I1/sw+0+YfrDr3wSW6xIXxyNEw5rkEED3PNpR6FP9+4LE
	 znyOfQ24Z4h3Tx4sGDEvnUM8BIfdNQLYj88/5OclsfM8E4LeisndOHUyn/EEkJ9/Vv
	 RRMaYeCaKL6UfOg10+pR20bEVVqXJiKwiWrZhNbGNlWMTfywM0hfddWSYBNGfwq8Sx
	 5RoIC6AoK4kjlnUmrTQZKhzSZBwoLQ67eo7UM3SlnL6hh1hYx4z8+DragFyQmrxBRR
	 H3ftvuhaDc+sA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/9] arm64: Support 2024 dpISA extensions
Date: Tue, 03 Dec 2024 12:39:19 +0000
Message-Id: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPf7TmcC/23NQQ6CMBCF4auQWTtmWgpUV97DuBhsgUYF0ppGQ
 7i7hbjQhOU/yXxvgmC9swGO2QTeRhfc0KfIdxlcO+5bi86kBklSCSKN7B+lwiXRjC4wajoIqhR
 XjdKQ3kZvG/dayfMldefCc/DvdSGK5frF5AYWBRJyrg3pOq2xPt2s7+19P/gWFi3KHyGnDUEmo
 S5LEiwKI7n4E+Z5/gCfvkMD8wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IZV9ZhzHqJVnEKcJxYKcUwlnmw8jFD+SNDgdQoZo3EE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvzz7hlUQbTGXweDHSxiaLyo/jZx/81Z2eBMmkqR
 OhrG3nyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0788wAKCRAk1otyXVSH0Kd0B/
 9wcLjxF+pY4wnLffdC8iHWzfQtl+IDjeHS7OvcKXcadzjW9nOFTjtmZYB3DN02HxbBNRU6O0V5vSnC
 luo2DkfmzB4DWPIcVCdmaIqEO1xEZEfIZ8dS7yFF9Z/wvmD3neIjP5CV8WZCznY0253/4ghki2s/cq
 KQ/ttPhSqx+3oqOOe3AP9kkWRwa09lJmljZKtBwCmnQWwEHMdtLYgzai5kZB0DXWGg9CRyz3cqxUPf
 IdYlLytkhcnRVJVasl5vzK7PQBUvYQlqFZjJPL9su+Z+O9nt76vQLa248RQjLyKhO+GYd+AbnxpUWO
 MzERraxO3i6lmp/+S6NcHURXTC7XOq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 architecture release includes a number of data processing
extensions, mostly SVE and SME additions with a few others.  These are
all very straightforward extensions which add instructions but no
architectural state so only need hwcaps and exposing of the ID registers
to KVM guests and userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Commit log update for the hwcap test.
- Link to v2: https://lore.kernel.org/r/20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org

Changes in v2:
- Filter KVM guest visible bitfields in ID_AA64ISAR3_EL1 to only those
  we make writeable.
- Link to v1: https://lore.kernel.org/r/20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org

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
 arch/arm64/kvm/sys_regs.c                 |   6 +-
 arch/arm64/tools/sysreg                   |  87 +++++++++-
 tools/testing/selftests/arm64/abi/hwcap.c | 273 +++++++++++++++++++++++++++++-
 8 files changed, 493 insertions(+), 10 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241008-arm64-2024-dpisa-8091074a7f48

Best regards,
-- 
Mark Brown <broonie@kernel.org>


