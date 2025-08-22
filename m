Return-Path: <linux-kselftest+bounces-39723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B6B32343
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3151D616CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AA2D661D;
	Fri, 22 Aug 2025 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs+NaeED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE7298CA2;
	Fri, 22 Aug 2025 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892658; cv=none; b=YjNAIf5SNo/7w5lJkvDVKzpvlp0N+fmThuLrlWYmEzaPsT5BTbqc+WX3U+6pIGtH9EDjEXSC9EzkIbN/KQxyku08RMWt8XsVRvbdcTOkD0BANBI3FRYJkm7apn1W3mI2T6BJ+Z1qO/5A+d7ldWe6A8wdseuw+3oO7pfhK5uDDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892658; c=relaxed/simple;
	bh=rDgSkITQIHr2CTJ/SrTmZzQuxO9787OxhZbgsSwFaMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbEisdsdd/pbr4HDw2CjNlMpYNCyVE5L2+wspwS/4MOfAhN3B6Wql479Xolio6naCY1QmQ9Po4V31FCJda7XUoG1mVrun4frjhxSvLsGpJhm5qOa/Tt+mVDuxt1oO72WfitDLVNQIP3JZ2IL9wUlKl+Zk6RAzLkgIlvqkytMG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs+NaeED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26EC4CEED;
	Fri, 22 Aug 2025 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892658;
	bh=rDgSkITQIHr2CTJ/SrTmZzQuxO9787OxhZbgsSwFaMM=;
	h=From:To:Cc:Subject:Date:From;
	b=cs+NaeEDDonD8ijdCZ2qTqbqbGsDiDGE4OrvbHSM0dkuCJbpd2e2DOMoijmBg9Bb6
	 z+3ZL5HgRiGKJSH24cyBsTAbHCdLDy1X9zRPNoKtqxhleXS4yYb3SuLAXFxWZoN5Zd
	 fSx7rQp7z7oFZXwMKfBKT/6kieK+VlMPQPeH3AjQwE6/qyY206wXeAajS8G5J/Ff4D
	 ZijvMV8FwnNlSRY244JR+tBiyUrwqJ8zu4SBtkCIX7X6ZBSGQkiVgxnpm74gdF5Rcb
	 z/LtC88hSFHKJkmAHM0/gITtRzKGnhLvzu9P2q+jonGnyRtf5dn/X8dsmCygxsjOT6
	 dMtFw97l+Zvug==
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
Subject: [PATCH net-next] selftests: drv-net: hds: restore hds settings
Date: Fri, 22 Aug 2025 12:57:35 -0700
Message-ID: <20250822195735.1673744-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
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
 tools/testing/selftests/drivers/net/hds.py | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 7c90a040ce45..abad81a88ba9 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -58,7 +58,39 @@ from lib.py import defer, ethtool, ip, random
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
+def _defer_reset_hds(cfg, netnl) -> dict | None:
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
@@ -76,6 +108,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq('enabled', rings['tcp-data-split'])
 
 def set_hds_disable(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'disabled'})
     except NlError as e:
@@ -93,6 +126,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq('disabled', rings['tcp-data-split'])
 
 def set_hds_thresh_zero(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': 0})
     except NlError as e:
@@ -110,6 +144,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq(0, rings['hds-thresh'])
 
 def set_hds_thresh_random(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -140,6 +175,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq(hds_thresh, rings['hds-thresh'])
 
 def set_hds_thresh_max(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -157,6 +193,7 @@ from lib.py import defer, ethtool, ip, random
     ksft_eq(rings['hds-thresh'], rings['hds-thresh-max'])
 
 def set_hds_thresh_gt(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -178,6 +215,7 @@ from lib.py import defer, ethtool, ip, random
     """
     mode = _get_hds_mode(cfg, netnl)
     if mode == 'enabled':
+        _defer_reset_hds(cfg, netnl)
         netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                          'tcp-data-split': 'unknown'})
 
-- 
2.50.1


