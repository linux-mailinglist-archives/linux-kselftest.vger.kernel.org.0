Return-Path: <linux-kselftest+bounces-47702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAEDCCB95C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 12:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCB6305A80B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 11:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F129B766;
	Thu, 18 Dec 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suPfyznc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BA184;
	Thu, 18 Dec 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056692; cv=none; b=F0ZGfeQzqNyW6LJZJsOiYNEazEV1QxZTSWBBdQc5M9nvrEKcFdTsGDCk8PsQEbRdv+894XvlWJfUPG5ROrEpVxothgDuPyw/uUKMo+295qen+rW3vMCrjZmFyPQsm00xX45IrawP4dcdVAKrVDHnMxmKxaYEB32VIhrZqRe7rOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056692; c=relaxed/simple;
	bh=sl+2QZ3wnll/UsCDTfkEWXHpVidEQ52naoIGPmwEE6s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WPnH5wfJ574IhOUA7UOwiLorr0LumG9g6cZjH5QIUp98vuUx4YsZGfrU6qLOBCjboA5PB5DcBsbAZ/4HH7grDERAn/OavdwfcABC0CPGd6yw3Xq3WuNP6LEPHe84m1NeWKgdyjnv0/QTqVHbWfdISMXAeqKwbVME1LXhdnclMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suPfyznc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ADDC4CEFB;
	Thu, 18 Dec 2025 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766056691;
	bh=sl+2QZ3wnll/UsCDTfkEWXHpVidEQ52naoIGPmwEE6s=;
	h=From:Subject:Date:To:Cc:From;
	b=suPfyzncV4U7Magq7xXnHpUAbRFyNJ7ra6AjDQOYApxP2etTiHoXcgTMhZkEpQW1f
	 fE9asDTF0H/kC09ZufZyPsAdwpLEWp4/q6tpVxkYFTUbLeFe8YD2hLwpadkSlMSVdi
	 W79ilLceJjkX+TDIh8B6nVOmiZRE9vWHlr8FcBLoMloLuvxwaFeLqmttRb/Ec+txV7
	 PI+GHoYcC6Eke5ejNiRXZNoUTPGrsxoPDOXAr6dkJAq4razsTwxJ2UuobM+v1ZP0+e
	 PGHU5pLQLnVSyN7JvIyGoMtA0+Ztzi2D9cT3VB4GgMVF5uWuRqABiO3uQHvY7BYi1I
	 x/Y3xbZs7GcLg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/3] selftests/filelock: Make output more kselftestish
Date: Thu, 18 Dec 2025 11:17:59 +0000
Message-Id: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfiQ2kC/3XNTQrDIBCG4asU17U4Juanq96jdGHjmEgkBhVpC
 bl7TQqFLrJ8P5hnFhLQGwzkelqIx2SCcVOO4nwi3SCnHqlRuQlnXLCKlTSg1RFDpNpYtK4b6Rj
 lTDWX2LaNZAoZycezR21eO3x/5B5MiM6/9z8JtvVLNtAckQkoo6oEqetaQ9FWtxH9hPbifE82M
 /GfAwzEocOzo4VWHJ616Ar556zr+gFN8/dtBQEAAA==
X-Change-ID: 20250604-selftest-filelock-ktap-f2ae998a0de0
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sl+2QZ3wnll/UsCDTfkEWXHpVidEQ52naoIGPmwEE6s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ+Lv3PP/391tKLfyXmA7XHOAiQAOInvh/tP70
 92CcWpECceJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUPi7wAKCRAk1otyXVSH
 0JCRB/wNkQfzS/8Vq2fnMeSjuL2kiE/Baa/qXVtEWwucpn1OtYcu5g9iix8omp7dK+nZF0Rr0x5
 6Wziu3F3TqLyEFF4IB8tbAkle/kKZWgC1b/w/Wrx/VCWp8jxlT94oKsI/x2Xd8argNlK51IDEL8
 uEUS21CJYNV+PAKrKdAGJXR837pvvPsNAnrRR8xeIJ98qScoMWyzKEM5q+qY7Fs/5Bnfs9nwvqB
 L9GBy4sLZZzOZipd95L1GLsnBjYsYaAFkaob6XEU+ZyYXvsDNXg6094Kt1LTozLZaDpD/JjsFpd
 MHeVrNTAtNwBVMID9Vj8OpQ63YOByVPeOQXVbMpJa4E6U1H6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series makes the output from the ofdlocks test a bit easier for
tooling to work with, and also ignores the generated file while we're
here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.19-rc1.
- Link to v2: https://lore.kernel.org/r/20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org

Changes in v2:
- Rebase onto v6.18-rc1.
- Link to v1: https://lore.kernel.org/r/20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org

---
Mark Brown (3):
      kselftest/filelock: Use ksft_perror()
      kselftest/filelock: Report each test in oftlocks separately
      kselftest/filelock: Add a .gitignore file

 tools/testing/selftests/filelock/.gitignore |  1 +
 tools/testing/selftests/filelock/ofdlocks.c | 94 +++++++++++++----------------
 2 files changed, 42 insertions(+), 53 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250604-selftest-filelock-ktap-f2ae998a0de0

Best regards,
--  
Mark Brown <broonie@kernel.org>


