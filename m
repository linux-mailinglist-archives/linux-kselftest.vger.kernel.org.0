Return-Path: <linux-kselftest+bounces-30195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6A1A7D49C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDF716895E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E9227E94;
	Mon,  7 Apr 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="119EFkKa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="brpD5Vq0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF89226CEF;
	Mon,  7 Apr 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008787; cv=none; b=FvKGU/+dVYuFHemSLYgheN4RFQVgderNv4CMtl1sa7vIwcodXm0wNzkW/xUcmJWAqC4XvspA7UZn0zzqAOyrpeM/ffnNMGJ09GUunkoZodqQ0/vokZpf3L+7w748ly08Id2PohKkOMnn1PPEul1eFVmRzI+Ee2wkwB60VVawAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008787; c=relaxed/simple;
	bh=BVT171KPOVJVjfzTPXmBhG+I/rvwg4GYgQn0y8XhdF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqO53ILp4Vjv4q1Pm0g3cQOBuYVOgcMgG1JFKw58Htx1MwJ2/mOlU1CrsiM6pVho3QAu3qrv7+smXtkDNQ6dqEpvJTML7HHeQtawTJ7ZVLFbGhA41LOYa/HT/RhUAEAsp1A25XxC+JS8xoaad0H3/IxGT0ldyHqhAmZdqV2HIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=119EFkKa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=brpD5Vq0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfHP6lDLf5mEBPgKe6QaxYDp7DWXdQcn3ptsh2iol5E=;
	b=119EFkKaDIyTry59mhF6Nj6Q8i7IqCcSaEij1XCc1mx/ic9n0pXXKk6e7oNKqnLWaHGkJf
	ldRmSURSE8UsakW5GFO/dt74mmrVATJcVUp6Xx4bEvNuiTrL24/OCoiaOynD11XmV2NlIJ
	wMsAGRg5D9wFMkxWBrTGWHt1os6cYBFwrWBi07IZ4IMVMmM1W2yr9TdPk4qRaMyKQ/Ec6B
	bTUTeY9DDqM6Uk3S5HHxbITusezgF/D5OnDwpKgffDp0tEZzp/nek0l6KpOs1V14t7HOol
	71T+6/kvczJYNY+3vbIgYwZCCTqnpW0HmwnZt/udOO/zYCYfuFVCE1aF3CxmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfHP6lDLf5mEBPgKe6QaxYDp7DWXdQcn3ptsh2iol5E=;
	b=brpD5Vq0BTZ60J3GCjNOOZ9F9JyPzhxGSaA5sCouL/MGLReltn+Hy0hP45hxlAXZzER1nR
	OMgBH6tFovjADcBQ==
Date: Mon, 07 Apr 2025 08:52:32 +0200
Subject: [PATCH v2 09/32] selftests: harness: Always provide "self" and
 "variant"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-9-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1726;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BVT171KPOVJVjfzTPXmBhG+I/rvwg4GYgQn0y8XhdF0=;
 b=EVaqUXTX8S9p1Cg05h5IAzL1hFWtZWPygOsiGMSM2xZxIZYd0RG4EAh48/iKnVjIo+l+BSYgT
 xW1vK0VlblZCEl37Zi1EzwYnJZkbex40hwjlCfLlnknujFbK/sA0/cQ
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


