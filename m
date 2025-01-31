Return-Path: <linux-kselftest+bounces-25472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8AA239F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD7B168585
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD01B87F8;
	Fri, 31 Jan 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oZOB2PJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF91AB51F;
	Fri, 31 Jan 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308118; cv=none; b=o7QZcZVQUJi0xUcMLmWkEAscflhIM8/pEoTsBzJM7cuut9pX288U4hwfDoskwhX896QUQztL5J1b4V3wVjoqPp+y6pyWiLqkmuF8za4jjz7WAcf/mm9AJk+dvBqZ4yxL7FMtEJ6EenScPn8swPzpR4ucs/son0BT3V7zFgcWNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308118; c=relaxed/simple;
	bh=rByWKYRv5lXiojBNpEoZKIzS9+wgm6yzWbucOqfkK5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAHHlL11bm7E5g9jzuEib/aoNXXxY4KcMxLjgFsACet0QVWc2pj8Mn+jypBEK+8bBRAmFy2RKOr10I3GGmXqDn9OxeJfbS2JF0qPbj4ONFIAkJROMj1mTThofgtb/V6iHbmLOIhILsVzJtgR9jkTzq0M9H7j/js3dRHtGQ5smX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oZOB2PJX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61B75442DD;
	Fri, 31 Jan 2025 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738308114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpUUYbb8uSTcTTJlq9HQ1Thh02vPvIt/1ZbBxUC0vdg=;
	b=oZOB2PJXEVzwU/5/m7fCq4OsCZr5ZBU3fiWbmlVIHSppIJbtOMCDlijUVHjJk1TDhU9xvi
	22Zqq7nP12VqwPmtDWSyL/FFQkXBEGikCrhA8HnheKWf+s9bXid08u/86efwBNpTCa/IvK
	ThbdEOuVZzUcj0zaZHWoxjkNztGQOwW7gLyWZoPz7Mi71SpnHEkdFVTi2QgYelsf/6OegX
	pzOVijevalp+3tOYJTC24i2uBARios4ZS8WF8sPuuSyb9WX3cYMg1DDWvOpEUoWE1uRPRw
	f6KzlzPT/GWPnMyhobwv3yVEbsxewJOfLOECXVZu5cjeE4wGAugmOjhM09uSRA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Jan 2025 08:21:46 +0100
Subject: [PATCH bpf-next v4 07/14] selftests/bpf: test_xdp_veth: Add
 prog_config[] table
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-redirect-multi-v4-7-970b33678512@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepfdeurghsthhivghnucevuhhruhhttghhvghtucdlvgeurffhucfhohhunhgurghtihhonhdmfdcuoegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegfeduhfeutddtieffteffleejffekveeviedutdegjeelfedtjeegtdejtddthfenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddugegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhog
 hhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

The BPF program attached to each veth is hardcoded through the
use of the struct skeletons. It prevents from re-using the initialization
code in new test cases.

Replace the struct skeletons by a bpf_object table.
Add a struct prog_configuration that holds the name of BPF program to
load on a given veth pair.
Use bpf_object__find_program_by_name() / bpf_xdp_attach() API instead of
bpf_program__attach_xdp() to retrieve the BPF programs from their names.
Detach BPF progs in the cleanup() as it's not automatically done by this
API.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 133 +++++++++++++--------
 1 file changed, 80 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index a214d5b479bea3008ebf71e0ba37bc50b9561f14..d1435490b96701a33236adc10dd1b120b95fda58 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -38,12 +38,7 @@
 #define VETH_NAME_MAX_LEN	16
 #define IP_SRC				"10.1.1.11"
 #define IP_DST				"10.1.1.33"
-
-struct skeletons {
-	struct xdp_dummy *xdp_dummy;
-	struct xdp_tx *xdp_tx;
-	struct xdp_redirect_map *xdp_redirect_maps;
-};
+#define PROG_NAME_MAX_LEN	128
 
 struct veth_configuration {
 	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
@@ -77,55 +72,59 @@ static struct veth_configuration net_config[VETH_PAIRS_COUNT] = {
 	}
 };
 
