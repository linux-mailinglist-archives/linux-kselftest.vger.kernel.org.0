Return-Path: <linux-kselftest+bounces-40494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30344B3ED66
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C7A204DDD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD72DF153;
	Mon,  1 Sep 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpCxWf2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308EF1096F;
	Mon,  1 Sep 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747912; cv=none; b=ddpqz/SVmwd6lWz1CjvRgp0Bp6IEbRuahX4K+ABCNZTSs0eMf9DmaXK30zE3artJsS5vOzLy27iTlxNBIKo1zG1/hXREAh3RBHPI9A40EcthZ4R6i5RqJ3q4ussTj+38E/7NQ0BlOj/90jvx8bcpFqsDoUKdZsjOvn4S5T8/5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747912; c=relaxed/simple;
	bh=ZzbBU4sOpra+cPAiUAX1BmBqz1TgtCycAamaqJH0DvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4q2fnLTIxCzPWjawZk5oqqokxYgMK8Y8npEkYZYH13xegAjOMz8IvTK8tNVmmbWbizb0ZsvMHJOvUhe3bmFXPTt/MVOOmsbXNynxp8TtDnBGH5hb3AtIlDWawfrp/lnG8zLMQan8XdFd6dGxDwd5T3l+KeZ3L9g6uShkNw9deI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpCxWf2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B44C4CEF1;
	Mon,  1 Sep 2025 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756747911;
	bh=ZzbBU4sOpra+cPAiUAX1BmBqz1TgtCycAamaqJH0DvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpCxWf2PL3VzWy1mwMddLdFK07I9Rr6896vS584vQRVy2s9wxjdZPI7InUF04X7HL
	 HyKmv849e3C+G6xrVG9GNvWCGlZ29IyuoArnAsVOECSMQRsCfzGM3gVC1XWndKw8EC
	 ApBCbzipfiyoDgdcI/OgdC/i6oM9zs+Eb0UbNA0jZEnsIHRKUVp7oybKLZ275YjG8q
	 5Ms1nlnevItoDLnD3dP6G4c2dX5XOjMZsiCdNj8u5zI7XzUBpL8lpHI0J/rq2eMmQ2
	 c1pv1diX/ETo3wlk4/Y9Pz0FqmSH5tzzSZBFm2YlokEXoOODuTvr6ljAFg3S7fXY48
	 9jV+bsxF8l3Cw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] selftests: drv-net: rss_ctx: make the test pass with few queues
Date: Mon,  1 Sep 2025 10:31:39 -0700
Message-ID: <20250901173139.881070-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901173139.881070-1-kuba@kernel.org>
References: <20250901173139.881070-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rss_ctx.test_rss_key_indir implicitly expects at least 5 queues,
as it checks that the traffic on first 2 queues is lower than
the remaining queues when we use all queues. Special case fewer
queues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index a5562a9f729f..ed7e405682f0 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -178,8 +178,13 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     cnts = _get_rx_cnts(cfg)
     GenerateTraffic(cfg).wait_pkts_and_stop(20000)
     cnts = _get_rx_cnts(cfg, prev=cnts)
-    # First two queues get less traffic than all the rest
-    ksft_lt(sum(cnts[:2]), sum(cnts[2:]), "traffic distributed: " + str(cnts))
+    if qcnt > 4:
+        # First two queues get less traffic than all the rest
+        ksft_lt(sum(cnts[:2]), sum(cnts[2:]),
+                "traffic distributed: " + str(cnts))
+    else:
+        # When queue count is low make sure third queue got significant pkts
+        ksft_ge(cnts[2], 3500, "traffic distributed: " + str(cnts))
 
 
 def test_rss_queue_reconfigure(cfg, main_ctx=True):
-- 
2.51.0


