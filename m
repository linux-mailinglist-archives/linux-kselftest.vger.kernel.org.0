Return-Path: <linux-kselftest+bounces-30544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB1A85743
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB321BC0424
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAE293B61;
	Fri, 11 Apr 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ghV41ak";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnxh4Rq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5992989BD;
	Fri, 11 Apr 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362114; cv=none; b=IdEqDEBQAFmsrXLx1jqh0uBMWyQetqRj5jtLm7K4WO9kprAgFdzPT6u4zZM7iFxYUpOBdWtrvAGukRjtUIBON6YMQpjDW9JC3pjZQHpjRNYWazMKIWf2RrbLG2VTcOFUuTuPmoeIu+75ri03zyOKnSIwO5S9musyjQh3lDekNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362114; c=relaxed/simple;
	bh=X+BMimOr27k+/lCB8IAFuJEQitOZeP8NtZG5I0zUYoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rO5kLF5MejfesGcK77rLpKQJY2mVsB64Sd4I50pCwoPKnqcem3xAnWSYF19aJ/Z6ts+fFywHVE0c5znAU48pzzSuilneoN1oOVDLudIWZZQPvgALwT/OOnLgjFzOwLOy+um2DkP54W7EMi8WwHcF3KhCnYgTV1UubjjZDEiDXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ghV41ak; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnxh4Rq7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtICgEwn39BNK2RVwM0gACpiOULlMkuI9K6OeLRKX6w=;
	b=1ghV41akaZSwLQ7urFX89khrmSalYn0EJp0/t4podAGy1uveW7dJMKGyPn7DMZWul5Fjcc
	zi/5isGpJcYAIiS2Ytm8198ev0cz/GrvWpWBpua5OLuqKCb8v1PIUnpI7/7RffmkFVcS2q
	MOTaxdIln8zu+GBCXlCpSr1Vl6oGqB3PigzpkOHwARaDRA7dLa+8lGJJ7U9ScLQlb4Efo8
	HQHSxgi/fesbM1afnMwWXANIonoQzL80vt2AObhf+JUVcQwvqP9rZAqn0kHNrFM/m1a0s9
	0gjQoWRtyFkLxaIVKkDMGzrRkbEVrqgjoSlHxVvEhUH+FsAK8rJRO4619CI/6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtICgEwn39BNK2RVwM0gACpiOULlMkuI9K6OeLRKX6w=;
	b=tnxh4Rq7BreL3AkcMEmUE63b0xNeszlpzoFZx+AMPDD4iUlSMxTBwrtCtdVU09OXi4nlcw
	LbpA7VfJMDP6VXBA==
Date: Fri, 11 Apr 2025 11:00:30 +0200
Subject: [PATCH v3 06/32] selftests: harness: Remove dependency on
 libatomic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-6-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1409;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=X+BMimOr27k+/lCB8IAFuJEQitOZeP8NtZG5I0zUYoE=;
 b=Im72zI7x5XtITNJyoPf3w6jYh5XXgB8/srkQa44p0i0srwGO/a5ubt4hxFxRNQ4yqEUMrkwL3
 VgEPMKsuE/YAvyc15OO1qiLCDUcJA49pye8H12jtwSr+3GaDDHuEs0v
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__sync_bool_compare_and_swap() is deprecated and requires libatomic on
GCC. Compiler toolchains don't necessarily have libatomic available, so
avoid this requirement by using atomics that don't need libatomic.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 222a4f51a8d704c41597e09a241ad887ef787139..7ec4f66d0e3d7f129f6c2a45ff58310dabe5d03f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -439,12 +439,12 @@
 		} \
 		if (child == 0) { \
 			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
-					__sync_bool_compare_and_swap(teardown, false, true)) \
+					!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
 				fixture_name##_teardown(_metadata, self, variant->data); \
 			_exit(0); \
 		} \
 		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
-				__sync_bool_compare_and_swap(teardown, false, true)) \
+				!__atomic_test_and_set(teardown, __ATOMIC_RELAXED)) \
 			fixture_name##_teardown(_metadata, self, variant->data); \
 		munmap(teardown, sizeof(*teardown)); \
 		if (self && fixture_name##_teardown_parent) \

-- 
2.49.0


