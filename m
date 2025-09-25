Return-Path: <linux-kselftest+bounces-42425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54389BA1805
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CC2563A03
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25232274A;
	Thu, 25 Sep 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEGWFikO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698D322A3F
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835022; cv=none; b=aKvQM3SX9lDzcbxrMt+QiOC+t1e4FqORBuIBC/i5UZdZuI0rv7rKvfdsu2TFaAMTIvILteiUD7sp5bWhG1w+pkJx7AJwcMs5KqnHsGQKK0faPNr2bT7jbbMnxMig6U82Hl1Ski+s2tfOAcNhxCGLfGTuktUpjqwR+2oM+MVPq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835022; c=relaxed/simple;
	bh=W0zrtGCRv1JKDtb4hNj0Ew9zhUISoAAsd0ngYP0rDks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+ecDIqgZkFa2nJQl+fILFXX0dUPrn/f4/rgQFzbj4EyKektPzKVpWICfCMRctRd3ouWbX689Ng1w5i+XtzxOlzeEod/gGkk/hW0gNUYylkVROcVa9KKawoRusivBWd8pSes+YVTJyPw70i3f73FJ1UFWNImUTOylqfSa0Vmp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEGWFikO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60110772so13249967b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835019; x=1759439819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dApBtpQ38j5H0cAjXKBJNlLXE3pUCuEyhNWBe3vyq94=;
        b=KEGWFikOmGYSP+bbLIGZWRtjQJ2m6O4lRhCj3jStCYm+g4tToNtn/mU5ccoJUSLIiz
         2YGJlCZzRMgJI60XaHhB53gz3Gz3vi+OVuuK/zLUki2Hq/2SuJGG5xepDV/DS/kHXxO1
         ay9RZUOslsE2Tp3v4qBBn2nJVgzZwbTKuFZp4gPB543mOMf2abd6dSWQJWjNtBpy+TS+
         X9P9XvsqBQ1bV1JTz0Q6NTrJwepUGfhKWxpAmMgRKMtV+DnKsw34ispDNYXAR/q21NLv
         Z4/8S2aNnsafOQ3Ack3XJ4BPZWCUoJ3GVlJTH9KNu6sBipkCxXMtOvxc37LL2ANnEe/o
         bzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835019; x=1759439819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dApBtpQ38j5H0cAjXKBJNlLXE3pUCuEyhNWBe3vyq94=;
        b=k1yDAS6z5izaaSKEpGgdi+bYyPf7lAkRQ+gVsUBtvLHWWHOLkylh2B8b8DYYwVcafn
         CgIyo1m+Z0v8s0sJRAxqFYmnh2a7qnpEq/sVRWKlkjKVhP7oJDVdKjtGOFtZCUKJm4ky
         vBdYDtiG6TQh29oGGpGC6qG9zc1wurFB2jt9PYVMZgK1VT/LPi7PHxaXB4ZOETH0ZrvT
         yEyyKmQ86hi72k20tblsmucuMV8mCiy8iOh75ErnkkHLfSxK9xD57RBlOzMwlWvA/w1+
         yi8ORbD6aQW98z4FbR+anY/pihRyEDQ3r4slSLC0PNXAa1v9ASUCgkH2Xmum7N2G/tBj
         bTWA==
X-Forwarded-Encrypted: i=1; AJvYcCVk0tjSpHMYlTPk/78zvpuyETZszNsTTazn6k2UZqScoypcOHeS2rp+rqteStcoUxXr32Mwst0Wgb6oPvy73SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PiSXDLQa7xJWpo6t8Bqw+PGM4x7FmI8jToCk+vZeSFHDngR2
	BIyWz54cwyZJtrSaYTqLVbV4uaig1gkJYAaOVlxzu5FngSyHlzoXN5S1
X-Gm-Gg: ASbGncvoewcumQNrPd2zQKmMJGWYZTQg2IOouHS0wF1FCeDdSgjtNOL8DkDZ/8KAYTJ
	gm6UiSDyaDjJGRv0F4Y3EHq+tJ5f5VRW3z2R9z8/Mzvm4a+NdPs4h4fNXUjlhfxZOypBOlO3CHQ
	myMFxZ+mr0C+hF3V867VpSXRgJR91+8mGd8JOnOnXBjTIU9PVqk+//xlhD/gAM6W5JdYiqLYQ7a
	hJk9RT78TIeQ34x0g+ySTAC/N811lB1XrzPsJeQElsxtrejkL6lf13bRgg+qg1v2JAFotKG6iLj
	wr5WfZBYjc1SI9tO5RJewKGqOnAtaYTSc05wyqCOrJhcOw4ey4PBT1tSGCt4ajFh1q10g9pLlJx
	RvLDNcPpkl2Ao+R7ZXShW
