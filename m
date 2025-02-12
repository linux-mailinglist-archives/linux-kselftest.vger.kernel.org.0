Return-Path: <linux-kselftest+bounces-26455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468CA3245F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AB6188BE5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116E20ADE0;
	Wed, 12 Feb 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cel54dTP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE122209F49;
	Wed, 12 Feb 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358680; cv=none; b=cQRF1K+fDAN7vqyr+TJ6QPWlsrksI6qYeLPO5Hk7DvFlnOVHG2SQF/Ij2CvFIKwaEqse9VpglyyWraDpcE56YL/C2ngREDyLRwnvC7motHKQJiqu2reg32T3CoWhMOxkwHd3+84XpZQDkjj6Nk0oslhXXVgZgxZy1N8QONPICqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358680; c=relaxed/simple;
	bh=mML3QKQYZej6FAetszH7V3AdRE3n++aer73FZa9YkTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDduOft8OrzeX/K7qShueFgmcJ+CoyDUoEVl7WOCOSxs5J520OiAbZg3+sMWH0LQ4CJXdlJ8IvxqHbS+yWP99D0YiWAA9eiW5MpvvtcDXvI6mGuHIlfX3ZX25m/tEIko0tNehF9UUbCU/GhZT2xTXEeH5i8Nv69ediqS07VmpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cel54dTP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20DE743315;
	Wed, 12 Feb 2025 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739358676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+mHmOr7kEFjb8pVExkvKZ/vFKSfAcAT8K4w57mYRhg=;
	b=cel54dTPOsh/BqH+CHXScE6Ife8/XYgJSz3P3LbFCcsytgIR60YtrwdHqw27x5thh+e/FT
	uVHzNKPDRb+G0B0XtKvY2AQr0zebhg1lj2cOPat/qshm3r803Q1kIBmvst7njgOutJshwl
	qJ0u3XPZwEXaUmfeObk2GkWBqK82/MSQBPXmxwLjjYGgZ5qcPMWsxGIptShYtlLiF/qPdv
	/srfpLMNwL3BOoQcBrXOq89OWlcCZxi5fld0BSklEZfYcDWi3UrBhw297NX5cdcXSGf3Rz
	A0xEecrfiyHWSX5lBTSaskun8yS+a71OdnvN16LX0JDcZswW9vWdFthcPN67Rg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 12:11:09 +0100
Subject: [PATCH bpf-next v5 1/6] selftests/bpf: test_xdp_veth: Create
 struct net_configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-redirect-multi-v5-1-fd0d39fca6e6@bootlin.com>
References: <20250212-redirect-multi-v5-0-fd0d39fca6e6@bootlin.com>
In-Reply-To: <20250212-redirect-multi-v5-0-fd0d39fca6e6@bootlin.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdehgegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfs
 gdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

The network configuration is defined by a table of struct
veth_configuration. This isn't convenient if we want to add a network
configuration that isn't linked to a veth pair.

Create a struct net_configuration that holds the veth_configuration
table to ease adding new configuration attributes in upcoming patch.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 108 +++++++++++----------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 73a440e44d5287ae6246e074737483f31aa484fb..4fa2b452de7c8361ec575d63a3ce6fbedc220773 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -51,27 +51,33 @@ struct veth_configuration {
 	char remote_addr[IP_MAX_LEN]; /* IP address of the remote veth */
 };
 
