Return-Path: <linux-kselftest+bounces-25741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95FA27F16
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA83A0FB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5621CFFD;
	Tue,  4 Feb 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnuBFs4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96821C172;
	Tue,  4 Feb 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709639; cv=none; b=AEQlBpwH8X0Jc2/hQt/WEgCEiXYkB+u4PiPKsMAKdcva3IVFB9YsgyxGPRCoVSFnUGmZmlkAWnTbqNPX+N9PY4TGofb96ohfRhPcLuX+fFIjDUc7jF7XnE+qlIY7m2SBjXvGYZe97v1VeDPtEIxQIx9WtHn4dva6I0WxAkVYwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709639; c=relaxed/simple;
	bh=UjyVgY4mnk/+RCxUdi7MWPi51mBa6KRkW5x9l1umZxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iNabUMhqHJHuhhagI7rmdebZJ9tMAzOAsSVTmjQzS5DljxBnP4/NMIEqvxpmMzUQF5tdpZss4CWMbyFvjbrgxFJLWGwKlJzcVU31z++8b8ItJ4LyHXvypQSEtk0zkJCiNoHiP18asez3cqNlwYbKNsl/naQ4m6xRJl1QcY0N4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnuBFs4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FB8C4CEDF;
	Tue,  4 Feb 2025 22:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738709639;
	bh=UjyVgY4mnk/+RCxUdi7MWPi51mBa6KRkW5x9l1umZxM=;
	h=From:Date:Subject:To:Cc:From;
	b=SnuBFs4ATEpugBDZiD5cI47gKnHoMEiqP1hPBPywhFtExg03oTUWdwdlejPwpkexf
	 FMobjw1RbbtWTHq2l70WlrgJOYBOwTxUNTDTiELklsQ0zaM6lU5UzmZemhYp8RKMDg
	 m/mk2UPGMiCxljJVvA5z69r5KJzrrECHcgGNxHgM4HhM9yHpUirpIuE0r9quwTs+Ic
	 1INHmP8Y+nsFffydCtsRLdd2kroxk6ZG+ge1MPtBmw0b8aXhPsup3sOxZ+wwUXA4IH
	 rEXU4gUpdPn7eZUr6v8ZAJr1LfMD5K/uc69xKNnSAR517kJ4CQARkFsjSSnCtXE1BT
	 ZO1i0AAXb/z+A==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 04 Feb 2025 22:53:43 +0000
Subject: [PATCH] selftests/mm: Fix thuge-gen test name uniqueness
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-kselftest-mm-fix-dups-v1-1-6afe417ef4bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHaaomcC/x2M0QpAQBAAf0X7bOtcx8mvyINYbNzR7ZGSf3d5n
 KaZB4QCk0CTPRDoYuHdJyjyDIal9zMhj4lBK10qrQyuQtsUSSI6hxPfOJ6HoLJVb+rS2qI2kNo
 jUHL/t+3e9wOsJvL1ZwAAAA==
X-Change-ID: 20250204-kselftest-mm-fix-dups-076a48577184
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UjyVgY4mnk/+RCxUdi7MWPi51mBa6KRkW5x9l1umZxM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnopqE8JNsrIpaCLHsb803xkQveAt3pqdMpcA8xjWx
 FmXmdjqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6KahAAKCRAk1otyXVSH0I7yB/
 9b1brPz7RgFatdJWcZpnZOaDY/Cqhw0SquS2GMKVC1vMD3Gq9idQgjJSaSGtbrf37k7sMd2/cTR/I7
 Q/MRHCKnv1+PP6Nm4SpsO4qiPloU/fnSSxfVuDH1yhqp1LyxuxkN9JIAJelYqkeBuYrh2bsCgptSFn
 CY0wWjxLJ9b4lRlcqeCr7oE9f3UwQpNxrQVDHGcTisz4Gs4VLN2mQ73Hi30b3lCdY3h+Y98Svb3cjc
 Q7sG8mT9ggitAg599imc4CWBfL+jFmbcnOCinZfdiOuqyObxs4r2jL2afwSaodMs5w56ref6ReO6B3
 2yFbNKlsLzIPYOQvQGQw50QdVxT541
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The thuge-gen test_mmap() and test_shmget() tests are repeatedly run for a
variety of sizes but always report the result of their test with the same
name, meaning that automated sysetms running the tests are unable to
distinguish between the various tests. Add the supplied sizes to the logged
test names to distinguish between runs.

Fixes: b38bd9b2c448 ("selftests/mm: thuge-gen: conform to TAP format output")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/thuge-gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index e4370b79b62ffb133056eb843cdd1eaeba6503df..cd5174d735be405220d99ae796a3768f53df6ea4 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -127,7 +127,7 @@ void test_mmap(unsigned long size, unsigned flags)
 
 	show(size);
 	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
-			 "%s mmap\n", __func__);
+			 "%s mmap %lu\n", __func__, size);
 
 	if (munmap(map, size * NUM_PAGES))
 		ksft_exit_fail_msg("%s: unmap %s\n", __func__, strerror(errno));
@@ -165,7 +165,7 @@ void test_shmget(unsigned long size, unsigned flags)
 
 	show(size);
 	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
-			 "%s: mmap\n", __func__);
+			 "%s: mmap %lu\n", __func__, size);
 	if (shmdt(map))
 		ksft_exit_fail_msg("%s: shmdt: %s\n", __func__, strerror(errno));
 }

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250204-kselftest-mm-fix-dups-076a48577184

Best regards,
-- 
Mark Brown <broonie@kernel.org>


