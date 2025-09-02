Return-Path: <linux-kselftest+bounces-40600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89301B40194
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE1B4E561D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ADD3009E8;
	Tue,  2 Sep 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wBvkZ/wc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EC2FFDDB;
	Tue,  2 Sep 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817658; cv=none; b=DuOvK+oJq98yRUHAnhxoBA1mPY51kce3QOIULmqsayHPXBZKTYbcKnV9puNgyvdYxJ/uWmnVn2i/oKC+rvcfgp1sSDrm4+ySFG5FPu7pPr/14FlghhQvDXauO6fJxPxc5gGy/g0ppYEgchtdHKa2qkw2vCR78kGLf5bEdfmNVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817658; c=relaxed/simple;
	bh=48zcnMWzsv/v3bjOBynO172zSGmZWTSCCqqFVIYrNqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgaCLsi2szSHByQcQDmckWdj/pH89KqbfNsHLgJoKN4cDek28w2M16RBhrwbyghZl4vv7Tm8HAtfAtJ1uP3Ewaz9nh8/m7i0GRYDzUgLDuBkCW00uvA8be2klAoDUMUTn8w0n8+7EcHLjuxTLPksqLejdGEONk5rIVWXjVEBGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wBvkZ/wc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9286A1A09B9;
	Tue,  2 Sep 2025 12:54:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BAC660695;
	Tue,  2 Sep 2025 12:54:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 720C91C22DDC0;
	Tue,  2 Sep 2025 14:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ipKNJ+17JYwM1fYVqDkTvfn3AiEeFMXg/yEmZXSvkIQ=;
	b=wBvkZ/wcoPAOku67+XxqZtMtFeZrLOOxvPapEoeBBfafHWFG8uv8tzLgMMYpiOd9sZBBdX
	f9AlwXXoKNXu7cRsrVXo+WQ1GlpFp4/FqYoMnORnFi+kFHsf6AAX8xMKBmxvkv13lJ1Hk3
	BR+lnnBUe/bc28/wt0+78VVt9QlnuIaMmRJqY9xf/vkmRAJl2zrPal8nj6wwn5JjPZALyu
	A6Oh7W4mOz9GqFP9EKVQ2yqOOUPQqiZLwIXQqZkD55aH7E6LFfcfIIQkENVSqiN9Lf4PA5
	kON7J4aXteuResy44XM1vJzCoupY3tCxsgTtCOLTlj0wcUjsxq8tlqwWxAeccg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:49:59 +0200
Subject: [PATCH bpf-next v2 09/14] selftests/bpf: test_xsk: Don't exit
 immediately when workers fail
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-9-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

TX and RX workers can fail in many places. These failures trigger a call
to exit_with_error() which exits the program immediately. It prevents the
following tests from running and isn't compliant with the CI.

Add return value to functions that can fail.
Handle failures more smoothly through report_failure().

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 110 +++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index edc4236bdd319d396196bb672c6b15617d37b380..516ebbf6248e4629acf69e9a16e2a46b19fdea81 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -142,24 +142,26 @@ static void umem_reset_alloc(struct xsk_umem_info *umem)
 	umem->next_buffer = 0;
 }
 
-static void enable_busy_poll(struct xsk_socket_info *xsk)
+static int enable_busy_poll(struct xsk_socket_info *xsk)
 {
 	int sock_opt;
 
 	sock_opt = 1;
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_PREFER_BUSY_POLL,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
-		exit_with_error(errno);
+		return -errno;
 
 	sock_opt = 20;
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
-		exit_with_error(errno);
+		return -errno;
 
 	sock_opt = xsk->batch_size;
 	if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_SOCKET, SO_BUSY_POLL_BUDGET,
 		       (void *)&sock_opt, sizeof(sock_opt)) < 0)
-		exit_with_error(errno);
+		return -errno;
+
+	return 0;
 }
 
 int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
@@ -769,7 +771,7 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	return true;
 }
 
-static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
+static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
 {
 	struct bpf_map *data_map;
 	int adjust_value = 0;
@@ -779,19 +781,21 @@ static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
 	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
 	if (!data_map || !bpf_map__is_internal(data_map)) {
 		ksft_print_msg("Error: could not find bss section of XDP program\n");
-		exit_with_error(errno);
+		return -EINVAL;
 	}
 
 	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
 	if (ret) {
 		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
-		exit_with_error(errno);
+		return ret;
 	}
 
 	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
 	 * helper is not supported. Skip the adjust_tail test case in this scenario.
 	 */
-	return adjust_value != -EOPNOTSUPP;
+	*supported = adjust_value != -EOPNOTSUPP;
+
+	return 0;
 }
 
 static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
@@ -1443,7 +1447,7 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	return TEST_PASS;
 }
 
