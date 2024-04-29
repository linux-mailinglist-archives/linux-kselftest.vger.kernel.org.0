Return-Path: <linux-kselftest+bounces-9067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290B8B61E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DE01C21676
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C05513C91B;
	Mon, 29 Apr 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aDu2RMiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DD13C682
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418368; cv=none; b=cAzhAmOgubEW4Uz3idV16dS2kI0YXbz0utvJYfYUj1tYJTs3VX1cp7yglxWJ7WT6cJqlIiebU6E2q5h5DQqlrIGEoshvhraX4uNPAt4ANZBEDXbgMuPBmbudC4zvU05+duj1NLVDNkNd8xb/9JGaMVGBCSsGTzk26pjvAFGC33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418368; c=relaxed/simple;
	bh=YNoWdpho3K357HAWa8pQd6LbWwT9b05aCa7duYxa780=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFbQxkMr9gGUjiqyTqGnO7PfFW1PIn+HCcnfESFOMGb410q1h+vjGbnNbx395X3NkTyCNfvGBq2IFWwkldsOaV2xuEHLz4wn1VGlpJBjSmxCGkSoecGGYzMV7xUGhBbTqnq9XiKccBSyTRW+t5QoiOlkHW4mAlGCO9EjNHg55pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aDu2RMiu; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRn0k6DzFqR;
	Mon, 29 Apr 2024 21:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418356;
	bh=YNoWdpho3K357HAWa8pQd6LbWwT9b05aCa7duYxa780=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDu2RMiujrXkuiKN7rYDW30rxfl+DeJuz3aPRZvmJKP7p4RpKn5ioq9WTnJzgoV4A
	 RliCX4NKQaoRTS18r8V1vdsHvZ6AJ9NXFJ/uwsLrSuJhpypFRLT9Vb7Kq/eqtN66cP
	 wPRvXUZDnUKC+VJLtD4SLZmmV/86g6jEz+fTfvss=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRm3rxBzWvq;
	Mon, 29 Apr 2024 21:19:16 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 3/9] selftests/harness: Fix fixture teardown
Date: Mon, 29 Apr 2024 21:19:05 +0200
Message-ID: <20240429191911.2552580-4-mic@digikod.net>
In-Reply-To: <20240429191911.2552580-1-mic@digikod.net>
References: <20240429191911.2552580-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Make sure fixture teardowns are run when test cases failed, including
when _metadata->teardown_parent is set to true.

Make sure only one fixture teardown is run per test case, handling the
case where the test child forks.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shengyu Li <shengyu.li.evgeny@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Fixes: 72d7cb5c190b ("selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN")
Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429191911.2552580-4-mic@digikod.net
---
 tools/testing/selftests/kselftest_harness.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d98702b6955d..55699a762c45 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -382,7 +382,10 @@
 		FIXTURE_DATA(fixture_name) self; \
 		pid_t child = 1; \
 		int status = 0; \
-		bool jmp = false; \
+		/* Makes sure there is only one teardown, even when child forks again. */ \
+		bool *teardown = mmap(NULL, sizeof(*teardown), \
+			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
+		*teardown = false; \
 		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
 		if (setjmp(_metadata->env) == 0) { \
 			/* Use the same _metadata. */ \
@@ -399,15 +402,16 @@
 				_metadata->exit_code = KSFT_FAIL; \
 			} \
 		} \
-		else \
-			jmp = true; \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
+			if (_metadata->setup_completed && !_metadata->teardown_parent && \
+					__sync_bool_compare_and_swap(teardown, false, true)) \
 				fixture_name##_teardown(_metadata, &self, variant->data); \
 			_exit(0); \
 		} \
-		if (_metadata->setup_completed && _metadata->teardown_parent) \
+		if (_metadata->setup_completed && _metadata->teardown_parent && \
+				__sync_bool_compare_and_swap(teardown, false, true)) \
 			fixture_name##_teardown(_metadata, &self, variant->data); \
+		munmap(teardown, sizeof(*teardown)); \
 		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
-- 
2.44.0


