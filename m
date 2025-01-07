Return-Path: <linux-kselftest+bounces-24033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF84A04CE5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 00:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318111628AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4081C1E0E0A;
	Tue,  7 Jan 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0XStQxs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A71A0B08;
	Tue,  7 Jan 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290873; cv=none; b=Kxc9/FQNrtIN6lI0ucUTQ2tbvjv2GrFW4WuE7OD5APkCKjiuy6F59xdlpzMxt/tL9gP3JUb+5oM/mW3GZHtJ2vYA9uPm5IkdoCbeqKeleIw3to0X8Df/x8Ot1TDAti+c+MzLU43Ve/tprRizgX53s6dycdlcmRXyuPodtgaHDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290873; c=relaxed/simple;
	bh=4/74AoE0KevQY71fa48SjfyBNjcL4errS2YyxZ5ajuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oLcBJw5Sy80ZS0T+uW8cYOZZMicutiLOHi7UyfCVHTQ1/Y2/kgb0DejRzfyjB3EPxoZTM63H/Auyq3MgOubU1Fx8lV2anguuQM0Ni5ToEXEJ1kAvtV7elsDA0LC0DJzzWsS6Pe1R5nmBg+VPTGXKcwv8sdqf02vRYNLfcxaefl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0XStQxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB61BC4CED6;
	Tue,  7 Jan 2025 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290872;
	bh=4/74AoE0KevQY71fa48SjfyBNjcL4errS2YyxZ5ajuQ=;
	h=From:Subject:Date:To:Cc:From;
	b=g0XStQxsQUhFJHIe0Y7DbunDOLYpVvdB7P9VqbCxxJ4liGlJZJE5dkf7Ougnm4RGI
	 ep6cjl/vaOthEFMx3RoXsciQEa8KZtrxe8LT+spILQfH/Swnit8nfpdMDKTMjx3ISw
	 yolgzSITIFxRm5aF2OyrjCJ55RbTHl38e8qX22V0F79gddlFMak8o2me3CCjBYkVIg
	 tLvzE1ejxd42IfQrBXm5y1vS9L2AwWKELj/NBfSKUQjFvnR+WMFtKzrsi61MuqbHFi
	 7N69wlQB97gckLt8BVy4nvEIuWT+VjJpdIeNUj0ohM059N9YjzhWnCLLG2hIRA3mKT
	 EFHHeCDVk67/w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 0/5] arm64: Support 2024 dpISA extensions
Date: Tue, 07 Jan 2025 22:59:40 +0000
Message-Id: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANyxfWcC/23OwQrCMAyA4VeRnq0kaddWT76HeMhsp0XdpJWhy
 N7dTgQVd/wD+ZKHyCHFkMVq9hAp9DHHri1RzWdid+B2H2T0pQUBaQRwktPZaDmm9JeYWTpYIlj
 NttFOlLVLCk28vcjNtvQh5muX7q8LPY7TN0YTWI8SJCvnwdXlGrv1MaQ2nBZd2otR6+lLUDAhU
 BFqYwAZK09c/QnqIxCoCUGNP5iddTUy09L+CfpLQJwQdBGg8RqUs8Y39CMMw/AEEHjXCXcBAAA
 =
X-Change-ID: 20241008-arm64-2024-dpisa-8091074a7f48
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4/74AoE0KevQY71fa48SjfyBNjcL4errS2YyxZ5ajuQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnfbIw6kZpk6FmQX8Lcp16zn2VhkK18HvMB9LAKEdz
 eikIoK6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ32yMAAKCRAk1otyXVSH0HVSB/
 9eqUSUIQRfN14xSJQCK2j5joDXhTo8ICd8i/TOuFWQjroSc4fvBWhxpPuIubgie6MmjclU0OdXweic
 CdKYqINBJpMaaCr6UU/3V2ouhN+nJp2Z5ju+2IXc0ocyXgZHYemtqGb2fSIct9G73RIG7hl0iGEl0+
 buHtdVxVgjTOLQSAirhf93+M0f3auRTMBcYHKI/5ngMDE5WjRiXNNp+XtFrr7+5rZAlB7kQIzfuMgf
 IFH91K6VvotQrd2pc0EXSb/sF/9GNC1ugxkLQiF6NYVY/yrUOXdlcwuJvl7c6VSCHRvwGSCYB1OP42
 Coz+ZZdiFPOOJhXaEWN9zuItopz7ci
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 architecture release includes a number of data processing
extensions, mostly SVE and SME additions with a few others.  These are
all very straightforward extensions which add instructions but no
architectural state so only need hwcaps and exposing of the ID registers
to KVM guests and userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v5:
- Rebase onto arm64/for-next/cpufeature, which incorporates most of the
  sysreg updates from earlier versions.
- Remove SF8MM8 and SF8MM4 register defintitions which were removed from
  the ISA in the 2024-12 XML release, along with their associated hwcaps.
- Incorporate Marc's fix for SVE hwcaps on SME only systems and update
  the hwcaps for the newly added features to follow the same pattern.
- Link to v4: https://lore.kernel.org/r/20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org

Changes in v4:
- Fix encodings for ID_AA64ISAR3_EL1.
- Link to v3: https://lore.kernel.org/r/20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org

Changes in v3:
- Commit log update for the hwcap test.
- Link to v2: https://lore.kernel.org/r/20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org

Changes in v2:
- Filter KVM guest visible bitfields in ID_AA64ISAR3_EL1 to only those
  we make writeable.
- Link to v1: https://lore.kernel.org/r/20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org

---
Marc Zyngier (1):
      arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented

Mark Brown (4):
      arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601 2024-12
      arm64/hwcap: Describe 2024 dpISA extensions to userspace
      KVM: arm64: Allow control of dpISA extensions in ID_AA64ISAR3_EL1
      kselftest/arm64: Add 2024 dpISA extensions to hwcap test

 Documentation/arch/arm64/elf_hwcaps.rst   |  89 +++++++++--
 arch/arm64/include/asm/hwcap.h            |  15 ++
 arch/arm64/include/uapi/asm/hwcap.h       |  15 ++
 arch/arm64/kernel/cpufeature.c            |  71 +++++++--
 arch/arm64/kernel/cpuinfo.c               |  15 ++
 arch/arm64/kvm/sys_regs.c                 |   6 +-
 arch/arm64/tools/sysreg                   |  26 +++-
 tools/testing/selftests/arm64/abi/hwcap.c | 235 +++++++++++++++++++++++++++++-
 8 files changed, 441 insertions(+), 31 deletions(-)
---
base-commit: d66e21d59ed0e043e68ef8c6541c1e9f1a962614
change-id: 20241008-arm64-2024-dpisa-8091074a7f48

Best regards,
-- 
Mark Brown <broonie@kernel.org>


