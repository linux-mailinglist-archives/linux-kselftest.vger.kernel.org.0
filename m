Return-Path: <linux-kselftest+bounces-28154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F102A4D45B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6311729B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135731F9EC0;
	Tue,  4 Mar 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Io/3RH0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xOJ8Kdrp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8321F8720;
	Tue,  4 Mar 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072275; cv=none; b=pPmKa7BUTeEmaCBtsfbEwo+rEJ6j7Y/GKYTaaFlbrMhi4ccfv2ltjjguTUAirwiKOpLTcg84QIqn5UDIDMXSPum2eUNBUtXKWuZ3Ym7RPp67QBs4p8kHs1ZnxNH3MG84vbUR8b1AKzQf8osL5e+f8SB5F0sALMeHfPhbETMnMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072275; c=relaxed/simple;
	bh=MhCoMPPqVc/gIaoHbpaw8Q1QptCO1I6gObh8DSH4ELU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPBBkqSJkZ/6czI1v0/3aVuQTU45uHXvvICSoeHQRZ/JHL9keG2KtMzW9l/jt+g/4oyQBLwwcg6VpT3THnrKMqWSruwILQxJ021c9K60ZJy+WOqyWYMsrLbIKcUzBcjxR8gZsHXEvRnp78/QQOyec0S04ZqBRJV2Y2mllg17gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Io/3RH0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOJ8Kdrp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+94SOPd3J11uukpAuT8vGJKV5yurZHs3dOoh8W8Cbc=;
	b=Io/3RH0VSMxqtmYOmx1oGLE33k3DXEyNprNbPjzsMjDDi97ShpecOHxxdbDjYPI6RrI06P
	uWCaFzDSLRToXbagO8KQdzfPCue19Hh6cbvQWn2tbhvl8E3UrKkSxOl5+7lh9R45VVbeX1
	OPeWDGSyE3bIw8pocVAD19F7liJ/T02msdC+348OjMLHRpMHDcUI1y6TBngAUKzx/mamRn
	d7FBILtxDcW6feIjYSdRQHzyF7U+By4eRwckxrP5AscOhvK495HCMUzDG2FHTL2kBsCh1B
	dPeUDjPvhAxnd2i4wCuY+otTaoyDWQhkdRS4ME07/gcWjCfKKE0y7lByMz80Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+94SOPd3J11uukpAuT8vGJKV5yurZHs3dOoh8W8Cbc=;
	b=xOJ8KdrpwzNrnfxQvaIA5hy9BscksMfmzJbjYEGgxwp5oebk3Iwz5aAPJB7YnkJOdEDkT2
	KKVrdEY2HwEurxCw==
Date: Tue, 04 Mar 2025 08:10:35 +0100
Subject: [PATCH 05/32] selftests: harness: Remove inline qualifier for
 wrappers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-5-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1420;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MhCoMPPqVc/gIaoHbpaw8Q1QptCO1I6gObh8DSH4ELU=;
 b=wS5Lin8Xcj0SkpcCfGXocZdyGTKWi07S2kgMlHl3jCZv2Z+J3rDrfFt9KdrTQwH2YryxuLYZk
 lnR8D2AY7OZB8Z4JCz3DYufMaenymiHLS9K2ziHhjFbrtmJX3rHZuuK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The pointers to the wrappers are stored in function pointers,
preventing them from actually being inlined.
Remove the innline qualifier, aligning these wrappers with the other
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
2.48.1


