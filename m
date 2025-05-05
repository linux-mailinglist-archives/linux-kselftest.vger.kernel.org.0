Return-Path: <linux-kselftest+bounces-32449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF66AAA739
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 02:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEAD3AD70D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A29331F74;
	Mon,  5 May 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjHpGTmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A1331F6F;
	Mon,  5 May 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484553; cv=none; b=SbB40XTl7D0IwNnuOesOkeyQzG6oQQjBEG3TEzWplQw+2S01ZmuI/alr3qU6Z9NfVi1S7WqkfDklmOeHtSbu3UR8FSUInSY4MalOiCtJVuAtQ6Gr/VOzOgZGiOUlfSAhJbHZ1U+Wi7wWFk+E+ZEoaDHT7Z/sihncczX9oJQdkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484553; c=relaxed/simple;
	bh=U2WuZF++J+yU8AMVFz5H3SO6FY02eiBtByt94VFG4+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qz+xnPxlzmmeGhuVj0nr8Hgz+zah0UNaefiTKal1X9KVDluCzYrtGThTehVNbrTsUmJW/jSZgY83+9XkMhZI7g5VzPQkWH9y0g4TC73YX4MBeAstfO/0HIBUmyk0K48QtgPXTjsBE9AnCPZEBkJItTx0s3x6tHgt7mrRYNuXoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjHpGTmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C9BC4CEE4;
	Mon,  5 May 2025 22:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484553;
	bh=U2WuZF++J+yU8AMVFz5H3SO6FY02eiBtByt94VFG4+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjHpGTmDbGISRZLVPKCJtsLQ+EzGwZ6z8hYHnM2dbEwou8PPerZfTIPEkuWsIk/ft
	 YipwnOVXMzfAoKFhC+uT3wcw1MewpfhweIPGjqht5l7oUi3w+nMTTiN4hLmYZStMVa
	 bOS7DZQXzxv+lCl4VHBu+qeutziClR8EReJ6Y1buoFCLMijpWEVADRgOcr6jdXGNEf
	 CG/haNxbXdPKRyhNuiw38OCbS51M9M+IbJhZGgr92CaN2yhYVVbH5KpMlyjLj35+Rm
	 UxQOEDOAIONoE4YhTQTlx1iOM0ptjD6w1gxEb2COewFFU91oIKnkXGc12GL3ceGYiU
	 v17LmAKZ8wxSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 533/642] netdevsim: allow normal queue reset while down
Date: Mon,  5 May 2025 18:12:29 -0400
Message-Id: <20250505221419.2672473-533-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 285b3f78eabd951e59e98f01f86abaaa6c76cd44 ]

Resetting queues while the device is down should be legal.
Allow it, test it. Ideally we'd test this with a real device
supporting devmem but I don't have access to such devices.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250206225638.1387810-5-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netdevsim/netdev.c           | 10 ++++------
 tools/testing/selftests/net/nl_netdev.py | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e4c0d77849b82..a41dc79e9c2e0 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -664,8 +664,11 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 	if (ns->rq_reset_mode > 3)
 		return -EINVAL;
 
-	if (ns->rq_reset_mode == 1)
+	if (ns->rq_reset_mode == 1) {
+		if (!netif_running(ns->netdev))
+			return -ENETDOWN;
 		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
+	}
 
 	qmem->rq = nsim_queue_alloc();
 	if (!qmem->rq)
@@ -773,11 +776,6 @@ nsim_qreset_write(struct file *file, const char __user *data,
 		return -EINVAL;
 
 	rtnl_lock();
-	if (!netif_running(ns->netdev)) {
-		ret = -ENETDOWN;
-		goto exit_unlock;
-	}
-
 	if (queue >= ns->netdev->real_num_rx_queues) {
 		ret = -EINVAL;
 		goto exit_unlock;
diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 93e8cb671c3d9..beaee5e4e2aab 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -35,6 +35,21 @@ def napi_list_check(nf) -> None:
                         comment=f"queue count after reset queue {q} mode {i}")
 
 
+def nsim_rxq_reset_down(nf) -> None:
+    """
+    Test that the queue API supports resetting a queue
+    while the interface is down. We should convert this
+    test to testing real HW once more devices support
+    queue API.
+    """
+    with NetdevSimDev(queue_count=4) as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} down")
+        for i in [0, 2, 3]:
+            nsim.dfs_write("queue_reset", f"1 {i}")
+
+
 def page_pool_check(nf) -> None:
     with NetdevSimDev() as nsimdev:
         nsim = nsimdev.nsims[0]
@@ -106,7 +121,8 @@ def page_pool_check(nf) -> None:
 
 def main() -> None:
     nf = NetdevFamily()
-    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check],
+    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
+              nsim_rxq_reset_down],
              args=(nf, ))
     ksft_exit()
 
-- 
2.39.5


