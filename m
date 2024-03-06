Return-Path: <linux-kselftest+bounces-6020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906F87439E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7326B21DA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C091C6B4;
	Wed,  6 Mar 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umFp+x8m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A11BF40;
	Wed,  6 Mar 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766925; cv=none; b=OJe7bUka/Cuexzw661Iu/9J+REJrKAsUHNf1KHilGi1TMJDjJWLMEPQdrnpMm4LiJ+BBEDnlLdSVv6gyk5f0fgK566eeQBJS/X5lvenTes2fZqNs3JXS1W4/9BhtY+mZskL7qvTa/U74wOGLpoBlw/VLUjfoQIcurfDf+WBv7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766925; c=relaxed/simple;
	bh=hVYfvyWt2Y75bJeV4nbC5bLWMRIModbsxKyhoExAj58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l/2TqgkbrVdaXVPQOgYZitrjUWuHSyNDndS9yaCoxdnfirqgL60o779XFUUjTCbIGx7hsQVqWajiJzd6zq0J6iXrbr7x56TnF7F+1ZuJwx4/j+uIzFGQqVYgr4dAHDtG9fzIQ1jNJUz6CXWEzNvkxX91zG1kCHcCRO8IcknbeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umFp+x8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E64C43390;
	Wed,  6 Mar 2024 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766923;
	bh=hVYfvyWt2Y75bJeV4nbC5bLWMRIModbsxKyhoExAj58=;
	h=From:Subject:Date:To:Cc:From;
	b=umFp+x8mmmwKh5Ibc8r/84NYhN0tSs/nsPNty84UvAJBWEtJTRIFaejJb3lc/NiD3
	 QfUJcTGPFKBGVeO+kYDZoszlqlGykYo0vjNc6kb5ri0NrAKMqfHYP19I72IZVkdgX3
	 GTO2oquiM9bXn+u0QlXHnm4pI0DXuwRg+KnWTxH4GbCNYCekx2BzXWn820h9H6JNf1
	 wfoZ7Mq11GH5R2OtpoNZkfHkAEhCzgVdooRR2cucuHRCkLxjcYVQYETp915gtRBzkt
	 LHHeXrLR2J4okSCorIuIBHxsj9btnBzrsNAaP/PZf6/wwMZ5mVD6WITnCvEw3L+nEa
	 Y0nNrtKtyQ6Dg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 0/9] arm64: Support for 2023 DPISA extensions
Date: Wed, 06 Mar 2024 23:14:45 +0000
Message-Id: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOX46GUC/23N0QrCIBTG8VcZXmfo8UxdV71HdOGma1JtQ0OK2
 LvnoojYLv8fnN95kuiCd5HsiicJLvnohz5HuSlI05n+5Ki3uQkwEJwxQU24SqRzUjv6aCi0wkK
 pUKJCks/G4Fp/f5OHY+7Ox9sQHu8Pic/rBwO5xBKnjGpUzNpKV3UN+7MLvbtsh3Ais5bgJ3COK
 wJkARWUXFfYSqMXgvgJwMoVQWTB1k3dWC2VUe1CwK+AjAOsCJgFpaRjFWrJ7b8wTdMLoXy8Snc
 BAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3927; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hVYfvyWt2Y75bJeV4nbC5bLWMRIModbsxKyhoExAj58=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkAd6j3trVRH3TryRsMJsSJpFXc/h6DInBNgN/X
 TYlUskaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5AAAKCRAk1otyXVSH0MLpB/
 9aYoLdvnNvFjJfLHpXdTOuk1B2GKeK5b+uPqY6LiTUy/oyqNPC91J9LRXOsbtJWz5I2oQ7+QKfp4+N
 bmZC2JrSKSEFEV5towSsOQYLcFz78Rxnt4BBIVuAvFNcW/SR6Cn3vi5uU0nMsTNDwK/K+oPInuV4ch
 s+gzWSwvmU+VNFIm087gKRMxfmkUMsc1YXD80UcPztVmP9+uXEzy3nzMMpootzpxiLeAiijMEsiI/u
 hNeISZ66rUZ6ZcmlHjlwcS+UQg4vzGm2AQfpeJGC7UJa6r+rrKok/ZJLPwSXqymZTOvbGVIfb/V3vR
 jPCEslf9X909MXtzw8dxKCI3OEb8J2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series enables support for the data processing extensions in the
