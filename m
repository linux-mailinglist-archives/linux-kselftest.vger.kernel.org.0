Return-Path: <linux-kselftest+bounces-30202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85265A7D4A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E86188E654
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9A22A7FD;
	Mon,  7 Apr 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AuV7VeIK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Rmtk9ol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA722A1CF;
	Mon,  7 Apr 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008791; cv=none; b=cICR82jFNqdUMqs8zEJP6Ii0dDGlQzhhg3iFc4dSPM04TFd2hTyKlr6MoMakUjPmEfOB8xV5QfSkNec0cHbYPmlohZMgVIPLqcdiSemw1oKW2FZ/YxC+hXEkt1COZt2qWh9Afb7/nviaMKc/ENxIMZ413e2VZgh/llAEzp4ppQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008791; c=relaxed/simple;
	bh=dNb0DycZOXECXF1uglDgQ5OZ5A0IF51QyPd7mDkmpqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNvWWd8v3NOZ/gtQJuRKSEWEb5VxuM0A9RkAwGJvJgR3IvYjr1pf4Vi6iNGXuWEX148DyRbk8oT6TXPSzTIlju4lz18HJWhOr9xeJgMtZ599xw+8rJipJlcOCi4gQ2ZUt+qqAv7Oif3BN96KHpzul1euMEXB02JZJIxfNysPauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AuV7VeIK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Rmtk9ol; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqWg6AnaVdBpGZDz7vvxu+fK6BxS8YBbe1FDLG4qoKs=;
	b=AuV7VeIKFvSThJ7EWy87hBfCFAkZovM2BHm4BmW4NksqewRssXoFsOyalOZ+bvtLQwzfSb
	8xnII1bk82ItJsF1x1ZJkvOrnBaPeGZ1iDbl/9gCbPfTx5iKTtNcMGABUbf23Ydgkd54iO
	wPkgT7R9gTP0XNojLI7KzFmzfjngwZktPJI0FDMcpLkPVX8gPIzC+Gl9wN9geH7FZHZAMb
	WVZuGkgItSbB8hfl2bX8xZQfxBYplpSswqmekVasv1/J0lvtRspHOjXwtA/gDYXd72qa6m
	/GBzr+gnAtFmQ3ZaBM0uxMP4ivAQ3iQy1DwTUclYlTwh/LhgffG/5mDgypzlOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqWg6AnaVdBpGZDz7vvxu+fK6BxS8YBbe1FDLG4qoKs=;
	b=/Rmtk9olDLwqysVfhC0010MzBRqZihjOB1K/49cFiFxgHE3kXC6PhQ7BBU9YQIBKNA4SAv
	sMG6hIkgIcn0qQAQ==
Date: Mon, 07 Apr 2025 08:52:39 +0200
Subject: [PATCH v2 16/32] tools/nolibc: use pselect6_time64 if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-16-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1164;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dNb0DycZOXECXF1uglDgQ5OZ5A0IF51QyPd7mDkmpqQ=;
 b=siPCZeEZrV81W2zDYwybgE5DfL0UzV+ZLqYHz0S1WQYvHegTpeuCeaS8TysTwlFbkU12VoSuz
 Gp/8JSEJdpVDMgj+B24dodjAsdXzD3K7nMhwZwJ9XgK70mp8ajZWdhA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

riscv32 does not have any of the older select systemcalls.
Use pselect6_time64 instead.
poll() is also used to implement sleep().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 08c1c074bec89a27e53e5d461a3ebbf71ec323d1..a5decdba402236fa0935207f9207c771ac2700bf 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1023,6 +1023,14 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+#elif defined(__NR_pselect6_time64)
+	struct __kernel_timespec t;
+
+	if (timeout) {
+		t.tv_sec  = timeout->tv_sec;
+		t.tv_nsec = timeout->tv_usec * 1000;
+	}
+	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
 #else
 	return __nolibc_enosys(__func__, nfds, rfds, wfds, efds, timeout);
 #endif

-- 
2.49.0


