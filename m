Return-Path: <linux-kselftest+bounces-43187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E6BDE80F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F63448482C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A3321F27;
	Wed, 15 Oct 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGzx/IBD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8C31CA42;
	Wed, 15 Oct 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531865; cv=none; b=DYv1tYZSs5zHXs3ka5EPJR+I7Sn06Nal+fFHYKB/2xdt5WoxIqCZ/W7mVrO5VrPnf5Um4+f4ByGAaw4Pp1D6WOEcOVC05/5r4ADB96cA8Ij/wWljuwpKEG0SIVURymzhhKRc6sRj/a0ZN4xx1kRmwNVM7zPYpjksFzZ8Rs/+CRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531865; c=relaxed/simple;
	bh=j2Qm5pa/N3kSJDR0/gxEvhwXjYfhj+2IrZYicpoy4W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDvQKJAyP5bpbMLH9AXp0+HooAtKlvCCtcOPsamCfJ4ZT6LkvVICtXoB2ke5BCMtCtKXwJ4GZb3MONm6N9GFwpCd1XhalZOU9QMgBtx+2pjJMfP5lAx2aQMkfM9B/lpwalJi5MDM3jSoXGboz/i496lYqErCom5dBVIxrOliNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGzx/IBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B52C16AAE;
	Wed, 15 Oct 2025 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531865;
	bh=j2Qm5pa/N3kSJDR0/gxEvhwXjYfhj+2IrZYicpoy4W8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jGzx/IBDseSobadUv9m+TqcUg5V0kj8RUr4aRy5dURkIBtGSgSQilQaWwZ10tgqFG
	 q07jLXXKOM57yGei+pcdEqiPDDuo7KSU8cX2+U9f2CMood3AjsX/5SJiFRVqDV9R1w
	 QSBiefh2KKl2Wyo0Dki1cWBm2/RuLsJZ7PV7Cmu5VrdQ6hR/Nx0xw5Y2f5t+q5vIYY
	 VgFjCuDZZtdDvFGiRQDW1lKps+lPFXDyzwMmc3fwjtO24dNnpsNcN2YZiJjx/rfyKD
	 pgTBnAkaOkmxtonECB8KD4SxEKPdhxrTg1+C8E145Cwhp59PYJoWgbJQudgboGU7h/
	 Eokd1fscOvoMg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:36:26 +0100
Subject: [PATCH v3 2/2] selftests/fchmodat2: Use ksft_finished()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-selftests-fchmodat2-v3-2-f243fd281439@kernel.org>
References: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>
In-Reply-To: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=broonie@kernel.org;
 h=from:subject:message-id; bh=j2Qm5pa/N3kSJDR0/gxEvhwXjYfhj+2IrZYicpoy4W8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75WTHNh7yuKwBc114ew6TnfbgZGT0vM7NXrVU
 fVHYt0R9LWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+VkwAKCRAk1otyXVSH
 0DH2B/0dDff7WuIBreJvQjfeoWk+wrGNgGe9MOp5DBwapVIcpycTDGZ744K9s4ZViHmXCZHh2ln
 L+SBN5krx1d3uFLNMHqndE89npqFKQXqyGJfud3F/6lW+tztc2SxOyAmS4rz3k4tT3eTJbwyQZX
 zd0bO+dNJMJwXB/dG1yQYU5WWPtzm/iayhd6MrdUzNl9JmKlHxMOu51FvKRw2l/46ENcA1ldWhg
 Utc9bMBVaYicMfLyJmnLFlt6v6bzTMI0TQBgS1WimhgjsakIxGrQK9950EhPgvoCMlMK18ohoY1
 Q/rTKTSIug/OUWH3EmPTAVarLXOcrVoyubGBGGagMr6oOXS7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fchmodat2 test program open codes a version of ksft_finished(), use the
standard version.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e977d942c00b..d3682ccd7cb8 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -196,8 +196,5 @@ int main(int argc, char **argv)
 	test_regfile();
 	test_symlink();
 
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
+	ksft_finished();
 }

-- 
2.47.2


