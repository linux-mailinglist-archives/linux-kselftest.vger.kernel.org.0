Return-Path: <linux-kselftest+bounces-7506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4339789E5A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 00:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9A1C20F1A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921B158D87;
	Tue,  9 Apr 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ0D5WTm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5F158A2B;
	Tue,  9 Apr 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701563; cv=none; b=mFqXMLd1EP8mnpYI3bY8BSOzwkUJCWnDZ/5v5raznCd3rthyp5bz6QPKC4TFgC201cVVIOAh77CW56LOwUAenAfabRz7GoG8jCFsRenBjI37f8u+jkaczKKoYgSJJr7YQWivICWXyMkWb/XVq9W5cz/AXsUNS4Ho4BAE5cdTRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701563; c=relaxed/simple;
	bh=8/cFucOeeKlTH3yzMI5vn5hL40q+Izc6GOcx3MvaKKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=smP0XZkab38XKxPhEnTqRfXdl9yTPvLyg9dXPJhp+E+IqD/ipwzUCdOir2BnU4j03S+AynXIoaT50oGZ2Y+9kwtKgdSHoc0Gj/XpYIAJ7rxe92NipuNkMrHdVq0Gkp+W8uYTmkp+e3ALh4iDY/FXjB2VkxQdzObQmz4B+KQpzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ0D5WTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37138C43390;
	Tue,  9 Apr 2024 22:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712701562;
	bh=8/cFucOeeKlTH3yzMI5vn5hL40q+Izc6GOcx3MvaKKk=;
	h=From:Date:Subject:To:Cc:From;
	b=oZ0D5WTmAdMKmTvopb0qjX7Kbcvi566oBYT1F4uWLFSL+kv8M6JXD+Prw3wjHkEVS
	 kRa5kzV0ZjWhj6xt3hzz+Sph366jhBf6+EZEaG9xSvAhvu/r0AMW/A7UQa0Ddp1m0L
	 65V05/hLl4FIpgjrgm/NSwbewBnpWC9z2E0MEm7hmrTluwSLBzCiC2DhlzZWleE2Qx
	 /uNbjw4WgFBS1kZBKnzgsxJ8CSmI3C2/HD7APuyLMcvuuID6sNYTdPRWuYDm4Gg5sv
	 TwuPiVr/QgE85n8oYdC2MgvlvxuXEk1WgQ8K03vEHPY9S+mCZRi/YdVy/x+zKEva/f
	 J8k/39CJ4wgQw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 09 Apr 2024 23:24:51 +0100
Subject: [PATCH] selftests/clone3: Fix compiler warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240409-clone3-warning-fix-v1-1-03720200f1b4@kernel.org>
X-B4-Tracking: v=1; b=H4sIADLAFWYC/x2MQQqAIBAAvxJ7bsFSQvtKdBDbaiG2UKhA/HvSc
 QZmMiSKTAnGJkOkmxOfUqFrGwi7l42Ql8rQq94ooxyG4xTS+PgoLBuu/KJ1Xg86DNY5ghpekar
 +p9NcygcFT906ZAAAAA==
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8/cFucOeeKlTH3yzMI5vn5hL40q+Izc6GOcx3MvaKKk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmFcB4ohOSySFEcqyRnkDV/zaqiFySgS3odCDfWUns
 mUWkvluJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZhXAeAAKCRAk1otyXVSH0IcoB/
 92YSQediGO39+3BGKBUczDGFD6CjDYL+/rJ6NhMSsGoc2U7QeU6Wxh+5uQXHwiAmmzAPLPLw3lrGmA
 bNuMGEwjmW3nksWuza+gTlrrelUUHUS4JWF8YmtyN3iu7zdJfoDiOm9O1L/tfjIYB/C9vhHp1nTx0T
 uD4INyFWeJ9g+VQjNcRDwJ44XCOyy1+84HR3dnaAJJSVMQeoEpKsFJAc3Fa0LMu383q0jeT4zH9+ns
 72HYJ2LdGyHtFvLOybVwq24caB+Zfm04kW7xaKJTQCuyYmRrA84fsOwXC9Ay5FI0ZwnF25Dz993oO7
 amj5K2hlGxDqWB1fiyEt+DbofsKRzy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Shuah reported a compiler warning with an Ubuntu GCC 13 build, I've been
unable to reproduce it but hopefully this fixes the issue:

clone3_set_tid.c:136:43: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘size_t’ {aka ‘long unsigned int’} [-Wformat=]

Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_set_tid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 9ae38733cb6e..fbf813a5a06f 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -133,7 +133,7 @@ static void test_clone3_set_tid(const char *desc,
 		"[%d] clone3() with CLONE_SET_TID %d says: %d - expected %d\n",
 		getpid(), set_tid[0], ret, expected);
 
-	ksft_test_result(ret == expected, "%s with %d TIDs and flags 0x%x\n",
+	ksft_test_result(ret == expected, "%s with %zu TIDs and flags 0x%x\n",
 			 desc, set_tid_size, flags);
 }
 

---
base-commit: a053fd3ca5d1b927a8655f239c84b0d790218fda
change-id: 20240409-clone3-warning-fix-89a363c6899e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


