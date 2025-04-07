Return-Path: <linux-kselftest+bounces-30192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2658A7D49A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C825F3B03BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D8226D04;
	Mon,  7 Apr 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3Jpdo1N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mnbNiMQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110D225798;
	Mon,  7 Apr 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008785; cv=none; b=ZXG4EObV4qgwd4kdOiAIevLDWbeSD0tJ1+MjFsUAzLqOjrGAu+KDNsvdBjnuzCB2Gofv6F42V4BqZ8aiKehDMXK6CNAxaTWIsvGR4L6GH6NF3YYUVxf3MPwMfmCFo2SdeD1wtRoaWjFnYBcMSlMeFPt3fITZ8VdBx4r+uLLJTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008785; c=relaxed/simple;
	bh=iTc/RNQUri37IjlCMpegyjj2hPVvSJ8rCK9az0iWMW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKOy7lxMXAmeEUKCcj3RK2Ky0+kelCUAuWW4mUSGJ0+bbeslvZv+tGnc42I1vC1R5gkBnCk/HenDgoECSRqWVLgixgEHs1y9ElsfOGX+rqlWx1MAixTXNFvuaNmwDVHfBh3NnlsQFeUIr/SQzlshO2Ubd2L9TQw/T1hv1qw6dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3Jpdo1N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mnbNiMQG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMe0g3jwXR/976+VePxD04JYud2yUWQle7bIApeWz3U=;
	b=G3Jpdo1N6yh/w2DbbHuAPbzLVQoPOD0N2DCjiggJTZV/xmIizw+4j4bcWf3xtBIUM9fP+0
	nGMlIc1Uwwfuicuw1whh2QG3pmc6gFtKT4XSsYYNf/P2P418aXrJM5UhFF/ztTLtOMCPqe
	tw0iPFvc9KjP4U5HsVeOhbl/llGGpXP0Ql63q9e+oP9d6OpC4vz9nCP/0KcEIu6qugvr+e
	4BUoYpD2QxxTZG5TheI4IkgtjdS6SIQUaoYhAuXrXT1cglWY2cobY2Uow+etBT30oPE638
	Dzhni6XVNfkZG18QtDQwl9dyku3MBPUPPsA/l5PHzz8d9O+wOASTixRVfLFk+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMe0g3jwXR/976+VePxD04JYud2yUWQle7bIApeWz3U=;
	b=mnbNiMQGcxWqmK8+eswVy3fFEqOh4khlUjvif2kdqmM8XglIMwznTGdAuv8S6wuJglCeLd
	0Xdo5GTW14vzNRCA==
Date: Mon, 07 Apr 2025 08:52:28 +0200
Subject: [PATCH v2 05/32] selftests: harness: Remove inline qualifier for
 wrappers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-5-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1419;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iTc/RNQUri37IjlCMpegyjj2hPVvSJ8rCK9az0iWMW4=;
 b=fPuqO+THwyekty5QwWrGCk90B0dBCnHpCOameY4Pv6uN4eoOtDVUBuZDOSMx4Aj0fCPwhx8R2
 fU0Q67Ai9eVBztjXmjrEcdaJnHwkVT12iukuaHLgLDjne1RzX7RgvYK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The pointers to the wrappers are stored in function pointers,
preventing them from actually being inlined.
Remove the inline qualifier, aligning these wrappers with the other
functions defined through macros.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5822bc0b86a3c623fd34830fb8b541b27672a00b..222a4f51a8d704c41597e09a241ad887ef787139 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -172,7 +172,7 @@
 
 #define __TEST_IMPL(test_name, _signal) \
 	static void test_name(struct __test_metadata *_metadata); \
-	static inline void wrapper_##test_name( \
+	static void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
 	{ \
@@ -401,7 +401,7 @@
 		struct __test_metadata *_metadata, \
 		FIXTURE_DATA(fixture_name) *self, \
 		const FIXTURE_VARIANT(fixture_name) *variant); \
-	static inline void wrapper_##fixture_name##_##test_name( \
+	static void wrapper_##fixture_name##_##test_name( \
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata *variant) \
 	{ \

-- 
2.49.0


