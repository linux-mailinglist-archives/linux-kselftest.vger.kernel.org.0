Return-Path: <linux-kselftest+bounces-36469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A9AF7DCC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823135421C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF924EAB2;
	Thu,  3 Jul 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBUEAZ87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1B24DD0C;
	Thu,  3 Jul 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560007; cv=none; b=UD7it9fJEviHrUcmKDEoFscMmM5ssR2EIPKed6BcrF5XDzgRBSUQIyWhEQu6eAVV2cJe0W1Mf0M093c5qe/p92taJShhUhImazyc4EXKxg4a/hfMv7yB0dpNBgPQXYxOaEoucoxXC/Zoc++ru1jq0evDJ8QA/A3rDLeZZ5CjcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560007; c=relaxed/simple;
	bh=OzkE5YzGv4a64gH/xm2Y6n/iTkv2o7eX4zO+nwD0Ap8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ewFaNDhOjDAqugBNJvh8oPYOMF2yov1IHD3UebocItG4dN8+Ar+YzdIYKvnInkgV/ty85k7vOIUZASupG/i/sBecnKGuOlvwOlf2codxQHqwmVM4lKyHjUZLLEaFt3f8mARP3dwNSiLtDf9m2Pf+uGG21taQM8Y2ULo7BcoKF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBUEAZ87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B930C4CEE3;
	Thu,  3 Jul 2025 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751560007;
	bh=OzkE5YzGv4a64gH/xm2Y6n/iTkv2o7eX4zO+nwD0Ap8=;
	h=From:Subject:Date:To:Cc:From;
	b=KBUEAZ87bw/Y/xEK0apWiSR911PTT0LR9C1AwPeoI8I/PEvYcPORmV+Mkx6jR+Df1
	 0V+VW7maFgzuWXElMdIjqDQTp3GksChr0n6TuZa3CDlzN6YwtufdZfHQK7GTaFsHX7
	 ekvX+aqtiNOyko08UVP/Ja+Z+dP9Qgz40rtqhpqFx6kWLONK3BDLgk9hbCtZDIhI7r
	 q5cuXSPqJIUjW2H9DnAU4F0xf4+3oc4lXQU5hEsPzZIb5fn+qkiRb2zviruLhgOnei
	 etnJzpcXYHqHdzCaPw5jYX3KXOG6wRkfFZWnrcX8KsYza7xfW78R5AjRBmy+JTOCte
	 uVUc9ZGTylEIQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] arm64: Support FEAT_LSFE (Large System Float
 Extension)
Date: Thu, 03 Jul 2025 17:23:21 +0100
Message-Id: <20250703-arm64-lsfe-v2-0-eced80999cb4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHquZmgC/03M0QrCIBTG8VcZ5zpDTd3qqveIXZg7btLSOMYoh
 u+eDYIu/x98vxUyUsAMp2YFwiXkkGINuWvATTaOyMJQGySXmhupmaW7UWzOHhnvBHf+2NnBSai
 HB6EPrw279LWnkJ+J3pu9iO/6Y9p/ZhGMM9MdtHDq6lslzjekiPM+0Qh9KeUDMRaQiaUAAAA=
X-Change-ID: 20250625-arm64-lsfe-0810cf98adc2
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OzkE5YzGv4a64gH/xm2Y6n/iTkv2o7eX4zO+nwD0Ap8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZq9AOYzU26i6ZGFfSMwLvu537cdZGFtRz7FCh
 kPlYrEAQmiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGavQAAKCRAk1otyXVSH
 0BalB/4//XC+LdiJOx3alnA2tkZQLlecke6VHexYSrI5wWWv/VqWKzMe+67IwtuwVS1YxdIwqBR
 jMy2TvSlbqfHwxEajUP44zJONeBXOxbgV1j4wZpE1v/r1/QZ9PO/vwhf/jdxDrBkv0ijDGlmMAM
 y1v4N/0LHVxAh+kIRd1AyML94OJa0vieDFPzbFE09L0fUC9nd2mlCsYw+wtNnbGQWgZRnwt04LS
 CFbkevJNSqCSEk3X1wulPJdgL5UfC/5jkH/fShyn3vklO6G30NWR7be0mYhSyAvnJ2b7wNdrBSs
 EsZGUBw4nGVF5O0Zo3tWbTFYRLZFZvNvD7S9S+HiKXDA6aaJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
memory operations with floating point values.  We have no immediate use
for it in kernel, provide a hwcap so userspace can discover it and allow
the ID register field to be exposed to KVM guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Fix result of vi dropping in hwcap test.
- Link to v1: https://lore.kernel.org/r/20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org

---
Mark Brown (3):
      arm64/hwcap: Add hwcap for FEAT_LSFE
      KVM: arm64: Expose FEAT_LSFE to guests
      kselftest/arm64: Add lsfe to the hwcaps test

 Documentation/arch/arm64/elf_hwcaps.rst   |  4 ++++
 arch/arm64/include/asm/hwcap.h            |  1 +
 arch/arm64/include/uapi/asm/hwcap.h       |  1 +
 arch/arm64/kernel/cpufeature.c            |  2 ++
 arch/arm64/kernel/cpuinfo.c               |  1 +
 arch/arm64/kvm/sys_regs.c                 |  4 +++-
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 7 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250625-arm64-lsfe-0810cf98adc2

Best regards,
--  
Mark Brown <broonie@kernel.org>


