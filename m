Return-Path: <linux-kselftest+bounces-28911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AEA5F159
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E31A1890D95
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468D267390;
	Thu, 13 Mar 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n4cGp0P+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261C265CCF;
	Thu, 13 Mar 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862899; cv=none; b=pczwFSFX40im9NiKUGzgBxVBMlba5XqoD9tvr5PaXy10IVGaA6abG/gjHyhO6cFFtaa3He5oxyl/QfqXj3HCvlIHe8Z3ZhebdxAtXD8E4PeZwI7TWyWnaL+qknqJeMYQxm45vhWYXym2OYtuwOvjDOi+KCGuSrlF/1wF/KEO7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862899; c=relaxed/simple;
	bh=Ve9N1h7ouJni5oy51G3n9jOnTyZH5RmP6EvWbfqaK5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i033YTK5Jhr5Cdy/y3H0ijlghJNGWehIolpkaJ6+FTsm64HIv59zDol9/tU6b9fTD+QOaWEEtylOxN7A9+MsmVUfoomAlVZNg7FczGC9dHpg/Uujr5ZPAiZzFxzFFKlFzHJYnTNMuxe91javuAjGS/oN/loLiGcPE3uw0iEL2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n4cGp0P+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4353B43233;
	Thu, 13 Mar 2025 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741862894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBaFUMtyZtiGjmvEITAWPoj/RaRBon1Wk8I3WHtBRkU=;
	b=n4cGp0P+//ikLbhyWHE/cP6qPPEIYDpVYb5ccjjm6tJfmPO8W3KHvI/pmW0XhCdB9oJ7jn
	BE9m5Y3ZHXTveBzHADAp8MiWv4W8ktlCdiXd3g+c3P1WKYIJKyTJTgaJ8WLmRcvCMQMoy2
	4HhXucDnS5RzXceOSIJZfehZeliF5FNHmCu8CwNYFao1TbKOKww2F1g3Ko02sjN0qXpMHq
	933lzoDnPpVDPk71GsFmK2VjaNeutujq+A8Nt1ZJtVfp+z+ripVTpP1pTCVAkpZFGmvW/4
	9YaaZ850XUvq+SqfYv+sEJpNAyW9+748TfL66xcnJDwuWB/EMn3l9HtSfvaRcw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 13 Mar 2025 11:48:05 +0100
Subject: [PATCH 07/13] selftests/bpf: test_xsk: Don't exit immediately when
 workers fail
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-xsk-v1-7-7374729a93b9@bootlin.com>
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
In-Reply-To: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepvdgrtddumegtsgduleemkedvheefmeguuddttdemfhelvgdumeeftgejudemjeeitdgtmedutggsrgenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekvdehfeemugdutddtmehflegvudemfegtjedumeejiedttgemudgtsggrpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthhopehmrghgnhhushdrkhgrrhhlshhsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

TX and RX workers can fail in many places. These failures trigger a call
to exit_on_error() which exits the program immediately and can lead to
memory leak.

Add return value to functions that can fail.
Handle failures more smoothly through report_failure().

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 89 +++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 5b96f6860ff98de3c6160a1b94ae865a12121382..5b1b05c21a04e05673d01855567320452db1f9c5 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -235,24 +235,26 @@ static void umem_reset_alloc(struct xsk_umem_info *umem)
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
 
 static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
@@ -1627,7 +1629,7 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	return TEST_PASS;
 }
 
-static void xsk_configure_socket(struct test_spec *test, struct ifobject *ifobject,
+static int xsk_configure_socket(struct test_spec *test, struct ifobject *ifobject,
 				 struct xsk_umem_info *umem, bool tx)
 {
 	int i, ret;
@@ -1644,24 +1646,34 @@ static void xsk_configure_socket(struct test_spec *test, struct ifobject *ifobje
 
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
-	xsk_configure_socket(test, ifobject, test->ifobj_rx->umem, true);
+	int ret = xsk_configure_socket(test, ifobject, test->ifobj_rx->umem, true);
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
@@ -1675,7 +1687,7 @@ static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 
 	ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
 	if (ret != buffers_to_fill)
-		exit_with_error(ENOSPC);
+		return -ENOSPC;
 
 	while (filled < buffers_to_fill) {
 		struct pkt *pkt = pkt_stream_get_next_rx_pkt(pkt_stream, &nb_pkts);
@@ -1703,9 +1715,11 @@ static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 
 	pkt_stream_reset(pkt_stream);
 	umem_reset_alloc(umem);
+
+	return 0;
 }
 
-static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
+static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
 	u64 umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
@@ -1722,27 +1736,34 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 
 	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
 	if (bufs == MAP_FAILED)
-		exit_with_error(errno);
+		return -errno;
 
 	ret = xsk_configure_umem(ifobject, ifobject->umem, bufs, umem_sz);
 	if (ret)
-		exit_with_error(-ret);
+		return ret;
 
-	xsk_configure_socket(test, ifobject, ifobject->umem, false);
+	ret = xsk_configure_socket(test, ifobject, ifobject->umem, false);
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
 
 static void *worker_testapp_validate_tx(void *arg)
@@ -1752,10 +1773,17 @@ static void *worker_testapp_validate_tx(void *arg)
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
@@ -1775,19 +1803,22 @@ static void *worker_testapp_validate_rx(void *arg)
 	int err;
 
 	if (test->current_step == 1) {
-		thread_common_ops(test, ifobject);
+		err = thread_common_ops(test, ifobject);
 	} else {
 		xsk_clear_xskmap(ifobject->xskmap);
 		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
-		if (err) {
-			print_msg("Error: Failed to update xskmap, error %s\n",
-				       strerror(-err));
-			exit_with_error(-err);
-		}
+		if (err)
+			print_msg("Error: Failed to update xskmap, error %s\n", strerror(-err));
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

-- 
2.48.1


