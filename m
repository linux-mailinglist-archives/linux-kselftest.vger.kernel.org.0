Return-Path: <linux-kselftest+bounces-39728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7726B32355
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1973D1D62C02
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9962D8390;
	Fri, 22 Aug 2025 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXQnFbDl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262A2D836A;
	Fri, 22 Aug 2025 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892864; cv=none; b=aqw6W0Ql+4SdVfzaoxH028A6n9ugvaZR47odlqFwYc2KAAE29gr7cV9W6A41QU4IUfO+X/inFFRKA6pGtzFE05dUH+rVRtrF6GI23FAnGZU84TJA48GFXUswy2RwIYO+qrziJPeyzoRRwqj21N8zPEUY0Evn3Z73I5NvikAKmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892864; c=relaxed/simple;
	bh=fL5reU7n2NLVmobpgo6XfsVUTbllY3GjlzYhlHdzEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXi31hu+Uue4QINf9sCyNi//6vbnnpSE5XtahH9z7fyDuAN+4Q1cqhjCuvlxC13jEprkjQxMb6eiU+v5VeY15RGq6P39MBzOTvPSYkMxX5d1CaQ/u7r54HTPX/EPz2JNJXnFzQP95KET9ZOEXAXVL1nx8uzGb7uh+F1pALX/6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXQnFbDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC979C16AAE;
	Fri, 22 Aug 2025 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892864;
	bh=fL5reU7n2NLVmobpgo6XfsVUTbllY3GjlzYhlHdzEq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXQnFbDlnr+5y3h3yG9k8bjpHYduQcXDp+JulhoQVMor5fxt7FCXHIoHWJyKkMOHF
	 jjhHLQQ9XowbKKCGIAmIJJui9QCQ8RQ6CAHFxmao8OdlJXoReU8neB78wSmJqH8phZ
	 xvM4JjXvQpvaLNVf9tBSNn+FaPnryZ+tBY7KzqM5YwnLlvkEMJX9jfKt0LyyyOFmDj
	 9rOTYg2XC55fbHpUD4bmGrlFLXGcdz1QJnbsEeM/Its2AH+mTHpSLpZhQvge5HKMLU
	 hKH08NjX8Vq1spDkji6+UOBqoWeEQqfH7Wr+NngeADsw5a4mb9HhnoUdsuGR3FyP53
	 bdM0kptZoKFqg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: drv-net: ncdevmem: configure and restore HDS threshold
Date: Fri, 22 Aug 2025 13:00:52 -0700
Message-ID: <20250822200052.1675613-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822200052.1675613-1-kuba@kernel.org>
References: <20250822200052.1675613-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve HDS handling. Make sure we set threshold to 0.
Restore the previous settings before exiting.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/ncdevmem.c       | 96 +++++++++++++++++--
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 580b4459a840..aa2904d1a3e1 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -419,6 +419,60 @@ static const char *tcp_data_split_str(int val)
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
+	if (config->_present.hds_thresh)
+		ethtool_rings_set_req_set_hds_thresh(req, config->hds_thresh);
+
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	ynl_sock_destroy(ys);
+}
+
 static int configure_headersplit(bool on)
 {
 	struct ethtool_rings_get_req *get_req;
@@ -436,8 +490,14 @@ static int configure_headersplit(bool on)
 
 	req = ethtool_rings_set_req_alloc();
 	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
-	/* 0 - off, 1 - auto, 2 - on */
-	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	if (on) {
+		ethtool_rings_set_req_set_tcp_data_split(req,
+						ETHTOOL_TCP_DATA_SPLIT_ENABLED);
+		ethtool_rings_set_req_set_hds_thresh(req, 0);
+	} else {
+		ethtool_rings_set_req_set_tcp_data_split(req,
+						ETHTOOL_TCP_DATA_SPLIT_UNKNOWN);
+	}
 	ret = ethtool_rings_set(ys, req);
 	if (ret < 0)
 		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
@@ -745,6 +805,7 @@ static struct netdev_queue_id *create_queues(void)
 
 static int do_server(struct memory_buffer *mem)
 {
+	struct ethtool_rings_get_rsp *ring_config;
 	char ctrl_data[sizeof(int) * 20000];
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
@@ -767,9 +828,15 @@ static int do_server(struct memory_buffer *mem)
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
@@ -959,12 +1026,15 @@ static int do_server(struct memory_buffer *mem)
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
@@ -976,10 +1046,16 @@ int run_devmem_tests(void)
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
@@ -1000,13 +1076,13 @@ int run_devmem_tests(void)
 
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
@@ -1016,7 +1092,7 @@ int run_devmem_tests(void)
 
 	if (configure_headersplit(1)) {
 		pr_err("Failed to configure header split");
-		goto err_reset_rss;
+		goto err_reset_headersplit;
 	}
 
 	queues = create_queues();
@@ -1042,9 +1118,11 @@ int run_devmem_tests(void)
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
2.50.1


