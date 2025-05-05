Return-Path: <linux-kselftest+bounces-32372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EDAA972B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D3188886A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD41F540F;
	Mon,  5 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eIZCcOfb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y93qr98Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5A25E450;
	Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458178; cv=none; b=rj5yLqYEBGfjJ66pgKTHoyXXfubjnDdKoTDxzCR8COtj5JRzlErchUiu1VoIh2ic6/VDC47z1a4gxiPDP+b/vdxpmzViVrGg4zu9KPk+vYhvNz6hvoz6RMzVZvH4NGvYqw72YCRw6EPpCLT9UhauZicG47xlgr0tyliGgKS4kNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458178; c=relaxed/simple;
	bh=KhW3lWKpfo/1/0mm9HHAp3CarDorGDqS8DcPzFcBpDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTjhfSezzvbRgne8Fjg80CSAuBVSIG9is0p+c8IRFVpLdozraFexw/LOtD4COnOIemR6jZyIUNk1JWC8AQqP3t9LXk6BNvdBM//GJZB4Xa4qB/Nnjpx72EXiqRKcKfusrdZTjHG7Kmstyn4F9T88f38RdsIf3R1QB+CB9rtlcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eIZCcOfb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y93qr98Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJJ0rdSIAhSeUiLVcQzDlHj6elSkp5s1UP0V2E8oyAc=;
	b=eIZCcOfbzxUDB9LI+h46ceDGIqENozoalQOcGcO1bjmtbniyT81nImtjwPrsqxAv2P8bNZ
	lRFrFb9D7DCUMPDrqAXniGb0S888wtjf+Mqr7QD1Av5fCyo+AB5YuJ360V98gCn4N32jMp
	QU2pgdUR2ighWIYbcOcKw3XkXENO/A7QW1TL2TuF/+IN6LTddNQQ/98DYAuY1sL7lkq5uJ
	IbbtrBuPCVOjZJNWJnopQ5sYzDG65jSpMlCUEOucTr3So0sRGvQ1KSqbm+YtESnQQkZ7A0
	HwhZclA757WO8idCXap98HH0pCtLz/ONERIyYmm7S5rpy2IOB20gBe8FFALIWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJJ0rdSIAhSeUiLVcQzDlHj6elSkp5s1UP0V2E8oyAc=;
	b=Y93qr98Z3FeCXO6OSA/VOsIAkwRf4UiOSe9399hG6NAM9qLzK7DLHltNVEYUvbX8xY1ebr
	lkdLjzYF9nP4PRDg==
Date: Mon, 05 May 2025 17:15:23 +0200
Subject: [PATCH v4 05/14] selftests: harness: Remove inline qualifier for
 wrappers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-5-ee4dd5257135@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=1532;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KhW3lWKpfo/1/0mm9HHAp3CarDorGDqS8DcPzFcBpDw=;
 b=cLNwrtp10OcEYLKPFfDyYrwsXW80rM3TTKW0WWAPuW3YR0Ymas2yT9wh9Yx5LvOrCpjhU4OOj
 JLepqH/lF4tAL/D+f3WVOb+tfC6ZrsUG4gx9g0B3DmkrEzSM5fV7x6X
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The pointers to the wrappers are stored in function pointers,
preventing them from actually being inlined.
Remove the inline qualifier, aligning these wrappers with the other
functions defined through macros.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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


