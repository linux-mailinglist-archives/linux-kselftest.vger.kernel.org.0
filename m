Return-Path: <linux-kselftest+bounces-14690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040D945515
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 02:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C351F2335A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 00:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648FA50;
	Fri,  2 Aug 2024 00:03:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61A211C;
	Fri,  2 Aug 2024 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556995; cv=none; b=u6Ch5BNyw+J2aLJus+XWtRx/KYHedI2ZyCEqtVir2lO49I6gA2oNKrd+lJrJq3y8ZU7BD3/OwnHxDpABkM7821lMsPIqQ8K+5uX/oHZ7IyMR90vxrnIiAFYyQV4pMMQVCNiQCatPqlxdOnLsWjJJSnAgVyMqgdl7RW8h+FQEAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556995; c=relaxed/simple;
	bh=QcAvIHWMBzWxGBJ2Vi6pxtBbNp1IdHzgY8X0Nsct7M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK2V04EX4DhVzQoToXuyOzT8GlhKUa929rg+v0TjX4yYWZN+jtSGKLACPtp1AF7LVzA5StW4LK22C3gT1XauCB+FpaUtISaDR+diEXpyazfBSCrxxcJitZjhfQh/pOjJQ5NNpNjFKE8lXI9PiiOpksHkN5e5Xod4Wev0XDSazQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-264545214efso4176900fac.3;
        Thu, 01 Aug 2024 17:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722556992; x=1723161792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnCk0SvEhVwQqWO65jWfKFlVg+4G4vLteypuoGCHAVw=;
        b=rN0M5iQHvlVt9756/EMgkgwOpAgvBi5gmQHK+xDPNMCWOwHIULR11R6lFYUxBGNQt/
         0HizOEvBPO7S43YMshfDhO/rPlIp80Ht/LUMeuxhu8zyreRlajwyBY6QEdqetogiMpbY
         7XtO9wm4MQLqzrtlENUhvdNukUKy48s6/d36lqavkOhBFeFuM8rfvnVvHUfohek3Kj84
         9pFMeER9ngxgasRHeVfE52nSHc44oa3MErtUkZNApnFsu4yW+5OqCuMjsNizFAX2Gjfu
         5zwwd7yRUiyNJrQdprpyC5/mmJvrDBPndiV1wAkq4XqYx2337U9PlznaGFAHWITqhfsi
         P1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX0gdJRYgn2DzbPkBfhlIkncd1DlD0rEab3eUjyaE4Y4zQvwpDR5pISm/ycXupzTkAFw9f9iJ/to438QyicQxPQmyR9hP2zoUIEIpwBnLaD
X-Gm-Message-State: AOJu0Yz+Wr/NYZVHQKI5k8OEMo0HHQLjkBCgYFKL4S5xKy45UWZwFnJL
	1dGmM43zNCdv4TQHqKjc/fK2eWHz/rkJKi/SENTqfWiEkycbC19SXocfJl4=
X-Google-Smtp-Source: AGHT+IENjZPlqB/SxZn2B7pZUNBxeiTO6cdgcP9ONNV5IK9CkDwX2ZP5uXA4KSVOwwsEGfG3BLhZsg==
X-Received: by 2002:a05:6870:a99d:b0:260:8f6d:f01f with SMTP id 586e51a60fabf-26891e93234mr1976666fac.39.1722556991621;
        Thu, 01 Aug 2024 17:03:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763a3fa2asm403346a12.50.2024.08.01.17.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:03:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Shuah Khan <shuah@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 2/3] selftests: net: ksft: support marking tests as disruptive
Date: Thu,  1 Aug 2024 17:03:08 -0700
Message-ID: <20240802000309.2368-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802000309.2368-1-sdf@fomichev.me>
References: <20240802000309.2368-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new @ksft_disruptive decorator to mark the tests that might
be disruptive to the system. Depending on how well the previous
test works in the CI we might want to disable disruptive tests
by default and only let the developers run them manually.

