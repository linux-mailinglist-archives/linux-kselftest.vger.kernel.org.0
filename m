Return-Path: <linux-kselftest+bounces-27739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0248A47EF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9A43A57C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1922FE13;
	Thu, 27 Feb 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a6kvnCrO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0222FAC3;
	Thu, 27 Feb 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662670; cv=none; b=OLY2lXGsOdfNYIcCQyPAP9CCmiYbX49A1SmqX+cZHrEN/LNA/vp99hVOSmIWsIFeEG5e8w19UhS8887O1bkJuV7qluLYVECaOxIHq8dFLdPO1LY8c5CoaCKs8BQpPLTT2slj5Ks+cBFT0zud4ARjC/FNBvPAd0N9RX4hYHNfX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662670; c=relaxed/simple;
	bh=6GuD87moaEfGFs+lXq34yHIMH1/B6cN5FqKJ+YBTRhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmu0JHn+GDBCAF4gnjpZ/e6KtF5+N8VgIs9f1m2iegiYJiPfM1PJQC4YEp0qNH1z3IwiPx5x7WpxsJh27WEU80OSNi3rSv2kQkW/5Mt4hQYOcXk2yd/KkOJzXbbkhsO3UCkdVOzHfPwXakYAxHZ1uEe54u3h1FkrIDFDvLEglcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a6kvnCrO; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60D6844250;
	Thu, 27 Feb 2025 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740662666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgLDuChRRjukyXGwtIVnWh8/gA7aOWJNV2QUihUMTaU=;
	b=a6kvnCrOOW31LV8T4PIf79zabg1OOECr68ZmnPsN+03c8QjfZ0XZfN0m3khrmF8E/lXjYR
	5hSqJ9DFRZASyslZFcBNcC1foHblIJnHKgggUTxKWxQZXzsJOcDoj1fet9jaQ/FZCegVPA
	aj7IivfoYMBlCa3I91HcehOvhdf5nOKt6en/AGuWUTkwFLJWuzdVIs31P8zpnjF44VkPsp
	OLAXS3Zs02ja3zpOcqL7sJ4rDathbg1aMmlz6EBTB639gypwDnzu9Fdow72XlNt041ZRPK
	gmN2Fpnq5lSdisQETloI2b2Zdn+FAMX+K/WvNNPSu3g+Lk1sfDmo3+wp3Y1hqQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 27 Feb 2025 14:24:16 +0100
Subject: [PATCH bpf-next 01/10] selftests/bpf: test_tunnel: Add
 generic_attach* helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-tunnels-v1-1-33df5c30aa04@bootlin.com>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
In-Reply-To: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkphhsihhnghhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhug
 idqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: bastien.curutchet@bootlin.com

A fair amount of code duplication is present among tests to attach BPF
programs.

Create generic_attach* helpers that attach BPF programs to a given
interface.
Use ASSERT_OK_FD() instead of ASSERT_GE() to check fd's validity.
Use these helpers in all the available tests.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 128 ++++++++++-----------
 1 file changed, 62 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index cec746e77cd3abdf561cfc2422fa0a934fc481cd..27a8c8caa87e4c6b39b2b26c2aa9860b131a70a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -397,6 +397,56 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
 	return 0;
 }
 
+static int generic_attach(const char *dev, int igr_fd, int egr_fd)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	int ifindex = -1;
+
+	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
+		return -1;
+	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	tc_hook.ifindex = ifindex;
+	return attach_tc_prog(&tc_hook, igr_fd, egr_fd);
+}
+
+static int generic_attach_igr(const char *dev, int igr_fd)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	int ifindex = -1;
+
+	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	tc_hook.ifindex = ifindex;
+	return attach_tc_prog(&tc_hook, igr_fd, -1);
+}
+
+static int generic_attach_egr(const char *dev, int egr_fd)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_EGRESS);
+	int ifindex = -1;
+
+	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	tc_hook.ifindex = ifindex;
+	return attach_tc_prog(&tc_hook, -1, egr_fd);
+}
+
 static void test_vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel = NULL;
@@ -404,11 +454,9 @@ static void test_vxlan_tunnel(void)
 	int local_ip_map_fd = -1;
 	int set_src_prog_fd, get_src_prog_fd;
 	int set_dst_prog_fd;
-	int key = 0, ifindex = -1;
+	int key = 0;
 	uint local_ip;
 	int err;
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
-			    .attach_point = BPF_TC_INGRESS);
 
 	/* add vxlan tunnel */
 	err = add_vxlan_tunnel();
@@ -419,42 +467,22 @@ static void test_vxlan_tunnel(void)
 	skel = test_tunnel_kern__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
 		goto done;
