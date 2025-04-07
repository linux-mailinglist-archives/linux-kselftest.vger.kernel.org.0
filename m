Return-Path: <linux-kselftest+bounces-30205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB5A7D4AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D8C1885F0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8B22B8BE;
	Mon,  7 Apr 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YfXWzs1Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11rargUh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E122ACD1;
	Mon,  7 Apr 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008793; cv=none; b=Qf79yBgG4QRLFFqm+Ii8dWsjFdIEJCRRORLG1NYxmGR+FndLfwpfHF703Z4bzobdW8WHOM0+qImNNDvTkbsjyEhidBaYLtFJERW7qGx3HS3niAcBfb2Lt91OeKtUiknlsR0psl3EpeKKRlM+qV+EGlWRC76ar1DbdlQafHnXO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008793; c=relaxed/simple;
	bh=57F0YmhSlN4tFYcLaIwl/LaPNC82JeponEq16ncbsHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dF4etaI5UvaorAdehGF4DSje0bq+ek61Zrkgvglyn/3CoNOP8LyaNA/tuc5mEE3LBsfImSKsOhGTVpf+D71CMXSLWO01qLwEsHMEvdMBsWp0CH+RJhkLQFGpYBfCVA3x3ToF+YV0WyYrmAt3dMJwJsyXwbjPRG7UsfToAbzku50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YfXWzs1Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11rargUh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm7NpzwzHwG5QyiMDAKDL8vf/JWws+fnKfEgWpTx3s=;
	b=YfXWzs1QcONG6O8k+6clQ9A6IncwyFsZMfdcxiya4QaLfoWbM3pyWrB3MbcxVt8YNaTQZm
	mE9tDBAjN67ph+hmxTpbn3akkyuRfqmi4nsVRLkuQaqtV+fINVsxAKumjs7rw6kT1SUhhg
	dhR5/O8PLy81wcFhGZS0kfqQjNb/KrWC60W9yADTvflz+NdOg/0NgqV25lb+qudbj52R1n
	ceZ9RX7akT5SLoSSY6t9rSMLoyrNs1nzr8YBdPmUHThorxVyA781TWTZxFstN60jDQv9Tr
	oHf/TF41Qd9vGK3G7f8Hs6zUvoX5iHa6pMrzI0zZDz2yc+sQzTiH8/CGokjNgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm7NpzwzHwG5QyiMDAKDL8vf/JWws+fnKfEgWpTx3s=;
	b=11rargUhMkihEH8cENiWRYqp8qNZyaWiZcZwsnyXlYnQP7nFnJmDYpSwksFb2egCb9BLQG
	nGdjtthHzyUUuFAA==
Date: Mon, 07 Apr 2025 08:52:42 +0200
Subject: [PATCH v2 19/32] tools/nolibc: add _exit()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-19-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=912;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=57F0YmhSlN4tFYcLaIwl/LaPNC82JeponEq16ncbsHI=;
 b=am9offQqMwiAHrIymp2LL0jDvA3O4PpFrCziKjwvnat14IGBWq6/qTZumMElG4appwa+LkDqN
 zYAjqf3bCoqA0xb9eziBrerfUvoZn6IhYRXN8chD+r/O3FsG4WSa7gz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

_exit() is the faster variant of exit(), skipping all cleanup actions.
As nolibc does not perform any cleanup anyways, the implementation is
trivial.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b04d83a7ec50cad7beb32198d9d47bd9d5873f69..f52e1953020945fb2902d47ad5f7a8e7c2c1c290 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -301,11 +301,17 @@ void sys_exit(int status)
 }
 
 static __attribute__((noreturn,unused))
-void exit(int status)
+void _exit(int status)
 {
 	sys_exit(status);
 }
 
+static __attribute__((noreturn,unused))
+void exit(int status)
+{
+	_exit(status);
+}
+
 
 /*
  * pid_t fork(void);

-- 
2.49.0


