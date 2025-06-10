Return-Path: <linux-kselftest+bounces-34596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F4AD3B03
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DDC17B6C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7F2C1798;
	Tue, 10 Jun 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvEJkNA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB429C33A;
	Tue, 10 Jun 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565117; cv=none; b=aUH/At9pW9TDiyCAKULdTsWGrDtZ+z/F1yQCdzvhYdG9hnp+56ZXvOx4wSSWpqisDe68QQ2oU5Ez99hEvZygxnXJlbA0axS5KcoENmDncqEHGPTv6q+N8pvk3SoOW28auyHoDfcXrrKPeqI1ExBGUpCm1BjMx0v0v9eoXRYGihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565117; c=relaxed/simple;
	bh=XIqlvXcLhigaPQ9Uiztdzq4aV3ciRSHw6O22PqR8rDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+ywzE5GgY1X9tY19ltlLKd1Ik3E7YmM6GxSQhxOUAy0zaP35K3M8RIEfuK3bz48Z058ONx51WXdMaMDTQH9ONYFWteVcbTsIrsmGfMsZB1LyanEjvCf/TkjpEOGI38dgaeXST9ScoyNQFfXmb7Cak4Y0vd9AFDvBVQzTXhaMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvEJkNA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A9FC4CEF1;
	Tue, 10 Jun 2025 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565117;
	bh=XIqlvXcLhigaPQ9Uiztdzq4aV3ciRSHw6O22PqR8rDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fvEJkNA81zAL7NF8UKiSuwgNZEWLUkVEUY/DR1hVDBAwmDzKco7CtDda8YUlLICfT
	 e8GvGMLPXC4h/lOwBep3rHrkxXer83eUT/HjAV33gvLE0SQN+ioXVCewGK3+sakL1W
	 GgWXCdVGuZ1I29KVmkR/e8t71KSEVAvg5cG0BnP86cvQivSkfwEBbJvSTe/G90ZnVp
	 U6Htk7qZ0Q50T+MXpdZvqoXC8P/IfZ9/G+izpnrYuP39rD849IemRZEaLWjUUX1495
	 /1PDbI3TChQCZzTA9HsGvrm9kjLUTAfDw5xVycdm7/wC0cYiSO1Abu6DGLsrk5pxqa
	 d5g7+Odfj+mIQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 15:13:57 +0100
Subject: [PATCH 4/4] selftests/mm: Add messages about test errors to the
 cow tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-selftest-mm-cow-tweaks-v1-4-43cd7457500f@kernel.org>
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XIqlvXcLhigaPQ9Uiztdzq4aV3ciRSHw6O22PqR8rDU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSD6z7nodlgS22VhRNHY97fp3ZLzuwRlu31UHzQwB
 gXw7IGCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEg+swAKCRAk1otyXVSH0PuSB/
 9Gzkq/wcaXkrOxcFyL1WuVMFr8UsfjIpTwUaNEqszIp9AWmFw/DzRxjm33G41mFMQr1kRnUa0VtOqO
 aj1PB7cWiOLoalM2Z2ZwH7P0sa0Eqh0NI5kZ/4yiOpUDJVPnTuYtiw87wFWxKPn/Je0qO2sace67zh
 8g4xKUoaU0Xi6lgPjnHDQjEEF9+US9M+nKjGzwJQmE7qw56NVvqbva0YpiaIKWvnXLFO32x8KRiwDN
 hJ+z5+qfe/bOTdsWuruJZM5sAEBHjCiAxleGAN/8dnoCXCIdfDXOPULSGQkdcAcjOtwjOcVMTMP5rL
 NmLXpU70IC61Cn+eVEiZj9gd48ZDu7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

It is not sufficiently clear what the individual tests in the cow test
program are checking so add messages for the failure cases.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/cow.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 48fcf03aa4cd..29767e2afdd0 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -268,8 +268,10 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
 		 * fail because (a) harder to fix and (b) nobody really cares.
 		 * Flag them as expected failure for now.
 		 */
+		ksft_print_msg("Leak from parent into child\n");
 		log_test_result(KSFT_XFAIL);
 	} else {
+		ksft_print_msg("Leak from parent into child\n");
 		log_test_result(KSFT_FAIL);
 	}
 close_comm_pipes:
@@ -397,8 +399,10 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 		 * fail because (a) harder to fix and (b) nobody really cares.
 		 * Flag them as expected failure for now.
 		 */
+		ksft_print_msg("Leak from child into parent\n");
 		log_test_result(KSFT_XFAIL);
 	} else {
+		ksft_print_msg("Leak from child into parent\n");
 		log_test_result(KSFT_FAIL);
 	}
 close_pipe:
@@ -570,10 +574,12 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
 	}
 
 	/* Finally, check if we read what we expected. */
-	if (!memcmp(mem, tmp, size))
+	if (!memcmp(mem, tmp, size)) {
 		log_test_result(KSFT_PASS);
-	else
+	} else {
+		ksft_print_msg("Longtom R/W pin is not reliable\n");
 		log_test_result(KSFT_FAIL);
+	}
 
 quit_child:
 	if (use_fork) {
@@ -725,10 +731,12 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 		ksft_perror("PIN_LONGTERM_TEST_READ failed");
 		log_test_result(KSFT_FAIL);
 	} else {
-		if (!memcmp(mem, tmp, size))
+		if (!memcmp(mem, tmp, size)) {
 			log_test_result(KSFT_PASS);
-		else
+		} else {
+			ksft_print_msg("Longterm R/O pin is not reliable\n");
 			log_test_result(KSFT_FAIL);
+		}
 	}
 
 	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_STOP);
@@ -1417,10 +1425,12 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
 	else
 		ret = -EINVAL;
 
-	if (!ret)
+	if (!ret) {
 		log_test_result(KSFT_PASS);
-	else
+	} else {
+		ksft_print_msg("Leak from parent into child\n");
 		log_test_result(KSFT_FAIL);
+	}
 close_comm_pipes:
 	close_comm_pipes(&comm_pipes);
 }
@@ -1528,10 +1538,12 @@ static void test_cow(char *mem, const char *smem, size_t size)
 	memset(mem, 0xff, size);
 
 	/* See if we still read the old values via the other mapping. */
-	if (!memcmp(smem, old, size))
+	if (!memcmp(smem, old, size)) {
 		log_test_result(KSFT_PASS);
-	else
+	} else {
+		ksft_print_msg("Other mapping modified\n");
 		log_test_result(KSFT_FAIL);
+	}
 	free(old);
 }
 

-- 
2.39.5


