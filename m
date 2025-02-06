Return-Path: <linux-kselftest+bounces-25947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E3A2B6D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 00:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35E27A374C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 23:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E823AE7F;
	Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl8UCf1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83923AE71;
	Thu,  6 Feb 2025 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886021; cv=none; b=Z+ceLYskIqNIzZVK/dRDmhH7ybGdq/s9uN15mi2vAfCRIW2bOq/pIHGiS++Ue+I/EU5SP+DgVZ7ICTWeeij4NU5FI65IQooIODAVGLZGafFOqTxmZpPydRdJc6hreRCk22MfrN5KYVoWuNLNK/KSiBdjcMahSNeBCuD2F6mL3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886021; c=relaxed/simple;
	bh=Z1XzSNBE5JIoMwyBvoYbIDkrxkB8M2fI8zrxXs2nLnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuljrcJXj7QZ3o6mo5CyJCrZYjMN1JXE7POdVDz4t44ZOOEbn9/76RoZ+NMnAy/Ah3swO8R/NmOXKW8y3rDtDeNzWPJ0EqtdvvU+T1R5Fu+ohJEV8tdURTd2NYW/BU/oN+SIwIKrnli4I5W62paYSn5P7ODNjV5FEX/nRD3qy7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl8UCf1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C502BC4CEDD;
	Thu,  6 Feb 2025 23:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886020;
	bh=Z1XzSNBE5JIoMwyBvoYbIDkrxkB8M2fI8zrxXs2nLnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fl8UCf1CNVO+n6ySh0fFax+BpXfoW/oz1/0YSWau4RBHV43ZoK288/v630Nq4x5MY
	 T1Tr7eVXyXuMApRdyAG5VYGfV5xwZQNIZrwhJHG5NVIubOJBWIOqVN6zMJCTVNrUn2
	 qjYtNOxjUrcEtIovgTU60yZXPsR3BRKNUR7dYPuCVaZeVfZQ5HmTGD4s8pPbVlfO94
	 0Rbjb5aydHLzd0ZWpeVzdPvF+oElEFLnm95wOzU71ze2st9b7o2qAgMscZw5YBeTz/
	 XR6uE3hIAciZyl04s+0tXW3bYk1yEmGUZWfrry75BFG5O2K4/Y+DJCeJ5ralV/o7PU
	 05xYz61s8Y4RA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/7] selftests: net-drv: test adding flow rule to invalid RSS context
Date: Thu,  6 Feb 2025 15:53:29 -0800
Message-ID: <20250206235334.1425329-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that adding Rx flow steering rules pointing to an RSS
context which does not exist is prevented.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 319aaa004c40..7e5f4602e6b3 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -4,7 +4,8 @@
 import datetime
 import random
 import re
-from lib.py import ksft_run, ksft_pr, ksft_exit, ksft_eq, ksft_ne, ksft_ge, ksft_lt, ksft_true
+from lib.py import ksft_run, ksft_pr, ksft_exit
+from lib.py import ksft_eq, ksft_ne, ksft_ge, ksft_in, ksft_lt, ksft_true, ksft_raises
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx, KsftFailEx
@@ -649,6 +650,29 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     test_rss_context_overlap(cfg, True)
 
 
+def test_flow_add_context_missing(cfg):
+    """
+    Test that we are not allowed to add a rule pointing to an RSS context
+    which was never created.
+    """
+
+    require_ntuple(cfg)
+
+    # Find a context which doesn't exist
+    for ctx_id in range(1, 100):
+        try:
+            get_rss(cfg, context=ctx_id)
+        except CmdExitFailure:
+            break
+
+    with ksft_raises(CmdExitFailure) as cm:
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port 1234 context {ctx_id}"
+        ntuple_id = ethtool_create(cfg, "-N", flow)
+        ethtool(f"-N {cfg.ifname} delete {ntuple_id}")
+    if cm.exception:
+        ksft_in('Invalid argument', cm.exception.cmd.stderr)
+
+
 def test_delete_rss_context_busy(cfg):
     """
     Test that deletion returns -EBUSY when an rss context is being used
@@ -726,6 +750,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
                   test_rss_context_dump, test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
+                  test_flow_add_context_missing,
                   test_delete_rss_context_busy, test_rss_ntuple_addition],
                  args=(cfg, ))
     ksft_exit()
-- 
2.48.1


