Return-Path: <linux-kselftest+bounces-26458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6033A3246B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45D9188C17B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1620C48A;
	Wed, 12 Feb 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gJeOXqaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CA20AF93;
	Wed, 12 Feb 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358684; cv=none; b=iiuasyfzY6iGJ3oUGBDBmdCUADVWx5bJtZU3kwIrCYdeb56rc/jHz+diyZ5Udhu49R8xrJY3f48GVSMfddSqTpQPMKKUtbvWsOXa7k/ZvqPD1aFrARw0ulFansE9R9SHJj7xZqOWFuiccDQ8dIJt3xei6sgWHOvP7t4ZgmBO4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358684; c=relaxed/simple;
	bh=x0g6JZog3DrfVOhv6nEI6pbMuTsP71TuJ2LkyW0+UvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thLN9DUg4BHx5PRG9Sg0Xbr6ZA1jca7K8oh0SQd9noNZsK0gH2g7L8Fv4JfFHzEXTWD+shtIkPBQAsEOHlWPLYMOc728rBhoyANhQhhvFQ+8sfXSsVFxUOPzHO0zcZ1GVUXvX5Po911BZqKcL7cf4cPwS1uKDVw1AYTfX7ow8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gJeOXqaj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED0D1442D3;
	Wed, 12 Feb 2025 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739358680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZRe0X7hads5tQmI8KglYH4rHkVh+smGEa/GQq/xNLc=;
	b=gJeOXqajAoeQbM7dYI1gX6Zo8YMl5vYwwyxThP+Wkldjk5fLnJ1B7SX8Y0nyDDDY4fETWM
	SVF4ijTJTfv5fb4kdLyxJpFd+Pa8wjBpt9qKS0D4h9bZIVyfBYNWqeUIAA1KZC2lNeS5Ot
	wVlpBRZ8Cd/NmgfiS5dnz16nI4vUS0RbV7rMskblKEolK44rjyGnm/bioFAO5/L1IvONQs
	mXS9+KZO8xcMPGY935UPl5wn2kptuFWBY2XB3uW8UHTj6ggEcmA49qbmEhOebvqIlgLbHa
	Cj23O+Cnr9qSo0XhdGoQhaaQwjft/s0T+TA9D0wVMYfuCfze/VVlYBcyFclc5Q==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 12:11:12 +0100
Subject: [PATCH bpf-next v5 4/6] selftests/bpf: test_xdp_veth: Add XDP
 broadcast redirection tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-redirect-multi-v5-4-fd0d39fca6e6@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdehgegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfs
 gdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhpshhinhhghheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

XDP redirections with BPF_F_BROADCAST and BPF_F_EXCLUDE_INGRESS flags
are tested by test_xdp_redirect_multi.sh but not within the test_progs
framework.

Add a broadcast test case in test_xdp_veth.c to test them.
Use the same BPF programs than the one used by
test_xdp_redirect_multi.sh.
Use a BPF map to select the broadcast flags.
Use a BPF map with an entry per veth to check whether packets are
received or not

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 157 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |  48 +++++++
 2 files changed, 205 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index a1c79af23bec25529af5b549d16b2cbfaf1cebd4..3ca308aac75413af6bcaf69ed8d50f74b5325206 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -28,6 +28,23 @@
  *      | |                | |                | |
  *      | ------------------ ------------------ |
  *      -----------------------------------------
+ *
+ * - [test_xdp_veth_broadcast_redirect]: broadcast from veth11
+ *     - IPv4 ping : BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS
+ *          -> echo request received by all except veth11
+ *     - IPv4 ping : BPF_F_BROADCAST
+ *          -> echo request received by all veth
+ *
+ *    veth11             veth22              veth33
+ *  (XDP_PASS)         (XDP_PASS)          (XDP_PASS)
+ *       |                  |                  |
+ *       |                  |                  |
+ *     veth1		  veth2              veth3
+ * (XDP_REDIRECT)     (XDP_REDIRECT)     (XDP_REDIRECT)
+ *      |                   ^                  ^
+ *      |                   |                  |
+ *      ----------------------------------------
+ *
  */
 
 #define _GNU_SOURCE
