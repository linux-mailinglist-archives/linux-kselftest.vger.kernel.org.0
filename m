Return-Path: <linux-kselftest+bounces-47761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF2CD3004
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD8803001603
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B52EC090;
	Sat, 20 Dec 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="h41IrtiF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7529AAFA;
	Sat, 20 Dec 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238967; cv=none; b=sDFS0x1xAvWn6dO22CVcgPLoQPlQ1pB8Id5nf/iD6iuo1sFvR+1QVLNR+c8wYCt4hQQxBVdZZFSKbWrSGWX87cK0J4RD9KND7r+ZvXFv6UOseb3WjA9+l3eNQLQgOthLZqeR+v9N1SqluXvrYq/QveJRMJx4qJ/jjRYb+m197I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238967; c=relaxed/simple;
	bh=SLJeUwwi9ZNSa+MHhBcAuBf0JBKtu7Rmc82oI2zk0Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tTNLcIF1Q5RXl0/Rozjv5+O0wVocLF662QZcfvPbc6vBbzxYdDkrj5ynHjbWLq7Fji15EJmUPYxpUYDpZQR4pnL0hSe4aKGmpZ2WhO/jr0tUzsf0Fo4inRxlE/KuY/PkVMMCiHDlV7mkp0Y7DsK/81dJnjTVt+tKh1/atM58+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=h41IrtiF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=SLJeUwwi9ZNSa+MHhBcAuBf0JBKtu7Rmc82oI2zk0Ek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h41IrtiFnqJiYbiYwPzo2uXr9GQ6FRP0J9h2iTpHvco1s9Qr3R2cMJBd4V08JACLd
	 X41v8oSSfBtn+KCumFD5FQirU5IDa45+xf9Re/Cs0CKSHznccFqEOzGrjSufOJZYlY
	 UcaBPkr7sZsvSzBh2V1U//euXVsQ1dwo14+mfLI4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:46 +0100
Subject: [PATCH v3 02/14] tools/nolibc/poll: drop __NR_poll fallback
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-2-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1164;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SLJeUwwi9ZNSa+MHhBcAuBf0JBKtu7Rmc82oI2zk0Ek=;
 b=hefLYNpU5eTUf2VDsQeDvYUC/miRDcJqxXy0XqLWeLIhjZRczqB9yovvdo0oon1I4vZz4BDQ8
 c3H9APfECDhDdh/i+9ypS7mYrGV4BGbRmoSa7Q8LTw+q06U8dPJUtEO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This fallback is never used, remove it.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/fbca1d3e-12e4-4c4e-8091-87464035fe39@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/poll.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/include/nolibc/poll.h b/tools/include/nolibc/poll.h
index df952bcf0905..5b4fa339fbb5 100644
--- a/tools/include/nolibc/poll.h
+++ b/tools/include/nolibc/poll.h
@@ -31,7 +31,7 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
 	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
-#elif defined(__NR_ppoll_time64)
+#else
 	struct __kernel_timespec t;
 
 	if (timeout >= 0) {
@@ -39,8 +39,6 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
 	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >= 0) ? &t : NULL, NULL, 0);
-#else
-	return my_syscall3(__NR_poll, fds, nfds, timeout);
 #endif
 }
 

-- 
2.52.0


