Return-Path: <linux-kselftest+bounces-46321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31EC7D440
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A6B3A93F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574742BEC2B;
	Sat, 22 Nov 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="swzFT3z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF786280329;
	Sat, 22 Nov 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830795; cv=none; b=bNMUKe2FWeN3PUuxSlgxsAnVxxnump/RqXjZ7Hte4z+c/JZhEzsg8NoWBkteiQSdvP5rlyvdsAW7fwM8UavlugSQVxTDHhdcM1mtzU16Vx5iBnzHbeet9wtVqN5VYyxmitX59OxlR27sWlYcJD8JqFva5QNDuD/XPyBglkXW4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830795; c=relaxed/simple;
	bh=FcBX6WX6eEYWTFM1loQqCICXVcxi2FvrUgIrTEODT3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILdsdImvCDuJdjTfnMdaET/efJFgVHZnzC2bKjOYirdrn2K7tOGNi0EUMMSkG5Nok3ynSl4zZJwoS28CqDCmtRBfhFIhNaFx3VMkVu0u9At4MrLb2lb2dFIgN2aslfaeEHdRy3e9xsCDtpsIm7jJvJC9ADVvZXUln7Emev3amJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=swzFT3z+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830790;
	bh=FcBX6WX6eEYWTFM1loQqCICXVcxi2FvrUgIrTEODT3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=swzFT3z+Jg3yO0jp1LdhOxwjCDYyUO2mIuJ6gxnm60JIzsdKjn9tnXqjRmo1drhg7
	 Hssqn1f5Kn9OWjWu9NxNShr7yMvYkuGngq42ekmQ2O9D/5LsaolELmvOdhTiPyqd+Y
	 M5oOKsbNns0ZjFV5WFcWZ2nUT86vffcmhT3jDh8g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:08 +0100
Subject: [PATCH v2 02/13] tools/nolibc/poll: drop __NR_poll fallback
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-2-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1128;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FcBX6WX6eEYWTFM1loQqCICXVcxi2FvrUgIrTEODT3U=;
 b=0Mhlv6bJ19TqeJ+H3XN2EVDzMiB+gFo1aeGFBuMn5Mas1bOkuPxfIL8Dp44Oqp8JC4cy9ZF7T
 hK1x0qmeq2OD6LZsaebusOPovMVVZwrsVVkccOIp0CwBe2BdpZhP7Xg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This fallback is never used, remove it.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/fbca1d3e-12e4-4c4e-8091-87464035fe39@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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


