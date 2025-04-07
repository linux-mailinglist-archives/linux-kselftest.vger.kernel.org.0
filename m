Return-Path: <linux-kselftest+bounces-30203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5BA7D4AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD54C1682C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33F22AE48;
	Mon,  7 Apr 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdJ4lWw7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucDHXGDZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8622A4F6;
	Mon,  7 Apr 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008792; cv=none; b=MC16oYQ/jWoyq0d1RPt01HILyvArhaUs4fZGPADEdwXwP4qT/d+fQJxikAR8aoMSDQuH/cfLnFnEbcJXHkw/N8dxIVoOzSCUpP6ThT7Ojj1KBwVW/eWpA/wAqvBWqQ1bGJGSV0VU9JA9L9gHMqIGZtmiJuYKvkl6126eK4THUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008792; c=relaxed/simple;
	bh=UfwFCU91ffZuTdxNtj6J2SdT3JrHuwqMEWx4TRmx2p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRuZdRhSDzM1Y62m+ae5fYjb/22VYEb2HTlSHMlDJAGDi2l1qSprfKKtHceNNYr+7qFuVDo/Fw3Aq6JMWb/crnA3VRuQph38+mIb1vhqzrYc8m0gLGIk6JcJMKWmJu5he6kEvCElv58FZDxtkiO4ToR5te0OJg9QRROXziPj0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdJ4lWw7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucDHXGDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+8VoWEW0XZjMSQDsaz/4MYv5EAvq9VHzk9t+oyNa0Y=;
	b=UdJ4lWw7v2I7h8rlVSgBO1H7lbgE2CQJVtg1tQNzEPUZQugncjO8v42VBprWMFn7qdoz98
	XI01RIJupRljigtUN1c20CBHKzXqsaxTi/0iF4pS8ga4+pHvXMH8TFaMkfdKCsGAuXb+fw
	4D+YgZxNmJ/XEaBItqYb3bV9FBpqB3jBze19yiwLNmpKS3Nj7XEWQeep84r6s0Td4D2Z0L
	QXeqzMiednwyFMlbKzbBwV8GSVKyhw81VxSW8s7Fo9wwOYcGObsnxO6XM/TC1nco5171FT
	BTdtQZkeDG1M+uJMPfsY4AQ9W3NPz3xHEGF88VWy33ophkr3vbItHW/V2a2fzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+8VoWEW0XZjMSQDsaz/4MYv5EAvq9VHzk9t+oyNa0Y=;
	b=ucDHXGDZVX/+tmsR+WrdoJgiJe0nJP1nQC+1q19tObd47efqragCDBtRC78EgoWnQYq/l2
	JiYSfpVDsOeUjPCA==
Date: Mon, 07 Apr 2025 08:52:40 +0200
Subject: [PATCH v2 17/32] tools/nolibc: use ppoll_time64 if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-17-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1086;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UfwFCU91ffZuTdxNtj6J2SdT3JrHuwqMEWx4TRmx2p4=;
 b=L4+CAQe6TXN1O2+ZX8Sh0H2rY8xWrw0WRDzHukKtWkWcJ43BOj9HldYG57DfeE3sRU0JpiYaQ
 Dl2/lF0SgizBCpz9DQ3AlNOxo8ltJfqoecYYA8DsJo/buPQjm4HTIRO
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


