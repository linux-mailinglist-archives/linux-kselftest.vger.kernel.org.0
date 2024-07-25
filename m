Return-Path: <linux-kselftest+bounces-14229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916193C178
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 14:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6071C21515
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814F1993BE;
	Thu, 25 Jul 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zKRgaHVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5A199246;
	Thu, 25 Jul 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909550; cv=none; b=j2d42L3ar3yAnu03mOCM20GNNdlhlJr0ZgAgqYmtqRKPxt1ZF1ByZ6noiIHvpd4cbgEL2+Z6VhXJNEvDMiPku2BloerslNHFjs+V7Bh1tIJUx43WdvQnuzo+LP9GGIZ5plqtNd41meGkmdAaWkYKjptg0e75qYbGTz79TL2ym8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909550; c=relaxed/simple;
	bh=FEvbuVqbHKAEmFDKdL+n0b6biOIqhG7sfs3SXVHxcn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyeU1b9BPe6X+xizBpQ29sQZJDMo3yNdE93Y61dSuB2s2XTi8e0uMFIVLeHkFrlAtMjkY+CycP9pDrjpKGVJbV7oMTstNY0o4ma0M++oaaQixKqHHC0Y6IrzdxMA+cZIOHiwTYDouEpbpyQScOgeEo9OeYPoh1fcMR1qhYbkt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zKRgaHVM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721909546;
	bh=FEvbuVqbHKAEmFDKdL+n0b6biOIqhG7sfs3SXVHxcn8=;
	h=From:To:Cc:Subject:Date:From;
	b=zKRgaHVM8L6S/dQipEH4Ob2byrZwTqDJpKpY3Mn6VE5snuwc6/PnBAs8isbdBfkR8
	 KfnMNQqtkpCIo0ga4ydqpp9Se7M+uARSJ6R+2QJWvUsSUduBnX/rID2UOoz7CM+nl2
	 jomA4A8DmyO+VKGVyb6+FBfOyx0eY3M4Msys18QqjF8vilvqc716Cw29BnWq7xqiyH
	 FjFp7M3h59T+Fjjg8Y5uORr6Annj5kkk67bgNDGDJku+jtnkCQHSZqSkcHze57/yIW
	 jraKcfoHtrqLBB0YHWx5NdykGeNgMxOo2vzZItInU84aIMjg9ooX3BFcYodZlCKCaO
	 Hyo1TiluGBVOA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5E42137804C9;
	Thu, 25 Jul 2024 12:12:25 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests: lib: remove strscpy test
Date: Thu, 25 Jul 2024 17:11:39 +0500
Message-Id: <20240725121212.808206-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strscpy test loads test_strscpy module for testing. But test_strscpy
was converted to Kunit (see fixes). Hence remove strscpy.

Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Remove from Makefile and config file as well
---
 tools/testing/selftests/lib/Makefile   | 3 +--
 tools/testing/selftests/lib/config     | 1 -
 tools/testing/selftests/lib/strscpy.sh | 3 ---
 3 files changed, 1 insertion(+), 6 deletions(-)
 delete mode 100755 tools/testing/selftests/lib/strscpy.sh

diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index ee71fc99d5b51..c52fe3ad8e986 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,6 +4,5 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh strscpy.sh
-
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 645839b50b0a2..dc15aba8d0a3d 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -2,5 +2,4 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
-CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
diff --git a/tools/testing/selftests/lib/strscpy.sh b/tools/testing/selftests/lib/strscpy.sh
deleted file mode 100755
index be60ef6e1a7fb..0000000000000
--- a/tools/testing/selftests/lib/strscpy.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
-$(dirname $0)/../kselftest/module.sh "strscpy*" test_strscpy
-- 
2.39.2


