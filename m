Return-Path: <linux-kselftest+bounces-20593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D2F9AF6EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDAD1F22B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0724879B;
	Fri, 25 Oct 2024 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ENF4RvO+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AC23774;
	Fri, 25 Oct 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820347; cv=none; b=rmA+AWrL4edorHSCQ3va0YAGCZh+xrx1u7Iv/u0E9N80H9/5McNPUIadjJfbYu69dSSemdcCdR3hl6dRzQR844KSE0I4Y0+hC8lKMaAfUOnltkb/vVDknd6zyaEb4zmvBlmJgbfY2IGwV8R3WzoOQubh3mtSlYDtL1+DyRPbhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820347; c=relaxed/simple;
	bh=7Ou85phjMNye1YCifzMzi9QSOAtJ4MXYhgDnyFLOnCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP6Q+yQ0aUdSUHc48NiyAYyFXZN/Jzm04ja5xh6F045m7zG8aum1yuCKdXV6SOJjqP9YfDK0w2voEqgJ6IHodPBZ2ojZi0QYlBX7Uj6VlfzDIzCNYBSHCJCjtiZusiPXU9UwdTihE62HregVK8rJ7TVFqaLF538NtM9ga7MbReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ENF4RvO+; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820344; x=1761356344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Ou85phjMNye1YCifzMzi9QSOAtJ4MXYhgDnyFLOnCI=;
  b=ENF4RvO+Zfemzno092gmhen0aDqHeacp1D716sNqfC3caolavZQlgDnF
   8LDlKbAse7q/qCqbPV2ndj9dTh1XR/1xi2MKyMGuVKU71IFWlauMFKLzg
   H2OtQjIJPzgNHcCCMwrppCj1CfOSLwG+RRdUSDnwzm2h42apFuwOgttEw
   42y/VLqUupmKhCacSBE6YxOYVtN+lVUssErKDWZatx/oigETlOsf5iTey
   PBeJGLSePf8MeXd8KSiZQDlF+h4GpyhaAOzoOr4Wx5TOj7SsCXPJ5Lurp
   l8do2r4aPwayobI9Rn9tiQ1pxH7drbrku5blSJEJbMo+ibuwmUVDqAj/S
   A==;
X-CSE-ConnectionGUID: ICVMqaF/QaONnHakaO3ILg==
X-CSE-MsgGUID: gUSRz4r5RO6ehmtsa9detw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="165907792"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="165907792"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:38:56 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EA8B56C9CC;
	Fri, 25 Oct 2024 10:38:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 26DF614156;
	Fri, 25 Oct 2024 10:38:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E7D21EB430;
	Fri, 25 Oct 2024 10:38:52 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 213761A000B;
	Fri, 25 Oct 2024 09:38:52 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 3/3] selftests/watchdog: Add run_watchdog-test.sh to run watchdog tests
Date: Fri, 25 Oct 2024 09:39:33 +0800
Message-ID: <20241025013933.6516-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025013933.6516-1-lizhijian@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10--8.569700-10.000000
X-TMASE-MatchedRID: cSoPLjBYd52ZsNAndtGo7RMxKDqgAFSzx7Z86wvHt/gB+kZ9/05jkOLS
	dVP2tZn5EDhghh9GReY+T46mdEugcdGETJv1/WyOIGmn4OlOtCNr2qJoNIuCjRnLDSQE/NUqPbx
	0HPA711ApVPxqKrQDZASAV03Nbefppbeu4XjpXOS9/kMM+y0cUSLLJGCSgZKknhD4vcFcha51N6
	CkrtCdcVIeZmiiCQMf5p98cjyQCaKnhintEWTpJ8kX80ZK4JFBKQNhMboqZlq4GyTmeN+AbFSyG
	GjquCee4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vuArEwRbHc1dzQ0yzRqxnVSoiSe8ff6an9yQH
	AjQkxq01hyrTj5a3Ww==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

