Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE184EEF9F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiDAO3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbiDAO2a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6E234059;
        Fri,  1 Apr 2022 07:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E7B761C43;
        Fri,  1 Apr 2022 14:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06816C36AE3;
        Fri,  1 Apr 2022 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823199;
        bh=jKNvzhTmBysBgJ4fKzDMdHdD5CLp1/4zLk4B3J4TBes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkhxT8YTda8seWpz9X8Ydanup3E/1r2Dyt/ubOJd+p3lFpFoEWCLp0JHwq7fuSTYM
         OzT8R0ARX4cFEJEWlYmI50BAZYhgQZbjipeIaNsEj5r4knYBu4l6AdUU/ioCOpUlPn
         YP8had8Gv/ip5Q/8UdAs9A+8sMrX0Uza5Mk6GO1BKpaeRmPz9l5rtAjdgsPYhBUHwT
         dt+uD6+NLMRQX3OqeTe0YaTl2pKaqaVe483vbRrKBPp7CFU+Nv3e/JeulVKoj0TGQm
         9FRlrEK0pugrRiGdudLDa30L6QMrzEgEDFG1Uh7s8HF143eDufbI5e4X1XR7lIR7F1
         cI1Vt+emFuhlg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        shuah@kernel.org, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 019/149] selftests, xsk: Fix bpf_res cleanup test
Date:   Fri,  1 Apr 2022 10:23:26 -0400
Message-Id: <20220401142536.1948161-19-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401142536.1948161-1-sashal@kernel.org>
References: <20220401142536.1948161-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

[ Upstream commit 3b22523bca02b0d5618c08b93d8fd1fb578e1cc3 ]

After commit 710ad98c363a ("veth: Do not record rx queue hint in veth_xmit"),
veth no longer receives traffic on the same queue as it was sent on. This
breaks the bpf_res test for the AF_XDP selftests as the socket tied to
queue 1 will not receive traffic anymore.

Modify the test so that two sockets are tied to queue id 0 using a shared
umem instead. When killing the first socket enter the second socket into
the xskmap so that traffic will flow to it. This will still test that the
resources are not cleaned up until after the second socket dies, without
having to rely on veth supporting rx_queue hints.

Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20220125082945.26179-1-magnus.karlsson@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/xdpxceiver.c | 80 +++++++++++++++---------
 tools/testing/selftests/bpf/xdpxceiver.h |  2 +-
 2 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdpxceiver.c b/tools/testing/selftests/bpf/xdpxceiver.c
index 0a5d23da486d..4686897181b6 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.c
+++ b/tools/testing/selftests/bpf/xdpxceiver.c
@@ -266,22 +266,24 @@ static int xsk_configure_umem(struct xsk_umem_info *umem, void *buffer, u64 size
 }
 
 static int xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_info *umem,
-				struct ifobject *ifobject, u32 qid)
+				struct ifobject *ifobject, bool shared)
 {
-	struct xsk_socket_config cfg;
+	struct xsk_socket_config cfg = {};
 	struct xsk_ring_cons *rxr;
 	struct xsk_ring_prod *txr;
 
 	xsk->umem = umem;
 	cfg.rx_size = xsk->rxqsize;
 	cfg.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
-	cfg.libbpf_flags = 0;
+	cfg.libbpf_flags = XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD;
 	cfg.xdp_flags = ifobject->xdp_flags;
 	cfg.bind_flags = ifobject->bind_flags;
+	if (shared)
+		cfg.bind_flags |= XDP_SHARED_UMEM;
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
-	return xsk_socket__create(&xsk->xsk, ifobject->ifname, qid, umem->umem, rxr, txr, &cfg);
+	return xsk_socket__create(&xsk->xsk, ifobject->ifname, 0, umem->umem, rxr, txr, &cfg);
 }
 
 static struct option long_options[] = {
@@ -387,7 +389,6 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 	for (i = 0; i < MAX_INTERFACES; i++) {
 		struct ifobject *ifobj = i ? ifobj_rx : ifobj_tx;
 
-		ifobj->umem = &ifobj->umem_arr[0];
 		ifobj->xsk = &ifobj->xsk_arr[0];
 		ifobj->use_poll = false;
 		ifobj->pacing_on = true;
@@ -401,11 +402,12 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
 			ifobj->tx_on = false;
 		}
 
+		memset(ifobj->umem, 0, sizeof(*ifobj->umem));
+		ifobj->umem->num_frames = DEFAULT_UMEM_BUFFERS;
+		ifobj->umem->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
+
 		for (j = 0; j < MAX_SOCKETS; j++) {
-			memset(&ifobj->umem_arr[j], 0, sizeof(ifobj->umem_arr[j]));
 			memset(&ifobj->xsk_arr[j], 0, sizeof(ifobj->xsk_arr[j]));
-			ifobj->umem_arr[j].num_frames = DEFAULT_UMEM_BUFFERS;
-			ifobj->umem_arr[j].frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 			ifobj->xsk_arr[j].rxqsize = XSK_RING_CONS__DEFAULT_NUM_DESCS;
 		}
 	}
