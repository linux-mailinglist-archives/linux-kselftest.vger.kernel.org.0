Return-Path: <linux-kselftest+bounces-38770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47FB22729
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F336802F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9FF61FFE;
	Tue, 12 Aug 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isFD5Uon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F97210FB;
	Tue, 12 Aug 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001823; cv=none; b=LWZE+WXOIUk3MSHc8F2FW/f7Hk9x8LSwMAXJsBBQvpm/sE9wZYNN3ECI/vlt5g9+GOBfX+4266Tl7Oinj+xfRCOyeW3bnFdJ6ykghB29wR+vq/HgbfYvnsDCFKnJM3TATt2re9OJblrG1lMc3drnbSLvWMlTvC0svtOz3ZTv0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001823; c=relaxed/simple;
	bh=mlLL8Zqjl1x4J9h1Tsrvy6ZvXUSV2MFA05alrifoJH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5s6AGLhfOHAz6uWaZr0BCT8A0k1ynv5UbYKk5LK/Eguf/tEqCoNAXrdibBSPxIq1TM6gSxtxaj0O1Y/2v12S9M7iZDFrY5ZhptFxrFxsFA+Yvr0QER4Zy/fhZh+GJPVjvkpScqAAEiA1zwsfIYVkjI/yNW8qLlaMTTxoVnxUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isFD5Uon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BD0C4CEF0;
	Tue, 12 Aug 2025 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755001822;
	bh=mlLL8Zqjl1x4J9h1Tsrvy6ZvXUSV2MFA05alrifoJH4=;
	h=From:Subject:Date:To:Cc:From;
	b=isFD5UonT+qfvBMFBC6PbASfWD2ex7RBBE5hKUlwMeXn/ADaeOIXAwuDsBOdYNcc2
	 d4oQDKsbEWvVR6I/1Y4RSiRQ7loxHEepA6lOsiZOTm7tea1pWc7sdVloX8hyQ3UCIO
	 OJ/MuehhDZ9hEwjlouhMhusk/xsRX/Ht5XvyviVgBzi9mzvSsgVWO7DLuNhTYUB3+i
	 emQkdnqTbzyS/ACS1+0FaLjJqIjDcBqDPFyb8dnlwRLNwm5/URraAsVIl/kpAN6JnU
	 kLLldBDF5VUOENhEoFAohibwN20cA1Clo2YAmqW59f3uw51fHdlw8Q6Bghikm+k0II
	 OWGkTEVGgFxhA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] selftests/fchmodat2: Error handling and general
 cleanups
Date: Tue, 12 Aug 2025 13:00:48 +0100
Message-Id: <20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPAsm2gC/22NywrCMBBFf6XM2kheGu3K/5AuajppgjWRTChK6
 b8bC+5cngP33AUIc0CCtlkg4xwopFhB7hqwvo8jsjBUBsnlgRshGOHkClIh5qx/pKEvklnFldF
 WmaM7QV0+M7rw2qrXrrIPVFJ+byez+NpfT//tzYJxdjPaKUQ+8LO93DFHnPYpj9Ct6/oBFRSFt
 bcAAAA=
X-Change-ID: 20250711-selftests-fchmodat2-c30374c376f8
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mlLL8Zqjl1x4J9h1Tsrvy6ZvXUSV2MFA05alrifoJH4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBomzPa59QnoSIGXgwlB1rRgpOMn4bi4bb097RVN
 Q5V4oV6msCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaJsz2gAKCRAk1otyXVSH
 0NtdB/9QXEXDLlGE83aS2S8/f9sBPg1kYAaPxd48gnV3PhIud+nsnpMfQbbRvSjanIqoKS16rzA
 pr7O2yJlVUIMDWnhjD0a4FmLLynTOgxQ03T2V4GfphH7FOSj8bhiE1sOM8xeDw2A54luWz1vEIs
 wq01SFRKb6PVK88BRyQLWvSZr3cHDo8mVr48r98+SOkhZ+eJkLJVcpnO74jInwTBnaCUCvbdPQ2
 CjPgLvkj8iBjJhWu8c9VnBS+RDzfIEEzQy4xL6LYXYEBW2XATYn0XnWh/cPwDDAMrADsdIqxsiF
 xWODAlB3pQtsjVRGmeEJx9QTRanFxqvn/XLugkBsXjyWRsEp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I looked at the fchmodat2() tests since I've been experiencing some
random intermittent segfaults with them in my test systems, while doing
so I noticed these two issues.  Unfortunately I didn't figure out the
original yet, unless I managed to fix it unwittingly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.17-rc1.
- Link to v1: https://lore.kernel.org/r/20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org

---
Mark Brown (2):
      selftests/fchmodat2: Clean up temporary files and directories
      selftests/fchmodat2: Use ksft_finished()

 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 166 ++++++++++++++-------
 1 file changed, 112 insertions(+), 54 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250711-selftests-fchmodat2-c30374c376f8

Best regards,
--  
Mark Brown <broonie@kernel.org>


