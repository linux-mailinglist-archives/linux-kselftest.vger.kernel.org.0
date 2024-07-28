Return-Path: <linux-kselftest+bounces-14334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6136E93E46A
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9215BB21448
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCCF40861;
	Sun, 28 Jul 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WfvFwjDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A23716D;
	Sun, 28 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161420; cv=none; b=EuB0XddgjTl+xP2gvOHxqlDBF+ptBNLe9hPnxuNroW44YKwHcNt+teqH0U4P+s238wNVWY23Idjfp/tdTd6UXjuWcMQMoUfAxPSyZvxwN5JisuSqDg8JruMnVM24dff3vkY9q4C8m3ewhBSwkuAR4sFMXNytr5hI8V+HVVNw6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161420; c=relaxed/simple;
	bh=h/BgI+G7ScwU6DQ48y7tlStVhparWhO6ZDGIMqrbJic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEVGj6o31X3MyWxXLnl7jgobF0nAKiGLIMNS0j6n+asa6yXoqDgnEUk36JKZwnsj2WAlbceCkCJ8DOlXBcO1nhUdKat+df9c3tcSYV6raMPKeMVgvzGLGVsHAIeS470rJJm8P2uiFO4w92GrSUlXISuKN8uA+sUhvZ607Mq8tTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WfvFwjDC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=h/BgI+G7ScwU6DQ48y7tlStVhparWhO6ZDGIMqrbJic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WfvFwjDCuOFT6qPBwBI5QDXv9OU5+xvjnTUdlY1PZ1D0IzNptdnSEwHd4lZjddMwK
	 teliQDJpVdXXcYxoCGL/C9+IMr+bfmcB78amTjGsiiMO2b3lrq/l/UvF2gdQcUJEYd
	 gzlOM9HFL7OQNTSv5CqTAz/I2NjRK3nCCTWZ7LnM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:02 +0200
Subject: [PATCH 08/12] selftests/nolibc: setup objtree without
 Makefile.include
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-8-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1710;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=h/BgI+G7ScwU6DQ48y7tlStVhparWhO6ZDGIMqrbJic=;
 b=QlImsRN3Q2Vy+tVFvto+/SCpb8gpujf9wlvl0kTfCkhm38xgV8n+7uhBkwSonY8KiJOE0si5M
 z4BYQLdgjGOB4oWIfOCQftp6qY/o4SNy/iDV142DxxHeG0zoPrUkYOs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Makefile.include has multiple uses. In addition to the setup of various
variables based on "O=", for which it is used currently, it can also set
up variables based on "LLVM=".
Unfortunately using it for both at the same time would require a big
ugly reshuffling of the nolibc Makefile.
As we want to use its llvm handling in the future, reimplement its
objtree := $(O).

While at it, also move "$(objtree) ?= $(srctree)" for consistency.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 803a4e1bbe24..8000bc3c408b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -5,7 +5,6 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
-include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/utilities.mak
 # We need this for the "cc-option" macro.
 include $(srctree)/tools/build/Build.include
@@ -14,6 +13,9 @@ ifneq ($(O),)
 ifneq ($(call is-absolute,$(O)),y)
 $(error Only absolute O= parameters are supported)
 endif
+objtree := $(O)
+else
+objtree ?= $(srctree)
 endif
 
 ifeq ($(ARCH),)
@@ -21,8 +23,6 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
-objtree ?= $(srctree)
-
 # XARCH extends the kernel's ARCH with a few variants of the same
 # architecture that only differ by the configuration, the toolchain
 # and the Qemu program used. It is copied as-is into ARCH except for

-- 
2.45.2


