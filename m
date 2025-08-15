Return-Path: <linux-kselftest+bounces-39026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AC9B274C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 03:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B657B648B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665D81ACA;
	Fri, 15 Aug 2025 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvXOk52C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF056448;
	Fri, 15 Aug 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221601; cv=none; b=sTX6tuF70rrKx10FM261pbJVp/5HOPAaWtWMKNS6hMQcHNiXVKpt12K48MvaNUwZ637+APCtvSg6iZdJxrENKt6esqgq9O5rnczUHNnKJJ+2cOyJn/8ZVC0z2S8xvtCIq9wqfvg8/CPA3BHTJhwPSaYajj4VUYwNyFecB8OmW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221601; c=relaxed/simple;
	bh=wTkw/C7KITFBXAterEc6KAcdG/ZTiEKbLkSeQWRZ+UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cr3Pt3Ecxxv7tKsxVTD2nYvZiEzYSjMy/kLHWflZX6y9laVORx+moeQjUS0npIUd/TsQ4lDqj1y96RNaBkpTsrqv3gAekdnYi1oB8f8XD3G1mvOLwu3dxN1pVKp3FgVkVNi6KtER6tdMRNTy4cEdEtEaJTNKiLlboB3ucgXYuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvXOk52C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D64C4CEED;
	Fri, 15 Aug 2025 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755221597;
	bh=wTkw/C7KITFBXAterEc6KAcdG/ZTiEKbLkSeQWRZ+UU=;
	h=From:To:Cc:Subject:Date:From;
	b=OvXOk52C5MbcDfWCMqp1eCrKFRp3tM0yDlWJy/hNB8DxyZke3i4WtlkHRTlzMNd50
	 xmz7Im47cT17Z1d1H8Ep+sbcqUWV1MRk9ssMO0JiJNoDKsvpT26tURDsFRQ1Om8Ril
	 0gUZpmikFXFaJPCuuPyeOxV7dHNffqf2dvZVAuKPMo8knP5pqUqzdDzk4hfIumSWYr
	 CKqbrhzt+oPTwEySqTPyFjjZx+S47l7v8+EnkhPw7g+uOIbIUx2tQ9fIhtGxwcEFw0
	 en4Cl/t2Ijs7J9Jdp457HjIjtfrOeQNBQr2AW4PNq7nJi9p6mpvSG6PCaouo90XMS9
	 UMPC2FV+6dauQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	joe@dama.to,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: test the napi init state
Date: Thu, 14 Aug 2025 18:33:14 -0700
Message-ID: <20250815013314.2237512-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that threaded state (in the persistent NAPI config) gets updated
even when NAPI with given ID is not allocated at the time.

This test is validating commit ccba9f6baa90 ("net: update NAPI threaded
config even for disabled NAPIs").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Somehow I missed sending this out with the fix series.

CC: joe@dama.to
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/napi_threaded.py    | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/napi_threaded.py b/tools/testing/selftests/drivers/net/napi_threaded.py
index 9699a100a87d..ed66efa481b0 100755
--- a/tools/testing/selftests/drivers/net/napi_threaded.py
+++ b/tools/testing/selftests/drivers/net/napi_threaded.py
@@ -38,6 +38,34 @@ from lib.py import cmd, defer, ethtool
     return combined
 
 
+def napi_init(cfg, nl) -> None:
+    """
+    Test that threaded state (in the persistent NAPI config) gets updated
+    even when NAPI with given ID is not allocated at the time.
+    """
+
+    qcnt = _setup_deferred_cleanup(cfg)
+
+    _set_threaded_state(cfg, 1)
+    cmd(f"ethtool -L {cfg.ifname} combined 1")
+    _set_threaded_state(cfg, 0)
+    cmd(f"ethtool -L {cfg.ifname} combined {qcnt}")
+
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    for napi in napis:
+        ksft_eq(napi['threaded'], 'disabled')
+        ksft_eq(napi.get('pid'), None)
+
+    cmd(f"ethtool -L {cfg.ifname} combined 1")
+    _set_threaded_state(cfg, 1)
+    cmd(f"ethtool -L {cfg.ifname} combined {qcnt}")
+
+    napis = nl.napi_get({'ifindex': cfg.ifindex}, dump=True)
+    for napi in napis:
+        ksft_eq(napi['threaded'], 'enabled')
+        ksft_ne(napi.get('pid'), None)
+
+
 def enable_dev_threaded_disable_napi_threaded(cfg, nl) -> None:
     """
     Test that when napi threaded is enabled at device level and
@@ -103,7 +131,8 @@ from lib.py import cmd, defer, ethtool
     """ Ksft boiler plate main """
 
     with NetDrvEnv(__file__, queue_count=2) as cfg:
-        ksft_run([change_num_queues,
+        ksft_run([napi_init,
+                  change_num_queues,
                   enable_dev_threaded_disable_napi_threaded],
                  args=(cfg, NetdevFamily()))
     ksft_exit()
-- 
2.50.1


