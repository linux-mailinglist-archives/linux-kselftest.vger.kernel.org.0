Return-Path: <linux-kselftest+bounces-26456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057FA32464
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C522E188C0A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D720B1ED;
	Wed, 12 Feb 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EPlw+Tvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496A209F46;
	Wed, 12 Feb 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358682; cv=none; b=t0cCdWuLaAEbJuiSfzlt+z7igcZJHiCk/RRS1IMsv520cOULT90XmLjcdWOBD3hzaLOrDQM+V987UbDwdIp7gXk5j57QsHbrl7/mcnAkxZdND+c0s0ZVRZ1gatWDyvtQ0lRwf7RXkINanV4weNVlHjKdg4sO7qhjdTMmjiImboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358682; c=relaxed/simple;
	bh=MzSWdPosDdxdBkf1z+KXK6OUeFXB9MBq/QdiKYjFrXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSkQindN5khgk96fnP+1sEJk//tnMJe+VfGzCYwYgTC6peYhcIgLlJL7J3T+jSbgWa7O3HoWDGpT1iYRX8I/mjy13K9j3ZbDZH4zBskuV6AhthJ0TlJ2C7NFfBfUvKnydLl1KejC3FvrpkuRO8yEnSDGo3VxotQgg1cb3e+BBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EPlw+Tvh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69E71432FA;
	Wed, 12 Feb 2025 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739358677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj5o7NoQNqJlyyY9DzCVHS3ItyDIwLAnEb3Fe3jd0qQ=;
	b=EPlw+Tvhs+blWX027JMGx+njY4Kf6nLTeqCtleQrXNzMybW+OcOyveSGTfthndxl1jIorT
	v6J/hwbrmumaIPXKv7EGpNE1K/GfRYrjT76QoFlgYOMzXVWT0yfb+VXC/waNwoYK+UseJE
	so7vh8AevinS+YYpM4XPFgBbsbQVH5Y7pkpvqMU+uwL8jPYut+NVp7SYvA28b34fK7tia9
	EpOgrnuyoSVNjVZgOMoN7kaAllcaq3Iwf7H690wXSW/eUyIr3htBT6axPdWO1NVNdpNTrr
	lkhm780mxOqaE5Yvg+Q9p1Uy54MPVqgBXou9y0mq8XqvgNC92Vs9ll2I2vK0uA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 12:11:10 +0100
Subject: [PATCH bpf-next v5 2/6] selftests/bpf: test_xdp_veth: Use a
 dedicated namespace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-redirect-multi-v5-2-fd0d39fca6e6@bootlin.com>
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

Tests use the root network namespace, so they aren't fully independent
of each other. For instance, the index of the created veth interfaces
is incremented every time a new test is launched.

Wrap the network topology in a network namespace to ensure full
isolation. Use the append_tid() helper to ensure the uniqueness of this
namespace's name during parallel runs.
Remove the use of the append_tid() on the veth names as they now belong
to an already unique namespace.
Simplify cleanup_network() by directly deleting the namespaces

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 52 ++++++++++++++--------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 4fa2b452de7c8361ec575d63a3ce6fbedc220773..a1c79af23bec25529af5b549d16b2cbfaf1cebd4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -9,7 +9,11 @@
  *  | veth11 |        | veth22 |       | veth33 |
  *  ----|-----        -----|----       -----|----
  *      |                  |                |
- *    veth1              veth2            veth3
+ *  ----|------------------|----------------|----
+ *  | veth1              veth2            veth3 |
+ *  |                                           |
+ *  |                     NSO                   |
+ *  ---------------------------------------------
  *
  * Test cases:
  *  - [test_xdp_veth_redirect] : ping veth33 from veth11
