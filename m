Return-Path: <linux-kselftest+bounces-24959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DACA198AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CC5188D8D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1D215F42;
	Wed, 22 Jan 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="E6Gqx4xU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B91215773;
	Wed, 22 Jan 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571324; cv=none; b=m77sfj29fX2NOREul7ZfrGnlp17k3xSiSGv73EHdT380harg/9KphQ7OTlwf69kfOwsw5SHt+GHkLyj+Ef3kqTD1OzEZQ6Lp5qMYwpjtt0+RryVtn3OlWWooTAqXPiaEJo66x5oqUh2PPoW5dBfn4gQhzWJrIW19TO7/Aqymb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571324; c=relaxed/simple;
	bh=b3ngHEymh1xN/jzU2pxJXFVn1ST1gsxBzlNsnsYEeLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDiElwHT6HkLxACSeB0xnfxjJVcqoTtdlBn8nkIpAdK55myEIA78w5iWFwAQmcnjPDd3XkYFN6qYLZIfRNeqI0TzvjQMIMrRLw2VN4oaRd5KZZ0So+aeWaHGOFYKnotXxIrs4ngV62rAOFVyJr/Os9ncNpt3cKas/eim4XJ79Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=E6Gqx4xU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571320;
	bh=b3ngHEymh1xN/jzU2pxJXFVn1ST1gsxBzlNsnsYEeLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E6Gqx4xUAw/nOSnNzu/nzhj1Bov82hFQ+0kjshS/3sY8b0Q5TeeTJbzgDWMp+npbZ
	 +utS/WWf9KDb3gCNGupOy+t0s2luw37L1sIl820u6YGhlX1/8vWwvoAtX+/IrTk/ZE
	 iT94L4RVdLNFpvob/g5dIqi2Qu2T6x8nY0YACmAY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:41:46 +0100
Subject: [PATCH 3/5] selftests/nolibc: drop call to mrproper target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-config-v1-3-a697db968b49@weissschuh.net>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
In-Reply-To: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571320; l=1060;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=b3ngHEymh1xN/jzU2pxJXFVn1ST1gsxBzlNsnsYEeLc=;
 b=upscAaF1MGkrY26FFOH3e0YcfJGy35xUUtXZ+YLVD3Ty851wh32k1sDA78rJLaxvUDevFkHVt
 TNRvuCNu+70B7DP0IE99LdAyRj5fDz48N2gd0gpEzi90eG9Dy0nUNcs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

"mrproper" unnecessarily cleans a lot of files.
kbuild is smart enough to handle changed configurations,
so the cleanup is not necessary and only leads to excessive rebuilds.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 464165e3d9175d283ec0ed14765df29427b6de38..d3afb71b4c6b7fc51b89f034c826692e76122864 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -261,7 +261,7 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG)
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(DEFCONFIG)
 
 kernel:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) < /dev/null

-- 
2.48.1


