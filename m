Return-Path: <linux-kselftest+bounces-39872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0FBB349B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2611B25414
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F230BF6D;
	Mon, 25 Aug 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY61XCZ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD43093BD;
	Mon, 25 Aug 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145098; cv=none; b=HGYHTEReFCHmuHbcSdlTzUKknOOAYVTkctdi2/89CecV69tFQE/SJxZbV5zQrt9GCh1ld08zSUFE4Qx0mTg9XBAQ7SkwYCpPWl3IrtwiEBan2jA/uGoSoU3jqVIOLEjzp1TpUXBJ6HOkmyCrqZcf3PFBzp+BvvvnSAfOx3qkGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145098; c=relaxed/simple;
	bh=ygiTgd2ObwnT5fHwIZUXoTGoQM0SEe+lAEVw54jKypU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k95A3z742v2HGBeS81h608oYFHwCfSgnDN0tST1eOIYRekz0ILQ7Bg323++Uz3qjUUFixrKagb5wTC1OntbxmD5TXOx+hYS1rhqs/67Wy1ybtnY+IfE8s4uno8/AaiWrgt74VVn2XM7miCSjsSX676OKRXpD0lIMGmG4DmLyHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY61XCZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA624C4CEED;
	Mon, 25 Aug 2025 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145098;
	bh=ygiTgd2ObwnT5fHwIZUXoTGoQM0SEe+lAEVw54jKypU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jY61XCZ4MbAUBX+W90h5ZdZHurWwg+t/Ps/vDS8VXhJsvGR2efvFrJ8EmfzmnF/Fu
	 DZIHFGFx97ksyNYo3NJix8QHlzaQp7XJduIqjiyklourWMLSGCQw/zhLkppNRbiT+k
	 OtVhPbXRgBCs7mjOowl0KLPQtFZtA4rLmxaKRt0NvdPDxyWtHZjJJC06xZAZFFbkUu
	 ZHRLmhNKpi9Rn8Q6810qn/FUz5jFPu+KU44cg2Su8PHb7IoxtrrmFIyA1EMpUE+5Yu
	 bEChAdEis3VnV8SncxZeDUrwQ8x8DJ8hl6PWan+LCM4RHFpR1h/OzPvd0ytl3Zf6+B
	 Q207xu/lfHNJQ==
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
Subject: [PATCH net-next v2 4/5] selftests: drv-net: ncdevmem: restore original HDS setting before exiting
Date: Mon, 25 Aug 2025 11:04:46 -0700
Message-ID: <20250825180447.2252977-5-kuba@kernel.org>
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

Restore HDS settings if we modified them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move the threshold setting out
 - use explict setting if setting to UKNOWN doesn't result in matching
   the state we saw before the test
v1: https://lore.kernel.org/20250822200052.1675613-5-kuba@kernel.org
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 112 ++++++++++++++++--
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 580b4459a840..5fe55939f0e3 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -419,6 +419,77 @@ static const char *tcp_data_split_str(int val)
 	}
 }
 
