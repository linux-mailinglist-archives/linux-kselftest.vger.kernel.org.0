Return-Path: <linux-kselftest+bounces-32683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B2AB056D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E7A4C54D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64422424B;
	Thu,  8 May 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHgaC2GD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243315B0EF;
	Thu,  8 May 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740408; cv=none; b=ajIphBTaRrG4gjyeNU/f7ctPnvj2z25CEIMNfjDqjFFlgXWrdvDkpGPZwyUYRl5M5iWdPrJhjxCVeIAE+XiGodtuFtDS0UdNzuaEGpdmZyg/NtdeRwSPrn6aEFii8yJsRTxFS7hcWJvZjtqvGku5trJK+sDpvo0xVZH3Qqm7ivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740408; c=relaxed/simple;
	bh=mXxPbg862XN00UfOZl5DknDG9MUxUdfWuPXakfnxAHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgjfU5BdzUEKIO+zE84UMVl0ZKDThAljZnhMQKW8qV7vmGbbWBEJiwHPK/F0DsWFdlE/8C8ulp/U0tN03aB+L581E24eVLMaCAMx2O+AMNwuO5LQP7PcskuQ6B12ig9DwnQCyC3tXcA8O/K5rcHd/DI3ZRrWrsWCURet9MPoQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHgaC2GD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1EAC4CEE7;
	Thu,  8 May 2025 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746740408;
	bh=mXxPbg862XN00UfOZl5DknDG9MUxUdfWuPXakfnxAHs=;
	h=From:To:Cc:Subject:Date:From;
	b=EHgaC2GD7tDCIRJnD4cZWfqQbwfBdXBSqHsfZnRTA3/WPvNkH9SrNQx7ewIk7o6sm
	 fqx5N9n3YR909kvcM9eHLJQBvw2w8ouODS+sQldH2oOqx6sCJI9F0hAQ6Cuad1Sbvl
	 ti8hbGLY2s84LLMchnQKRVixPu4PxY5e/X0tuN5ForUSs0lODvklPop5W2cDU+hipq
	 bTSrfRyi7ij//QjhZlAZsqw5f90QkcgvTqNSxfToLHMTW5DPiwVn1wSi7sdkzwHPwK
	 yM+KpU5ExcPrK6lTAt1tr/+dd4tGizLdlDllFCE4jW7P4X1eVLtPWPd5XcagOQtjVl
	 5r5Iqq2OVDdLw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: ping: make sure the ping test restores checksum offload
Date: Thu,  8 May 2025 14:40:05 -0700
Message-ID: <20250508214005.1518013-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ping test flips checksum offload on and off.
Make sure the original value is restored if test fails.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/ping.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
index af8df2313a3b..e0f114612c1a 100755
--- a/tools/testing/selftests/drivers/net/ping.py
+++ b/tools/testing/selftests/drivers/net/ping.py
@@ -50,6 +50,16 @@ no_sleep=False
         cmd(f"echo {test_string} | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
     ksft_eq(nc.stdout.strip(), test_string)
 
+def _schedule_checksum_reset(cfg, netnl) -> None:
+    features = ethtool(f"-k {cfg.ifname}", json=True)
+    setting = ""
+    for side in ["tx", "rx"]:
+        f = features[0][side + "-checksumming"]
+        if not f["fixed"]:
+            setting += " " + side
+            setting += " " + ("on" if f["requested"] or f["active"] else "off")
+    defer(ethtool, f" -K {cfg.ifname} " + setting)
+
 def _set_offload_checksum(cfg, netnl, on) -> None:
     try:
         ethtool(f" -K {cfg.ifname} rx {on} tx {on} ")
@@ -139,6 +149,7 @@ no_sleep=False
 def test_default_v4(cfg, netnl) -> None:
     cfg.require_ipver("4")
 
+    _schedule_checksum_reset(cfg, netnl)
     _set_offload_checksum(cfg, netnl, "off")
     _test_v4(cfg)
     _test_tcp(cfg)
@@ -149,6 +160,7 @@ no_sleep=False
 def test_default_v6(cfg, netnl) -> None:
     cfg.require_ipver("6")
 
+    _schedule_checksum_reset(cfg, netnl)
     _set_offload_checksum(cfg, netnl, "off")
     _test_v6(cfg)
     _test_tcp(cfg)
@@ -157,6 +169,7 @@ no_sleep=False
     _test_tcp(cfg)
 
 def test_xdp_generic_sb(cfg, netnl) -> None:
+    _schedule_checksum_reset(cfg, netnl)
     _set_xdp_generic_sb_on(cfg)
     _set_offload_checksum(cfg, netnl, "off")
     _test_v4(cfg)
@@ -168,6 +181,7 @@ no_sleep=False
     _test_tcp(cfg)
 
 def test_xdp_generic_mb(cfg, netnl) -> None:
+    _schedule_checksum_reset(cfg, netnl)
     _set_xdp_generic_mb_on(cfg)
     _set_offload_checksum(cfg, netnl, "off")
     _test_v4(cfg)
@@ -179,6 +193,7 @@ no_sleep=False
     _test_tcp(cfg)
 
 def test_xdp_native_sb(cfg, netnl) -> None:
+    _schedule_checksum_reset(cfg, netnl)
     _set_xdp_native_sb_on(cfg)
     _set_offload_checksum(cfg, netnl, "off")
     _test_v4(cfg)
@@ -190,6 +205,7 @@ no_sleep=False
     _test_tcp(cfg)
 
 def test_xdp_native_mb(cfg, netnl) -> None:
+    _schedule_checksum_reset(cfg, netnl)
     _set_xdp_native_mb_on(cfg)
     _set_offload_checksum(cfg, netnl, "off")
     _test_v4(cfg)
-- 
2.49.0


