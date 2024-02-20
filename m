Return-Path: <linux-kselftest+bounces-5061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A285C49A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08211F243FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA614C596;
	Tue, 20 Feb 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q90ixN/f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223F135A4D;
	Tue, 20 Feb 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456968; cv=none; b=IgsVLWtL0EyJBoR4xWjha3Tm7vXbbklAdlzpCPmaaq/X21fKRo81pauzIxgIuq+fHhTTehwLZPXW0WH3u8m7vJGUae4fy+4C6rwEZ3fXKLjtQWMzhWd5nMQ/yEabot2VDZCnMjj6YT4KpxrEhW9XZIeUKgExBlii37wRkQe2FDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456968; c=relaxed/simple;
	bh=y1jR1SPhv1Na8mdweF3oZSOv0tk/hgB4rcZ8s6PB+T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqwqXQ4RhtaYtvVR494wx5m83U6/Mi4dNPeSupegnrtTZbg0AEgOuwFERtjm+VoqgpiSExLqnt2mxGpS3iZaPMykbOjAEFA4z5/f3rkLu3aflBxY7fwbhhTagUc3n/FdtfyKUcI0mGCONlQTfpabycaUQ6ywnAbNK8Zw7besOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q90ixN/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B11DC43394;
	Tue, 20 Feb 2024 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456967;
	bh=y1jR1SPhv1Na8mdweF3oZSOv0tk/hgB4rcZ8s6PB+T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q90ixN/ftQd5E433nAU54KmV61A34UqBg+LV+Itk6jz2YGj5L4GDZSyMCbuNO4Xkd
	 nw41HW+hVfYjJZHkm28GH/PI8Qst6z4xfoaMBDoZGFucZiKwZW7gwcWWkAnpgiImX+
	 +CsNU4du5h8k7IeHKP+3eDrOER5XZiruRy87q2ZOgprVA8AN9mxACIdAR4PH8MV5Xq
	 J3OBn8tm4nv7FMU8uzSPFI/mVQ6QjShFo03ST880rCH1l2x3ax/21L3ohzzdzrnI+2
	 5BHia/i6VTN3zb74Ro1dwwmBc5wv+jRNJnuKKQpDzhFbgnkfUuIlRbWHjibJKj/Cif
	 fImUkwBTHE77w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>,
	luto@amacapital.net,
	wad@chromium.org
Subject: [PATCH net-next v3 02/11] selftests: kselftest_harness: use KSFT_* exit codes
Date: Tue, 20 Feb 2024 11:22:26 -0800
Message-ID: <20240220192235.2953484-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
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
CC: keescook@chromium.org
CC: luto@amacapital.net
CC: wad@chromium.org
CC: shuah@kernel.org
CC: mic@digikod.net
CC: linux-kselftest@vger.kernel.org
CC: linux-security-module@vger.kernel.org
---
 tools/testing/selftests/kselftest_harness.h | 13 ++++++-------
 tools/testing/selftests/landlock/common.h   | 10 +++++-----
 2 files changed, 11 insertions(+), 12 deletions(-)

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
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index c15e22abdca6..f5b40399a538 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -47,10 +47,10 @@
 			_metadata->no_print = 1; \
 			fixture_name##_##test_name##_child(_metadata, self, variant); \
 			if (_metadata->skip) \
-				_exit(255); \
+				_exit(KSFT_SKIP); \
 			if (_metadata->passed) \
-				_exit(0); \
-			_exit(1); \
+				_exit(KSFT_PASS); \
+			_exit(KSFT_FAIL); \
 		} \
 		if (child != waitpid(child, &status, 0)) \
 			abort(); \
@@ -60,10 +60,10 @@
 			return; \
 		} \
 		switch (WEXITSTATUS(status)) { \
-		case 0: \
+		case KSFT_PASS: \
 			_metadata->passed = 1; \
 			break; \
-		case 255: \
+		case KSFT_SKIP: \
 			_metadata->passed = 1; \
 			_metadata->skip = 1; \
 			break; \
-- 
2.43.0