@@ -36,6 +53,7 @@
 #include "network_helpers.h"
 #include "xdp_dummy.skel.h"
 #include "xdp_redirect_map.skel.h"
+#include "xdp_redirect_multi_kern.skel.h"
 #include "xdp_tx.skel.h"
 #include <uapi/linux/if_link.h>
 
@@ -44,6 +62,7 @@
 #define IP_MAX_LEN		16
 #define IP_SRC				"10.1.1.11"
 #define IP_DST				"10.1.1.33"
+#define IP_NEIGH			"10.1.1.253"
 #define PROG_NAME_MAX_LEN	128
 #define NS_NAME_MAX_LEN		32
 
@@ -297,6 +316,121 @@ static void xdp_veth_redirect(u32 flags)
 	cleanup_network(&net_config);
 }
 
+#define BROADCAST_REDIRECT_SKEL_NB	2
+static void xdp_veth_broadcast_redirect(u32 attach_flags, u64 redirect_flags)
+{
+	struct prog_configuration prog_cfg[VETH_PAIRS_COUNT] = {
+		{
+			.local_name = "xdp_redirect_map_multi_prog",
+			.remote_name = "xdp_count_0",
+			.local_flags = attach_flags,
+			.remote_flags = attach_flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_multi_prog",
+			.remote_name = "xdp_count_1",
+			.local_flags = attach_flags,
+			.remote_flags = attach_flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_multi_prog",
+			.remote_name = "xdp_count_2",
+			.local_flags = attach_flags,
+			.remote_flags = attach_flags,
+		}
+	};
+	struct bpf_object *bpf_objs[BROADCAST_REDIRECT_SKEL_NB];
+	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
+	struct xdp_redirect_map *xdp_redirect_map;
+	struct bpf_devmap_val devmap_val = {};
+	struct net_configuration net_config;
+	struct nstoken *nstoken = NULL;
+	u16 protocol = ETH_P_IP;
+	int group_map;
+	int flags_map;
+	int cnt_map;
+	u64 cnt = 0;
+	int i, err;
+
+	xdp_redirect_multi_kern = xdp_redirect_multi_kern__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_kern__open_and_load"))
+		return;
+
+	xdp_redirect_map = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
+		goto destroy_xdp_redirect_multi_kern;
+
+	if (!ASSERT_OK(create_network(&net_config), "create network"))
+		goto destroy_xdp_redirect_map;
+
+	group_map = bpf_map__fd(xdp_redirect_multi_kern->maps.map_all);
+	if (!ASSERT_OK_FD(group_map, "open map_all"))
+		goto destroy_xdp_redirect_map;
+
+	flags_map = bpf_map__fd(xdp_redirect_multi_kern->maps.redirect_flags);
+	if (!ASSERT_OK_FD(group_map, "open map_all"))
+		goto destroy_xdp_redirect_map;
+
+	err = bpf_map_update_elem(flags_map, &protocol, &redirect_flags, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "init IP count"))
+		goto destroy_xdp_redirect_map;
+
+	cnt_map = bpf_map__fd(xdp_redirect_map->maps.rxcnt);
+	if (!ASSERT_OK_FD(cnt_map, "open rxcnt map"))
+		goto destroy_xdp_redirect_map;
+
+	bpf_objs[0] = xdp_redirect_multi_kern->obj;
+	bpf_objs[1] = xdp_redirect_map->obj;
+
+	nstoken = open_netns(net_config.ns0_name);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		int ifindex = if_nametoindex(net_config.veth_cfg[i].local_veth);
+
+		if (attach_programs_to_veth_pair(bpf_objs, BROADCAST_REDIRECT_SKEL_NB,
+						 &net_config, prog_cfg, i))
+			goto destroy_xdp_redirect_map;
+
+		SYS(destroy_xdp_redirect_map,
+		    "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
+		    net_config.veth_cfg[i].namespace, IP_NEIGH, net_config.veth_cfg[i].remote_veth);
+
+		devmap_val.ifindex = ifindex;
+		err = bpf_map_update_elem(group_map, &ifindex, &devmap_val, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
+
+	}
+
+	SYS_NOFAIL("ip netns exec %s ping %s -i 0.1 -c 4 -W1 > /dev/null ",
+		    net_config.veth_cfg[0].namespace, IP_NEIGH);
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		err =  bpf_map_lookup_elem(cnt_map, &i, &cnt);
+		if (!ASSERT_OK(err, "get IP cnt"))
+			goto destroy_xdp_redirect_map;
+
+		if (redirect_flags & BPF_F_EXCLUDE_INGRESS)
+			/* veth11 shouldn't receive the ICMP requests;
+			 * others should
+			 */
+			ASSERT_EQ(cnt, i ? 4 : 0, "compare IP cnt");
+		else
+			/* All remote veth should receive the ICMP requests */
+			ASSERT_EQ(cnt, 4, "compare IP cnt");
+	}
+
+destroy_xdp_redirect_map:
+	close_netns(nstoken);
+	xdp_redirect_map__destroy(xdp_redirect_map);
+destroy_xdp_redirect_multi_kern:
+	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
+
+	cleanup_network(&net_config);
+}
+
 void test_xdp_veth_redirect(void)
 {
 	if (test__start_subtest("0"))
@@ -308,3 +442,26 @@ void test_xdp_veth_redirect(void)
 	if (test__start_subtest("SKB_MODE"))
 		xdp_veth_redirect(XDP_FLAGS_SKB_MODE);
 }
