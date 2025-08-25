Return-Path: <linux-kselftest+bounces-39867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D6B34984
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF23A5259
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B9305E00;
	Mon, 25 Aug 2025 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLfip6ot"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D552FCBFF;
	Mon, 25 Aug 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144791; cv=none; b=BqoufWllwD8vOELT/ZP3azgF/5lqvD+Qi8tnhgJatf3Zjef+589EBf1/WvI7kOAfc+Tj8FAZwRpaWx5Gd8BKUeaEG0mkP/j/YyYIvIat2JtBGZ6Y70oAwjemLztHEcWyQaFmGHGptUxhbWPvFlXUJp3kV/C7Vi9ISpcQ+yte1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144791; c=relaxed/simple;
	bh=cgdUKiDYO0SJj5WsCQxEnKBO+Z8SG/sFL/42Ma9eE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYvG9/QfFBAd7lZAFvfmwlQQw9m1EqBHcxyepGgeyvL98EuzN+LbXPmbS/mkpH9Ff+/8n5kElBrRwgzMLdVV5beu/kyz/9IENdpy3VHnkZv2GQxioOx7MeTHXl4zkIhFpZj8HCiOBm0mbxLfSV+K8uoGFH+WrpJ1AvyYWHuxi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLfip6ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E1C4CEED;
	Mon, 25 Aug 2025 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144790;
	bh=cgdUKiDYO0SJj5WsCQxEnKBO+Z8SG/sFL/42Ma9eE8c=;
	h=From:To:Cc:Subject:Date:From;
	b=mLfip6ot7EjidE/AaKRhwQoMoOLem2UvcR9r7hLej+FNqaSuFoX+bwE2gzcb/8ESV
	 P2XZGIgfu0+WViVQ5xaWViRijeU2QrrYqiFSZis1QSu7ROx7ND54gdEye4gYMdQlLG
	 GwNVItUQbSD5/o7GC+T+cC25bFvpKnBNQOYeTccp40FubyzC0OZZU8hZ3LGeBsNoq1
	 PeKq1VhgPMqe5wMYBQWvHao36lRzNnDif1cnvpkrLokYqTGWqXuKBHMIm82ixHx5DD
	 d08C96WgD5O0DFxe7SxOB1owddLrOCb3cUhUpLZWJZa+kwl+JN92IsxSFx7zln+q6l
	 2Q3oRGs/1rY3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2] selftests: drv-net: hds: restore hds settings
Date: Mon, 25 Aug 2025 10:59:39 -0700
Message-ID: <20250825175939.2249165-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test currently modifies the HDS settings and doesn't restore them.
This may cause subsequent tests to fail (or pass when they should not).
Add defer()ed reset handling.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix type hints for older Python
v1: https://lore.kernel.org/20250822195735.1673744-1-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/hds.py | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 7c90a040ce45..a2011474e625 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -3,6 +3,7 @@
 
 import errno
 import os
+from typing import Union
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
 from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
@@ -58,7 +59,39 @@ from lib.py import defer, ethtool, ip, random
     if 'hds-thresh' not in rings:
         raise KsftSkipEx('hds-thresh not supported by device')
 
+
+def _hds_reset(cfg, netnl, rings) -> None:
+    cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+
+    arg = {'header': {'dev-index': cfg.ifindex}}
+    if cur.get('tcp-data-split') != rings.get('tcp-data-split'):
+        # Try to reset to "unknown" first, we don't know if the setting
+        # was the default or user chose it. Default seems more likely.
+        arg['tcp-data-split'] = "unknown"
+        netnl.rings_set(arg)
+        cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        if cur['tcp-data-split'] == rings['tcp-data-split']:
+            del arg['tcp-data-split']
+        else:
+            # Try the explicit setting
+            arg['tcp-data-split'] = rings['tcp-data-split']
+    if cur.get('hds-thresh') != rings.get('hds-thresh'):
+        arg['hds-thresh'] = rings['hds-thresh']
+    if len(arg) > 1:
+        netnl.rings_set(arg)
+
+
+def _defer_reset_hds(cfg, netnl) -> Union[dict, None]:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        if 'hds-thresh' in rings or 'tcp-data-split' in rings:
+            defer(_hds_reset, cfg, netnl, rings)
+    except NlError as e:
+        pass
+
+
 def set_hds_enable(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'enabled'})
     except NlError as e:
@@ -76,6 +109,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq('enabled', rings['tcp-data-split'])
 
 def set_hds_disable(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'disabled'})
     except NlError as e:
@@ -93,6 +127,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq('disabled', rings['tcp-data-split'])
 
 def set_hds_thresh_zero(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': 0})
     except NlError as e:
@@ -110,6 +145,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq(0, rings['hds-thresh'])
 
 def set_hds_thresh_random(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -140,6 +176,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq(hds_thresh, rings['hds-thresh'])
 
 def set_hds_thresh_max(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -157,6 +194,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq(rings['hds-thresh'], rings['hds-thresh-max'])
 
 def set_hds_thresh_gt(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -178,6 +216,7 @@ from lib.py import defer, ethtool, ip, random
     """
     mode = _get_hds_mode(cfg, netnl)
     if mode == 'enabled':
+        _defer_reset_hds(cfg, netnl)
         netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                          'tcp-data-split': 'unknown'})
 
-- 
2.51.0


