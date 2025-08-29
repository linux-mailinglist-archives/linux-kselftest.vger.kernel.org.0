Return-Path: <linux-kselftest+bounces-40344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED4B3C4A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C703BFF5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E89277CB1;
	Fri, 29 Aug 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXUciteh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB5276041;
	Fri, 29 Aug 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505236; cv=none; b=uFscytq0olwDtdTrCET2lAr3Z1oGdl/ZexzD5bgUfq3/9kfECX8CRWjLdtX26ILrpZ5JdlbqMW72K27tXAEGQgLfpa29KiPCY+EsxlAirfwvB2W4R/RJ6cGeS0AS8lMou3AhTR1j1vtuf+dqE+nEDv63V9uMw8I5JxgyHtFavPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505236; c=relaxed/simple;
	bh=sa3VPxyEgUd5NG35FxHRJ+fykGpg6tHJ+GkR6z9Cslc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsnOFnLTwOLnC0e67tEeV+XDEWJjlEALBXDcSters8CsnOOykGEOHBf7daoAuhkgAocCfLH8HUJ5LDWiMTJxjHzGNnChnMDTC1IMTg6fLy3IL80gHTZ/XTpNQBX4/W/rqzLnYKa6uTBwSBk3pdwV9IiXdOIALgWvXcmScpg0aVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXUciteh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA1FC4CEF1;
	Fri, 29 Aug 2025 22:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756505235;
	bh=sa3VPxyEgUd5NG35FxHRJ+fykGpg6tHJ+GkR6z9Cslc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXUcitehei7KEhp5BBUWC/dT3CVmCz+r2l+jMXVxBi3XUoPEJw0jtKNeLtNUnusx1
	 YeJdUAHaLAYDmErlBlTnmVZOjXmnD1aFGDY6pXdKqOoCUFQYmMD0KUSG1qgNN995rJ
	 q6b/aK0Sp/XDwv8pmcotOt5ddhCk7s64TI5E22DS/6utFLzMKse2BaSaqznKsWqDjg
	 fRYH0bLFE2F/jXNpx7c2ez9gBTiqE0e73XmGuAcsCaIHziBe9ot6O3fKfSRj5Hm6QV
	 raprI4iy5ooXsFGZyBJ738fArGkbhXlJccVu2VupyLzI4f1AD6ow4ueBq6s18+XOK6
	 2HRGY2fdrWPqw==
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
Subject: [PATCH net-next 2/2] selftests: drv-net: rss_ctx: make the test pass with few queues
Date: Fri, 29 Aug 2025 15:07:12 -0700
Message-ID: <20250829220712.327920-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829220712.327920-1-kuba@kernel.org>
References: <20250829220712.327920-1-kuba@kernel.org>
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
index 3fc5688605b5..4fa8c7f198a8 100755
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


