Return-Path: <linux-kselftest+bounces-14270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C493D1B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7657228448B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B917A5A8;
	Fri, 26 Jul 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="32x/hB9c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C217A5A3;
	Fri, 26 Jul 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992062; cv=none; b=gct4gtsX61BUzopUevMU9gFa0PqRRx9QuQ2fa/Q/qn/GK00lyvUq09d8hDG9ua5kpFtLbBG1sFh7k6LLkQc/oaDgMfPsYk+jhr8oAf+wyx6F2hFXEWNic/2IRVhdG5d5WL5sRz2K8dzHaXSLEZTdFYx0GNSjxfEWjq7INLndjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992062; c=relaxed/simple;
	bh=uMgsqZ1f9h0sRaq2TSzfX4gpb1CnCYYdd+RDbwevyKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7oEqpdjupTOYnT0r73bn+hAaevqz3XcCx59uV15SoCJlteEDEccK1o9ft/HiJIKEWrhgiWCQmLTleGwqLDPdGKXgoPGZ+JI/FwM0Kyw2PuTbUqQIuhrm4oQJMfYAftxW5fhJQyrHU6k3g1Eub0CBy3GNb/PrmlOgdQCrNkzTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=32x/hB9c; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721992059;
	bh=uMgsqZ1f9h0sRaq2TSzfX4gpb1CnCYYdd+RDbwevyKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=32x/hB9cR4RrwLzjG6REuhX7KLC6NOYZCSlu9YunFQWZF4PB1t8Feolf5qc9xiGpZ
	 5alH0uCoqM7aELcByb9o1MozVqazXqolX+W3cF0WjWmxtskLD1P9NWzMqGvsNZJCy7
	 BqdJotuiDBrWLbfi9Icgi2KJ9V1Yr424P17CB/hH76QkftmUvYSJ3C5Ifyp7Q188mX
	 X1anGN2GoxsiW8GwtjF0ZuK4kS77JIQrFRio3fC/++JGwm6uasbEz+ayS0wiHWaEyG
	 jGoeKwZW+3ClVA8mQWS1BF65TynA9VAEeqSjCy0swl5r74MD2wyO+GmDCKvPI3Ra+p
	 NVUnoqF7h4Qow==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC5DB37821C0;
	Fri, 26 Jul 2024 11:07:34 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kees@kernel.org,
	David Gow <davidgow@google.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com
Subject: [PATCH 3/3] selftests: lib: remove test_bitmap
Date: Fri, 26 Jul 2024 16:06:58 +0500
Message-Id: <20240726110658.2281070-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240726110658.2281070-1-usama.anjum@collabora.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the test_bitmap as it has been converted to kunit test.

Cc: kees@kernel.org
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lib/Makefile  | 2 +-
 tools/testing/selftests/lib/bitmap.sh | 3 ---
 tools/testing/selftests/lib/config    | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)
 delete mode 100755 tools/testing/selftests/lib/bitmap.sh

diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index ee71fc99d5b51..386c5887c0d65 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,6 +4,6 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh strscpy.sh
+TEST_PROGS := printf.sh prime_numbers.sh scanf.sh strscpy.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
deleted file mode 100755
index 00a416fbc0ef0..0000000000000
--- a/tools/testing/selftests/lib/bitmap.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-$(dirname $0)/../kselftest/module.sh "bitmap" test_bitmap
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 645839b50b0a2..7d3b1de29d3d6 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,6 +1,5 @@
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
-CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
-- 
2.39.2


