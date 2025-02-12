Return-Path: <linux-kselftest+bounces-26459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C468AA32477
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 12:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D755D3A3393
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC920B7EE;
	Wed, 12 Feb 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GJJ9cbTm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40B20B217;
	Wed, 12 Feb 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358685; cv=none; b=ouPabzNH/kI/jcHYctftFyc3rC1rmO1xmGAjYn1sAgJJpAz8xfzuTCrsZncVQlwC44ppcA/I2FWYfAoBkmzt2Sd/HXkGu6rB2XcBjGwgaG3a2o7vqdGiXWdu1Afo86ANpzHMwivcnMiispuAVnujhQoNf5hklU1vB5/iaGVA8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358685; c=relaxed/simple;
	bh=5GJbDTW2AKq/Rde6fLe+hN36KTutyK4RW539lKpxZ1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X19RHfxcL7gO3vE/6GJCgGoJqcEys1jre4jzYAP3VrvvRN11s1jVqO2xCPct4orxjG0QrSPsz8IbP4VyaOW0IB+PV7zVeQ370Ur++JbSC8Nx8ZnN3+Q2y8GSM7g3f+bSeEGychPgYmyE5XO32BSVdrrQeFW7Agtb2dcZYpwezFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GJJ9cbTm; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 377FE442A3;
	Wed, 12 Feb 2025 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739358681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO3cQ4a7f4c8sCHtBCkj8ISEQ7uOKuWSBgEO5SY/DBY=;
	b=GJJ9cbTmB58PKMVteiY8kXttIgBNNQUK2Fgd6q/BjpJHHC9ebPo56whRDn/Wenm9guJNEK
	KUaObJiB+Y9/Ft/H45i7W6qg+XCsTfmqml0v/08wPiGnkpaNUqPH6XQgVPkiEEnUyYdkpx
	1Yg8eCZsuPARHAH73sb379gAQzk0oO/P19Ts8PqzqNHB821BkK17T2mCDCl4lXpU4xpjAw
	Pb4ry1TDNIbFzBQssjvh5wPnOl5uCgIVlTc5kE21Fg6iAbZuyrOEaFIBiFxzDEru2d/dDH
	rluN/oRwR8dzk8qu7kXSNyYS3/w0wafGBnq0Tyn3DdRjW1kuWLuNU0G5jvfQaw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 12:11:13 +0100
Subject: [PATCH bpf-next v5 5/6] selftests/bpf: test_xdp_veth: Add XDP
 program on egress test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-redirect-multi-v5-5-fd0d39fca6e6@bootlin.com>
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

XDP programs loaded on egress is tested by test_xdp_redirect_multi.sh
but not by the test_progs framework.

Add a test case in test_xdp_veth.c to test the XDP program on egress.
Use the same BPF program than test_xdp_redirect_multi.sh that replaces
the source MAC address by one provided through a BPF map.
Use a BPF program that stores the source MAC of received packets in a
map to check the test results.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 132 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/xdp_redirect_map.c |  40 +++++++
 2 files changed, 172 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 3ca308aac75413af6bcaf69ed8d50f74b5325206..3e98a16659362a48202318a81033fe895647ad9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -34,6 +34,8 @@
  *          -> echo request received by all except veth11
  *     - IPv4 ping : BPF_F_BROADCAST
  *          -> echo request received by all veth
+ * - [test_xdp_veth_egress]:
+ *     - all src mac should be the magic mac
  *
  *    veth11             veth22              veth33
  *  (XDP_PASS)         (XDP_PASS)          (XDP_PASS)
@@ -431,6 +433,124 @@ static void xdp_veth_broadcast_redirect(u32 attach_flags, u64 redirect_flags)
 	cleanup_network(&net_config);
 }
 
