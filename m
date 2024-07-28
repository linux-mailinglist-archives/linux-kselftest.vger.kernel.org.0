Return-Path: <linux-kselftest+bounces-14341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F493E478
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E428148B
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40A57CBC;
	Sun, 28 Jul 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eSYczxSC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E613A8E4;
	Sun, 28 Jul 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161422; cv=none; b=YsUIJrny6QucKi9+dq6ntapdtlk1VhgYeV6nAjdo9L1X6qLxFwvikhG8joT92iAe5VIcPskhvuN6xi5ssItKzlVyDQOf6SXQ5mHmZyhfyKYe2qtnRmXRejBljYrljtg/FywOjhUYZUI75cR7sokq2VXJnI1QY8eQajkbL3TpbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161422; c=relaxed/simple;
	bh=LYVnkfOk8azVIIqLsIbtUPX96L6ih96CBmHiy7nNCmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJsoKpJPpbV1aiU2V94EKRof1Z42wT7lLnsc9XrgTdH/JvR8uXM5BR5oJpwBOKpxl+r5J8quMKqSoo1ii3KiEO0o17dKaT67ewKM8Etg15qUPF/oBB3gkzmH2VZSFwF/26k3BHJwKB2N726Bl5ATgCtR6xW2cB8+2JmSfAy0Kos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eSYczxSC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=LYVnkfOk8azVIIqLsIbtUPX96L6ih96CBmHiy7nNCmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eSYczxSCPTWxLilzT+dTYHsV+ajVKubS7sI497PJRbTsxaAvoSCJM5X/bdg9oHde8
	 wOzWaEJWu9r22CCDRXEZ6+qgtzP/2Z3Ix8OPOHtOCmkhrZ8sgXocwsEXG0V6VROIEr
	 6xgZ55A4b+3Fp8LRdd30FBcREu9LlAqc2ysehg3g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:01 +0200
Subject: [PATCH 07/12] selftests/nolibc: determine $(srctree) first
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-7-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1396;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LYVnkfOk8azVIIqLsIbtUPX96L6ih96CBmHiy7nNCmk=;
 b=XZLm41/WkvS5dnszYTu3j0CUw80qSXYzJZpRjecEctA8YbXWvHery96LrmE6BMVjnyLwC+WSK
 E3TPY2NM/4YDZAsMG9lJ4Y46pI2gqjul2FsFrk3cCzl/1u8nqFYZyWu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Avoid needing relative includes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 46dfbb50fae5..803a4e1bbe24 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,9 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
-include ../../../scripts/Makefile.include
-include ../../../scripts/utilities.mak
+# we're in ".../tools/testing/selftests/nolibc"
+ifeq ($(srctree),)
+srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
+endif
+
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/utilities.mak
 # We need this for the "cc-option" macro.
-include ../../../build/Build.include
+include $(srctree)/tools/build/Build.include
 
 ifneq ($(O),)
 ifneq ($(call is-absolute,$(O)),y)
@@ -11,11 +16,6 @@ $(error Only absolute O= parameters are supported)
 endif
 endif
 
-# we're in ".../tools/testing/selftests/nolibc"
-ifeq ($(srctree),)
-srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
-endif
-
 ifeq ($(ARCH),)
 include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)

-- 
2.45.2