X-Google-Smtp-Source: AGHT+IEJ1AFHr+6bBlVzr8CLiHkEL2bqG/pjqIeLOMVV3TNKpaPCF/1iEo9aRz547n4B55jNjCD5NQ==
X-Received: by 2002:a05:690c:708c:b0:717:ca51:d781 with SMTP id 00721157ae682-763fbe14bb7mr49967787b3.17.1758835019352;
        Thu, 25 Sep 2025 14:16:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d955sm108147d50.30.2025.09.25.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:58 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 8/8] selftests: drv-net: psp: add tests for destroying devices
Date: Thu, 25 Sep 2025 14:16:44 -0700
Message-ID: <20250925211647.3450332-9-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add tests for making sure device can disappear while associations
exist. This is netdevsim-only since destroying real devices is
more tricky.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/hw/lib/py/__init__.py         |  2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 .../selftests/drivers/net/lib/py/env.py       |  5 ++
 tools/testing/selftests/drivers/net/psp.py    | 59 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/ksft.py    |  5 ++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1c631f3c81f1..0ceb297e7757 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -22,7 +22,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
     from net.lib.py import NetNSEnter
     from drivers.net.lib.py import GenerateTraffic
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 8a795eeb5051..2a645415c4ca 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -21,7 +21,7 @@ try:
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
-        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt
+        ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `net` library from kernel sources")
     ksft_pr(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index c1f3b608c6d8..fc12e20af880 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -7,6 +7,7 @@ from lib.py import KsftSkipEx, KsftXfailEx
 from lib.py import ksft_setup, wait_file
 from lib.py import cmd, ethtool, ip, CmdExitFailure
 from lib.py import NetNS, NetdevSimDev
+from lib.py import KsftXfailEx
 from .remote import Remote
 
 
@@ -245,6 +246,10 @@ class NetDrvEpEnv(NetDrvEnvBase):
         if not self.addr_v[ipver] or not self.remote_addr_v[ipver]:
             raise KsftSkipEx(f"Test requires IPv{ipver} connectivity")
 
+    def require_nsim(self):
+        if self._ns is None:
+            raise KsftXfailEx("Test only works on netdevsim")
+
     def _require_cmd(self, comm, key, host=None):
         cached = self._required_cmd.get(comm, {})
         if cached.get(key) is None:
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 3eed986e587e..f32f3ffe440d 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -10,7 +10,7 @@ import termios
 import time
 
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises, KsftSkipEx
+from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises, ksft_not_none, KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
 
@@ -449,6 +449,61 @@ def data_stale_key(cfg):
         _close_psp_conn(cfg, s)
 
 
+def __nsim_psp_rereg(cfg):
+    # The PSP dev ID will change, remember what was there before
+    before = set([x['id'] for x in cfg.pspnl.dev_get({}, dump=True)])
+
+    cfg._ns.nsims[0].dfs_write('psp_rereg', '1')
+
+    after = set([x['id'] for x in cfg.pspnl.dev_get({}, dump=True)])
+
+    new_devs = list(after - before)
+    ksft_eq(len(new_devs), 1)
+    cfg.psp_dev_id = list(after - before)[0]
+
+
+def removal_device_rx(cfg):
+    """ Test removing a netdev / PSD with active Rx assoc """
+
+    # We could technically devlink reload real devices, too
+    # but that kills the control socket. So test this on
+    # netdevsim only for now
+    cfg.require_nsim()
+
+    s = _make_clr_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        ksft_not_none(rx_assoc)
+
+        __nsim_psp_rereg(cfg)
+    finally:
+        _close_conn(cfg, s)
+
+
+def removal_device_bi(cfg):
+    """ Test removing a netdev / PSD with active Rx/Tx assoc """
+
+    # We could technically devlink reload real devices, too
+    # but that kills the control socket. So test this on
+    # netdevsim only for now
+    cfg.require_nsim()
+
+    s = _make_clr_conn(cfg)
+    try:
+        rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": s.fileno()})
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": 0,
+                            "tx-key": rx_assoc['rx-key'],
+                            "sock-fd": s.fileno()})
+        __nsim_psp_rereg(cfg)
+    finally:
+        _close_conn(cfg, s)
+
+
 def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
@@ -512,7 +567,7 @@ def main() -> None:
 
                 if cfg.psp_dev_id is not None:
                     ksft_run(cases=cases, globs=globals(),
-                             case_pfx={"dev_", "data_", "assoc_"},
+                             case_pfx={"dev_", "data_", "assoc_", "removal_"},
                              args=(cfg, ))
                 else:
                     ksft_pr("No PSP device found, skipping all tests")
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 72cddd6abae8..83b1574f7719 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -72,6 +72,11 @@ def ksft_true(a, comment=""):
         _fail("Check failed", a, "does not eval to True", comment)
 
 
+def ksft_not_none(a, comment=""):
+    if a is None:
+        _fail("Check failed", a, "is None", comment)
+
+
 def ksft_in(a, b, comment=""):
     if a not in b:
         _fail("Check failed", a, "not in", b, comment)
-- 
2.47.3


