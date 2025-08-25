Return-Path: <linux-kselftest+bounces-39873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1264EB349B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA7E1B254C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7330DEBC;
	Mon, 25 Aug 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBWANdNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08E30C34B;
	Mon, 25 Aug 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145099; cv=none; b=QEv18x2JqtG32aHM6Bh8BN8oIC9vzhdnjEIWb7JT40ATieRx/+WpDCzsEJEC24PTPEbRwNOf26pIRrZQHLG1GfH+ZB4uosttPkjGoL0XZQW08ezTggS2L2w/1N9EINvNc844mJRS0XmskiYCIM3Sw1vCMZqkiSWMFhKhaUT1MME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145099; c=relaxed/simple;
	bh=WElHMgDUirUQOrUf5/24xtMxtD19ofo2XYNj8xPkN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjq+TngDB7Jv509cNZIaqodstRRshwK26fo8lXQpJVmEf2SfwgbisQpxliIL34OhTiZ962JpC4XSchGBAMaX/vceftTDTSPljDVsZB8CbHjO8ow5Knz11QKcf9ozotmINmDbdgzZmVvBPA62tdantrE7jaBdCMO/JBUrgBLUliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBWANdNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64707C19422;
	Mon, 25 Aug 2025 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145098;
	bh=WElHMgDUirUQOrUf5/24xtMxtD19ofo2XYNj8xPkN8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBWANdNmjOIVa4maAXPJf8OYL3YFwxel/gUBmVQn5KndnnkfVTQfH8fU+RNGR8V3Z
	 Gb0Zy3GnjDZ1i5hVwySNvK2PbFKE2/JHFbQsNnbroRtJt0kbKbT1i20j2XsFHfD1qq
	 8BSCbpJIzMPq70kXlUWktHHLF37AWOSNFSEnX56AfC1kUYBLXqoUUZvgBiqTIcsWvO
	 pWE6J+Qsm+sfJk0w9uHQ5XYpr7I8t0kX9plC2BG9gtJGQ6sp/5JmOXdPQ4wn2QEWLZ
	 HD0+EuhdoM9TR8MIGiXQ/JRPcZ4oTWyDrw0/WsZYuLAMg4p9+ZqRz0n24BNsMr+FJf
	 Ar5pltibNFcCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/5] selftests: drv-net: ncdevmem: explicitly set HDS threshold to 0
Date: Mon, 25 Aug 2025 11:04:47 -0700
Message-ID: <20250825180447.2252977-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825180447.2252977-1-kuba@kernel.org>
References: <20250825180447.2252977-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure we set HDS threshold to 0 if the device supports changing it.
It's required for ZC.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - split from previous patch
 - only touch hds if device supports it
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 5fe55939f0e3..8dc9511d046f 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -464,6 +464,8 @@ static void restore_ring_config(const struct ethtool_rings_get_rsp *config)
 	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
 	ethtool_rings_set_req_set_tcp_data_split(req,
 						ETHTOOL_TCP_DATA_SPLIT_UNKNOWN);
+	if (config->_present.hds_thresh)
+		ethtool_rings_set_req_set_hds_thresh(req, config->hds_thresh);
 
 	ret = ethtool_rings_set(ys, req);
 	if (ret < 0)
@@ -490,7 +492,8 @@ static void restore_ring_config(const struct ethtool_rings_get_rsp *config)
 	ynl_sock_destroy(ys);
 }
 
-static int configure_headersplit(bool on)
+static int
+configure_headersplit(const struct ethtool_rings_get_rsp *old, bool on)
 {
 	struct ethtool_rings_get_req *get_req;
 	struct ethtool_rings_get_rsp *get_rsp;
@@ -507,13 +510,15 @@ static int configure_headersplit(bool on)
 
 	req = ethtool_rings_set_req_alloc();
 	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
-	if (on)
+	if (on) {
 		ethtool_rings_set_req_set_tcp_data_split(req,
 						ETHTOOL_TCP_DATA_SPLIT_ENABLED);
-	else
+		if (old->_present.hds_thresh)
+			ethtool_rings_set_req_set_hds_thresh(req, 0);
+	} else {
 		ethtool_rings_set_req_set_tcp_data_split(req,
 						ETHTOOL_TCP_DATA_SPLIT_UNKNOWN);
-
+	}
 	ret = ethtool_rings_set(ys, req);
 	if (ret < 0)
 		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
@@ -850,7 +855,7 @@ static int do_server(struct memory_buffer *mem)
 		return -1;
 	}
 
-	if (configure_headersplit(1)) {
+	if (configure_headersplit(ring_config, 1)) {
 		pr_err("Failed to enable TCP header split");
 		goto err_free_ring_config;
 	}
@@ -1074,7 +1079,7 @@ int run_devmem_tests(void)
 		goto err_free_ring_config;
 	}
 
-	if (configure_headersplit(1)) {
+	if (configure_headersplit(ring_config, 1)) {
 		pr_err("Failed to configure header split");
 		goto err_reset_rss;
 	}
@@ -1090,7 +1095,7 @@ int run_devmem_tests(void)
 		goto err_unbind;
 	}
 
-	if (configure_headersplit(0)) {
+	if (configure_headersplit(ring_config, 0)) {
 		pr_err("Failed to configure header split");
 		goto err_reset_headersplit;
 	}
@@ -1106,7 +1111,7 @@ int run_devmem_tests(void)
 		goto err_unbind;
 	}
 
-	if (configure_headersplit(1)) {
+	if (configure_headersplit(ring_config, 1)) {
 		pr_err("Failed to configure header split");
 		goto err_reset_headersplit;
 	}
-- 
2.51.0


