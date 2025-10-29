Return-Path: <linux-kselftest+bounces-44307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4142C1C286
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 468CE5A0816
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF53469F1;
	Wed, 29 Oct 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cbtP9S3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48356272E6D;
	Wed, 29 Oct 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753891; cv=none; b=W1CSeMMdNL1pa/U3VXcIrJiYyXB3fmacJNumNsOzTKJURuIDCvcfTaztFXSg1eaN6P/TqrIsBd6Hd6an89pg6ed1mHgPaVZJoUoQXrDpZDGA3mq00X1TAUfwbkCUMWO4B6S7Xed/dsxtjvZIwxmCOq+Aa85VWQncwRs/2R65G6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753891; c=relaxed/simple;
	bh=3TD82kCZR1eUnCRzxDHjKFGl3wY+LjKiHLo/qxVzWVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnZzl6Vgb3cB8hwHMTQFJh3lNq4sSPTWNEGdJmN2ItpHaa5abSzASxn+CPCsjXSeUbJGukdFyI4BgTXcg6DIKRanmVV6xeGwnfRQTdfM2ik5uFOfUIOmnr4FbAh7/cGu/s4CVFpXBh3oLCokKb1CBBUyt5iWzHbZ2zphHCWz4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cbtP9S3t; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753882;
	bh=3TD82kCZR1eUnCRzxDHjKFGl3wY+LjKiHLo/qxVzWVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cbtP9S3tBLjXuoA0dZzHuRhzLQWD50b2tlCS2kydJsjGQ6zxCnf4Uoe615TXns+W5
	 0SZZ7v7UhyE/3WJXgiqIhJF5M3ISAEyhDa4l8Ec9IIxzRMjSnvx9egpI5ZaVuDKVHL
	 6vWS1055Lxsnqw1+ZUVASpuz4zpQJjP6BJpaTx3A=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:52 +0100
Subject: [PATCH 02/12] tools/nolibc: handle 64-bit off_t for llseek
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-2-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=832;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3TD82kCZR1eUnCRzxDHjKFGl3wY+LjKiHLo/qxVzWVM=;
 b=RSO6RXiJE4EgEBbogH8rxXKocscQypP/Y+d+hwaU1fSNMYBs0qX8THyYS3AWz3ngtOVN3pGh8
 9Y6T0UmoQCqBf71BrytykZnX1qd1AgEOWSOUsksMme1NM3dTIgDMPNk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Correctly handle 64-bit off_t values in preparation for 64-bit off_t on
32-bit architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 386ed80aead0..321a3bd16ff4 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -599,8 +599,7 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 	off_t result;
 	int ret;
 
-	/* Only exists on 32bit where nolibc off_t is also 32bit */
-	ret = my_syscall5(__NR_llseek, fd, 0, offset, &loff, whence);
+	ret = my_syscall5(__NR_llseek, fd, offset >> 32, (uint32_t)offset, &loff, whence);
 	if (ret < 0)
 		result = ret;
 	else if (loff != (off_t)loff)

-- 
2.51.1.dirty


