Return-Path: <linux-kselftest+bounces-28159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A5A4D469
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A45E3AA14E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA51FBCA7;
	Tue,  4 Mar 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Foy7ocf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHZ3ceud"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E41F9ED2;
	Tue,  4 Mar 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072278; cv=none; b=pjJELmDkP46NOGJltm6JgtsKYWOqvbKjzD9jkc1J++cRiMnOtb+M2gUidCFFRQBoHsOX9O6sSEWlIzTnzqkwi5c+XIpmuJjqkUqOQUj8eBTt09g+nKWysvd9WgZ4tSCHc8h6KEZxJRk/hjkATOmCv86TqBZohQkECc6eqv6+Zxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072278; c=relaxed/simple;
	bh=kSJ+Swu+8W5z5Seyz15kYMb3i2VBeQ4nM5oEkTiuqqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqB9s1a0su4Oqm2w3Lq/cn+hzJvDWQO/unatKMg5vCEWn0W+Oko4uJchpWCZnIQfoJ1zHsh+dkAUqXttrls2iI8d+f4RqxFa1k6jxdBTP7+6Fwx6aC4AEbChfNt+XAeqnk3V7yiipt5R/YzPaEYMYYfUZFTeCTY9OwKrg/oJyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Foy7ocf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHZ3ceud; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5fJDHm1fiAcLVFAbsFNMIv1dhxq8wr/vlTGBhOEMio=;
	b=3Foy7ocfgaKPgPHbGoCI9EHbJoV/2cSCmCmMJlnpW3wBiKXckxUlAWzlVJAnBqT/+sdh0m
	23cBP3n6le/3kTeiOnaOab66gX0DNCsjCKxybWHkOn+99aYZ/ZB2EzDoGRpKelzC7zALpA
	z2nxAP1jA9vG7NBLIsHKA+dbJO1rNgIk+GyK4/w+hK9/yziFYayFrhvxXahORE2jX6KraG
	ilapXoy4IQBEKWXghbLX9j6a7n+8bfkZq5p852t10+cNMsEuJ2TMk+94IQr8MReRZMFCK9
	JGjIj7OsE+NVmkfpL/3F5ykOU6zHgYgW+nh6wkULZk2ixD3atDnIURB4DiYcFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5fJDHm1fiAcLVFAbsFNMIv1dhxq8wr/vlTGBhOEMio=;
	b=cHZ3ceudfxugqqPQI2imYFeWTqngdGIrDa2X6KshqlUNd2Xgz3WiOa/vryDGspPOyNjMhD
	4EACNXTXOGp3i+Ag==
Date: Tue, 04 Mar 2025 08:10:42 +0100
Subject: [PATCH 12/32] selftests: harness: Add teardown callback to test
 metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-12-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=2758;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kSJ+Swu+8W5z5Seyz15kYMb3i2VBeQ4nM5oEkTiuqqw=;
 b=8p3S6eNuXT4bQAFdkByTT4iEkOGZoRhEVO2OHQAZ23jsngVe85QW9ZvVL5HUv9iqHOEwf0j7U
 w/tiphNTr19CS3wicuPknVqcxj8lZcPttASaNT8jcjaKu666Dyl04OG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
from __bail(). Introduce a new callback for it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2f067c0f47729d10f205774e58dfd85866bd4c96..efc855b93315892a822c9eefc8d7a3784793c754 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -445,14 +445,10 @@
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
@@ -466,6 +462,14 @@
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
@@ -475,6 +479,7 @@
 		object->name = #test_name; \
 		object->fn = &wrapper_##fixture_name##_##test_name; \
 		object->fixture = &_##fixture_name##_fixture_object; \
+		object->teardown_fn = &wrapper_##fixture_name##_##test_name##_teardown; \
 		object->termsig = signal; \
 		object->timeout = tmout; \
 		_##fixture_name##_##test_name##_object = object; \
@@ -918,6 +923,8 @@ struct __test_metadata {
 		   struct __fixture_variant_metadata *);
 	pid_t pid;	/* pid of test when being run */
 	struct __fixture_metadata *fixture;
+	void (*teardown_fn)(bool in_parent, struct __test_metadata *_metadata,
+			    void *self, const void *variant);
 	int termsig;
 	int exit_code;
 	int trigger; /* extra handler after the evaluation */

-- 
2.48.1


