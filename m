Return-Path: <linux-kselftest+bounces-23131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F39EC13B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065F2282A86
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E56A33B;
	Wed, 11 Dec 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIPt9K6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ACB3A8CB;
	Wed, 11 Dec 2024 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879065; cv=none; b=fl3Dda40S61SWuigL2UmOJssWBfWjLZvM4FfEhklLHuAMv8dYD0VasaHX+sGsMhj8jxfaXamuQF3y39+6mDaChoi3PgCewUHlVwtl9gNI4XBDRG1f22I6l4oUznfkYAo5b1RRUOlCx//3gvMqN9bJF6g9uHtwdIgUO3pUmnEkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879065; c=relaxed/simple;
	bh=jLX4rlgMDPCJWTDHkPE3yprw7Tf6zXMkVO5ew0qsRzg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AR9bTzEdWWgVU0RMumAhHeOntdwPxfipoTDtbP7gsj5tKW8okjsMw7I6d69hMOPvDsnFEp1TqPC4+AumlSfNxh0hKMPcjCZjUSwKNcSGppgVsYxdmJYybgz2F11x5JQ4rd+Vtcr0IJPEuIvyWRXfSp2O4TRmToDxAvCAEpAzDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIPt9K6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881E8C4CED6;
	Wed, 11 Dec 2024 01:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879065;
	bh=jLX4rlgMDPCJWTDHkPE3yprw7Tf6zXMkVO5ew0qsRzg=;
	h=From:Subject:Date:To:Cc:From;
	b=VIPt9K6avZPGcJX95i8dZcZr4WHiFeI8pQWxYiEQ1IxNs3eY2ofLeuQAKXbWBYM9/
	 sQmT5tfAA3Oc40yH+mwcwBsGb8iq3PvNUTjff3ekPbZ2fDCKO6XKQqfvWpVRWQ75Fh
	 SQQrQNXbR1TGoxJ6cZKWhXuhsIfPWFCmS7+DLxYFa+ItGPmwLy5JSnQ8GzhUxdg7sp
	 dPVdyiUY+zBuDQ2Y7sUv4SQ6LoWndxj/YiGWvlUbC3oGA+zkx8NF+80L15nyCD7+/l
	 vBFD9Xr+9ttQQ4/HymTlKu/TtpjxUoGkJ4NW9Ift8s+I7zaF6hwGR+G3aZSHwUYD+u
	 41qwgAo9MsEHw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/9] arm64: Support 2024 dpISA extensions
Date: Wed, 11 Dec 2024 01:02:45 +0000
Message-Id: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXkWGcC/23OSw6CMBCA4auQrq2ZPmiLK+9hXAxQoFGBtIZoC
 He3JSZqZPlPMt/MTIL1zgZyyGbi7eSCG/oYcpeRqsO+tdTVsQkHLhmAoehvStKUtB5dQGqgYKA
 l6kYaEtdGbxv3WMnTOXbnwn3wz/XCxNL0jfENbGIUKApTgynjNTTHi/W9ve4H35KkTfxLELAh8
 CiUSgFDltcc8z9BfAQOYkMQ6QdVaVMyRF7oH2FZlheedAloNQEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jLX4rlgMDPCJWTDHkPE3yprw7Tf6zXMkVO5ew0qsRzg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUOpUj1V2UXYPLuLrtYppEWr2dhV1p85fuVagzR
 gYNQooeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlDgAKCRAk1otyXVSH0BzyB/
 9GDTPkWnyb41SmxP3yIFjbgzxKspUYlH7g5GhliS3owYK1Zp6vFQGZ+qQHXW1QyBWYhXoYm+gPcNW3
 tApSmN4cH8lEJW21vvhZelgf5FsSNTfv7axUvnrNsTdqfFX0SqT/YUbMWc8A7Vq6drXVOiWBRkn2dP
 /nTdH+5hSEAxf/rb0Hj7a698k5s6+dxkGERVWV06OvuBtnjvPBXiN695n1RY6tQOS3ZbRAk+XZ+nGd
 7NUwOHysJDA7vQEQsQ4YSXl10w2jSHvSpFn7Kr6Lh9ps4s5yeMj6ihPa8LK/HXbt9SfJMFgu9zRPQL
 1Yrcan4GgMgqPM+IKvJhVzUBxGL19i
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2024 architecture release includes a number of data processing
extensions, mostly SVE and SME additions with a few others.  These are
all very straightforward extensions which add instructions but no
architectural state so only need hwcaps and exposing of the ID registers
to KVM guests and userspace.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
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


