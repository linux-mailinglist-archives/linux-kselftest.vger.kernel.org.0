Return-Path: <linux-kselftest+bounces-30548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDAA8574C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2749A100B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF2429B223;
	Fri, 11 Apr 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FN7Td7Wb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7G8B7I5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F11298CDF;
	Fri, 11 Apr 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362115; cv=none; b=b71LQ//XThsvsIKd0wS2NsaQ3PL3Jp+WDcPenRBwFWw3SboipkJWHAf/7DwLq9rXptSFeAs5qX0uNOd7moE87iKRcNG6cCPNaMc2/DsNmbAeCo6h13W+uXjsJsMvsFrtQ4wvv9ulp3ReIOSXGXdDgecTwH2S8CA+JTi4FLhH5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362115; c=relaxed/simple;
	bh=LGVMuklXgCkpJyincccVHRHsRYbHKB8kTUjlwhV0ovw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQxEPRwY13h4SU/AwJlfmlwkWGiocjHU1lH5SS2x3bJY8rcIYt8iu+NnTyMAX0EnUwlBGJ6lGdg+ZEty3quAxwpGHHgRkeRl+9sonYxPwVoLjUt4flBWwNJrTLmCA/K9saYvE/aCZRTXYZotnJZBerjkk2Dt4ifLwf3mSZIUC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FN7Td7Wb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7G8B7I5K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7VvCGnYllIwWlmCyX7MyWOjcCjHF74d/AC9380lrt0=;
	b=FN7Td7WbVj//5bhgC8Sue7qDOKKWCiKFQVOZhDfzoEJunTuF0GXNCuPOVMp6AB/HkoELfF
	gTviTKJC1/BYODUHegPMraBcmJ/Y93ertJ/qXjOcP/pUWELyw5CsBfM8UUZoYI33HyDsNs
	MueHtzi+8zpKyvUqDkpugOc9R1auZes2gY4i/jp+e4yJZuV9s7oh7JmnH/ebAMAXCYX9AU
	qhPxEiG6gTFgQ61TSkCxGJyOO6iMcmRjtqNp0PQSDscWso6Cv0MYhT+LHYGZKA7ocRdUAU
	FZ2ppzYLDO21xwglj06vSqff4p9GHL1zk5eHd62HEtEQeb94jHH0R3FJA5tZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7VvCGnYllIwWlmCyX7MyWOjcCjHF74d/AC9380lrt0=;
	b=7G8B7I5KzlBh2ZbB3HjwujV0zM7BGn6PbwFzy2Qn7614PD3v0uoL2mWv+ZP6x0vVm1Y8Sw
	raQCSkOmgVL68BCQ==
Date: Fri, 11 Apr 2025 11:00:35 +0200
Subject: [PATCH v3 11/32] selftests: harness: Add teardown callback to test
 metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-11-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2758;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LGVMuklXgCkpJyincccVHRHsRYbHKB8kTUjlwhV0ovw=;
 b=MSwLorvdyFqtJdr1shsNeIruj4rE0vaKAB7FtnDoPy3GOy6s/mbSzom/aGaC35vkf+ybn6T5w
 qEtq8IEpLbBC0b7OiU1Ux+bxZi7zJUdaEVE4htNSNJQaMBJOwruj+ux
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


