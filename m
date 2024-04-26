Return-Path: <linux-kselftest+bounces-8966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448F8B42B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A261C21E35
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0143CF58;
	Fri, 26 Apr 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REsYpzzz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60003C463;
	Fri, 26 Apr 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173845; cv=none; b=hHGfrABnWzQA38bcizZwx0Q48drTztqBPaIpld27p2TgxEiV/BGsFiVlJZJlvZRfGgRM8haIp9oZ0//QiR8BD87ZF5R9Vygf+hvLIc36ySHXIJBbGqEizbTaus0KrizN3g1W9uBFwxhuan0aqVSPzHpKHs2C66ibVAFxlYMW0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173845; c=relaxed/simple;
	bh=R2MeTPPej4K2BQjN/dfOWT2R2ABVWvDqMSdtBKSl1zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtBPUGUmLAw32CvZYQlcO8TxacUgI+cC8C2Kn2FIPlMLV1ehxzq0LRrPUZm7hYsVGK5HY2/aElQKOnX4r7LPsjRMGZeSd1SX1r9XoDpOOSUeVIwTu7s/ovqyttR+yxsPrMQtcYNfnR7bL+PjAwm6+WvrR+MA1/iBDAjNeR6qJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REsYpzzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1653C2BD11;
	Fri, 26 Apr 2024 23:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173845;
	bh=R2MeTPPej4K2BQjN/dfOWT2R2ABVWvDqMSdtBKSl1zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REsYpzzzip2dW3wA8jvVnGqBElwgGZctDhxXVn0vCr02cgSAiww34/MT2opzB2T2o
	 JHAJ1aipOn/Km6cTmtA6LnkhP6RjTUClhxuuuEsltv5ffLKg17cNzKVEd2wTWj11Sh
	 Le1RooQq5FezBV3HkPHlvaNcR1rSLVG1f+QCoxoTh7W+jBr2jep1nZsDqL0RzSnbUd
	 bnEG6usgsf4UGDtmOjBZ8ZTl0HHUFPHpyc1DcTfVWC+ci60boqqFP07P1M3gHmwk85
	 +Ps5qnx1WfYno8FLBu7L5dOqqeorzqvjTiSSKm1IB7gB/T3TD82LwQlZIxh6n8/rAB
	 +x1AjIy8uu2Vg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/6] selftests: drv-net-hw: support using Python from net hw tests
Date: Fri, 26 Apr 2024 16:23:55 -0700
Message-ID: <20240426232400.624864-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426232400.624864-1-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We created a separate directory for HW-only tests, recently.
Glue in the Python test library there, Python is a bit annoying
when it comes to using library code located "lower"
in the directory structure.

Reuse the Env class, but let tests require non-nsim setup.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/Makefile                 |  2 +-
 tools/testing/selftests/drivers/net/hw/Makefile  |  1 +
 .../selftests/drivers/net/hw/lib/py/__init__.py  | 16 ++++++++++++++++
 .../testing/selftests/drivers/net/lib/py/env.py  | 10 ++++++++--
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/lib/py/__init__.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2c940e9c4ced..9039f3709aff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -119,7 +119,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net,$(TARGETS)),)
+ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 2259a39a70ed..95f32158b095 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -16,6 +16,7 @@ TEST_FILES := \
 	#
 
 TEST_INCLUDES := \
+	$(wildcard lib/py/*.py ../lib/py/*.py) \
 	../../../net/lib.sh \
 	../../../net/forwarding/lib.sh \
 	../../../net/forwarding/ipip_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
new file mode 100644
index 000000000000..b582885786f5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+    from net.lib.py import *
+    from drivers.net.lib.py import *
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `net` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index e2ab637e56dc..5c8f695b2536 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -2,7 +2,7 @@
 
 import os
 from pathlib import Path
-from lib.py import KsftSkipEx
+from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import cmd, ip
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
@@ -76,7 +76,7 @@ from .remote import Remote
     nsim_v4_pfx = "192.0.2."
     nsim_v6_pfx = "2001:db8::"
 
-    def __init__(self, src_path):
+    def __init__(self, src_path, nsim_test=None):
 
         self.env = _load_env_file(src_path)
 
@@ -88,7 +88,10 @@ from .remote import Remote
         self._ns_peer = None
 
         if "NETIF" in self.env:
+            if nsim_test is True:
+                raise KsftXfailEx("Test only works on netdevsim")
             self._check_env()
+
             self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
 
             self.v4 = self.env.get("LOCAL_V4")
@@ -98,6 +101,9 @@ from .remote import Remote
             kind = self.env["REMOTE_TYPE"]
             args = self.env["REMOTE_ARGS"]
         else:
+            if nsim_test is False:
+                raise KsftXfailEx("Test does not work on netdevsim")
+
             self.create_local()
 
             self.dev = self._ns.nsims[0].dev
-- 
2.44.0


