Return-Path: <linux-kselftest+bounces-30554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9EA85756
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2948A4B0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AFC29DB91;
	Fri, 11 Apr 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="preT0jVi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKYg6SnW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEB29AB18;
	Fri, 11 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362118; cv=none; b=AxydyudG9CZavb2/X3TlV/7EGHoH+qbzwlyNqM+OIMdYPF+o6TtEIA0RqnnAUc+dlZugD6SHgyNgg+Q0N1CYYesTSMv88iB/52WOTPUxoZX3R6dqESjYiQSCfR6CzATgNfSGr+mNb6pEr+WiVHuTQXzGXG/AOxXK1YEgiG3oEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362118; c=relaxed/simple;
	bh=UfwFCU91ffZuTdxNtj6J2SdT3JrHuwqMEWx4TRmx2p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5HwHE5lXVgTavMqyLmEi3i/mxxtdkLAVLaWazl5+EpY9RjSqmlgZ9RHiq2mSPUKt3AiUDWeSEvNyKVhy5xGrsCrDDcm9PmZIXKJLEiNE52xvBAy1rXSqnC4FlA/oXGFnCxwikPrBYaCRHqWhIs0QB/TCWl1rBV4ZRqiiOVo8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=preT0jVi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKYg6SnW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+8VoWEW0XZjMSQDsaz/4MYv5EAvq9VHzk9t+oyNa0Y=;
	b=preT0jVisFbElgnat4CkA/9FDTc7JaYOl5Uv7O5EQ3KDWDoismv8zoZbHxWZYAq0xn8zVN
	6T0o78nRTT23y8pO43U07ctiM5AS7fvxZgX6yHFFSjWN2Fn/BXuAw+co6vrbtjOVT+fSBx
	WhciG6wNoiyhK6ggU09xiTGQWhtuYQS8LOOs5P+O+v1rBcR7pa9Q5Hy7bTHgIBFob4AeoN
	upNxnW4Frxje15Rf5yLmQ5lZ4TJzG0QyBWVAhVTlRuB9+klqG6xPkE6qgJblKR9gweRl+/
	Q6smHPsHdvokOyxCuvO5LMBDsI+7jenxnKNxxZBGS1kWk6feaVKKMZgExI2Jlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+8VoWEW0XZjMSQDsaz/4MYv5EAvq9VHzk9t+oyNa0Y=;
	b=ZKYg6SnW7ENBOKnRIP+8RD4nCfIRbO2aPw2Q5dUWWmRlt1JBo4qlQFUSbd3CqguK6GA6MJ
	+JmxTq/lpmZy0LAA==
Date: Fri, 11 Apr 2025 11:00:41 +0200
Subject: [PATCH v3 17/32] tools/nolibc: use ppoll_time64 if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-17-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1086;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UfwFCU91ffZuTdxNtj6J2SdT3JrHuwqMEWx4TRmx2p4=;
 b=MsRpXMP89fZmvpbwo/ZXjL0ppQDimTgT30Y+CMmJCqC94CSuFrBya6yIM4L6otvSFT8VdWDYJ
 Zc0X82KNWaaBq/O4syZlhtGP8NzVas7fYeTXnDwxPB7X6Ek1Bu5SG2C
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

riscv32 does not have any of the older poll systemcalls.
Use ppoll_time64 instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index a5decdba402236fa0935207f9207c771ac2700bf..b04d83a7ec50cad7beb32198d9d47bd9d5873f69 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -893,6 +893,14 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
 	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
+#elif defined(__NR_ppoll_time64)
+	struct __kernel_timespec t;
+
+	if (timeout >= 0) {
+		t.tv_sec  = timeout / 1000;
+		t.tv_nsec = (timeout % 1000) * 1000000;
+	}
+	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
 #elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #else

-- 
2.49.0


