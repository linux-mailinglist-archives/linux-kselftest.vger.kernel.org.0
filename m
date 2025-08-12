Return-Path: <linux-kselftest+bounces-38782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A15B22B48
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ED6188D8A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D742EFDAC;
	Tue, 12 Aug 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdm63OSK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDA2EFD99;
	Tue, 12 Aug 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010640; cv=none; b=ONlcKGooBVdflW5zwUA9RgsBNFQJXzySYmODasuVrzbvtLsyxtlD+deRxx4vWjWWmeZ2ROGL8qRHScrNUUlWzUY9Y3jRCWfqCm1KP9BLeYtbdrCMC9vKot9HHBSvAYhDi85d8zbORUX+ejdZmdQQpE/AEoFNNA49QDcOYHFxl9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010640; c=relaxed/simple;
	bh=3ExZLAzsZqIFtZW4qLdpfIumHDDWHM/OVOaO+t5xwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=foxYHQ3vEQ58gp+5JqH1SJ0sM2ej7RW4Lnv1F8fxmj7WSa5xeRfeZu9jv+z56Cx0GmqXT1I4EobjSfev6435qbmhW6DnWS3NbMdWYMBycRAMUzIKtUjiCPq/PHUZcmy48pulS+ZZN+4TZTSDOt0yCU6Ydd4DdBXWh6A+NpWkkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdm63OSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2A6C4CEF0;
	Tue, 12 Aug 2025 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010640;
	bh=3ExZLAzsZqIFtZW4qLdpfIumHDDWHM/OVOaO+t5xwD8=;
	h=From:Date:Subject:To:Cc:From;
	b=cdm63OSKyAumMKM6PCfP17B8WJbcbLNZqkLBaoaKUKgvjaekp+vAnYoRkGgPlV7Sv
	 SsmDm6UqvNrqtS90D2sc6m/1AQYkda0YcVmEUtgF2eRPaXuMohYKaR5p+C1NbcyhaO
	 UeVx7/6HzFg/b+N1UMyvOspdB/QggbpP06LO+feuZ6m/ZPlJd8ODIpMymYyhrjuMOK
	 yG+cgsTv03vx1PLEpHXO9D3BGFDXOyHdpByucJEW5iNFY5oIsQNKmazjH2hvpHAuyB
	 CCH+YUgxuzgEdWr1VsHO096HOx5ZO4hEIbwH8E263F74IeL0E4p/c9uW9V3FRlvefW
	 57Zct/Kjk2QWQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Aug 2025 15:49:27 +0100
Subject: [PATCH] kselftest/arm64: Don't open code SVE_PT_SIZE() in
 fp-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-arm64-fp-trace-macro-v1-1-317cfff986a5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHZUm2gC/x3MSQqAMAxA0atI1gZiHSheRVyENmoWDqQignh3i
 8u3+P+BJKaSoC8eMLk06b5lVGUBYeFtFtSYDY5cS548sq1dg9OBp3EQXDnYjuQkCvk6cltBTg+
 TSe9/O4zv+wGh42QXZgAAAA==
X-Change-ID: 20250808-arm64-fp-trace-macro-02ede083da51
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3ExZLAzsZqIFtZW4qLdpfIumHDDWHM/OVOaO+t5xwD8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBom1ZNDQMMXonLuVFMnkDp3HEVYBhXFQEQ3AW8K
 IWmG5NbDQCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaJtWTQAKCRAk1otyXVSH
 0C8mB/4gwEJmywOJjkmFNyrn/IILJtVCnzWPLvrJJCDLdQnFFA/DrVVoXJrpKAN6y6n7o8wX+W5
 8yrWfK2pfDSD0l21NxKiWeV7yddCPQuFlCydL1HqeN3k6P0iTB/p+dKMMZCNYySyzH4tRGjFET3
 XILQqxcUoUiX/ynWShooJgW/n+d6G1QHZD6Na6+JDFQ99avzsTLy7sk8I17hs5i3Aeb00Q9ceMG
 CxRtOCXcMP8GNr3pVL05VxWo+PC/ozvH0ewSvcypX0bnUbjH3FaUqm/wQqYoH7eDXTPKdEEZGso
 a6EBQf74yQL//qVaeNmXJYekmu/gUGamG9QEQDzo/k312huE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In fp-trace when allocating a buffer to write SVE register data we open
code the addition of the header size to the VL depeendent register data
size, which lead to an underallocation bug when we cut'n'pasted the code
for FPSIMD format writes. Use the SVE_PT_SIZE() macro that the kernel
UAPI provides for this.

Fixes: b84d2b27954f ("kselftest/arm64: Test FPSIMD format data writes via NT_ARM_SVE in fp-ptrace")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index 124bc883365e..cdd7a45c045d 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1187,7 +1187,7 @@ static void sve_write_sve(pid_t child, struct test_config *config)
 	if (!vl)
 		return;
 
-	iov.iov_len = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
+	iov.iov_len = SVE_PT_SIZE(vq, SVE_PT_REGS_SVE);
 	iov.iov_base = malloc(iov.iov_len);
 	if (!iov.iov_base) {
 		ksft_print_msg("Failed allocating %lu byte SVE write buffer\n",
@@ -1234,8 +1234,7 @@ static void sve_write_fpsimd(pid_t child, struct test_config *config)
 	if (!vl)
 		return;
 
-	iov.iov_len = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq,
-							  SVE_PT_REGS_FPSIMD);
+	iov.iov_len = SVE_PT_SIZE(vq, SVE_PT_REGS_FPSIMD);
 	iov.iov_base = malloc(iov.iov_len);
 	if (!iov.iov_base) {
 		ksft_print_msg("Failed allocating %lu byte SVE write buffer\n",

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-arm64-fp-trace-macro-02ede083da51

Best regards,
--  
Mark Brown <broonie@kernel.org>


