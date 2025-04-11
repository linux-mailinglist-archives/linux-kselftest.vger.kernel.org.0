Return-Path: <linux-kselftest+bounces-30542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA1A8573F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A304D4A0956
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B129AAE4;
	Fri, 11 Apr 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VuizJtdz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tl2nKwDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED2298CAC;
	Fri, 11 Apr 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362113; cv=none; b=ZB54+S0k1lizfaPFg9+lWs5GwukysrutDtfRt+ShBxrESul76CdpSJQjVTIlU6GHUj/s8WOgNwSLy4KidvnxvPkEYHZeLLiF8RDOCbF9TJ4MI0XG2EVWiUmGhZLxhppCUrN4Tl/Uuub+FqoYMt9HaEUH1y0SxicG1OeZs0AH8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362113; c=relaxed/simple;
	bh=iTc/RNQUri37IjlCMpegyjj2hPVvSJ8rCK9az0iWMW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzJ4eyAWPLklpm9UAn8QoR+6YZ6V077aHvp2k4xoL9y7HW+MX0vQ+SHyOcGQmDqS2xmZql1tw2Jn7L9tvGQtE+tRzoB+983EHKiMCX8jkWa437LuI125WyqyaHj7NqkB8dytcT7/PuHV3WYVH+eMWfGbaUIPqblw8bjX5hr3S6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VuizJtdz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tl2nKwDc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMe0g3jwXR/976+VePxD04JYud2yUWQle7bIApeWz3U=;
	b=VuizJtdzBqUgiJg0WrWE2Y5azXxO9KAvlc4dfOv9pOBvC/hNlxpT1WP8C8xIkM9zucDtN3
	a94qGmAq4kMa5z+TyiHi2XUuhxywgtg7Li4NwU4209+0O/RMdvBES1OPVQltp3dHGvu5ZU
	G5jL5R6llpQHzDdqhVsnmNOD5BOrd3A2c+DNw0pVFBXBuqMRIspWHgEXxYqYWgwkXxK25y
	5z9sNm2z7ju6IpN9d4iM1uUsJThvtFjf09JT1Dh3lpElZfi6lD4B1jbyuG0EINsVHI5wCc
	ZDY0g+ZMrlTqQLrz527R4miYQzGqFyzXAon1lNHFM3Y5Sx6coFoPOvmkhNB0JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMe0g3jwXR/976+VePxD04JYud2yUWQle7bIApeWz3U=;
	b=tl2nKwDcDC+mD40i4VfFK0Q/Zqw0JbPmRqBfNRvLfGQ2RYvLKQnsZwZmL1HFfcr/PEGL34
	0nzN4kuMBzlUnNBQ==
Date: Fri, 11 Apr 2025 11:00:29 +0200
Subject: [PATCH v3 05/32] selftests: harness: Remove inline qualifier for
 wrappers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-5-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1419;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iTc/RNQUri37IjlCMpegyjj2hPVvSJ8rCK9az0iWMW4=;
 b=8YgHapG/pY5M0wvPiR+V19Fh8iDIlF7p3oNQQLwFh7GgjDhzKY//CgMTYmNOonl5pPZn/twhc
 gNdQdCipmaTC06WFTBuUFrMsytLMMmGHPjmXATWIe11xi70cBo9ocpD
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


