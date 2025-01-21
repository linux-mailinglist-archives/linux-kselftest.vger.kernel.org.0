Return-Path: <linux-kselftest+bounces-24860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6EA17E43
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C81889FB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1881F2C2D;
	Tue, 21 Jan 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qm7+dpma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B311854;
	Tue, 21 Jan 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464491; cv=none; b=DnB72xg2Y5XFnZtUFC1iBtX5Mio62KEDMaLZU34pD6G1Kbbyj+zHsxabexowZzHH2I9C4Q528CF9cH96Aq8cESiPeTiRcSq6nYBXBpG2P9/dTP94qTykNtCsNYBONRUcH5sFXia5dAjwoFiLxp0za/hMVW/ZPUf1GcqvmxqfoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464491; c=relaxed/simple;
	bh=HHMAoSlDJKVuP3dZJwRH8IxSoi8C8BICwbQWSIV3Grs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czGEA1OsTQ87xhaDOiaHVzr0l8cT4ci730AnSuRPLvFWkbyVO5jvHcCmFgULcZcbv8tAdb3r46HzVyKpo/k/BrvaKCRtst/JqvY8owvQZqmK73mXvx1URTXXpspiu6Zg/TIVyq8KADAMbC17FEBRMxUQYqL3XqARfpb11c+ZT7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qm7+dpma; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 835C81BF20B;
	Tue, 21 Jan 2025 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737464487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIP/D2kpXHuiCiA4b1FgciAkjA+I6XOT5D45XNGkmDE=;
	b=Qm7+dpma83ZiKVX4K2kBrlTWwAZWWimjTU/hV61rVRHcmaoSOcDqt/t39xr7IaqmiEqF65
	adY+fVRKRH+3K9Dmc2AP/HB2ucKg/RCuJOnqnvc68ROVaFqVVwTIcPVOLbttRFd9rSlulK
	q9xxrCNK5JBOItEC8F0pakh7XyLoG157ei9AX5fPOhxLpOEDEByiSth2Jv3KEuKGRTaqmG
	5a2TsDEO45e8UeX1k971YHAPjwegVni3yMM3fgHSuFIxwFui9aae5VSHODF93kUx0WCV7/
	al+yHkEhAzy5G/CCaKzb082qPZXSY9D8frkJEFN54e/RHQO1BknTVMRNjGpPSQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 14:01:23 +0100
Subject: [PATCH bpf-next v2 01/10] selftests/bpf: test_xdp_veth: Split
 network configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v2-1-fc9cacabc6b2@bootlin.com>
References: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v2-0-fc9cacabc6b2@bootlin.com>
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

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 78 +++++++++++++---------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 8d75424fe6bc8b2d4eeabe3ec49b883284c834e9..8dc28274a6e8fc75b05781d827a04f01e03a6ebb 100644
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
@@ -121,12 +131,9 @@ static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
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
@@ -141,25 +148,11 @@ static int configure_network(struct skeletons *skeletons)
 		    config[i].remote_veth);
 	}
 
-	/* Then configure the redirect map and attach programs to interfaces */
-	map_fd = bpf_map__fd(skeletons->xdp_redirect_maps->maps.tx_port);
-	if (!ASSERT_GE(map_fd, 0, "open redirect map"))
-		goto fail;
-	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		interface_id = if_nametoindex(config[i].next_veth);
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
@@ -184,6 +177,8 @@ static int check_ping(struct skeletons *skeletons)
 void test_xdp_veth_redirect(void)
 {
 	struct skeletons skeletons = {};
+	int map_fd;
+	int i;
 
 	skeletons.xdp_dummy = xdp_dummy__open_and_load();
 	if (!ASSERT_OK_PTR(skeletons.xdp_dummy, "xdp_dummy__open_and_load"))
@@ -197,9 +192,28 @@ void test_xdp_veth_redirect(void)
 	if (!ASSERT_OK_PTR(skeletons.xdp_redirect_maps, "xdp_redirect_map__open_and_load"))
 		goto destroy_xdp_tx;
 
-	if (configure_network(&skeletons))
+	if (create_network())
 		goto destroy_xdp_redirect_map;
 
+	/* Then configure the redirect map and attach programs to interfaces */
+	map_fd = bpf_map__fd(skeletons.xdp_redirect_maps->maps.tx_port);
+	if (!ASSERT_OK_FD(map_fd, "open redirect map"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		int interface_id;
+		int err;
+
+		interface_id = if_nametoindex(config[i].next_veth);
+		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
+			goto destroy_xdp_redirect_map;
+		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
+		if (!ASSERT_OK(err, "configure interface redirection through map"))
+			goto destroy_xdp_redirect_map;
+		if (attach_programs_to_veth_pair(&skeletons, i))
+			goto destroy_xdp_redirect_map;
+	}
+
 	ASSERT_OK(check_ping(&skeletons), "ping");
 
 destroy_xdp_redirect_map:

-- 
2.47.1


