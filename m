Return-Path: <linux-kselftest+bounces-25285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C57A207F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 11:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B313D3A8C08
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBF1A9B27;
	Tue, 28 Jan 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jPI0HlvI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C61A23AC;
	Tue, 28 Jan 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058269; cv=none; b=a6CA4LpbcsT2pxVNL9zETvkZW7sDJzGETqv9GxDvMsZSZ0WJCUJeOHdAnihzXhvwU/B7OAScbeprddTF+zAL99KYkCbqYbzZhbo2KXgf7Xs6o3PNZNivtbbLn16g2vAVWo1y3plHrihgd04JJNYdnt2Vv6Dti0goBIQIhWsV7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058269; c=relaxed/simple;
	bh=gFLKuL6G55TUy+IWxGtTNF0lqi9FMxeV1c/9dvvMhsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2JTyKVtIJRUHZEf8iXVCktaxWW4VCGQUoBbB00P1q0F8r0zCjJH1KTS1US2uWRTqsVH1/Wuwr8CCnjTgeDsOV0uts4OY0dj77J4y5KkMk9FvZd8HeyDi222DXPphaqK2sY7rNu/BvxDSUqg7Ulm2tFlxGrg3LXvaGiaeXdGDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jPI0HlvI; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E0ED1C0003;
	Tue, 28 Jan 2025 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738058264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7P+x0n8lJBtCDpe4AAhhE/ki5FufYoGxSglBVU6SPOs=;
	b=jPI0HlvIL/Bfkg52uvM24Tl2y+mv44NmrZl4pyQOMDNv3I96cl7zmMoeVmp7cGNrcjIEu0
	2ousqxQq0s7LIWrMO7Bw9+ujGV4g2ig8ud+Qj5htyuV2idyebgrwJJE9R9SsPtZ+3pbQju
	7KkWYakTWkpkxSbvppUOhIrPqTsTAtnwpAI9JCNJxPhSeZHAD783qgSNl4Wp2cAZph+ekg
	iomPE3agP5dE5crUYH0q55Tks0oIoXTA4WxQZ47WI/ZNwE1kNWs90omLo8o6dLYOYgKIYA
	CaqX2CJo7RDfGMQpj7KYYZuhvbx0AWrXvG+jnMNODFhsJ03cGUIEO0FcZtuDEg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 28 Jan 2025 10:57:29 +0100
Subject: [PATCH bpf-next v3 05/14] selftests/bpf: test_xdp_veth: Split
 network configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-redirect-multi-v3-5-c1ce69997c01@bootlin.com>
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
In-Reply-To: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

configure_network() does two things : it first creates the network
topology and then configures the BPF maps to fit the test needs. This
isn't convenient if we want to re-use the same network topology for
different test cases.

Rename configure_network() create_network().
Move the BPF configuration to the test itself.
Split the test description in two parts, first the description of the
network topology, then the description of the test case.
Remove the veth indexes from the ASCII art as dynamic ones are used

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 81 +++++++++++++---------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 942c6e99e15ef69003c033e7bc1bfc9bc9777557..710136861bda7607dcaca6186b5acfe0082a870c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -3,17 +3,27 @@
 /* Create 3 namespaces with 3 veth peers, and forward packets in-between using
  * native XDP
  *
- *                      XDP_TX
- * NS1(veth11)        NS2(veth22)        NS3(veth33)
- *      |                  |                  |
- *      |                  |                  |
- *   (veth1,            (veth2,            (veth3,
- *   id:111)            id:122)            id:133)
- *     ^ |                ^ |                ^ |
- *     | |  XDP_REDIRECT  | |  XDP_REDIRECT  | |
- *     | ------------------ ------------------ |
- *     -----------------------------------------
- *                    XDP_REDIRECT
+ * Network topology:
+ *  ----------        ----------       ----------
+ *  |  NS1   |        |  NS2   |       |  NS3   |
+ *  | veth11 |        | veth22 |       | veth33 |
+ *  ----|-----        -----|----       -----|----
+ *      |                  |                |
+ *    veth1              veth2            veth3
+ *
+ * Test cases:
+ *  - [test_xdp_veth_redirect] : ping veth33 from veth11
+ *
+ *    veth11             veth22              veth33
+ *  (XDP_PASS)          (XDP_TX)           (XDP_PASS)
+ *       |                  |                  |
+ *       |                  |                  |
+ *     veth1             veth2              veth3
+ * (XDP_REDIRECT)     (XDP_REDIRECT)     (XDP_REDIRECT)
+ *      ^ |                ^ |                ^ |
+ *      | |                | |                | |
+ *      | ------------------ ------------------ |
+ *      -----------------------------------------
  */
 
 #define _GNU_SOURCE
@@ -119,12 +129,9 @@ static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
 	return 0;
 }
 
-static int configure_network(struct skeletons *skeletons)
+static int create_network(void)
 {
-	int interface_id;
-	int map_fd;
-	int err;
-	int i = 0;
+	int i;
 
 	/* First create and configure all interfaces */
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
@@ -139,27 +146,11 @@ static int configure_network(struct skeletons *skeletons)
 		    config[i].remote_veth);
 	}
 
-	/* Then configure the redirect map and attach programs to interfaces */
-	map_fd = bpf_map__fd(skeletons->xdp_redirect_maps->maps.tx_port);
-	if (!ASSERT_GE(map_fd, 0, "open redirect map"))
-		goto fail;
-	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		int next_veth = config[i].next_veth;
-
-		interface_id = if_nametoindex(config[next_veth].local_veth);
-		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
-			goto fail;
-		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
-		if (!ASSERT_OK(err, "configure interface redirection through map"))
-			goto fail;
-		if (attach_programs_to_veth_pair(skeletons, i))
-			goto fail;
-	}
-
 	return 0;
 
 fail:
 	return -1;
+
 }
 
 static void cleanup_network(void)
@@ -175,6 +166,8 @@ static void cleanup_network(void)
 void test_xdp_veth_redirect(void)
 {
 	struct skeletons skeletons = {};
+	int map_fd;
+	int i;
 
 	skeletons.xdp_dummy = xdp_dummy__open_and_load();
 	if (!ASSERT_OK_PTR(skeletons.xdp_dummy, "xdp_dummy__open_and_load"))
@@ -188,9 +181,29 @@ void test_xdp_veth_redirect(void)
 	if (!ASSERT_OK_PTR(skeletons.xdp_redirect_maps, "xdp_redirect_map__open_and_load"))
 		goto destroy_xdp_tx;
 
-	if (configure_network(&skeletons))
+	if (!ASSERT_OK(create_network(), "create_network"))
 		goto destroy_xdp_redirect_map;
 
+	/* Then configure the redirect map and attach programs to interfaces */
+	map_fd = bpf_map__fd(skeletons.xdp_redirect_maps->maps.tx_port);
+	if (!ASSERT_OK_FD(map_fd, "open redirect map"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		int next_veth = config[i].next_veth;
+		int interface_id;
+		int err;
+
+		interface_id = if_nametoindex(config[next_veth].local_veth);
+		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
+			goto destroy_xdp_redirect_map;
+		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
+		if (!ASSERT_OK(err, "configure interface redirection through map"))
+			goto destroy_xdp_redirect_map;
+		if (attach_programs_to_veth_pair(&skeletons, i))
+			goto destroy_xdp_redirect_map;
+	}
+
 	/* Test: if all interfaces are properly configured, we must be able to ping
 	 * veth33 from veth11
 	 */

-- 
2.47.1