We are ready to run the watchdog tests and check its exit code.
An example output is like below:
  linux/tools/testing/selftests/watchdog# make run_tests
  TAP version 13
  1..1
  # timeout set to 45
  # selftests: watchdog: run_watchdog-test.sh
  # ./run_watchdog-test.sh: Feed dog
  # Watchdog Ticking Away!
  # ..
  # ./run_watchdog-test.sh: Show watchdog_info
  # watchdog_info:
  #  identity:            iTCO_wdt
  #  firmware_version:    2
  # Support/Status: Set timeout (in seconds)
  # Support/Status: Supports magic close char
  # Support/Status: Keep alive ping reply
  #
  # ./run_watchdog-test.sh Turn off the watchdog timer
  # Watchdog card disabled.
  # Watchdog Ticking Away!
  # ..
  # ./run_watchdog-test.sh: Turn off the watchdog timer
  # Watchdog card enabled.
  # Watchdog Ticking Away!
  # ..
  # ./run_watchdog-test.sh: Set timeout to T seconds
  # Watchdog card disabled.
  # Watchdog timeout set to 10 seconds.
  # Watchdog card enabled.
  # Watchdog Ticking Away!
  # ..
  # ./run_watchdog-test.sh: Get the timeout
  # WDIOC_GETTIMEOUT returns 10 seconds.
  #
  # ./run_watchdog-test.sh: Get the pretimeout to T seconds
  # Watchdog card disabled.
  # WDIOC_GETPRETIMEOUT returns 0 seconds.
  # Watchdog card enabled.
  #
  # ./run_watchdog-test.sh Get the time left until timer expires
  # WDIOC_GETTIMELEFT returns 9 seconds.
  #
  # Get status & supported features
  # Support/Status: Keep alive ping reply
  # WDIOC_GETTEMP: 'Inappropriate ioctl for device'
  not ok 1 selftests: watchdog: run_watchdog-test.sh # exit=1

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/watchdog/Makefile     |  3 +-
 .../selftests/watchdog/run_watchdog-test.sh   | 41 +++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/watchdog/run_watchdog-test.sh

diff --git a/tools/testing/selftests/watchdog/Makefile b/tools/testing/selftests/watchdog/Makefile
index 6b5598b55252..4d1cb1d292a1 100644
--- a/tools/testing/selftests/watchdog/Makefile
+++ b/tools/testing/selftests/watchdog/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := watchdog-test
+TEST_GEN_FILES := watchdog-test
+TEST_PROGS := run_watchdog-test.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/watchdog/run_watchdog-test.sh b/tools/testing/selftests/watchdog/run_watchdog-test.sh
new file mode 100755
index 000000000000..0ea4b7770f1d
--- /dev/null
+++ b/tools/testing/selftests/watchdog/run_watchdog-test.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "$0: Feed dog"
+./watchdog-test -c 2 || exit
+
+echo
+echo "$0: Show watchdog_info"
+./watchdog-test -i -c 2 || exit
+
+echo
+echo "$0 Turn off the watchdog timer"
+./watchdog-test -d -c 2 || exit
+
+echo
+echo "$0: Turn on the watchdog timer"
+./watchdog-test -e -c 2 || exit
+
+echo
+echo "$0: Set timeout to T seconds"
+./watchdog-test -d -t 10 -c 2 -e || exit
+
+echo
+echo "$0: Get the timeout"
+./watchdog-test -T -c 2 || exit
+
+echo
+echo "$0: Get the pretimeout to T seconds"
+./watchdog-test -d -N -c 2 -e || exit
+
+echo
+echo "$0 Get the time left until timer expires"
+./watchdog-test -L -c 2 || exit
+
+echo
+echo "Get status & supported features"
+./watchdog-test -s || exit
+
+echo
+echo "$0: Set the pretimeout to T seconds"
+./watchdog-test -n 3 -c 2 || exit
-- 
2.44.0