-static const struct veth_configuration default_config[VETH_PAIRS_COUNT] = {
-	{
-		.local_veth = "veth1-",
-		.remote_veth = "veth11",
-		.next_veth = 1,
-		.remote_addr = IP_SRC,
-		.namespace = "ns-veth11-"
-	},
-	{
-		.local_veth = "veth2-",
-		.remote_veth = "veth22",
-		.next_veth = 2,
-		.remote_addr = "",
-		.namespace = "ns-veth22-"
-	},
+struct net_configuration {
+	struct veth_configuration veth_cfg[VETH_PAIRS_COUNT];
+};
+
+static const struct net_configuration default_config = {
 	{
-		.local_veth = "veth3-",
-		.remote_veth = "veth33",
-		.next_veth = 0,
-		.remote_addr = IP_DST,
-		.namespace = "ns-veth33-"
+		{
+			.local_veth = "veth1-",
+			.remote_veth = "veth11",
+			.next_veth = 1,
+			.remote_addr = IP_SRC,
+			.namespace = "ns-veth11-"
+		},
+		{
+			.local_veth = "veth2-",
+			.remote_veth = "veth22",
+			.next_veth = 2,
+			.remote_addr = "",
+			.namespace = "ns-veth22-"
+		},
+		{
+			.local_veth = "veth3-",
+			.remote_veth = "veth33",
+			.next_veth = 0,
+			.remote_addr = IP_DST,
+			.namespace = "ns-veth33-"
+		}
 	}
 };
 
@@ -83,7 +89,7 @@ struct prog_configuration {
 };
 
 static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
-					struct veth_configuration *net_config,
+					struct net_configuration *net_config,
 					struct prog_configuration *prog, int index)
 {
 	struct bpf_program *local_prog, *remote_prog;
@@ -106,7 +112,7 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 	if (!ASSERT_OK_PTR(remote_prog, "find remote program"))
 		return -1;
 
-	interface = if_nametoindex(net_config[index].local_veth);
+	interface = if_nametoindex(net_config->veth_cfg[index].local_veth);
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
 		return -1;
 
@@ -115,11 +121,11 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 	if (!ASSERT_OK(ret, "attach xdp program to local veth"))
 		return -1;
 
-	nstoken = open_netns(net_config[index].namespace);
+	nstoken = open_netns(net_config->veth_cfg[index].namespace);
 	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
 		return -1;
 
-	interface = if_nametoindex(net_config[index].remote_veth);
+	interface = if_nametoindex(net_config->veth_cfg[index].remote_veth);
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index")) {
 		close_netns(nstoken);
 		return -1;
@@ -136,31 +142,34 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 	return 0;
 }
 
-static int create_network(struct veth_configuration *net_config)
+static int create_network(struct net_configuration *net_config)
 {
 	int i, err;
 
-	memcpy(net_config, default_config, VETH_PAIRS_COUNT * sizeof(struct veth_configuration));
+	memcpy(net_config, &default_config, sizeof(struct net_configuration));
 
 	/* First create and configure all interfaces */
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		err = append_tid(net_config[i].namespace, NS_NAME_MAX_LEN);
+		err = append_tid(net_config->veth_cfg[i].namespace, NS_NAME_MAX_LEN);
 		if (!ASSERT_OK(err, "append TID to ns name"))
 			return -1;
 
-		err = append_tid(net_config[i].local_veth, VETH_NAME_MAX_LEN);
+		err = append_tid(net_config->veth_cfg[i].local_veth, VETH_NAME_MAX_LEN);
 		if (!ASSERT_OK(err, "append TID to local veth name"))
 			return -1;
 
-		SYS(fail, "ip netns add %s", net_config[i].namespace);
+		SYS(fail, "ip netns add %s", net_config->veth_cfg[i].namespace);
 		SYS(fail, "ip link add %s type veth peer name %s netns %s",
-		    net_config[i].local_veth, net_config[i].remote_veth, net_config[i].namespace);
-		SYS(fail, "ip link set dev %s up", net_config[i].local_veth);
-		if (net_config[i].remote_addr[0])
-			SYS(fail, "ip -n %s addr add %s/24 dev %s",	net_config[i].namespace,
-			    net_config[i].remote_addr, net_config[i].remote_veth);
-		SYS(fail, "ip -n %s link set dev %s up", net_config[i].namespace,
-		    net_config[i].remote_veth);
+		    net_config->veth_cfg[i].local_veth, net_config->veth_cfg[i].remote_veth,
+		    net_config->veth_cfg[i].namespace);
+		SYS(fail, "ip link set dev %s up", net_config->veth_cfg[i].local_veth);
+		if (net_config->veth_cfg[i].remote_addr[0])
+			SYS(fail, "ip -n %s addr add %s/24 dev %s",
+			    net_config->veth_cfg[i].namespace,
+			    net_config->veth_cfg[i].remote_addr,
+			    net_config->veth_cfg[i].remote_veth);
+		SYS(fail, "ip -n %s link set dev %s up", net_config->veth_cfg[i].namespace,
+		    net_config->veth_cfg[i].remote_veth);
 	}
 
 	return 0;