@@ -947,7 +949,10 @@ static void tx_stats_validate(struct ifobject *ifobject)
 
 static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 {
+	u64 umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
 	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
+	int ret, ifindex;
+	void *bufs;
 	u32 i;
 
 	ifobject->ns_fd = switch_namespace(ifobject->nsname);
@@ -955,23 +960,20 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (ifobject->umem->unaligned_mode)
 		mmap_flags |= MAP_HUGETLB;
 
-	for (i = 0; i < test->nb_sockets; i++) {
-		u64 umem_sz = ifobject->umem->num_frames * ifobject->umem->frame_size;
-		u32 ctr = 0;
-		void *bufs;
-		int ret;
+	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
+	if (bufs == MAP_FAILED)
+		exit_with_error(errno);
 
-		bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
-		if (bufs == MAP_FAILED)
-			exit_with_error(errno);
+	ret = xsk_configure_umem(ifobject->umem, bufs, umem_sz);
+	if (ret)
+		exit_with_error(-ret);
 
-		ret = xsk_configure_umem(&ifobject->umem_arr[i], bufs, umem_sz);
-		if (ret)
-			exit_with_error(-ret);
+	for (i = 0; i < test->nb_sockets; i++) {
+		u32 ctr = 0;
 
 		while (ctr++ < SOCK_RECONF_CTR) {
-			ret = xsk_configure_socket(&ifobject->xsk_arr[i], &ifobject->umem_arr[i],
-						   ifobject, i);
+			ret = xsk_configure_socket(&ifobject->xsk_arr[i], ifobject->umem,
+						   ifobject, !!i);
 			if (!ret)
 				break;
 
@@ -982,8 +984,22 @@ static void thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 		}
 	}
 
-	ifobject->umem = &ifobject->umem_arr[0];
 	ifobject->xsk = &ifobject->xsk_arr[0];
+
+	if (!ifobject->rx_on)
+		return;
+
+	ifindex = if_nametoindex(ifobject->ifname);
+	if (!ifindex)
+		exit_with_error(errno);
+
+	ret = xsk_setup_xdp_prog(ifindex, &ifobject->xsk_map_fd);
+	if (ret)
+		exit_with_error(-ret);
+
+	ret = xsk_socket__update_xskmap(ifobject->xsk->xsk, ifobject->xsk_map_fd);
+	if (ret)
+		exit_with_error(-ret);
 }
 
 static void testapp_cleanup_xsk_res(struct ifobject *ifobj)
@@ -1139,14 +1155,16 @@ static void testapp_bidi(struct test_spec *test)
 
 static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj_rx)
 {
+	int ret;
+
 	xsk_socket__delete(ifobj_tx->xsk->xsk);
-	xsk_umem__delete(ifobj_tx->umem->umem);
 	xsk_socket__delete(ifobj_rx->xsk->xsk);
-	xsk_umem__delete(ifobj_rx->umem->umem);
-	ifobj_tx->umem = &ifobj_tx->umem_arr[1];
 	ifobj_tx->xsk = &ifobj_tx->xsk_arr[1];
-	ifobj_rx->umem = &ifobj_rx->umem_arr[1];
 	ifobj_rx->xsk = &ifobj_rx->xsk_arr[1];
+
+	ret = xsk_socket__update_xskmap(ifobj_rx->xsk->xsk, ifobj_rx->xsk_map_fd);
+	if (ret)
+		exit_with_error(-ret);
 }
 
 static void testapp_bpf_res(struct test_spec *test)
@@ -1405,13 +1423,13 @@ static struct ifobject *ifobject_create(void)
 	if (!ifobj->xsk_arr)
 		goto out_xsk_arr;
 
-	ifobj->umem_arr = calloc(MAX_SOCKETS, sizeof(*ifobj->umem_arr));
-	if (!ifobj->umem_arr)
-		goto out_umem_arr;
+	ifobj->umem = calloc(1, sizeof(*ifobj->umem));
+	if (!ifobj->umem)
+		goto out_umem;
 
 	return ifobj;
 
-out_umem_arr:
+out_umem:
 	free(ifobj->xsk_arr);
 out_xsk_arr:
 	free(ifobj);
@@ -1420,7 +1438,7 @@ static struct ifobject *ifobject_create(void)
 
 static void ifobject_delete(struct ifobject *ifobj)
 {
-	free(ifobj->umem_arr);
+	free(ifobj->umem);
 	free(ifobj->xsk_arr);
 	free(ifobj);
 }
diff --git a/tools/testing/selftests/bpf/xdpxceiver.h b/tools/testing/selftests/bpf/xdpxceiver.h
index 2f705f44b748..62a3e6388632 100644
--- a/tools/testing/selftests/bpf/xdpxceiver.h
+++ b/tools/testing/selftests/bpf/xdpxceiver.h
@@ -125,10 +125,10 @@ struct ifobject {
 	struct xsk_socket_info *xsk;
 	struct xsk_socket_info *xsk_arr;
 	struct xsk_umem_info *umem;
-	struct xsk_umem_info *umem_arr;
 	thread_func_t func_ptr;
 	struct pkt_stream *pkt_stream;
 	int ns_fd;
+	int xsk_map_fd;
 	u32 dst_ip;
 	u32 src_ip;
 	u32 xdp_flags;
-- 
2.34.1

