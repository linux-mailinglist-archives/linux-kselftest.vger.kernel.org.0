Return-Path: <linux-kselftest+bounces-14986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ABD94B265
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2357284BC0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F4158D63;
	Wed,  7 Aug 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DbFbC10z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FD15535B;
	Wed,  7 Aug 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067525; cv=none; b=s3/BbHanLE0x2nlvg6E7TP1f2yT7t3LplvosRxwYlF1tKOYS00l7CgS+a/3+6JI1PpwMXlq22z6Z5On4xRRcHyZpnhchmFOje+javNSTgDHh164PATg5DvayhTTCf6hkz4F5bplLjnoSUqn43TEUehvb2TZd5Wp+S23tsublKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067525; c=relaxed/simple;
	bh=4W7HZDJOblZEcLHcrQM9iEEvp6UnFoiUYk+r8TvueIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZvicdwd21WWWUDtjWds7ujmIelmdaWReL5Ql+QGy+kByMwghl5pBCDVJyazzWiDvc8QUEo1KhrmOEIFMBUFsuKt25oF0d/5fqkdrVVO3rk8e2JYS9aOdEhYW9c5T+u0Yyck6FtUznZ7e+agmtnlczRyPfs90uhUJHiHaoEj3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DbFbC10z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=4W7HZDJOblZEcLHcrQM9iEEvp6UnFoiUYk+r8TvueIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DbFbC10zFm2X+xFl7Q9Uh5H3YxH9Pjv3JWTZYZWg4qvNuJYqBGOJOk2LGUEyFdxMP
	 GRljcMNfCZAm0SCXkMz8r16gK1CMsUj+ypmMZSnTdBfNaMcPLpTLxqGw9NKsA97MqP
	 fVddThwjstXUf2d43sjWurg0Q1x/XElMQkmbTnC8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:45 +0200
Subject: [PATCH v2 09/15] selftests/nolibc: determine $(srctree) first
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-9-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1795;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4W7HZDJOblZEcLHcrQM9iEEvp6UnFoiUYk+r8TvueIM=;
 b=jj2bplu2tkULkYur4/kcZD60eor02SnqztYgKFNXT1eUQerKP5wdcqItJiQWADhlDfVOr4oqH
 gQHcOC42JMQAmI3QnBscOc3gzNvNXq9Aulo6Gr6vF61owPi9Z45gJKP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The nolibc-test Makefile includes various other Makefiles from the tree.
At first these are included with relative paths like
"../../../build/Build.include" but as soon as $(srctree) is set up,
the inclusions use that instead to build full paths.

To keep the style of inclusions consistent, perform the setup
$(srctree) as early as possible and use it for all inclusions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.46.0


