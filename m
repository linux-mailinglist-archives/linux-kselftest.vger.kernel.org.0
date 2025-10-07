Return-Path: <linux-kselftest+bounces-42857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F2BC2F18
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 01:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5522C34510D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 23:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ABC26A0D0;
	Tue,  7 Oct 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRmF6RPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6F269AE9;
	Tue,  7 Oct 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879631; cv=none; b=LQngDY4EJXj0Q+lLde9Kmh9RUNV03TFOM+v6KU4l0QGPtU2ZnX26nbWA8tz2IDJRl8rleQ+46hdZmr4Dbh1s6qobN3pPEG/RFeOFgeXWvfanKniBjHxTA8kEyM/BxF0miwLY4DSn+seDxWkizN2epkFIfjdHeo7hEBB7KPSYVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879631; c=relaxed/simple;
	bh=diD3YtS1p7i/axPvYL2365mcS7f6J9B8A8/K9o3aWWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSe4mgORDui5iiLWMDCR8bqBoc5cUBTvkc8TONoUVUBDuJaaEn+CSPk/3U2jb82f3rPksc4KdqlfYX2HtqqPvjtDrdiA3R1vi++B3a2FdA1fUKqIjNesmA4GHk0mL6okt/yK7+Kw2O6fUfylulPt/ARDyYlYmASJRG/j5UmHivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRmF6RPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41671C19423;
	Tue,  7 Oct 2025 23:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759879630;
	bh=diD3YtS1p7i/axPvYL2365mcS7f6J9B8A8/K9o3aWWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRmF6RPXMVG0/S1VsazMrULsmIJfPjx0MR98U2fhaUf0a1hU01u753g7v59nw/Lqz
	 4++i38C/Z+BCFBh6QYK5Dt2qlJxmu2EJ1ymYpXJDofpmAAOJjKKCM90ckj9pGRxCin
	 pEcGdYQzNp9IH/PEpaF+umLxqoKg0iEi/07NJ/1t/XcK91QuNOApauMM8liZrcOhsh
	 RwhTlTkgvkUG13zEDNNyplWoGYyKhsDnYB1yNbpaaL6WBr0y1l9nK/23/cI4frhvmD
	 ScBggXlfSvaqBhHV0TF6dPyMzVIzAxTxgXqhcVKZ7CuHoKMYLvQCEzpHDU8JAEgujO
	 U5IutGzmiPTaQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	johndale@cisco.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 7/9] selftests: drv-net: fix linter warnings in pp_alloc_fail
Date: Tue,  7 Oct 2025 16:26:51 -0700
Message-ID: <20251007232653.2099376-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007232653.2099376-1-kuba@kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix linter warnings, it's a bit hard to check for new ones otherwise.

  W0311: Bad indentation. Found 16 spaces, expected 12 (bad-indentation)
  C0114: Missing module docstring (missing-module-docstring)
  W1514: Using open without explicitly specifying an encoding (unspecified-encoding)
  C0116: Missing function or method docstring (missing-function-docstring)

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: johndale@cisco.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/pp_alloc_fail.py | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
index ad192fef3117..fc66b7a7b149 100755
--- a/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
+++ b/tools/testing/selftests/drivers/net/hw/pp_alloc_fail.py
@@ -1,6 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Test driver resilience vs page pool allocation failures.
+"""
+
 import errno
 import time
 import os
@@ -13,7 +17,8 @@ from lib.py import cmd, tool, GenerateTraffic
 
 def _write_fail_config(config):
     for key, value in config.items():
-        with open("/sys/kernel/debug/fail_function/" + key, "w") as fp:
+        path = "/sys/kernel/debug/fail_function/"
+        with open(path + key, "w", encoding='ascii') as fp:
             fp.write(str(value) + "\n")
 
 
@@ -22,8 +27,7 @@ from lib.py import cmd, tool, GenerateTraffic
         raise KsftSkipEx("Kernel built without function error injection (or DebugFS)")
 
     if not os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_netmems"):
-        with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
-            fp.write("page_pool_alloc_netmems\n")
+        _write_fail_config({"inject": "page_pool_alloc_netmems"})
 
     _write_fail_config({
         "verbose": 0,
@@ -38,8 +42,7 @@ from lib.py import cmd, tool, GenerateTraffic
         return
 
     if os.path.exists("/sys/kernel/debug/fail_function/page_pool_alloc_netmems"):
-        with open("/sys/kernel/debug/fail_function/inject", "w") as fp:
-            fp.write("\n")
+        _write_fail_config({"inject": ""})
 
     _write_fail_config({
         "probability": 0,
@@ -48,6 +51,10 @@ from lib.py import cmd, tool, GenerateTraffic
 
 
 def test_pp_alloc(cfg, netdevnl):
+    """
+    Configure page pool allocation fail injection while traffic is running.
+    """
+
     def get_stats():
         return netdevnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
 
@@ -105,7 +112,7 @@ from lib.py import cmd, tool, GenerateTraffic
             else:
                 ksft_pr("ethtool -G change retval: did not succeed", new_g)
         else:
-                ksft_pr("ethtool -G change retval: did not try")
+            ksft_pr("ethtool -G change retval: did not try")
 
         time.sleep(0.1)
         check_traffic_flowing()
@@ -119,6 +126,7 @@ from lib.py import cmd, tool, GenerateTraffic
 
 
 def main() -> None:
+    """ Ksft boiler plate main """
     netdevnl = NetdevFamily()
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
 
-- 
2.51.0


