Return-Path: <linux-kselftest+bounces-6787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A4890EFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041E91F23867
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0A4A3D;
	Fri, 29 Mar 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuX5Q4Ik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9EEA29;
	Fri, 29 Mar 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671235; cv=none; b=aO5MfWuV94XhRxD8Ji7DtGKWLdJNVdSfSHRZU/q/mrEC5TT/waO1UrQp1lb9NZcc4598UgYhXhvzDv4hwVYSfOPpeaIs/Dwvb6e02D29VpM0LATEGlpytoDjr5w/qFkEGW3S8eLSCx+PE0Kh0qs6+9p1UGvRdcMfAV9yQ9/CGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671235; c=relaxed/simple;
	bh=WaKteGNUZ/NFFEBoV918r7uJ9rXae9sVwJg6sjxhGbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=esVaTMHSnYhGApuOM+HmD0zOl0hKiDNwdqA96R1JdCoRlvdRwMshnsWKLlKnculmVB5Cnamy0KpGwJex1aTmNSQ9EwBP7y+IgJPA0+fOAIFOOf0ZAWAu2NoX1AI5zARtydkk1OwxMbCqejkdhLFV5mYRTRMpisdIAvKPmiZgEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuX5Q4Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18CEC433C7;
	Fri, 29 Mar 2024 00:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671234;
	bh=WaKteGNUZ/NFFEBoV918r7uJ9rXae9sVwJg6sjxhGbw=;
	h=From:Subject:Date:To:Cc:From;
	b=kuX5Q4IkEeEaR/oS6zXwUH4ubqqp6YCgizU0yk5+deofn+YXBfRHnf46itFog4OUU
	 hZvPZyPx9/SubnZGE7jE7diObsfEFrzNAeDyLmp5Hyq2FVYncxlLIm9aCH/KvTM+AS
	 I27Q+/qK1CHRRgGWT7FIuuMbvJJebTMTkqIGeIcDago/poV2bpUL/ky9P7McOrijjq
	 gHdVJ92tS6pWE9PhtYJHqDEJYBKcCv9MHUrd6rfNPokrKYK5uREakM5jh+FMVG5GUS
	 hmafnX76XNHxvVXR2gspAlCjbhOvqE7oxjpcUHPvhdOHH3+4QI/dcEXrf4wFv0jtHx
	 Oq8wadNHMUGTw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 0/5] KVM: arm64: Support for 2023 dpISA extensions
Date: Fri, 29 Mar 2024 00:13:41 +0000
Message-Id: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUHBmYC/23QS2rEMAwG4KsMXtdFluVHuuo9SheOrcyYtslgl
 9Ay5O51hpZAk4UWv0CfhG6icslcxdPpJgrPueZpbME+nES8hPHMMqeWBQJqBaBlKB+W5BpluuY
 aJA46oXFkyZFoY9fCQ/66ky+vLV9y/ZzK933DrNbuL4Z2j81KgvTkIKXOd32Pz29cRn5/nMpZr
 NqMm6AUHQjYBHJolO9osMHvBL0JCOZA0E1Ifexj8tYFN+wE+hMIFOKBQE1wzjJ05K1Ke8Fsgoa
 jP5gmRGM9p9jq3w3LsvwA40aa6bkBAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2988; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WaKteGNUZ/NFFEBoV918r7uJ9rXae9sVwJg6sjxhGbw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmBge6b1dMM99N8t/UdqYyloY6+6oVeNZr+0mCG0iK
 cM25EaqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgYHugAKCRAk1otyXVSH0Oa9B/
 9xM8b3qsLcPZzl+tOQkQVDP78MiPgRLRAwyT9YSUS7v4si4z9EMCibX/Wb5OtRS8w+SAnbkcLXKUoK
 BW0H3zZtUlGWa2gm/xJYzSSD9HSM/7XslxGkYPwcXiZyVBn7k6PdSdapDdGmqyTNZJQtbl+CG8b2M0
 Hyw82EZvE/hR58v1RU5ooeHvjgll+xO4YtJlrKR/FxPRroqi9StmZvEeo14AwrkLybv4K0e33heaoZ
 8UNSBxH1W2VubJAQVtMtqOvzB6/Oqx5BCm4kOdaQtqa7DwzNyeQfa+qFoQD+/U1uoshY75K2RuJdzH
 Ju7mK4CMrWahCyc04g12i7WHWz/PlV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series implements support for the 2023 dpISA extensions in KVM
guests, it was previously posted as part of a series with the host
support but that has now been merged so only the KVM portions remain.

Most of these extensions add only new instructions so the guest support
consists of adding the relevant ID registers, masking out other features
like the 2023 MTE extensions.  

FEAT_FPMR introduces a new system register FPMR to the floating point
state which we enable guest access to and context switch when the ID
registers indicate that it is supported.  Currently we implement
visibility for FPMR with a fpmr_visibility() function as for other
system registers, I will separately look into adding support for
specifying this in the struct sys_reg_desc.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v6:
- Rebase onto v6.9-rc1.
- The host portions of the series were merged so only the KVM guest
  support remains.
- Link to v5: https://lore.kernel.org/r/20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org

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
Mark Brown (5):
      KVM: arm64: Share all userspace hardened thread data with the hypervisor
      KVM: arm64: Add newly allocated ID registers to register descriptions
      KVM: arm64: Support FEAT_FPMR for guests
      KVM: arm64: selftests: Document feature registers added in 2023 extensions
      KVM: arm64: selftests: Teach get-reg-list about FPMR

 arch/arm64/include/asm/kvm_host.h                  |  6 ++++--
 arch/arm64/include/asm/processor.h                 |  2 +-
 arch/arm64/kvm/emulate-nested.c                    |  9 ++++++++
 arch/arm64/kvm/fpsimd.c                            | 15 +++++++-------
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  9 ++++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  4 ++--
 arch/arm64/kvm/sys_regs.c                          | 24 +++++++++++++++++++---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 11 ++++++++--
 8 files changed, 60 insertions(+), 20 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20231003-arm64-2023-dpisa-2f3d25746474

Best regards,
-- 
Mark Brown <broonie@kernel.org>


