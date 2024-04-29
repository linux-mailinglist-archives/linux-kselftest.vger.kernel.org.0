Return-Path: <linux-kselftest+bounces-9025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4B8B5BB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F6B28235F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B380022;
	Mon, 29 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+YRdmvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B27FBC8;
	Mon, 29 Apr 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401874; cv=none; b=jdD/x9H1O7aIsv8Z9P45xgfidtOvKf305yJZdfMmEUanDHO/lHgpybC8EiQriyiQvUpbq34ARh2nReDnDoY1zEoiinrxR5hwk9TEcVo7iNpExTPRmEBo/r6iWEL6boi8zEhvhGFC5JQuFAgGkkogpF2zhpYtMEY99vIyPmN0On8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401874; c=relaxed/simple;
	bh=p2z2h5vG0yu/HelbmuJbgpX2U46xn4dXGiCYIuFOtIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FP5gp11K3kqlWxY9BBWDAfx5mO/XuGdYIi4GDG18vqSI4YW3YQ8O1QNExcF92UvlNKapGd1ZW/XsrvRmGpAJcr7UPIh/IGvrqy/5uy1Rh4CtX19gU6i0I7ZNCeVS60GbvIg6Mm8OT77XUzbd2jdFl5ra3e3QZuaawAwozPnAk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+YRdmvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B84AC4AF1D;
	Mon, 29 Apr 2024 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401873;
	bh=p2z2h5vG0yu/HelbmuJbgpX2U46xn4dXGiCYIuFOtIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+YRdmvwTPsx9/FKHCY5jH3/TloKkj7yXBHHX2blXUuMx1gwIqv3B/Dd1lQJsxncr
	 2yVVBo0YxpJ/GB5bVX4BpSbnZeeReCLAWj8HWLBRIVH1z/9dkoW18Ek1W2BGDel5+I
	 lIzCI0QaUtykiw3F+D1URh4JWJ4JpvmjjaxegKj/Kv8jA2mFfKBVvCk6dlKu5K9oqb
	 reH1MRZdpZ4tIsVzuvSBHxH/7ZYdOGM66XRxaOqe17A2I+9yo/AH2XL4u/g7N9T7c+
	 xGTTOyid3cNbW0HFH28uEKvLtXpXW7gvtGv9ik9IsRbMlisI4+FM37oOK9A7LrR6KS
	 NGMViSkLujIFw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 2/6] selftests: drv-net-hw: support using Python from net hw tests
Date: Mon, 29 Apr 2024 07:44:22 -0700
Message-ID: <20240429144426.743476-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429144426.743476-1-kuba@kernel.org>
References: <20240429144426.743476-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
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


