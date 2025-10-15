Return-Path: <linux-kselftest+bounces-43247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAF3BE030D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7714F19C82E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2231325492;
	Wed, 15 Oct 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek0T/92y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6270325480;
	Wed, 15 Oct 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553240; cv=none; b=rCYkdoEY8GxmGIE+YTPkgOxqfnffwP1Hd5nJDx03Zrl0XbMztxeneqt/q71XL3LcOriE7iZ1z+Q2Jrlx8aEsTSDO7YYAfeIH2IK1peCBF2xIVGups2tQ/fWHuBRyn65oEyhZZ88iL1INnjlVvq5hEyM1T8hiZdWqJc1vkQK057Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553240; c=relaxed/simple;
	bh=5I774JDnc+ZhNXYOjAnxiExSeRhyBZWv0Q7B9a6ooPU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k/zGJr3XZDKHPlPid7WQ2mPtJZSFqHTTV7A2gD6oeE8xN0arf/06BmsvDuY2JolO3DI8XQ5CNm1RmXZltXAP+YYA2LYjD0bfKD2KkdR7u9qmy6rrP8cI5l2tW5TyBJsKou56H39PbW3GBrszIFT+XI5W2MTucARTeekf4yZZAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek0T/92y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF5DC4CEF8;
	Wed, 15 Oct 2025 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553240;
	bh=5I774JDnc+ZhNXYOjAnxiExSeRhyBZWv0Q7B9a6ooPU=;
	h=From:Subject:Date:To:Cc:From;
	b=Ek0T/92ywzV12gGfyj02O9g9i4GO4Q9+9iSOuCeNwsG6g6EQ6s261DzlzrsfvkXbH
	 GM0Nfmr0MZnFOJOHr2MgP78S9RvCGcn+GmWgtwLx6Osn0E5pxoUWkh+n09g75tben/
	 bXKRqJTIBZA6l9gYzGWMcqgisjOHF5CqichsUtP+mf5K1UdCZ3X3f39TSgVrfACQWf
	 PuxgYSlJItvibBwRc7o4ZJwzu8cy+uZPs/dNcvquD/1XsZBpTjlM0JKprsyg85jiNr
	 XPGecJ6kqUwvyQxTnDVTHcOEh0TsMCt96Zc5Y0y1n8yu9ocsFIiztaUZWHzf5HmLBi
	 kzdf4so4/xvag==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] arm64/sme: Support disabling streaming mode via
 ptrace on SME only systems
Date: Wed, 15 Oct 2025 18:56:35 +0100
Message-Id: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPg72gC/32OMQ6DMAxFr4I81yiJCkRMvUfFEFIDUYFQh6Iix
 N1Lw97Nz/rffhsEYkcBymQDpsUF58cD1CUB25mxJXSPg0EJlYlCFmh4yK8YBsJpZmMpjn7sV5R
 NrTORC0FGwNGfmBr3ibfv1clMr/fxYj6XUJtAaP0wuLlMljyVGtlK+IU7F2bPa/RaZExHBa3EH
 4VFosCmsErVShey0bcn8Uh96rmFat/3L5B8uofwAAAA
X-Change-ID: 20250717-arm64-sme-ptrace-sme-only-1fb850600ea0
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 David Spickett <david.spickett@arm.com>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Luis Machado <luis.machado.foss@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-2a268
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5I774JDnc+ZhNXYOjAnxiExSeRhyBZWv0Q7B9a6ooPU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo7+kSOynJH1xs0jKeXbcSd6UHOAar8LrtzTyPJ
 0wzYgz8u2OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO/pEgAKCRAk1otyXVSH
 0LpkB/9zvncNeGhjb1lsEpTrYWZM/xwQ4R3Fxp7T2oBtHruR4zfZeLHekdkP63CzQY3CJPq4TbN
 tEP9ipDMXfU4a5UKH0mAGOxE4UdO4vLj6rXZk2L+Mk7Np0UQK2IdQAWHdS0Ci/rgz4sQh6W1kmI
 maJJuCe5C7Br1efmK0Sh6NfIl73FaU0SFETRP2awBCurnN7pSq/QlMhKnysLcng2dXPvcPBZJ+Y
 z3lYNcU1CYBJlQAIlNH69j/a4oobS25bOZ7yUizSf8qEcld9g4ZeGCtEY1ilRXA6AJVTyqRCqnh
 6CoZDM9JqKCLFx3Ldm3jaBBqPu2kB8EvK5gDOoh/z79r5jaC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently it is not possible to disable streaming mode via ptrace on SME
only systems, the interface for doing this is to write via NT_ARM_SVE but
such writes will be rejected on a system without SVE support. Enable this
functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format data
via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
writes currently error since we require that a vector length is specified
which should minimise the risk that existing software is relying on current
behaviour.

Reads are not supported since I am not aware of any use case for this and
there is some risk that an existing userspace application may be confused if
it reads NT_ARM_SVE on a system without SVE. Existing kernels will return
FPSIMD formatted register state from NT_ARM_SVE if full SVE state is not
stored, for example if the task has not used SVE. Returning a vector length
of 0 would create a risk that software could try to do things like allocate
space for register state with zero sizes, while returning a vector length of
128 bits would look like SVE is supported. It seems safer to just not make
the changes to add read support.

It remains possible for userspace to detect a SME only system via the ptrace
interface only since reads of NT_ARM_SSVE and NT_ARM_ZA will suceed while
reads of NT_ARM_SVE will fail. Read/write access to the FPSIMD registers in
non-streaming mode is available via REGSET_FPR.

The aim is is to make a minimally invasive change, no operation that would
previously have succeeded will be affected, and we use a previously defined
interface in new circumstances rather than define completely new ABI.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.18-rc1
- Link to v1: https://lore.kernel.org/r/20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org

---
Mark Brown (3):
      arm64/sme: Support disabling streaming mode via ptrace on SME only systems
      kselftst/arm64: Test NT_ARM_SVE FPSIMD format writes on non-SVE systems
      kselftest/arm64: Cover disabling streaming mode without SVE in fp-ptrace

 Documentation/arch/arm64/sve.rst              |  5 +++
 arch/arm64/kernel/ptrace.c                    | 40 +++++++++++++++---
 tools/testing/selftests/arm64/fp/fp-ptrace.c  |  5 +--
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 61 +++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 11 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20250717-arm64-sme-ptrace-sme-only-1fb850600ea0

Best regards,
--  
Mark Brown <broonie@kernel.org>


