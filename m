Return-Path: <linux-kselftest+bounces-8279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C718A8F29
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 01:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0572DB220F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 23:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8985C62;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjezADI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD785923;
	Wed, 17 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395517; cv=none; b=WsYmIXKEALFTBaO+rF2vy+HLgA9oab+L/KCPogJqdO0sDYyn/IxdNG/OXOkGYJ3pKz1V9g85fHNmeArwXYhcb+LXEV844JJ6ylBKCVL13VRijA1+U+1lNxVfR0oAy8IU1EQYspVPBaZRxm8c6M/pzESfYDv4+vGrKoPcJohEglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395517; c=relaxed/simple;
	bh=L8RYGfut66Ms4oIXNHvCI2Eazz9Ntss0vK6ONZSR+oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoY+P9BFKgGnI1pTsXLD9awEr0oAPMAK49N/ID27mBPtGN+q5cA9ORp7n2uyLmkvhadwJs12LtslCfX4s8CNpRKF7DtZ+xUveOueIVvbQvlu+SnhnfaQ6x3kU3a3itv9VFmkmAlvrArR9SSX0g5rzEgyTC9B/nnnum+KiySdcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjezADI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDCFC32781;
	Wed, 17 Apr 2024 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713395517;
	bh=L8RYGfut66Ms4oIXNHvCI2Eazz9Ntss0vK6ONZSR+oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjezADI3DNOwWAXY7qaVqnQywJBxn0Ks7o2Y+cJiHgZFz6tl8wzYp30mMa/jpcZeB
	 bctSZi561VdspQRN1RertlwTUvrAGijqRjLv2vwR/CSIHqn3qlnoGsOIWwKBx+ApvZ
	 yWMkZsf6CnOLyLE8H8K0iwE3VriaOksgSbaa+LFkL8h18WmEufymgUYDzyT+TD+S3t
	 CoeGu/gX4gGedPmzMhvyY78It3gLG/UM6MdTjJIflZxsKxEHQPDg80M9Y4McWEz7FP
	 tTzllt4EkZPeir1tPQH36xrVJJPSGrOOp7Litkrf1HR2U0YYKYPkkuD1abHyUYTNFB
	 C/Ak8M5Sxudiw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/8] selftests: net: set the exit code correctly in Python tests
Date: Wed, 17 Apr 2024 16:11:40 -0700
Message-ID: <20240417231146.2435572-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417231146.2435572-1-kuba@kernel.org>
References: <20240417231146.2435572-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test cases need to exit with non-zero status if they failed,
we currently don't do that:

  # KTAP version 1
  # 1..3
  # # At /root/ksft-net-drv/drivers/net/./ping.py line 18:
  # # Check failed 1 != 2
  # not ok 1 ping.test_v4
  # ok 2 ping.test_v6
  # ok 3 ping.test_tcp
  # # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
  ok 1 selftests: drivers/net: ping.py
  ^^^^

It's a bit tempting to make the exit part of ksft_run(),
but that only works well for very trivial setups. We can
revisit this later, if people forget to call ksft_exit().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/stats.py |  4 +++-
 tools/testing/selftests/net/lib/py/ksft.py   | 10 ++++++++++
 tools/testing/selftests/net/nl_netdev.py     |  4 +++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 5a9d4e56b28b..947df3eb681f 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
 
@@ -80,6 +81,7 @@ rtnl = RtnlFamily()
     with NetDrvEnv(__file__) as cfg:
         ksft_run([check_pause, check_fec, pkt_byte_sum],
                  args=(cfg, ))
+    ksft_exit()
 
 
 if __name__ == "__main__":
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 640dfbf47702..25f2572fa540 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -2,11 +2,13 @@
 
 import builtins
 import inspect
+import sys
 import time
 import traceback
 from .consts import KSFT_MAIN_NAME
 
 KSFT_RESULT = None
+KSFT_RESULT_ALL = True
 
 
 class KsftSkipEx(Exception):
@@ -63,6 +65,9 @@ KSFT_RESULT = None
 
 
 def ktap_result(ok, cnt=1, case="", comment=""):
+    global KSFT_RESULT_ALL
+    KSFT_RESULT_ALL = KSFT_RESULT_ALL and ok
+
     res = ""
     if not ok:
         res += "not "
@@ -114,3 +119,8 @@ KSFT_RESULT = None
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
     )
+
+
+def ksft_exit():
+    global KSFT_RESULT_ALL
+    sys.exit(0 if KSFT_RESULT_ALL else 1)
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 6909b1760739..93d9d914529b 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -2,7 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import time
-from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, ksft_busy_wait
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
 from lib.py import NetdevFamily, NetdevSimDev, ip
 
 
@@ -90,6 +91,7 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
     nf = NetdevFamily()
     ksft_run([empty_check, lo_check, page_pool_check],
              args=(nf, ))
+    ksft_exit()
 
 
 if __name__ == "__main__":
-- 
2.44.0


