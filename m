Return-Path: <linux-kselftest+bounces-4824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE7857286
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C661B24839
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589928F5;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjVgmYGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF239D520;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043187; cv=none; b=fdDHKJE+aRQ1LmciaLFW137WMbitlJmbFN1j6BcLX5FL+n5iOGHorxoV500rDfQPr7iIsDK9ZuKyp56sINJPz292su4knmSNwEHoqoFIypKKUK4H4rX0onIex+eiMihq33MN39x8bUYabiVYY3VtYOrXu1NYMhUkrDfT867dw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043187; c=relaxed/simple;
	bh=Z9hNhdVvFV7ETtFUNB58TEtQQH7wuVllQqGyEb2w9Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycby38GRzmMicozC+04DBCRbxH5SkkTjlBK0SCt+rhq81NEff4EQbrES3mqj+/tUirtNBaXoSWJPU1RLp9krgqWqer4Awm8T1Gtw37riudIkGMQVYUhQIC2vfCIhZBLjko1HBedRz0guoncUBfUDLNooiom24Wdwqbt4IJqCdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjVgmYGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A313C43399;
	Fri, 16 Feb 2024 00:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708043187;
	bh=Z9hNhdVvFV7ETtFUNB58TEtQQH7wuVllQqGyEb2w9Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjVgmYGsl0+XRHuO2PWg/dI6SBCPGP47VNJIOyYsvbu0uTExqd8NOtBOVm9u7RF0k
	 6EA2mnCkSg8PdrD7MYZIUoq6AO8L7ypyRTFAqtyAZsjsM16yD+BE6Yy0SoSwR6ZJex
	 RafD2WkCniT68Nx1dhKmhe07hJNZyCw9sXboEJ+Yl2pJLhQnX1rKevS/NsdDHBpGIS
	 ZUMc9JzyVQ86bw2un6uiTVn4tJwugtEV+JTk753NVfeW9piZkBHm8k41s6eUELzrrN
	 0nCQghz/uQg7uzoLWBdtHHD/1nJXRlWb93Qh1fiT06AVUYPr8bO/5St7iC9GZM/KhK
	 JrlHbae80qHAg==
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org,
	keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/4] selftests: kselftest_harness: use KSFT_* exit codes
Date: Thu, 15 Feb 2024 16:26:17 -0800
Message-ID: <20240216002619.1999225-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216002619.1999225-1-kuba@kernel.org>
References: <20240216002619.1999225-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we no longer need low exit codes to communicate
assertion steps - use normal KSFT exit codes.

Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 98bdedf9a53a..618b41eac749 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -874,7 +874,7 @@ static inline void __test_check_assert(struct __test_metadata *t)
 {
 	if (t->aborted) {
 		if (t->no_print)
-			_exit(1);
+			_exit(KSFT_FAIL);
 		abort();
 	}
 }
@@ -937,7 +937,7 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (WEXITSTATUS(status) == 255) {
+		if (WEXITSTATUS(status) == KSFT_SKIP) {
 			/* SKIP */
 			t->passed = 1;
 			t->skip = 1;
@@ -950,7 +950,7 @@ void __wait_for_test(struct __test_metadata *t)
 		} else {
 			switch (WEXITSTATUS(status)) {
 			/* Success */
-			case 0:
+			case KSFT_PASS:
 				t->passed = 1;
 				break;
 			/* Other failure, assume step report. */
@@ -1132,12 +1132,11 @@ void __run_test(struct __fixture_metadata *f,
 		setpgrp();
 		t->fn(t, variant);
 		if (t->skip)
-			_exit(255);
-		/* Pass is exit 0 */
+			_exit(KSFT_SKIP);
 		if (t->passed)
-			_exit(0);
+			_exit(KSFT_PASS);
 		/* Something else happened. */
-		_exit(1);
+		_exit(KSFT_FAIL);
 	} else {
 		__wait_for_test(t);
 	}
-- 
2.43.0


