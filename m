Return-Path: <linux-kselftest+bounces-28006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B83A4B90A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DD616D799
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248571EF096;
	Mon,  3 Mar 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rx2ydca+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA515A868;
	Mon,  3 Mar 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990178; cv=none; b=V8wi/9Od3q9Y5tVdVVwq6w2AQev4FP3vCEvx0Gvt41A2IovNVXg+sa9RjQjBcRM576/dXd2vfxNdYnxDVtO/+BuBlHWJPjocJmwy7ZBhevHhrxp2yoYtm41Xf7j5lo52DFRDme2ritDUu9+XX83ZuG0JixqmkGYfuZCKp+gPRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990178; c=relaxed/simple;
	bh=nmk4QgfUGcR5FpFsSenlW1rMZoO9PahipOHh+z34D/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRM9cJkXjlFA+X7Dibmpy7imPfXqCVUHx40cOjvXzP6PVKyqvW/FZb0z/+hDIPplEzOaVDC2W8iENDg9h4WqGtZM9blwUoJi7UjeqYKcX88VDX+9rfroI3CKzM62QrdeH+RkxGc18+SS2l8KEaDPcancymeDW1snA7AUB3i5oAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rx2ydca+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AB9D4435C;
	Mon,  3 Mar 2025 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIjFxsz9ZhDoEdo6JHTWR9bLwZgDcKJH7nfN265P1fk=;
	b=Rx2ydca+DgdZnvLrUd5xe2QzHpOJV2XG/xH32Mi6XLU9TULKirTGKrEDgb1pWMEnCaE8gQ
	TEcyXaew30IKzW3ckttsHSH/5qRX8vSzMSbvFEu+Sbpu0TZBB5sBUAdU2rR2MFTiOuCj8Z
	yuetX1B80+vdFUkV7meKBlv7XHp/pxq51SLJK8By1xcE4m5s/Ax/wR/IIhqpaNz9lmQab8
	+k7Aps1MTXGSLtP36AAz5LqmoQTf9NvfRGPOHtsth+HrTKigJcwUTR8markJ/+roKmr+S3
	YLcimONzPTBQPlURx4sBeXtycFirhzc2TA3eXC3kcSKr3Vyf/8+yNVk1L245mQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:49 +0100
Subject: [PATCH bpf-next v2 01/10] selftests/bpf: test_tunnel: Add
 generic_attach* helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-1-8329f38f0678@bootlin.com>
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
In-Reply-To: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmr
 ghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

A fair amount of code duplication is present among tests to attach BPF
programs.

Create generic_attach* helpers that attach BPF programs to a given
interface.
Use ASSERT_OK_FD() instead of ASSERT_GE() to check fd's validity.
Use these helpers in all the available tests.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
Changes in v2:
 - Move tc_hook definition to attach_tc_prog()
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 140 ++++++++++-----------
 1 file changed, 66 insertions(+), 74 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index cec746e77cd3abdf561cfc2422fa0a934fc481cd..cc03a4440182cfff94f8421c3f5362aaf470086d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -364,32 +364,34 @@ static int test_ping(int family, const char *addr)
 	return -1;
 }
 
-static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
+static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)
 {
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
+			    .attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS);
 	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
 			    .priority = 1, .prog_fd = igr_fd);
 	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts2, .handle = 1,
 			    .priority = 1, .prog_fd = egr_fd);
 	int ret;
 
-	ret = bpf_tc_hook_create(hook);
+	ret = bpf_tc_hook_create(&hook);
 	if (!ASSERT_OK(ret, "create tc hook"))
 		return ret;
 
 	if (igr_fd >= 0) {
-		hook->attach_point = BPF_TC_INGRESS;
-		ret = bpf_tc_attach(hook, &opts1);
+		hook.attach_point = BPF_TC_INGRESS;
+		ret = bpf_tc_attach(&hook, &opts1);
 		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
-			bpf_tc_hook_destroy(hook);
+			bpf_tc_hook_destroy(&hook);
 			return ret;
 		}
 	}
 
 	if (egr_fd >= 0) {
-		hook->attach_point = BPF_TC_EGRESS;
-		ret = bpf_tc_attach(hook, &opts2);
+		hook.attach_point = BPF_TC_EGRESS;
+		ret = bpf_tc_attach(&hook, &opts2);
 		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
-			bpf_tc_hook_destroy(hook);
+			bpf_tc_hook_destroy(&hook);
 			return ret;
 		}
 	}
@@ -397,6 +399,50 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
 	return 0;
 }
 
+static int generic_attach(const char *dev, int igr_fd, int egr_fd)
+{
+	int ifindex;
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
+	return attach_tc_prog(ifindex, igr_fd, egr_fd);
+}
+
+static int generic_attach_igr(const char *dev, int igr_fd)
+{
+	int ifindex;
+
+	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	return attach_tc_prog(ifindex, igr_fd, -1);
+}
+
+static int generic_attach_egr(const char *dev, int egr_fd)
+{
+	int ifindex;
+
+	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	return attach_tc_prog(ifindex, -1, egr_fd);
+}
+
 static void test_vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel = NULL;
@@ -404,11 +450,9 @@ static void test_vxlan_tunnel(void)
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
@@ -419,42 +463,22 @@ static void test_vxlan_tunnel(void)
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
 
@@ -488,11 +512,9 @@ static void test_ip6vxlan_tunnel(void)
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
@@ -503,31 +525,17 @@ static void test_ip6vxlan_tunnel(void)
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
 
@@ -559,10 +567,7 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	struct test_tunnel_kern *skel = NULL;
 	struct nstoken *nstoken;
 	int set_src_prog_fd, get_src_prog_fd;
-	int ifindex = -1;
 	int err;
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
-			    .attach_point = BPF_TC_INGRESS);
 
 	/* add ipip tunnel */
 	err = add_ipip_tunnel(encap);
@@ -573,10 +578,6 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	skel = test_tunnel_kern__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
 		goto done;
-	ifindex = if_nametoindex(IPIP_TUNL_DEV1);
-	if (!ASSERT_NEQ(ifindex, 0, "ipip11 ifindex"))
-		goto done;
-	tc_hook.ifindex = ifindex;
 
 	switch (encap) {
 	case FOU:
@@ -598,11 +599,7 @@ static void test_ipip_tunnel(enum ipip_encap encap)
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
@@ -628,8 +625,6 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 
 static void test_xfrm_tunnel(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
-			    .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct test_tunnel_kern *skel = NULL;
 	struct nstoken *nstoken;
@@ -646,19 +641,16 @@ static void test_xfrm_tunnel(void)
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


