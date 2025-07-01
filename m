Return-Path: <linux-kselftest+bounces-36148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FEAEEFF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 09:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA3D3A78D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 07:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7E25F96B;
	Tue,  1 Jul 2025 07:44:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB11F0E29;
	Tue,  1 Jul 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355884; cv=none; b=MlFG3hRCjGNqHRVtNRGP9KmBG9Om56CrK6wAhd4gj4bsDYmxmQmMSI500Hz5cT5Hs7vMxZj9VgE7r6esCQ4GNodzeXGjzJhJauZ+3X2iPIfdWYteitPNjdLoJc4dqqjceyvgnnRDi2Cp2ykgZYQO2IjRuxsdQZHgl7eYx2rhoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355884; c=relaxed/simple;
	bh=GUxWlxzOAhyjkDsOo/s8z7wkHiw7mVkFJGKEY91uj/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAFpkLfKtizagd18N54PtoTnLYbB/zlzWkknZmJ0VVJ6k1ndPEYxMm3n0D8OJwQ1Rt5Fe6gqbARaKdr3hPG4JqpBupJmitoIIKQsU8qaUmCBPZ8uQiLj77wfrVedJ/Ubc0sh/XaGvCZcnKG5NiaIUa+fBGtznuMqG30h5DXiwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47688C4CEEB;
	Tue,  1 Jul 2025 07:44:42 +0000 (UTC)
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
Subject: [PATCH v2] rtc: Rename lib_test to test_rtc_lib
Date: Tue,  1 Jul 2025 09:44:39 +0200
Message-ID: <47019d7f8ced12107b54a372fdf34b1b8f7b6183.1751355848.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling the RTC library functions test as a module, the module
has the non-descriptive name "lib_test.ko".  Fix this by renaming it to
"test_rtc_lib.ko".

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - s/rtc_lib_test/test_rtc_lib/.
---
 drivers/rtc/Makefile                       | 2 +-
 drivers/rtc/{lib_test.c => test_rtc_lib.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/rtc/{lib_test.c => test_rtc_lib.c} (100%)

diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 4619aa2ac4697591..789bddfea99d8fcd 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -15,7 +15,7 @@ rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
 rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
 rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= sysfs.o
 
-obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= lib_test.o
+obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= test_rtc_lib.o
 
 # Keep the list ordered.
 
diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/test_rtc_lib.c
similarity index 100%
rename from drivers/rtc/lib_test.c
rename to drivers/rtc/test_rtc_lib.c
-- 
2.43.0