+#define VETH_EGRESS_SKEL_NB	3
+static void xdp_veth_egress(u32 flags)
+{
+	struct prog_configuration prog_cfg[VETH_PAIRS_COUNT] = {
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "xdp_dummy_prog",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "store_mac_1",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "store_mac_2",
+			.local_flags = flags,
+			.remote_flags = flags,
+		}
+	};
+	const char magic_mac[6] = { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};
+	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
+	struct bpf_object *bpf_objs[VETH_EGRESS_SKEL_NB];
+	struct xdp_redirect_map *xdp_redirect_map;
+	struct bpf_devmap_val devmap_val = {};
+	struct net_configuration net_config;
+	int mac_map, egress_map, res_map;
+	struct nstoken *nstoken = NULL;
+	struct xdp_dummy *xdp_dummy;
+	int err;
+	int i;
+
+	xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_dummy, "xdp_dummy__open_and_load"))
+		return;
+
+	xdp_redirect_multi_kern = xdp_redirect_multi_kern__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_kern__open_and_load"))
+		goto destroy_xdp_dummy;
+
+	xdp_redirect_map = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
+		goto destroy_xdp_redirect_multi_kern;
+
+	if (!ASSERT_OK(create_network(&net_config), "create network"))
+		goto destroy_xdp_redirect_map;
+
+	mac_map = bpf_map__fd(xdp_redirect_multi_kern->maps.mac_map);
+	if (!ASSERT_OK_FD(mac_map, "open mac_map"))
+		goto destroy_xdp_redirect_map;
+
+	egress_map = bpf_map__fd(xdp_redirect_multi_kern->maps.map_egress);
+	if (!ASSERT_OK_FD(egress_map, "open map_egress"))
+		goto destroy_xdp_redirect_map;
+
+	devmap_val.bpf_prog.fd = bpf_program__fd(xdp_redirect_multi_kern->progs.xdp_devmap_prog);
+
+	bpf_objs[0] = xdp_dummy->obj;
+	bpf_objs[1] = xdp_redirect_multi_kern->obj;
+	bpf_objs[2] = xdp_redirect_map->obj;
+
+	nstoken = open_netns(net_config.ns0_name);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		int ifindex = if_nametoindex(net_config.veth_cfg[i].local_veth);
+
+		SYS(destroy_xdp_redirect_map,
+		    "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
+		    net_config.veth_cfg[i].namespace, IP_NEIGH, net_config.veth_cfg[i].remote_veth);
+
+		if (attach_programs_to_veth_pair(bpf_objs, VETH_REDIRECT_SKEL_NB,
+						 &net_config, prog_cfg, i))
+			goto destroy_xdp_redirect_map;
+
+		err = bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
+
+		devmap_val.ifindex = ifindex;
+		err = bpf_map_update_elem(egress_map, &ifindex, &devmap_val, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
+	}
+
+	SYS_NOFAIL("ip netns exec %s ping %s -i 0.1 -c 4 -W1 > /dev/null ",
+		    net_config.veth_cfg[0].namespace, IP_NEIGH);
+
+	res_map = bpf_map__fd(xdp_redirect_map->maps.rx_mac);
+	if (!ASSERT_OK_FD(res_map, "open rx_map"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < 2; i++) {
+		u32 key = i;
+		u64 res;
+
+		err = bpf_map_lookup_elem(res_map, &key, &res);
+		if (!ASSERT_OK(err, "get MAC res"))
+			goto destroy_xdp_redirect_map;
+
+		ASSERT_STRNEQ((const char *)&res, magic_mac, ETH_ALEN, "compare mac");
+	}
+
+destroy_xdp_redirect_map:
+	close_netns(nstoken);
+	xdp_redirect_map__destroy(xdp_redirect_map);
+destroy_xdp_redirect_multi_kern:
+	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
+destroy_xdp_dummy:
+	xdp_dummy__destroy(xdp_dummy);
+
+	cleanup_network(&net_config);
+}
+
 void test_xdp_veth_redirect(void)
 {
 	if (test__start_subtest("0"))
@@ -465,3 +585,15 @@ void test_xdp_veth_broadcast_redirect(void)
 		xdp_veth_broadcast_redirect(XDP_FLAGS_SKB_MODE,
 					    BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
 }
+
+void test_xdp_veth_egress(void)
+{
+	if (test__start_subtest("0/egress"))
+		xdp_veth_egress(0);
+
+	if (test__start_subtest("DRV_MODE/egress"))
+		xdp_veth_egress(XDP_FLAGS_DRV_MODE);
+
+	if (test__start_subtest("SKB_MODE/egress"))
+		xdp_veth_egress(XDP_FLAGS_SKB_MODE);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
index 93f31480246118529a6b536775c9641c286e46d8..50c8958f94e58614c845dc6c60e02000a959faef 100644
--- a/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
+++ b/tools/testing/selftests/bpf/progs/xdp_redirect_map.c
@@ -76,4 +76,44 @@ int xdp_count_2(struct xdp_md *xdp)
 	return xdp_count(xdp, 2);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __be64);
+} rx_mac SEC(".maps");
+
+static int store_mac(struct xdp_md *xdp, __u32 id)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	struct ethhdr *eth = data;
+	__u32 key = id;
+	__be64 mac = 0;
+
+	if (data + sizeof(*eth) > data_end)
+		return XDP_DROP;
+
+	/* Only store IPv4 MAC to avoid being polluted by IPv6 packets */
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		__builtin_memcpy(&mac, eth->h_source, ETH_ALEN);
+		bpf_map_update_elem(&rx_mac, &key, &mac, 0);
+		bpf_printk("%s - %x", __func__, mac);
+	}
+
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int store_mac_1(struct xdp_md *xdp)
+{
+	return store_mac(xdp, 0);
+}
+
+SEC("xdp")
+int store_mac_2(struct xdp_md *xdp)
+{
+	return store_mac(xdp, 1);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.48.1


