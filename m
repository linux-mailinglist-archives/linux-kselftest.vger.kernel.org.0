Return-Path: <linux-kselftest+bounces-25474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1DA239FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3A51685B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13F1C07F5;
	Fri, 31 Jan 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jkCgmPTu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEC1B87FC;
	Fri, 31 Jan 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308120; cv=none; b=dapwhdDUurl0HJBLujvQEloMXll7ymo7heZPn0PeDqOh15JBaZvsHwVy2Oe3+yH3QoMVPG027zs0VFbpxuiblLYnWfzS26gDtPA8XwnvdptIp45OXasKphQ9+4vep2tDlLEfklhMlbNqikcQjswkySNiFSGO3PKn8uPDbHQ7t0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308120; c=relaxed/simple;
	bh=4ij4q5oCE/k8l7/JrJhQecJB7oJrRTQiA39ENFZd8x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESRKc4Z4AtrLXLJdzdXvFvtVn3N91C3ydKo0u+WpP5xa1QUTpSJ/DiEgXPBh+bxWLrSi8obU9h5KfTE18Eb78l+5KqWNRmf3zpU+wBxJfR5vI5ppTGI72ej9vR64XsWuTzXAlrX2FQkAUvgj0t7odUysEm4e4GcFeEWzwBbj6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jkCgmPTu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCE68442CD;
	Fri, 31 Jan 2025 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjRfgd4ePqZ43wByx09yu6Sy1Gt2cfedEe4nm5AIf1U=;
	b=jkCgmPTumSup98L6x9Qs4ZOln4mCxE3U3hW3oKTSoMndS5kNFQ9p5/FDh0BV0SbpDItPaV
	y3hDoZsvn3XXQRJ3DpY4sA3EK4ZGtHhPtbDyaMqF661VDxxJQzcMmR5TrSLZuk5e6lxMSU
	pXZYVkbeSDaGrfAvBvAM+bSQFjp7Sl9VdIM2ncybmPtp4Y+vQkfYyBjfglhSJurW7q79oY
	khEfZGDBuf8uRH2sSskjQGIRgEnWnBlQozCn/5+ne9LStUJ0aFi9R1GtYP1fYTsSRduI3j
	nWw9gT3l4dzEDyk5ziv0cB3KiiVihRrjPTlN9j7jTpu5UNIv6rPqwxm1iy40fQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:48 +0100
Subject: [PATCH bpf-next v4 09/14] selftests/bpf: test_xdp_veth: Use unique
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-9-970b33678512@bootlin.com>
References: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
In-Reply-To: <20250131-redirect-multi-v4-0-970b33678512@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

The network namespaces and the veth used by the tests have hardcoded
names that can conflict with other tests during parallel runs.

Use the append_tid() helper to ensure the uniqueness of these names.
Use the static network configuration table as a template on which
thread IDs are appended in each test.
Set a fixed size to remote_addr field so the struct veth_configuration
can also have a fixed size.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 51 ++++++++++++++--------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 59fa742b16bd46853b8cfd0ea56a497351c7fb2a..b869d466ada1d2aa00b72013990e4e34fb0315b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -35,40 +35,42 @@
 #include "xdp_tx.skel.h"
 
 #define VETH_PAIRS_COUNT	3
-#define VETH_NAME_MAX_LEN	16
+#define VETH_NAME_MAX_LEN	32
+#define IP_MAX_LEN		16
 #define IP_SRC				"10.1.1.11"
 #define IP_DST				"10.1.1.33"
 #define PROG_NAME_MAX_LEN	128
+#define NS_NAME_MAX_LEN		32
 
 struct veth_configuration {
 	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
 	char remote_veth[VETH_NAME_MAX_LEN]; /* Peer interface in dedicated namespace*/
-	const char *namespace; /* Namespace for the remote veth */
+	char namespace[NS_NAME_MAX_LEN]; /* Namespace for the remote veth */
 	int next_veth; /* Local interface to redirect traffic to */
-	char *remote_addr; /* IP address of the remote veth */
+	char remote_addr[IP_MAX_LEN]; /* IP address of the remote veth */
 };
 
