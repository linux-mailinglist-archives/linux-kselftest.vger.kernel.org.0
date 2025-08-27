Return-Path: <linux-kselftest+bounces-40063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A52B388BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D55E806A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D952292B2E;
	Wed, 27 Aug 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR/qvhYr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2F274659;
	Wed, 27 Aug 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316161; cv=none; b=JEEBThaSeQeGQegk9s6ZyaJ1Ag17XGJyvfhYLuSTdTcgZDJaR9UcFkklQBOQvXjB38lPjBA1fyXnbYZlu0Obu/Y7Mzo9k8R2O6JaoSw5i30pF5rv6stB2G4wTP0IUKbWCBl6swRZ1FJ25Kn9AgHiLbxSU5N/b57V39dClFFGIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316161; c=relaxed/simple;
	bh=bp3zc4zA0mhhj8oOq8MCGeII2K8a1NvOHUUUV4QYvD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwMRiB7ScJ3IhcSrLFpVrREKUAYmVVixowg2oxJ7Ru7gsAgtqii9ob/iEsXakI0dNpXdL6QQSOrqyraht3Lwex3lEATegJWcaSmGXQysCWA2eIRPL8ec0kHZWDEI3ejhkcl0rOzae81Ow7C1LEVs/qGD7plPEOrb/PrwsEL045E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR/qvhYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7848C4CEEB;
	Wed, 27 Aug 2025 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756316160;
	bh=bp3zc4zA0mhhj8oOq8MCGeII2K8a1NvOHUUUV4QYvD4=;
	h=From:To:Cc:Subject:Date:From;
	b=KR/qvhYr7SXjPmTcV8fSFYWJwlqGs5p2uhICBuyfRttXmUhpMXlM0WZQEhiheJUS7
	 +dHKPZaMjSxDvBKhl3xbrXQwE2tJrZEH0WCQHcutxeZh9SPIozB0qeNN04axqOdjoD
	 g3ubjqZwcQzqjR+cul6DfzBn1GMPlbnCMKQqD0rKvfT8q3q/5CjTrouMrDvgasSWCc
	 hSRfY2EGYCw4fpixri1esGOjMx0HN6xptpH/a4/BGuIkEAfW9x6rcwI8auF17CM0Bz
	 H0iT8dXcEC6h6Hwe0QiysQLk64/Eo3itSdRpb/cl+Q5a60qiXyOWoHtC6xYssH8qty
	 qkCobRD9UbOSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: rss_ctx: fix the queue count check
Date: Wed, 27 Aug 2025 10:35:58 -0700
Message-ID: <20250827173558.3259072-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0d6ccfe6b319 ("selftests: drv-net: rss_ctx: check for all-zero keys")
added a skip exception if NIC has fewer than 3 queues enabled,
but it's just constructing the object, it's not actually rising
this exception.

Before:

  # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ethtool -X enp1s0 equal 3 hkey d1:cc:77:47:9d:ea:15:f2:b9:6c:ef:68:62:c0:45:d5:b0:99:7d:cf:29:53:40:06:3d:8e:b9:bc:d4:70:89:b8:8d:59:04:ea:a9:c2:21:b3:55:b8:ab:6b:d9:48:b4:bd:4c:ff:a5:f0:a8:c2
  not ok 1 rss_ctx.test_rss_key_indir

After:

  ok 1 rss_ctx.test_rss_key_indir # SKIP Device has fewer than 3 queues (or doesn't support queue stats)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I spotted that NIPA instances with 4 CPUs are failing this test case.
They have only 4/2=2 queues. I bumped their CPU count to 6, but test
is clearly wrong.

CC: shuah@kernel.org
CC: ecree.xilinx@gmail.com
CC: gal@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 7bb552f8b182..9838b8457e5a 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -118,7 +118,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
     qcnt = len(_get_rx_cnts(cfg))
     if qcnt < 3:
-        KsftSkipEx("Device has fewer than 3 queues (or doesn't support queue stats)")
+        raise KsftSkipEx("Device has fewer than 3 queues (or doesn't support queue stats)")
 
     data = get_rss(cfg)
     want_keys = ['rss-hash-key', 'rss-hash-function', 'rss-indirection-table']
-- 
2.51.0