@@ -52,10 +56,12 @@ struct veth_configuration {
 };
 
 struct net_configuration {
+	char ns0_name[NS_NAME_MAX_LEN];
 	struct veth_configuration veth_cfg[VETH_PAIRS_COUNT];
 };
 
 static const struct net_configuration default_config = {
+	.ns0_name = "ns0-",
 	{
 		{
 			.local_veth = "veth1-",
@@ -144,21 +150,30 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 
 static int create_network(struct net_configuration *net_config)
 {
+	struct nstoken *nstoken = NULL;
 	int i, err;
 
 	memcpy(net_config, &default_config, sizeof(struct net_configuration));
 
-	/* First create and configure all interfaces */
+	/* Create unique namespaces */
+	err = append_tid(net_config->ns0_name, NS_NAME_MAX_LEN);
+	if (!ASSERT_OK(err, "append TID to ns0 name"))
+		goto fail;
+	SYS(fail, "ip netns add %s", net_config->ns0_name);
+
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
 		err = append_tid(net_config->veth_cfg[i].namespace, NS_NAME_MAX_LEN);
 		if (!ASSERT_OK(err, "append TID to ns name"))
-			return -1;
+			goto fail;
+		SYS(fail, "ip netns add %s", net_config->veth_cfg[i].namespace);
+	}
 
-		err = append_tid(net_config->veth_cfg[i].local_veth, VETH_NAME_MAX_LEN);
-		if (!ASSERT_OK(err, "append TID to local veth name"))
-			return -1;
+	/* Create interfaces */
+	nstoken = open_netns(net_config->ns0_name);
+	if (!nstoken)
+		goto fail;
 
-		SYS(fail, "ip netns add %s", net_config->veth_cfg[i].namespace);
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
 		SYS(fail, "ip link add %s type veth peer name %s netns %s",
 		    net_config->veth_cfg[i].local_veth, net_config->veth_cfg[i].remote_veth,
 		    net_config->veth_cfg[i].namespace);
@@ -172,29 +187,21 @@ static int create_network(struct net_configuration *net_config)
 		    net_config->veth_cfg[i].remote_veth);
 	}
 
+	close_netns(nstoken);
 	return 0;
 
 fail:
+	close_netns(nstoken);
 	return -1;
 }
 
 static void cleanup_network(struct net_configuration *net_config)
 {
-	struct nstoken *nstoken;
 	int i;
 
-	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
-		bpf_xdp_detach(if_nametoindex(net_config->veth_cfg[i].local_veth), 0, NULL);
-		nstoken = open_netns(net_config->veth_cfg[i].namespace);
-		if (nstoken) {
-			bpf_xdp_detach(if_nametoindex(net_config->veth_cfg[i].remote_veth),
-				       0, NULL);
-			close_netns(nstoken);
-		}
-		/* in case the detach failed */
-		SYS_NOFAIL("ip link del %s", net_config->veth_cfg[i].local_veth);
+	SYS_NOFAIL("ip netns del %s", net_config->ns0_name);
+	for (i = 0; i < VETH_PAIRS_COUNT; i++)
 		SYS_NOFAIL("ip netns del %s", net_config->veth_cfg[i].namespace);
-	}
 }
 
 #define VETH_REDIRECT_SKEL_NB	3
@@ -223,6 +230,7 @@ static void xdp_veth_redirect(u32 flags)
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];
 	struct xdp_redirect_map *xdp_redirect_map;
 	struct net_configuration net_config;
+	struct nstoken *nstoken = NULL;
 	struct xdp_dummy *xdp_dummy;
 	struct xdp_tx *xdp_tx;
 	int map_fd;
@@ -251,6 +259,11 @@ static void xdp_veth_redirect(u32 flags)
 	bpf_objs[0] = xdp_dummy->obj;
 	bpf_objs[1] = xdp_tx->obj;
 	bpf_objs[2] = xdp_redirect_map->obj;
+
+	nstoken = open_netns(net_config.ns0_name);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto destroy_xdp_redirect_map;
+
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
 		int next_veth = net_config.veth_cfg[i].next_veth;
 		int interface_id;
@@ -274,6 +287,7 @@ static void xdp_veth_redirect(u32 flags)
 			     net_config.veth_cfg[0].namespace, IP_DST), "ping");
 
 destroy_xdp_redirect_map:
+	close_netns(nstoken);
 	xdp_redirect_map__destroy(xdp_redirect_map);
 destroy_xdp_tx:
 	xdp_tx__destroy(xdp_tx);

-- 
2.48.1