-	ifindex = if_nametoindex(VXLAN_TUNL_DEV1);
-	if (!ASSERT_NEQ(ifindex, 0, "vxlan11 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 	get_src_prog_fd = bpf_program__fd(skel->progs.vxlan_get_tunnel_src);
 	set_src_prog_fd = bpf_program__fd(skel->progs.vxlan_set_tunnel_src);
-	if (!ASSERT_GE(get_src_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (!ASSERT_GE(set_src_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, get_src_prog_fd, set_src_prog_fd))
+	if (generic_attach(VXLAN_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
 	/* load and attach bpf prog to veth dev tc hook point */
-	ifindex = if_nametoindex("veth1");
-	if (!ASSERT_NEQ(ifindex, 0, "veth1 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.veth_set_outer_dst);
-	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, set_dst_prog_fd, -1))
+	if (generic_attach_igr("veth1", set_dst_prog_fd))
 		goto done;
 
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
 	nstoken = open_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
-	ifindex = if_nametoindex(VXLAN_TUNL_DEV0);
-	if (!ASSERT_NEQ(ifindex, 0, "vxlan00 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.vxlan_set_tunnel_dst);
-	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
+	if (generic_attach_egr(VXLAN_TUNL_DEV0, set_dst_prog_fd))
 		goto done;
 	close_netns(nstoken);
 
@@ -488,11 +516,9 @@ static void test_ip6vxlan_tunnel(void)
 	int local_ip_map_fd = -1;
 	int set_src_prog_fd, get_src_prog_fd;
 	int set_dst_prog_fd;
-	int key = 0, ifindex = -1;
+	int key = 0;
 	uint local_ip;
 	int err;
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
-			    .attach_point = BPF_TC_INGRESS);
 
 	/* add vxlan tunnel */
 	err = add_ip6vxlan_tunnel();
@@ -503,31 +529,17 @@ static void test_ip6vxlan_tunnel(void)
 	skel = test_tunnel_kern__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
 		goto done;
-	ifindex = if_nametoindex(IP6VXLAN_TUNL_DEV1);
-	if (!ASSERT_NEQ(ifindex, 0, "ip6vxlan11 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 	get_src_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_get_tunnel_src);
 	set_src_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_set_tunnel_src);
-	if (!ASSERT_GE(set_src_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (!ASSERT_GE(get_src_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, get_src_prog_fd, set_src_prog_fd))
+	if (generic_attach(IP6VXLAN_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
 	nstoken = open_netns("at_ns0");
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
-	ifindex = if_nametoindex(IP6VXLAN_TUNL_DEV0);
-	if (!ASSERT_NEQ(ifindex, 0, "ip6vxlan00 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_set_tunnel_dst);
-	if (!ASSERT_GE(set_dst_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
+	if (generic_attach_egr(IP6VXLAN_TUNL_DEV0, set_dst_prog_fd))
 		goto done;
 	close_netns(nstoken);
 
@@ -559,10 +571,7 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	struct test_tunnel_kern *skel = NULL;
 	struct nstoken *nstoken;
 	int set_src_prog_fd, get_src_prog_fd;
-	int ifindex = -1;
 	int err;
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
-			    .attach_point = BPF_TC_INGRESS);
 
 	/* add ipip tunnel */
 	err = add_ipip_tunnel(encap);
@@ -573,10 +582,6 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	skel = test_tunnel_kern__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
 		goto done;
-	ifindex = if_nametoindex(IPIP_TUNL_DEV1);
-	if (!ASSERT_NEQ(ifindex, 0, "ipip11 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 
 	switch (encap) {
 	case FOU:
@@ -598,11 +603,7 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 			skel->progs.ipip_set_tunnel);
 	}
 
-	if (!ASSERT_GE(set_src_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (!ASSERT_GE(get_src_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, get_src_prog_fd, set_src_prog_fd))
+	if (generic_attach(IPIP_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
 	/* ping from root namespace test */
@@ -628,8 +629,6 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 
 static void test_xfrm_tunnel(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
-			    .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct test_tunnel_kern *skel = NULL;
 	struct nstoken *nstoken;
@@ -646,19 +645,16 @@ static void test_xfrm_tunnel(void)
 	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
 		goto done;
 
-	ifindex = if_nametoindex("veth1");
-	if (!ASSERT_NEQ(ifindex, 0, "veth1 ifindex"))
-		goto done;
 
 	/* attach tc prog to tunnel dev */
-	tc_hook.ifindex = ifindex;
 	tc_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state);
-	if (!ASSERT_GE(tc_prog_fd, 0, "bpf_program__fd"))
-		goto done;
-	if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
+	if (generic_attach_igr("veth1", tc_prog_fd))
 		goto done;
 
 	/* attach xdp prog to tunnel dev */
+	ifindex = if_nametoindex("veth1");
+	if (!ASSERT_NEQ(ifindex, 0, "veth1 ifindex"))
+		goto done;
 	xdp_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state_xdp);
 	if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
 		goto done;

-- 
2.48.1


