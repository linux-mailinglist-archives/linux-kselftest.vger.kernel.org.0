Return-Path: <linux-kselftest+bounces-32377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94CAA972E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BA73BD015
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C897264F99;
	Mon,  5 May 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qRT+tLf+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SlVaeGvG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A025FA05;
	Mon,  5 May 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458179; cv=none; b=cPhBCWxoEYXZ4IQ6LOzPYchljDGQUEfUwEruQ/sanL+tGd1gEza3lWzI5ut3XcFYS6nq1DcHbsU1rHNJEZ1hVCqG95cGJ7JBeKBjjr06EmJFXtSFqx1W5KAiI/6VOkSiWKvFeFuE8SuNgTP2yUEzS1RSPEEyGmi5mk31qqR6iQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458179; c=relaxed/simple;
	bh=cIAbiYAQCJHymzx2YQGvNcUZ4KQQgJzrrBBrgowF7y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6XAO3dlrAzC4PUdor0okqgkdoPZgAr2ULQlGjzbVloqsuVzrQhT4NQbSkqExVy4qnpaFXQCkK9SIKIIoekD82o7VR94+HviNapSC36aFtThNPqL/7nDE3pYrTFrt3ec0tN2fqfSvrlcNJIKz6YTQdYm7jXrubjt+Jv8FP5ii7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qRT+tLf+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SlVaeGvG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMEjXYtOVelogEkWnB2vXLhzX+zDJWYDpEZ5D94Yo94=;
	b=qRT+tLf+oKx4L74EtcZzUTyE0xQngIOW3CLs7RAhA3Af0lEN0DJR9aFf1Bq2Fm6LcsujVa
	I1ZO/Q2KIeLXr8jvdGwWoL/AL9pbmjFvZwdTNsAb87m8vsFTwH/tq0oGvXKfnAonMe/6Mw
	kIY9ZpsO1IVRBJaVdzXAFRBxi4YgD7D7ErdooY4IeSaa9CUmJ3eRJJ1VD99kkCIykcCtzT
	d2Q3MVunTYBfjWd4c6QyOiEuv8BujUX8RsmT5z9zRigzOyrETe9fCsslMHr7wo+2E85A7V
	zYm6eqKvqGRVZuBCxYRVcTWlF4UYP4y4tzo7GgEz0nsyuNa3+oJ04Mbq36MPpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMEjXYtOVelogEkWnB2vXLhzX+zDJWYDpEZ5D94Yo94=;
	b=SlVaeGvGc4buCQYGOlwXeUvfNEr8RYUO5hztm5nxESs6hzSw+VpZHDp8eYQ4mYPhT2EvIP
	+2sk9rkmRu1hroCQ==
Date: Mon, 05 May 2025 17:15:27 +0200
Subject: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=3493;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cIAbiYAQCJHymzx2YQGvNcUZ4KQQgJzrrBBrgowF7y0=;
 b=coa6dTM3UXD4w8mifRa2JBo0DI+5K6TNWjweDiWu9YSxYlbCg7roxnFyUY9HCIG5ZkiRq0Bta
 8nYouNjdBUVBW2f49c/T+LPvE4ZUBOY8/aGB4uYaRsN1POohWNUVc2l
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
from __bail(). To access the atomic teardown conditional from there,
move it into the test metadata.
This also allows the removal of "setup_completed".

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 905986debbfb0ce8c9659dbd52b6c67c6759cae7..895821af3e5c5752065561d0a108210d79e9eeee 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -411,9 +411,9 @@
 		pid_t child = 1; \
 		int status = 0; \
 		/* Makes sure there is only one teardown, even when child forks again. */ \
-		bool *teardown = mmap(NULL, sizeof(*teardown), \
+		_metadata->no_teardown = mmap(NULL, sizeof(*_metadata->no_teardown), \
 			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
-		*teardown = false; \
+		*_metadata->no_teardown = true; \
 		if (sizeof(*self) > 0) { \
 			if (fixture_name##_teardown_parent) { \
 				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
@@ -431,7 +431,7 @@
 				/* Let setup failure terminate early. */ \
 				if (_metadata->exit_code) \
 					_exit(0); \
-				_metadata->setup_completed = true; \
+				*_metadata->no_teardown = false; \
 				fixture_name##_##test_name(_metadata, self, variant->data); \
 			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
@@ -439,15 +439,16 @@
 			} \
 		} \
 		if (child == 0) { \
-			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
-					!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
+			if (!fixture_name##_teardown_parent && \
+					!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
 				fixture_name##_teardown(_metadata, self, variant->data); \
 			_exit(0); \
 		} \
-		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
-				!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
+		if (fixture_name##_teardown_parent && \
+				!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
 			fixture_name##_teardown(_metadata, self, variant->data); \
-		munmap(teardown, sizeof(*teardown)); \
+		munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
+		_metadata->no_teardown = NULL; \
 		if (self && fixture_name##_teardown_parent) \
 			munmap(self, sizeof(*self)); \
 		if (WIFEXITED(status)) { \
@@ -916,7 +917,7 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
-	bool setup_completed; /* did setup finish? */
+	bool *no_teardown; /* fixture needs teardown */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
@@ -1195,7 +1196,7 @@ static void __run_test(struct __fixture_metadata *f,
 	t->exit_code = KSFT_PASS;
 	t->trigger = 0;
 	t->aborted = false;
-	t->setup_completed = false;
+	t->no_teardown = NULL;
 	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 

-- 
2.49.0


