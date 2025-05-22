Return-Path: <linux-kselftest+bounces-33510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56FAC110B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA21C00706
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0723BD06;
	Thu, 22 May 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+6PMrVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00C23814C;
	Thu, 22 May 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931421; cv=none; b=jyoY7sl7aksGjApc0im9YuK6MVdGfIqRUtMK4l4TNrp9tf6zh6nMKJhgQ6JUEXVS8lQgIYomdl+n+Y3ZbamZrrzAfuhMgGEmoUe+fowqDEKg1fiOHiV8YWWeFhGaF1GxX4yvwPLcruaHFYJzveiigrWgCApgwnp97X7qABw/r+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931421; c=relaxed/simple;
	bh=VvYoIAPws8oKWrSzmwyl5I2kVoNn7TSdR7yt+32hlHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lqh0TVTKq+qpbJ8EEzaxuPfXY0Mf+osvI/7u/2j+9LVlxhumLEfbLbnoRWfAC9DtS4DLa6XrrOaewLcZVLgo3WbWVFFN199bvWdSIcc8ZCjkdMPxjeFk32jR6gyPwCq5WiXQAR6a+BQ+2UIIRJ9COPKJHaoJ39aVJ2lq/rlQt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+6PMrVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18942C4CEE4;
	Thu, 22 May 2025 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931420;
	bh=VvYoIAPws8oKWrSzmwyl5I2kVoNn7TSdR7yt+32hlHw=;
	h=From:Date:Subject:To:Cc:From;
	b=a+6PMrVGQUrDneoBqo7DpWq3C22wqZjSn0oPDNex12hEXE6P4jNg9TL+coc9VhPv3
	 v3H9whzPkI1a66RrzKo8eVKrvAn1vzrZPvXCSgm9vQT2vt1FkePpF7Mm6+zcf/zgd+
	 vrbpV2fwolsZffJQ8ROfywhL/8TNw8BbBq7dOYvzdYz32LDiqpsxsdKBVaN3GXPyHP
	 HyeFuJN5AWGXicgR03nnbHlg023X8N7Pt9VSPc+l4LrEa7RjbLObAXAOpwuz1ho0IJ
	 9ERA+94SSEf+KX/VQGZLKC1tlKO1pPAqQPCyWEhS6hnvJzK/upDQsCeLYCgMsogeye
	 ndC7CquUbPedQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 May 2025 17:29:00 +0100
Subject: [PATCH] selftests/mm: Deduplicate test names in madv_populate
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-selftests-mm-madv-populate-dedupe-v1-1-fd1dedd79b4b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMtQL2gC/x3NQQrCMBBG4auUWTvQRCLqVcRFSP7RQNOGTFoKp
 Xc3uPw27x2kqAlKz+Ggii1pWuYOcxkofP38AafYTXa0bnTWsGKSBm3KOXP2ceOylHXyDRwR1wJ
 +OPFibuEa7kK9Uyok7f/H632eP7/4p4BzAAAA
X-Change-ID: 20250521-selftests-mm-madv-populate-dedupe-95faf16c3c8f
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VvYoIAPws8oKWrSzmwyl5I2kVoNn7TSdR7yt+32hlHw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoL1EaPKKO67XVukLC02kQQKb86S1XJSrhZcwTGdkT
 d3uiRGGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaC9RGgAKCRAk1otyXVSH0KUEB/
 9nHnsZi6fuK8Z2Egd5gNc+gg3Dv5KcnWZDd4FCa5MoUrj2Js/x0OfjS9yujvOqaksSwIkyaaNdn5cN
 Y3lHvmHA+U8CV2bkF2baU/2/E2yb8FHdOtxt/GORbzgtou0sCubqI9/7oOL5D8nIqaBQC5qEdnoPKs
 9U0RR0i5WBYfnlu6ZJwzwProVavVofRyOrSNTUFmPkR6C4IGU9EsXlJuTtdtCt1NV+LjBWwFw0voyN
 S2EjvNxlsO60xMlFqkjuaHGKm6HcqcvhDatX1ZYGvYb8iix4Jw9FZNE6Hzy1/xQCZsS2DJi1FQruXZ
 Y7Ji+ehGYg8SmjkFoiAOE3PYzOq4da
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The madv_populate selftest has some repetitive code for several different
cases that it covers, included repeated test names used in ksft_test_result()
reports. This causes problems for automation, the test name is used to both
track the test between runs and distinguish between multiple tests within
the same run. Fix this by tweaking the messages with duplication to be more
specific about the contexts they're in.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/madv_populate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index ef7d911da13e..b6fabd5c27ed 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -172,12 +172,12 @@ static void test_populate_read(void)
 	if (addr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap failed\n");
 	ksft_test_result(range_is_not_populated(addr, SIZE),
-			 "range initially not populated\n");
+			 "read range initially not populated\n");
 
 	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
 	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
 	ksft_test_result(range_is_populated(addr, SIZE),
-			 "range is populated\n");
+			 "read range is populated\n");
 
 	munmap(addr, SIZE);
 }
@@ -194,12 +194,12 @@ static void test_populate_write(void)
 	if (addr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap failed\n");
 	ksft_test_result(range_is_not_populated(addr, SIZE),
-			 "range initially not populated\n");
+			 "write range initially not populated\n");
 
 	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
 	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
 	ksft_test_result(range_is_populated(addr, SIZE),
-			 "range is populated\n");
+			 "write range is populated\n");
 
 	munmap(addr, SIZE);
 }
@@ -247,19 +247,19 @@ static void test_softdirty(void)
 	/* Clear any softdirty bits. */
 	clear_softdirty();
 	ksft_test_result(range_is_not_softdirty(addr, SIZE),
-			 "range is not softdirty\n");
+			 "cleared range is not softdirty\n");
 
 	/* Populating READ should set softdirty. */
 	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
-	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
+	ksft_test_result(!ret, "softdirty MADV_POPULATE_READ\n");
 	ksft_test_result(range_is_not_softdirty(addr, SIZE),
-			 "range is not softdirty\n");
+			 "range is not softdirty after MADV_POPULATE_READ\n");
 
 	/* Populating WRITE should set softdirty. */
 	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
-	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
+	ksft_test_result(!ret, "softdirty MADV_POPULATE_WRITE\n");
 	ksft_test_result(range_is_softdirty(addr, SIZE),
-			 "range is softdirty\n");
+			 "range is softdirty after MADV_POPULATE_WRITE \n");
 
 	munmap(addr, SIZE);
 }

---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250521-selftests-mm-madv-populate-dedupe-95faf16c3c8f

Best regards,
-- 
Mark Brown <broonie@kernel.org>


