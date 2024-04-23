Return-Path: <linux-kselftest+bounces-8708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DD8AE906
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047791C21DE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0C13792C;
	Tue, 23 Apr 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MmvNR2v7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A66137903;
	Tue, 23 Apr 2024 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881059; cv=none; b=BeN5ulydRY0h6MkJ+aMxX30I18Nq3vfPQYaY9vD674/Ayxb4yPnuRHsMc5Yk8hCgzxQRav6DZdVci0V40mEMe8lLrkMfvmXMKujsllVXPDC9rCzHb2CSvxYu6oa6eGaOAldpQtCOjPdXj5ADVKq0D62aUm5i1ltj3H9eQ0gdCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881059; c=relaxed/simple;
	bh=saLWC8UDzTsxgZN81v2ZZ/H9uAMBrrcZVtJooX0ATGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jN6hvLR01q/PVsMOcHpq4GP9fBEaknfG4c4upnMEA47ClY03LNz4KsSJ3dU88kaggOxd8OOex8+0L5aV26eXvizkd+cjKQ8iJnInsVPFOLk06Y2uiQQQyjIOzvondqJDgZPO3Sj+DZC6BwG9Vn9LiP4nWuGrz3IdD2z4Tbcu3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MmvNR2v7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713881052;
	bh=saLWC8UDzTsxgZN81v2ZZ/H9uAMBrrcZVtJooX0ATGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MmvNR2v7ixBjEg8YyiM9SFQDuOrsUc2mc+YUwTc21A3Z/ISE/7/ja6XbwCzo07upR
	 kxfU5YqyIK7c4LYq8+rqcHZTQhMF12zHeGhznqAh3kl1mA4D1+MRJkAeoMs27B6iWG
	 AUAINiB1pGzYsMsqmqB2E0jmC87JVO12Gzfe5uYfk5XoD3oZTRaZ7KDV6FXhZISATA
	 vsYPJgnu474dL7oRjYnES6Rz18sRD3bxEL27uWLzByBUAVRWyxu93+DG0PsfUfAW6k
	 kd1/HqECrHnaF4M17xrvUj9Z8GletWLUk/XunWaXKms3vBTfon9xhK3Hk9apjhCvJG
	 QTUlWDGcYnuig==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A92073782139;
	Tue, 23 Apr 2024 14:04:11 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 23 Apr 2024 10:03:40 -0400
Subject: [PATCH 1/3] kselftest: devices: Move discoverable devices test to
 subdirectory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-dev-err-log-selftest-v1-1-690c1741d68b@collabora.com>
References: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
In-Reply-To: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Move the discoverable devices test to a subdirectory to allow other
related tests to be added to the devices directory.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/Makefile                                        | 2 +-
 tools/testing/selftests/devices/{ => probe}/Makefile                    | 2 +-
 .../selftests/devices/{ => probe}/boards/Dell Inc.,XPS 13 9300.yaml     | 0
 tools/testing/selftests/devices/{ => probe}/boards/google,spherion.yaml | 0
 tools/testing/selftests/devices/{ => probe}/ksft.py                     | 0
 .../testing/selftests/devices/{ => probe}/test_discoverable_devices.py  | 0
 6 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c785b6256a45..55815470e94c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,7 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
-TARGETS += devices
+TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
diff --git a/tools/testing/selftests/devices/Makefile b/tools/testing/selftests/devices/probe/Makefile
similarity index 77%
rename from tools/testing/selftests/devices/Makefile
rename to tools/testing/selftests/devices/probe/Makefile
index ca29249b30c3..7a6eaa031cfe 100644
--- a/tools/testing/selftests/devices/Makefile
+++ b/tools/testing/selftests/devices/probe/Makefile
@@ -1,4 +1,4 @@
 TEST_PROGS := test_discoverable_devices.py
 TEST_FILES := boards ksft.py
 
-include ../lib.mk
+include ../../lib.mk
diff --git a/tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml b/tools/testing/selftests/devices/probe/boards/Dell Inc.,XPS 13 9300.yaml
similarity index 100%
rename from tools/testing/selftests/devices/boards/Dell Inc.,XPS 13 9300.yaml
rename to tools/testing/selftests/devices/probe/boards/Dell Inc.,XPS 13 9300.yaml
diff --git a/tools/testing/selftests/devices/boards/google,spherion.yaml b/tools/testing/selftests/devices/probe/boards/google,spherion.yaml
similarity index 100%
rename from tools/testing/selftests/devices/boards/google,spherion.yaml
rename to tools/testing/selftests/devices/probe/boards/google,spherion.yaml
diff --git a/tools/testing/selftests/devices/ksft.py b/tools/testing/selftests/devices/probe/ksft.py
similarity index 100%
rename from tools/testing/selftests/devices/ksft.py
rename to tools/testing/selftests/devices/probe/ksft.py
diff --git a/tools/testing/selftests/devices/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
similarity index 100%
rename from tools/testing/selftests/devices/test_discoverable_devices.py
rename to tools/testing/selftests/devices/probe/test_discoverable_devices.py

-- 
2.44.0


