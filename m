Return-Path: <linux-kselftest+bounces-35464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC8AE242D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3271C2175A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D9239E64;
	Fri, 20 Jun 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Hsy2oohI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F43238C0F;
	Fri, 20 Jun 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455589; cv=none; b=KkxS7Rc7Gzfp5hm4R4mLFP7R+PIsfcuospWrGmahloLLxQDdQzwK0oXnHf62TFkyVLnONGMt4+tkmHqZGd54MORg0SESp0eGNeQUxZd7wh8ucg641+glyHzSqSu3VLNS7NtfIlHUoQbqhmrJSzni8oy2wmbFoR2StUgWVzbTknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455589; c=relaxed/simple;
	bh=txCjIBp7fMZKfcJXO+z5XgGsJrosp+zHd4noDHk6vuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRaWPfyrNhPf7dC7mYakV/URrD1ouIuKz6o7lgje9JiLoogtHSWHaP1o37wz0DwpoWvSpbzEqdQASvii2AyGuS6ABrYxW5ZmSJIvEozBhqD1YDoArF20OHm5wcR2eSr3Hw/9LEDaVJNS8KriBM7AxI7/sp8DDwuYL6Ado/IBDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Hsy2oohI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750455579;
	bh=txCjIBp7fMZKfcJXO+z5XgGsJrosp+zHd4noDHk6vuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hsy2oohIoz1NwDn9O1muFKJAOlWoVuw6/i8Mh8a8UL4pQxdZLkAuDJM/OKYOzqeXC
	 pNp0yk3XBajEQTw+qUF6V3rKdhtkBU44hLmzMjTr2yJnr0X87zWBKnJbxQz8CLaF3y
	 0oOoi57r0vnHKBJWyYySbIiiOQORy3TWDGpIpHgs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 20 Jun 2025 23:39:30 +0200
Subject: [PATCH 1/4] selftests/nolibc: drop implicit defconfig executions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250620-nolibc-selftests-v1-1-f6b2ce7c5071@weissschuh.net>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
In-Reply-To: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750455578; l=1451;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=txCjIBp7fMZKfcJXO+z5XgGsJrosp+zHd4noDHk6vuM=;
 b=9zHfwAxtjs6za0X3hhzrn51nKfJiXL4ElfDNl5TtE/Bs09o+iaqlrGyJSsTDdqHHi8Sq9tk1M
 8hGY3i3oB+MD1cNSMiYbymxsmc13G1ayEp+txVut9mSMv3b6qh2cLwo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Commit d7d271ec30dd ("selftests/nolibc: execute defconfig before other targets")
accidentally introduced implicit executions of the defconfig target.
These executions were unintentional and come from a misunderstanding of
ordering dependencies.

Drop the dependencies again.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/3d5128b9-b4b6-4a8e-94ce-ea5ff4ea655b@sirena.org.uk/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 147ce411b46ac84ea3ee0f91a55a7bb6c0712626..41b97dfd02bff3fb57f4d2b73b718f5c389d25e9 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -307,10 +307,10 @@ defconfig:
 		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig < /dev/null; \
 	fi
 
-kernel: | defconfig
+kernel:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) < /dev/null
 
-kernel-standalone: initramfs | defconfig
+kernel-standalone: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs < /dev/null
 
 # run the tests after building the kernel

-- 
2.50.0


