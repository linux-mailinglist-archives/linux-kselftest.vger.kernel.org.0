Return-Path: <linux-kselftest+bounces-30191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B783EA7D48E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4934163B48
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC5226CF4;
	Mon,  7 Apr 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QC/CgySL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsIPwuO0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B3225797;
	Mon,  7 Apr 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008785; cv=none; b=VmLCYHNgsr25Wn3hJBU4ztAF4GZ0/SAbAb5mfVf7Uh4sBpQUa1g7cqR3ibtKJocRVhzXT6SO1x6DYQyxmKSQ/MUZan8NRb8Xn/7vtKn3w0vC/Djw/GdXF6ihonAooftYWYzZ6ibwJRQxVzcQ6XoweHUwnmUOZsLp009M0k3gci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008785; c=relaxed/simple;
	bh=X+BMimOr27k+/lCB8IAFuJEQitOZeP8NtZG5I0zUYoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDfJ+2xtdVNKxQY61myhXtuBKQmRwJD9ryzSpky1iBZGKPwe5ffCtyA8otk/zmQftetYWHQApL3mV1VySRzBaQ/7dJcmKxmaiINbKRucrL9UE0DF5EjWjU6Bhzicm/iw5qO5pfhMEzmrqQHWc/Qmg68dczBPvGaoBbLMcYxBDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QC/CgySL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsIPwuO0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtICgEwn39BNK2RVwM0gACpiOULlMkuI9K6OeLRKX6w=;
	b=QC/CgySLPb8G0uPvTHftXR63Js/yqF8ZwbcOXYN4by83lAtfR7GOMG1/FJMdzsu+q6j4X2
	HpJ8oulmT5f3HuRXhlwjEvcuPr8a+mxHYNVfmJlhiWbGrS0CcmhXx0jv+xxpbKtBaFz8TL
	csMM7Rdw3B7ZhP+73FP9AjLRKw7FNmHbOMgJHYOBwqZ0YU+nehK4Gqwzy5jLVsN4ZCLPhs
	dkjHY2Emvcy1v25aSunqTjV8JkLnHUd7ecTdF6LbTURGZfex3zHsdQarvu/1oGKQ6CdOyN
	lQwj7aNSCpjclWAn6Ua0vUq+wjQc0aoYBLAHfn32FLtB4fH4E4DnZ2uLBpaWGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtICgEwn39BNK2RVwM0gACpiOULlMkuI9K6OeLRKX6w=;
	b=jsIPwuO06RW3ZllBgG2wUUQt1igUNC7Sf9FXXabJm7I83Elv1Xbg4IkAc3EeKBZ/PJDQa7
	XieX5GHxKs0WeBDQ==
Date: Mon, 07 Apr 2025 08:52:29 +0200
Subject: [PATCH v2 06/32] selftests: harness: Remove dependency on
 libatomic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-6-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1409;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=X+BMimOr27k+/lCB8IAFuJEQitOZeP8NtZG5I0zUYoE=;
 b=mpooDyXjTAA/0FPKJ3eg/h9ao9poICLHIrFGQxe/S2CvGJJdFmljNPx04hlh4b71+4eDX4RNT
 E792W+2GTa5AiiV6fnEp0nkC9twKOHrm6z4O35YZVn/BYBBXUwDhc++
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


