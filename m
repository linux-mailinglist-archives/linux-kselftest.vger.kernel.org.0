Return-Path: <linux-kselftest+bounces-42901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7D3BC6037
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48DD74E2EF1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384C29D279;
	Wed,  8 Oct 2025 16:25:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6E10957
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940708; cv=none; b=mJodkC4QlSbnIL5IFVy8ev+U/Ac1fBTMH4W0J/J44DTl+FW8/ILyn6HSJu9Ctfkjs3wNvjHLSmeVCssrw0Cxmz5jAJbeqkDqrGHNpI30OHf3f7SkoAhgbi5t7fSH80tkr6655D4HViXAa8IULzYmnKaNC/qSncaN3W/4xffl03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940708; c=relaxed/simple;
	bh=Dmiwn2mr2rCHOc0TQSND9LLrXQRFE4B6R8jw0RE9nok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRbepqdFvH4aRmkBJYVESnTg0g2SezLhC8LfeQ7X0SECBaNL/AnB8UanUuoGWmcqeKCrvm06Zw27CcvbpZw1YsrCtEdWECUPjlWLM1teAmGcXjYCJ2FqRtrP8P7rT4h3o8GqC/8WGR7Tx/uKpXHhpzexS9/SE4Oa4cWzRMf0fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7930132f59aso9976b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Oct 2025 09:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940704; x=1760545504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lha07SgLr6YajsxSBvN4itwnfzekQjZC85rngCVcAvE=;
        b=GT9nk0CbBzYhUSA//eQJ9XY6cCeGJW+7oGBZis9dnbSetwsttV5gR8+iuffW2RBrIt
         /QJjQNtl4TjGHKn4FdmJVyRI9z3gQpbnHORA7kGc2WyCeUYGMMvvgmWTHnNPQ+v+jwsA
         VDtG93AfutZzDhozEpkAvdNhZWYO6jm/zNYDPpylzbJkJMcYqPR/75p311oK4Md/2kXV
         yYZ80Zfj7mm7QcwS8by64Ojf29sARu49iZlQKzgCg9ks+Ksi4WMetVO7i2KZOm5y/EiA
         77ExY2KmhSseaCfKXa51ijhAhEfkdo5XhuQ+Hvlr12hGqH+n0NkxguTqHdOH50Ldp3KO
         PgaA==
X-Forwarded-Encrypted: i=1; AJvYcCUD9YMU7BuEa9jQMLfJWnrCp7JI2hziEQuDEfNC7pmjf+BJJitMH5tVU/ZRXTGA9uvQpsBO8+ZNpx/qTmsWTtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+mgMlrP5xj3Ly5vFB7mukWOZFlpyz3uKZLqTNeTF0CFjIrXX
	aWvFOCPaPup7f8DhHcUAf/qnuEbue7RCbZ7DavK70jh7B64QJPmR/Cc7ajuH
X-Gm-Gg: ASbGncsRjDaclheyDaBSp5A5pFsHkAMpDeNDR4ZriOlJJvwnqtgEzWdXp/iLespjudJ
	vlFANjxSb/H0hMvMNrFGSXdnDCGC/UOb3RAiRTsNfPBZgG54SyOnCotPrnHJxGbhyM/329U/ILr
	Rmvhq4wAishlAhfbColDfM5OsPwG1Rr5oSwbEzvHNeuOgsWhBYyS1lHiQdNGilgvxKYVcHjUutA
	d3KUcN03WWh3d4K28vobcwy6VmajvxhFPBno0mYXCtnRDyHTUwYyCbxoUFdqfczaEBfmJrkg/aD
	29am7XItwtcMcJX1XNzuteEDLB4N23Kqb2Om+iG//tDbk4ljUWTaNSNV9h1ffxIwqx2vktWqYCm
	te3BBXVhLUG6KxpDq6CWGfE9bZOF6hshtQXqA6ghAQ/+ZQFBdNC9SbToFUFlKy3FoMTyd6VoYpk
	eUA/dL+aIY4kNvPUuKAsfYepfNZ/w75lVlE/i0AWkRt3RYlgi3EnZtgvKpAtEQKEZmyBlyYxFci
	1ENt0MMsDkzbjWxIZtfFfYTe1gHDw==
