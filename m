Return-Path: <linux-kselftest+bounces-30552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C871FA85755
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760C71BC0BA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6029CB51;
	Fri, 11 Apr 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+dAmASc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glbLpOpy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D289C29B23B;
	Fri, 11 Apr 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362117; cv=none; b=ennSRI/4xww29V5R9SY7uS22f+H0qqRYBoiXtLRa69YO6WV+zxGytyrHA3fsNa6BJjGke6i7yW6rq4zKUgUeDLfRmfIE/glsUkQkFqAYznCiZrxV5FSJYHyB4DYl1opgrLpdJrnzZ2u0wZCwI1p+7S/8R+3CZwlKb9fEDXcAeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362117; c=relaxed/simple;
	bh=dNb0DycZOXECXF1uglDgQ5OZ5A0IF51QyPd7mDkmpqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuF41fPUnMrTanzRStt5fBKrLDVL1JjRlmWs3t4/PLmIQvzHPBpw5epo74/j/KYgK0ILPku9y9w2jn6QbPdcpmmBp+8+6vzNWuDrdLOgbRtlW2QlftJyMxCV9zws2Y03gla1U8HySqkOfE5TdYiFBUfTHKeCOR+ZzOf764A4+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+dAmASc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=glbLpOpy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqWg6AnaVdBpGZDz7vvxu+fK6BxS8YBbe1FDLG4qoKs=;
	b=d+dAmAScXC5jrsTck9jISsZ8Cx2C7BBvQDYGsoZJI6o2FrV+cZ6DPBaYlUrXoH4ghv9AzK
	jTtWzKAcpOII3U5JIzcJMhFRURyt2PSlO7UsZZA05AJheoee9eKkYE526dzEICbsPz0TAX
	Ua4c4dtb/ydR0aoHXrlsXobflM8ichygIU+WD+bU0WB1n7HDeSVnh/mg0Pc0XhNBxqWhtF
	fbEgp4BDhmtQqFkA/AcyR0ZG/MwvB+/Oq3w5USNOYfhEZIR3t/fKytBpQqveFAY9eIQ5pn
	b0eLyhOKAwKHsgtwaDuYb96DFqc3S1sYqi99hx4hPpZ22ort6g6r4pWBbiGKGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqWg6AnaVdBpGZDz7vvxu+fK6BxS8YBbe1FDLG4qoKs=;
	b=glbLpOpyN4/iVCYO9280mqkYT6xxxLGqsr3nQrxAf8H7DKWW6Kv7PqHlZffBMELugcAwQp
	2I/X1CEo9EMgZ0Bw==
Date: Fri, 11 Apr 2025 11:00:40 +0200
Subject: [PATCH v3 16/32] tools/nolibc: use pselect6_time64 if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-16-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1164;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dNb0DycZOXECXF1uglDgQ5OZ5A0IF51QyPd7mDkmpqQ=;
 b=z8ReeP5xUgxNzaesrylbCqXcthWik285lCV1QVgRrmlxL4V2IzNvWmCOHdVfjKZeZnJXjqEMn
 y8eJl+FQtFXBf7sf7dF7P5+eqFMk9p39jAGnuA0ykh1gFAnIkxFGdxw
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