KSFT framework runs disruptive tests by default. DISRUPTIVE=False
environment (or config file) can be used to disable these tests.
ksft_setup should be called by the test cases that want to use
new decorator (ksft_setup is only called via NetDrvEnv/NetDrvEpEnv for now).

In the future we can add similar decorators to, for example, avoid
running slow tests all the time. And/or have some option to run
only 'fast' tests for some sort of smoke test scenario.

  $ DISRUPTIVE=False ./stats.py
  KTAP version 1
  1..5
  ok 1 stats.check_pause
  ok 2 stats.check_fec
  ok 3 stats.pkt_byte_sum
  ok 4 stats.qstat_by_ifindex
  ok 5 stats.check_down # SKIP marked as disruptive
  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:1 error:0

v3:
- parse yes and properly treat non-zero nums as true (Petr)

v2:
- convert from cli argument to env variable (Jakub)

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
Cc: Shuah Khan <shuah@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/lib/py/env.py       |  5 ++-
 tools/testing/selftests/drivers/net/stats.py  |  2 +
 tools/testing/selftests/net/lib/py/ksft.py    | 40 +++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index a5e800b8f103..1ea9bb695e94 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -4,6 +4,7 @@ import os
 import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
+from lib.py import ksft_setup
 from lib.py import cmd, ethtool, ip
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
@@ -14,7 +15,7 @@ from .remote import Remote
 
     src_dir = Path(src_path).parent.resolve()
     if not (src_dir / "net.config").exists():
-        return env
+        return ksft_setup(env)
 
     with open((src_dir / "net.config").as_posix(), 'r') as fp:
         for line in fp.readlines():
@@ -30,7 +31,7 @@ from .remote import Remote
             if len(pair) != 2:
                 raise Exception("Can't parse configuration line:", full_file)
             env[pair[0]] = pair[1]
-    return env
+    return ksft_setup(env)
 
 
 class NetDrvEnv:
diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 2fdde8cf0307..d17dfed2788f 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -4,6 +4,7 @@
 import errno
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_disruptive
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import ip, defer
@@ -135,6 +136,7 @@ rtnl = RtnlFamily()
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
 
 
+@ksft_disruptive
 def check_down(cfg) -> None:
     try:
         qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f26c20df9db4..353860fe6223 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import builtins
+import functools
 import inspect
 import sys
 import time
@@ -10,6 +11,7 @@ from .utils import global_defer_queue
 
 KSFT_RESULT = None
 KSFT_RESULT_ALL = True
+KSFT_DISRUPTIVE = True
 
 
 class KsftFailEx(Exception):
@@ -127,6 +129,44 @@ KSFT_RESULT_ALL = True
             KSFT_RESULT = False
 
 
+def ksft_disruptive(func):
+    """
+    Decorator that marks the test as disruptive (e.g. the test
+    that can down the interface). Disruptive tests can be skipped
+    by passing DISRUPTIVE=False environment variable.
+    """
+
+    @functools.wraps(func)
+    def wrapper(*args, **kwargs):
+        if not KSFT_DISRUPTIVE:
+            raise KsftSkipEx(f"marked as disruptive")
+        return func(*args, **kwargs)
+    return wrapper
+
+
+def ksft_setup(env):
+    """
+    Setup test framework global state from the environment.
+    """
+
+    def get_bool(env, name):
+        value = env.get(name, "").lower()
+        if value in ["yes", "true"]:
+            return True
+        if value in ["no", "false"]:
+            return False
+        try:
+            return bool(int(value))
+        except:
+            raise Exception(f"failed to parse {name}")
+
+    if "DISRUPTIVE" in env:
+        global KSFT_DISRUPTIVE
+        KSFT_DISRUPTIVE = get_bool(env, "DISRUPTIVE")
+
+    return env
+
+
 def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
     cases = cases or []
 
-- 
2.45.2