-static void xsk_configure(struct test_spec *test, struct ifobject *ifobject,
+static int xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 			  struct xsk_umem_info *umem, bool tx)
 {
 	int i, ret;
@@ -1460,24 +1464,34 @@ static void xsk_configure(struct test_spec *test, struct ifobject *ifobject,
 
 			/* Retry if it fails as xsk_socket__create() is asynchronous */
 			if (ctr >= SOCK_RECONF_CTR)
-				exit_with_error(-ret);
+				return ret;
 			usleep(USLEEP_MAX);
 		}
-		if (ifobject->busy_poll)
-			enable_busy_poll(&ifobject->xsk_arr[i]);
+		if (ifobject->busy_poll) {
+			ret = enable_busy_poll(&ifobject->xsk_arr[i]);
+			if (ret)
+				return ret;
+		}
 	}
+
+	return 0;
 }
 
-static void thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
+static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobject)
 {
-	xsk_configure(test, ifobject, test->ifobj_rx->umem, true);
+	int ret = xsk_configure(test, ifobject, test->ifobj_rx->umem, true);
+
+	if (ret)
+		return ret;
 	ifobject->xsk = &ifobject->xsk_arr[0];
 	ifobject->xskmap = test->ifobj_rx->xskmap;
 	memcpy(ifobject->umem, test->ifobj_rx->umem, sizeof(struct xsk_umem_info));
 	ifobject->umem->base_addr = 0;
+
+	return 0;
 }
 
-static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream *pkt_stream,
+static int xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream *pkt_stream,
 				   bool fill_up)
 {
 	u32 rx_frame_size = umem->frame_size - XDP_PACKET_HEADROOM;
@@ -1491,7 +1505,7 @@ static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 
 	ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
 	if (ret != buffers_to_fill)
-		exit_with_error(ENOSPC);
+		return -ENOSPC;
 
 	while (filled < buffers_to_fill) {
 		struct pkt *pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &nb_pkts);
@@ -1519,9 +1533,11 @@ static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 
 	pkt_stream_reset(pkt_stream);
 	umem_reset_alloc(umem);
+
+	return 0;
 }
 
-static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
+static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
 	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
 	int mmap_flags;
@@ -1541,27 +1557,34 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 
 	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
 	if (bufs == MAP_FAILED)
-		exit_with_error(errno);
+		return -errno;
 
 	ret = xsk_configure_umem(ifobject, ifobject->umem, bufs, umem_sz);
 	if (ret)
-		exit_with_error(-ret);
+		return ret;
 
-	xsk_configure(test, ifobject, ifobject->umem, false);
+	ret = xsk_configure(test, ifobject, ifobject->umem, false);
+	if (ret)
+		return ret;
 
 	ifobject->xsk = &ifobject->xsk_arr[0];
 
 	if (!ifobject->rx_on)
-		return;
+		return 0;
 
-	xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream, ifobject->use_fill_ring);
+	ret = xsk_populate_fill_ring(ifobject->umem, ifobject->xsk->pkt_stream,
+				     ifobject->use_fill_ring);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < test->nb_sockets; i++) {
 		ifobject->xsk = &ifobject->xsk_arr[i];
 		ret = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, i);
 		if (ret)
-			exit_with_error(errno);
+			return ret;
 	}
+
+	return 0;
 }
 
 void *worker_testapp_validate_tx(void *arg)
@@ -1571,10 +1594,17 @@ void *worker_testapp_validate_tx(void *arg)
 	int err;
 
 	if (test->current_step == 1) {
-		if (!ifobject->shared_umem)
-			thread_common_ops(test, ifobject);
-		else
-			thread_common_ops_tx(test, ifobject);
+		if (!ifobject->shared_umem) {
+			if (thread_common_ops(test, ifobject)) {
+				report_failure(test);
+				pthread_exit(NULL);
+			}
+		} else {
+			if (thread_common_ops_tx(test, ifobject)) {
+				report_failure(test);
+				pthread_exit(NULL);
+			}
+		}
 	}
 
 	err = send_pkts(test, ifobject);
@@ -1594,29 +1624,41 @@ void *worker_testapp_validate_rx(void *arg)
 	int err;
 
 	if (test->current_step == 1) {
-		thread_common_ops(test, ifobject);
+		err = thread_common_ops(test, ifobject);
 	} else {
 		xsk_clear_xskmap(ifobject->xskmap);
 		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
-		if (err) {
+		if (err)
 			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
 				       strerror(-err));
-			exit_with_error(-err);
-		}
 	}
 
 	pthread_barrier_wait(&barr);
 
+	/* We leave only now in case of error to avoid getting stuck in the barrier */
+	if (err) {
+		report_failure(test);
+		pthread_exit(NULL);
+	}
+
 	err = receive_pkts(test);
 
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
 
 	if (err) {
-		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
-			test->adjust_tail_support = false;
-		else
+		if (!test->adjust_tail) {
 			report_failure(test);
+		} else {
+			bool supported;
+
+			if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
+				report_failure(test);
+			if (!supported)
+				test->adjust_tail_support = false;
+			else
+				report_failure(test);
+		}
 	}
 
 	pthread_exit(NULL);

-- 
2.50.1


