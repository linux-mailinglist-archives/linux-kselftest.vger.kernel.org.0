Return-Path: <linux-kselftest+bounces-18552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1142989800
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 23:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A351A1F215D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C317C9EA;
	Sun, 29 Sep 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="t2wM1fTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C68F6D;
	Sun, 29 Sep 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646471; cv=none; b=klK2cGRhsO0GbgBxNL6RNjSiiSFFVchfIT5NEg3nDBxZ3VUhqU/h+QKRYjLlF8NHGlQ1lDxUHQN5EYYoAbBC9bliXVLK6NxVANLEicE2wtRxE5b3OAHIJzznx+XMvIKJ42ZXAqXGMj50/HVKKFQ6xLGI+KcDLWnKt8N98RKgxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646471; c=relaxed/simple;
	bh=AsJHVK60vM8HIohq226Spe/+cd3HPgDderr8uqmDSfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezTb06sAqVKM74da9lVsuuv5bpS/JLi2UkAXUnBEWLNJt73b0DY9O+WKtnZOdijqRlS8ab7vl9gfv6JFq4/LcebRudeqyoUOVRhGS2iusx4kUVO1Wc4Bdau81Mt93+XYjf/w56PofURc96rjeIP650TKxdxKJ3erfpNLYVfdthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=t2wM1fTZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646464;
	bh=AsJHVK60vM8HIohq226Spe/+cd3HPgDderr8uqmDSfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t2wM1fTZQ8XyCHHB1mjswvdHmpzfvgE8zsOWWVY3nfBKUD2dupTWJ+BpGZYD0ISxS
	 j90iwDzQ2qneKpnAAj722vOFJi3BI6CkuFnHurf1AseuisAjHPXUK9yJ3eZI7IeUoh
	 YB4+O8taWU9VlDRBLH91aFmq9oDnq2CcdRigVw6I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 29 Sep 2024 23:47:38 +0200
Subject: [PATCH 3/5] selftests/nolibc: add support to use standalone
 kernels for tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240929-nolibc-csky-v1-3-bb28031a73b0@weissschuh.net>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
In-Reply-To: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
To: Guo Ren <guoren@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646464; l=1908;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AsJHVK60vM8HIohq226Spe/+cd3HPgDderr8uqmDSfI=;
 b=/1nN18yVpzqP1spFIXxEEJQ5Xk851s6rB1sfm2gFycmVazAio5dOkV22+Mh06qAZbrsnz9By5
 v2PGey+KgNuCHGoHABCGSwNc73oWn1FVWOX96eYWofSVXpU0qZfKSBw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all architectures support loading an initramfs through qemu.
One example is csky for which support is going to be added.
By allowing to build the initramfs into the kernel itself this issue can
be avoided.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8de98ea7af8071caa0597aa7b86d91a2d1d50e68..e8278924cf28f17144044e69724df1d4fde141a3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -265,14 +265,21 @@ kernel:
 kernel-standalone: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs < /dev/null
 
+ifeq ($(QEMU_RUN_STANDALONE_$(XARCH)),)
+RUN_DEPS = kernel initramfs.cpio
+QEMU_INITRD = -initrd initramfs.cpio
+else
+RUN_DEPS = kernel-standalone
+endif
+
 # run the tests after building the kernel
-run: kernel initramfs.cpio
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+run: $(RUN_DEPS)
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" $(QEMU_INITRD) -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" $(QEMU_INITRD) -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log

-- 
2.46.2


