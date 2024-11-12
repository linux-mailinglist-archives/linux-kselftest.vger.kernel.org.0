Return-Path: <linux-kselftest+bounces-21856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C79C589A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E451F22656
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014D213BC0D;
	Tue, 12 Nov 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry3Ienk6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54A13B2A9;
	Tue, 12 Nov 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416908; cv=none; b=OFLQK3SZdhls8R7+NK/7rcaUYldiuE2UD+MWcsOldJ73QDzR5R1yRe0/AZFA7DZ1oNn/JzneO2Lp2NJwClTFu5k/5o0ZfZ+cjjUxEfpeqIlcZ6hY3Ug09reBRZS4E/FLNkdm6L6tUdaOPMeuJrHfdD2gWrZ6Hx4PCTundu/Nk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416908; c=relaxed/simple;
	bh=FvQalYDVEb1tpw/lP6gu1uruFFvqj+3wo8n72MSeeY0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UIJ7iQiCGYT46WniOZ1iNMiQnqECcl3UbP+TpTg3vZuwiFlwmDU2py4Za7s6fBlRAyX9HjyIH/UfVQ6n/z7l3aToQ1bANr4dREdtSCqWEfHRYdWKOuZX8HaLUm/pm42YYB61c5d99A/AMosaKZKY1CVGjExLc6bv5yr27RI3oK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry3Ienk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79157C4CECD;
	Tue, 12 Nov 2024 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416908;
	bh=FvQalYDVEb1tpw/lP6gu1uruFFvqj+3wo8n72MSeeY0=;
	h=From:Subject:Date:To:Cc:From;
	b=Ry3Ienk6Y2mM8ZSs97j1OsJGSFL04SToDAIVsb60k4QUyrtWzKjldHGfWBeza0Ntc
	 F2ehoYnC6jSbr40fNYBouxQB/YGIde7p6M3n60M5efUUmUSp8QHNevD2aflvEP4hyk
	 o1qTJUnVJapdAb0glmsRVYAeTaD1+SvxDIziFqd6zws9Q1l02FIyeyk1cT+Ix7tAvE
	 /CyBDg/fY3kZ90N6xxJiqfqxQMpllDXChWv1WbiaSCRzi4MuUYJs9hOeTXRhjdIsE+
	 wlvJdrIQPbCKy3rvBN5NMtVlJGKzHiFa1RkMEa4h/8ZWxy21wz34hJclG2jwhFBCU9
	 bbaJMqqWv4JiQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] kselftest/arm64: fp-ptrace enhancements
Date: Tue, 12 Nov 2024 13:08:13 +0000
Message-Id: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1TM2cC/22NzQqDMBCEX0X23C2JPyntyfcoHmKy0dCqYSOhR
 Xz3pkJvvc03MN9sEIk9RbgVGzAlH/0yZyhPBZhRzwOht5mhFGUtpWhQ86RqdAHDytpQThOjc0J
 Jp42trIY8DUzOvw7tvcs8+rgu/D5ekvy2P+HlvzBJFFhRQ6JXVPV0bR/EMz3PCw/Q7fv+AWcUs
 ta5AAAA
X-Change-ID: 20241105-arm64-fp-ptrace-fpmr-ff061facd3da
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FvQalYDVEb1tpw/lP6gu1uruFFvqj+3wo8n72MSeeY0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnM1NGksqjE4L2HpHxUPyd1pEiPV03AHGWcCTUq
 SwkfqD7Ua2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzNTRgAKCRAk1otyXVSH
 0JXxB/4rctBZh0YSAiAGYaYnt07rwf45I71iUF+DWpfOD7a6NJi5adRDG3sSPz2MBraM3zC3jT3
 TK04aJay+ydDIdC726w/cUsfW45o9a3RIRrNovWdSZkCOPJBP7J/XrhjaX+JHN2VfEoF/imjeDm
 rZRddzt9qNMyEaPDLcKgdfBOqzmy+/v76iFeKpcwCGFYzdt1y90M53+FJcoLuwhgOYingHpFC3j
 hQsT7hQRtyCbsi9rCtvIhiz7TOTG7mqaV9sH80xlx9FQ2E4kteWjrnCXNbOy6o/hhj1bhcJt6gk
 mzgWv5eMqxWZzxzL30McMcw7rD7r7uOjspA4ppr8eJrW2Qi5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series contains a bit of a grab bag of improvements to the floating
point tests, mainly fp-ptrace.  Globally over all the tests we start
using defines from the generated sysregs (following the example of the
KVM selftests) for SVCR, stop being quite so wasteful with registers
when calling into the assembler code then expand the coverage of both ZA
writes and FPMR (which was not there since fp-ptrace and the 2023 dpISA
extensions were on the list at the same time).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Drop attempt to reference sysreg-defs.h due to build issues, just
  import the defines directly into fp-ptrace.  We can revisit later.
- Link to v1: https://lore.kernel.org/r/20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org

---
Mark Brown (3):
      kselftets/arm64: Use flag bits for features in fp-ptrace assembler code
      kselftest/arm64: Expand the set of ZA writes fp-ptrace does
      kselftest/arm64: Add FPMR coverage to fp-ptrace

 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S |  41 ++++--
 tools/testing/selftests/arm64/fp/fp-ptrace.c     | 161 +++++++++++++++++++++--
 tools/testing/selftests/arm64/fp/fp-ptrace.h     |  12 ++
 tools/testing/selftests/arm64/fp/sme-inst.h      |   2 +
 4 files changed, 188 insertions(+), 28 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241105-arm64-fp-ptrace-fpmr-ff061facd3da

Best regards,
-- 
Mark Brown <broonie@kernel.org>