-static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
+struct prog_configuration {
+	char local_name[PROG_NAME_MAX_LEN]; /* BPF prog to attach to local_veth */
+	char remote_name[PROG_NAME_MAX_LEN]; /* BPF prog to attach to remote_veth */
+};
+
+static int attach_programs_to_veth_pair(struct bpf_object **objs, size_t nb_obj,
+					struct prog_configuration *prog, int index)
 {
 	struct bpf_program *local_prog, *remote_prog;
-	struct bpf_link **local_link, **remote_link;
 	struct nstoken *nstoken;
-	struct bpf_link *link;
-	int interface;
-
-	switch (index) {
-	case 0:
-		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_0;
-		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_0;
-		remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
-		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
-		break;
-	case 1:
-		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_1;
-		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_1;
-		remote_prog = skeletons->xdp_tx->progs.xdp_tx;
-		remote_link = &skeletons->xdp_tx->links.xdp_tx;
-		break;
-	case 2:
-		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_2;
-		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_2;
-		remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
-		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
-		break;
+	int interface, ret, i;
+
+	for (i = 0; i < nb_obj; i++) {
+		local_prog = bpf_object__find_program_by_name(objs[i], prog[index].local_name);
+		if (local_prog)
+			break;
 	}
+	if (!ASSERT_OK_PTR(local_prog, "find local program"))
+		return -1;
+
+	for (i = 0; i < nb_obj; i++) {
+		remote_prog = bpf_object__find_program_by_name(objs[i], prog[index].remote_name);
+		if (remote_prog)
+			break;
+	}
+	if (!ASSERT_OK_PTR(remote_prog, "find remote program"))
+		return -1;
+
 	interface = if_nametoindex(net_config[index].local_veth);
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
 		return -1;
-	link = bpf_program__attach_xdp(local_prog, interface);
-	if (!ASSERT_OK_PTR(link, "attach xdp program to local veth"))
+
+	ret = bpf_xdp_attach(interface, bpf_program__fd(local_prog), 0, NULL);
+	if (!ASSERT_OK(ret, "attach xdp program to local veth"))
 		return -1;
-	*local_link = link;
+
 	nstoken = open_netns(net_config[index].namespace);
 	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
 		return -1;
+
 	interface = if_nametoindex(net_config[index].remote_veth);
 	if (!ASSERT_NEQ(interface, 0, "non zero interface index")) {
 		close_netns(nstoken);
 		return -1;
 	}
-	link = bpf_program__attach_xdp(remote_prog, interface);
-	*remote_link = link;
-	close_netns(nstoken);
-	if (!ASSERT_OK_PTR(link, "attach xdp program to remote veth"))
+
+	ret = bpf_xdp_attach(interface, bpf_program__fd(remote_prog), 0, NULL);
+	if (!ASSERT_OK(ret, "attach xdp program to remote veth")) {
+		close_netns(nstoken);
 		return -1;
+	}
 
+	close_netns(nstoken);
 	return 0;
 }
 
@@ -150,45 +149,73 @@ static int create_network(void)
 
 fail:
 	return -1;
-
 }
 
 static void cleanup_network(void)
 {
+	struct nstoken *nstoken;
 	int i;
 
-	/* Deleting namespaces is enough to automatically remove veth pairs as well
-	 */
-	for (i = 0; i < VETH_PAIRS_COUNT; i++)
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		bpf_xdp_detach(if_nametoindex(net_config[i].local_veth), 0, NULL);
+		nstoken = open_netns(net_config[i].namespace);
+		if (nstoken) {
+			bpf_xdp_detach(if_nametoindex(net_config[i].remote_veth), 0, NULL);
+			close_netns(nstoken);
+		}
+		/* in case the detach failed */
+		SYS_NOFAIL("ip link del %s", net_config[i].local_veth);
 		SYS_NOFAIL("ip netns del %s", net_config[i].namespace);
+	}
 }
 
