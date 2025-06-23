Return-Path: <linux-kselftest+bounces-35644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1380AE4F85
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729507AD062
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8E221723;
	Mon, 23 Jun 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mKRm93PP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FE1F582A;
	Mon, 23 Jun 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713372; cv=none; b=Pi3knc9VC/6nWf8mAAeFzvaeY7gvv1H7LXkOl7fYmL1eoJb8viigvm6kCds5+qrZCLROxuff1FcwNsBc2I8eXVYiQquVOqeH83R+GBzO7LZwCpLx8veYlVxcmbrcKVA1gDiIabf3He2UAEzG9ZaZJvYZWDTTrRLPdtGAoroxBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713372; c=relaxed/simple;
	bh=AXpmx56Br8rtCaljBJmjxSdc1RxM2udDj6+vnOU1qBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFBWnd9kXSsphVYWvm/HpGx9mi+ZoxYlPGvWcSrbKN1yl6Dbrv6aLW7+6wbh7X45WaZi+JaphxX5Se98lUlrsPIltj1EdxgdmI5coknE5EzI5BOHuCwR7E8clpgObIlXpkcEym2AgtN/VTJiUBUG7pb8IRSrTSRs97JVhbTiILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mKRm93PP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713368;
	bh=AXpmx56Br8rtCaljBJmjxSdc1RxM2udDj6+vnOU1qBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mKRm93PPYvPOvKfQAmIedippTp885v9QdH8yvIlDSF6liDlpBb4ZAYsi6LPoXzJC0
	 VY4UiggyWaP15K9bQ6im5kSuzR8upPsMTpRMLntHpiChdWsYO29y+/MOv+FPgHkIBN
	 l+5RJPU/B2ByJY0iVw3LdS/ySWUNKsKkxiyQlr8g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:15:53 +0200
Subject: [PATCH v2 2/3] selftests/nolibc: use file driver for QEMU serial
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-sh-v2-2-0f5b4b303025@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713367; l=1768;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AXpmx56Br8rtCaljBJmjxSdc1RxM2udDj6+vnOU1qBw=;
 b=KXimSMwxaQ4c7kUohn5zfomefBOacBntKx/adLUEEZP1MCRngmETrlOCLznK1D8O0pMBf/nFN
 0oOjuxG/MeLDc6+E0ExBVZdwS5PB2emv87/sZS43npFVfwq5wMFBhQm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

For the test implementation of the SuperH architecture a second serial
serial port needs to be used. Unfortunately the currently used 'stdio'
driver does not support multiple serial ports at the same time.

Switch to the 'file' driver which does support multiple ports and is
sufficient for the nolibc-test usecase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 9e220a733d97f3f916c6aa38df2414781f17ef94..ba3b762cb103ee87aafecbd5e838fc0e678b7b50 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -311,12 +311,12 @@ kernel-standalone: initramfs
 
 # run the tests after building the kernel
 run: kernel initramfs.cpio
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial file:/dev/stdout $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial file:/dev/stdout $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log

-- 
2.50.0


