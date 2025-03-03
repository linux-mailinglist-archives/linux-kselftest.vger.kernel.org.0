Return-Path: <linux-kselftest+bounces-28008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD0A4B911
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 09:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1831316F241
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB31EFF81;
	Mon,  3 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iJUMwfZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684271E98FF;
	Mon,  3 Mar 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990179; cv=none; b=CFSrPRr2eO8ZeBlE3GJuVXfOwY+YhVRGxg4TUTkeDfcDzCGq5CjkgFGGOF4PSg/JOXMpy0FZ/+Cc8KW1lz7Y601j6tsbI3Z99Tzj/DxgqkvxeXkaKfiOaMmZhPnDMWMhyI1wEOs/++j1DHlrIZN++cASfCAkU2kW38+Fw5HTRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990179; c=relaxed/simple;
	bh=2yOX0Mz6bPvi3V15KF/ErDQ07v1dxZdGbSO2xjEqnEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jN6tV9vNwdTcJn7CxQ0b9Ljcm31RUdNC63qIAq4bbk/I63mV+JRLTb3NlVpqOxaJ55pUVU/XRrPGVKxadH+QdmaeI9A9KH/fAVu8xn/VQJ5lUJPsyqHAOD7lp2Pv2qRVgVppcpVnQFvn6EK5WthY5pXZ0rTktyA1FpaQwgvH3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iJUMwfZh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B774D44351;
	Mon,  3 Mar 2025 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740990174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLt18rIxvJAQVL3sg4PjOQNh8lJIIXXMSEoe0rYvXfA=;
	b=iJUMwfZhaOw5BCRC1XTQEFu215rdJdVei4TEn0VcL054hK6YgMsCWFbgNJGXfLGZo9Trhg
	DFHau7SYdPT8YC3gAXXl/DoULUYJ6WRrcVxeh29d3VDgzpGTSlu8gjUl3HiN4UeJqKSpQf
	+8nX1BekVz40PrW60I1ymck1IdBntHUWN+FshtVo/btOXnLqe+KRrRivdc8wadNI627Nia
	RUfaX+S2M75M8Eba5eXwMgqzxTg1ZfKxlTzq5nANiGf8t3ejJA4p9lfpO6mmyxOzvX4VAT
	iK5QpN4DQqFyGJWjledbp9LF62ftIUqgcO78NrgO6wg/xdNU1dzAvPAl6k8r2g==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Mon, 03 Mar 2025 09:22:50 +0100
Subject: [PATCH bpf-next v2 02/10] selftests/bpf: test_tunnel: Add ping
 helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-tunnels-v2-2-8329f38f0678@bootlin.com>
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

All tests use more or less the same ping commands as final validation.
Also test_ping()'s return value is checked with ASSERT_OK() while this
check is already done by the SYS() macro inside test_ping().

Create helpers around test_ping() and use them in the tests to avoid code
duplication.
Remove the unnecessary ASSERT_OK() from the tests.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 53 ++++++++++------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index cc03a4440182cfff94f8421c3f5362aaf470086d..09e674c147bb31e239476b66eb5f57fc2b447cd9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -364,6 +364,25 @@ static int test_ping(int family, const char *addr)
 	return -1;
 }
 
+static void ping_dev0(void)
+{
+	/* ping from root namespace test */
+	test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
+}
+
+static void ping_dev1(void)
+{
+	struct nstoken *nstoken;
+
+	/* ping from at_ns0 namespace test */
+	nstoken = open_netns("at_ns0");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		return;
+
+	test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
+	close_netns(nstoken);
+}
+
 static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
@@ -492,9 +511,7 @@ static void test_vxlan_tunnel(void)
 		goto done;
 
 	/* ping test */
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ping_dev0();
 
 done:
 	/* delete vxlan tunnel */
@@ -549,9 +566,7 @@ static void test_ip6vxlan_tunnel(void)
 		goto done;
 
 	/* ping test */
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ping_dev0();
 
 done:
 	/* delete ipv6 vxlan tunnel */
@@ -565,7 +580,6 @@ static void test_ip6vxlan_tunnel(void)
 static void test_ipip_tunnel(enum ipip_encap encap)
 {
 	struct test_tunnel_kern *skel = NULL;
-	struct nstoken *nstoken;
 	int set_src_prog_fd, get_src_prog_fd;
 	int err;
 
@@ -602,19 +616,8 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 	if (generic_attach(IPIP_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
-	/* ping from root namespace test */
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
-
-	/* ping from at_ns0 namespace test */
-	nstoken = open_netns("at_ns0");
-	if (!ASSERT_OK_PTR(nstoken, "setns"))
-		goto done;
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
-	close_netns(nstoken);
+	ping_dev0();
+	ping_dev1();
 
 done:
 	/* delete ipip tunnel */
@@ -627,7 +630,6 @@ static void test_xfrm_tunnel(void)
 {
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct test_tunnel_kern *skel = NULL;
-	struct nstoken *nstoken;
 	int xdp_prog_fd;
 	int tc_prog_fd;
 	int ifindex;
@@ -658,14 +660,7 @@ static void test_xfrm_tunnel(void)
 	if (!ASSERT_OK(err, "bpf_xdp_attach"))
 		goto done;
 
-	/* ping from at_ns0 namespace test */
-	nstoken = open_netns("at_ns0");
-	if (!ASSERT_OK_PTR(nstoken, "setns"))
-		goto done;
-	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
-	close_netns(nstoken);
-	if (!ASSERT_OK(err, "test_ping"))
-		goto done;
+	ping_dev1();
 
 	if (!ASSERT_EQ(skel->bss->xfrm_reqid, 1, "req_id"))
 		goto done;

-- 
2.48.1


