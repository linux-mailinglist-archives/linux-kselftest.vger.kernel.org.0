Return-Path: <linux-kselftest+bounces-24978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7042FA19F24
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442667A56E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3204820B80E;
	Thu, 23 Jan 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Uyvw2/KG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A3179A7;
	Thu, 23 Jan 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617926; cv=none; b=Q5nctK6M4FUydkKCMkY9vijZt5wDMauDCWyEn5tMUysWrG/eocEQkrfyJMPPCH/++++cCNzSoygl0k4AxSbWLk8rW2S5fsNskz31PuKA2UNLnAgSSWPoHuteY+nKDcByQ9wMQ/UwI77MgBGBFChT0yRwx0ZdXlOmzHhBlCVeTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617926; c=relaxed/simple;
	bh=b3ngHEymh1xN/jzU2pxJXFVn1ST1gsxBzlNsnsYEeLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frg6xFTsOlMBfXsp9Nw79PHL22JrS3Mg/lw1VJ4S2IejsvQPdwpcr6Z0mweldakUjKc+23nj/vuJM3ZWolfSaBkSwyEiIKEt8aH7/imKrNfvUczT3OcK9PdTvYmbIZOKLARiJ2HWzhSPhqC5q5anaCpuy5G+0qqtOj0CknmGiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Uyvw2/KG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617921;
	bh=b3ngHEymh1xN/jzU2pxJXFVn1ST1gsxBzlNsnsYEeLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uyvw2/KGJUaK7S6PTi7nh18gLx3/3ys1adigTBzEmYU2++v4aJ7N27vsdTfS3awXn
	 nG4M/Nq7aRxCJ77RVvxRNcraCkUfykn/SSRlhHgtyy9QTjditVAhgwrs2haaZzk2JK
	 jJ1sKmCeFUGmU3MkG4UFrQQ19GyhYg273qjHNtug=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 08:37:39 +0100
Subject: [PATCH v2 3/5] selftests/nolibc: drop call to mrproper target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-config-v2-3-5701c35995d6@weissschuh.net>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
In-Reply-To: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617921; l=1060;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=b3ngHEymh1xN/jzU2pxJXFVn1ST1gsxBzlNsnsYEeLc=;
 b=9h1P0DTnjCiXPcYVsKNxBWxZJ7azaKGsq8ag6l7xwjUtxP27Y1O8NdiGdbnEUW11btiP88OEt
 Li2AuMJYFftCDcqNKaFdgt1tanUlpMdoht4JZesjxDYytjZFN4mmlrd
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


