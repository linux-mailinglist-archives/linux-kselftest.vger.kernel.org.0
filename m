Return-Path: <linux-kselftest+bounces-30198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE365A7D49B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2737A3B79
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F036229B35;
	Mon,  7 Apr 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXeZxYkv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJViICUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94308225A31;
	Mon,  7 Apr 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008789; cv=none; b=NVrr6nPTKexDoJhbLHsWyr+1JS4LqAQx0YLaWhUy7h5vZQyBHog2PkM/Lhaeea/eJEhR9UMJBIT42ZDZ0py2bXWDPC6hZtOGkzKq/GEfq6XSKwLcAqaCSttIGxFqV2695tl3Po0ZSZTvOdGWKaTRnsDUaRcqXoR4HImmlYM/DJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008789; c=relaxed/simple;
	bh=xsOgqpVF3xELBsCaLrwDdUg/BIkBndVgq3S6YVEJtrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkhqrAe1CF1Y7x65NShVXBqK8xpRFlvAuSdVZyz+1YwhGkdcWKT/emzkLLneNHxc9kDPl7WCiQ1WgVYfER4tZY/Lg7jkiqa9ma2bfzYf0hDFDmsuAofhYFsqVhRE/M1dvLauDTLMWNPbEVMtKPs1e1EC65jAfEHM5prc83opsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXeZxYkv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJViICUw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2m1ytKmJLv4W19Ree/8QxaUIOzVWzU9VNFHgbO9ms8=;
	b=IXeZxYkv1OYam7J/e0atSnptO2qbkkrLtOaK/c/gw73RJr6/YhVbIkLGwK0+6zI8KqIxCV
	0K/kVNkuQ5JrsE5Cge+pn7w/48yqKYinmw5BOfMcoZgKmtKIun1CqFgEgd/26OFQzDuaR0
	GzNk4LkMv84/b77g+qfVVyZeTOR+63zaK8kURTcjqcczS4wUtDK5WQ29Sa+CLslZPyVpU2
	PPYaO+43/qso9n2riBwzbkc1jXiitU7Vn++f7BvhMHZtvTD85qu7Jmoet+T74EkNtzyEGs
	Zexo8VgyjyPBM1evFZ/0uXTXmC11sm5HgtNcO8QpMDXclMtyGJjt8zNacZuwPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2m1ytKmJLv4W19Ree/8QxaUIOzVWzU9VNFHgbO9ms8=;
	b=KJViICUwFWy9pHzmhp6jnV1zB4MaHL9JfdvZhCtipA33x9pSmsMU6Gn7bBwHhf7KI8tKWb
	PXFjsHiNaZtQECDA==
Date: Mon, 07 Apr 2025 08:52:33 +0200
Subject: [PATCH v2 10/32] selftests: harness: Move teardown conditional
 into test metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-10-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=3443;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xsOgqpVF3xELBsCaLrwDdUg/BIkBndVgq3S6YVEJtrg=;
 b=wyJ1aTkDeVvu4HQE4t5UT7rxpGoIYKdi4n7ZZ+rPHeiFeibNPA85n82HuWlcxVcTBsHoh9k9J
 ysEX4balNVsA2xFN4Y/698QK/vtqcTEanYJa5piH0xOXKhyBt1Im9fX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
from __bail(). To access the atomic teardown conditional from there,
move it into the test metadata.
This also allows the removal of "setup_completed".

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4038ceeb42a870a2b77c6888df8a7bb4c4a258ba..790445c541aa3875d8d42822ab979295cc869d39 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -413,9 +413,9 @@
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
@@ -433,7 +433,7 @@
 				/* Let setup failure terminate early. */ \
 				if (_metadata->exit_code) \
 					_exit(0); \
-				_metadata->setup_completed = true; \
+				*_metadata->no_teardown = false; \
 				fixture_name##_##test_name(_metadata, self, variant->data); \
 			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
 				ksft_print_msg("ERROR SPAWNING TEST GRANDCHILD\n"); \
@@ -441,15 +441,16 @@
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
@@ -918,7 +919,7 @@ struct __test_metadata {
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool aborted;	/* stopped test due to failed ASSERT */
-	bool setup_completed; /* did setup finish? */
+	bool *no_teardown; /* fixture needs teardown */
 	jmp_buf env;	/* for exiting out of test early */
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
@@ -1197,7 +1198,7 @@ static void __run_test(struct __fixture_metadata *f,
 	t->exit_code = KSFT_PASS;
 	t->trigger = 0;
 	t->aborted = false;
-	t->setup_completed = false;
+	t->no_teardown = NULL;
 	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 

-- 
2.49.0


