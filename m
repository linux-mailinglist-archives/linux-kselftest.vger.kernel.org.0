Return-Path: <linux-kselftest+bounces-32378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67CAA9732
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F037AC0C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48067265CA0;
	Mon,  5 May 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IwjAJCMI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIKJPVrY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A23262FCB;
	Mon,  5 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458180; cv=none; b=m99RUoL20fDbezlMQFzZzksIgKoRsvnO/ltPhgtq3aIYme8RMUwh1Nz69mfre62Q0ndAtL0YRKH+XxYcse67NeoXvUvnktvnV5S8EwzQZsbU2QU5VwPfdQg7V8qX727qDV5JM9vUc8HoALwjwIr/70MpUo6Qy7MOjgmhb7/Ds2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458180; c=relaxed/simple;
	bh=dZJe/GuY8DCD+P4SRvM/cXfTKtE8IWZ0aUq54fDachw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpdaIXHS8TYOIj/gYdETrfWl/U+10Vgai5m45xNgrgNIX6DW99B5jYrMjP4rOSQChKJYtQP4EiACbCiXKSMd4hWLnpXgAanSVA8siVXVNVomTZvkiqmY/T6UsA12EYUrThaGzNINlEa7SAsMTSnCv5l6IRVierLTCM2luIAhPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IwjAJCMI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIKJPVrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M/KT6c4m/HT5iZ05zmOXmbeyImB/lmz8pLtAGEhfbk=;
	b=IwjAJCMI5KJIWicZeGER3UcHdqvWr9n4piYR0UamnOFLH62HAsSa7qO4FZNAiuUnJEpd6x
	uSNduNtpCi257fnPqvY9FQ9p0R1SCatsbtcNN+6/bE8eLdgDlRCuHLZOwRm9IDjhQWBYn0
	DBJaYGTG7UXST2fT3+UaVMoCIkixj3gt6ywfp+KJ+kTSlRDe/5jthxpfjcx2KtFFxk5ei9
	QiD7MV3JRbRyhhMlB6dImJoh+AzZbgyur0tbYROWraQfTz8KWpvcobCQgOwNvxHFi61RJV
	VmEwFrkvwjUcT+FCWcZYsWCTzIKgE6f2amBLiv677TYNLRH+2A/O9oFRJSIzpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M/KT6c4m/HT5iZ05zmOXmbeyImB/lmz8pLtAGEhfbk=;
	b=aIKJPVrYMO2CzhdCTai+3EtpZZ0VuIxlpWTxa1w+uCHzgCZwQOylBqCPSX8Cf4ev2muzLf
	B0mhscSKx8VmD6Dw==
Date: Mon, 05 May 2025 17:15:29 +0200
Subject: [PATCH v4 11/14] selftests: harness: Add "variant" and "self" to
 test metadata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-11-ee4dd5257135@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=1221;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dZJe/GuY8DCD+P4SRvM/cXfTKtE8IWZ0aUq54fDachw=;
 b=bs+1ZUlRgQtLqceT0FrYNlE+Jd7svhxW16EeK9XaAsiVeTdgTqilJc5eF3aEMB35ssj5Fflw9
 BIWIoSpu5BQDyQj0CjPjZlHKDe4jAiJRP6UtRU9sPeqD7DmX0h0xvy+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To get rid of setjmp()/longjmp(), the variant and self need to be usable
from __bail().

Make them available from the test metadata.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index acb476093b74968ecb71180ade9e5852b22da170..088c875df91a58f8760749b6047b246fb2a7891f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -423,6 +423,8 @@
 				self = &self_private; \
 			} \
 		} \
+		_metadata->variant = variant->data; \
+		_metadata->self = self; \
 		if (setjmp(_metadata->env) == 0) { \
 			/* _metadata and potentially self are shared with all forks. */ \
 			child = fork(); \
@@ -926,6 +928,8 @@ struct __test_metadata {
 	bool aborted;	/* stopped test due to failed ASSERT */
 	bool *no_teardown; /* fixture needs teardown */
 	jmp_buf env;	/* for exiting out of test early */
+	void *self;
+	const void *variant;
 	struct __test_results *results;
 	struct __test_metadata *prev, *next;
 };

-- 
2.49.0


