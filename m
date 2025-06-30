Return-Path: <linux-kselftest+bounces-36088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D30AED614
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 09:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89F616C66F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721E235056;
	Mon, 30 Jun 2025 07:48:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E41E7C10;
	Mon, 30 Jun 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269689; cv=none; b=M1OkDShAmvfRVanuXjNums8ZHd+KNRxq8Gae7AOnjwB06KD9nEKzXCl7UppY0FI8lXmxW4b1w2mMys8QXsatboexs25N9Ni2Gavf2inF3KK+LYiMbfkYJdVwsxALRuNYpGbt2jTzGwgMxK+2Y7gcHKAI2E6GsoU1KIoyQodkxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269689; c=relaxed/simple;
	bh=Ncl3helxO+ZS9QeFzkQwEfUkOIHQAykAjG5n7efWSDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViCk9UWgHdjkHZFhDYje4igju5A8OyDE80uuXwpnEtX90cmOMzLudj3VB8L/NJX0UNSTCJk+8z5n5ny/l7o+wW0vGqtBJburPYixBame7uriKHlStdm11tTvrenn1QrwPrk6reMyIOtjQfHYfJUOBGsfwJE1Ts/Ry0fijaz1jwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B32C4CEE3;
	Mon, 30 Jun 2025 07:48:06 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kernel@vger.kernel.org
Cc: linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] rtc: Rename lib_test to rtc_lib_test
Date: Mon, 30 Jun 2025 09:47:54 +0200
Message-ID: <df1a73d4a14426ae0d3e8809aed40c686b67dd3e.1751268290.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling the RTC library functions test as a module, the module
has the non-descriptive name "lib_test.ko".  Fix this by adding the
subsystem's name as a prefix.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/rtc/Makefile                       | 2 +-
 drivers/rtc/{lib_test.c => rtc_lib_test.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/rtc/{lib_test.c => rtc_lib_test.c} (100%)

diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 4619aa2ac4697591..aa08d1c8a32ec23d 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -15,7 +15,7 @@ rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
 rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
 rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= sysfs.o
 
-obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= lib_test.o
+obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= rtc_lib_test.o
 
 # Keep the list ordered.
 
diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/rtc_lib_test.c
similarity index 100%
rename from drivers/rtc/lib_test.c
rename to drivers/rtc/rtc_lib_test.c
-- 
2.43.0


