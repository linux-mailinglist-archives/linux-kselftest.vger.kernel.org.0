Return-Path: <linux-kselftest+bounces-37586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BECB0AA2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 20:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A37AA6BB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127AE2E7BB5;
	Fri, 18 Jul 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZYjaIcP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99481F7575;
	Fri, 18 Jul 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863746; cv=none; b=ho6iPOqGauDByA6NRXW3P/GrEXuEDYxqC8ThyhPz6sbFXsBQ4mvjqOAYcvUOuPyfS90Jd3fNWg7J5FZkEFEgB5CQX8sHyJZ82aX8T82mEu4e8y3i3nScHjqXPcWvA+d/WbYyQAq2oS0aCWn7xlqXXEOqOJ9eQWmwWK/to1dNC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863746; c=relaxed/simple;
	bh=d2q2TbdCVeqS5rqu/bLRgCJKo3NrsSwrZ6A3XKOfT0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lTdG+25ZjJYWlDHxAGyMdhjabLPimxqOjWPsSwSCNSIGDxoGsaVwo2EoxbeOgfTn8EL5Wt3IHbyLj35GB9tACTP8HLe1qj5iF4D9tLLoJGPfTIOuXAagWscA/lDU+o5UbK2sx/TRBTY6FY2xCFy4/KJfZjUVEyhfoNDfcaduKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZYjaIcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EBFC4CEEB;
	Fri, 18 Jul 2025 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752863745;
	bh=d2q2TbdCVeqS5rqu/bLRgCJKo3NrsSwrZ6A3XKOfT0g=;
	h=From:Date:Subject:To:Cc:From;
	b=oZYjaIcP9cMmKu60dpbyg4SCH49W2emFlditUGxphisynp/39CgbKo/N28bH7JCKp
	 EdscLKZaZQ7G8HD58Yx/7QLjK6gqdIV5Uz/D9FEgr4lx90Tmo9UaKd0VIaWCYD99f6
	 wDt63Al9vbWz+H51YkmVGl/u0c8VMQbmNUkcmq6iUPspSbt41znioz2PQ1wBgDB5+/
	 CBaU7Tj7xDu7TBOXZ8aNLO8/Xr2C3QcaOgujf4E6odoL9ee4cKeyaeVlPk1H4TGwOC
	 bP4NSrxIuuWk+If0kHeUrBU1hOhN9F9qVOcj7YL7BWurVpnUfbOHycouLohVv3U/Z9
	 V0NOFeaoIRCvA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 18 Jul 2025 19:33:16 +0100
Subject: [PATCH] kselftest/arm64: Allow sve-ptrace to run on SME only
 systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-arm64-sve-ptrace-sme-only-v1-1-2a1121e51b1d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGuTemgC/x3MQQqDMBBA0auEWXcgxqi1VxEXUcd2oMYwI6KId
 2/o8i3+v0BJmBRe5gKhnZXXmFE8DIyfEN+EPGWDs66yTfHEIEvtUXfCtEkYCXUhXOP3RB8G306
 2bFxbQe6T0MzH/9319/0D8agvyWsAAAA=
X-Change-ID: 20250718-arm64-sve-ptrace-sme-only-4ab49d037295
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d2q2TbdCVeqS5rqu/bLRgCJKo3NrsSwrZ6A3XKOfT0g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoepP9gEyjTyb6/d1rD8yLE7mUsNFe6A0KL+VEw
 8JodIcKEwmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHqT/QAKCRAk1otyXVSH
 0CmpB/9AawBTVxco1Vojwq8+KB6lhkWcokuOiooTXWM7NUIUtYQESNsIcYGllucQn+TMGkUYvVZ
 ldDNU8grNvIL/v3PtBl9MS4zsOlABSgf2jkuGB3UTSzMA6h+X0xp6F2f026TBv7U1xSyRhmZZe/
 1KjdyW6m1MWH1W0hRravq+l92o7q+0DN//lW+LWTQF85G/Trp8UU+oh5jSapRzzjEZbDHiiBqpq
 k+mDVjF1sSJQVwQdw/eYb6Mqeiv7GUCF/XIm9EecYyhe2a+8KyCOTVXjdPr8N/iijDiacBd6yUk
 2lTXIu6A0Gk198jFPlr38GQGx2EaoWAUQckLqIzpZB6ji0jw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the sve-ptrace test program only runs if the system supports
SVE but since SME includes streaming SVE the tests it offers are valid
even on a system that only supports SME. Since the tests already have
individual hwcap checks just remove the top level test and rely on those.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 7f9b6a61d369..b22303778fb0 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -753,9 +753,6 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(EXPECTED_TESTS);
 
-	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
-		ksft_exit_skip("SVE not available\n");
-
 	child = fork();
 	if (!child)
 		return do_child();

---
base-commit: 9e8ebfe677f9101bbfe1f75d548a5aec581e8213
change-id: 20250718-arm64-sve-ptrace-sme-only-4ab49d037295

Best regards,
--  
Mark Brown <broonie@kernel.org>


