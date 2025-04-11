Return-Path: <linux-kselftest+bounces-30546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F34A85749
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7333BD8D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD02A29AB1F;
	Fri, 11 Apr 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w8ephqr4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwXooJ/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A52298CCA;
	Fri, 11 Apr 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362114; cv=none; b=oZ3YBtKBpd85WOTn2mO8rRD3GCLLUXVw2sx0tq1BfK/07gyrlt/jGHsBkbMARlwXToYrFekJkMPaccL/NYGktbO7m8zACQngANUbpaKtKjZDltiujZqmKzhMjcfhSa8QYSLbkfXAfVwhBW0cnJl5ahD2FphnfTHRKIZ7V7lAXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362114; c=relaxed/simple;
	bh=BVT171KPOVJVjfzTPXmBhG+I/rvwg4GYgQn0y8XhdF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZpwUK+DKcQspX+8cGG53LZZzFeuln3FYVeAez3MxNzTsPLMydiWY10qtyP95BXFwCXWnMgW2NmE5aO/bfDSnoAUCkQJm0k9tS7VUnqIxXVwS8rijwTSsCuKzNgi15FCNDo4TUsdBOmZE+D7pr5/OedF0WUMY6nNymMreJyRbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w8ephqr4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwXooJ/b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfHP6lDLf5mEBPgKe6QaxYDp7DWXdQcn3ptsh2iol5E=;
	b=w8ephqr44jeknOTrmQuSC0azDs+LLpv03987OQuDvtYlekDrfbE1JMuQfw1V0YkxEoykvk
	ldx9BZ6FWUBDSCJ2Rn4h+Mhs5LGelH8piTXz+vvFOg8mDquxFnmyq+8FlPTCRfMFtielss
	7Efx5SYyIcHkKr6Neeufsh0gfBEAO0e23PQUHP/fCHDfVrDON07GXcPbjsLADsFqkhOIrF
	BPbu5X7Nqf2qTiGmY0OrIjGVSYd1f1tVbSCttEhfnZ8GNkHrcp406eVzRnyRhqzSgy97lj
	sM8ruVCUJeZRFNMX+y9ZqyMWIQaDFrzuR0yljb64Bl/y712d+jVeEeulohZobg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfHP6lDLf5mEBPgKe6QaxYDp7DWXdQcn3ptsh2iol5E=;
	b=uwXooJ/bkze83Ndkth12mXwO6CddYWvLD88efqB0B/RkCAfsmL19afvepVhtMTJqiihJ69
	I3WltRHHtfcbM2CQ==
Date: Fri, 11 Apr 2025 11:00:33 +0200
Subject: [PATCH v3 09/32] selftests: harness: Always provide "self" and
 "variant"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-9-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1726;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BVT171KPOVJVjfzTPXmBhG+I/rvwg4GYgQn0y8XhdF0=;
 b=aE1YqloT5sq4xow8ECRqaLDPl36mLdTU8dQGj0XC555BvnmnlRrQDIhbo7rtJXZe1fqDzafs8
 YA3d26AOHXxBKzYxHVj47cdKMAL4gJEdzmkGy1B85V+T3eZjo4zzcUA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming changes to the assertion macros need those two symbols
also to be available for tests without fixtures.
Provide them with a NULL value.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 905986debbfb0ce8c9659dbd52b6c67c6759cae7..4038ceeb42a870a2b77c6888df8a7bb4c4a258ba 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -173,13 +173,13 @@
 #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)
 
 #define __TEST_IMPL(test_name, _signal) \
-	static void test_name(struct __test_metadata *_metadata); \
+	static void test_name(struct __test_metadata *_metadata, void *self, const void *variant); \
 	static void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
 		if (setjmp(_metadata->env) == 0) \
-			test_name(_metadata); \
+			test_name(_metadata, NULL, NULL); \
 		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
@@ -193,7 +193,9 @@
 		__register_test(&_##test_name##_object); \
 	} \
 	static void test_name( \
-		struct __test_metadata __attribute__((unused)) *_metadata)
+		struct __test_metadata __attribute__((unused)) *_metadata, \
+		void __attribute__((unused)) *self, \
+		const void __attribute__((unused)) *variant)
 
 /**
  * FIXTURE_DATA() - Wraps the struct name so we have one less

-- 
2.49.0


