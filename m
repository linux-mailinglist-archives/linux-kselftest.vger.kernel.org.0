Return-Path: <linux-kselftest+bounces-36777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62194AFDA87
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1355868C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F125394B;
	Tue,  8 Jul 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVlTYJc9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC338256C71;
	Tue,  8 Jul 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012412; cv=none; b=jfchdO2Xvi+mYAq3FHsSstPFI0fZdiFea71pAmrX+D6OXLdIWp64niF5kKmvw/qSY6WgackV6J1OeOKb6FltReIdbhwlAPc8Fr3RbXddT79fYQKq8JxSmZqGJ3u5aCqfMCQSy4XGujJ1II7PwmC3kOkYtCQkHuh70EL81zMr1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012412; c=relaxed/simple;
	bh=0DCSh97tlsCNy2I2ppkjAiABuMiU4rgf/sYDZDRotrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5eXpynldLZyND+YbrPL2qmrIybGJDQ6G1kfffzpXH3i5t1951XJAt3rAgxmLcYR4S31mAe4Kz9uSK2FSdfBsOlXLG9+73NWoDmnFTJR1htAdY20zRWmdeSdelrCOqIdoeBD5ZvgmBfLRfIc+ZyVgnayfKZejTeo0epKimwEUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVlTYJc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31EBC4CEF7;
	Tue,  8 Jul 2025 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012412;
	bh=0DCSh97tlsCNy2I2ppkjAiABuMiU4rgf/sYDZDRotrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVlTYJc98J8WCKV0nyZRbLytsLGIDM/MbyWQZL8GB4HUzg7RdEnMj8kygQfuuUr47
	 Q0CXrBIqhzlZWU6sKiV0a2zWSAA2Ce2B7aDEdwWJ669md1XHbZZFHkD3ydB9xiHp2q
	 kfX/WMXY9jvsc5nJwB+SgrCxy614YOhaLMTRwe/MvtLIcbx4bLESp+gc55fSNxTCsl
	 bSxdl61HvD7edt+jlG7hMzS/z5Zx4kCb2a/oRBLVWzrGhIwLFCftGl9lNQwWFDxWmA
	 +rCHeviXYDOClzq7UElg5GMQqneemAHJ/mzQq0RygNnN/ZvXEvwIL3dk055y4hbHx+
	 xIkfuIgyK0tJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] selftests: drv-net: test RSS header field configuration
Date: Tue,  8 Jul 2025 15:06:40 -0700
Message-ID: <20250708220640.2738464-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708220640.2738464-1-kuba@kernel.org>
References: <20250708220640.2738464-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test reading RXFH fields over IOCTL and netlink.

  # ./tools/testing/selftests/drivers/net/hw/rss_api.py
  TAP version 13
  1..3
  ok 1 rss_api.test_rxfh_indir_ntf
  ok 2 rss_api.test_rxfh_indir_ctx_ntf
  ok 3 rss_api.test_rxfh_fields
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_api.py       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index db0f723a674b..6ae908bed1a4 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -20,6 +20,38 @@ from lib.py import NetDrvEnv
     return int(output.split()[-1])
 
 
+def _ethtool_get_cfg(cfg, fl_type, to_nl=False):
+    descr = ethtool(f"-n {cfg.ifname} rx-flow-hash {fl_type}").stdout
+
+    if to_nl:
+        converter = {
+            "IP SA": "ip-src",
+            "IP DA": "ip-dst",
+            "L4 bytes 0 & 1 [TCP/UDP src port]": "l4-b-0-1",
+            "L4 bytes 2 & 3 [TCP/UDP dst port]": "l4-b-2-3",
+        }
+
+        ret = set()
+    else:
+        converter = {
+            "IP SA": "s",
+            "IP DA": "d",
+            "L3 proto": "t",
+            "L4 bytes 0 & 1 [TCP/UDP src port]": "f",
+            "L4 bytes 2 & 3 [TCP/UDP dst port]": "n",
+        }
+
+        ret = ""
+
+    for line in descr.split("\n")[1:-2]:
+        # if this raises we probably need to add more keys to converter above
+        if to_nl:
+            ret.add(converter[line])
+        else:
+            ret += converter[line]
+    return ret
+
+
 def test_rxfh_indir_ntf(cfg):
     """
     Check that Netlink notifications are generated when RSS indirection
@@ -77,6 +109,21 @@ from lib.py import NetDrvEnv
     ksft_eq(set(ntf["msg"]["indir"]), {1})
 
 
+def test_rxfh_fields(cfg):
+    """
+    Test reading Rx Flow Hash over Netlink.
+    """
+
+    flow_types = ["tcp4", "tcp6", "udp4", "udp6"]
+    ethnl = EthtoolFamily()
+
+    cfg_nl = ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    for fl_type in flow_types:
+        one = _ethtool_get_cfg(cfg, fl_type, to_nl=True)
+        ksft_eq(one, cfg_nl["flow-hash"][fl_type],
+                comment="Config for " + fl_type)
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
-- 
2.50.0


