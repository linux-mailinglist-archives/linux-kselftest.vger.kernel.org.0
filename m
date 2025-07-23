Return-Path: <linux-kselftest+bounces-37894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50879B0FA74
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C450172DDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F522B5A5;
	Wed, 23 Jul 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNwev9Y4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4F1F582A;
	Wed, 23 Jul 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296465; cv=none; b=j68pOMUdmbcwTPioHgtP4wh1OqWthNvgp7tOOvutCsz8oTQ3El7xd5e9pe4V+KCwMvGGAX0OxcekpW2sErwQ4IeGy6nk3QACpnFJG6POv1gwKvU8r4e5D745MBzpckdFg4goi2Lb0jDflk03RELYk/4AgPIL0qc1v+g92v7+zEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296465; c=relaxed/simple;
	bh=xvDo4AKg/k44dPHBVj8HSdpuDyPR3cV7NoMSr1v2tNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkINVa/G8rcs3Aj9J7YRqgavR4ISau7i30k5owZ1GwgiQNUlTWqoDR8k4cUQffEj/8OHLP4/YXkVL24ja4kfq6tF4A/SzkmZzqA5br9Uw6MlZjmFW6fTg3JqRNyc5QabJXfUdVT/qJD83T2svJnjzLRgJEadnmBWZ/09sDtlVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNwev9Y4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8bbb605530so1064799276.0;
        Wed, 23 Jul 2025 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753296463; x=1753901263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hj0cme8ACgBBTTOBddIeLDrtmAh/6KnAxLE3cBGOuBE=;
        b=lNwev9Y4VaLEulcLnM4hHUNSNYmtJjezZPVCqx/C4OGS8fGlOGgbwk5d9BZvGz/Nia
         a0bv7SQBz6yUxRxim34mz5QZ6+KD9FrzKgT8w6KhqVVjnI/0VxqlOvxq6d/tbfgjjy7/
         PyaWP+e8EMT4eO3bpXxSAvpVmwrU0ATpuN17W2LoTT8Kp87nGTwV5RYSjPuIn8Cu5KvC
         bDpjgYJr+VgBX9xqkEL+O8YWwAf6KZe7ZkAikwTl/kLiQXpO03r+8BP2iMetHX+2+R8S
         k0ZVyQxXYbjv7abWBE6L8S5JOzYvSqkYpVj64MYz7JW5wc0wsMppUsWI/F+6Z3+1fiUP
         JUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296463; x=1753901263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj0cme8ACgBBTTOBddIeLDrtmAh/6KnAxLE3cBGOuBE=;
        b=WSXRSBqXzaQF+hRi0TsUrHAcnzbqBXzsciKhuaRAWSbSJR9s9GVpJGquKiXh6aPWvm
         G1VFuhjqPcFBOF7pn/8vsmPJWcqVfcHHwQ1p7rser6Cofc83d2PqVIMCCkrQHoZwsz/e
         oHw9/ksJctH3nfWrNRSRywYtc/lEM9YEAc5gByNeF3VH/XQhLmxD/4zleekhJlZEvLYd
         n2Nz2H94SZjUC7WLrd4xnBksfv+rFG1cMdUFULagB3UFzLbsEpYfFzJAmxyHEFg4dSVx
         xUBGDvnFJT0MVGcTvQQrSd+Y4SItfqV1OTvGPWMgxEGLXSq5KC48rYp0l5kgcnRBSQDE
         F0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWdPqGzlnZmk4f4KF0AAIdDbzm5v8xrna5645DVTBtCsfGo3fn2czbaiTjoX3qXwqBAmjwrMTh3@vger.kernel.org, AJvYcCWj/yr9M3JrD2qA2tb9xJgd1BktcOO5XWOhIe94OvVL1NQj4nEZv43IRRSltN4Y3zeU+IY0milseejM50rLI4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FkXhXUWrCAfmgR9g9fFPkuZePX4O4GLUPSt6KRSlpYp4CC55
	nAf4LL93LmtuGKbFKaWs/m5qBaJ2b75Yin6hAfPDoX/wqr5ei91l85rC
X-Gm-Gg: ASbGnctO2jA/iG6M4YuX0aAztsh/ERpx72tip/1FFUb8/C6xxsHBlfTai4ctr5cH5KG
	34KUcRWLdYcK1utE8sRV28XwH0wsYwyfLiKMhKr9kRGwP+KPwoYZ3lcFtZ/hnS4S4z+xt70dOFs
	NoMWsnC5Mui4lvqP1ftJaOU8nxJq2FiJrr2IbWAebCkTw3uVpzcU/Ji36Em8H4MG4zjJOOcgMdI
	kNX6m+gaKK1125gY2Z+ndY5LSquN/C5Zg1pCWg85gDd9LQ5sZPAyfQZGLG6r8JiLj1fZahECFrV
	k4/zFmgX0q60Yv51RjdO89PQeybCOboAJ3eq4mC/NtheyWWsb0wlPZ/t7EK3loVd2O7smg6Awxo
	FsuXg/3yd++w+1XAK/fE=
X-Google-Smtp-Source: AGHT+IGgXlK37A+PJgSBqYZ85nu4Ft/eoHAd9YIGDTIwh3dxd1/C6Iz28bbtSWWSxf4LTiKWFlIwhQ==
X-Received: by 2002:a05:6902:13c3:b0:e89:8d59:bf7b with SMTP id 3f1490d57ef6-e8dcae97277mr4388977276.16.1753296462814;
        Wed, 23 Jul 2025 11:47:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8dbcd41d37sm1206021276.15.2025.07.23.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:47:41 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/3] selftests: drv-net: tso: enable test cases based on hw_features