-static struct veth_configuration net_config[VETH_PAIRS_COUNT] = {
+static const struct veth_configuration default_config[VETH_PAIRS_COUNT] = {
 	{
-		.local_veth = "veth1",
+		.local_veth = "veth1-",
 		.remote_veth = "veth11",
 		.next_veth = 1,
 		.remote_addr = IP_SRC,
-		.namespace = "ns-veth11"
+		.namespace = "ns-veth11-"
 	},
 	{
-		.local_veth = "veth2",
+		.local_veth = "veth2-",
 		.remote_veth = "veth22",
 		.next_veth = 2,
-		.remote_addr = NULL,
-		.namespace = "ns-veth22"
+		.remote_addr = "",
+		.namespace = "ns-veth22-"
 	},
 	{
-		.local_veth = "veth3",
+		.local_veth = "veth3-",
 		.remote_veth = "veth33",
 		.next_veth = 0,
 		.remote_addr = IP_DST,
-		.namespace = "ns-veth33"
+		.namespace = "ns-veth33-"
 	}
 };
 
@@ -80,6 +82,7 @@ struct prog_configuration {
 };
 
 static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
+					struct veth_configuration *net_config,
 					struct prog_configuration *prog, int index)
 {
 	struct bpf_program *local_prog, *remote_prog;
@@ -132,17 +135,27 @@ static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
 	return 0;
 }
 
-static int create_network(void)
+static int create_network(struct veth_configuration *net_config)
 {
-	int i;
+	int i, err;
+
+	memcpy(net_config, default_config, VETH_PAIRS_COUNT * sizeof(struct veth_configuration));
 
 	/* First create and configure all interfaces */
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		err = append_tid(net_config[i].namespace, NS_NAME_MAX_LEN);
+		if (!ASSERT_OK(err, "append TID to ns name"))
+			return -1;
+
+		err = append_tid(net_config[i].local_veth, VETH_NAME_MAX_LEN);
+		if (!ASSERT_OK(err, "append TID to local veth name"))
+			return -1;
+
 		SYS(fail, "ip netns add %s", net_config[i].namespace);
 		SYS(fail, "ip link add %s type veth peer name %s netns %s",
 		    net_config[i].local_veth, net_config[i].remote_veth, net_config[i].namespace);
 		SYS(fail, "ip link set dev %s up", net_config[i].local_veth);
-		if (net_config[i].remote_addr)
+		if (net_config[i].remote_addr[0])
 			SYS(fail, "ip -n %s addr add %s/24 dev %s",	net_config[i].namespace,
 			    net_config[i].remote_addr, net_config[i].remote_veth);
 		SYS(fail, "ip -n %s link set dev %s up", net_config[i].namespace,
@@ -155,7 +168,7 @@ static int create_network(void)
 	return -1;
 }
 
-static void cleanup_network(void)
+static void cleanup_network(struct veth_configuration *net_config)
 {
 	struct nstoken *nstoken;
 	int i;
@@ -196,6 +209,7 @@ void test_xdp_veth_redirect(void)
 			.remote_flags = 0,
 		}
 	};
+	struct veth_configuration net_config[VETH_PAIRS_COUNT];
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];
 	struct xdp_redirect_map *xdp_redirect_map;
 	struct xdp_dummy *xdp_dummy;
@@ -215,7 +229,7 @@ void test_xdp_veth_redirect(void)
 	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
 		goto destroy_xdp_tx;
 
-	if (!ASSERT_OK(create_network(), "create_network"))
+	if (!ASSERT_OK(create_network(net_config), "create network"))
 		goto destroy_xdp_redirect_map;
 
 	/* Then configure the redirect map and attach programs to interfaces */
@@ -237,7 +251,8 @@ void test_xdp_veth_redirect(void)
 		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
 		if (!ASSERT_OK(err, "configure interface redirection through map"))
 			goto destroy_xdp_redirect_map;
-		if (attach_programs_to_veth_pair(bpf_objs, VETH_REDIRECT_SKEL_NB, ping_config, i))
+		if (attach_programs_to_veth_pair(bpf_objs, VETH_REDIRECT_SKEL_NB,
+						 net_config, ping_config, i))
 			goto destroy_xdp_redirect_map;
 	}
 
@@ -254,5 +269,5 @@ void test_xdp_veth_redirect(void)
 destroy_xdp_dummy:
 	xdp_dummy__destroy(xdp_dummy);
 
-	cleanup_network();
+	cleanup_network(net_config);
 }

-- 
2.48.1