newly released 2023 architecture, this is mainly support for 8 bit
floating point formats.  Most of the extensions only introduce new
instructions and therefore only require hwcaps but there is a new EL0
visible control register FPMR used to control the 8 bit floating point
formats, we need to manage traps for this and context switch it.

Due to the very recently merged KVM changes for configuring guest
features via ID register writes only being available in -next the
support for guest state has been dropped for this version, the relevant
KVM interfaces should all be there after the merge window so the code
will be refreshed for the new interfaces then.

I've not added test coverage for ptrace, my plan is to add support to
fp-ptrace (which is now merged so I'll update after the merge window).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v5:
- Rebase onto v6.8-rc3.
- Use u64 rather than unsigned long for storing FPMR.
- Temporarily drop KVM guest support due to issues with KVM being a
  moving target.
- Link to v4: https://lore.kernel.org/r/20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org

Changes in v4:
- Rebase onto v6.8-rc1.
- Move KVM support to the end of the series.
- Link to v3: https://lore.kernel.org/r/20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org

Changes in v3:
- Rebase onto v6.7-rc3.
- Hook up traps for FPMR in emulate-nested.c.
- Link to v2: https://lore.kernel.org/r/20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org

Changes in v2:
- Rebase onto v6.7-rc1.
- Link to v1: https://lore.kernel.org/r/20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org

---
Mark Brown (9):
      arm64/cpufeature: Hook new identification registers up to cpufeature
      arm64/fpsimd: Enable host kernel access to FPMR
      arm64/fpsimd: Support FEAT_FPMR
      arm64/signal: Add FPMR signal handling
      arm64/ptrace: Expose FPMR via ptrace
      arm64/hwcap: Define hwcaps for 2023 DPISA features
      kselftest/arm64: Handle FPMR context in generic signal frame parser
      kselftest/arm64: Add basic FPMR test
      kselftest/arm64: Add 2023 DPISA hwcap test coverage

 Documentation/arch/arm64/elf_hwcaps.rst            |  49 +++++
 arch/arm64/include/asm/cpu.h                       |   3 +
 arch/arm64/include/asm/cpufeature.h                |   5 +
 arch/arm64/include/asm/fpsimd.h                    |   2 +
 arch/arm64/include/asm/hwcap.h                     |  15 ++
 arch/arm64/include/asm/kvm_arm.h                   |   2 +-
 arch/arm64/include/asm/kvm_host.h                  |   1 +
 arch/arm64/include/asm/processor.h                 |   4 +
 arch/arm64/include/uapi/asm/hwcap.h                |  15 ++
 arch/arm64/include/uapi/asm/sigcontext.h           |   8 +
 arch/arm64/kernel/cpufeature.c                     |  72 +++++++
 arch/arm64/kernel/cpuinfo.c                        |  18 ++
 arch/arm64/kernel/fpsimd.c                         |  13 ++
 arch/arm64/kernel/ptrace.c                         |  42 ++++
 arch/arm64/kernel/signal.c                         |  59 ++++++
 arch/arm64/kvm/fpsimd.c                            |   1 +
 arch/arm64/tools/cpucaps                           |   1 +
 include/uapi/linux/elf.h                           |   1 +
 tools/testing/selftests/arm64/abi/hwcap.c          | 217 +++++++++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          |  82 ++++++++
 .../selftests/arm64/signal/testcases/testcases.c   |   8 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 23 files changed, 619 insertions(+), 1 deletion(-)
---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20231003-arm64-2023-dpisa-2f3d25746474

Best regards,
-- 
Mark Brown <broonie@kernel.org>