Date: Wed, 23 Jul 2025 11:47:36 -0700
Message-ID: <20250723184740.4075410-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723184740.4075410-1-daniel.zahka@gmail.com>
References: <20250723184740.4075410-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tso.py uses the active features at the time of test execution
as the set of available gso features to test. This means if a gso
feature is supported but toggled off at test start, the test will be
skipped with a "Device does not support {feature}" message.

Instead, we can enumerate the set of toggleable features by capturing
the driver's hw_features bitmap. To avoid configuration side-effects
from running the test, we also snapshot the wanted_features flag set
before making any feature changes, and then attempt to restore the
same set of wanted_features before test exit.

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/hw/tso.py | 52 ++++++++++++++-----
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index 3370827409aa..f8386e3d88cd 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -119,15 +119,30 @@ def build_tunnel(cfg, outer_ipver, tun_info):
     return remote_v4, remote_v6
 
 
+def restore_wanted_features(cfg):
+    features_cmd = ""
+    for feature in cfg.hw_features:
+        setting = "on" if feature in cfg.wanted_features else "off"
+        features_cmd += f" {feature} {setting}"
+    try:
+        ethtool(f"-K {cfg.ifname} {features_cmd}")
+    except Exception as e:
+        ksft_pr(f"WARNING: failure restoring wanted features: {e}")
+
+
 def test_builder(name, cfg, outer_ipver, feature, tun=None, inner_ipver=None):
     """Construct specific tests from the common template."""
     def f(cfg):
         cfg.require_ipver(outer_ipver)
+        defer(restore_wanted_features, cfg)
 
         if not cfg.have_stat_super_count and \
            not cfg.have_stat_wire_count:
             raise KsftSkipEx(f"Device does not support LSO queue stats")
 
+        if feature not in cfg.hw_features:
+            raise KsftSkipEx(f"Device does not support {feature}")
+
         ipver = outer_ipver
         if tun:
             remote_v4, remote_v6 = build_tunnel(cfg, ipver, tun)
@@ -138,12 +153,12 @@ def test_builder(name, cfg, outer_ipver, feature, tun=None, inner_ipver=None):
 
         tun_partial = tun and tun[1]
         # Tunnel which can silently fall back to gso-partial
-        has_gso_partial = tun and 'tx-gso-partial' in cfg.features
+        has_gso_partial = tun and 'tx-gso-partial' in cfg.hw_features
 
         # For TSO4 via partial we need mangleid
         if ipver == "4" and feature in cfg.partial_features:
             ksft_pr("Testing with mangleid enabled")
-            if 'tx-tcp-mangleid-segmentation' not in cfg.features:
+            if 'tx-tcp-mangleid-segmentation' not in cfg.hw_features:
                 ethtool(f"-K {cfg.ifname} tx-tcp-mangleid-segmentation on")
                 defer(ethtool, f"-K {cfg.ifname} tx-tcp-mangleid-segmentation off")
 
@@ -161,11 +176,8 @@ def test_builder(name, cfg, outer_ipver, feature, tun=None, inner_ipver=None):
                            should_lso=tun_partial)
 
         # Full feature enabled.
-        if feature in cfg.features:
-            ethtool(f"-K {cfg.ifname} {feature} on")
-            run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=True)
-        else:
-            raise KsftXfailEx(f"Device does not support {feature}")
+        ethtool(f"-K {cfg.ifname} {feature} on")
+        run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=True)
 
     f.__name__ = name + ((outer_ipver + "_") if tun else "") + "ipv" + inner_ipver
     return f
@@ -176,23 +188,39 @@ def query_nic_features(cfg) -> None:
     cfg.have_stat_super_count = False
     cfg.have_stat_wire_count = False
 
-    cfg.features = set()
     features = cfg.ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
-    for f in features["active"]["bits"]["bit"]:
-        cfg.features.add(f["name"])
+
+    cfg.wanted_features = set()
+    for f in features["wanted"]["bits"]["bit"]:
+        cfg.wanted_features.add(f["name"])
+
+    cfg.hw_features = set()
+    hw_all_features_cmd = ""
+    for f in features["hw"]["bits"]["bit"]:
+        if f.get("value", False):
+            feature = f["name"]
+            cfg.hw_features.add(feature)
+            hw_all_features_cmd += f" {feature} on"
+    try:
+        ethtool(f"-K {cfg.ifname} {hw_all_features_cmd}")
+    except Exception as e:
+        ksft_pr(f"WARNING: failure enabling all hw features: {e}")
+        ksft_pr("partial gso feature detection may be impacted")
 
     # Check which features are supported via GSO partial
     cfg.partial_features = set()
-    if 'tx-gso-partial' in cfg.features:
+    if 'tx-gso-partial' in cfg.hw_features:
         ethtool(f"-K {cfg.ifname} tx-gso-partial off")
 
         no_partial = set()
         features = cfg.ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
         for f in features["active"]["bits"]["bit"]:
             no_partial.add(f["name"])
-        cfg.partial_features = cfg.features - no_partial
+        cfg.partial_features = cfg.hw_features - no_partial
         ethtool(f"-K {cfg.ifname} tx-gso-partial on")
 
+    restore_wanted_features(cfg)
+
     stats = cfg.netnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)
     if stats:
         if 'tx-hw-gso-packets' in stats[0]:
-- 
2.47.1


