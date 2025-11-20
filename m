Return-Path: <linux-kselftest+bounces-46040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF93BC71C4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B70E12C7AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C927EFFA;
	Thu, 20 Nov 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3ezgLl2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42F27CCE2;
	Thu, 20 Nov 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604643; cv=none; b=En67vJo+02DEtsY9eP6ecTmBTquRUDRYIiB/Saqoqaxp5E8YGDVtmVUtb3YwaQHwr7OLbMDMG7zXTyIwJ85W+TzxK06uFWu2gUuVUXMJIFLYXTXMybCUEjQIJMrLE1EFSjvbotyyhem+XuwAwrqMj4Csh3hOYfBa9aEim7wpbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604643; c=relaxed/simple;
	bh=M2RDMOflWruszvz4IjlIJ7Tc0Rm0J++juLnLaKCcYtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyxEU3FOFIJmlYU4k2eqPrOUxm/1VAwZLe7msRnXx+Njvx9FNDij1d89wS7VqAk61oNbwhRqg+AEUzQcS6V+bCW77wTS8tC6Ap9IlQNnKt/Fup+6DR5EUryGaTikLDQP+gfg+dDIdtMDxu526n3hHiCT9NvuaghIypF3artSR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3ezgLl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A400CC19421;
	Thu, 20 Nov 2025 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604643;
	bh=M2RDMOflWruszvz4IjlIJ7Tc0Rm0J++juLnLaKCcYtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3ezgLl2IlSyehJ26SJAJ+L8DP7Na2iwLINnB+hlau3nXU8mzsOQf8JGhJhj4stWP
	 OfNeMqt5SBBh7f7I69/FumVSkNLjJL1ZUuI16VWQuorhYoaREZtzV4CDHECNKUheeA
	 sBjPJxjUpCS4LTl0sPOpRx2e8WW3nPNETozmEPS3pA2bNuNqBCf9hnJLvOoNRaYq7s
	 itf9A2pSPPNdtEgV11q9aFgQH+W93dWwl1WIA4cZX1ehgbjcL2EJM7laSzXa5jr59J
	 JCoouG47Kgs2ivxmVoQPLlGasFvrfqpu+mGDuaTAu68g9zVQJVTxKad2seIEhGQ5b8
	 Ik5GN67Uu9TrA==
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
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 03/12] selftests: net: py: add test variants
Date: Wed, 19 Nov 2025 18:10:15 -0800
Message-ID: <20251120021024.2944527-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120021024.2944527-1-kuba@kernel.org>
References: <20251120021024.2944527-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - use named tuple instead of attaching attrs directly to a func
v2: https://lore.kernel.org/20251118215126.2225826-4-kuba@kernel.org
---
 .../drivers/net/hw/lib/py/__init__.py         |  4 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  4 +-
 .../testing/selftests/net/lib/py/__init__.py  |  5 +-
 tools/testing/selftests/net/lib/py/ksft.py    | 55 ++++++++++++++++++-
 4 files changed, 61 insertions(+), 7 deletions(-)

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
index 3ef39436302a..ebd82940ee50 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -6,6 +6,7 @@ import signal
 import sys
 import time
 import traceback
+from collections import namedtuple
 from .consts import KSFT_MAIN_NAME
 from .utils import global_defer_queue
 
@@ -170,6 +171,10 @@ KSFT_DISRUPTIVE = True
             KSFT_RESULT = False
 
 
+KsftCaseFunction = namedtuple("KsftCaseFunction",
+                              ['name', 'original_func', 'variants'])
+
+
 def ksft_disruptive(func):
     """
     Decorator that marks the test as disruptive (e.g. the test
@@ -185,6 +190,42 @@ KSFT_DISRUPTIVE = True
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
+    return lambda func: KsftCaseFunction(func.__name__, func, params)
+
+
 def ksft_setup(env):
     """
     Setup test framework global state from the environment.
@@ -236,7 +277,19 @@ KSFT_DISRUPTIVE = True
                     break
 
     for func in cases:
-        test_cases.append((func, args, func.__name__))
+        if isinstance(func, KsftCaseFunction):
+            # Parametrized test - create case for each param
+            for param in func.variants:
+                if not isinstance(param, KsftNamedVariant):
+                    if not isinstance(param, tuple):
+                        param = (param, )
+                    param = KsftNamedVariant(None, *param)
+
+                test_cases.append((func.original_func,
+                                   (*args, *param.params),
+                                   func.name + "." + param.name))
+        else:
+            test_cases.append((func, args, func.__name__))
 
     return test_cases
 
-- 
2.51.1