X-Google-Smtp-Source: AGHT+IG7rJeTc7BaYSRW2mgEZOIvuZo+hdU8tJz9alDLAEj9qzpkoBMt/mHdSNCv2yx7KPQXHG9lGA==
X-Received: by 2002:a05:6a00:398b:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7938723dab3mr4584210b3a.19.1759940703895;
        Wed, 08 Oct 2025 09:25:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-794e2a4cb5asm156736b3a.71.2025.10.08.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:25:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] selftests: drv-net: update remaining Python init files
Date: Wed,  8 Oct 2025 09:25:03 -0700
Message-ID: <20251008162503.1403966-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Convert remaining __init__ files similar to what we did in
commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove tool from imports in driver __init__s it's not actually used
v1: https://lore.kernel.org/20251007144326.1763309-1-kuba@kernel.org

CC: shuah@kernel.org
CC: willemb@google.com
CC: daniel.zahka@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 .../drivers/net/hw/lib/py/__init__.py         | 40 ++++++++++++++-----
 .../selftests/drivers/net/lib/py/__init__.py  |  4 +-
 .../testing/selftests/net/lib/py/__init__.py  | 29 ++++++++++++--
 3 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 0ceb297e7757..fb010a48a5a1 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -1,5 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Driver test environment (hardware-only tests).
+NetDrvEnv and NetDrvEpEnv are the main environment classes.
+Former is for local host only tests, latter creates / connects
+to a remote endpoint. See NIPA wiki for more information about
+running and writing driver tests.
+"""
+
 import sys
 from pathlib import Path
 
@@ -8,26 +16,36 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
 try:
     sys.path.append(KSFT_DIR.as_posix())
 
-    from net.lib.py import *
-    from drivers.net.lib.py import *
-
     # Import one by one to avoid pylint false positives
+    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
-        rand_port, tool, wait_port_listen
-    from net.lib.py import fd_read_timeout
+    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
-    from net.lib.py import NetNSEnter
-    from drivers.net.lib.py import GenerateTraffic
+    from drivers.net.lib.py import GenerateTraffic, Remote
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+
+    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
+               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "CmdExitFailure",
+               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
+               "fd_read_timeout", "ip", "rand_port",
+               "wait_port_listen", "wait_file",
+               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
+               "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
+               "ksft_setup",
+               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
+               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
+               "ksft_not_none", "ksft_not_none",
+               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
 except ModuleNotFoundError as e:
-    ksft_pr("Failed importing `net` library from kernel sources")
-    ksft_pr(str(e))
-    ktap_result(True, comment="SKIP")
+    print("Failed importing `net` library from kernel sources")
+    print(str(e))
     sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index e6c070f32f51..b0c6300150fb 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -22,7 +22,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
@@ -34,7 +34,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port", "tool",
+               "fd_read_timeout", "ip", "rand_port",
                "wait_port_listen", "wait_file",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 997b85cc216a..97b7cf2b20eb 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -1,9 +1,32 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Python selftest helpers for netdev.
+"""
+
 from .consts import KSRC
-from .ksft import *
+from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
+    ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
+    ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
+    ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit
 from .netns import NetNS, NetNSEnter
-from .nsim import *
-from .utils import *
+from .nsim import NetdevSim, NetdevSimDev
+from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
+    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+
+__all__ = ["KSRC",
+           "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
+           "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
+           "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
+           "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_setup",
+           "ksft_run", "ksft_exit",
+           "NetNS", "NetNSEnter",
+           "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
+           "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
+           "wait_port_listen", "wait_file",
+           "NetdevSim", "NetdevSimDev",
+           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
+           "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
+           "RtnlAddrFamily"]
-- 
2.51.0


