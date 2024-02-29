Return-Path: <linux-kselftest+bounces-5568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6726386BDB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1C5280CCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C2383BE;
	Thu, 29 Feb 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGyglxSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBB383A6;
	Thu, 29 Feb 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168369; cv=none; b=D992hQ5S5DMnM+7JeL8D0n9fyu6NuX67O38nWb/nag2vWHejBwas3lVS2MQtmtomDXNCBR5UEN0KtJyxy7wMd/bji63qlkyLnuOhOywodiMYrxHINIVaB6c6U9JwIloT/RQvPLqX7SwoEaUfPBtnNmowtymazmvlPT0EQ6tlfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168369; c=relaxed/simple;
	bh=bjj80Pj8TBirff2iGjilAsXR8Ov3uSNGQxuJFTzd6G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoxuZzQ8v5x/tihCrQPhxbAG3UCwKJ3uV5c5/zqXhAot1SApWH2NNmKNXY1BB92CGUBSRaLQLrqZ0/OairISCL8nuqvb5nt4W/w69aJf4LuTkNkCirK5wV9a1lTndavFku3wYnwnNz4Pa5gEYxnWGTyeGmUPsKfD9GImSVZvzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGyglxSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D953AC433C7;
	Thu, 29 Feb 2024 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168369;
	bh=bjj80Pj8TBirff2iGjilAsXR8Ov3uSNGQxuJFTzd6G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGyglxSn9kY+W8+CIhSmYrcJTHl6+H0ODObTgT1NlTXfFgmXqlfMo2gz/2CoCaCIo
	 7MA6b/k9fO1Svk1e74kekY8FpBIDPWPe53wuwGCfUNI31/usk2XJCd9h4M0CGB8JKZ
	 ezm7Mu8T/jn2oVMjH6MubYJMF6R70ZSvzyQ0+1pfoSc2O1fa/ue1zMM6kJtQMFbXM8
	 HsuqtMvYg4fTLYi47g1N8Ca6LXh3i7wCRrp+ylZOMsVoVpGe8juc/fxrxvTil+PGt5
	 XDY8LAz/9TXbTBtWjiZE/c7ju1fY8wh7OsHMtBp4j1gNJSOyccnOnq3hHAG19y5JH4
	 5QrXOIs4sLupQ==
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
Subject: [PATCH v4 03/12] selftests: kselftest_harness: use KSFT_* exit codes
Date: Wed, 28 Feb 2024 16:59:10 -0800
Message-ID: <20240229005920.2407409-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
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
 tools/testing/selftests/kselftest_harness.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ad49832457af..62ce258b0853 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -936,7 +936,7 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (WEXITSTATUS(status) == 255) {
+		if (WEXITSTATUS(status) == KSFT_SKIP) {
 			/* SKIP */
 			t->passed = 1;
 			t->skip = 1;
@@ -949,7 +949,7 @@ void __wait_for_test(struct __test_metadata *t)
 		} else {
 			switch (WEXITSTATUS(status)) {
 			/* Success */
-			case 0:
+			case KSFT_PASS:
 				t->passed = 1;
 				break;
 			/* Failure */
@@ -1128,11 +1128,10 @@ void __run_test(struct __fixture_metadata *f,
 		setpgrp();
 		t->fn(t, variant);
 		if (t->skip)
-			_exit(255);
-		/* Pass is exit 0 */
+			_exit(KSFT_SKIP);
 		if (t->passed)
-			_exit(0);
-		_exit(1);
+			_exit(KSFT_PASS);
+		_exit(KSFT_FAIL);
 	} else {
 		__wait_for_test(t);
 	}
-- 
2.43.2