+static struct ethtool_rings_get_rsp *get_ring_config(void)
+{
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return NULL;
+	}
+
+	get_req = ethtool_rings_get_req_alloc();
+	ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+	get_rsp = ethtool_rings_get(ys, get_req);
+	ethtool_rings_get_req_free(get_req);
+
+	ynl_sock_destroy(ys);
+
+	return get_rsp;
+}
+
+static void restore_ring_config(const struct ethtool_rings_get_rsp *config)
+{
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
+	struct ethtool_rings_set_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret;
+
+	if (!config)
+		return;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return;
+	}
+
+	req = ethtool_rings_set_req_alloc();
+	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
+	ethtool_rings_set_req_set_tcp_data_split(req,
+						ETHTOOL_TCP_DATA_SPLIT_UNKNOWN);
+
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL restoring HDS cfg: %s\n", ys->err.msg);
+
+	get_req = ethtool_rings_get_req_alloc();
+	ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+	get_rsp = ethtool_rings_get(ys, get_req);
+	ethtool_rings_get_req_free(get_req);
+
+	/* use explicit value if UKNOWN didn't give us the previous */
+	if (get_rsp->tcp_data_split != config->tcp_data_split) {
+		ethtool_rings_set_req_set_tcp_data_split(req,
+							config->tcp_data_split);
+		ret = ethtool_rings_set(ys, req);
+		if (ret < 0)
+			fprintf(stderr, "YNL restoring expl HDS cfg: %s\n",
+				ys->err.msg);
+	}
+
+	ethtool_rings_get_rsp_free(get_rsp);
+	ethtool_rings_set_req_free(req);
+
+	ynl_sock_destroy(ys);
+}
+
 static int configure_headersplit(bool on)
 {
 	struct ethtool_rings_get_req *get_req;
@@ -436,8 +507,13 @@ static int configure_headersplit(bool on)
 
 	req = ethtool_rings_set_req_alloc();
 	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
-	/* 0 - off, 1 - auto, 2 - on */
-	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	if (on)
+		ethtool_rings_set_req_set_tcp_data_split(req,
+						ETHTOOL_TCP_DATA_SPLIT_ENABLED);
+	else
+		ethtool_rings_set_req_set_tcp_data_split(req,
+						ETHTOOL_TCP_DATA_SPLIT_UNKNOWN);
+
 	ret = ethtool_rings_set(ys, req);
 	if (ret < 0)
 		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
@@ -745,6 +821,7 @@ static struct netdev_queue_id *create_queues(void)
 
 static int do_server(struct memory_buffer *mem)
 {
+	struct ethtool_rings_get_rsp *ring_config;
 	char ctrl_data[sizeof(int) * 20000];
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
@@ -767,9 +844,15 @@ static int do_server(struct memory_buffer *mem)
 		return -1;
 	}
 
+	ring_config = get_ring_config();
+	if (!ring_config) {
+		pr_err("Failed to get current ring configuration");
+		return -1;
+	}
+
 	if (configure_headersplit(1)) {
 		pr_err("Failed to enable TCP header split");
-		return -1;
+		goto err_free_ring_config;
 	}
 
 	/* Configure RSS to divert all traffic from our devmem queues */
@@ -959,12 +1042,15 @@ static int do_server(struct memory_buffer *mem)
 err_reset_rss:
 	reset_rss();
 err_reset_headersplit:
-	configure_headersplit(0);
+	restore_ring_config(ring_config);
+err_free_ring_config:
+	ethtool_rings_get_rsp_free(ring_config);
 	return err;
 }
 
 int run_devmem_tests(void)
 {
+	struct ethtool_rings_get_rsp *ring_config;
 	struct netdev_queue_id *queues;
 	struct memory_buffer *mem;
 	struct ynl_sock *ys;
@@ -976,10 +1062,16 @@ int run_devmem_tests(void)
 		return -1;
 	}
 
+	ring_config = get_ring_config();
+	if (!ring_config) {
+		pr_err("Failed to get current ring configuration");
+		goto err_free_mem;
+	}
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss()) {
 		pr_err("rss error");
-		goto err_free_mem;
+		goto err_free_ring_config;
 	}
 
 	if (configure_headersplit(1)) {
@@ -1000,13 +1092,13 @@ int run_devmem_tests(void)
 
 	if (configure_headersplit(0)) {
 		pr_err("Failed to configure header split");
-		goto err_reset_rss;
+		goto err_reset_headersplit;
 	}
 
 	queues = create_queues();
 	if (!queues) {
 		pr_err("Failed to create queues");
-		goto err_reset_rss;
+		goto err_reset_headersplit;
 	}
 
 	if (!bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys)) {
@@ -1016,7 +1108,7 @@ int run_devmem_tests(void)
 
 	if (configure_headersplit(1)) {
 		pr_err("Failed to configure header split");
-		goto err_reset_rss;
+		goto err_reset_headersplit;
 	}
 
 	queues = create_queues();
@@ -1042,9 +1134,11 @@ int run_devmem_tests(void)
 err_unbind:
 	ynl_sock_destroy(ys);
 err_reset_headersplit:
-	configure_headersplit(0);
+	restore_ring_config(ring_config);
 err_reset_rss:
 	reset_rss();
+err_free_ring_config:
+	ethtool_rings_get_rsp_free(ring_config);
 err_free_mem:
 	provider->free(mem);
 	return err;
-- 
2.51.0


