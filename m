Return-Path: <linux-kselftest+bounces-11093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1D8D75B6
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DF71F22868
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005C3CF6A;
	Sun,  2 Jun 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rSjuDaiE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F84084E;
	Sun,  2 Jun 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334815; cv=none; b=C/h6kfgsKR3mgTs+0/Hi+XyHPAqTLc40va88Awa5acOuTDfWcKUUlHe9LDEoy3ZCFDTfZYTAZ/fBTb8XKdF2pBLDVHbZdQbslHsEAAp6/ijSrul1mLS/5XoI3E8fi66plO+qPGwbGhVWWCqtH3pm1VxhGZXGQPg287PTJughb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334815; c=relaxed/simple;
	bh=xqCuHdkNJJZ+XxhEQFOwzwjBF076dyDkCFfFETjSEyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idyB12hLlTn6NG+PzV/6GEGa9f2xQyu/EDZFTpSmht5XAdmyycLcJTIuuQSyTRMKX3r+zGjgp6qyl0PGzP/Uw/fOPUETkvNtTvWbq8YoNlJ5yuL1UKWGbDglLYuN0AkTtLaEsiUdGt74u4BpV86GDe3YhrEGU9SYRpStr0204v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rSjuDaiE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717334812;
	bh=xqCuHdkNJJZ+XxhEQFOwzwjBF076dyDkCFfFETjSEyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSjuDaiEAPCXLgGNdb0WuwJilAZdssYHLFhpWaDrAEGsjNsxsp77osVvBUAWPh2rq
	 UJalw9wrvJhk/K721fSPyDGXMQcAX/UPgQSdJCcHUtQL5rmaoIo2R0WFbsYWTB4nrR
	 XzrBTFEvulpOeKPkTQdt4I7ZdIkwU78LkP95DHBStQ5GR+0ZS/9biATgEvfKW2QMns
	 CpcagRFkftL1ku/0TdVrhZT4TTJq2xVaNeYLy5hrAKhqLeEfLUYlldwYEN+DYd65xr
	 4v9hueaTWaE5eEStnCUMm4KnWLu3UgTS96URq1nz9+OA03vsy8I8yaTozKnZ19AOQS
	 fLIthTxEMQUGw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 657E6378213B;
	Sun,  2 Jun 2024 13:26:26 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: arm64: tags: remove the result script
Date: Sun,  2 Jun 2024 18:25:00 +0500
Message-Id: <20240602132502.4186771-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240602132502.4186771-1-usama.anjum@collabora.com>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The run_tags_test.sh script is used to run tags_test and print out if
the test succeeded or failed. As tags_test has been TAP conformed, this
script is unneeded and hence can be removed.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
make run_tests TARGETS="arm64/tags"

Before:
➜  selftests make run_tests TARGETS="arm64/tags"
  TAP version 13
  1..2
  # timeout set to 45
  # selftests: arm64/tags: tags_test
  # TAP version 13
  # 1..1
  # ok 1 Syscall successful
  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
  ok 1 selftests: arm64/tags: tags_test
  # timeout set to 45
  # selftests: arm64/tags: run_tags_test.sh
  # --------------------
  # running tags test
  # --------------------
  # TAP version 13
  # 1..1
  # ok 1 Syscall successful
  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
  # [PASS]
  ok 2 selftests: arm64/tags: run_tags_test.sh

After:
  ➜  selftests make run_tests TARGETS="arm64/tags"
  TAP version 13
  1..1
  # timeout set to 45
  # selftests: arm64/tags: tags_test
  # TAP version 13
  # 1..1
  # ok 1 Syscall successful
  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
  ok 1 selftests: arm64/tags: tags_test
  make[1]: Leaving directory '/home/ubuntu/repos/kernel/linux_mainline/tools/testing/selftests/arm64/tags'
---
 tools/testing/selftests/arm64/tags/Makefile         |  1 -
 tools/testing/selftests/arm64/tags/run_tags_test.sh | 12 ------------
 2 files changed, 13 deletions(-)
 delete mode 100755 tools/testing/selftests/arm64/tags/run_tags_test.sh

diff --git a/tools/testing/selftests/arm64/tags/Makefile b/tools/testing/selftests/arm64/tags/Makefile
index 6d29cfde43a21..0a77f35295fb6 100644
--- a/tools/testing/selftests/arm64/tags/Makefile
+++ b/tools/testing/selftests/arm64/tags/Makefile
@@ -2,6 +2,5 @@
 
 CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := tags_test
-TEST_PROGS := run_tags_test.sh
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/tags/run_tags_test.sh b/tools/testing/selftests/arm64/tags/run_tags_test.sh
deleted file mode 100755
index 745f113799303..0000000000000
--- a/tools/testing/selftests/arm64/tags/run_tags_test.sh
+++ /dev/null
@@ -1,12 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "--------------------"
-echo "running tags test"
-echo "--------------------"
-./tags_test
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-else
-	echo "[PASS]"
-fi
-- 
2.39.2