+
+void test_xdp_veth_broadcast_redirect(void)
+{
+	if (test__start_subtest("0/BROADCAST"))
+		xdp_veth_broadcast_redirect(0, BPF_F_BROADCAST);
+
+	if (test__start_subtest("0/(BROADCAST | EXCLUDE_INGRESS)"))
+		xdp_veth_broadcast_redirect(0, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+
+	if (test__start_subtest("DRV_MODE/BROADCAST"))
+		xdp_veth_broadcast_redirect(XDP_FLAGS_DRV_MODE, BPF_F_BROADCAST);
+
+	if (test__start_subtest("DRV_MODE/(BROADCAST | EXCLUDE_INGRESS)"))
+		xdp_veth_broadcast_redirect(XDP_FLAGS_DRV_MODE,
+					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+
+	if (test__start_subtest("SKB_MODE/BROADCAST"))
+		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE, BPF_F_BROADCAST);
+
+	if (test__start_subtest("SKB_MODE/(BROADCAST | EXCLUDE_INGRESS)"))
+		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE,
+					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index 682dda8dabbc9abbb5d1b0b22dd5f81124142e79..93f31480246118529a6b536775c9641c286e46d8 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/if_ether.h>
+
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_DEVMAP);
@@ -28,4 +31,49 @@ int xdp_redirect_map_2(struct xdp_md *xdp)
 	return bpf_redirect_map(&tx_port, 2, 0);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} rxcnt SEC(".maps");
+
+static int xdp_count(struct xdp_md *xdp, __u32 key)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	struct ethhdr *eth = data;
+	__u64 *count;
+
+	if (data + sizeof(*eth) > data_end)
+		return XDP_DROP;
+
+	if (bpf_htons(eth->h_proto) == ETH_P_IP) {
+		/* We only count IPv4 packets */
+		count = bpf_map_lookup_elem(&rxcnt, &key);
+		if (count)
+			*count += 1;
+	}
+
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_count_0(struct xdp_md *xdp)
+{
+	return xdp_count(xdp, 0);
+}
+
+SEC("xdp")
+int xdp_count_1(struct xdp_md *xdp)
+{
+	return xdp_count(xdp, 1);
+}
+
+SEC("xdp")
+int xdp_count_2(struct xdp_md *xdp)
+{
+	return xdp_count(xdp, 2);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.48.1


