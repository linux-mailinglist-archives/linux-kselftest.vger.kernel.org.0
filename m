Return-Path: <linux-kselftest+bounces-34452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C951EAD1A8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9475616BE40
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354772517AA;
	Mon,  9 Jun 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NggJ67Vd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35F1FC7E7;
	Mon,  9 Jun 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461347; cv=none; b=d4xXIt1R8MNmt3ZGOIRn7Z2C4kZSjVekax3+nub95udfbueIhZXQQGmQ4DwNGolcoXfaMuNyLGWVsyMNpWw25rDptc8SoNx2LWfnYAXOzpZfTmD7Trhk+pVywXutoWZvs0T4WnBSji4G5raweIk/ZNktZK/tA9wgLoE3Q1FWVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461347; c=relaxed/simple;
	bh=qdPGpd0OBf2lCfW2sBZZl1KesI547PXMUYolLF8VpwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsmeQ45hOPqKS0OL3JA86KfoCkOnamdfXYd3letOpJAecS3/8EEtrWAspU7/I6Gkm+mETVe95Mzx/VEoNXdl5xeRytwqqjL6uhjcXfK7vzhG4fNBj9b2QKtnB4CsQwP+8PUZMLcEA6N22AO0eKIH3+miX8o8lA5nfdhxoA5+sxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NggJ67Vd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749461343;
	bh=qdPGpd0OBf2lCfW2sBZZl1KesI547PXMUYolLF8VpwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NggJ67Vd3teVZAIa8Sc4kpyxr27x9qFYYDl4ZQ8FDr6eupskos5w162NgXNbiarwc
	 SWJx/byeLfJTk40x2QfXMAX2d/AJVP3cjY+OaEo38haBAc0LeYODJXJPktkR7P4VTm
	 j76+Qu/WJ2tWIP4M4Oahaf/CdfsZOJZjGAu5AaNY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 09 Jun 2025 11:28:58 +0200
Subject: [PATCH 2/3] selftests/nolibc: use file driver for QEMU serial
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250609-nolibc-sh-v1-2-9dcdb1b66bb5@weissschuh.net>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
In-Reply-To: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749461342; l=1709;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qdPGpd0OBf2lCfW2sBZZl1KesI547PXMUYolLF8VpwI=;
 b=7y+2WNcedXjbu5lqzEjTwB3qLJBOz5oIFvGlL0cOzzXxKdifehE9ZdTc3TT7ODkmX582d46Ke
 5GRGvwe4OBLDqalJi1AB+JdCKBrjGHEh6MIRzOI5KlMkwpmQHL3TwpC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

For the test implementation of the SuperH architecture a second serial
serial port needs to be used. Unfortunately the currently used 'stdio'
driver does not support multiple serial ports at the same time.

Switch to the 'file' driver which does support multiple ports and is
sufficient for the nolibc-test usecase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 22da78a4bfea0274f66abec319d34b3d2a2824ac..238acaa7bb06dcdbcadd9d3190c2de726e1a40b1 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -315,12 +315,12 @@ kernel-standalone: initramfs | defconfig
 
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
2.49.0


