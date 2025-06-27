Return-Path: <linux-kselftest+bounces-35987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5AAEBE60
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E853A8737
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBFB2EA175;
	Fri, 27 Jun 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMTMx71v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EE12E5D;
	Fri, 27 Jun 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045108; cv=none; b=f1ULHMsD+ZGTZi7o6unqWw1HDhL1mIt0xUG5VkX189MjdfhVHS9x0/7DTTF4/ETIs6L/BTw+R/zy+VJcHWLNfJZx5I/8WGwR/TNR29Y4+KF/80YKZXnmI/7N/s+HP8xiagheI+L0n8sa4BDC2W5PKJ2wdKuXcyRtbfppCZC1cEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045108; c=relaxed/simple;
	bh=TjGWey8FcBbGmqOInU155Db/0s5SY/hzFhuW5NLF6cI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YRUJnsyjUt76M0vW3zMJFLSogMKxbJhztT5o+vJ1UMVk0K5SLlER+D/Op5IW8ahfLjFuws0NrYVOUgQQjE5guCfg+5Ui0l1JDkHXxpszcrDc1berRUvSAYoOptNJvUA2+7A+sf+m010Vs1FPiQhD2idodd446QrnlD0aadWmHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMTMx71v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB940C4CEE3;
	Fri, 27 Jun 2025 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751045107;
	bh=TjGWey8FcBbGmqOInU155Db/0s5SY/hzFhuW5NLF6cI=;
	h=From:Subject:Date:To:Cc:From;
	b=kMTMx71v6QM/OXAP+Y0vfh2Ir0lcOSak7ALprCXKwUgIF0uKebxCPcQU3Vf13aR0z
	 iWz+WSzDHeQLfrNGqlER6Rf4D3Bovf/AJuGCl9acOgWDuA77RUScEDfaZbxwwq14qs
	 lTqZ86zTd+r68HGYzkYHlGSqa5tCYH9qZU2FMMbjKq0O4JryKCEtChOERdVS6BKhOX
	 ramNyYWQ+rKpWs0nL511bBvEVdCI6R8bEyEAt/ptDzqk999Rzbr/2gy9YuVDmUy0Wk
	 Ke78hj90sRZRzfBm8Uiho/4VvA7tQx7kI0kG5lNDMAstg+qLC9PhZpzUJuxhLnr7zz
	 CjJbpZqTNijXg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] arm64: Support FEAT_LSFE (Large System Float
 Extension)
Date: Fri, 27 Jun 2025 18:20:43 +0100
Message-Id: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvSXmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyNT3cSiXDMT3ZzitFRdAwtDg+Q0S4vElGQjJaCGgqLUtMwKsGHRsbW
 1AFdTkTtcAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TjGWey8FcBbGmqOInU155Db/0s5SY/hzFhuW5NLF6cI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoXtPt0FftV/nPMAp/n+4AWdmZOj6LgUFaBlaA+
 4ex33utcbSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaF7T7QAKCRAk1otyXVSH
 0MOSB/9s8wuMp+MQz7BhZa2kE2BZucnu98xD581nSGlh0NygznHU5GiBt16nWyR/96xsxh7X6Pt
 4GqJqm3TQyyYBj0V8GK9ZeBDgyW64FmjYSzvn3WcCt0rdcyzWPTBUPfGXx4YPu5I4o3HL3fz5uH
 2W+Mkl10sFSBiJGJzoWlagqg/Z392OpdPSXq7ZK8BlLER1n5zicMpw50tXZK8g3aVZaa8Ozt7E8
 F4PUCjnn4hk/WchuQi3P+ohPmnHYzEWIrdxC+61y0Gop+0m1esJufi4ZQxUk3QSf5EEZgxbL1dp
 JoIe4+SkFWRhJtRFXoKtJKFQTN6WKUWtZahW7oABwkMAPHfZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
memory operations with floating point values.  We have no immediate use
for it in kernel, provide a hwcap so userspace can discover it and allow
the ID register field to be exposed to KVM guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
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


