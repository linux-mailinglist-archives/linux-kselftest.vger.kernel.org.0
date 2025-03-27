Return-Path: <linux-kselftest+bounces-29869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95FA735EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666AA17921D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB58155312;
	Thu, 27 Mar 2025 15:48:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFF14900F
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090501; cv=none; b=N1EiSAawYeuXrjFmhw7av8nwqeKfyybz8y7Q6bW49jc9BUVBefQ2ntDKBRRVSQqV9rSZtBkKf0ThCxPWhBJ8Y4QkxKgXqHkS9f57kumiyYInxFquYBEaQybyzUws5KZiCouJZuYKYjOTm3VhMo0g+o40S6n99kbnWO6aGhRsrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090501; c=relaxed/simple;
	bh=9MJdlM3coeZFkA6pFM6DJcyW5HfVOzFSWssH9fzHpeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDcNCd76xh13oWc+2BcBsjuHv/kdcflIrhLTAtvKvmiCdMD4quA18bMq5Kqqs4jJZ0eZytU3druVxztcogxT70Il9zardCSxYojd6CbccCJmp1OrghzbxoEhb8DdJIFwPni3L/awYT/exLCugK7TwiVp6jRu+QJ6XLxjEEGiV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4ZNnx239N5z4xMJ6
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 16:43:02 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b1ef:107c:7814:6642])
	by laurent.telenet-ops.be with cmsmtp
	id Vriv2E0065Szt1p01rivvs; Thu, 27 Mar 2025 16:42:55 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txpNe-0000000Fsi7-24Kr;
	Thu, 27 Mar 2025 16:42:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txpNe-00000006DNN-4Ayq;
	Thu, 27 Mar 2025 16:42:55 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] rtc: Rename lib_test to rtc_lib_test
Date: Thu, 27 Mar 2025 16:42:53 +0100
Message-ID: <8edd0c09fe12d1225e2b830f8a55e7c830da078b.1743090053.git.geert@linux-m68k.org>
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
index 489b4ab07068c758..c0ccbbfe2739c1aa 100644
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


