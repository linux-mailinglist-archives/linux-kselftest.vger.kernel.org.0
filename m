Return-Path: <linux-kselftest+bounces-28151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F1A4D456
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C81894C78
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5671F790B;
	Tue,  4 Mar 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wg+W04RF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7P3hdN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09C1F582E;
	Tue,  4 Mar 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072273; cv=none; b=fxFdQX3xit2MaJAD3+MTeSUxB3DTJy8Ivyc5G1AZ8c2KjweNE8SIYAB43Rjx+uscxpARtlB+EALrXBt2HYz273NRRIPJAFwEE33uNjn9h3uuK6W5hjHjI7ABEQGiB0gADNStxrVZk3pEXv74s9iKFeeMZX4y5cA7xXSKt/8Ng/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072273; c=relaxed/simple;
	bh=lQCsvZCManznXxoRZlWYV8bAc51DQHK993lH7lMNVP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNtBlm0LOF8zthOTOGad0SZCiQ+tzbQSD3MyHBBMf5ISJbdn7Tc2jACBGdzd0XCesjz8HExZ+t0m+VWIL1VXLSO4EbuVACc01xcw12Ysk8czfDMFyzFGs8HWov8OtGphyiGyuE8+LH9Ff+/ObCb+GjaNLUeqGhPnttmI5zbtUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wg+W04RF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7P3hdN4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj4b/kgrOFJpYcVPs/RiGzf4gMX/wtv+L2rD6A41LIA=;
	b=Wg+W04RFCCO8oBuTxtysBUkKB4Vlcumz37pCR4nyYTZooWNSHv+++9IgHC1HfYEZVIKcuz
	2+6kOzdt1e8DphdkGQkNk385utpFjckEM89KEKAkOlsySnqgD+Y9TX7IHj/6c1NI8M2Yoc
	6g41qbwM4ontveJPDqJyz1OOsLHqxDDhjRgUDY4SbbGFOUO30GgW/EqQDk5HvmrIJvkOtU
	2rStaGbprHPAC8SRdpsMflhqYErTHxm0IUMtZgoCbEog7upNfFfe+mPbKWC/9zcus0uWOX
	mspw19iVm/K+d0r29ttoKWvrPd+OcHnR1ngWlcia07JgWSx49XgmSCqmvTSDIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj4b/kgrOFJpYcVPs/RiGzf4gMX/wtv+L2rD6A41LIA=;
	b=t7P3hdN4iqqmyqomeu9rIzLC4pniY7vHmZIGuxO8WAJXl74OHrxUaOCN1tGgd/fHcqAA9q
	5bYTPlS1YlMvxmCQ==
Date: Tue, 04 Mar 2025 08:10:34 +0100
Subject: [PATCH 04/32] selftests: harness: Mark functions without
 prototypes static
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-4-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=2245;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lQCsvZCManznXxoRZlWYV8bAc51DQHK993lH7lMNVP4=;
 b=AdGVo2qpD/O1qq/5xAVF5qKmBYZkYTfKSHBAOy6RXNR/f833VVfx0np5LA9eSmdL7VvqSkoEj
 IEQtncUXrj7CgyL4F5RjuVFdmEH7wLTgcitkOogG2GJsxiTfxx/mBk1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With -Wmissing-prototypes the compiler will warn about non-static
functions which don't have a prototype defined.
As they are not used from a different compilation unit they don't need to
be defined globally.

Avoid the issue by marking the functions static.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2b350ed60b2bf1cbede8e3a9b4ac5fe716900144..5822bc0b86a3c623fd34830fb8b541b27672a00b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -258,7 +258,7 @@
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_SETUP(fixture_name) \
-	void fixture_name##_setup( \
+	static void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -307,7 +307,7 @@
 	__FIXTURE_TEARDOWN(fixture_name)
 
 #define __FIXTURE_TEARDOWN(fixture_name) \
-	void fixture_name##_teardown( \
+	static void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -987,7 +987,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	kill(-(t->pid), SIGKILL);
 }
 
-void __wait_for_test(struct __test_metadata *t)
+static void __wait_for_test(struct __test_metadata *t)
 {
 	struct sigaction action = {
 		.sa_sigaction = __timeout_handler,
@@ -1205,9 +1205,9 @@ static bool test_enabled(int argc, char **argv,
 	return !has_positive;
 }
 
-void __run_test(struct __fixture_metadata *f,
-		struct __fixture_variant_metadata *variant,
-		struct __test_metadata *t)
+static void __run_test(struct __fixture_metadata *f,
+		       struct __fixture_variant_metadata *variant,
+		       struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
 	char test_name[1024];

-- 
2.48.1