+#define VETH_REDIRECT_SKEL_NB	3
 void test_xdp_veth_redirect(void)
 {
-	struct skeletons skeletons = {};
+	struct prog_configuration ping_config[VETH_PAIRS_COUNT] = {
+		{
+			.local_name = "xdp_redirect_map_0",
+			.remote_name = "xdp_dummy_prog",
+		},
+		{
+			.local_name = "xdp_redirect_map_1",
+			.remote_name = "xdp_tx",
+		},
+		{
+			.local_name = "xdp_redirect_map_2",
+			.remote_name = "xdp_dummy_prog",
+		}
+	};
+	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];
+	struct xdp_redirect_map *xdp_redirect_map;
+	struct xdp_dummy *xdp_dummy;
+	struct xdp_tx *xdp_tx;
 	int map_fd;
 	int i;
 
-	skeletons.xdp_dummy = xdp_dummy__open_and_load();
-	if (!ASSERT_OK_PTR(skeletons.xdp_dummy, "xdp_dummy__open_and_load"))
+	xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_dummy, "xdp_dummy__open_and_load"))
 		return;
 
-	skeletons.xdp_tx = xdp_tx__open_and_load();
-	if (!ASSERT_OK_PTR(skeletons.xdp_tx, "xdp_tx__open_and_load"))
+	xdp_tx = xdp_tx__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_tx, "xdp_tx__open_and_load"))
 		goto destroy_xdp_dummy;
 
-	skeletons.xdp_redirect_maps = xdp_redirect_map__open_and_load();
-	if (!ASSERT_OK_PTR(skeletons.xdp_redirect_maps, "xdp_redirect_map__open_and_load"))
+	xdp_redirect_map = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
 		goto destroy_xdp_tx;
 
 	if (!ASSERT_OK(create_network(), "create_network"))
 		goto destroy_xdp_redirect_map;
 
 	/* Then configure the redirect map and attach programs to interfaces */
-	map_fd = bpf_map__fd(skeletons.xdp_redirect_maps->maps.tx_port);
+	map_fd = bpf_map__fd(xdp_redirect_map->maps.tx_port);
 	if (!ASSERT_OK_FD(map_fd, "open redirect map"))
 		goto destroy_xdp_redirect_map;
 
+	bpf_objs[0] = xdp_dummy->obj;
+	bpf_objs[1] = xdp_tx->obj;
+	bpf_objs[2] = xdp_redirect_map->obj;
 	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
 		int next_veth = net_config[i].next_veth;
 		int interface_id;
@@ -200,7 +227,7 @@ void test_xdp_veth_redirect(void)
 		err = bpf_map_update_elem(map_fd, &i, &interface_id, BPF_ANY);
 		if (!ASSERT_OK(err, "configure interface redirection through map"))
 			goto destroy_xdp_redirect_map;
-		if (attach_programs_to_veth_pair(&skeletons, i))
+		if (attach_programs_to_veth_pair(bpf_objs, VETH_REDIRECT_SKEL_NB, ping_config, i))
 			goto destroy_xdp_redirect_map;
 	}
 
@@ -211,11 +238,11 @@ void test_xdp_veth_redirect(void)
 			     net_config[0].namespace, IP_DST), "ping");
 
 destroy_xdp_redirect_map:
-	xdp_redirect_map__destroy(skeletons.xdp_redirect_maps);
+	xdp_redirect_map__destroy(xdp_redirect_map);
 destroy_xdp_tx:
-	xdp_tx__destroy(skeletons.xdp_tx);
+	xdp_tx__destroy(xdp_tx);
 destroy_xdp_dummy:
-	xdp_dummy__destroy(skeletons.xdp_dummy);
+	xdp_dummy__destroy(xdp_dummy);
 
 	cleanup_network();
 }

-- 
2.48.1


