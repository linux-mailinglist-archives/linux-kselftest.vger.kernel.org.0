Return-Path: <linux-kselftest+bounces-28153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB4A4D45A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5F1890B9D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F801F9421;
	Tue,  4 Mar 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXP+8HYS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+eetx4L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DA1F584F;
	Tue,  4 Mar 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072275; cv=none; b=r5XJssS6RzjtJS5pKI5YuA1zVp3OTeYSfEhsi+AKpTQeSrdeuX+8mCQldNL1z598r+Lr70PXlRk0x072Q4mCWdtO/GYUSPQBhEze4OosQG30ErrUPFWEQ8xJgWA24eFMEYR58mM5KxmAbhrJ/LV+eH0x0wjCvvUxm6M9n0rRT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072275; c=relaxed/simple;
	bh=8vvtUkkfHU7xlGs3lJ+IYJc5qNLYbAx060rjbFlvpuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ac3RDkW5lwDOm4pD/U1Fl4tTRYi0pYW5GDrmx8HgIuel+dgCZcJQpN4PglEw1CM1NfU5MQNmV0RiZybpyj2PK+B5Af3uTkrKfID4Agg+gAM+vPqsloBzxwxoEh1kSZ59MBgdB2ICKQMpzZOi7Pzlr6d08YQfrvZEIsFhFkyRYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXP+8HYS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+eetx4L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=god5WALMpEkXYpkoV5aKX9NrjAlOqlLEXSMF+UWBpRw=;
	b=DXP+8HYSw9ANj+wG4s31OnOGHxrg5UTHMavkMwQSvPdFBzqMOEl9mswdQVfTp6H4bndTIC
	GN7V4tNCdJRehxbgr9kIUiHiKOCZvoEZ2sUWFkK5Eu8nZq+twkJAQ2dVZzTOI0bKhXjQKh
	B8FAsdw8pdKNjoLZFxxRMiQAAiLJy6LZanxhmI8Luw26nE0++B3AeB4lzXc/DhCPcZtjYH
	+FKei4KF5Kx/B5sEXnTmqL/Uo3Wbx/VQ9XiejuxRq7udr8mW6wkhq8WfHKP1EFm5MdhmcX
	XFpoY6kiD9WpuzV1YA4dVmUf8aN6ibrK0prIQpRv1wTjlBQ49LTjRGU7fPZwNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=god5WALMpEkXYpkoV5aKX9NrjAlOqlLEXSMF+UWBpRw=;
	b=q+eetx4LyQAMto+5SowB626tpFF4LmW3DZZMDRx4dkhPxHUokP2V4Abr9E5Gt1EBNKRGlk
	qBhu/7ODeIy57vCA==
Date: Tue, 04 Mar 2025 08:10:37 +0100
Subject: [PATCH 07/32] selftests: harness: Remove dependency on libatomic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-7-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1409;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8vvtUkkfHU7xlGs3lJ+IYJc5qNLYbAx060rjbFlvpuU=;
 b=1xqyfb93DD9zV6ixSsFKx8ObiOnTGVdqzRrqpICbcltbHN9MY18YjxcX9RDdOiss+vj8KJA5r
 zEUdkTqaLhJAcCHCznKxXPantI+0KrwuS4S9H1z5rlIPGSs6XMmqCcm
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
index 6659c10f4d8fc7c750bc5e8a36ebcbcacda5de60..bf5ffc594a4a864d2e8bb6f47c29fa56d58919d9 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -443,12 +443,12 @@
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
2.48.1


