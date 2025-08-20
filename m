Return-Path: <linux-kselftest+bounces-39387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD8B2E4EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130845E35DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C896277CB4;
	Wed, 20 Aug 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLcZNj6X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBC3EA8D;
	Wed, 20 Aug 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714568; cv=none; b=IU7Copjxs4+wz8d8NEkNVJUUKAnQDG3X/d3IQVXzFH6a04DxWyyfoNWcKwFu3y/1lXr1p1tpy/YKgzGtEN3tE+B5uDVjj640znw0PR/rfpl4ZhHrjrolcYNlPznsD9hzZYVum6ivAUgAzWHQgW3RTDjJAEE6isiqK0Ifj0nQ8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714568; c=relaxed/simple;
	bh=0SzMeuxfOcNRRFI3htotgO4HznADUizoh4BxITQXZOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jCA+lpBLuZc92b8XL+E2Mu3KB1uXwiSPYlXlufSkI93PROG8Si4w2XP0XGlDsjlm6y2hBPGZUdM7ONO/g87BqBW/PCx4HaQk0X56AoSC818gtn7Wh47IA7w4kv31LgljVI2aYiN/zcjqjC4D3sMKNLH+ncArO39wGOuBFwmsKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLcZNj6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4560EC113CF;
	Wed, 20 Aug 2025 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755714567;
	bh=0SzMeuxfOcNRRFI3htotgO4HznADUizoh4BxITQXZOk=;
	h=From:Subject:Date:To:Cc:From;
	b=HLcZNj6Xx1YnNkL7/pmzTjPZLtq7r0D4LDQY6xconSMbLOgivCj75OKolau7e4REA
	 bnUKL52WlM4nwx13xRELTbxCXC2L6t8m2vZnPuh8al/NsXRc0qJKI3FoecooLrR+Tl
	 3bn4dWdH7BxPD0EXItX7Q8rOPQIuWbcWQKdc+2q3V4d9xth5+BFV9BIX6Pb1JwWkqO
	 4bviGi+1eYSf8BQRI5DkWPc4Ay7vScetR8CwefUTokTRcjlSdW9XIb6XVw18nCFqps
	 D+CIRZFVdBMB0Zgql050NCJlSlq69VLxXfUFmm7wMrl2CIcrURIQ6ZNmXbwhZOKMZ8
	 gKMbNJ2xTy/oQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/5] arm64/sme: Support disabling streaming mode via ptrace
 on SME only systems
Date: Wed, 20 Aug 2025 19:29:02 +0100
Message-Id: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8TpmgC/02NwQ6CMBBEf6XZs2u2VbDhVwyHUhZtIhS3SDSEf
 7cBD97mTTLzFkgsgRNUagHhOaQQhwz6oMDf3XBjDG1mMGQKuugLOunLM6aecZzEed5iHB4f1F1
 jCyqJ2BHk/Sjchff2fa13Fn6+smLaS2hcYvSxD1Ol5vKY38Ub+FdXahNbsj9xN+Ku7Z2XiGS4Z
 bKn1hUa6nX9AsHKlt/QAAAA
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0SzMeuxfOcNRRFI3htotgO4HznADUizoh4BxITQXZOk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBophQAKGsvgPWYjakzBehyIWbniPGNVwMRy7IMp
 jdIOYBYrriJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKYUAAAKCRAk1otyXVSH
 0FfpB/4gF/goxVk8COhAg47IRT39tjP26tJuUhi0mMHRnEDvhOuV8V+5vaQPbO+Xjfw8uHwDEuw
 AytR+JXZJv9UotF4ySgcaTMJ9lAN3VkoESEmjNHN/PrPIY8Ft2h6FykhQQkTl6sTUmgZLkf5p2a
 lmU78YM6rXOhB6s+g6Hw7CgUHNbH+2hTJYnVw87P+QiH7vR+njPZ13RFp4bd2hmzuszifcUywQ4
 XPBtfXAUqiiQQtj5UtEhAwkFuKFHtg1e3SbHORXOIhavM2ymwS0hMMbpcloDqDAFtJF8pT8H1Nq
 AZ61yit7STjWoeFvVjYeSLdXFpvSSoVtFP880qhy7P5a3sdO
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

The series starts with some enhancements to sve-ptrace to cover some
further corners of existing behaviours in order to reduce the risk of
inadvertent changes, implements the proposed new ABI, then extends both
sve-ptrace and fp-ptrace to exercise it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (5):
      kselftest/arm64: Verify that we reject out of bounds VLs in sve-ptrace
      kselftest/arm64: Check that unsupported regsets fail in sve-ptrace
      arm64/sme: Support disabling streaming mode via ptrace on SME only systems
      kselftst/arm64: Test NT_ARM_SVE FPSIMD format writes on non-SVE systems
      kselftest/arm64: Cover disabling streaming mode without SVE in fp-ptrace

 Documentation/arch/arm64/sve.rst              |   5 +
 arch/arm64/kernel/ptrace.c                    |  40 ++++++--
 tools/testing/selftests/arm64/fp/fp-ptrace.c  |   5 +-
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 139 +++++++++++++++++++++++++-
 4 files changed, 177 insertions(+), 12 deletions(-)
---
base-commit: 768361ab16ce943ef3577cea204dc81aa4a47517
change-id: 20250717-arm64-sme-ptrace-sme-only-1fb850600ea0
prerequisite-change-id: 20250808-arm64-fp-trace-macro-02ede083da51

Best regards,
--  
Mark Brown <broonie@kernel.org>


