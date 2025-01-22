Return-Path: <linux-kselftest+bounces-24960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F4A198B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39645188D902
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B032E215F5F;
	Wed, 22 Jan 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Yhw4X1lQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B20215772;
	Wed, 22 Jan 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571325; cv=none; b=I2rQzqW5MlvMMCc+ymm7IIpnYezXFeTfognkpYCgOJIXGgbJKkyTP9Q3S7ATwGqmF3WWU8cjOT6qewhbAVFwLW+zD21nyvgJn9C5zi18sdnt4W6D7/e3FPyUZ9lzZI0Tm4II0DSkPPcGJQPB/x07RBOkmMU6YaRBv73YYW4/d5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571325; c=relaxed/simple;
	bh=yOnX0FgFgCBauRdniu/luUgUK6bKzG+/jixgAfNPI50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKtrQeOzAIKPMrE5ZHbVh/jEbaJYiTPMVL4dsRE/eNN0On7w40Cbe390EyJQu7rrLkQKCFIguvWoVKIRNTVNNnFkCZb0wJrvRZovXx54zCznqxy6IteuqNEqhndS/BpBco3ZjNkWY+T9qfKPxzbGe4ICSbujeGorSQT7kJj9VWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Yhw4X1lQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571320;
	bh=yOnX0FgFgCBauRdniu/luUgUK6bKzG+/jixgAfNPI50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yhw4X1lQIVawkE4akuZu99ipUYMW7K6D717d6qR+vot6m2D7yK22o09bPRMytolMQ
	 L7OI9AXt2uXrpSqB34qWEy4QY0zT/vBK8cgvdNL6+94x7X3OrdEClf8r1UTgfLoj+H
	 NVYqW5l/1UnBNzADcAv2T7b3KnDd8XCxmaH6LmF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:41:45 +0100
Subject: [PATCH 2/5] selftests/nolibc: drop call to prepare target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-config-v1-2-a697db968b49@weissschuh.net>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
In-Reply-To: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571320; l=1035;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yOnX0FgFgCBauRdniu/luUgUK6bKzG+/jixgAfNPI50=;
 b=xUSgaq+CBfe1W+ws87ZgQTUUg7OyhFgomVpjI652MuEBzynN5/krmpsBgjCk5zBesw5TDoPF7
 NWbgWqBiF78AXYamqcJOUNRVeQbFIR8c+0oeNYVy0WSwYn62DcZzuKH
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


