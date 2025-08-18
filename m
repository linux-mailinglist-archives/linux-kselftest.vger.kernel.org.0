Return-Path: <linux-kselftest+bounces-39244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27600B2B177
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7640F171CF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851EB273811;
	Mon, 18 Aug 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvlReavJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08D2737F3;
	Mon, 18 Aug 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544812; cv=none; b=kf1gCzcm+kMLI1KtiSwSJRVXEQyLLV18GWR43NQrHIO2EDkH5zgUxV0TU9FsNswPA/sw6MmcNSRYPGvyxtNM4qaGPSqDoQLTCIC1mPEg5d3uO+OctyP9SfF3vEmV1dPJkYhEp5NRTtaCgYYuDs7lrbMesx0fuCrHnNqytMaXRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544812; c=relaxed/simple;
	bh=KoH1ekd5Jot6OL3gfQp6WOa6ek+epiij/6qn2GsPf4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W01UqaIMNRflrjdSLqI0SY1z1GPYSuizyAyBBbjBvBGn+vhix0Q5F58aiqnYGSvTX6rkS/5Tt0ZO4OfSP5nsHJ6/YXRw300FwXsGLmgt7+4H5niDbJjQxu+Y/U1yOzfYUFgFBgb4U4CHYpaNVzhdN701GUy/HO2eVsNLb/g66n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvlReavJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41F2C4CEF1;
	Mon, 18 Aug 2025 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544812;
	bh=KoH1ekd5Jot6OL3gfQp6WOa6ek+epiij/6qn2GsPf4k=;
	h=From:Subject:Date:To:Cc:From;
	b=pvlReavJnsy4vTno4qmdsMc9AmWIjlCOmDDk5S49ZeiH5XHmhipMSNHxZYUFA8KlY
	 hbh+nfbPI/Bb3MT59p9fQzbRJEwR6nLPv+bj6ogp28t+lfidxwGO9LI/NOF0dR/aGD
	 AinABAuJyLRrGF0jJ7IpilByFutwD8V7m3JVxjHJhdArQjPLxwtQbIst6H7lvEcpe8
	 wMZ627RIaam/95Fgp38tElelGHdLYwk2PU/cYswzj8a30ZK/fSpmo3xWPX+sc8wu9o
	 +TuxNTWG+2EHqCidbu1l1xomi9JBq3zjNuR2z8r2PmLfHnlrSMP42ShOIBw0o85kH/
	 zEcMyKGxSbfZg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] selftests/filelock: Make output more kselftestish
Date: Mon, 18 Aug 2025 20:19:34 +0100
Message-Id: <20250818-selftest-filelock-ktap-v1-0-d41af77f1396@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZ8o2gC/x3MQQqDMBBG4avIrDswhlpqryJdhPjHDgaVTJCCe
 HeDy2/x3kGGrDD6NAdl7Gq6LhXto6Hw88sE1rGanLhOXvJkQ4oFVjhqQlrDzHPxG0fn0fdvLyO
 EarxlRP3f4+F7nhd8KQ/saAAAAA==
X-Change-ID: 20250604-selftest-filelock-ktap-f2ae998a0de0
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KoH1ekd5Jot6OL3gfQp6WOa6ek+epiij/6qn2GsPf4k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoo3zn7Ri5KAt1k8GR0w12WSG8+EbWwjF9+8J7s
 at2c4h5cC2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKN85wAKCRAk1otyXVSH
 0PhGB/49yF95EPxdhBFo3VgL2gTzv4sdfPpu/eIFxyHQlfmxxzmyAyPxbZE4M9DMq8Flr3LlDwT
 9nDxDj8wpshftMIt9psMNd1iwHh4iBOQnrBL1WLs7MutRw5WQ0UGZ8kP+nS/nsqKdFJf7Kj8Xe0
 T4dvVIUXRWbXEJNOWPszQ59FvjvbQkQ2/thb/NZvZG99s7PD8PpB1+A/ChT2K/duqMHCs6mWpKQ
 nNe5Y1IdOGWgES6HM/aCBY5X+JqHkQiJauo/TCKTIew1m0MhefKhv+MpusCFs5ajjNC20mlEFv/
 An73zer7/0zo7t6E3c+4/oKla3klwYz/+9kp61F8RwKX3lIH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series makes the output from the ofdlocks test a bit easier for
tooling to work with, and also ignores the generated file while we're
here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      kselftest/filelock: Use ksft_perror()
      kselftest/filelock: Report each test in oftlocks separately
      kselftest/filelock: Add a .gitignore file

 tools/testing/selftests/filelock/.gitignore |  1 +
 tools/testing/selftests/filelock/ofdlocks.c | 94 +++++++++++++----------------
 2 files changed, 42 insertions(+), 53 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250604-selftest-filelock-ktap-f2ae998a0de0

Best regards,
--  
Mark Brown <broonie@kernel.org>


