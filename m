Return-Path: <linux-kselftest+bounces-37605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D04B0AC16
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237AE1C27ADE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFD223311;
	Fri, 18 Jul 2025 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y04bJ+ZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6D222594;
	Fri, 18 Jul 2025 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877021; cv=none; b=MnVE8ETzb9UJE8IR8m5EmtLarLUKKy5tlj9p81vvMRlhZKvxuLY+5Sd51RErfgiyaKoO2pwGiD+5TotY5KobgV39M3vK+CLjy4FMxNEUj9foJoELg26h3KwTPbXkPZCCTCbyz0e/rmnFICL82eRgWSZHIjyVEg4XOBRVKoQyM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877021; c=relaxed/simple;
	bh=v75KB1eAr6vVFWWCQHSWO2tjEmEj20MzgOKOHSHPFeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qam+ciURupEgKB1SX6a/oel8fooVuHdFDbqOunPT4kIyvE71YcvT4ksvGMy6o1WIs6vWOvlZY3FKRuatUD2UMxtKK7MFSoWgOgn0VJLWmCcHJwf+Vzn2qyVGBtoj0TNjRZmRPAWnX7KFmiMKogTjr/4qot1ZieeuSIgMOlYNj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y04bJ+ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8432AC4CEEB;
	Fri, 18 Jul 2025 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752877021;
	bh=v75KB1eAr6vVFWWCQHSWO2tjEmEj20MzgOKOHSHPFeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y04bJ+ZRqPbHQiYnPbvwqrPEKLjeZVSl+7qpsOBsYDbWG41tSrUrGgaqOOfML1BWd
	 yOkqfLzcuGXsN/E3MFfE+LfcQrXIwaJRLIq+YI2/7VG4lZs4XI5W3SwCc5PTokS/sk
	 e1Rs+MXVpjqHCpZcp8TAxNct7rCFWr7Zt2L4nHwXijZL3p/LH5EZLRsLzuob/4v/4a
	 WSKc7SyPqIjwwXsIWYfbq6yEH9oqELSd5MELXbV9DXhOCSzcGNKiVolMLzW6RFJEk6
	 rZKMHO4HL35JnXvdIPV2FWvfMbAr39Jn6uLT1Czy2EMZhCwZPofoJxPz6oSCgrIw6j
	 sklLkgiwW+0Lw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 18 Jul 2025 23:14:51 +0100
Subject: [PATCH 2/3] kselftest/arm64: Fix SVE write data generation for SME
 only systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-arm64-fp-ptrace-sme-only-v1-2-3b96dd19a503@kernel.org>
References: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
In-Reply-To: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v75KB1eAr6vVFWWCQHSWO2tjEmEj20MzgOKOHSHPFeY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoesfW2kpUi/Y9eauMoMki+FnL9SKRAujO6Ay8H
 iByIVbdfpaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHrH1gAKCRAk1otyXVSH
 0Fi1CACFkFDPkjcxZ+wxAUV5LuKeBhx1IS5cpkKfdAPRJmLOiYN98DQbVK6ETi0R/6PSbvrQspe
 ru3j5f2hXnU4zZEIwo7QNd/oz8t3tOY6KQL1VmD/uWRFNOZ/4iWHz9QX57shTngup/CNfVPWlJK
 4hJ3Qv1TH2WU3tncQwkf/d1Tmof0oNHhL4VQJGp8m4RyRM1EHQ5rvyrxpnT8P7q5JLACyYD3nqf
 R+nIvBjUwN2wCwu3v6uWrfI7WLgWw8hB19vD1yin22VOL7u0J2G5voVs/cv/YP9/YxkmOAVUV4w
 p/iOrFs0AlpwxbXUgRT2Hf+00PybeDDBOMcEDcn/3tqZ04Jz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

fp-ptrace does not handle SME only systems correctly when generating data,
on SME only systems scenarios where we are not in streaming mode will not
have an expected vector length. This leads to attempts to do memcpy()s of
zero byte arrays which can crash, fix this by skipping generation of SVE
data for cases where we do not expect to have an active vector length.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index d953e9b0ebe5..9fc9dc4adaf9 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1134,6 +1134,9 @@ static void sve_write_expected(struct test_config *config)
 	int vl = vl_expected(config);
 	int sme_vq = __sve_vq_from_vl(config->sme_vl_expected);
 
+	if (!vl)
+		return;
+
 	fill_random(z_expected, __SVE_ZREGS_SIZE(__sve_vq_from_vl(vl)));
 	fill_random(p_expected, __SVE_PREGS_SIZE(__sve_vq_from_vl(vl)));
 
@@ -1161,6 +1164,9 @@ static void sve_write(pid_t child, struct test_config *config)
 	vl = vl_expected(config);
 	vq = __sve_vq_from_vl(vl);
 
+	if (!vl)
+		return;
+
 	iov.iov_len = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
 	iov.iov_base = malloc(iov.iov_len);
 	if (!iov.iov_base) {

-- 
2.39.5


