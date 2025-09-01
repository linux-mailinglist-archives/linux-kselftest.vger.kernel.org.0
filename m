Return-Path: <linux-kselftest+bounces-40495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591FB3ED64
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1686F1A85BA0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF12DF120;
	Mon,  1 Sep 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHQ7zKFk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA313E02A;
	Mon,  1 Sep 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747912; cv=none; b=Rqg09Thnus8FvdvsUfEFtJNTbXTmiMT02o5SsE+PE854SGpW0AeeZIQTPqJjkep1+TR9AxDWCSFhsYlf4kmT2cUCvky8ij3G9XGCOcMzGLZ4sMnu63AxOZecagvTLH9o7RgHOHUbfxZvJeSo7DyY1QquZLvIJYCggG9K1AVJkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747912; c=relaxed/simple;
	bh=n5cUTjuZGwZgUD8Z463UpffeCXPrtAJ3Cz7osXRmr1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNwt8D3vTX/n8TqWPSRgfa1vY8s360SvqJ/PujKLOFJUNseuxY+butaM49N83Num9E2SKYl1nmY/37RxhXesSrFzLp2tGM8kHv83OeFM72JPJYXPcTGMprIjDXOdCgCOheSJzLRjPPJlzqI3R3T8v4X6Yc7GifYYf8+Fgv90LIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHQ7zKFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A751CC4CEF0;
	Mon,  1 Sep 2025 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756747911;
	bh=n5cUTjuZGwZgUD8Z463UpffeCXPrtAJ3Cz7osXRmr1M=;
	h=From:To:Cc:Subject:Date:From;
	b=dHQ7zKFk0kQigUyi8j0pzR/7NMjGxgPI3FoHYczXL3TGH2zxrNSXGrNbALDwfjujK
	 bhT8EWGKNtRs9WhKjDD08ySq663+U8xd/NxaiByU6Kr94RMSWdZiTofoKRCSGChlEP
	 k6afHIZ/Aphlh1U7U6vKQihW4n9lhQDYD9+J0Cpl1WmRKjycqwwPR/Kf6gxF1Y2mAv
	 VZ1cvqTgkNfL1fEzZ8c39iX5UbLczdjK4fwccQb/l9dFtyaNxx06t7upb92gEsjZuA
	 +PqsLuW29uiPPrMd5is26H6JQMRlMfvj6HFqgTr7aZIXe5gnzeWSVNKiZ9wM04yQI1
	 GQ8dLIqVYwa3g==
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
Subject: [PATCH net-next v2 1/2] selftests: drv-net: rss_ctx: use Netlink for timed reconfig
Date: Mon,  1 Sep 2025 10:31:38 -0700
Message-ID: <20250901173139.881070-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rss_ctx test has gotten pretty flaky after I increased
the queue count in NIPA 2->3. Not 100% clear why. We get
a lot of failures in the rss_ctx.test_hitless_key_update case.

Looking closer it appears that the failures are mostly due
to startup costs. I measured the following timing for ethtool -X:
 - python cmd(shell=True)  : 150-250msec
 - python cmd(shell=False) :  50- 70msec
 - timed in bash           :  45- 55msec
 - YNL Netlink call        :   2-  4msec
 - .set_rxfh callback      :   1-  2msec

The target in the test was set to 200msec. We were mostly measuring
ethtool startup cost it seems. Switch to YNL since it's 100x faster.

Lower the pass criteria to 150msec, no real science behind this number
but we removed some overhead, drivers which previously passed 200msec
should easily pass 150msec now.

Separately we should probably follow up on defaulting to shell=False,
when script doesn't explicitly ask for True, because the overhead
is rather significant.

Switch from _rss_key_rand() to random.randbytes(), YNL takes a binary
array rather than array of ints.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - increase the threshold to safer 150msec
 - mention change away from _rss_key_rand()
v1: https://lore.kernel.org/20250829220712.327920-1-kuba@kernel.org
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 9838b8457e5a..a5562a9f729f 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -335,19 +335,20 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     data = get_rss(cfg)
     key_len = len(data['rss-hash-key'])
 
-    key = _rss_key_rand(key_len)
+    ethnl = EthtoolFamily()
+    key = random.randbytes(key_len)
 
     tgen = GenerateTraffic(cfg)
     try:
         errors0, carrier0 = get_drop_err_sum(cfg)
         t0 = datetime.datetime.now()
-        ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
+        ethnl.rss_set({"header": {"dev-index": cfg.ifindex}, "hkey": key})
         t1 = datetime.datetime.now()
         errors1, carrier1 = get_drop_err_sum(cfg)
     finally:
         tgen.wait_pkts_and_stop(5000)
 
-    ksft_lt((t1 - t0).total_seconds(), 0.2)
+    ksft_lt((t1 - t0).total_seconds(), 0.15)
     ksft_eq(errors1 - errors1, 0)
     ksft_eq(carrier1 - carrier0, 0)
 
-- 
2.51.0


