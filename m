Return-Path: <linux-kselftest+bounces-28157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF2A4D462
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C59173615
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39471FBC82;
	Tue,  4 Mar 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjvghqnW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EnGwB1Mk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C31F91C8;
	Tue,  4 Mar 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072277; cv=none; b=daraYKZx4kn3WrZiTB4uv7tV1OO3sL5R0UMZkWu4IA/QYmSk7LhJeJjNyYBlTFwE2AFx295lfi0pv/vz9l/bcUMTFAsEwVtrqfvmU40+71RKSOjelEsY5xmyUwXEsbo7sT5h2Kai0iR83Ilz5eNDPI3k+oGIUyicYEKojGzeGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072277; c=relaxed/simple;
	bh=n11dzlHJKAUvcxhcZ3+QmW7/Z+t7UcsNSCN+9tRhJ+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1E4eF8LtgEWl8YcWcIkLz29BQnRsSElAOkzXCRxAv2F6mG+a8pQjSgw2SAHD/+MGUDS1rI2g18yo+pjhDN5sy3R7pyY9XO7+hpsqn/2SHDjkf1193C6AzvC3p0Uf0SwHAv7Fredk/AN4EHQmBAVTrEVD1l6RWuOsnvarTvS9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjvghqnW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EnGwB1Mk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGUzQQZccJ78cNMkb79/3IJvgD3Wyye1IF1KinfhvjA=;
	b=LjvghqnWKER74QEsfI+7+XrTBs5+Idbff1RJ06+YGd8XrhcoTeZRk2/XOYmMBTpiaPcJvW
	TlRAc4NfPW5kQgGllbUb96Pk8YOyVood6pJUuIHELtw+6vrs/oDnOLFBMzx3W060yLNx24
	c1y66gqfmEWAEcisF9mWChj58E3N6tiwqLbBNevuv0KybESi0pAh07X102vpcjLgg3Tw4k
	UuLug52Ia2hekTPxeKKZ7b2Q1Y1AUz/YnS0Ibdv4HgnhKykjvixzJVm2GRYOwaueVclB6Z
	LBiLDpU2X5/Vd09GbibXOwoZb0USASD0XciNGfGLiY3l3ahFqL+sviOqN74CvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGUzQQZccJ78cNMkb79/3IJvgD3Wyye1IF1KinfhvjA=;
	b=EnGwB1Mk2f0ifTBIhddUWkfJ0EtDFZwwdXVH+pYOHd4m1VRVuSyo9t3A3KugvIKDEXmdeW
	mvQjZ8sT83W8/tDg==
Date: Tue, 04 Mar 2025 08:10:40 +0100
Subject: [PATCH 10/32] selftests: harness: Always provide "self" and
 "variant"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-10-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1726;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=n11dzlHJKAUvcxhcZ3+QmW7/Z+t7UcsNSCN+9tRhJ+U=;
 b=gKYaxtFfX8nACnUEZqJ4cGUouQ8kniQXhS/hvIU4JW1t5iCEPnc88DTefdTufNmmjugH3weDk
 DGmv2zQ/nWJDQYFMdtIuFvABhNaowzOXl3qMtbNv59aBTwPi9OY0VNl
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
index df55b99d8abab2398d2eba5080c4d0c795688bc7..0ea3778a3a85fda6bc363d2b2e1038679920d22b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -177,13 +177,13 @@
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
@@ -197,7 +197,9 @@
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
2.48.1