@@ -169,21 +178,22 @@ static int create_network(struct veth_configuration *net_config)
 	return -1;
 }
 
-static void cleanup_network(struct veth_configuration *net_config)
+static void cleanup_network(struct net_configuration *net_config)
 {
 	struct nstoken *nstoken;
 	int i;
 
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		bpf_xdp_detach(if_nametoindex(net_config[i].local_veth), 0, NULL);
-		nstoken = open_netns(net_config[i].namespace);
+		bpf_xdp_detach(if_nametoindex(net_config->veth_cfg[i].local_veth), 0, NULL);
+		nstoken = open_netns(net_config->veth_cfg[i].namespace);
 		if (nstoken) {
-			bpf_xdp_detach(if_nametoindex(net_config[i].remote_veth), 0, NULL);
+			bpf_xdp_detach(if_nametoindex(net_config->veth_cfg[i].remote_veth),
+				       0, NULL);
 			close_netns(nstoken);
 		}
 		/* in case the detach failed */
-		SYS_NOFAIL("ip link del %s", net_config[i].local_veth);
-		SYS_NOFAIL("ip netns del %s", net_config[i].namespace);
+		SYS_NOFAIL("ip link del %s", net_config->veth_cfg[i].local_veth);
+		SYS_NOFAIL("ip netns del %s", net_config->veth_cfg[i].namespace);
 	}
 }
 
@@ -210,9 +220,9 @@ static void xdp_veth_redirect(u32 flags)
 			.remote_flags = flags,
 		}
 	};
-	struct veth_configuration net_config[VETH_PAIRS_COUNT];
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];
 	struct xdp_redirect_map *xdp_redirect_map;
+	struct net_configuration net_config;
 	struct xdp_dummy *xdp_dummy;
 	struct xdp_tx *xdp_tx;
 	int map_fd;
@@ -230,7 +240,7 @@ static void xdp_veth_redirect(u32 flags)
 	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
 		goto destroy_xdp_tx;
 
-	if (!ASSERT_OK(create_network(net_config), "create network"))
+	if (!ASSERT_OK(create_network(&net_config), "create network"))
 		goto destroy_xdp_redirect_map;
 
 	/* Then configure the redirect map and attach programs to interfaces */
@@ -242,18 +252,18 @@ static void xdp_veth_redirect(u32 flags)
 	bpf_objs[1] = xdp_tx->obj;
 	bpf_objs[2] = xdp_redirect_map->obj;
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		int next_veth = net_config[i].next_veth;
+		int next_veth = net_config.veth_cfg[i].next_veth;
 		int interface_id;
 		int err;
 
-		interface_id = if_nametoindex(net_config[next_veth].local_veth);
+		interface_id = if_nametoindex(net_config.veth_cfg[next_veth].local_veth);
 		if (!ASSERT_NEQ(interface_id, 0, "non zero interface index"))
 			goto destroy_xdp_redirect_map;
 		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
 		if (!ASSERT_OK(err, "configure interface redirection through map"))
 			goto destroy_xdp_redirect_map;
 		if (attach_programs_to_veth_pair(bpf_objs, VETH_REDIRECT_SKEL_NB,
-						 net_config, ping_config, i))
+						 &net_config, ping_config, i))
 			goto destroy_xdp_redirect_map;
 	}
 
@@ -261,7 +271,7 @@ static void xdp_veth_redirect(u32 flags)
 	 * veth33 from veth11
 	 */
 	ASSERT_OK(SYS_NOFAIL("ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
-			     net_config[0].namespace, IP_DST), "ping");
+			     net_config.veth_cfg[0].namespace, IP_DST), "ping");
 
 destroy_xdp_redirect_map:
 	xdp_redirect_map__destroy(xdp_redirect_map);
@@ -270,7 +280,7 @@ static void xdp_veth_redirect(u32 flags)
 destroy_xdp_dummy:
 	xdp_dummy__destroy(xdp_dummy);
 
-	cleanup_network(net_config);
+	cleanup_network(&net_config);
 }
 
 void test_xdp_veth_redirect(void)

-- 
2.48.1


