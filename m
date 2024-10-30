Return-Path: <linux-kselftest+bounces-21132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA39B6804
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859032845C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCC213143;
	Wed, 30 Oct 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOW/D+Eb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114138F91;
	Wed, 30 Oct 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302828; cv=none; b=tLoM5qF3iWUxLQ2sfN0yT9EMDLn56T470WHOI1/MzFlKQKeacwNqb021PwncOfghPD43wM+5/ZtEC/urKeSxTFTkjs2W0pHHi6mLe7uqEx/eianTtOZQrvNQ7yDAQoAu1MtZ7LJ+NpKWMYb7wjICXZfLkIhaj1zSKCXV8/o0cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302828; c=relaxed/simple;
	bh=Bl+5Ay3FFAKvbhH35eUMEt83qx9zkSG64B9jfI7uxUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FVPf673RpJ7Af3aF/WqofAWlxTVaQ0bFqECnYxWbmOAPCejc5haXnygmGNHjItqL5HIq6Me7FVretV/fPL3FUevdwsFUJdcGSo1usjNHbzcLD39oODljUdnMNMjSeCiYA8xp/R75pdAERKweOokQs7J/UFz6f601q3QdMZ/xVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOW/D+Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F60BC4CECE;
	Wed, 30 Oct 2024 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302828;
	bh=Bl+5Ay3FFAKvbhH35eUMEt83qx9zkSG64B9jfI7uxUM=;
	h=From:Subject:Date:To:Cc:From;
	b=qOW/D+EbmBVAn7zk80NEXzG8+OmGSsRUnuuO5kc7a373sZbp/9JOtuhn8iwKC9d93
	 RTNm7dSttbfV/68DueQWTmBZcGyqm5iEJbHT9xqTQiQfMEuFmfeOnDSuYWrlCFu9IG
	 7oNHtYRDrj4W1QUdwddUEMXKoDJVnOxXcuk/WJxr1LsDFlh3zY6fNfJzt1wZMN9thQ
	 9MwNkmckzyGdyKPtYsVrXdJXipUMZ2CQzSSOb0J6y68haSxRl97BeL9/D4nXCVlTSU
	 vDZKc8uvM+x6HqDgA7+6t1WfT2Q9fwvuRYe+MEZxSB4bIAo/9e1G4N0qDUQIl4WtjI
	 B4+3+0VhYQEnQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/9] arm64: Support 2024 dpISA extensions
Date: Wed, 30 Oct 2024 15:34:45 +0000
Message-Id: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVSImcC/22NQQ6CMBBFr0Jm7ZhpbaS64h6GRZUBJiolU0M0h
 LtbiEuX7yf/vRkSq3CCczGD8iRJ4pDB7gq49WHoGKXJDJasM0Qegz6PDlfEZpQU0NPJUOlC2To
 P+TYqt/LelJc6cy/pFfWzFSazrj+Z/SObDBKGg2/IX3Mt+OrOOvBjH7WDelmWL8HYHB6xAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Bl+5Ay3FFAKvbhH35eUMEt83qx9zkSG64B9jfI7uxUM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNhsrSy+xHNERieWXqP1j/YLwVf78bhUbTyAurw
 QfZkv3WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTYQAKCRAk1otyXVSH0BrECA
 CB6c/mPpV22NP6+WBfhlhYwKlwBchS7yWzpSBftwPoSuYGS0t4BoON04mg80CKZZ77jSxS2kBkPehz
 kyddpgAq8Ox3wQxlE98z5L7tyQZEantMU8PD3ETBZw6aQaXKuBT4YeYFwvl2sKRnzw47NzWA27z1/k
 dNbgFlS22UXo5xRxEVqY50qFuR95vOWZULgDA5NaLG7Nj0Yg9iQVo44Fbk2GanuB1+P0UB4JVdVdRY
 rW7AC78fY5NRsevuhLVA7AsNj82qqf4f/3LQGAu5cHIZvTxYqpa780AgZCaAZTqpGBUSJdHbyJhDR8
 kFD1bJxDlLQyReI4OogHPtyEHlgN96
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 architecture release includes a number of data processing
extensions, mostly SVE and SME additions with a few others.  These are
all very straightforward extensions which add instructions but no
architectural state so only need hwcaps and exposing of the ID registers
to KVM guests and userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241008-arm64-2024-dpisa-8091074a7f48

Best regards,
-- 
Mark Brown <broonie@kernel.org>


