Return-Path: <linux-kselftest+bounces-30196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BFA7D499
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98F3188E424
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EF422838F;
	Mon,  7 Apr 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WdyOPdFu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUuS3g/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C2227B94;
	Mon,  7 Apr 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008788; cv=none; b=QdFMDd1Ns4LRpO+nEenfQCZlq7rF4LDyoa2+c6rH15RD2TgVImdzyLdndyW5n82t7SlLssWczQQNXzxDN3QldSGpGhdIcUq6IfTrNbcXSsWRbwklC7Xkt5x8t8boesV2tYTCOOycPmDT9Y5hnDra4wpN8753wD6UcxiKyDPIHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008788; c=relaxed/simple;
	bh=LGVMuklXgCkpJyincccVHRHsRYbHKB8kTUjlwhV0ovw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rt9JSsuDaYguscXpdUXB43mCnA2jwvyrV7I3ZnJjbPSntVfFSZBS36xkIV2P+SCB/z0OiooCVLo3aN4KXONfsY4lqFhEmhUtNkJ0sudroopksFH2/fVufsAr0p+5fHPnsod72/AiYVa1ET7YTT8QFHdjPwBKKemPbN67o3zxlCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WdyOPdFu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUuS3g/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7VvCGnYllIwWlmCyX7MyWOjcCjHF74d/AC9380lrt0=;
	b=WdyOPdFu3mOYACexSwGyIMhbG3Ql1IiPr/0+tW0iGj56hbhItBLhdC0sWVK17KN77/H/9V
	OyvCzatOfbdct3YnSBRWCJ/f7mV6HXxBURT9KSZ2nmOpFuf+y32jXix8UZzDc2TW6woQMW
	9Oc/6wxf4sgBnt6WE/gEqTaokT4mtvLNgCzkfZKl6qQypfF5n51GZlL04R/8OVc2O9+oh4
	HsDo0t/E7+GwS0dl7blzbgU0o0ck3hYWp7wUaT1s9nNDkWjqqDTk/zjkA5opS/WYY61aJl
	k/IQQOZ+zmytx+KeAMq4aRZPZyqNWPSbEOH0CxLImBQPU+CVooaIMfmu9NX0Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7VvCGnYllIwWlmCyX7MyWOjcCjHF74d/AC9380lrt0=;
	b=dUuS3g/nIJPohoaV7YioHFC+czIeyDLogcqrOFjgOfLrwoHv7jV70kdzbrYTu6aVX+ZRVs
	fiZdNZjGb4RJcsBA==
Date: Mon, 07 Apr 2025 08:52:34 +0200
Subject: [PATCH v2 11/32] selftests: harness: Add teardown callback to test
 metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-11-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2758;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LGVMuklXgCkpJyincccVHRHsRYbHKB8kTUjlwhV0ovw=;
 b=mDCKvXHrs+8EhNHov9yHAtB/weKXm8CTu3PLsSAatKJgPJRPOu2EE7M/4hurod/yrSF0CixIQ
 8t7BNCZl6liC/cf90d52vtZpI90PYi6BiqnE/VlaO0MhHXPwfse7mJH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
from __bail(). Introduce a new callback for it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 790445c541aa3875d8d42822ab979295cc869d39..5373b8da8886aef5df3368aeff95080636ae2343 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -441,14 +441,10 @@
 			} \
 		} \
 		if (child == 0) { \
-			if (!fixture_name##_teardown_parent && \
-					!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
-				fixture_name##_teardown(_metadata, self, variant->data); \
+			_metadata->teardown_fn(false, _metadata, self, variant->data); \
 			_exit(0); \
 		} \
-		if (fixture_name##_teardown_parent && \
-				!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
-			fixture_name##_teardown(_metadata, self, variant->data); \
+		_metadata->teardown_fn(true, _metadata, self, variant->data); \
 		munmap(_metadata->no_teardown, sizeof(*_metadata->no_teardown)); \
 		_metadata->no_teardown = NULL; \
 		if (self && fixture_name##_teardown_parent) \
@@ -462,6 +458,14 @@
 		} \
 		__test_check_assert(_metadata); \
 	} \
+	static void wrapper_##fixture_name##_##test_name##_teardown( \
+		bool in_parent, struct __test_metadata *_metadata, \
+		void *self, const void *variant) \
+	{ \
+		if (fixture_name##_teardown_parent == in_parent && \
+				!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED)) \
+			fixture_name##_teardown(_metadata, self, variant); \
+	} \
 	static struct __test_metadata *_##fixture_name##_##test_name##_object; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
@@ -471,6 +475,7 @@
 		object->name = #test_name; \
 		object->fn = &wrapper_##fixture_name##_##test_name; \
 		object->fixture = &_##fixture_name##_fixture_object; \
+		object->teardown_fn = &wrapper_##fixture_name##_##test_name##_teardown; \
 		object->termsig = signal; \
 		object->timeout = tmout; \
 		_##fixture_name##_##test_name##_object = object; \
@@ -914,6 +919,8 @@ struct __test_metadata {
 		   struct __fixture_variant_metadata *);
 	pid_t pid;	/* pid of test when being run */
 	struct __fixture_metadata *fixture;
+	void (*teardown_fn)(bool in_parent, struct __test_metadata *_metadata,
+			    void *self, const void *variant);
 	int termsig;
 	int exit_code;
 	int trigger; /* extra handler after the evaluation */

-- 
2.49.0


