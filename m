Return-Path: <linux-kselftest+bounces-45921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E348C6BC5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89CE6349194
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788D30F535;
	Tue, 18 Nov 2025 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRJk0Ptz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE003702EE;
	Tue, 18 Nov 2025 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502721; cv=none; b=q9lRZWeCB6pWjzD2Oy5BwVEC1VaMn/3ugiaMnvj9oTX/H5x3gv+Am1XS6sYYRZdR91vSZkpReOPcq3c5W1w6TUnXmVLsREBnqGO2L7OsjQEskxcfzhB3hzsttynV/tZXdkoVgNIm3iPZWY4o/4YI1vlz48/CeAjaV3wvVt5hNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502721; c=relaxed/simple;
	bh=7VRlff2BxV4/bV8vpOfuj+lJBaj3v6P0BHu5peCjcxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT9RT+PXU0SJiW41yGRN7V1KNbhhPMwbSZdhGu68gzUi5JZPMkBPCRa3A+Mq9KXA6NPdNqaRbNIMow/43yeR7chU3ZZb70r1mTWp52QikHzy68t1i1qzrLAfA5xzn8X20IMWwoPgn99WH2ee26+teF4FMJqdgy2NjxlRWjK+osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRJk0Ptz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58518C4AF12;
	Tue, 18 Nov 2025 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502719;
	bh=7VRlff2BxV4/bV8vpOfuj+lJBaj3v6P0BHu5peCjcxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRJk0PtzONX0sC0kubkQ+CVML5mabmPt8CcjyL+48yHyGdj7T8JTwp3f6ERytI75i
	 xMmjVe5hRyqZ2xyAfD6J+s3k1p4ZtsMVaYw112HOFKOvDUyo0OA0ZZk7rBQMHz6iO7
	 x9DasGdh6zju7GC5In6X8c94ub/8PiuhH4Ld8yj1OU2hgK0mJPvujp2cTEGs0YElzz
	 xGNK9NCXUvxcq1T0As/JOll+GufTFOWRcRAYHuBymq6Ty1kZIi8s68/XQqgcCJD46L
	 wLc47s2GW+GzSYhmElAHYU93/kCxnzhPZHEm2MhprVhKRAZjRfpiTTdMCRU2eESxkB
	 nppsxSFsftmCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	krakauer@google.com,
	linux-kselftest@vger.kernel.org,
	petrm@nvidia.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/12] selftests: net: py: add test variants
Date: Tue, 18 Nov 2025 13:51:17 -0800
Message-ID: <20251118215126.2225826-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118215126.2225826-1-kuba@kernel.org>
References: <20251118215126.2225826-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a lot of cases where we try to re-run the same code with
different parameters. We currently need to either use a generator
method or create a "main" case implementation which then gets called
by trivial case functions:

  def _test(x, y, z):
     ...

  def case_int():
     _test(1, 2, 3)

  def case_str():
     _test('a', 'b', 'c')

Add support for variants, similar to kselftests_harness.h and
a lot of other frameworks. Variants can be added as decorator
to test functions:

  @ksft_variants([(1, 2, 3), ('a', 'b', 'c')])
  def case(x, y, z):
     ...

ksft_run() will auto-generate case names:
  case.1_2_3
  case.a_b_c

Because the names may not always be pretty (and to avoid forcing
classes to implement case-friendly __str__()) add a wrapper class
KsftNamedVariant which lets the user specify the name for the variant.

Note that ksft_run's args are still supported. ksft_run splices args
and variant params together.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../drivers/net/hw/lib/py/__init__.py         |  4 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  4 +-
 .../testing/selftests/net/lib/py/__init__.py  |  5 +-
 tools/testing/selftests/net/lib/py/ksft.py    | 57 ++++++++++++++++++-
 4 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index fb010a48a5a1..0c61debf86fb 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -25,7 +25,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
         fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
-        ksft_setup
+        ksft_setup, ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from drivers.net.lib.py import GenerateTraffic, Remote
@@ -40,7 +40,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
                "wait_port_listen", "wait_file",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
-               "ksft_setup",
+               "ksft_setup", "ksft_variants", "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none",
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index b0c6300150fb..d9d035634a31 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -25,7 +25,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
-        ksft_setup
+        ksft_setup, ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
 
@@ -38,7 +38,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "wait_port_listen", "wait_file",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
-               "ksft_setup",
+               "ksft_setup", "ksft_variants", "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
                "ksft_not_none", "ksft_not_none"]
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 97b7cf2b20eb..40f9ce307dd1 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -8,7 +8,8 @@ from .consts import KSRC
 from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
     ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
-    ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit
+    ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit, \
+    ksft_variants, KsftNamedVariant
 from .netns import NetNS, NetNSEnter
 from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
@@ -21,7 +22,7 @@ __all__ = ["KSRC",
            "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
            "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_setup",
-           "ksft_run", "ksft_exit",
+           "ksft_run", "ksft_exit", "ksft_variants", "KsftNamedVariant",
            "NetNS", "NetNSEnter",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 52c42c313cf2..47e0af210bee 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -185,6 +185,49 @@ KSFT_DISRUPTIVE = True
     return wrapper
 
 
+class KsftNamedVariant:
+    """ Named string name + argument list tuple for @ksft_variants """
+
+    def __init__(self, name, *params):
+        self.params = params
+        self.name = name or "_".join([str(x) for x in self.params])
+
+
+def ksft_variants(params):
+    """
+    Decorator defining the sets of inputs for a test.
+    The parameters will be included in the name of the resulting sub-case.
+    Parameters can be either single object, tuple or a KsftNamedVariant.
+    The argument can be a list or a generator.
+
+    Example:
+
+    @ksft_variants([
+        (1, "a"),
+        (2, "b"),
+        KsftNamedVariant("three", 3, "c"),
+    ])
+    def my_case(cfg, a, b):
+        pass # ...
+
+    ksft_run(cases=[my_case], args=(cfg, ))
+
+    Will generate cases:
+        my_case.1_a
+        my_case.2_b
+        my_case.three
+    """
+
+    def decorator(func):
+        @functools.wraps(func)
+        def wrapper():
+            return func
+        wrapper.ksft_variants = params
+        wrapper.original_func = func
+        return wrapper
+    return decorator
+
+
 def ksft_setup(env):
     """
     Setup test framework global state from the environment.
@@ -236,7 +279,19 @@ KSFT_DISRUPTIVE = True
                     break
 
     for func in cases:
-        test_cases.append((func, args, func.__name__))
+        if hasattr(func, 'ksft_variants'):
+            # Parametrized test - create case for each param
+            for param in func.ksft_variants:
+                if not isinstance(param, KsftNamedVariant):
+                    if not isinstance(param, tuple):
+                        param = (param, )
+                    param = KsftNamedVariant(None, *param)
+
+                test_cases.append((func.original_func,
+                                   (*args, *param.params),
+                                   func.__name__ + "." + param.name))
+        else:
+            test_cases.append((func, args, func.__name__))
 
     return test_cases
 
-- 
2.51.1


