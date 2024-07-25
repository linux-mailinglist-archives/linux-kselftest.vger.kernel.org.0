Return-Path: <linux-kselftest+bounces-14226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16E93C095
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B721F1F2206B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A81991B1;
	Thu, 25 Jul 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ufsvA23n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7213C907;
	Thu, 25 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905727; cv=none; b=F7GvinJjqQxYFcC9xf0l5ALZf2pkKMr9baE2/hCMJX6+TjJoE7gRvEPjrI+ZGnbT6es/e3l3CSpoL5OAhAbbC65XxF6P3npTAlQV0FYc7R93j5wTUd32GF3ndLUn3+Wy8hGcVI73QrVyFRHtZ1o31TXD4s+iIDM3frpqxe9wPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905727; c=relaxed/simple;
	bh=RKcCpU42n0Y6Bgxy69mbl5JfvuR02h2bEfJh+w0xUlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WWI7wmJjRZrQ63gwpo/fHvKvtcYf5h7s1WgALnpBt6UTpgQrMLApt0DoMXx+rH6WIHIoij5hQvBa/vv/DaRgESVi2fYJiWe3T6k8ROPH/DDzJt10TVtyr9APNkA1P64lkvoT1tI69/etw7C0QJhhrphMRGhLMDWDMnAF7jwfx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ufsvA23n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721905724;
	bh=RKcCpU42n0Y6Bgxy69mbl5JfvuR02h2bEfJh+w0xUlU=;
	h=From:To:Cc:Subject:Date:From;
	b=ufsvA23n+iU9k50GS2kFqZILTqWxv4fi4h+qr+gj7F1yLGdrEVKmEeD/J9BdsPJdS
	 IZ9fTVdV75yT/873LsQU6R6MKTZcDXTXGypO6+rhS/AfCv1BLfb4a08oKZGE7frjHz
	 h5gIwsOyrfITCFHGW2zeYbOZPtVvUKeOHSZSpog8w9BxfquB/5rVpi0qUEd2MJC4n5
	 L7PC2T5XADOGP7n3yEWyuVWLy5jK2MEkouZFBqkmBw6LH/Hi3F53EIGUkKvfiHM1Bu
	 xAcd8D2/OXFc/JmUPXmcqw+t1kBEddbEfEL4yYJAKKg4mVZzUGrMTsSo5GcahNFpR2
	 zcCjfODEbdsag==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7E79937803EE;
	Thu, 25 Jul 2024 11:08:40 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>,
	Vitor Massaru Iha <vitor@massaru.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: user: remove user suite
Date: Thu, 25 Jul 2024 16:08:03 +0500
Message-Id: <20240725110817.659099-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user test suite has only one test, test_user_copy which loads
test_user_copy module for testing. But test_user_copy module has already
been converted to kunit (see fixes). Hence remove the entire suite.

Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/Makefile               |  1 -
 tools/testing/selftests/user/Makefile          |  9 ---------
 tools/testing/selftests/user/config            |  1 -
 tools/testing/selftests/user/test_user_copy.sh | 18 ------------------
 4 files changed, 29 deletions(-)
 delete mode 100644 tools/testing/selftests/user/Makefile
 delete mode 100644 tools/testing/selftests/user/config
 delete mode 100755 tools/testing/selftests/user/test_user_copy.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc8fe9e8f7f20..af2429431b6b2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -107,7 +107,6 @@ TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += tty
 TARGETS += uevent
-TARGETS += user
 TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
diff --git a/tools/testing/selftests/user/Makefile b/tools/testing/selftests/user/Makefile
deleted file mode 100644
index 640a40f9b72bc..0000000000000
--- a/tools/testing/selftests/user/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Makefile for user memory selftests
-
-# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
-all:
-
-TEST_PROGS := test_user_copy.sh
-
-include ../lib.mk
diff --git a/tools/testing/selftests/user/config b/tools/testing/selftests/user/config
deleted file mode 100644
index 784ed8416324d..0000000000000
--- a/tools/testing/selftests/user/config
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_TEST_USER_COPY=m
diff --git a/tools/testing/selftests/user/test_user_copy.sh b/tools/testing/selftests/user/test_user_copy.sh
deleted file mode 100755
index f9b31a57439b7..0000000000000
--- a/tools/testing/selftests/user/test_user_copy.sh
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Runs copy_to/from_user infrastructure using test_user_copy kernel module
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if ! /sbin/modprobe -q -n test_user_copy; then
-	echo "user: module test_user_copy is not found [SKIP]"
-	exit $ksft_skip
-fi
-if /sbin/modprobe -q test_user_copy; then
-	/sbin/modprobe -q -r test_user_copy
-	echo "user_copy: ok"
-else
-	echo "user_copy: [FAIL]"
-	exit 1
-fi
-- 
2.39.2


