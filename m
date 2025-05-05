Return-Path: <linux-kselftest+bounces-32376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFDAA972F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF937ABB84
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB6264A8E;
	Mon,  5 May 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BO7ZlM7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtRHjeGs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8372609DF;
	Mon,  5 May 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458179; cv=none; b=uiwnNkPphPJNJ06w/r/D8O6q4xpKQA4zMXOMM/mW1a9jnRa/yHZt6rxPmkFWO7hNmNYfwf8OiWrSHjqTbO8M3+RLaXlfX/oeA4Q3h8KwbBPhFBXiI3MfKFBNZA557e6QOGDx/pOsQF4vEBdU5/cwRlt3feBSB8OwgnjPUSOLHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458179; c=relaxed/simple;
	bh=4EziIyuNtndmKe4I0VA1SvkCzM+7fFihUqiCilnzZyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBD2FYDnqfFc2uonpm0osHYLSDdeDM3jwEaYRNIzg6DuWWrPpP8cJiYsIvAsqFK3weMwKHZ69dOgJwBLpIkEvJqqbgCyzIpaGAPGgtKU4aCL78ax1yHN93BYCSWCkuoXT9FJYff6/0zKXyzSejAM7mWxVHhafNBNZeTbMQrwpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BO7ZlM7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TtRHjeGs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRjOGqv37y13JtLIhuaeoavB7nfm6OGp7fisOHTFIKE=;
	b=0BO7ZlM7gOgRz3IOpb5wx/AxOGnhn1XBL/+mNvNSGNJcBIxAAaBrMpIA0Uu5eOToa5dieA
	QxnO4mOh2QylrwPhyS73wcwmVcWM5RvKFlZS55ligHe665Zg65o5ngJzyndCTKnpp4L9xK
	w4O0pkiVCyWG7TQxEDHO8/91GVycHTECkev1qkt8zrJ7wTyvF3SNrw8mzM9wTVLxpQ4+OL
	44hQoID1w2QNPCVz+kRZVRTASmBdEXhWWJzsS/nIc2/IMjvwaOb/7mjXOEgA0MWmaOEQ/y
	pHaUNH9HzVdZ8E4u6RBba4VBwiiHZWZ0G14yF+aJn4d85aSSWE6o//FfEJxCCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRjOGqv37y13JtLIhuaeoavB7nfm6OGp7fisOHTFIKE=;
	b=TtRHjeGsR4cUpXAmzddlmwcjqW0tS3bqo7q/1CaDq6OmAw8/x79ilhCOEMc3fo1uAVW3NY
	9titQIrFyHPqf5CQ==
Date: Mon, 05 May 2025 17:15:28 +0200
Subject: [PATCH v4 10/14] selftests: harness: Add teardown callback to test
 metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-10-ee4dd5257135@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=2808;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4EziIyuNtndmKe4I0VA1SvkCzM+7fFihUqiCilnzZyM=;
 b=rGYg0T7+Pz/BkXBpWkZILIHEDS//4/mlvrWD6+/nhgizcYbeM7FBiIAjXoTKTqm7WkESdxdtE
 4zUxRFTQR7TAgfaNutPfMnpO3pEvXuV/ZLTXUFSYjPKuwwDAwp4MsPu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
from __bail(). Introduce a new callback for it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 895821af3e5c5752065561d0a108210d79e9eeee..acb476093b74968ecb71180ade9e5852b22da170 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -439,14 +439,10 @@
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
@@ -460,6 +456,14 @@
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
@@ -469,6 +473,7 @@
 		object->name = #test_name; \
 		object->fn = &wrapper_##fixture_name##_##test_name; \
 		object->fixture = &_##fixture_name##_fixture_object; \
+		object->teardown_fn = &wrapper_##fixture_name##_##test_name##_teardown; \
 		object->termsig = signal; \
 		object->timeout = tmout; \
 		_##fixture_name##_##test_name##_object = object; \
@@ -912,6 +917,8 @@ struct __test_metadata {
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


