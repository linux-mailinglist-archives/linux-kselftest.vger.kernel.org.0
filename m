Return-Path: <linux-kselftest+bounces-8709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146FC8AE909
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC11C21F05
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475B137903;
	Tue, 23 Apr 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y28hfahN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C965135414;
	Tue, 23 Apr 2024 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881063; cv=none; b=CWDkGHfGtXcuNY0nX5ufI1oyKHO65ovAP9w0VKDoVdw43EmOI/fmhhvbZk5j0u1DiN8uwAnu06e2uVclAobZM8osdtF/RvQeLgM/YnzyhDB4cpbJ9XMh1sYu3jmZnpzRQOUrcUJa2RVAtD7h1A0bbHzlUql6FLZ/Jqz7cQ7KFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881063; c=relaxed/simple;
	bh=IswkZXwK+n2nisieR/XDGMs/iTPnx3zTGK0EaBj5w/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+pTlnEBQ2nmxC6ZeB5Uja1VVWcnOJEt7F1Y1mogv2KOedVrTwMIqMAiRPdjPINFlrM9wLnyWoticbVrCYIEyxa5WW9mNEyIHZWp3hqsv7NNiAyrRmp8QNBNqbmWK8aCrHzP+vfPvVzMIUl8X7kDrP37wrkHVYIy7DBo2XMpmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y28hfahN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713881054;
	bh=IswkZXwK+n2nisieR/XDGMs/iTPnx3zTGK0EaBj5w/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y28hfahNHk7gUuWmoLezv/VlMQPjejBP8mzZnZAgRXfCPeo1IwpvW98fgVkzdqzgb
	 /wkIjkr0s7Zgw9FmxJJ7xvu3yCLoH3LwrG/tgerdlEZ6byrY04w6073nUaKP+5pL1g
	 QoHBOMVEQYf4oKMOrsQie04YM4TLmHPaGy3/6BNIFwRFc+yk1nRTvmc1MRvzP5Wr4J
	 Nva7WXCbmeu3petW/kFFlb64N14es8TNplebo4AGfoQLVDGi/1xbNj3g5JNOL+oFiE
	 njifgz64pqUWj0K7AgTEng98lW+ASx+ghokzzChp6QgWscUwHQyk5L6yUd0UZN2hHt
	 CSBQsxLMgM/8g==
Received: from [192.168.1.205] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 270B93782141;
	Tue, 23 Apr 2024 14:04:13 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 23 Apr 2024 10:03:41 -0400
Subject: [PATCH 2/3] kselftest: Move ksft helper module to common directory
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-dev-err-log-selftest-v1-2-690c1741d68b@collabora.com>
References: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
In-Reply-To: <20240423-dev-err-log-selftest-v1-0-690c1741d68b@collabora.com>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Move the ksft python module, which provides generic helpers for
kselftests, to a common directory so it can be more easily shared
between different tests.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/Makefile                                   | 1 +
 tools/testing/selftests/devices/probe/Makefile                     | 2 +-
 tools/testing/selftests/devices/probe/test_discoverable_devices.py | 7 ++++++-
 tools/testing/selftests/{devices/probe => kselftest}/ksft.py       | 0
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 55815470e94c..a07ef1f473b3 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -250,6 +250,7 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	install -m 744 kselftest/ktap_helpers.sh $(INSTALL_PATH)/kselftest/
+	install -m 744 kselftest/ksft.py $(INSTALL_PATH)/kselftest/
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
 	rm -f $(TEST_LIST)
 	@ret=1;	\
diff --git a/tools/testing/selftests/devices/probe/Makefile b/tools/testing/selftests/devices/probe/Makefile
index 7a6eaa031cfe..f630108c3fdf 100644
--- a/tools/testing/selftests/devices/probe/Makefile
+++ b/tools/testing/selftests/devices/probe/Makefile
@@ -1,4 +1,4 @@
 TEST_PROGS := test_discoverable_devices.py
-TEST_FILES := boards ksft.py
+TEST_FILES := boards
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
index fbae8deb593d..0a2f4902dbbf 100755
--- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
@@ -15,12 +15,17 @@
 #
 
 import glob
-import ksft
 import os
 import re
 import sys
 import yaml
 
+# Allow ksft module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../../kselftest/"))
+
+import ksft
+
 pci_controllers = []
 usb_controllers = []
 
diff --git a/tools/testing/selftests/devices/probe/ksft.py b/tools/testing/selftests/kselftest/ksft.py
similarity index 100%
rename from tools/testing/selftests/devices/probe/ksft.py
rename to tools/testing/selftests/kselftest/ksft.py

-- 
2.44.0


