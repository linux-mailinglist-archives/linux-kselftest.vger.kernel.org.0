Return-Path: <linux-kselftest+bounces-35467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B728AE2434
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC93B4446
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 21:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F85A238C34;
	Fri, 20 Jun 2025 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WaSFYBJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAE218596;
	Fri, 20 Jun 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455590; cv=none; b=kC0KkhDW64tPUhyOTB91cJYR3QIc78MMNbK0iRbjFJYU+/p2FV6Bi9SLOv5fGifWs6CQDcSNEQ5mrLPivXjfcvdo3nxfmfufodIHGtLbkKZG9sWesHDfPTnYhvM2E7QG7s5Kv9noL80zp5hOdGtM2jhUkhtWsNi+VpTs1Yd58I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455590; c=relaxed/simple;
	bh=DOp3MwDL1Dnv3cqUgbx/x6jmoScWW6MBfnQhM9z8lRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJu2Pp9pJL8LSuiUjVkwVfl4xOd0GvQv8aG2S7kHFbQeShIvg810RAeNthJDzVFbog8OSstu10zBG9L9g7qNaVqx6Bszsn8xfCMgby54zWFjEHpKSXuAdmmBrR1sp476uSFrlz7DVV1NVrHL/Vh92UCuWD0bAFQ4Af67UUvko20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WaSFYBJK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750455579;
	bh=DOp3MwDL1Dnv3cqUgbx/x6jmoScWW6MBfnQhM9z8lRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WaSFYBJKC4rfklM4SwzPunmurZPltXvSPl7O/IQ7KYHAjk/3ZseariVY2pQKfft34
	 N9SDQOvm3xkYg1IbkR0/ulaA3DpGqhDJqfQmIu9wyzgo9y00PYis2OksK74VjFh8Ug
	 QZ6fKGpQXBRfm3NFgWPGAQqTmElviz/fTSxg1Oao=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 20 Jun 2025 23:39:33 +0200
Subject: [PATCH 4/4] selftests/nolibc: integrate with kselftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250620-nolibc-selftests-v1-4-f6b2ce7c5071@weissschuh.net>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
In-Reply-To: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750455578; l=1744;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DOp3MwDL1Dnv3cqUgbx/x6jmoScWW6MBfnQhM9z8lRA=;
 b=bjes1PZdG70MWZuu3CSg/Qp5M4R1cEKxyXXbjJBjHqD/fvhoYGGTKoulmJAuxsO2sVm3xR02E
 +KfpKZDPu/+BOZ/ooxBo0hWzvKgxI3D5QK/X1/ifUwvEyhiJMgBqn5n
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Hook up nolibc-test with the kselftests framework.
This enables CI systems and developers to easily execute the tests.

While nolibc-test does not emit KTAP output itself that is not a problem,
as the kselftest executor will wrap the output in KTAP.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/Makefile        |  1 +
 tools/testing/selftests/nolibc/Makefile | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 339b31e6a6b592217eca1c03068f21728ea024b4..3a4c98102f6967c4a1586104a560418292b3f31d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -77,6 +77,7 @@ TARGETS += net/ovpn
 TARGETS += net/packetdrill
 TARGETS += net/rds
 TARGETS += net/tcp_ao
+TARGETS += nolibc
 TARGETS += nsfs
 TARGETS += pci_endpoint
 TARGETS += pcie_bwctrl
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..fc7a65ca5fdd77576be49d6227939ec5451a814a
--- /dev/null
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS := nolibc-test
+
+include ../lib.mk
+include $(top_srcdir)/scripts/Makefile.compiler
+
+cc-option = $(call __cc-option, $(CC),,$(1),$(2))
+
+include Makefile.include
+
+CFLAGS = -nostdlib -nostdinc -static \
+	 -isystem $(top_srcdir)/tools/include/nolibc -isystem $(top_srcdir)/usr/include \
+	 $(CFLAGS_NOLIBC_TEST)
+
+ifeq ($(LLVM),)
+LDLIBS := -lgcc
+endif
+
+$(OUTPUT)/nolibc-test: nolibc-test.c nolibc-test-linkage.c | headers

-- 
2.50.0


