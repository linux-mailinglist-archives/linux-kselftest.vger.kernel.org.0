Return-Path: <linux-kselftest+bounces-14991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5494B26D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C081C21480
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6315A873;
	Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Obe1Hv2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3A15625A;
	Wed,  7 Aug 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067526; cv=none; b=crB2R/P9PyjotWxDuMyO38q8+yLhmf//kjeTAmAiEuiSQjJ2J1tT2CASohE+ceNBPg93vbMNX8jm8WbeSz0ER3jALAzyK/YSU17B5yLwrn/tMo+GxAO1UO7Kj8ygDShJbG6NIhurBkjpbSdomQxSnuz6AivKIuRupoc2jHN4I8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067526; c=relaxed/simple;
	bh=mzJqvggvf/O3hGt8YR0AaA0XozV76zGpeEuCI2JjtjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rlj834eqhdvuPW7SfwCURiKzyOhgOagGZyszs2kYnV4DOtV7ElcejN59bqipcBDJCzJD4gtphmN3JhlX3qJCsWYR8ig2tEIDVfDme9FimAvgzhqMlc56KUTVQC0NSH1wfAjyDUN+1PHCVRS3gfXfuGV08+63xf8y2ZxeaoTRBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Obe1Hv2A; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=mzJqvggvf/O3hGt8YR0AaA0XozV76zGpeEuCI2JjtjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Obe1Hv2Ai+nk+pEozj3wMuc6lcmV5n+cym9W2xXFJJd8tMCxuz0vt4jaZ6fFBv8xj
	 d8qni8LpyUbgMs/8D/3BWiuANc/nnmNF+nRUfh/40LPQRFAG6HEb8OFDmd3rqhzMU8
	 UiStyxIiMLd0Np9YpjZJCUZ63f63+yzqcT/DOJug=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:47 +0200
Subject: [PATCH v2 11/15] selftests/nolibc: add cc-option compatible with
 clang cross builds
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-11-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1451;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mzJqvggvf/O3hGt8YR0AaA0XozV76zGpeEuCI2JjtjI=;
 b=6mt2mDEcgMwvjyijTyBBuyriPgXEhcN+zP/t4jRZYDfwWBdq2fs+xW0A4e9T8oSM9AyomEG6h
 ntdp3d4N7UPAMEfhMTQ3vCHVryVKEFHcJb/3eaRi6d3Q5rB+f2geH+e
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The cc-option macro from Build.include is not compatible with clang
cross builds, as it does not respect the "--target" and similar flags,
set up by Mekfile.include.

Provide a custom variant which works correctly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index cdff317c35f2..b8577086e008 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -6,8 +6,8 @@ srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
 include $(srctree)/tools/scripts/utilities.mak
-# We need this for the "cc-option" macro.
-include $(srctree)/tools/build/Build.include
+# We need this for the "__cc-option" macro.
+include $(srctree)/scripts/Makefile.compiler
 
 ifneq ($(O),)
 ifneq ($(call is-absolute,$(O)),y)
@@ -23,6 +23,8 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+cc-option = $(call __cc-option, $(CC),$(CLANG_CROSS_FLAGS),$(1),$(2))
+
 # XARCH extends the kernel's ARCH with a few variants of the same
 # architecture that only differ by the configuration, the toolchain
 # and the Qemu program used. It is copied as-is into ARCH except for

-- 
2.46.0


