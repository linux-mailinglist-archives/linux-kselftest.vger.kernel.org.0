Return-Path: <linux-kselftest+bounces-24982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C528A19F27
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0340C7A634C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098420C02D;
	Thu, 23 Jan 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fdhoS1nm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E820B7EE;
	Thu, 23 Jan 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617927; cv=none; b=oY2XDd6T6bigNL+iKb8CBi/VvuBHCn2arArbLyuI9pKUpaxslKkhpcOZ/xUgrb5aMDYlhR9tUpsyjwQ1+Q5OD0LPdBsV6olCKceU0sdRutFEwRSqxHpfqX008BGgRlY0OmLi4Vwg+6oJqfrhIzY/bjAPOZYbVwCWHif8w/4lP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617927; c=relaxed/simple;
	bh=yOnX0FgFgCBauRdniu/luUgUK6bKzG+/jixgAfNPI50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3+gAjiTUJ+ua7E9w7LgaDstvIdIsufnq4MhWsxGlKYfdif4mdrVTBC5uViNKRbbucMZFtWD6QlYIUbo1A28Fn2Tnv5XOHQ5jUdnxo+op28SS6ruv2U6wyJvObtXQUhqsv1WpWXqs6jKSBo979otHHYkWeuidmpKLA6TpLUIJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fdhoS1nm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617921;
	bh=yOnX0FgFgCBauRdniu/luUgUK6bKzG+/jixgAfNPI50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fdhoS1nmZfFxvT+Jdb647NmhVwOUnbWTeoJGXWVB5gJUQIS/5yAjk/6nOG60Ely+h
	 qhubgWL8WeLpah5Zcdyvhui9d8nl6w9l8s3JBtMdXpUqfzTnBfZJ3Ut/sHf5BVXuTp
	 oGdpsXzOL8BXD/9H1xIKlZvdK4VezD6vN2zqQOXE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 08:37:38 +0100
Subject: [PATCH v2 2/5] selftests/nolibc: drop call to prepare target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-config-v2-2-5701c35995d6@weissschuh.net>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
In-Reply-To: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617921; l=1035;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yOnX0FgFgCBauRdniu/luUgUK6bKzG+/jixgAfNPI50=;
 b=3c3uXajMzIEqHCg6W0c2KbmDdcMvWn+p61TmFTJg3H1DTmZ3W6Gsms5EHmTICryzj8FYmRdTM
 JR/6W1zh6nsCGAtoHkJiv1tCQ99IOWcc1GZOmKncQqVaU7vYiCm/UQ6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The "prepare" target does not need to be run manually.
kbuild knows when to use it on its own and the target is not even
documented.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ba044c8a042ce345ff90bdd35569de4b5acd117d..464165e3d9175d283ec0ed14765df29427b6de38 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -261,7 +261,7 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG)
 
 kernel:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) < /dev/null

-- 
2.48.1


