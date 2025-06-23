Return-Path: <linux-kselftest+bounces-35643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A76FAE4F77
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5091B60F8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C521B9C9;
	Mon, 23 Jun 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WZofouo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214C2628C;
	Mon, 23 Jun 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713372; cv=none; b=i3baRM5hIDflqPRMVALZ6akOpP8dQu7PO2Hk/p3eYEYlEA5tsARqPEI1MJbGCelSnof8e/VVwFI3A19SDJgB8sZ4SJUisgaoW8cE5ZuUJthDn+KbPPGinmTUYAKZACc7MfAGgduCnyVg/wKk0SQMXiR1HFsWxsmsYnEiDSVsNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713372; c=relaxed/simple;
	bh=JXT55h1kBuOnOzqPmpYxX1L2/iZn2J8XhrAQLZByMqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA+PX76WKnPvvC7lcL8elAXrJpMOi6OfuvUFHYCC08bBN1V5Eo7Ejgj29d8U/Rawzh/O6Wo+n3v7GrQoXZNGL70s9GshGLS+RzpDRC6SPSiH8Z1ku9paDmE9SHlM5dDLKTwcghwkCbQBiu173D1nSCxptVtViszJtUBn7MxW5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WZofouo4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713368;
	bh=JXT55h1kBuOnOzqPmpYxX1L2/iZn2J8XhrAQLZByMqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WZofouo4A2DqrhUw/NzUbOORc1oZ1Cphg/szyquc7/xvEXDls6ZxwWlBncnHj1qQe
	 gAO2pIpdJJF0R8l6Xk7Q9T3w5dKQkkWqZ//XCUXFTblTeCN86d2m6fQ37QUK5y89FX
	 5GVrH7BHmv1dMQjpz3pM+g9U5hhXVxtvSNOoK36M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:15:52 +0200
Subject: [PATCH v2 1/3] selftests/nolibc: fix EXTRACONFIG variables
 ordering
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-sh-v2-1-0f5b4b303025@weissschuh.net>
References: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
In-Reply-To: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713367; l=1123;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JXT55h1kBuOnOzqPmpYxX1L2/iZn2J8XhrAQLZByMqA=;
 b=Ju5eduvCW7qTCKhvkS1NoIMcxHMmg5crbapxtIQIsSvPZMv49Y4FKGSIkeO6QotRGU2GcNKxf
 uzkdHSsYPXvA76PcHrxb6ua/ucMrX6E8OFmZfLbo0kLA+2n0+uUJAju
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The variable block got disordered at some point.

Use the correct ordering.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 6d62f350d0c16405785a8aabc7f5741b82e55370..9e220a733d97f3f916c6aa38df2414781f17ef94 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -107,10 +107,10 @@ DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG_m68k       = virt_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
-EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
-EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
 EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
+EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
+EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
 TEST =

-- 
2.50.0


