Return-Path: <linux-kselftest+bounces-14497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562FD942307
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C809D1F24AA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A321917E6;
	Tue, 30 Jul 2024 22:39:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996D18FC70;
	Tue, 30 Jul 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379177; cv=none; b=k3i9jZ6ih/D24uWFeaa/di4NDWoriXgmFMHUC/YvV0MPE5Gb5Y0bRA6ShkQL7JqaokbSB8EdOrSWF3V7mlpiXtnLW9a76N4Mb/d6w2ViSBzdEu65aKPcg4N168eQACKkgqe0Njo0XnNpZ1X1s5nBfoL4BIT8U77doHiuVLwO0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379177; c=relaxed/simple;
	bh=01aBNQY5Tlt8L4YGWNQDg+n+NxluEmat5HtzzHYcFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htwt88P4QOAP03DljNQTZdxDz+9RU7UzvdmRzkeUIDgaxY3nY/Mk7H//FHx8WptDpTvj0HDwcXMDd9CeIeZHe+5++317ancX+jZzQUlZTfPjURuhvR1C0c08Nq07dyfOi1U2HiF/HcCT9/BnZ2Vr8JzfYRlnUCmk05NMbqKO6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ff1cd07f56so31003185ad.2;
        Tue, 30 Jul 2024 15:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379175; x=1722983975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z09/Z1fFuYaGdkTvdaTZsUViz4sT9rHWzDlJHDRXuU=;
        b=sl4Iiow33tMulwhSvf58S2v9mmdyhQNScRUXKm8Ogz3DrYTaifBNmWQMn8M9uuMgri
         zhRLN5pq3lUbH8hcmF1Ub2YABvQTAyn1MsiocGQ6Bu32FubIF6XxVusCHN9eT7PMLoOH
         k5n2RFEMThy4VJEx1KTHBEKURr6zFxYg2i+wDGENvYOUKitpgzvDoj2q6TSgVWV3/k4Q
         a9HxqRbj02oWTm3o93L2Mn4xQ53eL8OiYFrasX5CUA5vh/WFe3cE15koYVjKlatUv5ji
         MV59GTsYihJZ6zQejcNqeX7x11LU/aQzgDqyWe/OnrnpDKe+XRRf7YxyYH74J2NJA2WD
         9iNg==
X-Forwarded-Encrypted: i=1; AJvYcCVvRbLWGcY9/YfIHKQ58+gLqBTCPqgb86vIxImqScihPBsS++pFL4wLsc9LYa0Hffc/Hec5HEjvNLgZF8dIvb5gZlVcGpfNi1/u4b++jdiP
X-Gm-Message-State: AOJu0YxrqJBVdntSOoXTIJSkv2l4KYhdLiYd+GUYEaqqEa805yQVDvQE
	9DMxCibowDuj8xmd3pjNpEP72gQen1WYcSGjlXNkLaWfX2dbKtNzXONNpRU=
X-Google-Smtp-Source: AGHT+IFu7dksqrakFuuKC+Bv5tO4eYOWvZikOGyNL5gOMwcg7zTzDEDlWgCTwxTTZ3ZeBBjN/smI+Q==
X-Received: by 2002:a17:902:ec86:b0:1fd:9e88:e4c3 with SMTP id d9443c01a7336-1ff04824fffmr163693455ad.17.1722379174623;
        Tue, 30 Jul 2024 15:39:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c89933sm107238125ad.33.2024.07.30.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:39:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] selftests: net: ksft: support marking tests as disruptive
Date: Tue, 30 Jul 2024 15:39:32 -0700
Message-ID: <20240730223932.3432862-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730223932.3432862-1-sdf@fomichev.me>
References: <20240730223932.3432862-1-sdf@fomichev.me>
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

v2:
- convert from cli argument to env variable (Jakub)

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
--
Cc: Shuah Khan <shuah@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/lib/py/env.py       |  5 +--
 tools/testing/selftests/drivers/net/stats.py  |  2 ++
 tools/testing/selftests/net/lib/py/ksft.py    | 32 +++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

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
index 93f9204f51c4..4c58080cf893 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -3,6 +3,7 @@
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
+from lib.py import ksft_disruptive
 from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import ip, defer
@@ -134,6 +135,7 @@ rtnl = RtnlFamily()
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
 
 
+@ksft_disruptive
 def check_down(cfg) -> None:
     try:
         qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index f26c20df9db4..a9a24ea77226 100644
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
@@ -127,6 +129,36 @@ KSFT_RESULT_ALL = True
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
+        return env.get(name, "").lower() in ["true", "1"]
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


