Return-Path: <linux-kselftest+bounces-14340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB693E472
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6561F21555
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85E5028C;
	Sun, 28 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OvVm/KUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213993F9EC;
	Sun, 28 Jul 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161421; cv=none; b=teShoJfuUyj0n8oWZbNZw6e4syyF2zeunhcii36v4PDmpm4Ws/k57GtYFxISqxqY1nZQRZxgsgv/xVES9nF1ftRm8wBEkC+JqV57/mmp2GKtyOrgcdRjB1FbeZg6vEMPHwKJJJVJT5d8HC6NXOYDa6b+7Q1+BO8lq1ieGgnvidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161421; c=relaxed/simple;
	bh=WpLErwbIOnDQlI1CEKK7Shd+jxySTINo7VNwEfZYUTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EU6IvCTZIbUOTopcptcZdRrSTF/XxuBnu+ohGg9cLAazlufTUpkOLjLK1OkJ3lpVSga+/K+w97JCd3i/K8pmFlw9VXirnezDU60EfmY13uydGmxGa/9KZpdJsSATyNi/shFT8jz5QGd/++uAdM1lQgIUyRcYMPbrWvVQx6CB4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OvVm/KUd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=WpLErwbIOnDQlI1CEKK7Shd+jxySTINo7VNwEfZYUTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OvVm/KUdBQ0x9DOSKZVHBXxKhOc+HXE118h7CeI6hidvPR8y1oQOI/g3xPGN1ysG8
	 xlLk621Ay00dHE8oAeXrE7YXOq//GA4xCpE3AN4D/Fis+//RnZHqMzObh6d/Oct27Y
	 f4EugGqobQRZ9tqgjEp60XjH+Iw7a13q05oGG79I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:03 +0200
Subject: [PATCH 09/12] selftests/nolibc: add support for LLVM= parameter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-9-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1069;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WpLErwbIOnDQlI1CEKK7Shd+jxySTINo7VNwEfZYUTg=;
 b=oQvqhk1sOdBQW1kiH9NRhGOIAHT6fFXMl2hUhZbjSEH4LYFZz9V3Osk6YijFwP9XbKCsJRpmg
 ZQukNU2xlK9BNYw3uAJEFRzj04M/SKCkezapyrvvI9sE9oijHanKQ3/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Makefile.include can modify CC and CFLAGS for usage with clang.
Make use of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8000bc3c408b..cdff317c35f2 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -155,6 +155,9 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wex
 		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
+# Modify CFLAGS based on LLVM=
+include $(srctree)/tools/scripts/Makefile.include
+
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
 		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \

-- 
2.45.2


