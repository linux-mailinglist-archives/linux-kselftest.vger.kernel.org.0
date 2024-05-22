Return-Path: <linux-kselftest+bounces-10591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D28CC838
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 23:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06EF1F21B91
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84407E575;
	Wed, 22 May 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZSV05dcW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AF146A69;
	Wed, 22 May 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414427; cv=none; b=HfB9pTHklwMoS1ZsEfWw/tsRwTL9N0XFg/6SeBnE4BdT+lP0Ybara39AQL9AV0pvbpC2puVXUVkH5DFzMwjejiv6ir7rCGH02oeJh4lwva1usumGrxMMgkka2xwnPF2hyLLxx1dVvulhK79awrUjwLmvE8sN+tpIBFeWSj8ZwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414427; c=relaxed/simple;
	bh=c4vBuU7VQ4mwFEFn2s+RaMllEqyyW2emcOv9iqGvLOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULlEezPGrZI2oW7nIt5vlXaA7mT6KWcXkrwHuHGIaneR6WDVMMqeGuqM/U6tNPpSpQNH+eX6kLfXPtExIdJNiosFXt5YUZOKbvK2wuHoRUVWDD10nMTTPWsBsePLu6KWIos0RDKfNNrbdr/bTck6ws85nomnoxA72zDzBvfQD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZSV05dcW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716414424;
	bh=c4vBuU7VQ4mwFEFn2s+RaMllEqyyW2emcOv9iqGvLOM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZSV05dcWkVQ8FSBYxpOXtffDFdzh8LXdBYkrp4Sy2c7vtNZEIFgH6c4RT62JNl1SS
	 N/xB+itHYM7Ek0D/pfC0nTFIeeMxD3QF21ifRBzMu55RDgM/p9nTtGrcbY7789okD3
	 ZYcD21LYRwl8OFWFd3XLIhaAmAZ9r39Qv6j/kR4KZmfLCJltuqFBH1gIPK34CvwfxA
	 2zG4mdpUEZz0pEgiLqcvvB3icAUOh6O4ZM8G6ArdEaSLi5ZcnYDrG791sNCLwQX0M9
	 PQMaCMvv2Y/IEGpZWsyMdgjmN2Ly4dkK/Qx4dVGBazLOEkT3vrhXaa91oKviIPHemo
	 bdCFAskYNfyGA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D24513782180;
	Wed, 22 May 2024 21:47:02 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: openat2: don't print total number of tests and then skip
Date: Wed, 22 May 2024 14:46:45 -0700
Message-Id: <20240522214647.3568788-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't print that 88 sub-tests are going to be executed. But then skip.
The error is printed that executed test was only 1 while 88 should have
run:

Old output:
  TAP version 13
  1..88
  ok 2 # SKIP all tests require euid == 0
  # Planned tests != run tests (88 != 1)
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

New and correct output:
  TAP version 13
  1..0 # SKIP all tests require euid == 0

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/openat2/resolve_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index bbafad440893c..5472ec478d227 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(NUM_TESTS);
 
 	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
-	if (geteuid() != 0)
+	if (geteuid())
 		ksft_exit_skip("all tests require euid == 0\n");
 
+	ksft_set_plan(NUM_TESTS);
+
 	test_openat2_opath_tests();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-- 
2.39.2


